Return-Path: <stable+bounces-34981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2808941C6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6ACB22F49
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA30481D7;
	Mon,  1 Apr 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nU2G2deB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEFD481B8;
	Mon,  1 Apr 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989947; cv=none; b=Bngn7Hts8Us9LxlttgiyPkVdDnvlDEX7ZtcAHUW1JeiZt0lJu5lmd92R7FX6rgfg30tXKRdk2owLT1trv70MNFXxqJm3VIj5vbAvd2N1+lfexpQtYJXDtIq1LJsPLxcyCo4MDWjZq2nLpmmVIB7R5+wMlGU9VLpf4dzxbyq1lAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989947; c=relaxed/simple;
	bh=bykUW7s2LJN1t+IW+fklpOuYD6CPTwzZsYoLCc4dut8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT8tfgqC3eQCl4o8j6Sv8pAQbzD8yzziQTXSSKrmUf/va2Aw1f2ZMrLLyk2XbZCgqZtYSCv1SmIFcRa7sfDqvVbQB0AoGJKBFWsPKKrDvnqU9UomQzvAxEya4fjL88/QqMakuOu/ptRoGmHDRjOKgf2T2CoSR1Edy8dDqMOkQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nU2G2deB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6816C433C7;
	Mon,  1 Apr 2024 16:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989947;
	bh=bykUW7s2LJN1t+IW+fklpOuYD6CPTwzZsYoLCc4dut8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nU2G2deBD0q8BAaivp9zfL6Yt0siVGcCvLCw888F0QkcEtnyEux0drMH5pHh5loJZ
	 ZCWXyAfJ+tGkU4Qk4RT9BVVh+Vn5BNGh07As01532teuZiDhHRdLHUwq4K7hvzvyCk
	 ntROj5Hfz437MeYME3iKWNuuh0/up5KN4nFPQYW0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 6.6 200/396] Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory
Date: Mon,  1 Apr 2024 17:44:09 +0200
Message-ID: <20240401152553.894855175@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mhklinux@outlook.com>

commit b8209544296edbd1af186e2ea9c648642c37b18c upstream.

The VMBUS_RING_SIZE macro adds space for a ring buffer header to the
requested ring buffer size.  The header size is always 1 page, and so
its size varies based on the PAGE_SIZE for which the kernel is built.
If the requested ring buffer size is a large power-of-2 size and the header
size is small, the resulting size is inefficient in its use of memory.
For example, a 512 Kbyte ring buffer with a 4 Kbyte page size results in
a 516 Kbyte allocation, which is rounded to up 1 Mbyte by the memory
allocator, and wastes 508 Kbytes of memory.

In such situations, the exact size of the ring buffer isn't that important,
and it's OK to allocate the 4 Kbyte header at the beginning of the 512
Kbytes, leaving the ring buffer itself with just 508 Kbytes. The memory
allocation can be 512 Kbytes instead of 1 Mbyte and nothing is wasted.

Update VMBUS_RING_SIZE to implement this approach for "large" ring buffer
sizes.  "Large" is somewhat arbitrarily defined as 8 times the size of
the ring buffer header (which is of size PAGE_SIZE).  For example, for
4 Kbyte PAGE_SIZE, ring buffers of 32 Kbytes and larger use the first
4 Kbytes as the ring buffer header.  For 64 Kbyte PAGE_SIZE, ring buffers
of 512 Kbytes and larger use the first 64 Kbytes as the ring buffer
header.  In both cases, smaller sizes add space for the header so
the ring size isn't reduced too much by using part of the space for
the header.  For example, with a 64 Kbyte page size, we don't want
a 128 Kbyte ring buffer to be reduced to 64 Kbytes by allocating half
of the space for the header.  In such a case, the memory allocation
is less efficient, but it's the best that can be done.

While the new algorithm slightly changes the amount of space allocated
for ring buffers by drivers that use VMBUS_RING_SIZE, the devices aren't
known to be sensitive to small changes in ring buffer size, so there
shouldn't be any effect.

Fixes: c1135c7fd0e9 ("Drivers: hv: vmbus: Introduce types of GPADL")
Fixes: 6941f67ad37d ("hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218502
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Link: https://lore.kernel.org/r/20240229004533.313662-1-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240229004533.313662-1-mhklinux@outlook.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/hyperv.h |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -164,8 +164,28 @@ struct hv_ring_buffer {
 	u8 buffer[];
 } __packed;
 
+
+/*
+ * If the requested ring buffer size is at least 8 times the size of the
+ * header, steal space from the ring buffer for the header. Otherwise, add
+ * space for the header so that is doesn't take too much of the ring buffer
+ * space.
+ *
+ * The factor of 8 is somewhat arbitrary. The goal is to prevent adding a
+ * relatively small header (4 Kbytes on x86) to a large-ish power-of-2 ring
+ * buffer size (such as 128 Kbytes) and so end up making a nearly twice as
+ * large allocation that will be almost half wasted. As a contrasting example,
+ * on ARM64 with 64 Kbyte page size, we don't want to take 64 Kbytes for the
+ * header from a 128 Kbyte allocation, leaving only 64 Kbytes for the ring.
+ * In this latter case, we must add 64 Kbytes for the header and not worry
+ * about what's wasted.
+ */
+#define VMBUS_HEADER_ADJ(payload_sz) \
+	((payload_sz) >=  8 * sizeof(struct hv_ring_buffer) ? \
+	0 : sizeof(struct hv_ring_buffer))
+
 /* Calculate the proper size of a ringbuffer, it must be page-aligned */
-#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(sizeof(struct hv_ring_buffer) + \
+#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(VMBUS_HEADER_ADJ(payload_sz) + \
 					       (payload_sz))
 
 struct hv_ring_buffer_info {



