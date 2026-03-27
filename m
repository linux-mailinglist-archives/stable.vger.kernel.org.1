Return-Path: <stable+bounces-230632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDiQApNixmm+JAUAu9opvQ
	(envelope-from <stable+bounces-230632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:57:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AFF342F4E
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 662A4312AB5F
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34103E3C60;
	Fri, 27 Mar 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSoU9hMt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0233F385;
	Fri, 27 Mar 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608740; cv=none; b=gQ88tW1i/LRCnwi49CIsG1HuQd5+JndJZX3fTqX87pPp5JHujq1+OAgL+D3FC3BMdsUOsq1DiDInxYWRqPLNcTdGPakJCVQiFntb2EUnbl6z4Qz8vYB2Htd2dIV32kvns5WOdCztHHMuZkUYkeRve7mEPR7YuYutQWc87Bbe9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608740; c=relaxed/simple;
	bh=PIjhqXV96eZdpEdqYKATLZ86ccJJiq7XCV261VUyjdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFNG8v281TZSwtP07ScUvqIXyQMNtf7VuPd4aF1fzFkPs83NSmLJ0JWm+hVZELLDm8VBmsnvE4Lds4Q3uih/59qM8i/1sTkssNi4jahM5re0XQgaxvhYiIY9G/BCBdGJSRvkFTLNxiOSXww1pymnCNkxOsdvar2dYrow4lf+rlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSoU9hMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE41C2BC86;
	Fri, 27 Mar 2026 10:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608740;
	bh=PIjhqXV96eZdpEdqYKATLZ86ccJJiq7XCV261VUyjdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSoU9hMtl1mpvyS+eR6AvXOwZ/ntnp6B3E7TT74fiScs0MJHSKFQC8EmBkr6pWYDZ
	 dHnED8ne9UwQeZVPu7TyMbzhkrHT20UxQBaTyY61YHE2DBSHOQzs7BlbeHr4LRXcbD
	 codAwSjme9EYZ5DYnVUBGTO4rf3rul3Nzfnz0ilr8++pr6JiicfRk37eiyim+I7m+d
	 XfG8FftrC8brcEoLelHr1jsJTwwc/BsQY72T15AYkA5awIFzS8SZS36/Z2V+WCzxjg
	 k0oBRzmytmBC2kt/bIk+lkc/yqwLwWSDpU6VYL21Bf4h6JDVxfmkXu+Qn598qTEwlJ
	 5N9NB013H/gXQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w64na-00000005UzU-14MI;
	Fri, 27 Mar 2026 11:52:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Tony Olech <tony.olech@elandigitalsystems.com>
Subject: [PATCH 1/4] mmc: vub300: fix NULL-deref on disconnect
Date: Fri, 27 Mar 2026 11:52:05 +0100
Message-ID: <20260327105208.1310739-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327105208.1310739-1-johan@kernel.org>
References: <20260327105208.1310739-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230632-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85AFF342F4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before dropping the reference to
the driver data on disconnect to avoid NULL-pointer dereferences or
use-after-free.

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Cc: stable@vger.kernel.org	# 3.0
Cc: Tony Olech <tony.olech@elandigitalsystems.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mmc/host/vub300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index ff49d0770506..f173c7cf4e1a 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2365,8 +2365,8 @@ static void vub300_disconnect(struct usb_interface *interface)
 			usb_set_intfdata(interface, NULL);
 			/* prevent more I/O from starting */
 			vub300->interface = NULL;
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_remove_host(mmc);
+			kref_put(&vub300->kref, vub300_delete);
 			pr_info("USB vub300 remote SDIO host controller[%d]"
 				" now disconnected", ifnum);
 			return;
-- 
2.52.0


