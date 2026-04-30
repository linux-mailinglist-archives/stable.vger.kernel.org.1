Return-Path: <stable+bounces-242175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFVcG3WQ82ky5AEAu9opvQ
	(envelope-from <stable+bounces-242175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:25:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6014A6578
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B81B9302002B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3461F4611FF;
	Thu, 30 Apr 2026 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQWflFsl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC864364045
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569808; cv=none; b=SQ+1M/Mi4vnukTlYwn3j3F7vuaS9JbM2g61kPTf7n/7GKLVlm25sxeBtN1hQxbTxU2q6XZJHxJAvvlXYY6qM54BO1NOfKilqGLQ65p2+tK8HiT8i2EEiJoeuiqgHJi8RkoVzFc30Eg3OV3Zi2YxgXNYAQtRGGHvl7/HAiDefNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569808; c=relaxed/simple;
	bh=a/jLziHOfORjHeFyqDHp6KaVlr6lwO2VEmYmxtpUzO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6sTo+jrXRV1JQ3X2kSN7BwJrf2g0iTLJczHHD+AzEBZJWyp1uS4O54GClEFlccDrFUW8+vhLkVsTxcYDELVFOJOknXxcxKrgb601RY8/Z/nG8oLNmuevhAQgVe95C9cNahpZszAusl4K/K6HUHOVEcGzZsM1wZbNahZigOhUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQWflFsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E68C2BCC6;
	Thu, 30 Apr 2026 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777569807;
	bh=a/jLziHOfORjHeFyqDHp6KaVlr6lwO2VEmYmxtpUzO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQWflFsl9qZQ3AhBp2EXqqYfbzgtqdwZzqX83iJcXPDHlqoX67YZnu8O1xq7NlK9b
	 +1JwOcGsVDrT28AY0nDkftR/kOQGdSysH+1XQ0OXP1Gzo7gf/Ac19MJNTSmycGCgGr
	 ff5feEKGRb4OwGND5nksPTc2qs0GQ7pn7jyegAT4r/PJ1Gc8j6Wg/q+UEXmPG93W2k
	 B/djJWkC5mkdvUr00onhyPQmG6ZckJtwxOOEQ5g5pW6a1ceLiNKOFGFRYOMQ4Ujrd9
	 2cSA0myJ7peRHVKEA6MjXSBHEkqyIarSdp0ZqW5oD6dPpmfvgggAesDG8FQWluJdFC
	 6asNoPHuGvp2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
Date: Thu, 30 Apr 2026 13:23:23 -0400
Message-ID: <20260430172324.1875442-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430172324.1875442-1-sashal@kernel.org>
References: <2026043042-octopus-sagging-4db9@gregkh>
 <20260430172324.1875442-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE6014A6578
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242175-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email,nbd.name:email,msgid.link:url]

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit e6f48512c1ceebcd1ce6bb83df3b3d56a261507d ]

Prepare mt792xu_wfsys_reset() for chips that share the same USB WFSYS
reset flow but use different register definitions.

This is a pure refactor of the current mt7921u path and keeps the reset
sequence unchanged.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/20260311002825.15502-1-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: 56154fef47d1 ("wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 40 +++++++++++++++----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 20e7f9c7c88c0..666be8ee6092d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -208,6 +208,24 @@ static void mt792xu_epctl_rst_opt(struct mt792x_dev *dev, bool reset)
 	mt792xu_uhw_wr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT, val);
 }
 
+struct mt792xu_wfsys_desc {
+	u32 rst_reg;
+	u32 done_reg;
+	u32 done_mask;
+	u32 done_val;
+	u32 delay_ms;
+	bool need_status_sel;
+};
+
+static const struct mt792xu_wfsys_desc mt7921_wfsys_desc = {
+	.rst_reg = MT_CBTOP_RGU_WF_SUBSYS_RST,
+	.done_reg = MT_UDMA_CONN_INFRA_STATUS,
+	.done_mask = MT_UDMA_CONN_WFSYS_INIT_DONE,
+	.done_val = MT_UDMA_CONN_WFSYS_INIT_DONE,
+	.delay_ms = 0,
+	.need_status_sel = true,
+};
+
 int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
 {
 	int err;
@@ -238,25 +256,31 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
 
 int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 {
+	const struct mt792xu_wfsys_desc *desc = &mt7921_wfsys_desc;
 	u32 val;
 	int i;
 
 	mt792xu_epctl_rst_opt(dev, false);
 
-	val = mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
+	val = mt792xu_uhw_rr(&dev->mt76, desc->rst_reg);
 	val |= MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
-	mt792xu_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
+	mt792xu_uhw_wr(&dev->mt76, desc->rst_reg, val);
 
-	usleep_range(10, 20);
+	if (desc->delay_ms)
+		msleep(desc->delay_ms);
+	else
+		usleep_range(10, 20);
 
-	val = mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
+	val = mt792xu_uhw_rr(&dev->mt76, desc->rst_reg);
 	val &= ~MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
-	mt792xu_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
+	mt792xu_uhw_wr(&dev->mt76, desc->rst_reg, val);
+
+	if (desc->need_status_sel)
+		mt792xu_uhw_wr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS_SEL, 0);
 
-	mt792xu_uhw_wr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS_SEL, 0);
 	for (i = 0; i < MT792x_WFSYS_INIT_RETRY_COUNT; i++) {
-		val = mt792xu_uhw_rr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS);
-		if (val & MT_UDMA_CONN_WFSYS_INIT_DONE)
+		val = mt792xu_uhw_rr(&dev->mt76, desc->done_reg);
+		if ((val & desc->done_mask) == desc->done_val)
 			break;
 
 		msleep(100);
-- 
2.53.0


