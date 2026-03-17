Return-Path: <stable+bounces-226042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJLkAfNouWmZDwIAu9opvQ
	(envelope-from <stable+bounces-226042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:45:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A683D2AC39C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DACF5302D187
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3613E3D94;
	Tue, 17 Mar 2026 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mb3zwL6H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215D3E3C6E
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758702; cv=none; b=UTXe5NNYhcVDJMsdzTYJic4lj5MwHhbLh6L16cqt9CfJN9VhxipFJ+zrdq5EGakaSUZuAfTXoZxYfqMUlCw3/ZcKRpqUdjUgWE4LC7Qh7IFAyG7o04PwWj7Yt+4iwiq28egyhgBt7C8rPaaOqO97vVbm5iiP3YAoXZJ7cei2/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758702; c=relaxed/simple;
	bh=svSQnHGCqFQEcao/wHa0p20MZDxxQuMHGuC4SP3ztM4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N70ptCysMkOiaHHu81uQKZND8d+PawfLyXOcBPvohaym8/GUzObCI/Tso5yIlruE0zk6edOPDXk8zIWMT+d052eMUIzuUVdzHo+Gyl4vPpC3v+iQWgJOTvxe1JjuVp+i6kZLV3MrUBQtOZS85hAbszbdsmd/n/Ax46nVUK9qpks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mb3zwL6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6656DC4CEF7;
	Tue, 17 Mar 2026 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773758701;
	bh=svSQnHGCqFQEcao/wHa0p20MZDxxQuMHGuC4SP3ztM4=;
	h=Subject:To:Cc:From:Date:From;
	b=Mb3zwL6HfUp1gnIiK5RAfgCmH/xbltkGfsJPsfQGBa0/Cf5Ia8PGYPBh0zMrEYTWp
	 EJCPO7X2hsi8QWWITpEEYdNY+GyAUKXTkh8opShUc+yD8jp9Y7xBAVtblqzy+sl1w4
	 BJZneDE7V27mL180aWLLFoLpz14UfBoTYCsHKJfk=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Factor out DMA mapping from queuing path" failed to apply to 5.15-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:44:47 +0100
Message-ID: <2026031747-negligent-affair-b476@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226042-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,intel.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A683D2AC39C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f3bcbfe1b8b0b836b772927f75f8cb6e759eb00a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031747-negligent-affair-b476@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f3bcbfe1b8b0b836b772927f75f8cb6e759eb00a Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:40 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Factor out DMA mapping from queuing path

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

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index b903a2da1fd1..ba451f026386 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -439,6 +439,33 @@ static void hci_dma_unmap_xfer(struct i3c_hci *hci,
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
@@ -446,6 +473,11 @@ static int hci_dma_queue_xfer(struct i3c_hci *hci,
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
@@ -456,9 +488,6 @@ static int hci_dma_queue_xfer(struct i3c_hci *hci,
 	for (i = 0; i < n; i++) {
 		struct hci_xfer *xfer = xfer_list + i;
 		u32 *ring_data = rh->xfer + rh->xfer_struct_sz * enqueue_ptr;
-		enum dma_data_direction dir = xfer->rnw ? DMA_FROM_DEVICE :
-							  DMA_TO_DEVICE;
-		bool need_bounce;
 
 		/* store cmd descriptor */
 		*ring_data++ = xfer->cmd_desc[0];
@@ -477,18 +506,6 @@ static int hci_dma_queue_xfer(struct i3c_hci *hci,
 
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
@@ -511,7 +528,7 @@ static int hci_dma_queue_xfer(struct i3c_hci *hci,
 		op2_val = rh_reg_read(RING_OPERATION2);
 		if (enqueue_ptr == FIELD_GET(RING_OP2_CR_DEQ_PTR, op2_val)) {
 			/* the ring is full */
-			hci_dma_unmap_xfer(hci, xfer_list, i + 1);
+			hci_dma_unmap_xfer(hci, xfer_list, n);
 			return -EBUSY;
 		}
 	}


