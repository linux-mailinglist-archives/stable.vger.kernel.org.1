Return-Path: <stable+bounces-194716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF9C591F7
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 18:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9BE424183
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0FA2FBDE3;
	Thu, 13 Nov 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agw4EO6E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D652FC861
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053635; cv=none; b=TEC9Mpga0/1ZvCJSb765ciwMJaRnyAHPTBIQQHkfBvCjgqx/LBYXGCBGDNG/AX1FGxQqrk23XMfIXHp7iekZNTvLUrIBnBbR+eM7jMD2NHqoTiuJ7pXBQ8AeQ8O3iu8E4vaVpSr3+0IgJnqiNgmRrk9BfF702IGL1JHhiaLhFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053635; c=relaxed/simple;
	bh=eIDJr2pEA2DRlPLQjPs6NNGihwqlyDxmUFqdN1+Zr80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i2Df2EvH8q0WV3jqTaHT3GS5aVZohMn7UP7QK4oiaehGjf5c95xiUpr2CMJC1b9wqx5tBdlYAFdY+aehu4grI2bkBll1SKa5goKwW25TW5wDR+8M48cQi0joJVSd7InvvFj8FNNRWy3vLAzXYyzZggYLz/wLFtwHenvba32nUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agw4EO6E; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aace33b75bso982807b3a.1
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 09:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763053633; x=1763658433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKwZSMmGzUdanwCTT7PnADQTRL8j3tcNkt4rj2Q3WSU=;
        b=agw4EO6E4L6hOmTbmJo1KlrFpPgsnrs6Gw80yf3fQjlpjnpjNhVAB7jT6swm/whUA5
         SZ4mY9XoVxABr3dP0yZKxJphUatoLDlMg+rb4N8R3mE4waHo1wr4UIaiqbwzM4d62Ff3
         hVoKzCYaAhzfnjx86Sjijx3XDES5EWIoa27KbifTcsVPA/EIlPIx0HxlI0FO+D3iBgwM
         WTecegNQil8kAf7qOCZrVP52xw6XvrRiJrwpXK9a1obqkVGrqt62HNePou2PLl6LrD7q
         cfaEf+A8WUhGWvOOFk5MKMolI5AciIFCuIz8blpEnsE2biv8gQbyxnFL9xl2Vj75AN4o
         YPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053633; x=1763658433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKwZSMmGzUdanwCTT7PnADQTRL8j3tcNkt4rj2Q3WSU=;
        b=NMzcxuaJh1oeKDwltc1UsjsfmLY8Kpd6fTRVbLhRmbTrBmlEzTp+ZYOzZJm2EdO5RZ
         OV1oSdVKPokhgWLlqEnjPCWTfDufPWT0Ox+hrVfHmv54iE+OBCMahJ++bzJwzB+ws5IV
         UkkdHMdud8OHSntzhoadCcIhVB5l48WgfGyBgx+Tps/u59u0+9smo9A6dA3UA/wox8pH
         J5RwNtXbtp7yI+uZJ4u75679pvSty1NgPvQ7/nt7FkzWkfQE423iA3vf9D3vEnhXhnRg
         9EisTY0M5+wXIr+zzMCr0yS4Lk/4PEFU50M0vviyxgm2A70Tc9fsOrxAwHl3uFmMlKwv
         /1IA==
X-Forwarded-Encrypted: i=1; AJvYcCXMHL110CPeCZBhVcWdckFy+BVYkLTu8yR4q107ye43mtMXrka9JNtT1H/KSHeum33sTPJZ+7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEGSfwgY74/VRJHiqeflSpqAttsURJkpBhIMUJ+PtxQlkC4+T
	dLWw+3ctEXLatUKGODKaLv5ZKPaijxHBTxg/023HJgzy3wTEmijNa+lsABUhwQ==
