Return-Path: <stable+bounces-95890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83069DF35A
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 22:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F242162D50
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 21:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662FB1AA1FB;
	Sat, 30 Nov 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="s88kO2yd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/y39pAy"
X-Original-To: stable@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FE8468;
	Sat, 30 Nov 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733003270; cv=none; b=OSvsCGRuop2aKRQkE1MOHnL+Go3gJkN2QjfL2iNwAYliPsXGdO7EfcRRT0sSj/zrNNpJBgShWS8NULI1G+ygoXIwlCYzo9vRXaW1Onnn4wJyOB7nXza5DXsQOEiS8K/1qeZ0wgC/MrfFj/ljV1XSEWDi7dq0kIo4rANQ5zFW4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733003270; c=relaxed/simple;
	bh=tgFlapvT7VwQsZiO6n4iEi3XFX6DBlZjgTPZF2GhaDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TcHQMDt7avlqe0cToxPe+mm3z+MQ1jsUvAIegRmI/NFZjz1jH4KDnc/zqbKOVFqzwlT2O82Ysuf4RIpwWjbpuV5YKqcbGbsT3rMyDLJbvhtu1nejjOmjgXzxNEUUY8HX1aj961PQmVDw9o4Kt+RVZZH+14P9K7CAxGqMkfw/Bwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=s88kO2yd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/y39pAy; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id AE3CC2004D6;
	Sat, 30 Nov 2024 16:47:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 30 Nov 2024 16:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1733003266; x=1733006866; bh=Ug6noMxJx4D0HoGkjMXTBxp/QR93meFj
	QxG2sTCVytQ=; b=s88kO2ydw0gUoGi6fFxuPvR48rCYB3tFg/sjJaKqsyrIc3fd
	gnXoRVp6n3e3b5NgXRiXawcjxmyVHctiNpDX4KoxOn97RTWUK8vjdfz15oFCDbAq
	VpRbtESgpl2t6uNSEbLtPNWS+7KBMX0bWs2FR6aJHXBjX/O9t3/OLmK8TUipYgT4
	cWC4YpjG1PyTKpS4GpDlJ3nFfjffP95ZLOdw9dk6JMVF9SvClSMfzHqUH+tzuZhD
	eg0781XkO51wBjQTzG1rEyc3JdKQzRzcomLehnPf9WH+oBY9H1vU714Uy80cEicV
	83vJhNQEcyiLuY84gw9U5uJje0OL4Vo8xUX0hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1733003266; x=1733006866; bh=Ug6noMxJx4D0HoGkjMXTBxp/QR93
	meFjQxG2sTCVytQ=; b=g/y39pAydNgDkiGRZAQbYD5gYCCvFAB5Ija8HT/8PLr9
	otNL/G+UlSvp3vDkKxY1DjfG/TVqjUPMNNAtlHDUChfxgb8JA0jryLtOfLO3Yyne
	x1l4NmhVHGU4sgqtNYLayVXp2QEH8PStVP/hktZHdCKHkGFaf5lchQA2EUf+KkZs
	bYE3qQZWJsL5xj50QzblhXYunA4PSbI58hWbKSePiFHcofAe/dxicya1+D616hok
	+UFu7+4OuTJPLDq+DLbT6HATHGika7XxEOXmd4B/ECru2FLfs0s0ItkAN6+n/BSU
	rFJb8TKPyinCtffcSMDXGEpaSTm+xeok4RY0D81Q8Q==
X-ME-Sender: <xms:_4dLZ7AkowSsgEKX5WlTd9qkkDkkNQENdt8I-XLbgNfwWnTMQ8V9lw>
    <xme:_4dLZxjbokabgT_HfRgCt8ByjWmFgvWiTcoP_8kARMpAjXv70zQzyHtk7RKf3Wev6
    WgjMe5Mhfn3gMhwXOQ>
X-ME-Received: <xmr:_4dLZ2kxryVu1S3PKbaWUF2_MUIfkVpPMUhsrKUvGlF2D8AqjbiPavTjBaNIWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheehgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecu
    hfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuhhsrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepjeffleetjeeigfehfeeghfdugedtjeekledu
    heetudejffdtveevueeuffejfeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihusegt
    ohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopedvfedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhr
    tghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopeholhgvghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhu
    ohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhiqhhisehishhrtgdrih
    hstggrshdrrggtrdgtnhdprhgtphhtthhopehufihusegtohgvlhgrtggrnhhthhhushdr
    nhgrmhgvpdhrtghpthhtohepiihihigrohesughishhrohhothdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopegvsghivgguvghr
    mhesgihmihhsshhiohhnrdgtohhm
