Return-Path: <stable+bounces-194713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63FCC59239
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 18:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B4D4A1208
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDF4364038;
	Thu, 13 Nov 2025 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNwYyTXF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424F350A1C
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053082; cv=none; b=tSUTfRgaVjrH8GIqNdzAZZrTeu8RXHY3Z8nzl5SGic9WM1MlUlrFQuAI83WCS98oa8jlQtAFUX0aTJpyc83eK6ttPUnEjxStF9xlYWUc702T66TD4sCmDIW8kGKcDbN3k6r9pp0HHyy6m+vmPTEbXFCd9ETllrm2hkcGbRTHSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053082; c=relaxed/simple;
	bh=ZiKp3Us5TfvTTgd1Mf4tAnjULHF0j5L3K6g6yFU9xaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Fu1flwMnLTAF881IGAE/GS0z2h6TIaZmkfHnORNj1kFEgHLo0Hoas62ah55dwddkXGa31ctec6ykT1ZYBmeK1KrAi6x6C8BrrsS8XVn4rkTMJ+F2/c4o+x0s+mfSlOeZ2Ndwaxe6g+Wz+QgmxdK2QJU8AVHDjfD289ucRS1r+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNwYyTXF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297ec50477aso7587985ad.1
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 08:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763053080; x=1763657880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxY15pCig7ehzu17aXvbRYXDGqhdvK7v7ljoeGKcCTo=;
        b=ZNwYyTXFK0BQjG3oNVIXj5gNIAq+dZlBJ0UodhpxWijvws2JVy7R8LCKgFDHI4ka2r
         FwA5oRKmAb/t5SHj6evpBOrDrrooSByGs0KG/0dpR0Qo609wbqnGiwp42IWOcJIJ0P9e
         mrKvsYTDZCUcBwC0/GoH5OIDE8WOwyE4ZqzGiTH/1QeUsnExv+8aef5TGFEWCCZ0ixae
         pi2H8p9WvSvwQ9e/Pmp3hHGeLX9vRt676k9KYEuGpzPrb5mjBwmp+CMhna6BD4Idoq1e
         OYF7HCi3TBJ6+GQJp+PgnYJOfGu5jbM4yUH2n+VJzB+Rg1YQ/Dph3MdwzZ1QCHh16MC2
         jC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053080; x=1763657880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxY15pCig7ehzu17aXvbRYXDGqhdvK7v7ljoeGKcCTo=;
        b=Ju31USUFamyGSACwEX5GCFwNJ02znM5mPNLn86darKbfzRhyB7XRE8ga0zEZVEyJZh
         H7Ppquij9Un/lsJN+HwPrUFTLwDWn8kO5KMpQ8m+rHX/pKHkTMCypAwWzkq467sGDddK
         Bt4LSORk/krOxuwm3gQUuoW+oXsjtKP2sizko5V7p2AOJM5bcnCNj8YhTvg/ew+mVgXK
         zjh5IBm8PvgEM/M8YtH0d0/Y0nk4tFLumjnsgG+3ZsFakXyjzGGT3/FRhAGTl4mwRRZc
         5y9UsnyvLAWB+tbq9s4y5yUSKYDIe0GEInv6vLqecFfiecPfGa6IPvmOOK3bGiyJX4y8
         YP+w==
X-Forwarded-Encrypted: i=1; AJvYcCUYgydkYDbNd5GgRee0KiJUIRdHQ1ghVbnkJdDrigWeOEywkc/YOQmfitnoGA/pbqhIpeeTL/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Z+RtKDDOy2l1F05d1fp4rNmwvwC9Xw0jXLy+NeRfyShAC9hw
	AFXuWllQrB84gXfpQ0tdATgrHUXYZ1FNjr3zyV0/cLhPjwJ2hS6EqPvs
X-Gm-Gg: ASbGnctHajUTMDJHaO4Otn+Harpks2BO5c9s5/xAFdhzjO/ZOLlr47X0Znz3sknY+tS
	nr8WG/4N6qwOPZngpW1sTiLryYSTexqRjhrmpVqczIhSwC3ojjUDWGuyaaRYdnsasp26dLzPJ6J
	+xoaxr3T/EtZF5MAxyQLh9LsAuesm1TTUxb389MLqalXkdCxPlq36hTMylUou5yWE0ne40ywIKe
	U6FTPKp7M8eBCLz38MmHdmzcAlbzZABbcb5Z6jSrjiwe+/4HNzQHFBFVYQYmzr98ijfEZg7R0zZ
	2GR4lU30jsI6fSZldW2EguC0cURZOkxfSUvLcoPXyb0me/3JIoKmCUPXF0wAqC4DOnNaVNcnX4S
	wBIHi+y5grqQpRewqWInn5HGybmG9kSKAh7ghFxnjKjz3ukew1PjIlT/n9MalGo8+U/uPgSukSt
	SI/7q4Jl1J1A==
X-Google-Smtp-Source: AGHT+IFKvHsWJvixvb9dE5t25elHMEX4byG8bPdymodY2lyo4fBvJbAQGsfhsFXpYPribLfJpEaqgQ==
X-Received: by 2002:a17:903:b0e:b0:267:912b:2b36 with SMTP id d9443c01a7336-29867fd17b2mr2436545ad.23.1763053080234;
        Thu, 13 Nov 2025 08:58:00 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:648:4280:48f0::76e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccbacsm30488995ad.108.2025.11.13.08.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:57:59 -0800 (PST)
From: Vincent Li <vincent.mc.li@gmail.com>
To: mchun.li@gmail.com
Cc: Vincent Li <vincent.mc.li@gmail.com>,
	stable@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH] LoongArch: BPF: Disable bpf trampoline kernel module function trace
Date: Thu, 13 Nov 2025 08:57:57 -0800
Message-Id: <20251113165757.366865-1-vincent.mc.li@gmail.com>
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


