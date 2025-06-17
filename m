Return-Path: <stable+bounces-154546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAC0ADDA64
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12C35A7510
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF9C2FA641;
	Tue, 17 Jun 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ug5HaZAL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6542FA623
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179549; cv=none; b=Edcyt3GZyEF9ivmxkanCDCvvLxfkE0/O8FfPrXf093HCuKvwTai7wdSpYI2kYA0XPCXvb+USVqGCNAr3rpNl+VNL0gT6isHZiivu/tqYcKkX6WEmi91zNJCoFUplb9agpSWzJjJ6fioGzPPD+iLRQptmUTrLy4A8XyjhUKDHdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179549; c=relaxed/simple;
	bh=Pq/utjlzEuIfkek9XZnVBp8fSFoTSrvDNDAxjZPlw38=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=VIquag5F1e5rbkPibL/1My5PXV88o76M0T/LhkNH4I7JFWNVhcd2xt8HsUlc5aUgnATu2xBAlOQiR+wQWEqPUZIDgs/G31jduRt6CETa5p5fCD9Ssganq03EspGwMcScF81svuxX4AvT2IqkgNXOIeuFjD4kkFcnY/iAzX2rAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ug5HaZAL; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7387d4a336so5096475276.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1750179546; x=1750784346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3WedCFWStTLGQoRjqyCyAiG9gRzO4RZX34vrpKojbY=;
        b=ug5HaZAL+cOVyFeZVLTiRyYR0VjN4oxLOzVOkxkOOsZY7f1a9+Hv2pBJV0iLDlOxIN
         SWwNAbgsuy5OENFkA8nXdjW6/9jWYbJY5sjVau6jGeA7Xqb1GHNoGDIOj1WQwxzUYOba
         XekKbhpe6v5gYPjTjgYqjlSXR4vCkt2BE0M7l4IZRkVQA5XgRkvfAmcm2vv+EU9ga1wF
         goiA4dONAWSSnUe5Wx3zGEX6SLw/FXF5AZHKRz4ONa91xeGaPbz4e+Zcx9/gVNUaqdYF
         +W2ICp9+b22nxIkBPZ7+k8uAa9SEr4G9pyTMVqd9yPkl6aaWqbra6TeEtht/E3xu367S
         ya8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750179546; x=1750784346;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3WedCFWStTLGQoRjqyCyAiG9gRzO4RZX34vrpKojbY=;
        b=Si8wJhLGbLuSMMZtoRvlZOe1LRpkaDN2Mw2hF/KMJGxfuHRALRpJf1NsmffIRe65l0
         X94t0MpSeBZZlEG3JwmI4Z5NXDtezdXX+2ElMCF4yJmcyiGB35CCNyjAgWIGcFK4nlzg
         vSiMzp8V7rJulg+mvnWwxQo41zBZTa64/Y8KKnYnlMGbmH4NOFIFOjn+NCuA5z900OW7
         X1Zrg8JweZ9Gv5ROYAPYMVX0kPn9yiYyzcaG77cVxFqdKv+cBiz97xab0rf0qd11gl9s
         LXneNic1DCtV9wzVUsuotV0L0YRi9Qu/exPDFRUKg/dnxGdOTw3JzODfuldDg5AlxqE3
         xucg==
X-Forwarded-Encrypted: i=1; AJvYcCWXrxsVlSghLNQaVsukLivdtEjas5YKGyLxFOPs2tISbVudnEj8VhhA5eusoL/KzMhnGplq8TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmpAprPJ4s7fNr1fSAgHTlH0b1T1I8sRYIj9fykIvGZtxHCZVf
	cBtPhMyzEVr67ZPh4X2/Ga4vI+FenVXWviXe/CYwy3FILy4vlETPSgZh/58l5f6hisUK4aZclls
	6V/AT2wYbhMOSHX4C3zYKGy29ayjKqQscnps2QxX8Sl32gA+0rsdn
X-Gm-Gg: ASbGncs8xWca2mxUNWkHNIUquf/THZnodzGsg1UJYONPRy1OhSgoitJXYs/x8a23GN8
	prKsLt8y4IQmSwXVmEuGhq7EdhYBljolpkqnhBtfNDXpvYB982rSuZBcT54MjpfiIGYEN9l7dmu
	5Quy0tolCPN/GKk4Syi1NLWQmp40DynPfvO658itG30g==
X-Google-Smtp-Source: AGHT+IGSCvZiANtX9Bl/HpsDub1w4yISZFiwbM+BT7EjZpdRobfVM39JzQLIUYKJHkKGGqxdjmjcWoVv0Nx1/XMSZIQ=
X-Received: by 2002:a05:6902:1106:b0:e79:67c9:b665 with SMTP id
 3f1490d57ef6-e822abf553bmr19451526276.12.1750179546528; Tue, 17 Jun 2025
 09:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Jun 2025 12:59:05 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 17 Jun 2025 12:59:05 -0400
X-Gm-Features: AX0GCFulqAMQoBWj-bhm26_rBEBqHZqIdbktzIQdJPom5Vl63K7D31M3oZqp4dQ
Message-ID: <CACo-S-2Z6Sq5_E+wvqa+ydKt8rpBM84gFqi90Sb9DGse1+phdg@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) stack frame size (2488)
 exceeds limit (2048) in 'dml31_ModeSupport...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 stack frame size (2488) exceeds limit (2048) in
'dml31_ModeSupportAndSystemConfigurationFull'
[-Werror,-Wframe-larger-than] in
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.o
(drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:69fb66ef80a96ff4750a9dacf73be24a7cbe888e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2c86adab41e98d103953bf8c447202c9147150ab


Log excerpt:
=====================================================
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3795:6:
error: stack frame size (2488) exceeds limit (2048) in
'dml31_ModeSupportAndSystemConfigurationFull'
[-Werror,-Wframe-larger-than]
 3795 | void dml31_ModeSupportAndSystemConfigurationFull(struct
display_mode_lib *mode_lib)
      |      ^
  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn303/dcn303_fpu.o
1 error generated.
  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/dcn314_fpu.o

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:685193725c2cf25042b9bcc9


#kernelci issue maestro:69fb66ef80a96ff4750a9dacf73be24a7cbe888e

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

