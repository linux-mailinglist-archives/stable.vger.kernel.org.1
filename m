Return-Path: <stable+bounces-79241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5698D744
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA44DB23673
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D61D017E;
	Wed,  2 Oct 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EKVhLYMN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832B29CE7;
	Wed,  2 Oct 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876863; cv=none; b=K4b70E70sKxaw/gyfWwzXrAL3OO61CHW0a54+7F3K//V3LoTiufXnTOFm3CYMQsISWA9i0ICLmaq+iMTA1f4eYjVgA5YZsRjDzq/ogE216s/qpJZEs3Te6JfkB6uAs2A0J4DK7q0BT24cf3d791rjyU7ZHPjTqjNY+8kZHRGhg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876863; c=relaxed/simple;
	bh=unxIOkyD0jg/Ph5ThfyNq0b+toVIf62F8b6+i8IzQT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlAKzeIieB+1wm1AjnRu8b8ytQ+t1GAo5DUhHTeNKBXkU7bS9EmzKH9hkaVh/HRBj6nOpENvI7royUWJck8Ylsbgf2u5pBhaRbR2CQt2iiQHXJWa1kcyqH8j4wXQq9QkL52gCyvlBGmbPl7lnZZbmVz9qkiKlOxePyJNc7StiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EKVhLYMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7462C4CEC2;
	Wed,  2 Oct 2024 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876863;
	bh=unxIOkyD0jg/Ph5ThfyNq0b+toVIf62F8b6+i8IzQT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKVhLYMNfAN6Pe/zuV5ZT5JDpK4jCaJNbnpypqd9D1FeH5K0dVz2yzsBIzxXUsBtO
	 72Zg633dIsQu+cw/z482JtpLApjB52KNE1vDKKhW2wZmcX1I9XP4u9MTJMSdgfnuSc
	 a7d13tCC6in2JCVO/qslRAuCYMMvENoIkadJL7SI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pawel Laszczak <pawell@cadence.com>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.11 585/695] usb: xhci: fix loss of data on Cadence xHC
Date: Wed,  2 Oct 2024 14:59:43 +0200
Message-ID: <20241002125845.863852525@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawel Laszczak <pawell@cadence.com>

commit e5fa8db0be3e8757e8641600c518425a4589b85c upstream.

Streams should flush their TRB cache, re-read TRBs, and start executing
TRBs from the beginning of the new dequeue pointer after a 'Set TR Dequeue
Pointer' command.

Cadence controllers may fail to start from the beginning of the dequeue
TRB as it doesn't clear the Opaque 'RsvdO' field of the stream context
during 'Set TR Dequeue' command. This stream context area is where xHC
stores information about the last partially executed TD when a stream
is stopped. xHC uses this information to resume the transfer where it left
mid TD, when the stream is restarted.

Patch fixes this by clearing out all RsvdO fields before initializing new
Stream transfer using a 'Set TR Dequeue Pointer' command.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reviewed-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/PH7PR07MB95386A40146E3EC64086F409DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/host.c     |    4 +++-
 drivers/usb/host/xhci-pci.c  |    7 +++++++
 drivers/usb/host/xhci-ring.c |   14 ++++++++++++++
 drivers/usb/host/xhci.h      |    1 +
 4 files changed, 25 insertions(+), 1 deletion(-)

--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -62,7 +62,9 @@ static const struct xhci_plat_priv xhci_
 	.resume_quirk = xhci_cdns3_resume_quirk,
 };
 
-static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
+static const struct xhci_plat_priv xhci_plat_cdnsp_xhci = {
+	.quirks = XHCI_CDNS_SCTX_QUIRK,
+};
 
 static int __cdns_host_init(struct cdns *cdns)
 {
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -78,6 +78,9 @@
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
 
+#define PCI_DEVICE_ID_CADENCE				0x17CD
+#define PCI_DEVICE_ID_CADENCE_SSP			0x0200
+
 static const char hcd_name[] = "xhci_hcd";
 
 static struct hc_driver __read_mostly xhci_pci_hc_driver;
@@ -473,6 +476,10 @@ static void xhci_pci_quirks(struct devic
 			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
 	}
 
+	if (pdev->vendor == PCI_DEVICE_ID_CADENCE &&
+	    pdev->device == PCI_DEVICE_ID_CADENCE_SSP)
+		xhci->quirks |= XHCI_CDNS_SCTX_QUIRK;
+
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1399,6 +1399,20 @@ static void xhci_handle_cmd_set_deq(stru
 			struct xhci_stream_ctx *ctx =
 				&ep->stream_info->stream_ctx_array[stream_id];
 			deq = le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
+
+			/*
+			 * Cadence xHCI controllers store some endpoint state
+			 * information within Rsvd0 fields of Stream Endpoint
+			 * context. This field is not cleared during Set TR
+			 * Dequeue Pointer command which causes XDMA to skip
+			 * over transfer ring and leads to data loss on stream
+			 * pipe.
+			 * To fix this issue driver must clear Rsvd0 field.
+			 */
+			if (xhci->quirks & XHCI_CDNS_SCTX_QUIRK) {
+				ctx->reserved[0] = 0;
+				ctx->reserved[1] = 0;
+			}
 		} else {
 			deq = le64_to_cpu(ep_ctx->deq) & ~EP_CTX_CYCLE_MASK;
 		}
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1628,6 +1628,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
+#define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;



