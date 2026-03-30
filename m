Return-Path: <stable+bounces-231014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHakJJwcymmu5QUAu9opvQ
	(envelope-from <stable+bounces-231014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:47:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0A35610B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A071A3004052
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 06:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36E9395D84;
	Mon, 30 Mar 2026 06:47:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EF36492D;
	Mon, 30 Mar 2026 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853264; cv=none; b=G6NhTClfYmvA1IrUwOaZnEnA+Uvj6Lp1w0rmwF8PdLzEmtNUBpyhVpQ+tFc/LWYTCqEiHkHI9XSfjCPUSruGGkit4ygZEUNHVYjSfyIyHVbQ3NJfdcCOk5EMoVsqY/aGTaKK+9UX/plQZzVwXujd3sRzohKf9Qapj0SbXCw9i+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853264; c=relaxed/simple;
	bh=l7TwGuTLtOsnks53RDzg4uNEc15Nexfo8Rjzx/NI1YY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YUmg6o+Hq+YrDi6493ggKPrMVoV1jqM2wLID7af4Quy0rxVcU5N/9zkUw/MSueGtpMTRfQWSpCyg5YHximUHFXkeTC70P5b9GY6YkD8pKDLUmzI9jWWEX9obfsPGvJG8+h7J/8+YNcgNkCbM/G53UzhgQbjVu+p87X0+8kNyKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowAA34Wx_HMppusGcCw--.2032S2;
	Mon, 30 Mar 2026 14:47:28 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Mon, 30 Mar 2026 14:47:15 +0800
Subject: [PATCH] riscv: misaligned: Make enabling delegation depend on
 BROKEN
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-riscv-misaligned-dont-delegate-v1-1-68b089b306c3@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAHIcymkC/x3NSwqEMBBF0a1IjbsgbcBPb0V6EJJnLNAoKRFB3
 LvB4Znce5EiC5R+1UUZh6isqeD7qchPLkWwhGKqTd0Yaw1nUX/wIupmiQmBw5p2DpgR3Q62fuw
 73zaA6ahEtoxRzncw/O/7AZTxU/lwAAAA
X-Change-ID: 20260330-riscv-misaligned-dont-delegate-3cf98c76ee08
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Songsong Zhang <U2FsdGVkX1@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID:qwCowAA34Wx_HMppusGcCw--.2032S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kuw4xXr13Xw1DAry5Arb_yoW5CryDpr
	WUCFs0grWUJrn7ZFWSq3s2gF45Z3s5Gry3Gr42q34FkFW5ZryxZrZ2qry7XFyUGr1kX3y0
	9Fyakr109Fy5Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFylc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjfU8D7aUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231014-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 80D0A35610B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The unaligned access emulation code in Linux has various deficiencies.
For example, it doesn't emulate vector instructions [1], and doesn't
emulate KVM guest accesses. Therefore, requesting misaligned exception
delegation with SBI FWFT actually regresses userspace and KVM guest
behavior. Until Linux can handle it properly, guard these sbi_fwft_set()
calls behind RISCV_SBI_FWFT_DELEGATE_MISALIGNED, which in turn depends
on BROKEN.

The rest of the existing code proceeds as before, except as if
SBI_FWFT_MISALIGNED_EXC_DELEG is not available, to handle any remaining
address misaligned exceptions on a best-effort basis. The KVM SBI FWFT
implementation is also not touched, but it is disabled if the firmware
emulates unaligned accesses.

Cc: stable@vger.kernel.org
Fixes: cf5a8abc6560 ("riscv: misaligned: request misaligned exception from SBI")
Reported-by: Songsong Zhang <U2FsdGVkX1@gmail.com> # KVM
Link: https://lore.kernel.org/linux-riscv/38ce44c1-08cf-4e3f-8ade-20da224f529c@iscas.ac.cn/ [1]
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Clément: Sorry to call what you did broken, but it really is breaking
on real hardware out there. I think this is the right way for now.
---
 arch/riscv/Kconfig                   | 14 ++++++++++++++
 arch/riscv/kernel/traps_misaligned.c |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 90c531e6abf5..8ad1f13c170e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -941,6 +941,20 @@ config RISCV_VECTOR_MISALIGNED
 	help
 	  Enable detecting support for vector misaligned loads and stores.
 
+config RISCV_SBI_FWFT_DELEGATE_MISALIGNED
+	bool "Request firmware delegation of unaligned access exceptions"
+	depends on RISCV_SBI
+	depends on BROKEN
+	help
+	  Use SBI FWFT to request delegation of load address misaligned and
+	  store address misaligned exceptions, if possible, and prefer Linux
+	  kernel emulation of these accesses to firmware emulation.
+
+	  Since the Linux kernel's emulation is incomplete, enabling this may
+	  cause unexpected userspace and KVM guest crashes.
+
+	  If you don't know what to do here, say N.
+
 choice
 	prompt "Unaligned Accesses Support"
 	default RISCV_PROBE_UNALIGNED_ACCESS
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 2a27d3ff4ac6..81b7682e6c6d 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -584,7 +584,7 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
 
 static bool misaligned_traps_delegated;
 
-#ifdef CONFIG_RISCV_SBI
+#if defined(CONFIG_RISCV_SBI_FWFT_DELEGATE_MISALIGNED)
 
 static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
 {

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260330-riscv-misaligned-dont-delegate-3cf98c76ee08

Best regards,
-- 
Vivian "dramforever" Wang


