Return-Path: <stable+bounces-226845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJMpIjeWuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:58:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF8B2B06A7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3991231C5E53
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3142F7478;
	Tue, 17 Mar 2026 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1llV+APL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105222D739D;
	Tue, 17 Mar 2026 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768445; cv=none; b=MuhXYys1KhzDRasJ5C666yQOxcAY5Ie78rNLGntsgt+cIGyw2e2gbQ8UzK3glv6OdohCi8r4iANcG+s1SEa5QW34FieR/2K2vWiFXGB6c+4Pfp7AVsp9Yr+Rox+BaH1z+EOCVCB4T3f+DVHYVjhHC0CUmNVeiHwO87s79/BHKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768445; c=relaxed/simple;
	bh=d/MJ3Eo+HuFV0v2G/ok7w04V7D+KOBLr4y8Flxkje1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r++G9VLai2mLLZpPZJqyUpqCB2+YrHUO6cZBWEFttuGBQE8FKNi7GDsE8v3POpDRMEx1N8DQmlJSm5jYxJNuRzzhLXhL0f8XvDBbVYPoG4LB1VbI5pwnoEKVk/lGfYZ7JvUZgqZvw0OIkH2G4Bv0l+g/gsquvJON966lFTwu1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1llV+APL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C0CC4CEF7;
	Tue, 17 Mar 2026 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768444;
	bh=d/MJ3Eo+HuFV0v2G/ok7w04V7D+KOBLr4y8Flxkje1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1llV+APLXoe1XJ6yVrqvkZphKHJif4vN8LaYUB14DxX0ifeTpSx2EZ4lY2w4cPE1m
	 ZFAifNVahYjZ2wU1kW8TrekLrJhN9yeimuX25nBhJqX5ZJf91R+so0krKj9L0iGFoG
	 1ffFJhTczKgG/PEBbfgPQ327t32FmWZ/jddqiGBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.18 309/333] i3c: mipi-i3c-hci: Factor out DMA mapping from queuing path
Date: Tue, 17 Mar 2026 17:35:38 +0100
Message-ID: <20260317163010.845903993@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-226845-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,bootlin.com:email,intel.com:email]
X-Rspamd-Queue-Id: EDF8B2B06A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit f3bcbfe1b8b0b836b772927f75f8cb6e759eb00a upstream.

Prepare for fixing a race in the DMA ring enqueue path when handling
parallel transfers.  Move all DMA mapping out of hci_dma_queue_xfer()
and into a new helper that performs the mapping up front.

This refactoring allows the upcoming fix to extend the spinlock coverage
around the enqueue operation without performing DMA mapping under the
spinlock.

No functional change is intended in this patch.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-4-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c |   49 ++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 16 deletions(-)

--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -375,6 +375,33 @@ static void hci_dma_unmap_xfer(struct i3
 	}
 }
 
+static struct i3c_dma *hci_dma_map_xfer(struct device *dev, struct hci_xfer *xfer)
+{
+	enum dma_data_direction dir = xfer->rnw ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	bool need_bounce = device_iommu_mapped(dev) && xfer->rnw && (xfer->data_len & 3);
+
+	return i3c_master_dma_map_single(dev, xfer->data, xfer->data_len, need_bounce, dir);
+}
+
+static int hci_dma_map_xfer_list(struct i3c_hci *hci, struct device *dev,
+				 struct hci_xfer *xfer_list, int n)
+{
+	for (int i = 0; i < n; i++) {
+		struct hci_xfer *xfer = xfer_list + i;
+
+		if (!xfer->data)
+			continue;
+
+		xfer->dma = hci_dma_map_xfer(dev, xfer);
+		if (!xfer->dma) {
+			hci_dma_unmap_xfer(hci, xfer_list, i);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 static int hci_dma_queue_xfer(struct i3c_hci *hci,
 			      struct hci_xfer *xfer_list, int n)
 {
@@ -382,6 +409,11 @@ static int hci_dma_queue_xfer(struct i3c
 	struct hci_rh_data *rh;
 	unsigned int i, ring, enqueue_ptr;
 	u32 op1_val, op2_val;
+	int ret;
+
+	ret = hci_dma_map_xfer_list(hci, rings->sysdev, xfer_list, n);
+	if (ret)
+		return ret;
 
 	/* For now we only use ring 0 */
 	ring = 0;
@@ -392,9 +424,6 @@ static int hci_dma_queue_xfer(struct i3c
 	for (i = 0; i < n; i++) {
 		struct hci_xfer *xfer = xfer_list + i;
 		u32 *ring_data = rh->xfer + rh->xfer_struct_sz * enqueue_ptr;
-		enum dma_data_direction dir = xfer->rnw ? DMA_FROM_DEVICE :
-							  DMA_TO_DEVICE;
-		bool need_bounce;
 
 		/* store cmd descriptor */
 		*ring_data++ = xfer->cmd_desc[0];
@@ -413,18 +442,6 @@ static int hci_dma_queue_xfer(struct i3c
 
 		/* 2nd and 3rd words of Data Buffer Descriptor Structure */
 		if (xfer->data) {
-			need_bounce = device_iommu_mapped(rings->sysdev) &&
-				      xfer->rnw &&
-				      xfer->data_len != ALIGN(xfer->data_len, 4);
-			xfer->dma = i3c_master_dma_map_single(rings->sysdev,
-							      xfer->data,
-							      xfer->data_len,
-							      need_bounce,
-							      dir);
-			if (!xfer->dma) {
-				hci_dma_unmap_xfer(hci, xfer_list, i);
-				return -ENOMEM;
-			}
 			*ring_data++ = lower_32_bits(xfer->dma->addr);
 			*ring_data++ = upper_32_bits(xfer->dma->addr);
 		} else {
@@ -447,7 +464,7 @@ static int hci_dma_queue_xfer(struct i3c
 		op2_val = rh_reg_read(RING_OPERATION2);
 		if (enqueue_ptr == FIELD_GET(RING_OP2_CR_DEQ_PTR, op2_val)) {
 			/* the ring is full */
-			hci_dma_unmap_xfer(hci, xfer_list, i + 1);
+			hci_dma_unmap_xfer(hci, xfer_list, n);
 			return -EBUSY;
 		}
 	}



