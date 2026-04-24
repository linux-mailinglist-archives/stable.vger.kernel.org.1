Return-Path: <stable+bounces-240630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMIYBthK62ntKgAAu9opvQ
	(envelope-from <stable+bounces-240630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 12:50:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854B45D649
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 12:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E5AF300FFB6
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923E344D90;
	Fri, 24 Apr 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6vI4gKl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C938A72C;
	Fri, 24 Apr 2026 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027762; cv=none; b=czYjxl8s6vfNEVZH1ANu2bQqX3Pt2csBgGQuLNQzrViWH1r6OZWS+dTiTocmU0LnZNPlfpiyPm766HT1m5C1ZVvBuQWPuR3Jhat5umIrfDPjET1nsoTw51eLnh/mOMFPNevAY6rAfNSITa6omTX2kGgbQPfTLjMx3ogKQmDIgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027762; c=relaxed/simple;
	bh=dgEnmis+w1/mHACY1d1/wSgNW49oVl9g0u3C4GaOJLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qfC6BYZCMEyQxjkY48JcUVqdaW/1y0qcQf5pxAnKOkPZG0R6iP7dACDdVZE6gHLwL9nRipuh7TOXHVaglsV0YcC3RukYgYbkMU3TdeZTqPsJblkFRKG2cjYEt1oWVEf5Xv1zn1/sfkMpNkneoH16oPsDSN+r3H6hMvnLUAFyldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6vI4gKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC531C19425;
	Fri, 24 Apr 2026 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027761;
	bh=dgEnmis+w1/mHACY1d1/wSgNW49oVl9g0u3C4GaOJLQ=;
	h=From:To:Cc:Subject:Date:From;
	b=s6vI4gKlkLDbmbMRQdVF2kz+MZepPzqZbB4jCTCs/Uy2JKRCY+Y9xbpQGCTk16axe
	 Xxt7nGzas2OZjWCMvvXzGcnBvvqE+AgH/V4udpkwpwSpnNv/rbThXc7ZlDU5xhD392
	 zvV9vha1G2vbhaDsgqMY/WaFIK95YewOxzbsQA+isqNLvTNcszV+SEAq7mWOAUg6j5
	 FVzF8Bs8kyw8WL4Zcx5IZ9Z8RTscI0I7CCQZyuBEIpQwc4vHjmWuXbqB2gPzjtwv+O
	 TFeUM8wtLme0uKbyY0CNzy4RWvCltED+3HhHiEXmyFP4KA5QJybqOQIlzNtIVuXdAw
	 +muYVTgJBxgww==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGE63-0000000AzPr-2iqs;
	Fri, 24 Apr 2026 12:49:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Martyn Welch <martyn@welchs.me.uk>
Subject: [PATCH] staging: vme_user: fix root device leak on init failure
Date: Fri, 24 Apr 2026 12:49:10 +0200
Message-ID: <20260424104910.2619349-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7854B45D649
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240630-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,welchs.me.uk:email]

Make sure to deregister and free the root device in case module
initialisation fails.

Fixes: 658bcdae9c67 ("vme: Adding Fake VME driver")
Cc: stable@vger.kernel.org	# 4.9
Cc: Martyn Welch <martyn@welchs.me.uk>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/vme_user/vme_fake.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index be4ad47ed526..8abaa3165fbb 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1230,6 +1230,8 @@ static int __init fake_init(void)
 err_driver:
 	kfree(fake_bridge);
 err_struct:
+	root_device_unregister(vme_root);
+
 	return retval;
 }
 
-- 
2.53.0