X-Gm-Gg: ASbGncvLAfpaMmvHR4NQnFY3ymDZklYeDr8xWVj4oKCrkdARR+Rth47CGR7dX+u67hX
	r2gjBI7F/zE/+PEr6UG9fLHlnjBqufuYgiBwxjOfI4e+jXaAW9gWTsgc32KrZhUj+W0pP0RjJmI
	XyLNOYhhoSFwbmchp1BuOvfTn5rNX3wQ5Xxur6n9bLa3zPQZk6Mg70vjRbyTUY99Y2r+PEuJnoC
	vu31oCfGnvv1fVqrJ44ZM+D4FBF0SmlszExKzteCfLJeAzWcRdBk6Bxdl7z1vXig1NOrbb/x7iX
	q6SD+I03LZtiKfpkx4DZQuNXTO5Atxh5PQ7gaN3lblt6bMmz21HdPiEN0f7NZQmC5eMOvJXqPob
	udNyFYWteOKyFVuuml3x47aOh9sLRlwTeC5kDgw2NG6grFEWi1jupNpmBG70NNp8jX/1oLplKdf
	Rzyx7MFVbaew==
X-Google-Smtp-Source: AGHT+IEfUMMtqB0bhkhL0gj5Ig+FeOUTrhBZAFyF9owq3FJPGQALfGZUkSO+nlRFF81/4Zl757VY9g==
X-Received: by 2002:a05:6a00:9a9:b0:7aa:a2a8:980f with SMTP id d2e1a72fcca58-7ba3b4ab38bmr229629b3a.20.1763053632940;
        Thu, 13 Nov 2025 09:07:12 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:648:4280:48f0::76e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e713sm2770885b3a.54.2025.11.13.09.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:07:12 -0800 (PST)
From: Vincent Li <vincent.mc.li@gmail.com>
To: Chenghao Duan <duanchenghao@kylinos.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev
Cc: Vincent Li <vincent.mc.li@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] LoongArch: BPF: Disable bpf trampoline kernel module function trace
Date: Thu, 13 Nov 2025 09:06:51 -0800
Message-Id: <20251113170651.367092-1-vincent.mc.li@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current LoongArch BPF trampoline implementation is incompatible
with tracing functions in kernel modules. This causes several severe
and user-visible problems:

* Kernel lockups when a BPF program is attached to a module function [0].
* The `bpf_selftests/module_attach` test fails consistently.
* Critical kernel modules like WireGuard experience traffic disruption
  when their functions are traced with fentry [1].

Given the severity and the potential for other unknown side-effects,
it is safest to disable the feature entirely for now. This patch
prevents the BPF subsystem from allowing trampoline attachments to
module functions on LoongArch.

This is a temporary mitigation until the core issues in the trampoline
code for module handling can be identified and fixed.

[root@fedora bpf]# ./test_progs -a module_attach -v
bpf_testmod.ko is already unloaded.
Loading bpf_testmod.ko...
Successfully loaded bpf_testmod.ko.
test_module_attach:PASS:skel_open 0 nsec
test_module_attach:PASS:set_attach_target 0 nsec
test_module_attach:PASS:set_attach_target_explicit 0 nsec
test_module_attach:PASS:skel_load 0 nsec
libbpf: prog 'handle_fentry': failed to attach: -ENOTSUPP
libbpf: prog 'handle_fentry': failed to auto-attach: -ENOTSUPP
test_module_attach:FAIL:skel_attach skeleton attach failed: -524
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
Successfully unloaded bpf_testmod.ko.

[0]: https://lore.kernel.org/loongarch/CAK3+h2wDmpC-hP4u4pJY8T-yfKyk4yRzpu2LMO+C13FMT58oqQ@mail.gmail.com/
[1]: https://lore.kernel.org/loongarch/CAK3+h2wYcpc+OwdLDUBvg2rF9rvvyc5amfHT-KcFaK93uoELPg@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: f9b6b41f0cf3 (“LoongArch: BPF: Add basic bpf trampoline support”)
Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Vincent Li <vincent.mc.li@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index cbe53d0b7fb0..49c1d4b95404 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1624,6 +1624,9 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	/* Direct jump skips 5 NOP instructions */
 	else if (is_bpf_text_address((unsigned long)orig_call))
 		orig_call += LOONGARCH_BPF_FENTRY_NBYTES;
+	/* Module tracing not supported - causes kernel lockups */
+	else if (is_module_text_address((unsigned long)orig_call))
+		return -ENOTSUPP;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		move_addr(ctx, LOONGARCH_GPR_A0, (const u64)im);
-- 
2.38.1


