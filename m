Return-Path: <stable+bounces-87795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD0F9ABB9B
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 04:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CDF1F242E1
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5153E47B;
	Wed, 23 Oct 2024 02:36:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59511BDCF
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650978; cv=none; b=UJ8EGV3UXDsjkC5Kh90azpIGgmICdcytbTo4YJzs2NPd7jHnxx89tx57/D4dNJMFuiru9aCKSAyODHLuncXlwV402kkZ1D+C8l113xShNf758QmkUlouabuExJmu3KwIfsIE3ceDtqr6h2MASYrVZsAdUi3uKpbrfwKc/lmovnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650978; c=relaxed/simple;
	bh=cXWJ0nXRuc8RFqNOc6vuz6UccAKCszG0BSIE9IdY8JM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4IjZKP2aIIgHvAUio/odOdIG2+WbVn8QpIXUaFcX4Lom+l4bwpkdaCRKefF4fJV5pmqE6XqHkmLXd0yD0uS1/Yya5ZU59yfJilY9oZIZjK91ptOahTxXICnFVctRFWuKDOcMLzYsrP+7uJICgcMrk06edb5ViytH+frG9A1+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.180.133.93])
	by gateway (Coremail) with SMTP id _____8BxeeAVYRhn+eAGAA--.15690S3;
	Wed, 23 Oct 2024 10:36:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.133.93])
	by front1 (Coremail) with SMTP id qMiowMDx2OIEYRhnhSkKAA--.59375S5;
	Wed, 23 Oct 2024 10:35:59 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: kernel@openeuler.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH OLK-6.6 3/3] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
Date: Wed, 23 Oct 2024 10:35:46 +0800
Message-Id: <20241023023546.2274277-4-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241023023546.2274277-1-zhanghongchen@loongson.cn>
References: <20241023023546.2274277-1-zhanghongchen@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx2OIEYRhnhSkKAA--.59375S5
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQETB2cYKroD2gAAsi
X-Coremail-Antispam: 1Uk129KBj93XoWxAr4DJr4UKryUCFyUXr4DZFc_yoW5uFWrpF
	s3AF13Jr4DGryxAF1Duw1j9ry8Xrs7Gr43XFs5Cr1xZa12y3W2yr1IgrZ7XFZrA393CFWF
	va1xtr1kZay5Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wNVDUUUUU==

From: Huacai Chen <chenhuacai@loongson.cn>

mainline inclusion
from mainline-v6.11-rc1
commit 7697a0fe0154468f5df35c23ebd7aa48994c2cdc
category: feature
bugzilla: https://gitee.com/openeuler/kernel/issues/IAZ33N
CVE: NA

Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7697a0fe0154468f5df35c23ebd7aa48994c2cdc

----------------------------------------------------------------------

Chromium sandbox apparently wants to deny statx [1] so it could properly
inspect arguments after the sandboxed process later falls back to fstat.
Because there's currently not a "fd-only" version of statx, so that the
sandbox has no way to ensure the path argument is empty without being
able to peek into the sandboxed process's memory. For architectures able
to do newfstatat though, glibc falls back to newfstatat after getting
-ENOSYS for statx, then the respective SIGSYS handler [2] takes care of
inspecting the path argument, transforming allowed newfstatat's into
fstat instead which is allowed and has the same type of return value.

But, as LoongArch is the first architecture to not have fstat nor
newfstatat, the LoongArch glibc does not attempt falling back at all
when it gets -ENOSYS for statx -- and you see the problem there!

Actually, back when the LoongArch port was under review, people were
aware of the same problem with sandboxing clone3 [3], so clone was
eventually kept. Unfortunately it seemed at that time no one had noticed
statx, so besides restoring fstat/newfstatat to LoongArch uapi (and
postponing the problem further), it seems inevitable that we would need
to tackle seccomp deep argument inspection.

However, this is obviously a decision that shouldn't be taken lightly,
so we just restore fstat/newfstatat by defining __ARCH_WANT_NEW_STAT
in unistd.h. This is the simplest solution for now, and so we hope the
community will tackle the long-standing problem of seccomp deep argument
inspection in the future [4][5].

Also add "newstat" to syscall_abis_64 in Makefile.syscalls due to
upstream asm-generic changes.

More infomation please reading this thread [6].

[1] https://chromium-review.googlesource.com/c/chromium/src/+/2823150
[2] https://chromium.googlesource.com/chromium/src/sandbox/+/c085b51940bd/linux/seccomp-bpf-helpers/sigsys_handlers.cc#355
[3] https://lore.kernel.org/linux-arch/20220511211231.GG7074@brightrain.aerifal.cx/
[4] https://lwn.net/Articles/799557/
[5] https://lpc.events/event/4/contributions/560/attachments/397/640/deep-arg-inspection.pdf
[6] https://lore.kernel.org/loongarch/20240226-granit-seilschaft-eccc2433014d@brauner/T/#t

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/include/asm/unistd.h b/arch/loongarch/include/asm/unistd.h
index cfddb0116a8c..f1d2b7e5c062 100644
--- a/arch/loongarch/include/asm/unistd.h
+++ b/arch/loongarch/include/asm/unistd.h
@@ -8,4 +8,5 @@
 
 #include <uapi/asm/unistd.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define NR_syscalls (__NR_syscalls)
-- 
2.33.0


