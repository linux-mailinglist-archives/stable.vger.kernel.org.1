Return-Path: <stable+bounces-145322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753D6ABDB58
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C2A16A6F1
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22BB246327;
	Tue, 20 May 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAasDafi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE25246769;
	Tue, 20 May 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749835; cv=none; b=A9weQ300YBbhK2N/eL2iLy44UrBOEhiOpeLXoabR9GsrFfm6de+dVDRLNKYXpetA446w9XDEfSpErh53cFwYurG1aXWFEPP6GHI4GZlD51CU66D4NghR3UWVfxCTzHs5uEXIRWEnvNlZc6WlJ+hp90T/E70F+E+oFtnVdmliYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749835; c=relaxed/simple;
	bh=MLNrMmd3GB53xMuKyzuqNIKYQZPG6mQWaUi0zX7T7sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrjWQIul+jzKWP3xELMolsryGgq5jNeycABl+2P/7uhJsCdKFwz3SYY2LENoNxlzlODVwVBG1iUQvoqtxlhmvS3dUqxxzrgI7ntXvG7gsp+PEqJZV2gYeTH9/7IjglNWTo2MrM4c1bM59owv1ftPKgVDMfw4o6vHf77+GwO/oU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OAasDafi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B50EC4CEE9;
	Tue, 20 May 2025 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749834;
	bh=MLNrMmd3GB53xMuKyzuqNIKYQZPG6mQWaUi0zX7T7sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAasDafirmvmMm5J80t2xXkatrvVla6v90wmKhVIYTgIC3yn/v+7pfmJlVVO6OqMl
	 5Yq2k+i6kqxQn68FOpA7aWrJth9CQO3E/Hx0XyGPxwsWMTVPX742H4bcG4E4SDw+WS
	 RyAoPJG+rG8lsQ4dQtjgoqhNse4w1Oli2NyPbMLA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 075/117] hv_netvsc: Use vmbus_sendpacket_mpb_desc() to send VMBus messages
Date: Tue, 20 May 2025 15:50:40 +0200
Message-ID: <20250520125806.965492413@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
References: <20250520125803.981048184@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mhklinux@outlook.com>

commit 4f98616b855cb0e3b5917918bb07b44728eb96ea upstream.

netvsc currently uses vmbus_sendpacket_pagebuffer() to send VMBus
messages. This function creates a series of GPA ranges, each of which
contains a single PFN. However, if the rndis header in the VMBus
message crosses a page boundary, the netvsc protocol with the host
requires that both PFNs for the rndis header must be in a single "GPA
range" data structure, which isn't possible with
vmbus_sendpacket_pagebuffer(). As the first step in fixing this, add a
new function netvsc_build_mpb_array() to build a VMBus message with
multiple GPA ranges, each of which may contain multiple PFNs. Use
vmbus_sendpacket_mpb_desc() to send this VMBus message to the host.

There's no functional change since higher levels of netvsc don't
maintain or propagate knowledge of contiguous PFNs. Based on its
input, netvsc_build_mpb_array() still produces a separate GPA range
for each PFN and the behavior is the same as with
vmbus_sendpacket_pagebuffer(). But the groundwork is laid for a
subsequent patch to provide the necessary grouping.

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Link: https://patch.msgid.link/20250513000604.1396-3-mhklinux@outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |   50 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1047,6 +1047,42 @@ static int netvsc_dma_map(struct hv_devi
 	return 0;
 }
 
+/* Build an "array" of mpb entries describing the data to be transferred
+ * over VMBus. After the desc header fields, each "array" entry is variable
+ * size, and each entry starts after the end of the previous entry. The
+ * "offset" and "len" fields for each entry imply the size of the entry.
+ *
+ * The pfns are in HV_HYP_PAGE_SIZE, because all communication with Hyper-V
+ * uses that granularity, even if the system page size of the guest is larger.
+ * Each entry in the input "pb" array must describe a contiguous range of
+ * guest physical memory so that the pfns are sequential if the range crosses
+ * a page boundary. The offset field must be < HV_HYP_PAGE_SIZE.
+ */
+static inline void netvsc_build_mpb_array(struct hv_page_buffer *pb,
+				u32 page_buffer_count,
+				struct vmbus_packet_mpb_array *desc,
+				u32 *desc_size)
+{
+	struct hv_mpb_array *mpb_entry = &desc->range;
+	int i, j;
+
+	for (i = 0; i < page_buffer_count; i++) {
+		u32 offset = pb[i].offset;
+		u32 len = pb[i].len;
+
+		mpb_entry->offset = offset;
+		mpb_entry->len = len;
+
+		for (j = 0; j < HVPFN_UP(offset + len); j++)
+			mpb_entry->pfn_array[j] = pb[i].pfn + j;
+
+		mpb_entry = (struct hv_mpb_array *)&mpb_entry->pfn_array[j];
+	}
+
+	desc->rangecount = page_buffer_count;
+	*desc_size = (char *)mpb_entry - (char *)desc;
+}
+
 static inline int netvsc_send_pkt(
 	struct hv_device *device,
 	struct hv_netvsc_packet *packet,
@@ -1089,6 +1125,9 @@ static inline int netvsc_send_pkt(
 
 	packet->dma_range = NULL;
 	if (packet->page_buf_cnt) {
+		struct vmbus_channel_packet_page_buffer desc;
+		u32 desc_size;
+
 		if (packet->cp_partial)
 			pb += packet->rmsg_pgcnt;
 
@@ -1098,11 +1137,12 @@ static inline int netvsc_send_pkt(
 			goto exit;
 		}
 
-		ret = vmbus_sendpacket_pagebuffer(out_channel,
-						  pb, packet->page_buf_cnt,
-						  &nvmsg, sizeof(nvmsg),
-						  req_id);
-
+		netvsc_build_mpb_array(pb, packet->page_buf_cnt,
+				(struct vmbus_packet_mpb_array *)&desc,
+				 &desc_size);
+		ret = vmbus_sendpacket_mpb_desc(out_channel,
+				(struct vmbus_packet_mpb_array *)&desc,
+				desc_size, &nvmsg, sizeof(nvmsg), req_id);
 		if (ret)
 			netvsc_dma_unmap(ndev_ctx->device_ctx, packet);
 	} else {



