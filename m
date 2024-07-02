Return-Path: <stable+bounces-56769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3160F9245E2
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BBD28266C
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCEB1BE24F;
	Tue,  2 Jul 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CSitQte+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949F1514DC;
	Tue,  2 Jul 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941297; cv=none; b=Y/kX0ucCH1anfO15O7zcBoFi2ynFWXI3VJgkQx9AqU7Z6j9GXEKTZhSQRIWcDzT2h02LZ36VTP7M4LnsKLMhI1fvNLUW2tDsG8kLxaEjurdLnbynO8zwizM7rI9YfQ53x7QLRVHYCcEDp/m6y+HY4cBb85VsjVlRzDlO/vMKsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941297; c=relaxed/simple;
	bh=iafLsxUcGCIlbe2ccXS+4vJRDTSTuB7fO9DCDsG32rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlvZ85uUjueX3Vp1pfVVKTp1QhAwQTY2MqAm1S+vH9vxICebiZTJ641deQtXz4E1x4MePwMHTle3ZIxta+CIq2TNN/JXmARBMHSOJ/k6+uTilGSvpYeV8umdhTXDyOs+TOxES+Quhq64KK5Adxf1gep+JxZLQBCtXM2h7y0/6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CSitQte+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D250C116B1;
	Tue,  2 Jul 2024 17:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719941297;
	bh=iafLsxUcGCIlbe2ccXS+4vJRDTSTuB7fO9DCDsG32rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSitQte+yPFhBYerCWjZ5iVNXfN1e/0N6GB4y42rRQ6SeiZu6zGU/twx63Jzi3JTk
	 yYoYG5whbiY1qrJCOA8IKOx2ebvo5yQ5bQt+UbpniznDgQbCFJxsWYiEC/NtLMA451
	 c5n/10NVvQOcT6fdZeT/3ibIjMsrLP5OrnZ9dJCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 022/128] bpf: Fix overrunning reservations in ringbuf
Date: Tue,  2 Jul 2024 19:03:43 +0200
Message-ID: <20240702170227.073814817@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
References: <20240702170226.231899085@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit cfa1a2329a691ffd991fcf7248a57d752e712881 ]

The BPF ring buffer internally is implemented as a power-of-2 sized circular
buffer, with two logical and ever-increasing counters: consumer_pos is the
consumer counter to show which logical position the consumer consumed the
data, and producer_pos which is the producer counter denoting the amount of
data reserved by all producers.

Each time a record is reserved, the producer that "owns" the record will
successfully advance producer counter. In user space each time a record is
read, the consumer of the data advanced the consumer counter once it finished
processing. Both counters are stored in separate pages so that from user
space, the producer counter is read-only and the consumer counter is read-write.

One aspect that simplifies and thus speeds up the implementation of both
producers and consumers is how the data area is mapped twice contiguously
back-to-back in the virtual memory, allowing to not take any special measures
for samples that have to wrap around at the end of the circular buffer data
area, because the next page after the last data page would be first data page
again, and thus the sample will still appear completely contiguous in virtual
memory.

Each record has a struct bpf_ringbuf_hdr { u32 len; u32 pg_off; } header for
book-keeping the length and offset, and is inaccessible to the BPF program.
Helpers like bpf_ringbuf_reserve() return `(void *)hdr + BPF_RINGBUF_HDR_SZ`
for the BPF program to use. Bing-Jhong and Muhammad reported that it is however
possible to make a second allocated memory chunk overlapping with the first
chunk and as a result, the BPF program is now able to edit first chunk's
header.

