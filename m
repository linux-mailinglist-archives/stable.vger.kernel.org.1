Return-Path: <stable+bounces-60394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069DA933795
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 09:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C771C22F9B
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 07:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42291862A;
	Wed, 17 Jul 2024 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="EjzfHKvX";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="jdO9ZU/A"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ABD168BD
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200011; cv=none; b=uyNC7czXIJTx6KdgIxOuxujpd3YWARcpbbi75Wmn8IoBcjoJJTYPJvyAv/DKOaNPWwCgq8WM5wroZ1R+EFOJVQiL0BKhN+dDbWwSq2WgNO2H5D31CI6G2KHn2Pb1b6i/hzDV2esIFqp2uufjiWRrCllxTAO3joZ+8IXmO54HPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200011; c=relaxed/simple;
	bh=65xOSFoM8MP80drLWmLcDodRrDY9h6SdWFcHarUsseM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dp+97lhlT1KNbpjqG4Ko6zi1rn3148QpidzIPsdmTM9G7yL2+jXtLdBkvpI2f3ZqhYnOozTCbgEn6ELYjTX2uL8oi8Itw5VCa8ooj22n98J4XgVWEGzOxQDzjHCcCxRQAjNMMVlOh+I5Y4bteWA3x21MNmlmX4Z7dVaiTf+WwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=EjzfHKvX; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=jdO9ZU/A; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1721199593;
	bh=65xOSFoM8MP80drLWmLcDodRrDY9h6SdWFcHarUsseM=;
	h=From:To:Cc:Subject:Date:From;
	b=EjzfHKvXx1vVzefD5UJr5ZZ9GDlIRv5eEao0d3HA+6hd7O5RXeg/EjVLDwibRKlAb
	 /agxmAwqhTwfOWWIClh4bsV+ZpcD1GUkFMssbJLATiqBC3qHsD3kYBYi/J0NuzaN/g
	 Z59dWPHn9bINpLFqfaSiIT77Wne58/G6hU+pLVUMh40myvDI1xxfATcgEOmExD5/q9
	 BtAYtkWE7luN0FIdpempxngD0AvF+P6Mp13MnIXbYTjOfqz6d7NvQv12VG9s4IYKjK
	 lRAsst7ysIAqvvp7TDNSGZ1TDSmq1zPMc9EyTogK0Ij0RCFRw7ZDUAagQ9i2jpMqJu
	 lRyYu4muqO8VQ==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 2CC5B3F2
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:59:53 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=jdO9ZU/A;
	dkim-atps=neutral
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 2B08447A
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:59:52 +0900 (JST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-25e46c20b00so5954440fac.1
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 23:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1721199591; x=1721804391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNfJfXpYedJZSYYzS17v37ye2jCftg3/OOWbhti96y4=;
        b=jdO9ZU/Ad+j+JtbpMgPpn01s8tjn0M7VzautJaghbmx3FLG1ue5zCC/pKPNag4zbhH
         M/CGXkD04BKq+w21Cq1S2gb1KLq8PwYJW6xdaVQuBjrZm22bqT9kvIBsDvQZlrgO5qgS
         /flZVbOxQlupEPfEzQ9iiiH1Lul8NX9QSiiBc8pAVzIi86mPC5lyX+Q43u3TyOOgNJyr
         pL6JRy8V3/kAET4R5QHW4DiM29giS31MtNai46sYwvnjGe9b0ZylCTsrotvoerPAAl/C
         JyDOjIU15XRwZTGIdwDPo8uPTRsd0/a5wfZW7pLn4srXOXSkaG3pQgVHSBtpaymBnLLL
         1QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721199591; x=1721804391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNfJfXpYedJZSYYzS17v37ye2jCftg3/OOWbhti96y4=;
        b=ldvmN914O3YhhOVWptq3cp+xu+xHlxXt8CXR1HYwFefTLDtELbk8NrWpW1Qa4KFihi
         Vf0BkFb1zo2El7SD5I7UiWrrZljR7N7I1GRHjOe7AbIwXX8DfOf0U6iTROewbKLvgB5z
         fEX/TyrcuP2CAfBSAdNxcI89DzgHgZG8srZiFRUHDTSwgcxGqFcC6rqeXaqzWUG8DTjj
         /SjGd1YHXjniUcyXtoDRRmbBB0Ik7pF+JB7UXHnV+CaAKQERi9GANxCWzuVEtHasYeV+
         mQwFM7DLS/xtNQn++0ix+YtNGqmGvwnQ5SgR/DQhiwZjXOAqSeY/iI6MmR/fXQ17iulH
         n26w==
X-Gm-Message-State: AOJu0Yzpk42awQjfdoukGJyqkmrOpyrQGuUZM0Jh2osC/s5QNTnRjS4B
	mMEM+wV8opGgv+9HT+uyROhLfxHcANiGQ2+UGbpafDPNm8Wh8vWqopA/u17/iDAOrdE9VeSYW/U
	iF2D34ZkcXX7Db9QPN4GmBJoysSGYG8T7gi3Jd512kRPrdZjcQhwGowOHQXQgNfY=
X-Received: by 2002:a05:6870:3282:b0:25e:97a:cd69 with SMTP id 586e51a60fabf-260d94a9af0mr430603fac.55.1721199590707;
        Tue, 16 Jul 2024 23:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETlz6McS5Z+zSy0GArMhsC5E/QfLKzYPAoPMutexcz6hOvCr7WcimZ/g8id6+/M0dIK2mdLQ==
X-Received: by 2002:a05:6870:3282:b0:25e:97a:cd69 with SMTP id 586e51a60fabf-260d94a9af0mr430597fac.55.1721199590320;
        Tue, 16 Jul 2024 23:59:50 -0700 (PDT)
Received: from pc-0182.atmarktech (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7d2bcsm7684240b3a.99.2024.07.16.23.59.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2024 23:59:49 -0700 (PDT)
Received: from [::1] (helo=pc-0182.atmark.tech)
	by pc-0182.atmarktech with esmtp (Exim 4.96)
	(envelope-from <dominique.martinet@atmark-techno.com>)
	id 1sTydg-005bjx-2D;
	Wed, 17 Jul 2024 15:59:48 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Andrii Nakryiko <andrii@kernel.org>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.10] bpf: Fix overrunning reservations in ringbuf
Date: Wed, 17 Jul 2024 15:59:46 +0900
Message-Id: <20240717065946.1336705-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
The only conflict with the patch was in the comment at top of the patch
(the commit that had changed this comment, 583c1f420173 ("bpf: Define
new BPF_MAP_TYPE_USER_RINGBUF map type"), has nothing to do with this
fix), so I went ahead with it.

I'm not familiar with the ringbuf code but it doesn't look too wrong to
me at first glance; and with this all stable branches are covered.

 kernel/bpf/ringbuf.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 1e4bf23528a3..eac0026e2fa6 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -41,9 +41,12 @@ struct bpf_ringbuf {
 	 * mapping consumer page as r/w, but restrict producer page to r/o.
 	 * This protects producer position from being modified by user-space
 	 * application and ruining in-kernel position tracking.
+	 * Note that the pending counter is placed in the same
+	 * page as the producer, so that it shares the same cache line.
 	 */
 	unsigned long consumer_pos __aligned(PAGE_SIZE);
 	unsigned long producer_pos __aligned(PAGE_SIZE);
+	unsigned long pending_pos;
 	char data[] __aligned(PAGE_SIZE);
 };
 
@@ -145,6 +148,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	rb->mask = data_sz - 1;
 	rb->consumer_pos = 0;
 	rb->producer_pos = 0;
+	rb->pending_pos = 0;
 
 	return rb;
 }
@@ -323,9 +327,9 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr *hdr)
 
 static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 {
-	unsigned long cons_pos, prod_pos, new_prod_pos, flags;
-	u32 len, pg_off;
+	unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, flags;
 	struct bpf_ringbuf_hdr *hdr;
+	u32 len, pg_off, tmp_size, hdr_len;
 
 	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
 		return NULL;
@@ -343,13 +347,29 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
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
2.39.2