X-ME-Proxy: <xmx:_4dLZ9zLq1Fc35MwqNxMX-c9o-ZJ3TXvvlzphSm5U1GMUZAZJXnLCw>
    <xmx:_4dLZwQ5YRLMkzkZ20rb6u7oqwJlJZ3VRovcqED8mWotxWcgn4gBMw>
    <xmx:_4dLZwZ7NbX5bQLW-Kh3_vkoHCnl43FmyIZD22jGYnIVYAd3OvVrjg>
    <xmx:_4dLZxRXckSL8v1n_RPxk_NxdKlL7rosEdxrOVcUsbycqC2yrz0J2g>
    <xmx:AohLZ5Qz8JKjHzyVraZXD67Pqg1EqfEc3fdN-jXqT-lX7P8CvSXNz6e9>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Nov 2024 16:47:42 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Sun, 01 Dec 2024 05:47:13 +0800
Subject: [PATCH] riscv/ptrace: add new regset to get original a0 register
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name>
X-B4-Tracking: v=1; b=H4sIAOCHS2cC/x3MMQqAMAxA0atIZgNt0KFeRRzUxpqlSiIqiHe3O
 L7h/weMVdigqx5QPsVkywW+rmBex5wYJRYDOWo8OY8qNp+Y+ULlZHxgbClMoaUxuggl25UXuf9
 lP7zvB7f1anFiAAAA
X-Change-ID: 20241201-riscv-new-regset-d529b952ad0d
To: Oleg Nesterov <oleg@redhat.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>, 
 Andrea Bolognani <abologna@redhat.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, 
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, 
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, 
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, stable@vger.kernel.org, 
 Celeste Liu <uwu@coelacanthus.name>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3224; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=tgFlapvT7VwQsZiO6n4iEi3XFX6DBlZjgTPZF2GhaDs=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGdO/27+ejT67U17uYOJXz/fmPjJbrjI9p7nS4Ghh+I
 OvZwwgJVqeOUhYGMS4GWTFFlrwSlp+cl8527+3Y3gUzh5UJZAgDF6cATOTCe4b/mc2h98Ufndho
 syS/aQlXObP6vhNPbXcoqUzXOZr2OXAnB8P/4kuX7G7s7O9s/NO72mx2j+n+jpB2o1bBCWsCbxg
 vF9nGBwChJ0wk
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

The orig_a0 is missing in struct user_regs_struct of riscv, and there is
no way to add it without breaking UAPI. (See Link tag below)

Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
access original a0 register from userspace via ptrace API.

Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
 arch/riscv/kernel/ptrace.c | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 34 insertions(+)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index ea67e9fb7a583683b922fe2c017ea61f3bc848db..faa46de9000376eb445a32d43a40210d7b846844 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -31,6 +31,7 @@ enum riscv_regset {
 #ifdef CONFIG_RISCV_ISA_SUPM
 	REGSET_TAGGED_ADDR_CTRL,
 #endif
+	REGSET_ORIG_A0,
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -184,6 +185,30 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
 }
 #endif
 
+static int riscv_orig_a0_get(struct task_struct *target,
+			     const struct user_regset *regset,
+			     struct membuf to)
+{
+	return membuf_store(&to, task_pt_regs(target)->orig_a0);
+}
+
+static int riscv_orig_a0_set(struct task_struct *target,
+			     const struct user_regset *regset,
+			     unsigned int pos, unsigned int count,
+			     const void *kbuf, const void __user *ubuf)
+{
+	int orig_a0 = task_pt_regs(target)->orig_a0;
+	int ret;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &orig_a0, 0, -1);
+	if (ret)
+		return ret;
+
+	task_pt_regs(target)->orig_a0 = orig_a0;
+	return ret;
+}
+
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -224,6 +249,14 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = tagged_addr_ctrl_set,
 	},
 #endif
+	[REGSET_ORIG_A0] = {
+		.core_note_type = NT_RISCV_ORIG_A0,
+		.n = 1,
+		.size = sizeof(elf_greg_t),
+		.align = sizeof(elf_greg_t),
+		.regset_get = riscv_orig_a0_get,
+		.set = riscv_orig_a0_set,
+	},
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b44069d29cecc0f9de90ee66bfffd2137f4275a8..390060229601631da2fb27030d9fa2142e676c14 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -452,6 +452,7 @@ typedef struct elf64_shdr {
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NT_RISCV_ORIG_A0	  0x903	/* RISC-V original a0 register */
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */

---
base-commit: 0e287d31b62bb53ad81d5e59778384a40f8b6f56
change-id: 20241201-riscv-new-regset-d529b952ad0d

Best regards,
-- 
Celeste Liu <uwu@coelacanthus.name>


