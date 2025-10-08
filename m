Return-Path: <stable+bounces-183588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC39BC3B89
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 09:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA14188142C
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9C02F0699;
	Wed,  8 Oct 2025 07:50:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54649BA4A;
	Wed,  8 Oct 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759909858; cv=none; b=lRQrPWZ5EQ1xMYCVYK0pA4jIbvb/vqsi84GWLQTXWI1WJ96kr73ATV3qw6xtGzgohLteI2i1o/P4dUK+XJSiptDyfIffcYifl4qhyMZVfubRv6tmBjA/srkHG4PRah8ZCksclW5ckgttud9CWOCv+5n7QUlXnFtl8mFw6EfcJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759909858; c=relaxed/simple;
	bh=UCqejvx3Wzj5uQO0KGNts4+sn5ztUu1ECviBWuIVAuE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bsOh8NojXPnU5T7ZxOJP8qRzDfgX3zPo9fQfLbAkBn0pRfFwiMFIO1mh9Qwxha/I18sSB2P/xyXNqiztB6OBrVrWZV2JSIkqtp3eboqcUG3LMKsq3mhBd9P0vH2GC/zZkeFPxRMFw5Asmqw5gD2idTRkCRqLYyvw/qwE7UQN1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.81.247])
	by APP-01 (Coremail) with SMTP id qwCowAA3kaPLF+ZoUI4EDQ--.32936S2;
	Wed, 08 Oct 2025 15:50:35 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH 6.6.y 0/2] riscv: mm: Backport of mmap hint address fixes
Date: Wed, 08 Oct 2025 15:50:15 +0800
Message-Id: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALcX5mgC/x2MQQqEMAxFryJZG7FCK3oVcVHbzEwWaklAFPHuh
 uHBh7f47wYlYVIYqxuEDlbeNxNXV5B+cfsScjaHru18O7gehTUduK6xYMxZUEtMhMFwnvq8hMX
 bgP2L0IfPf3uC0ITmgvl5XkLmNYVyAAAA
X-Change-ID: 20250917-riscv-mmap-addr-space-6-6-15e7db6b5db6
To: stable@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Guo Ren <guoren@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>, 
 Yangyu Chen <cyy@cyyself.name>, Han Gao <rabenda.cn@gmail.com>, 
 Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, 
 Palmer Dabbelt <palmer@rivosinc.com>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowAA3kaPLF+ZoUI4EDQ--.32936S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr17Kw45Cr43Jw4xCr4Durg_yoWfGwb_ZF
	WUtas5Xw1UJF4DWFWDK3WrWr4vk3sYvryrAr1kJ39xGr1akr4DCw42grW8XasFvan5KrZr
	JrWxA34IyFy7tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Backport of the two riscv mmap patches from master. In effect, these two
patches removes arch_get_mmap_{base,end} for riscv.

Guo Ren: Please take a look. Patch 1 has a slightly non-trivial conflict
with your commit 97b7ac69be2e ("riscv: mm: Fixup compat
arch_get_mmap_end"), which changed STACK_TOP_MAX from TASK_SIZE_64 to
TASK_SIZE when CONFIG_64BIT=y. This shouldn't be a problem, but, well,
just to be safe.

---
Charlie Jenkins (2):
      riscv: mm: Use hint address in mmap if available
      riscv: mm: Do not restrict mmap address based on hint

 arch/riscv/include/asm/processor.h | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)
---
base-commit: 60a9e718726fa7019ae00916e4b1c52498da5b60
change-id: 20250917-riscv-mmap-addr-space-6-6-15e7db6b5db6

Best regards,
-- 
Vivian "dramforever" Wang


