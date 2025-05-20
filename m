Return-Path: <stable+bounces-145199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4DABDA7F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A861B1BA55E1
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04D9242D7D;
	Tue, 20 May 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fzF2n8zA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD33DDA9;
	Tue, 20 May 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749455; cv=none; b=R/Y+NQc7Zz83AZAnPP9TDLFcwQ1dFiHdKOjssyoy+HDGp0URuHvUHmAkH3opxztobAf58t19pnC4zjdMtqy6+7PzG45sVjLA1+xWhxi8JXstfdMRLJb6K9GOqVhCxvY6Z8Z4IbCJFJLXLrdGDE53050ysTS6ESQhrLmJ8rz5ON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749455; c=relaxed/simple;
	bh=SmNO870M6Ey5f30PXkVBqpxZvqeWpNlyFAcr5F5QKrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhgWjZCI9eJ7nWGzQvPtf6rghlX9FO1uzOjqFveoDTy0r4ehwIkTUn9hLvYhy7rC2wCCCZ6jgyyUwvo8QEHzXKUWs0icE9JPkhbMp1pnmMXL9hb0FVJV1BVxejW+dCbkWuUr3NGZB9HYsdaQX2bL+BFytjdfKo3kBnioWaGpnEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fzF2n8zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C7FC4CEEA;
	Tue, 20 May 2025 13:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749455;
	bh=SmNO870M6Ey5f30PXkVBqpxZvqeWpNlyFAcr5F5QKrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fzF2n8zAfdWaKLnganC+/MxaV6a+0Ny3N8sckVbu1ex+nt6REWzN1/NqGgQHPg/EP
	 cXEGjE7jduoyjD8BO2F8rkWrFGH5n/in1zTK+EIy9zIalE3lPYS865LZsWOgjp5fRj
	 qX065eDhJzBYytysRRUdw4lDWFMApjhWVAydvRwQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 50/97] hv_netvsc: Use vmbus_sendpacket_mpb_desc() to send VMBus messages
Date: Tue, 20 May 2025 15:50:15 +0200
Message-ID: <20250520125802.615215921@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
References: <20250520125800.653047540@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1082,6 +1082,42 @@ static int netvsc_dma_map(struct hv_devi
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
@@ -1124,6 +1160,9 @@ static inline int netvsc_send_pkt(
 
 	packet->dma_range = NULL;
 	if (packet->page_buf_cnt) {
+		struct vmbus_channel_packet_page_buffer desc;
+		u32 desc_size;
+
 		if (packet->cp_partial)
 			pb += packet->rmsg_pgcnt;
 
@@ -1133,11 +1172,12 @@ static inline int netvsc_send_pkt(
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



