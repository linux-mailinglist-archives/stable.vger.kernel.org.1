Return-Path: <stable+bounces-169287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BD0B23A51
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 22:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D40189C685
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E362C21C4;
	Tue, 12 Aug 2025 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="00h360nQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E8270EBA
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032347; cv=none; b=Q3thAXfWz+uirylIX3Ho9r5vVvDvMOplWjM96nmPNT16bKWzoddMKz1eXkQn67OymZuled5CAY19XzMYwRFQF5CKqDxcjUwQPc9O8nwgIzSb/UYTgpdTiJM9L3DKB30O7AfipLv7vGM7wiojvaNkaB3FJWWspkNxi0j9VOGqLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032347; c=relaxed/simple;
	bh=uCR/ZMYlGUdCFvngaQQN+P2v4uDoiRpOMDlrCjkwsvs=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=tKDoIRc0+r2c99dmFKftDy1EjyedV0W8/rF2yD5j+zJWXGAwkh+eRYTUogZMb0K2cZbywbxm/ZsQbGhVYhM3HC0AUN63AJk7c8rRPs5cM4Ghs60KMzn+Uf43Ds5CdcOCIATrRgNHKAEaN+H+1TflWjPrO/KKIkseRIQXsx3h7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=00h360nQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b429db71b3dso4152844a12.0
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755032345; x=1755637145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wx0+JEj2RjqKxyWHPx0LvIOcVVDwYY8U+wQqgeV0KbA=;
        b=00h360nQbxYmd8fCJ7jl4GTwAslzvVTuKekKKoBDrvPz7pnOVCPc2nhwmXYvwNR5c8
         zrswYU+gobsU4j+fDvjttHz0wI0AzQAfFDwZXUXqrJYsR0S9bylHRbMDqdyHsgYJGI/8
         6lYjU+/bc5fnXvpMsM5QxT5kHR3/Yk+fD8VFhyvH38vOauhgaETuQ7yvkqa4eKine1Vm
         bBvKBeN8b7+QOeGb4ckTH+z6GnENQgxoqz/lYPTwvDOZkJMipNGt1cf4x1ANPnVCHwLA
         lCHoaGu0dJv7PXTW7jvglyGmPG+QdBBVQOcO9ObySMI659wpzugvXUBycMbVaIr4WVdz
         z1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755032345; x=1755637145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wx0+JEj2RjqKxyWHPx0LvIOcVVDwYY8U+wQqgeV0KbA=;
        b=cJrcHGjel7cF3kHPzMVEnnJVjGKiJIk+ns8j/2UNOzrA2zE4OwfY6kgmzoM5JM3y5z
         +52xp6ILeVqszMSF+fl8iYQuDW/0rnVboUzBHghnIAUoufaaGhCVytljbiZcw3XCtx71
         E6/pgSobmj+k7z7LLUKnYd5coHsq/ifh4gUNxC0aW75ByO//QG6cm5ja6p26Wnm63kvK
         kIMJtPydKq1EbEGZxUakmLx4ywcaV75GYO+9l8vUZCuqNySvK5nevarghxSkKkV8Z0Rk
         UTiU1/BYpK2+OZcSxHa0v5gTfb+v+TD2c+EsR2PyEfSHWSIgcn6B8ih+R0T1FtAc2zDp
         drnw==
X-Forwarded-Encrypted: i=1; AJvYcCWgJWqLg4inZ/fYHl32OD05/Bq7pIMqwGvWdAwiT51kDpacSXIXkD+F5KGlP3siGXWXK2OerZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD62WWD7J/eqlL6ctnv4jyMNzmixVSHAf3SlQEyj96M4iIbAuF
	4XuzfpYtiegw18OsIcWbj6E6H/zt3ZPPB/7N+x1GzJTH4IKhuQ0rQlgQis8uSvVcA7eA0ln0T8u
	OAXu+
X-Gm-Gg: ASbGncuf4Rx0vGqsek1oYA6D0f4cPeXscYQAv7rwPBV7GQEo98BqOANKAft74YKLGg2
	oAEHkzLhDNwF6u9dcay1B5riFZ05Q+M+nR8y1fnJNxRHx56D4bNgomUskvRglNu1hAfkYPLEhmG
	tPBltAtUDTPi4jGhUMJS1sYKooPPie9f4VaI2zyCgsIbjfXEMnUMIMDBuT1CdTUd1cphMGdQQ5d
	W1urxApW7FLpHnJzuJPhSpaR72xi9O5S5m6FKkoyTZNYjQjV7sBzAerDhRqPx4Q+lYmzef7PuQR
	rR/YXAISxz2sW0cGa4ggJvX1Hcz7Z8CXgK6CPKb5tsMCpE/5lHiGvvUeJzxiEapyYgnT0XLQOlB
	R2E8/WCz9IvefAfwN
X-Google-Smtp-Source: AGHT+IHrz7ROLypBOb8oASHe5dZ9I6pOJpJsGLj1cw+x64V07tf8lGmRfHn73cRCuq1IESNmBfFCqg==
X-Received: by 2002:a17:90b:350f:b0:321:6e1a:1b70 with SMTP id 98e67ed59e1d1-321d0aebb15mr824370a91.0.1755032345246;
        Tue, 12 Aug 2025 13:59:05 -0700 (PDT)
Received: from 99cfaf6094a7 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321d1d7846bsm91792a91.4.2025.08.12.13.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) implicit declaration of
 function
 'guest_cpu_cap_has' [-Werror,-Wim...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 12 Aug 2025 20:59:04 -0000
Message-ID: <175503234385.237.5946738827143782193@99cfaf6094a7>





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 implicit declaration of function 'guest_cpu_cap_has' [-Werror,-Wimplicit-function-declaration] in arch/x86/kvm/vmx/vmx.o (arch/x86/kvm/vmx/vmx.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:ffd38b22f4d3da011e2d8142fcd9b848083d18fb
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  62f5d931273c281f86db2d54bfa496b2a2b400cc



Log excerpt:
=====================================================
arch/x86/kvm/vmx/vmx.c:2022:25: error: implicit declaration of function 'guest_cpu_cap_has' [-Werror,-Wimplicit-function-declaration]
 2022 |             (host_initiated || guest_cpu_cap_has(vcpu, X86_FEATURE_RTM)))
      |                                ^
arch/x86/kvm/vmx/vmx.c:2022:25: note: did you mean 'guest_cpuid_has'?
./arch/x86/kvm/cpuid.h:84:29: note: 'guest_cpuid_has' declared here
   84 | static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu,
      |                             ^
arch/x86/kvm/vmx/vmx.c:2022:7: error: use of undeclared identifier 'host_initiated'
 2022 |             (host_initiated || guest_cpu_cap_has(vcpu, X86_FEATURE_RTM)))
      |              ^
2 errors generated.

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:689b7884233e484a3f8f254e


#kernelci issue maestro:ffd38b22f4d3da011e2d8142fcd9b848083d18fb

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

