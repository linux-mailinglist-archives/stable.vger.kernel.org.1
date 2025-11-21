Return-Path: <stable+bounces-196499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA5C7A719
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EF63A1294
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492F28D82F;
	Fri, 21 Nov 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRqYNPzG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860E221F0A
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737903; cv=none; b=c7e4qlJ9XmKXrC2a5frRDST1dqiLfx6o0NK62PIU0jNME6LtBJrOUgFvHVfydWYL6wVt1w8hd5HfZtuKgjtSeD5zBjU7g5WTwOhxQDvQugOeqVbvBHAb8G6jVDRhcCXVDrDh6NR9kozUMhlPVNap7BAywvyhlmcC/3SwtN8EdQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737903; c=relaxed/simple;
	bh=tLQk0k5vh+Mj6/nbDJE9tSmjNZwEVI2yygeNEEc394c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUorR7tGuCpX3HxzyChyT489DIWFdOChcZfUSDVh8qybtV5HXzjvKwSv2iXlaXlSOUMoBLS+rk9KbH0bv7av0RO4HACJXDZC4V+L3h7t7L02BF562h7XmLZtNyOCGelpTUeEpl5rB+k06KH3KEv01roGyTEdxe4x7tKhTnvvwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRqYNPzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919B8C4CEF1;
	Fri, 21 Nov 2025 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763737903;
	bh=tLQk0k5vh+Mj6/nbDJE9tSmjNZwEVI2yygeNEEc394c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tRqYNPzG6H+1hD2zKkea3CpBATFUNEChCUUkkz/Jbj5squVBAyqoFXVqypgVyyQWA
	 lymb8VSyo6xa+R3FSLO/fLMeSSpDa7/zsMFmN7ajYrkAgp6AtR/PQgLFpQqQwsbfGC
	 AcNNx8yKahYJfEUk71YoEEaAn7Aqcmzqyv6swQJr2FoLL5diDxkob2wyeKkcy7dQRZ
	 A/h6eGWTHAAOaYuukOUT/0c4tFRDkHZ7LpW2j67+prYACYRS1y5yGVLCQ3HeLZG8AG
	 ZUs1YRc2oZ0RtInJmJr6DljBd1TyUf134h4g6aW1eYn9QI6jgnE2pd7zTa/+J+8WzN
	 xa5JVwyQVdssw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] crash: fix crashkernel resource shrink
Date: Fri, 21 Nov 2025 10:11:40 -0500
Message-ID: <20251121151140.2560469-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112029-arrogance-bondless-6a5b@gregkh>
References: <2025112029-arrogance-bondless-6a5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sourabh Jain <sourabhjain@linux.ibm.com>

[ Upstream commit 00fbff75c5acb4755f06f08bd1071879c63940c5 ]

When crashkernel is configured with a high reservation, shrinking its
value below the low crashkernel reservation causes two issues:

1. Invalid crashkernel resource objects
2. Kernel crash if crashkernel shrinking is done twice

For example, with crashkernel=200M,high, the kernel reserves 200MB of high
memory and some default low memory (say 256MB).  The reservation appears
as:

cat /proc/iomem | grep -i crash
af000000-beffffff : Crash kernel
433000000-43f7fffff : Crash kernel

If crashkernel is then shrunk to 50MB (echo 52428800 >
/sys/kernel/kexec_crash_size), /proc/iomem still shows 256MB reserved:
af000000-beffffff : Crash kernel

Instead, it should show 50MB:
af000000-b21fffff : Crash kernel

Further shrinking crashkernel to 40MB causes a kernel crash with the
following trace (x86):

BUG: kernel NULL pointer dereference, address: 0000000000000038
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
<snip...>
Call Trace: <TASK>
? __die_body.cold+0x19/0x27
? page_fault_oops+0x15a/0x2f0
? search_module_extables+0x19/0x60
? search_bpf_extables+0x5f/0x80
? exc_page_fault+0x7e/0x180
? asm_exc_page_fault+0x26/0x30
? __release_resource+0xd/0xb0
release_resource+0x26/0x40
__crash_shrink_memory+0xe5/0x110
crash_shrink_memory+0x12a/0x190
kexec_crash_size_store+0x41/0x80
kernfs_fop_write_iter+0x141/0x1f0
vfs_write+0x294/0x460
ksys_write+0x6d/0xf0
<snip...>

This happens because __crash_shrink_memory()/kernel/crash_core.c
incorrectly updates the crashk_res resource object even when
crashk_low_res should be updated.

Fix this by ensuring the correct crashkernel resource object is updated
when shrinking crashkernel memory.

Link: https://lkml.kernel.org/r/20251101193741.289252-1-sourabhjain@linux.ibm.com
Fixes: 16c6006af4d4 ("kexec: enable kexec_crash_size to support two crash kernel regions")
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Applied fix to `kernel/kexec_core.c` instead of `kernel/crash_core.c` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index b7246b7171b73..88024cb22a9db 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1132,7 +1132,7 @@ static int __crash_shrink_memory(struct resource *old_res,
 		old_res->start = 0;
 		old_res->end   = 0;
 	} else {
-		crashk_res.end = ram_res->start - 1;
+		old_res->end = ram_res->start - 1;
 	}
 
 	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
-- 
2.51.0


