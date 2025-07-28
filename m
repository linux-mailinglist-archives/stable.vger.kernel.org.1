Return-Path: <stable+bounces-165016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA5AB143B2
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 23:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2AA3BCFC9
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892E23535F;
	Mon, 28 Jul 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUFimcyN"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C721A426
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736676; cv=none; b=Py0S4dvSBW2JcTKQHXNnqj2E7ALg1izlyL+7oq80V6Z5Tv76RhGBk8igUAxchaEpfEQFwfq+juSKOBZjowQpItGdt7M/hEBGDl4aw8uHAkEJj4k+HEgm72Pom57aBkYxgvbDzijukrOpc+V6KpzHzPncm9Xsw/WlvMrx6qqnGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736676; c=relaxed/simple;
	bh=zFb2Oa6g6C1AFnPxXLdZtpXeNv9w6hxscbJigmNdpCg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=daWqn9X0lVrCb16OEZSmfxVdvHYUF/O5OQxS/PlEBW7qgmFViGT6t7+2iam1cdsOuUOFX1Ogtw+XT3y6y2ccEKjz0RKIUVmdaWKNihPPqGUp4XRLZPh3aZt5aGsOnr686oygsabW746BHmKGJERHinLQenCxckSW+pfiTBkxocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUFimcyN; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3e3d462b81cso21875095ab.3
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753736673; x=1754341473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g2HkGuPdjC+GNCrApZe3pzlcGnX64te3qygbh3oqdwo=;
        b=HUFimcyNttiR97bMM+Bvvn59xVZ9vfwJ+RbkO/TIcdaXrTRdWXZQyMPUmyMCAQyasV
         jM5cSBoK+4vvWaqbFYwJHAvbRl28IitbOUSrKYICBI+eQnJXCeMGqiduFCQWGqMrtLJB
         lpffhEgs+k14qHNW/RVy6ZOAKUDN29iRiXKiaYyXV9T84RCauNbKUe9my5EypdMYaXgF
         51frSdAm9LXE1B6OgCnuIf8TM1DHl07Lm0vrQipmLj3LWpRwdmvbxDgRiwDhb/Q9xArp
         nMEIw1o2klW//oFTf9KCZUP9teZ6Av7vWQrX+qHI30uN3n/RF66i4sKNd7mdXVJqsaU+
         qeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753736673; x=1754341473;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2HkGuPdjC+GNCrApZe3pzlcGnX64te3qygbh3oqdwo=;
        b=u3v6g5v4NCQp7BfvXWfM48v/oUrvsQYRFAtPNaeebCcvSi0nS8K7hJOAaUA+vUYmfr
         T0XZMnIX2mL0F+3p1dABw6t9lqzk9SVQwJW9GEi92IZ0kNRAcVmbL8drsveXBR++65M3
         faU8/C8wBWXcjGcv64s+v7NKPwbOhllxpAZFMihBVfcfHre2pcyypWxTxQ2okO47BX4S
         GQJ2XOq2hxCtYlSg/0vcBs+bUfGkJjhZWEPhF6uJ5+JxhO5Eeu+g1qvmBiVnbmFWCPX3
         J1zi+6tsZealrbgB/jYnRQhkJKwY51Ow7xqgV9kr03oDeU4O84PLgx3A38VODX6K4eq3
         andg==
X-Forwarded-Encrypted: i=1; AJvYcCV/2Ibfai93mYjqZ3Nih7P7b9c15SR+KpPrWBY1DH4hozPZdigl3BiLKEhNknu63xBMJw5zaws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLyvaAcII5U92fknsSIP//0+8YWINGGwnewfjq2S5q4ht3Ausc
	n9yuGGzcGhvBjQiSxc1o3lKAu2FBj0qU1JT1LBPTEy+gl3MGuJ9nNCnwU9fn5Mr7YjHCuRT/JoH
	OLB+CtDhqwiz9sNmZtuZVSoQddA==
X-Google-Smtp-Source: AGHT+IF3ElRNmNEgLOiZ+XFI0ik5ZaJq9q7/NhwGFbXXUTCuR7C+nhEBtW4V6iPFUdR2A3KToowq+hl+CNEjc4UEBw==
X-Received: from ilbbu29.prod.google.com ([2002:a05:6e02:351d:b0:3df:2bc3:4c40])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:19ce:b0:3df:3bc5:bac1 with SMTP id e9e14a558f8ab-3e3c5250ebdmr229349785ab.5.1753736673097;
 Mon, 28 Jul 2025 14:04:33 -0700 (PDT)
Date: Mon, 28 Jul 2025 14:04:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANflh2gC/x2NSQ7CMAwAv1L5jKskELavoB6yuGAJmcoJFFT17
 0Q9jeYys0AhZSpw7RZQ+nDhlzSxuw7SI8idkHNzcMZ5c3JnjAcsNcQnYeay8S0sXHGqinNQQY/ WYzLpkuM+j84cocUmpZG/2+gGvre+/8Gwrn8ZZ8nEgAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753736672; l=1896;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=zFb2Oa6g6C1AFnPxXLdZtpXeNv9w6hxscbJigmNdpCg=; b=HH73qpE/zdS+HCUqoI7QlwguMOVUWIcr2Ny2CgnzuAwg/gvWWMVd4GqIurLvfypFGt3lDRlob
 13Mch8agVrpDeZ9Y0oMMvccLNTHA6rhTzU/w5faraqws/Vx98Q7G6j3
X-Mailer: b4 0.12.3
Message-ID: <20250728-b4-stable-disable-uninit-ptr-warn-5-15-v1-1-e373a895b9c5@google.com>
Subject: [PATCH 5.15.y] KVM: arm64: sys_regs: disable -Wuninitialized-const-pointer
 warning
From: Justin Stitt <justinstitt@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Christopher Covington <cov@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

A new warning in Clang 22 [1] complains that @clidr passed to
get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
doesn't really care since it casts away the const-ness anyways -- it is
a false positive.

|  ../arch/arm64/kvm/sys_regs.c:2838:23: warning: variable 'clidr' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
|   2838 |         get_clidr_el1(NULL, &clidr); /* Ugly... */
|        |                              ^~~~~

Disable this warning for sys_regs.o with an iron fist as it doesn't make
sense to waste maintainer's time or potentially break builds by
backporting large changelists from 6.2+.

This patch isn't needed for anything past 6.1 as this code section was
reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache
configuration").

Cc: stable@vger.kernel.org
Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
I'm sending a similar patch for 6.1.
---
 arch/arm64/kvm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 989bb5dad2c8..109cca425d3e 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -25,3 +25,6 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o
+
+# Work around a false positive Clang 22 -Wuninitialized-const-pointer warning
+CFLAGS_sys_regs.o := $(call cc-disable-warning, uninitialized-const-pointer)

---
base-commit: 8bb7eca972ad531c9b149c0a51ab43a417385813
change-id: 20250728-b4-stable-disable-uninit-ptr-warn-5-15-c0c9db3df206

Best regards,
--
Justin Stitt <justinstitt@google.com>


