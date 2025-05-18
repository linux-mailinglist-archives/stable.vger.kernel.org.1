Return-Path: <stable+bounces-144716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1A5ABAF32
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 11:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DE116A86A
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68B313D891;
	Sun, 18 May 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SxhEO6/2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE767E1
	for <stable@vger.kernel.org>; Sun, 18 May 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747562348; cv=none; b=Kpg8Z1ejvKVaL5poPO6bZwlzToTnDUbk738QNBnvpIDr7LXCrhht8VyWQMouqLspsFkCYopVXUbQZaO95snOEq3isMcM9wHSikHajuscpF8SUjcjYJa4MLMlzYOz+mYYmNKMHo2VdeUS7lldfI2HkDNiEc8tmrd//phVkPw6Zww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747562348; c=relaxed/simple;
	bh=LR1Mhrf6Bs4wSUWjcnk/fQx3UL3sVGebxQdkUelfyBY=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=dHJtPjNcTTpnfarsf+3bYl+MpOMzpvye6mWbTro66nyP1gp/utldJ0u8988d+I6WKSIjOXJRAiaa09Zq5hB9UyC6kBhHTB5HWYsqGuTGin+rd5xsheplw6aaBOq7zPRO2qE3j+kWfsrH6KEAP3OtEcHsOLmQNx7lyAN40FcXlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=SxhEO6/2; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e75668006b9so3529909276.3
        for <stable@vger.kernel.org>; Sun, 18 May 2025 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1747562345; x=1748167145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PglU88x4n4qllhzfvjESKFFEq92m0kLBBPud0yKRW7Q=;
        b=SxhEO6/2jqr8O0YvEIXi5zaFsD94oEZU2LWqLP4yI/sveRjXNylLxLrmv9/9TSJOf9
         56BwnGvO85pmMbon9oscysuXHWBbU+3V/cTcutMRFCISInptWfRge0kyKden+FsTPAid
         7DZ+uVV4eSIfxIxVci0W8G64LNwf+KTNQky+jkcD5s7cFDjRLHp8yM+h1/1ld6asLuHa
         4DK57wxOG9JwvE2EyT2SXBov9nQIavHbYT885a3IERkX45qKjvKV7RNORifGCsVsv5je
         rVCisM+Ug8ijTw446FdtTIm+t/4XELhVyjKvVECkhCDcIeIDdopWxrjarOEEc4FjN20p
         rBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747562345; x=1748167145;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PglU88x4n4qllhzfvjESKFFEq92m0kLBBPud0yKRW7Q=;
        b=Ducef4fwBx2dGhO5f9j3nuJipx4nORHG34KFmBMCBxQPqvEq9PT+P8tkYVMCGJRpBJ
         30SVWyw6CYNd6hryNKV1jUTNbaCjv2Qvq9FgPQ4RGsIjbW0eXipedFix9GNvDKWuMCo2
         qsR0gO2s2Ln3L9EJJHSMB2+l1G0V2qHWnQPIjlDBY0q8oAFqlvmnHIn7E6ylJ+tb/EQn
         yyA3Gb1mXKl2nkcw0bousdmthKZC5iep5WH8ao4W/BXkTrx9CCfgN4Cnm5AWoOEFDH+S
         bAsZIehE6CF89acf1lEzaO7qLNy2wKDJSnYlAMyBiYoBFpdI0NeqXL0acxWyBlGXTTd9
         V8tA==
X-Forwarded-Encrypted: i=1; AJvYcCV7pOo5y5f09z+CzDLfi2+z2of++eky7X2bt7rlj6+Jg+J72+u85DG5mCnqep4tN8NsCjBB/JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymfjyegiIQPEiJ0sRQ6RKjz5GQsoIxy3856eaE2HXfzkWaUznY
	z2NIB5m/6KV9xsXQyrMvJVIkndHRloT5SxBeaaNNEao2I1lHrmz9Ao73nsEbc/cIJUHuxJgW5yA
	xnUYWYH1Ap5P8hrlPNcj5/ZbRbbwn2Y4g2DlqSfUaJA==
X-Gm-Gg: ASbGncukGUze8wJtPpGGuLJQjkNWiWtKDvSJQvaKJVnSsIoAIRY3XTTUAVV2iO3DPYl
	xl004f6nlFgJKOywyMJe6Kc6XL2WlXOL/LIXcuy69GRzxTV+UkELNe6vfOvbBnQhphJBHCdCJnI
	5WjcWIr5KkonOpJu7FnQ1dvMlkF2CPfCY=
X-Google-Smtp-Source: AGHT+IFmDbtKgO0N5F4WKZPxch7AWV/RcMHwzm6qC3sm+UX+Z08rd+M/4pge7TPjB2saV9yGShySQCV9o5RmgXU3xRI=
X-Received: by 2002:a05:6902:110c:b0:e77:d5ca:ffad with SMTP id
 3f1490d57ef6-e7b6a0ab67fmr12267280276.29.1747562345099; Sun, 18 May 2025
 02:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 May 2025 04:59:03 -0500
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 May 2025 04:59:03 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Sun, 18 May 2025 04:59:03 -0500
X-Gm-Features: AX0GCFtkBFE7CflNDF_firGXJTs9eEbfsejapZF45FND08oke9asfZA2dmIU4_0
Message-ID: <CACo-S-3VvZ8uMB-S9G0rPNDtMPRQ8_gWajhYe8JkFTXG9SMZ_Q@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) set_ftrace_ops_ro+0x46:
 relocation to !ENDBR: .text+0x16c578 in vm...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 set_ftrace_ops_ro+0x46: relocation to !ENDBR: .text+0x16c578 in
vmlinux (vmlinux.o) [logspec:kbuild,kbuild.compiler.objtool]
---

- dashboard: https://d.kernelci.org/i/maestro:c49af145451f7a03012be6a37ed4b2bc44aa3470
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  615b9e10e3377467ced8f50592a1b5ba8ce053d8


Log excerpt:
=====================================================
vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x46: relocation to
!ENDBR: .text+0x16c578
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  GEN     .vmlinux.objs
  MODPOST vmlinux.symvers
  CC      .vmlinux.export.o
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.kallsyms1
ld.lld: error: undefined symbol: its_static_thunk
>>> referenced by usercopy_64.c
>>>               vmlinux.o:(emit_indirect_jump)

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+allmodconfig on (x86_64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6829871bfef071f536c1102b


#kernelci issue maestro:c49af145451f7a03012be6a37ed4b2bc44aa3470

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

