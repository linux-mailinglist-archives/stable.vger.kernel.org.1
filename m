Return-Path: <stable+bounces-145327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7590ABDB62
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2175A171D31
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABBB245038;
	Tue, 20 May 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LRE2ngSu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A991B0F17;
	Tue, 20 May 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749852; cv=none; b=jQe5/Z7b0kIhUF+QoPH28gIG4dyjoRNucDd0K4B93fXsOwcDXv9pbQgO6W4qnWabI9Zvah2+d1ipk0O4f6RffKN8ATyJOu3aZpA52UtAn0nl1B6Qk9MkSv+irNDK2hN04Frn6I9qIpsdxh9zgh2qYOzsHsa/SdFNdq4cfvgkKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749852; c=relaxed/simple;
	bh=V1FwQnySqthfyw5eTQEjCSYk/8aHR+0eQmZDzhtcj18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYVHn1hMQ0/FSPc9XYXAljQZljKkB/TogCxua03nAXuSoJZ5kpf4O7vy3qamL5SPhmrNaaxxvVJdpAe5n9r41R5L4hZz7RRIzuLJv79wepOU1vcVAEn0Lh4s0UD4mu3/oS7PST6F2ZLoG1UdD0pUAF/2nnq5SEEzj0l+3ds/1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LRE2ngSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0661CC4CEE9;
	Tue, 20 May 2025 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749851;
	bh=V1FwQnySqthfyw5eTQEjCSYk/8aHR+0eQmZDzhtcj18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRE2ngSuPHqhv/2j/UpHbI76Ol6ZpmPSYLqozJly8pTwpM4xJ9389PSilOKOav867
	 /XEQhUFW6oHsXUikeUN0dYuYBs+yWU4DzRRJxSeu4ngYt0mNOxUPe/Ph5o7MQBzUyu
	 GWmTdmAlpEtWU/5jNUtkgHZOiFOeNsiMyw1tLwXc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 079/117] Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()
Date: Tue, 20 May 2025 15:50:44 +0200
Message-ID: <20250520125807.134258101@linuxfoundation.org>
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

commit 45a442fe369e6c4e0b4aa9f63b31c3f2f9e2090e upstream.

With the netvsc driver changed to use vmbus_sendpacket_mpb_desc()
instead of vmbus_sendpacket_pagebuffer(), the latter has no remaining
callers. Remove it.

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Link: https://patch.msgid.link/20250513000604.1396-6-mhklinux@outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hv/channel.c   |   59 -------------------------------------------------
 include/linux/hyperv.h |    7 -----
 2 files changed, 66 deletions(-)

--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1113,65 +1113,6 @@ int vmbus_sendpacket(struct vmbus_channe
 EXPORT_SYMBOL(vmbus_sendpacket);
 
 /*
- * vmbus_sendpacket_pagebuffer - Send a range of single-page buffer
- * packets using a GPADL Direct packet type. This interface allows you
- * to control notifying the host. This will be useful for sending
- * batched data. Also the sender can control the send flags
- * explicitly.
- */
-int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
-				struct hv_page_buffer pagebuffers[],
-				u32 pagecount, void *buffer, u32 bufferlen,
-				u64 requestid)
-{
-	int i;
-	struct vmbus_channel_packet_page_buffer desc;
-	u32 descsize;
-	u32 packetlen;
-	u32 packetlen_aligned;
-	struct kvec bufferlist[3];
-	u64 aligned_data = 0;
-
-	if (pagecount > MAX_PAGE_BUFFER_COUNT)
-		return -EINVAL;
-
-	/*
-	 * Adjust the size down since vmbus_channel_packet_page_buffer is the
-	 * largest size we support
-	 */
-	descsize = sizeof(struct vmbus_channel_packet_page_buffer) -
-			  ((MAX_PAGE_BUFFER_COUNT - pagecount) *
-			  sizeof(struct hv_page_buffer));
-	packetlen = descsize + bufferlen;
-	packetlen_aligned = ALIGN(packetlen, sizeof(u64));
-
-	/* Setup the descriptor */
-	desc.type = VM_PKT_DATA_USING_GPA_DIRECT;
-	desc.flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
-	desc.dataoffset8 = descsize >> 3; /* in 8-bytes granularity */
-	desc.length8 = (u16)(packetlen_aligned >> 3);
-	desc.transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
-	desc.reserved = 0;
-	desc.rangecount = pagecount;
-
-	for (i = 0; i < pagecount; i++) {
-		desc.range[i].len = pagebuffers[i].len;
-		desc.range[i].offset = pagebuffers[i].offset;
-		desc.range[i].pfn	 = pagebuffers[i].pfn;
-	}
-
-	bufferlist[0].iov_base = &desc;
-	bufferlist[0].iov_len = descsize;
-	bufferlist[1].iov_base = buffer;
-	bufferlist[1].iov_len = bufferlen;
-	bufferlist[2].iov_base = &aligned_data;
-	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
-
-	return hv_ringbuffer_write(channel, bufferlist, 3, requestid, NULL);
-}
-EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
-
-/*
  * vmbus_sendpacket_mpb_desc - Send one or more multi-page buffer packets
  * using a GPADL Direct packet type.
  * The desc argument must include space for the VMBus descriptor. The
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1224,13 +1224,6 @@ extern int vmbus_sendpacket(struct vmbus
 				  enum vmbus_packet_type type,
 				  u32 flags);
 
-extern int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
-					    struct hv_page_buffer pagebuffers[],
-					    u32 pagecount,
-					    void *buffer,
-					    u32 bufferlen,
-					    u64 requestid);
-
 extern int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 				     struct vmbus_packet_mpb_array *mpb,
 				     u32 desc_size,



