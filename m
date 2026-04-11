Return-Path: <stable+bounces-235681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLY/MZGs2WkdsAgAu9opvQ
	(envelope-from <stable+bounces-235681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 04:06:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F8E3DDF35
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 04:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19EF03008A78
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137C27E07E;
	Sat, 11 Apr 2026 02:05:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592FD247291;
	Sat, 11 Apr 2026 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775873146; cv=none; b=tgfkodaU1LRfb5dQF68zIYKoswemmBTVOmXndwCv0cEdwKpQ6mV56H+syw5fwza/F0s2WlfXr5VLkdqpP2zWZ94/B1+5nfuv4yYReeFV4kl61rmGoqlEuz34bTfjuaCQU+5ghePSmgqd0ZMzYGE2xHmYHpxtUh40BGugjjIBMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775873146; c=relaxed/simple;
	bh=A8T+0KyOzB5wMeVORzGGrHba9n+in8xjS4BOAhubVXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bg9T/5yd5r4fk22kc1nRgYtcmTAJyGy4kYDjCQuGyoWsZ+ts7+fEFSRQdQn3+fKNn6NFtBBlYrKCiH9dPeNmnv4arItvilwsHd6e/PrThIXdbsgCGoqF5LZWMiEPKAsG1MGmy2+rsbMQ7JOydG44h3fsDciFVKwmMJV1L4HtjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.17])
	by gateway (Coremail) with SMTP id _____8Cx_6pwrNlpLTYkAA--.1788S3;
	Sat, 11 Apr 2026 10:05:36 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.17])
	by front1 (Coremail) with SMTP id qMiowJDxhcBprNlpZ8FqAA--.37055S2;
	Sat, 11 Apr 2026 10:05:32 +0800 (CST)
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
Subject: [PATCH V2] LoongArch: Show CPU vulnerabilites correctly
Date: Sat, 11 Apr 2026 10:05:22 +0800
Message-ID: <20260411020522.2779250-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxhcBprNlpZ8FqAA--.37055S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr15JF1kZr1DCr1xAF4fZwc_yoW8WrWkpF
	Wqywn5Xr4rCF1DtasFvF129ryDX3WkGw13Wa4akFykAF12vr1DXr1v93yDXF1jvw47KayF
	gF98G3s3KFW7Z3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2MKZDUUUU
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235681-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,loongson.cn:mid,cc-sw.com:url]
X-Rspamd-Queue-Id: 36F8E3DDF35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most LoongArch processors are vulnerable to Spectre-V1 Proof-of-Concept
(PoC). And the generic mechanism, __user pointer sanitization, can be
used as a mitigation. This means to use array_index_nospec() to prevent
out of boundry access in syscall and other critical paths.

Implement the arch-specific cpu_show_spectre_v1() to show CPU Spectre-V1
vulnerabilites correctly.

Cc: stable@vger.kernel.org
Link: https://cc-sw.com/chinese-loongarch-architecture-evaluation-part-3-of-3/
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Fix build warnings.

 arch/loongarch/kernel/cpu-probe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 8654a1eff834..c8947c798195 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -402,3 +402,9 @@ void cpu_probe(void)
 
 	cpu_report();
 }
+
+ssize_t cpu_show_spectre_v1(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Mitigation: __user pointer sanitization\n");
+}
-- 
2.52.0

diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index c8947c798195..52f36ef19897 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
+#include <linux/cpu.h>
 #include <linux/smp.h>
 #include <linux/stddef.h>
 #include <linux/export.h>


