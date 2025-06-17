Return-Path: <stable+bounces-154547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA0EADDA2A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38182C5D07
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57EF2FA624;
	Tue, 17 Jun 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="s2Gh+34n"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AF2FA623
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179551; cv=none; b=gaDruSaBde9Vll5ofITqwAvx1pW675lGJaqY/O/7d3/B6XuDq/sy5WaFGIFH/RlnV2OxFWXRC/JWRB4rTEVBpWO7Ey7LEWH72n5fFP+lg1afo0CRmn0Z6UuW25mPHf36jZ4U5evj2Sk4JK0g6t+M33H54PS6R4+6PNxdabV4bVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179551; c=relaxed/simple;
	bh=EHAFjGGQrkORrm6hRPY/QTvwJwTbtUPfkVY0DU1xFm0=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=SYRlVSNQFTQtOV5liqviKbAQrWkvJOswDZ3bwa13TEZz5vXZGrpAWM0O3L6AA/gPW1VVUlM4BF1P3j6uRGG6IcHpqWLqLe55yQVCkDeYnJTkTRADNY2G4N5gj+8gf6ue2Nv93zlGl7aHgJ8G/8voIXNpuWPBSvKR4qdtSOi7xKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=s2Gh+34n; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e82278e3889so3031847276.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1750179549; x=1750784349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGEDHEIEqKDiiwEf8AN24U2VOHdi/+aitNdJIVP40iI=;
        b=s2Gh+34nTQB05Pm7em2+vy98fUBsRcrsZEAm6t1DqMqBt2iESwC4bvKwjRSWJ2pExV
         YZwDf0xOgo1pKxzu+r7DLpi8Wt0+f23gQxJ9uHvJkSU8ugNA9Q2/ak0zpSuWJtEOlDgc
         F2yGwGeFT+PLWfE4JpSiCCU1rbmi3c0FHe8V3+xkNsay92iPpe9rarQ1Me7NOm+fo82p
         88jfuPPG6Qk/cgrqY2giU9o2fHubjGt4EFPlbHZYcdWSpCC68eHjtFBbuzmdue4Nuhbr
         hv+wCMpRxhEV1bOhurLlx1jMjNxNeOOYCM9FBEX3kbT31OBg+9ArFqbSZXIoghw8XLlm
         /9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750179549; x=1750784349;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGEDHEIEqKDiiwEf8AN24U2VOHdi/+aitNdJIVP40iI=;
        b=pML7DWPp7xFA2lQO7afwg2t0qsOn29lfF6TgASvMbxK1S9OvXTj1WJ3xkzh/jQcB9j
         RDqvEoCPmCGbcBYg7UG5AEbtil7TlxkpcUbD0QwNlyOP1lqQX+sOr0MPdo7I6TWsSaIv
         GaMXI2rrfpiYGKA2IqA3IxqCb4YooKAW0BZ7TckYYUP2tDBYEvlGEflN+iyMtZVpRB8L
         Wtw7oFJeT2plVkbyPNBEKokBx2jn+t0RoAq5wG/TzYs7eEylhtYICAVay6Xf5kMqouVN
         jrFpEN7QPtzd11MFdP8iDEGycQYFP2HmvKt8cHQTQOkedVDcx5TJHyDhcjQoy1hnA7dS
         I2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWDxu7nIAwbftXlyHg2A0atx09x25xBZQL6GNXrE5nOR5KNL/8YVOHQFm9o50SsfwoT2znmwhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpR+L76ii/v8kg8or8fUmzCdcNy6SBcp+iPQCyiZqryqomzBK
	4dyrT2kw8EYHg5pn4Co8L4Rdt+kXLZFHK1cPIAtIsxpMhhtPTCXbsAZ1ihhVeoR1yn7U0esmf4K
	VEmY53GaWnH15jQN7skNoEiLvsJ4ol7LIjPC5E/pINQ==
X-Gm-Gg: ASbGncvUrBRdo9XoH2ScwQKc1tzI8l5A6Ykx2FRo/3z9OiKirQxmJSwABgq6tJcBUxO
	KLvlAMDx0fosopeGNRxgA3HmGsuH9LPpmI7SrK6J38yGdfiLfd4YNs7P5Ak4tLevonhLBs7KP+L
	JepzyLrejO46N+Xr7khW1W+lqTc+eBerykmzDHlw8w5Q==
X-Google-Smtp-Source: AGHT+IG5Wz+dS3Fwzb/hDZcq1bUAOj5mNGfGNpLUu746GLmy+xgAYkBl8aKB06VTvWKJhFrlGCSOkuMSF3bJ1/F5aks=
X-Received: by 2002:a05:6902:6986:b0:e82:6c9b:8296 with SMTP id
 3f1490d57ef6-e826c9b85cbmr3954996276.7.1750179548847; Tue, 17 Jun 2025
 09:59:08 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Jun 2025 09:59:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 17 Jun 2025 09:59:06 -0700
X-Gm-Features: AX0GCFvNzCd34E_mqeCngxekZmg9VEQW82W3bgHC4XES-K72pmFYe8hoXaUhaPc
Message-ID: <CACo-S-1qbCX4WAVFA63dWfHtrRHZBTyyr2js8Lx=Az03XHTTHg@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) clang: error: assembler
 command failed with exit code 1 (use -v to...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 clang: error: assembler command failed with exit code 1 (use -v to
see invocation) in drivers/firmware/qcom_scm-32.o
(scripts/Makefile.build:262) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:e1ce6e2cb61e68ec7bf14991570487d713f77e0a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  e2f5a2e75b315706dd2d1d50a4313e5785eb189d


Log excerpt:
=====================================================
  CC      drivers/firmware/qcom_scm-32.o
  CC      lib/idr.o
  CC      drivers/gpu/host1x/debug.o
  CC      drivers/clk/rockchip/clk-rk3328.o
  CC      drivers/clk/rockchip/clk-rk3368.o
  CC      lib/ioremap.o
  CC      drivers/gpu/drm/drm_probe_helper.o
  CC      drivers/clk/rockchip/clk-rk3399.o
/tmp/qcom_scm-32-2d4d72.s: Assembler messages:
/tmp/qcom_scm-32-2d4d72.s:56: Error: selected processor does not
support `smc #0' in ARM mode
/tmp/qcom_scm-32-2d4d72.s:69: Error: selected processor does not
support `smc #0' in ARM mode
/tmp/qcom_scm-32-2d4d72.s:173: Error: selected processor does not
support `smc #0' in ARM mode
/tmp/qcom_scm-32-2d4d72.s:394: Error: selected processor does not
support `smc #0' in ARM mode
/tmp/qcom_scm-32-2d4d72.s:545: Error: selected processor does not
support `smc #0' in ARM mode
/tmp/qcom_scm-32-2d4d72.s:930: Error: selected processor does not
support `smc #0' in ARM mode
/tmp/qcom_scm-32-2d4d72.s:1070: Error: selected processor does not
support `smc #0' in ARM mode
/tmp/qcom_scm-32-2d4d72.s:1117: Error: selected processor does not
support `smc #0' in ARM mode
clang: error: assembler command failed with exit code 1 (use -v to see
invocation)

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:685191885c2cf25042b9bb39

## multi_v7_defconfig on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:685191845c2cf25042b9bb35


#kernelci issue maestro:e1ce6e2cb61e68ec7bf14991570487d713f77e0a

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

