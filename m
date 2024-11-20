Return-Path: <stable+bounces-94434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C9D9D3EC8
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 16:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C32F1F25077
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7761C57AA;
	Wed, 20 Nov 2024 15:10:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110011B85C1;
	Wed, 20 Nov 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115443; cv=none; b=e3OqPwv259YUth6gno93MvczGvbVNaeRM7HOT+1V+6EYxujuRZN6rQADUUJumChqgwQZijk5SxNyD9JpvkBlC+UVjKR8fJXVoxx8OBrvvH/sHwg4Ep/v888+G/iaRF8xb9MfMd3tDXHHBEJTT+MMBxF+q6ICsI/Q9uF7Qaa+N0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115443; c=relaxed/simple;
	bh=SCPGHzzQ2BKPMQKq6ogaqxmB1VFuttE+wlSxcPJR2iM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5Dy3zFm3wnYBMGBcibXsoYBtIoZnpyx0DciuVNb7700fT+pgW+dvLQZZ/OzQrvOfHW6LxRTqnK1wdh0v2N0gUlH6XnqWPC6PgiATpIw+rlkiJDoIHPGTB9WZFAmhQekvoyC8vu//5E9Whb7Hrof/RLxRnGDFYUyZsAKiuVj3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.202])
	by gateway (Coremail) with SMTP id _____8AxquHr+z1nLMhDAA--.4497S3;
	Wed, 20 Nov 2024 23:10:35 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.202])
	by front1 (Coremail) with SMTP id qMiowMCx_8Lm+z1n8m9fAA--.10941S2;
	Wed, 20 Nov 2024 23:10:35 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Haiyong Sun <sunhaiyong@loongson.cn>
Subject: [PATCH] LoongArch: Explicitly specify code model in Makefile
Date: Wed, 20 Nov 2024 23:10:26 +0800
Message-ID: <20241120151026.1683941-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_8Lm+z1n8m9fAA--.10941S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zry8Jw4rWF4rKF45uFy8WFX_yoW8JFW3pF
	Z3Zr1kKr48WrW8tFykJa43WF4DGa1Dtr42vF42q34UAFyrZw13Xr4rJa1kGF1UGasrA3yF
	gayfKFy3AFyDJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxU2MKZDUUUU

LoongArch's toolchain may change the default code model from normal to
medium. This is unnecessary for kernel, and generates some relocations
which cannot be handled by the module loader. So explicitly specify the
code model to normal in Makefile (for Rust 'normal' is 'small').

Cc: stable@vger.kernel.org
Tested-by: Haiyong Sun <sunhaiyong@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index ae3f80622f4c..567bd122a9ee 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -59,7 +59,7 @@ endif
 
 ifdef CONFIG_64BIT
 ld-emul			= $(64bit-emul)
-cflags-y		+= -mabi=lp64s
+cflags-y		+= -mabi=lp64s -mcmodel=normal
 endif
 
 cflags-y			+= -pipe $(CC_FLAGS_NO_FPU)
@@ -104,7 +104,7 @@ ifdef CONFIG_OBJTOOL
 KBUILD_CFLAGS			+= -fno-jump-tables
 endif
 
-KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat
+KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat -Ccode-model=small
 KBUILD_RUSTFLAGS_KERNEL		+= -Zdirect-access-external-data=yes
 KBUILD_RUSTFLAGS_MODULE		+= -Zdirect-access-external-data=no
 
-- 
2.43.5


