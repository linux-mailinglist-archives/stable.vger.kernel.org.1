Return-Path: <stable+bounces-214020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKV9A9Vlg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-214020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:29:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F4E8B06
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6959A318287C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A94221F17;
	Wed,  4 Feb 2026 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f2QFVkJL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72D28853A;
	Wed,  4 Feb 2026 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218293; cv=none; b=h5iVV2MmIms/4wlgqnPqIRLt+L7o2u56CMVL78GzEf9DP0/a0OJP7Q/cB8YXv5hp/e9Dt35/PpGUmFzUwSKlS1eRti+us50/P/07Ac5Rk/lIvMzCo5HbfGBUEtsLcw2fTH8xn/ZJR+8Ho+C4daEroRtJk0YSOZ/9U64lBBEXMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218293; c=relaxed/simple;
	bh=xj3UgVhfs5P5wp6YFfk7tkG2otdHxzyWVXE6KHb/AXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWeCGORWzd5MVzkBS2tv0MTl5ubA76cHfyJ2awQcO+XJOTTPQy/IjIwo7+f6+zWEmfchZVoqGJdFmEo3jT1OAx7n3c6He5FnP85yCOgFGgc+NCe6Rsmu18EeUXrCGFCjuPTS8E2X+1ZFbfY2daACAbuO3yzVICEwSHg/jgMr6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f2QFVkJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450AEC4CEF7;
	Wed,  4 Feb 2026 15:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218292;
	bh=xj3UgVhfs5P5wp6YFfk7tkG2otdHxzyWVXE6KHb/AXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2QFVkJLOYzYmhcvfxE2+NiuXwfRPqU7tGgH6sKbUVRc9456ti+O++6srgmRk4BkF
	 HBTnS1+vnqft/qChWs2Q0bkgu42nhjAW0UfPpEJS773YWOgVqxisD6R4R1toH5tDYW
	 imoAGQUkVyCpSFJaCWIr9uQ8+Ft7bbXPN18fH9ac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.1 267/280] net: stmmac: make sure that ptp_rate is not 0 before configuring EST
Date: Wed,  4 Feb 2026 15:40:41 +0100
Message-ID: <20260204143919.307733721@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,bootlin.com,kernel.org,163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214020-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,bootlin.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F9F4E8B06
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexis Lothoré <alexis.lothore@bootlin.com>

[ Upstream commit cbefe2ffa7784525ec5d008ba87c7add19ec631a ]

If the ptp_rate recorded earlier in the driver happens to be 0, this
bogus value will propagate up to EST configuration, where it will
trigger a division by 0.

Prevent this division by 0 by adding the corresponding check and error
code.

Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Fixes: 8572aec3d0dc ("net: stmmac: Add basic EST support for XGMAC")
Link: https://patch.msgid.link/20250529-stmmac_tstamp_div-v4-2-d73340a794d5@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ The context change is due to the commit c3f3b97238f6
("net: stmmac: Refactor EST implementation")
and the proper adoption is done. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c        |    5 +++++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c |    5 +++++
 2 files changed, 10 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -597,6 +597,11 @@ int dwmac5_est_configure(void __iomem *i
 	int i, ret = 0x0;
 	u32 ctrl;
 
+	if (!ptp_rate) {
+		pr_warn("Dwmac5: Invalid PTP rate");
+		return -EINVAL;
+	}
+
 	ret |= dwmac5_est_write(ioaddr, BTR_LOW, cfg->btr[0], false);
 	ret |= dwmac5_est_write(ioaddr, BTR_HIGH, cfg->btr[1], false);
 	ret |= dwmac5_est_write(ioaddr, TER, cfg->ter, false);
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1497,6 +1497,11 @@ static int dwxgmac3_est_configure(void _
 	int i, ret = 0x0;
 	u32 ctrl;
 
+	if (!ptp_rate) {
+		pr_warn("Dwxgmac2: Invalid PTP rate");
+		return -EINVAL;
+	}
+
 	ret |= dwxgmac3_est_write(ioaddr, XGMAC_BTR_LOW, cfg->btr[0], false);
 	ret |= dwxgmac3_est_write(ioaddr, XGMAC_BTR_HIGH, cfg->btr[1], false);
 	ret |= dwxgmac3_est_write(ioaddr, XGMAC_TER, cfg->ter, false);



