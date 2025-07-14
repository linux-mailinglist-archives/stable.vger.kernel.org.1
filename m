Return-Path: <stable+bounces-161809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8F3B03783
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 09:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CB8176651
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8422DA1F;
	Mon, 14 Jul 2025 07:04:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB122DA08;
	Mon, 14 Jul 2025 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476699; cv=none; b=Fz8mCgai61HlYUBtqS89G5BQ9nxP5jhMjyyaS06Gj1LSlvstN1XRA0Gdss59ln2Uz3qOgwghfv5mfzkBsnT0rrhAheoTQjeCEOqmnPNVBoxPaOVSlfAiT2uUaVq2DiflfiUSvmpfrHeECcQVK4499EB4PonheoH+fNoy6zx2YBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476699; c=relaxed/simple;
	bh=cToq3o3HlGCMSYHZ2d6IQRVOA5a0EC+VOiw+pnCaSKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUNgw9zBnMazxf3ubQtFiHcMgec/h1U4NjGAo+3Fozl43GUdoKx03BvvpO/Ciob1HK+omcDV2y0Y4gUWP65RggDDO6d4NCZXcpCZpLa2U5w/efocywu4wKXO96RHuSH70Ncenyy8i7Yzqa1+8aTz6kiacmIVEWgBxxIqSCRG9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.193])
	by gateway (Coremail) with SMTP id _____8DxzOIVrHRo6g4pAQ--.19529S3;
	Mon, 14 Jul 2025 15:04:53 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.193])
	by front1 (Coremail) with SMTP id qMiowJAx_8EPrHRo4HoWAA--.4569S2;
	Mon, 14 Jul 2025 15:04:52 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: Make relocate_new_kernel_size be a .quad value
Date: Mon, 14 Jul 2025 15:04:38 +0800
Message-ID: <20250714070438.2399153-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx_8EPrHRo4HoWAA--.4569S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GrWfWF17Ar18GFy5XryDXFc_yoWktrX_KF
	yxJws8Gr4UJF4jywn0vwsavr1Ygw15Jas5Cw1kX3yxJasxArWjyr45Xan5uwsIkr4kGrWY
	qw1DGFsayr42qosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcVc_UUUUU

Now relocate_new_kernel_size is a .long value, which means 32bit, so its
high 32bit is undefined. This causes memcpy((void *)reboot_code_buffer,
relocate_new_kernel, relocate_new_kernel_size) in machine_kexec_prepare()
access out of range memories in some cases, and then end up with an ADE
exception.

So make relocate_new_kernel_size be a .quad value, which means 64bit, to
avoid such errors.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/relocate_kernel.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/relocate_kernel.S b/arch/loongarch/kernel/relocate_kernel.S
index 84e6de2fd973..8b5140ac9ea1 100644
--- a/arch/loongarch/kernel/relocate_kernel.S
+++ b/arch/loongarch/kernel/relocate_kernel.S
@@ -109,4 +109,4 @@ SYM_CODE_END(kexec_smp_wait)
 relocate_new_kernel_end:
 
 	.section ".data"
-SYM_DATA(relocate_new_kernel_size, .long relocate_new_kernel_end - relocate_new_kernel)
+SYM_DATA(relocate_new_kernel_size, .quad relocate_new_kernel_end - relocate_new_kernel)
-- 
2.47.1


