Return-Path: <stable+bounces-161641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11367B019A7
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 12:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664F05A0193
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 10:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E98281531;
	Fri, 11 Jul 2025 10:25:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB931F4282;
	Fri, 11 Jul 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229536; cv=none; b=AHe/+zzphUeJsm70ckq8h6QNCa952gBj+rS3Ubxezg78aOfD4rR1F3QcXr0oz6RSP8c/bw87y8vdkq6TOua8M3Za13N4ny2t8XRm2P2Hq1L0FbeTrBbjuGloKpzvgr0vxm8uuLfgtWmZ79WlAjKoeYmKtUCVqZZeaA7gP+t8BYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229536; c=relaxed/simple;
	bh=vKJvOURhUE13DR5vB8HI3FuVcBQKiAi/1A/TkD7JfWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZmiEFZanf7heAb7WQRgDvXDUOOFAz1XyX4fXWTtVWsdq0EkXmeR1K+++6vu/jD8iG9SEl9ifNDzp7YVJQw8QR2M6VRvULbFS0Evnfd/+AMh3oMGgY5TJehBlvQQsidA+TmcM/nqj9mLAEJUZ8YBsTGDuLtOQjUcmxSLpDpXUQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.193])
	by gateway (Coremail) with SMTP id _____8Bx22qT5nBosysnAQ--.48018S3;
	Fri, 11 Jul 2025 18:25:23 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.193])
	by front1 (Coremail) with SMTP id qMiowJDxscKH5nBoupkSAA--.12437S2;
	Fri, 11 Jul 2025 18:25:21 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] init: Handle bootloader head in kernel parameters
Date: Fri, 11 Jul 2025 18:24:55 +0800
Message-ID: <20250711102455.3673865-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxscKH5nBoupkSAA--.12437S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr1xCrWxCF48ZF1DuFy3Awc_yoW8XF4DpF
	4qvry3X3s7Jr4Svw48ZrWvg34fuwnxWa12kanruan8JF15Wry0qas5CFZxW3Zxtr4fKF4j
	qF1kXF10k3W7AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jepB-UUUUU=

BootLoader may pass a head such as "BOOT_IMAGE=/boot/vmlinuz-x.y.z" to
kernel parameters. But this head is not recognized by the kernel so will
be passed to user space. However, user space init program also doesn't
recognized it.

KEXEC may also pass a head such as "kexec" on some architectures.

So the the best way is handle it by the kernel itself, which can avoid
such boot warnings:

Kernel command line: BOOT_IMAGE=(hd0,1)/vmlinuz-6.x root=/dev/sda3 ro console=tty
Unknown kernel command line parameters "BOOT_IMAGE=(hd0,1)/vmlinuz-6.x", will be passed to user space.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 init/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/init/main.c b/init/main.c
index 225a58279acd..9e0a7e8913c0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -545,6 +545,7 @@ static int __init unknown_bootoption(char *param, char *val,
 				     const char *unused, void *arg)
 {
 	size_t len = strlen(param);
+	const char *bootloader[] = { "BOOT_IMAGE", "kexec", NULL };
 
 	/* Handle params aliased to sysctls */
 	if (sysctl_is_alias(param))
@@ -552,6 +553,12 @@ static int __init unknown_bootoption(char *param, char *val,
 
 	repair_env_string(param, val);
 
+	/* Handle bootloader head */
+	for (int i = 0; bootloader[i]; i++) {
+		if (!strncmp(param, bootloader[i], strlen(bootloader[i])))
+			return 0;
+	}
+
 	/* Handle obsolete-style parameters */
 	if (obsolete_checksetup(param))
 		return 0;
-- 
2.47.1


