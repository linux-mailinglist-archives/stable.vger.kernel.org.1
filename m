Return-Path: <stable+bounces-136974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51086A9FD53
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 00:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63C3467E05
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 22:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D9212B1E;
	Mon, 28 Apr 2025 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="f0XmO6Je"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8F155333
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881149; cv=none; b=rhGLMrI9Lznc7/XJiO8kc+Zwkjxp8vR6Q2XPQX6a7g+euhvIpIihIs5efyXrJgJ6KmD4cuQlArBQH3tR52wXt0Q9STRvkmwyJCdBvJQrZX1ZQugEirv67tKFzc3u/aiRbv+9AypIghV8GysF1VQOaqG3tgc6zDYfA3V23UOY1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881149; c=relaxed/simple;
	bh=uLj8m0an7X3JmS30zmyg5dTwqXXsCIoVqw+IGLy6HE8=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=M+D0qa8M+an3Jh2KtvRrGCzGpLnAxYcIwi5/vELFQ23+dFSY9PbMJS+jWahbPxYr4sQyZ2yZvgQNe61Al7LWR/W+VxZA5FaKzYuPRFv4wGvzOd3PofaQyjCtAj8VkEvQqYZLLSLH0abWVJbA5eL4wyIUe5OpnZvl1Ye2esTBZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=f0XmO6Je; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so1773934276.3
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745881145; x=1746485945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+IVWIn2UXhSLa8laKq98wli33u3+zcQ483Tm3cmHgg=;
        b=f0XmO6Jee1njMxoTSIiFGsN1b4Opz6QCK8obq3KffDNRxUAx6WoZdkFLQEPyqcRwyP
         zEhpDMOJVOJKbjbd88y+WZj5WwakzXh8q0T49htB1lMb+98wTKu8Y7Gc5EO+SaCRWzYU
         i+HAgVW4LpCbzJcs5ZRuBWpubiMUei6x9BLEBto7OK2NSLnCP2U305KhC04BsGfYWOrO
         fEXMjJB9lv0cGGqrUI6v92hZtsZedug6/wV2ECFlduszGpjAuSqxH7RsK4Ws+//fw9Tj
         SNe7W+s0xRcr4TJDD+4VUPZgip3Ppy63UIJcUuQt/zUYcBlgrANm6UWpbTcyCFKtV8iN
         Anmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881145; x=1746485945;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+IVWIn2UXhSLa8laKq98wli33u3+zcQ483Tm3cmHgg=;
        b=X6spvmELKnTsnf0+s6Jr90YU5DChmUF4IoiI5bLEKo2PwKMNzwu9/T0hRbmqBF98Rf
         RwymXLVIkGq+1+SQi5YFc07UexGTPGaRsnBNMb3+OOey3Yx4yNbVY//vDVVG3DY0prQa
         KAIAC+qR/qZ6gUO1lFvMrDH+KSUutgtnZcLIcU7bPvTDdZXWpHF0ByQYK8jAaqCpVAnZ
         /+wm+cXC/YdoV5sOefsp7zg0QDgGjeFXwXwixysWA44GIPeaqWdmi6i360QY3wsMq4pb
         Kt/AA2/0hsk+yC62twbjZS2WIt/IYNdTDcqf+OTya24ORg5EX7Dwa5Ecyt6naruesNBX
         wxKA==
X-Forwarded-Encrypted: i=1; AJvYcCUeLy6RP74ErQGx3oDxTTG38MNqMtGD7nko+6kV9AQ0ZURtU+i099e70lbpE7ggJySVDwp9W1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo5y1Ru8MmzXLuhRFuAcnpRohAtPh68P8CnAfPKxcV3PwQL2pV
	9l7uJUSd+oCRbkWdf2OQTRk03L8jJAeragRpjXs+EZ87uwUr333MY+uXoozuXakYjzvFSFGyekj
	7ELcmvFUS8Dd87jdLEifAaBiRMl211SszmIzjCKeYzhV/WALkl9s=
X-Gm-Gg: ASbGncuJqEfV2d0gtGnTjusD72XzQ+oJHlU2dZCJM4hgDGCdX8Zv7l2nNv3zKjl4ulN
	FuHDzcgPeOb+8+s0TkBjidkS6amrMzNphkrj9oc5Dn5T+Kflyz7q4n2+f8h60vzs8i6zhu8WKaa
	MU8g4bPMCK+PWLmiC+NvRI
X-Google-Smtp-Source: AGHT+IHH22Yb8vVDM2GGMpfWIKMlVaV8rrihJ5/TH2x0MBmduq7CAxPeilPSBt/GNCVtS2VjgzgODkD1S3YT2CswIyk=
X-Received: by 2002:a05:6902:12ce:b0:e6d:fd2f:2b41 with SMTP id
 3f1490d57ef6-e732344caffmr15747582276.35.1745881145551; Mon, 28 Apr 2025
 15:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 15:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 15:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 15:59:04 -0700
X-Gm-Features: ATxdqUF097B9OzWHJJVLI5kpRP6ioIsGmz8U98FMG3tkguVAGQdA0cDCiU5TH3Y
Message-ID: <CACo-S-0Kai+-oJcTcp-2PDtH5nem_L8Xd44Yj646KrvnAEEEjA@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) expected ')' in
 .vmlinux.export.o (.vmlinux.export.c) [logspec:kbu...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 expected ')' in .vmlinux.export.o (.vmlinux.export.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:2e17160abef3cb44a707a6b2dac8d873f29c593c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=====================================================
.vmlinux.export.c:1260:33: error: expected ')'
 1260 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^
.vmlinux.export.c:1260:1: note: to match this '('
 1260 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^
./include/linux/export-internal.h:62:37: note: expanded from macro
'KSYMTAB_FUNC'
   62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name,
KSYM_FUNC(name), sec, ns)
      |                                         ^
./include/linux/export-internal.h:41:5: note: expanded from macro '__KSYMTAB'
   41 |         asm("   .section
\"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
      |            ^
.vmlinux.export.c:1269:42: error: expected ')'
 1269 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^
.vmlinux.export.c:1269:1: note: to match this '('
 1269 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^
./include/linux/export-internal.h:62:37: note: expanded from macro
'KSYMTAB_FUNC'
   62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name,
KSYM_FUNC(name), sec, ns)
      |                                         ^
./include/linux/export-internal.h:41:5: note: expanded from macro '__KSYMTAB'
   41 |         asm("   .section
\"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
      |            ^
.vmlinux.export.c:1271:34: error: expected ')'
 1271 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^
.vmlinux.export.c:1271:1: note: to match this '('
 1271 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^
./include/linux/export-internal.h:62:37: note: expanded from macro
'KSYMTAB_FUNC'
   62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name,
KSYM_FUNC(name), sec, ns)
      |                                         ^
./include/linux/export-internal.h:41:5: note: expanded from macro '__KSYMTAB'
   41 |         asm("   .section
\"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
      |            ^
3 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:680fc28a43948caad95c14a3


#kernelci issue maestro:2e17160abef3cb44a707a6b2dac8d873f29c593c

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

