Return-Path: <stable+bounces-212420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KB3HPIyeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:01:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BE1A4F36
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0983A31B3074
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4682F745C;
	Wed, 28 Jan 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GOT55faZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A75288C22;
	Wed, 28 Jan 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615458; cv=none; b=c7AyU5FS40th78RuRAdwBAQV51mvfERVo97JFGl0iVLy/USNLbYkg5Dj27C1hCTM2ne8OH97Ax1Va+YGsP9slK824lJqhvPV/NWherKahJd61EOazX9DEzRjLz1NVPm5Pb6w+Xmmw3FAnvqLD/GnZqFK2hp7kcf18Vg3AaCbIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615458; c=relaxed/simple;
	bh=x8PDpgvEnJ6UyVoJR8cohV9QAhRm4v6oMqp7WkRpWo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5rxHmXsCM+WIjQKr14KB4wcwiz4jDJUvkM2igVnKDvyYOfcebvdcwShorc7VpUDCX9rvsdIJjcyHmorHUBU66G6uF5+7FMzb1sWryR8t7tK2x8JBv6fmAsYqxE3HJsmxFi3UTPinfUXe4N8aKb8w4eqzZrsirvfV73gaJwD5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GOT55faZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB710C4CEF1;
	Wed, 28 Jan 2026 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615458;
	bh=x8PDpgvEnJ6UyVoJR8cohV9QAhRm4v6oMqp7WkRpWo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOT55faZJT/fNyNJ1KwbDVeWWUy2QYV+3KlqoWdJN1TZ+XE7s1qcoYB78aEzctA7Z
	 LulNO1KMj0jvdEvQvepk0Iwfpb0J5xr/bouwDge+qIhRafdQYf5/Ol9TuWQMbrC8Le
	 gy+eNAanxmkMARahBGwrpGQ8jd/VfoSg27iYAZMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Wolf <wolf@yoxt.cc>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 016/227] ata: libata: Print features also for ATAPI devices
Date: Wed, 28 Jan 2026 16:21:01 +0100
Message-ID: <20260128145344.927746288@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212420-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[yoxt.cc:server fail];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[cassel.kernel.org:server fail,wolf.yoxt.cc:server fail,dlemoal.kernel.org:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 69BE1A4F36
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit c8c6fb886f57d5bf71fb6de6334a143608d35707 ]

Commit d633b8a702ab ("libata: print feature list on device scan")
added a print of the features supported by the device for ATA_DEV_ATA and
ATA_DEV_ZAC devices, but not for ATA_DEV_ATAPI devices.

Fix this by printing the features also for ATAPI devices.

Before changes:
ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133

After changes:
ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133
ata1.00: Features: Dev-Attention HIPM DIPM

Fixes: d633b8a702ab ("libata: print feature list on device scan")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Tested-by: Wolf <wolf@yoxt.cc>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c41714bea77e8..699919e4579e1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3119,6 +3119,9 @@ int ata_dev_configure(struct ata_device *dev)
 				     dma_dir_string);
 
 		ata_dev_config_lpm(dev);
+
+		if (print_info)
+			ata_dev_print_features(dev);
 	}
 
 	/* determine max_sectors */
-- 
2.51.0