For example, consider the creation of a BPF_MAP_TYPE_RINGBUF map with size
of 0x4000. Next, the consumer_pos is modified to 0x3000 /before/ a call to
bpf_ringbuf_reserve() is made. This will allocate a chunk A, which is in
[0x0,0x3008], and the BPF program is able to edit [0x8,0x3008]. Now, lets
allocate a chunk B with size 0x3000. This will succeed because consumer_pos
was edited ahead of time to pass the `new_prod_pos - cons_pos > rb->mask`
check. Chunk B will be in range [0x3008,0x6010], and the BPF program is able
to edit [0x3010,0x6010]. Due to the ring buffer memory layout mentioned
earlier, the ranges [0x0,0x4000] and [0x4000,0x8000] point to the same data
pages. This means that chunk B at [0x4000,0x4008] is chunk A's header.
bpf_ringbuf_submit() / bpf_ringbuf_discard() use the header's pg_off to then
locate the bpf_ringbuf itself via bpf_ringbuf_restore_from_rec(). Once chunk
B modified chunk A's header, then bpf_ringbuf_commit() refers to the wrong
page and could cause a crash.

Fix it by calculating the oldest pending_pos and check whether the range
from the oldest outstanding record to the newest would span beyond the ring
buffer size. If that is the case, then reject the request. We've tested with
the ring buffer benchmark in BPF selftests (./benchs/run_bench_ringbufs.sh)
before/after the fix and while it seems a bit slower on some benchmarks, it
is still not significantly enough to matter.

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Reported-by: Muhammad Ramdhan <ramdhan@starlabs.sg>
Co-developed-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240621140828.18238-1-daniel@iogearbox.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/ringbuf.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 9e832acf46925..a1911391a864c 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -59,7 +59,8 @@ struct bpf_ringbuf {
 	 * This prevents a user-space application from modifying the
 	 * position and ruining in-kernel tracking. The permissions of the
 	 * pages depend on who is producing samples: user-space or the
-	 * kernel.
+	 * kernel. Note that the pending counter is placed in the same
+	 * page as the producer, so that it shares the same cache line.
 	 *
 	 * Kernel-producer
 	 * ---------------
@@ -78,6 +79,7 @@ struct bpf_ringbuf {
 	 */
 	unsigned long consumer_pos __aligned(PAGE_SIZE);
 	unsigned long producer_pos __aligned(PAGE_SIZE);
+	unsigned long pending_pos;
 	char data[] __aligned(PAGE_SIZE);
 };
 
@@ -176,6 +178,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	rb->mask = data_sz - 1;
 	rb->consumer_pos = 0;
 	rb->producer_pos = 0;
+	rb->pending_pos = 0;
 
 	return rb;
 }
@@ -390,9 +393,9 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr *hdr)
 
 static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 {
-	unsigned long cons_pos, prod_pos, new_prod_pos, flags;
-	u32 len, pg_off;
+	unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, flags;
 	struct bpf_ringbuf_hdr *hdr;
+	u32 len, pg_off, tmp_size, hdr_len;
 
 	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
 		return NULL;
@@ -410,13 +413,29 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 		spin_lock_irqsave(&rb->spinlock, flags);
 	}
 
+	pend_pos = rb->pending_pos;
 	prod_pos = rb->producer_pos;
 	new_prod_pos = prod_pos + len;
 
-	/* check for out of ringbuf space by ensuring producer position
-	 * doesn't advance more than (ringbuf_size - 1) ahead
+	while (pend_pos < prod_pos) {
+		hdr = (void *)rb->data + (pend_pos & rb->mask);
+		hdr_len = READ_ONCE(hdr->len);
+		if (hdr_len & BPF_RINGBUF_BUSY_BIT)
+			break;
+		tmp_size = hdr_len & ~BPF_RINGBUF_DISCARD_BIT;
+		tmp_size = round_up(tmp_size + BPF_RINGBUF_HDR_SZ, 8);
+		pend_pos += tmp_size;
+	}
+	rb->pending_pos = pend_pos;
+
+	/* check for out of ringbuf space:
+	 * - by ensuring producer position doesn't advance more than
+	 *   (ringbuf_size - 1) ahead
+	 * - by ensuring oldest not yet committed record until newest
+	 *   record does not span more than (ringbuf_size - 1)
 	 */
-	if (new_prod_pos - cons_pos > rb->mask) {
+	if (new_prod_pos - cons_pos > rb->mask ||
+	    new_prod_pos - pend_pos > rb->mask) {
 		spin_unlock_irqrestore(&rb->spinlock, flags);
 		return NULL;
 	}
-- 
2.43.0




