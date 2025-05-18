Return-Path: <stable+bounces-144713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D01EABAEDE
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 10:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D5316C792
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED99212B3E;
	Sun, 18 May 2025 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UyKDBy4v"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF0C212B1F
	for <stable@vger.kernel.org>; Sun, 18 May 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747558749; cv=none; b=fN5/01+kGGWmWPU/10v3e4QPPSbU5mz8nAwHg9/xAZBAb9Gp0AqIoJxN+UyfSMslU3W9XclTUv7DX22AIGFpGXfK575+jOpyiaBUgZyByL0pAn5kOVmNHExcAE57ETWvuPdBPCgr5U3jzcRKhj3C4RblXO0K8toKYQS271dQNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747558749; c=relaxed/simple;
	bh=LR1Mhrf6Bs4wSUWjcnk/fQx3UL3sVGebxQdkUelfyBY=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=q+UBuJq8kR9dAelQZfc92l6k3/TP6zFihRrvnMcKeLabnumiabrctWEUiKLzqX1my9CsYg9Lj2g23jXRnikBDe/+IYeMomlJ4uu7iSIsSRlsz3GGZE5f34JW6XSwSfVW8gJyrMPHc86SdFqXREKDwB7HfDDbKSFrey3pxHzU0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=UyKDBy4v; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7b9a3d85b9so151077276.0
        for <stable@vger.kernel.org>; Sun, 18 May 2025 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1747558746; x=1748163546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PglU88x4n4qllhzfvjESKFFEq92m0kLBBPud0yKRW7Q=;
        b=UyKDBy4vT/XNdJ10DKVrINEG+EEZF5GRTUTnu8mHkquga/m176BO4Dbdiky6nRYkK2
         n+/YhEkRiRq/mtInzc7TWgfW6OL47Qn6KtwDBOs4V9hmzhsZld04tHS5LZpwor0TxjCT
         ytbWoxJ3z55WnyexFiWiKbyrCBlcCtE6uo2H/JuFhhgMUAwUGCo6mPmM4amSvOJDYbdL
         NYWgquu9UbH3UDck1E5DNSFGW6c87TLYf5wlAf8pYvouKLoEW9I9H4zQdvig21/Y/fI5
         3oqhokgh0wM7Zkq6oCJDE7EW5c7jZTUw+wtzB/14uWzstV7P+dTR4MIjDdnj3Q0dAUIw
         Oo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747558746; x=1748163546;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PglU88x4n4qllhzfvjESKFFEq92m0kLBBPud0yKRW7Q=;
        b=LhLpfgUyoZyUEo+zxX3QoJtknxZ/xahyz2JVxXuDVO3hxSl9oog3/BmbosAKpYiIGQ
         DJjFePUAs2FdDpFF1OdaFYpzHtFzFpbp6dNl78H+xOqiRLin77vDuyGtUGCvV28N1wRG
         8eDPy8hv5pGblFC5ie6vYA9N6xPzjicUAHmd4CVgND1f6x8cU11kAeDtshf6k2AIjNSD
         pi3+5FynJNbu5Q3+zR7K9QqTY63EKlgnhKsci80zAAspGkPNTzTXoyPV3RdkzIZ0cj3Y
         PFjzLKmNMNkAUX/wvqEabevFju44Fwqnr4f6eaWvXL2yKtOeTf8sBy2O8segaGih1qsM
         Ff5w==
X-Forwarded-Encrypted: i=1; AJvYcCVgBeFBOc+K4dBoIFHyzPCRMyRyPRTomUv6uJKucutNjS1Xa7Q7IpTBDDikbymG3IqvFynHrcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDB/jEEyPQa8M+tljZYiXhyZ2o7uBH6q6D42WfofD1oXJHRnap
	V3WgWJScbLRvrTzWg8W74qYgoxyR7eV/vPaIk41CtW8eDgCrZo+/4jp/6ZTAsktukC1Bd8+jPYx
	0t1nE0PCvkhKz1V1ksjKfzWLpMIClhXQjXsVKndHF9g==
X-Gm-Gg: ASbGncuMo8i5TCiLZr1wmccKLGzB4ksbqLOj9qwsmJ0gI7YdjQKiUPP6bM7q0ru+rVQ
	qcI5obhF0ATQTKIkOOG2pwdL29GX++qzgHr0LOkdFnx3c8ZDZznLQY1hRLXAaj7I8Pzu+hixSG9
	XyFBH8j6Xlgcg0LmzOboxVv/KITs7kcF8=
X-Google-Smtp-Source: AGHT+IFNVEZEa+R6ZXh3pe/liOMvqNvK9PgI4pWEdf+wRJmfs+/pqx527zBRfqwyouP7nyJLA0WQz/Uy9ZRft1rKvo8=
X-Received: by 2002:a05:6902:2181:b0:e75:b883:3a8d with SMTP id
 3f1490d57ef6-e7b6d5545d3mr10289069276.35.1747558745851; Sun, 18 May 2025
 01:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 May 2025 01:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 May 2025 01:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Sun, 18 May 2025 01:59:04 -0700
X-Gm-Features: AX0GCFsaVHqrs_Domp2ZifpEvbQ4j466yh62IQHYOfYqVv5SB6mei2zxIRCxhPk
Message-ID: <CACo-S-2K7fLdx26QbPv_jB=XUiWyXaDGyTMXbCE6-wxx+irN6Q@mail.gmail.com>
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

