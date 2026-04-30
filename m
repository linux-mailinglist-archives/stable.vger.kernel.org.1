Return-Path: <stable+bounces-242121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNZ2DY1e82lT1wEAu9opvQ
	(envelope-from <stable+bounces-242121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:52:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9654A3B18
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BC913011F1F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70DF421F0E;
	Thu, 30 Apr 2026 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="drM6kmtW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F140759E
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557119; cv=none; b=tWhVsVHvVk5uid98Ep07rwA79Vf8qxRrCgRA5bKa1s7tI3+HAtokJA3mTsyt8finCsIXlb3xp8cMJ3bDgfaPfVhZTJaweAhqEtmhdqnu+bkZzrrBmI2QPPA4dKM8ULerIiw9Zj3I+yfsS0pD5H9o+iDRaOoaYicYrUj9JPWFEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557119; c=relaxed/simple;
	bh=vFlu8tUetbRJDtB8/jQBCtrMV4slSzOxbitYRVvXwsA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rdByxlAfOTxwqZx0nb7hv315+i7iaAXAeUePhK8DWMGl3YCuZV40zMwRsR3IZJ/j+Smx4Ew81oJUbNGtjoNRafoSHZRSwmDQ3HBZqepvAmfV9rE6GQygVEReJ38TdN0hS3QfE4b4kokBaf7KRqZ2TIx0/Js7dpBSqFmuwbvOEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=drM6kmtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A5CC2BCB3;
	Thu, 30 Apr 2026 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777557119;
	bh=vFlu8tUetbRJDtB8/jQBCtrMV4slSzOxbitYRVvXwsA=;
	h=Subject:To:Cc:From:Date:From;
	b=drM6kmtW8QcIOt3ZnwKlsZLBbQ+X58Pd72GsnZfuTiE/i2+pt9gfAGnHNgKnwoi2H
	 nSngv3M7P2R61DJHDwA6cf/kPKwKDHUUHDLbIhQ3pu1RxmBtNXDAnRevx5bngb85co
	 a8qI0YMIGsKvhn8otWJOeD9eJT6cHxa2aAtuJgbQ=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling" failed to apply to 6.6-stable tree
To: sean.wang@mediatek.com,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Apr 2026 15:51:42 +0200
Message-ID: <2026043042-octopus-sagging-4db9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB9654A3B18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242121-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,nbd.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,mediatek.com:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 56154fef47d104effa9f29ed3db4f805cbc0d640
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026043042-octopus-sagging-4db9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56154fef47d104effa9f29ed3db4f805cbc0d640 Mon Sep 17 00:00:00 2001
From: Sean Wang <sean.wang@mediatek.com>
Date: Tue, 10 Mar 2026 19:28:25 -0500
Subject: [PATCH] wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling

mt7925u uses different reset/status registers from mt7921u. Reusing the
mt7921u register set causes the WFSYS reset to fail.

Add a chip-specific descriptor in mt792xu_wfsys_reset() to select the
correct registers and fix mt7925u failing to initialize after a warm
reboot.

Fixes: d28e1a48952e ("wifi: mt76: mt792x: introduce mt792x-usb module")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/20260311002825.15502-2-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 7ddde9286861..d2a8b2b0df32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -392,6 +392,10 @@
 #define MT_CBTOP_RGU_WF_SUBSYS_RST	MT_CBTOP_RGU(0x600)
 #define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
 
+#define MT7925_CBTOP_RGU_WF_SUBSYS_RST	0x70028600
+#define MT7925_WFSYS_INIT_DONE_ADDR	0x184c1604
+#define MT7925_WFSYS_INIT_DONE		0x00001d1e
+
 #define MT_HW_BOUND			0x70010020
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index a92e872226cf..47827d1c5ccb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -224,6 +224,15 @@ static const struct mt792xu_wfsys_desc mt7921_wfsys_desc = {
 	.need_status_sel = true,
 };
 
+static const struct mt792xu_wfsys_desc mt7925_wfsys_desc = {
+	.rst_reg = MT7925_CBTOP_RGU_WF_SUBSYS_RST,
+	.done_reg = MT7925_WFSYS_INIT_DONE_ADDR,
+	.done_mask = U32_MAX,
+	.done_val = MT7925_WFSYS_INIT_DONE,
+	.delay_ms = 20,
+	.need_status_sel = false,
+};
+
 int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
 {
 	int err;
@@ -254,7 +263,9 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
 
 int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 {
-	const struct mt792xu_wfsys_desc *desc = &mt7921_wfsys_desc;
+	const struct mt792xu_wfsys_desc *desc = is_mt7925(&dev->mt76) ?
+						&mt7925_wfsys_desc :
+						&mt7921_wfsys_desc;
 	u32 val;
 	int i;
 


