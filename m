Return-Path: <stable+bounces-145203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD5ABDA81
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629911BA5313
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB52441A7;
	Tue, 20 May 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdHz9FcS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD0243378;
	Tue, 20 May 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749467; cv=none; b=BGY90grqwP/SQfo5+jjCYlwh2f4wvAaxfxJNoxJyHeEheI0dPFNRhQ2j9Kc9Da85sGvDTqGXV57Kd3QCFyFopunuVL9OVwkvDJ+nNxlhMV5/0tzvJHwJY6wsznH79h3fNoh8BZBthyX1aW0AAG9Ahetzi6r8E1GBfb8yRn9KeZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749467; c=relaxed/simple;
	bh=EXd6WAvY5Xp6I4xcvyZqZn7ZHpmxMpgf/w6rjosoKJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfg5fGQUQriJFqAPUW6pqJLD5+L7BQLlk+BbC6d6Eo8qLLRfIbLZM/84yPsHnN37GK0ZD4mswfd8O8OB0ndyN0bq6zpOyfbqJ4o7w6rSLX+hzNGThr9hv0hGOUzolvnBZpk0qsGKcSTb+qlNopSzQbSlhqNM/oacrSGFX5BxqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdHz9FcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDF5C4CEE9;
	Tue, 20 May 2025 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749467;
	bh=EXd6WAvY5Xp6I4xcvyZqZn7ZHpmxMpgf/w6rjosoKJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdHz9FcSygn96IRVFc2tmVlnWo/3flIZu/mROpXnjvqfU2e/nzx3vKAAFOAWETR3y
	 2nk9R2bDAS5cUEVC1y9m5U574wE5LeYvGtKVPlKr9B1vREAOTE5axBkcjHZ3BfvB1S
	 VQJbP5FpLaV4yMbX9rp/wJPA+ocz9Pqi3a+YrhZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 54/97] Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()
Date: Tue, 20 May 2025 15:50:19 +0200
Message-ID: <20250520125802.775392855@linuxfoundation.org>
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



