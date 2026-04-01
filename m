Return-Path: <stable+bounces-232645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACPRM8d6zGkbTQYAu9opvQ
	(envelope-from <stable+bounces-232645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:54:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3883D373944
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C4E330247C5
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 01:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF80027EFF7;
	Wed,  1 Apr 2026 01:53:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393EA1BF33;
	Wed,  1 Apr 2026 01:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008415; cv=none; b=h8/1nD1DI9E3FDV5w3mk9IhYJGHl/om1Pumc1ClOlfVupnFOXuGFr/I+FcHL3+mIYHkYOh4oUtljTO/nj40FoJ0PmWSUfW9ils1OWQM/jhgXuWkPIN9bwWyVBWpreAxB3wjPAucDNZhOAvRqNj6nZyAejOxfgoHFByRWRL3K47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008415; c=relaxed/simple;
	bh=oVfTxME1W9wyIGFJeOjjftOvbABzg/kDJGWnopM7ZN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q7hvr+xPCezqmC2H+qZyH0zcdjD4jW+5YhOLEf9f1kAOifKHLX/EBmzrUGdait9YI+NCygAOYNxTD0znOexCi+cASRB0Mrd5XQEBtrWKJtCYNetmEz+c7SkhGPeWRKVwKNZCw/PXvKeEXvLIti/tyZKqaK3VQQUdjdXOS0T/6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowACH826Oesxp41nPCw--.8410S2;
	Wed, 01 Apr 2026 09:53:18 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 01 Apr 2026 09:53:17 +0800
Subject: [PATCH v2] riscv: misaligned: Make enabling delegation depend on
 NONPORTABLE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-riscv-misaligned-dont-delegate-v2-1-5014a288c097@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAIx6zGkC/42NQQqDMBBFryKz7kg0kMaueo/iIk5GHbCxJBJax
 Ls39QRdvs/nvR0SR+EEt2qHyFmSrKFAe6mAZhcmRvGFoVWtUVorjJIo41OSW2QK7NGvYUPPC09
 uY9Q0dpauhllZKJJX5FHeZ+DRF54lbWv8nL3c/Na/1bnBBo0dlO0GrQzpe/m7VDuqKUB/HMcXf
 y7eus4AAAA=
X-Change-ID: 20260330-riscv-misaligned-dont-delegate-3cf98c76ee08
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Songsong Zhang <U2FsdGVkX1@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.15.0
X-CM-TRANSID:qwCowACH826Oesxp41nPCw--.8410S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kuw4xGw4rGr43CryDZFb_yoWrXF47p3
	yUCFs8KrWUGrn7ZFWaq392gF45Wa95Gry3Gw43t34rGFW5Zryjvr92qr47XFyUGrykW348
	uFyakFy09Fy5Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_KwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUCFAJUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232645-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.infradead.org,vger.kernel.org,gmail.com,iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.786];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 3883D373944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The unaligned access emulation code in Linux has various deficiencies.
For example, it doesn't emulate vector instructions [1] [2], and doesn't
emulate KVM guest accesses. Therefore, requesting misaligned exception
delegation with SBI FWFT actually regresses vector instructions' and KVM
guests' behavior.

Until Linux can handle it properly, guard these sbi_fwft_set() calls
behind RISCV_SBI_FWFT_DELEGATE_MISALIGNED, which in turn depends on
NONPORTABLE. Those who are sure that this wouldn't be a problem can
enable this option, perhaps getting better performance.

The rest of the existing code proceeds as before, except as if
SBI_FWFT_MISALIGNED_EXC_DELEG is not available, to handle any remaining
address misaligned exceptions on a best-effort basis. The KVM SBI FWFT
implementation is also not touched, but it is disabled if the firmware
emulates unaligned accesses.

Cc: stable@vger.kernel.org
Fixes: cf5a8abc6560 ("riscv: misaligned: request misaligned exception from SBI")
Reported-by: Songsong Zhang <U2FsdGVkX1@gmail.com> # KVM
Link: https://lore.kernel.org/linux-riscv/38ce44c1-08cf-4e3f-8ade-20da224f529c@iscas.ac.cn/ [1]
Link: https://lore.kernel.org/linux-riscv/b3cfcdac-0337-4db0-a611-258f2868855f@iscas.ac.cn/ [2]
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Changes in v2:
- BROKEN -> NONPORTABLE (Conor)
- Elaborated the config help text (Conor)
- Add one more breakage report link
- Link to v1: https://patch.msgid.link/20260330-riscv-misaligned-dont-delegate-v1-1-68b089b306c3@iscas.ac.cn
---
 arch/riscv/Kconfig                   | 22 ++++++++++++++++++++++
 arch/riscv/kernel/traps_misaligned.c |  2 +-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 90c531e6abf5..56a4fad9b7c2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -941,6 +941,28 @@ config RISCV_VECTOR_MISALIGNED
 	help
 	  Enable detecting support for vector misaligned loads and stores.
 
+config RISCV_SBI_FWFT_DELEGATE_MISALIGNED
+	bool "Request firmware delegation of unaligned access exceptions"
+	depends on RISCV_SBI
+	depends on NONPORTABLE
+	help
+	  Use SBI FWFT to request delegation of load address misaligned and
+	  store address misaligned exceptions, if possible, and prefer Linux
+	  kernel emulation of these accesses to firmware emulation.
+
+	  Unfortunately, Linux's emulation is still incomplete. Namely, it
+	  currently does not handle vector instructions and KVM guest accesses.
+	  On platforms where these accesses would have been handled by firmware,
+	  enabling this causes unexpected kernel oopses, userspaces crashes and
+	  KVM guest crashes. If you are sure that these are not a problem for
+	  your platform, you can say Y here, which may improve performance.
+
+	  Saying N here will not worsen emulation support for unaligned accesses
+	  even in the case where the firmware also has incomplete support. It
+	  simply keeps the firmware's emulation enabled.
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


