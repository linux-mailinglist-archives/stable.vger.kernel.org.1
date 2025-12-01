Return-Path: <stable+bounces-197701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A906CC96C0D
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 11:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDAE3A4E06
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC018304BC9;
	Mon,  1 Dec 2025 10:51:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF4304980;
	Mon,  1 Dec 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586284; cv=none; b=TQZQ1OV/KRJ82mnvOHR+hPUlp+cNgVT/IxSfgu7ml6Oh8AFasx9uOU+ImDsM9juNPPu5LlA3aAWz1OzuW/+4fWPEJuGHDbiMOl2VRa4bNHKjBGu/bcUH9/TICrJQvSs42vrzDaUXfNFLAV/nfQgN2+Shsz+14Zo9cpnzKE+2scc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586284; c=relaxed/simple;
	bh=f7D0pJeKDv+deamM19Hgk7bpUNZ9WShvSpC28QYXz1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MYxnsW/XJYwjHCa1qgrY3XHnM6VJ09VZWj0rd84jGrqGOGfXvnjZFK1s9nl2FSlS8KprZNz8W/PLCukB+lINm08yS/7HpmZl1yUN5jgj6yae6/GrIITOriAlSfIGOAdew5nIYORRswwH4oQqfzejFm620Pwf05IuBraTfuq4evU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 417C4153B;
	Mon,  1 Dec 2025 02:51:14 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06B5B3F73B;
	Mon,  1 Dec 2025 02:51:19 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: akpm@linux-foundation.org,
	pjw@kernel.org,
	leitao@debian.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	coxu@redhat.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: kernel: initialize missing kexec_buf->random field
Date: Mon,  1 Dec 2025 10:51:18 +0000
Message-Id: <20251201105118.2786335-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
introduced the kexec_buf->random field to enable random placement of
kexec_buf.

However, this field was never properly initialized for kexec images
that do not need to be placed randomly, leading to the following UBSAN
warning:

[  +0.364528] ------------[ cut here ]------------
[  +0.000019] UBSAN: invalid-load in ./include/linux/kexec.h:210:12
[  +0.000131] load of value 2 is not a valid value for type 'bool' (aka '_Bool')
[  +0.000003] CPU: 4 UID: 0 PID: 927 Comm: kexec Not tainted 6.18.0-rc7+ #3 PREEMPT(full)
[  +0.000002] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[  +0.000000] Call trace:
[  +0.000001]  show_stack+0x24/0x40 (C)
[  +0.000006]  __dump_stack+0x28/0x48
[  +0.000002]  dump_stack_lvl+0x7c/0xb0
[  +0.000002]  dump_stack+0x18/0x34
[  +0.000001]  ubsan_epilogue+0x10/0x50
[  +0.000002]  __ubsan_handle_load_invalid_value+0xc8/0xd0
[  +0.000003]  locate_mem_hole_callback+0x28c/0x2a0
[  +0.000003]  kexec_locate_mem_hole+0xf4/0x2f0
[  +0.000001]  kexec_add_buffer+0xa8/0x178
[  +0.000002]  image_load+0xf0/0x258
[  +0.000001]  __arm64_sys_kexec_file_load+0x510/0x718
[  +0.000002]  invoke_syscall+0x68/0xe8
[  +0.000001]  el0_svc_common+0xb0/0xf8
[  +0.000002]  do_el0_svc+0x28/0x48
[  +0.000001]  el0_svc+0x40/0xe8
[  +0.000002]  el0t_64_sync_handler+0x84/0x140
[  +0.000002]  el0t_64_sync+0x1bc/0x1c0

To address this, initialise kexec_buf->random field properly.

Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
Suggested-by: Breno Leitao <leitao@debian.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kernel/kexec_image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 532d72ea42ee..b70f4df15a1a 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -41,7 +41,7 @@ static void *image_load(struct kimage *image,
 	struct arm64_image_header *h;
 	u64 flags, value;
 	bool be_image, be_kernel;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	unsigned long text_offset, kernel_segment_number;
 	struct kexec_segment *kernel_segment;
 	int ret;
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


