Return-Path: <stable+bounces-161332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BB4AFD5D8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15837A2E94
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5AF2E6D38;
	Tue,  8 Jul 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UEPBeVHx"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E32E6D08
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997556; cv=none; b=ZSQy1jrCY4QZV4rk5O7Pv0nsqvql36Oua3uZsL6FvxzhJpYNTYb78Nof77bFcbPxrsuPTSLy4BDLfzRl+ZwHYcoIsh026+n8oMz1vAKquZ/a1eloEWJV8tnAFm0YJhuuGcDeb/0OKAhcGx/jW9tWXHoYODzOQ7/t5w/Hqpha0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997556; c=relaxed/simple;
	bh=SlKZIWrBTz4Yxvdzk2/A3SC47H+ueWZm1cXsaUakAZo=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=hbE767hJHF7QeLMQoaH/kmFfaK87C+xADpGdwNTakGcq/LNitKaz83yfgI9telenyVw9DgTYrn5Kq//972dhiYmJcCNuzPDK1KS16j6l3nAiE9DzCIRXt6z80/J+Mlfjo49RGHfN0+mCfVfuuhNR5FhbTg1gA6aWj1cVfmoKAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=UEPBeVHx; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8b62d09908so998654276.2
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751997554; x=1752602354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3er1WSXYPtitR8HtSx6s8YEJ03vfGwTcXJhqutQC30=;
        b=UEPBeVHxy2sfcUIHezWepqWN3I1trlT91SeDXlhhrIPrmgZXLIX3uMX3XuxGfknPsp
         67ApqYYJ3zN6DD7un1iLNDRDaIu5MAymUMK3iZYMyUDa1SUdGfLOHG+/hCEtQ+TpPlWf
         VcdSuBSSI+glfaEC8lfi/70Gd4WlSacRzlY5wlyYPh7pcTVEwGvt+F3Uofq/oHY5br0+
         bKuoZDikUfUSaBMWGkYTvv9/87UhGy9BwLSQJAyG0Xm/jiXX63gU7YMqSSUb5vqC7BLx
         Jj+wwa5ZsLm4m7Dk4t8S1Ce1Zk8BDV1DvOFrcL0yx6c897hA5BAWWrfck76bHWxkU7Tp
         LBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997554; x=1752602354;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3er1WSXYPtitR8HtSx6s8YEJ03vfGwTcXJhqutQC30=;
        b=rLCNbKhCKHRs7a8lPJerxnIw6B1xcq1zypk5VEAxq1XBGwe1atjXwD8RqP6nUN4CUA
         AI3cgzkKjVtl2UlDNM7F17fHMn9nr9QznWpNdPe3NVRInnEq0Ef427CxWFknyB0CsnHr
         UiqIq62bVpEgs+lXtLOtbjyFA6MK8kqCcJBt+KERza+il8uOfp0jCQUIeKrwS2Ou5EKc
         IW3hicNtC0HbWJxtZVcWyXX8+QEXcHlIOKIocy493jpL1fRBf+uhkVbxjCRWKT1NmZtU
         Yfvy/vXSnezsajKsboWkCr0ujDBwPnOefFl6ES16SDQf494a6mHi77gfGMoZtPc6wJer
         Ne/A==
X-Forwarded-Encrypted: i=1; AJvYcCW4nbgrfCL9uxew+bxHZ9AyN92b8Ysj2MQ3alYos8HB+XUXWVvqkxUKYgQr2AfeGXYu/xEN7qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+ho8/DQYKrcVOFYbUqM58SY5zDN+S3OUE6kiZDklBU/jfE+/
	kZeyF5fTkp8mnydEN0bI1c7oeCcW+Mtwcd+6DEz97ZxLWqyOF8juxWWAliqmOIqtBOgwzI+SPNG
	14sURgeq2ya0ar4fihduS07qIPKlufaYusM+gPw42TQPqLkdTXubEYIpgRw==
X-Gm-Gg: ASbGncu7XlGhfAdw2uWX9DWuB8e66n3wERTj0+NNWNfecIKJhStcdPhXJL/NvmxjQHn
	rVFKiV0JE54HbRmlrVY3OYqq98OHRdwC19AbR6TMbBFU3jB0ssmcSTX9TftLI9f/YI99JZ0LlED
	zYBcVSlSuG2x92tIGp5yQ/p0rRT9iHsEmRKr3oLhIEg9eC2DBhY9N2
X-Google-Smtp-Source: AGHT+IHbOPNf0UOZ13k/N2vWUGAG+5iELz5MYwWYnMsk2yNrEgyPuAEi/GuxmtqcbpotIicqP+0aG3CtTUuX1S1nwEU=
X-Received: by 2002:a05:690c:dc1:b0:70e:73ae:766c with SMTP id
 00721157ae682-7166b6be7b4mr233783727b3.22.1751997554058; Tue, 08 Jul 2025
 10:59:14 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:12 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Jul 2025 10:59:11 -0700
X-Gm-Features: Ac12FXzd5nv5iBZRyM3e_LV43M3kfz7ZmVoT7k_HOvwac27ufN7Dv1c1MIaF9_0
Message-ID: <CACo-S-1s6=RbysGdhSz4tEiUaNiXFeTjHWK9xUk-pHUJG+0_ZA@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) in vmlinux
 (Makefile:1246) [logspec:kbuild,kbuild.other]
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 in vmlinux (Makefile:1246) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:16639fda313460b17cc53ce3fe28a6a8157c0596
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  57a10c76a9922f216165558513b1e0f5a2eae559



Log excerpt:
=====================================================
.lds
aarch64-linux-gnu-ld: drivers/base/cpu.o:(.data+0x178): undefined
reference to `cpu_show_tsa'

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:686d533334612746bbb53969

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:686d52c134612746bbb538ca

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:686d494334612746bbb51edf

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:686d492934612746bbb51eb3


#kernelci issue maestro:16639fda313460b17cc53ce3fe28a6a8157c0596

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

