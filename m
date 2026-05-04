Return-Path: <stable+bounces-243593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHXwGRau+GlIxwIAu9opvQ
	(envelope-from <stable+bounces-243593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:32:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD964BFA65
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E635308FEB0
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB193D9DBB;
	Mon,  4 May 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AnvoiCtc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6D35A3AD;
	Mon,  4 May 2026 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904282; cv=none; b=eEy8AHrDuUojm+WOFMO0wZy6JqRE+dg4CikvOa6baHODUfCb9tAjA5JrbKYzl8cAFt0VnNN6U5Y94WinQ7rkFReR5FGkc/29Ks67/q0c0Y6SwEP6TDr9hQkTg1t6KBBaeWP0zlxTLVXaozheqIWRrgSGq1OrShwDUwYkbAtPhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904282; c=relaxed/simple;
	bh=ysV1WmbN7xyJQow60VAwaXhOecoApmj9M7KXl0vEgSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUzTxvqIlNXHeOIcqBaR5CEiC45LBLX/hmWohMLgSW0p0K/CwGGaYDJ4eabPm3kMOPY5HdXJdG++UZkJjSUHAR4wnNVSVL14gMTyIiAkm6g5NexhKiw2nQOP5DOMRRgSt6gAiB8SEO8hyOu8bIc6IT2BscVv0UgRyvvztDYUfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AnvoiCtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655E9C2BCB8;
	Mon,  4 May 2026 14:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904282;
	bh=ysV1WmbN7xyJQow60VAwaXhOecoApmj9M7KXl0vEgSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnvoiCtcpRWNJ2PlL2EhNUApsRm+dKjLnf31W+WuI8Krs7kQH7eHdjflyslUX5mOa
	 e3V1r6VdoCoUsKLHKBH/d6WRGHZa5RsE88XX5YjjoiIpgXra1FAwos5wE2l3vJQpRq
	 HR1OIGb6ugi/Bn7QUaVZmfwM/0+j9kkt8A8bM520=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 254/275] wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
Date: Mon,  4 May 2026 15:53:14 +0200
Message-ID: <20260504135152.475190094@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: CDD964BFA65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243593-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,nbd.name:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c |   40 +++++++++++++++++++-----
 1 file changed, 32 insertions(+), 8 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -206,6 +206,24 @@ static void mt792xu_epctl_rst_opt(struct
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
@@ -236,25 +254,31 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
 
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



