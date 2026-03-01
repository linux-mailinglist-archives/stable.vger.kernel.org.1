Return-Path: <stable+bounces-222190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI+rNvSso2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:05:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 460EF1CE321
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0CF6329F44E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180BD2773EC;
	Sun,  1 Mar 2026 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q559ejkc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C927281D;
	Sun,  1 Mar 2026 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330122; cv=none; b=nk1otxA2R7qjSWnAhvbyuar8QEHexw8P+t1ZQT0bI6z8fW3emOvILJjakT5BUebtKIh1ufLEpk2uLssfU9o4VQbnhenl8JSMKHYqOLXCxHYUC5vwgy3U4EjJkiXFQg9KsxgGB4ZLJ9KyknCc06MYPs8UkiOg/GjbTH1SHubeg6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330122; c=relaxed/simple;
	bh=VCATElnsvig6h+2ikJy3K3apHNgIODHvAUxvlK0Jd/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1ZzHrzKFtwG8C1wx7bg+Gn4y4yMFSZ4CKWX/OkvnFBhiKplYjRjDClJpsvZVPEpGqSAGy1kaFfwHnLiEeGbnE5/YLQmvWKgFNCvowJ5faz4oSV8LVr+tH1tYLN+rTxrP1CCRPSB9geE2O6L0njz5wsGHeLTh5I4WrT9D64mt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q559ejkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B026C19421;
	Sun,  1 Mar 2026 01:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330122;
	bh=VCATElnsvig6h+2ikJy3K3apHNgIODHvAUxvlK0Jd/M=;
	h=From:To:Cc:Subject:Date:From;
	b=Q559ejkcrWbRksuYXrhSkzjHTj1+skQoSWJVRFRyo6L7jCudCHzhp/GGfnq7nys4g
	 1LiPpu+IlMOX3+/dT9hSlsAA8HjYwfqkF3nBn7KI0y77t5wZ4w711gPQr2FEIGfvsw
	 VPSGkZmqqYHjNVekoZMYEefC59sGE3ZoT7CAq3zTLbwwhu85iT+8sgracEaw8SMh7B
	 5aMMWmZI7dJevil8G2GdF2QccAc5N+1iZDI22kRR1hfQNu0NZOH01Nj+HX8B12uQt8
	 vmpR/4WgWaMiR7s3W6Q6DA5yJi4fkDOpIP/D7x2D0BuzOmqVhd8I9N+/qyGPbzUfvm
	 brBoSwTGRJxNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-rt-devel@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Handle percpu handler address for ORC unwinder" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:20 -0500
Message-ID: <20260301015520.1722542-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222190-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 460EF1CE321
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 055c7e75190e0be43037bd663a3f6aced194416e Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue, 10 Feb 2026 19:31:13 +0800
Subject: [PATCH] LoongArch: Handle percpu handler address for ORC unwinder

After commit 4cd641a79e69 ("LoongArch: Remove unnecessary checks for ORC
unwinder"), the system can not boot normally under some configs (such as
enable KASAN), there are many error messages "cannot find unwind pc".

The kernel boots normally with the defconfig, so no problem found out at
the first time. Here is one way to reproduce:

  cd linux
  make mrproper defconfig -j"$(nproc)"
  scripts/config -e KASAN
  make olddefconfig all -j"$(nproc)"
  sudo make modules_install
  sudo make install
  sudo reboot

The address that can not unwind is not a valid kernel address which is
between "pcpu_handlers[cpu]" and "pcpu_handlers[cpu] + vec_sz" due to
the code of eentry was copied to the new area of pcpu_handlers[cpu] in
setup_tlb_handler(), handle this special case to get the valid address
to unwind normally.

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/setup.h |  3 +++
 arch/loongarch/kernel/unwind_orc.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index 3c2fb16b11b64..f81375e5e89c0 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -7,6 +7,7 @@
 #define _LOONGARCH_SETUP_H
 
 #include <linux/types.h>
+#include <linux/threads.h>
 #include <asm/sections.h>
 #include <uapi/asm/setup.h>
 
@@ -14,6 +15,8 @@
 
 extern unsigned long eentry;
 extern unsigned long tlbrentry;
+extern unsigned long pcpu_handlers[NR_CPUS];
+extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
 extern char init_command_line[COMMAND_LINE_SIZE];
 extern void tlb_init(int cpu);
 extern void cpu_cache_init(void);
diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index d6b3688a1ce97..11ba3e4ac9eee 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -352,6 +352,22 @@ static inline unsigned long bt_address(unsigned long ra)
 {
 	extern unsigned long eentry;
 
+#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
+	int cpu;
+	int vec_sz = sizeof(exception_handlers);
+
+	for_each_possible_cpu(cpu) {
+		if (!pcpu_handlers[cpu])
+			continue;
+
+		if (ra >= pcpu_handlers[cpu] &&
+		    ra < pcpu_handlers[cpu] + vec_sz) {
+			ra = ra + eentry - pcpu_handlers[cpu];
+			break;
+		}
+	}
+#endif
+
 	if (ra >= eentry && ra < eentry +  EXCCODE_INT_END * VECSIZE) {
 		unsigned long func;
 		unsigned long type = (ra - eentry) / VECSIZE;
-- 
2.51.0





