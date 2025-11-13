Return-Path: <stable+bounces-194714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085CDC5932C
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717233BC9DE
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57AD357A56;
	Thu, 13 Nov 2025 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9Qavfly"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0836A022
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053314; cv=none; b=fdGGozE/li3FgNaTzXsO2T3yqqg1c+4AcAcoO886uDbPkfiGMsxhdNySaUbW6gAzyJcMQqXZ0tdb4wn98h7KQmwa0TEv8Ajalx8zl+DHLT5T1293N3pVH2iOxcj4kqC9GlgGmE2fmH3Eu0ZByQEZ4n3uW13gCtIAz6IYjFzqUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053314; c=relaxed/simple;
	bh=ZiKp3Us5TfvTTgd1Mf4tAnjULHF0j5L3K6g6yFU9xaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QPFevgWegi6/ssr8dFz7RfU+S97rzyBY2tvSAC7rrjWf4BlGXViT/IOOZAopef1N1x1ib1/Mn3LcOKg1g1ucyN7Kr2k64lHakevr9KplX0cFIzAHVxNOgRQ1i5OWUUVPwDd377Nbf0/GvsBqxQKj3NlSQarWajG/eXvaOD4s+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9Qavfly; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7af603c06easo1216720b3a.0
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763053312; x=1763658112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxY15pCig7ehzu17aXvbRYXDGqhdvK7v7ljoeGKcCTo=;
        b=b9QavflyinWOwFadYX/E7GROsJx4W6GoRuH5iXG6VnTIa51hKfa6Gtt/g2hos8mln7
         xXFWtIJPz2PQMrqpdvv9yKBRuamD7lHPFRnw8WfATehQCbbxbxxsZ8fFGDjPj1qEUBZr
         BL52QoJndfaa1AWG/Jq9DhlU2RVdH7fPP6Qi0UZkgU4scUytLH5oG+xSFwz4r5zxg6Ni
         KFzpxfJxnbrlK2jW7r4UeNEpPars/9OvKShNGrZpOGLy6aG0DATFEFn0+6quh20SI6sp
         k/hSFeE0xiC3cgQTg+Lx0W68yErTNbX1Zq489v1IyPYxbgWkJE0setB1ELbtikykZD9C
         3qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053312; x=1763658112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxY15pCig7ehzu17aXvbRYXDGqhdvK7v7ljoeGKcCTo=;
        b=PejhhQU4QUkguU5jTGObwKo06a9ACgphL3t1BPnyIwws5XNdvKKDJ6qwp/xo6PQUDD
         eArqegOv2E3TT0vx/c6rHp+FR9syRFEg0ocACXGbJ7CtFd88yBB2qDx7kdzzsnMv0+H7
         0JVb9wa16vCa/PQC6fOqEyefceVL9tHTLsxZ83RWM/79TM0gSXjWUKZ5R0qv/ZrxIUY7
         urkol5IDUljYLrAT9pMCeo6VzO3XTTFr9vDYe5CRPnASZZt2WuBJ9VEOeFMpcGlmUNXq
         TnPEF/sof82UXA9rlXd9D1zEwRgR2kSNcKGYyhFPYi09viZr4P12CHGgt2xRshr1dudD
         9ePQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3p3r3wAwEZ1SazV326/6wup+7FaeItesC1R6C7194NVpszdDEvliytSOj3ICltXoGm1O6Lqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6ljkDP/8iXA2qJbxSxtdPaFltTModxag+DerTLgFtve2DzfU
	7V6ezZWOXu9rnH+U6gdg4Qoe+zq++9w46Bkc37l9eBlbcd+il3jkD9xX
X-Gm-Gg: ASbGncuWVpeH9KLuD4p0UcCxOh9Vh6QhY10W5XBt5CdGmU4tc7hR+6YJs3N2DdII/aK
	2vigaVOmmYZw+EqE0UKV+sqERN/fD4bfvO9x2+2eBnfkJ/gl26ybT7VsEnzHI6oJZAF2ON60OVG
	iqrxAr5aOrp5s26vevK8nDsD5sSGp3JEZM0K9oQml9gSsy81q9oOu6BiFMcfMTtrfxB9Zzdf0mg
	SyPuQfekBNfYucPQkVB9htPbUmbVLSMhaQiKEDJWtsVeluGni7PtGMtOZPut4jXqExWN1MG9hwU
	yrWs78Qy1eKEE+VubwZ1Ion6t+1m8Ucogn1GyBqd9mlnjw1vHvPRo5kV7te2Uv+st3VE9N73wFP
	eKQ0d44m2gO5vT1u6g2C94VejkufliG20PABrasfamwlCzWuHH/i72q+9bgOujANbZmjQwqKXkt
	216LAp0eIqMw==
X-Google-Smtp-Source: AGHT+IGHBCTA22PDjAYfk5F3dMeRziKsGaI8zOSPtysXvoJjOXCGB27DDq1/mTB72CYpKftTUF9M1w==
X-Received: by 2002:a05:6a00:9519:b0:7a9:d8a8:992a with SMTP id d2e1a72fcca58-7b8e1981001mr4276049b3a.13.1763053311528;
        Thu, 13 Nov 2025 09:01:51 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:648:4280:48f0::76e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924ae6943sm2869007b3a.6.2025.11.13.09.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:01:51 -0800 (PST)
From: Vincent Li <vincent.mc.li@gmail.com>
To: mchun.li@gmail.com
Cc: Vincent Li <vincent.mc.li@gmail.com>,
	stable@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH] LoongArch: BPF: Disable bpf trampoline kernel module function trace
Date: Thu, 13 Nov 2025 09:01:49 -0800
Message-Id: <20251113170149.366989-1-vincent.mc.li@gmail.com>
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
Closes: https://lore.kernel.org/loongarch/CAK3+h2wDmpC-hP4u4pJY8T-yfKyk4yRzpu2LMO+C13FMT58oqQ@mail.gmail.com/
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


