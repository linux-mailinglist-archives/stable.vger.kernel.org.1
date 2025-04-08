Return-Path: <stable+bounces-131718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3BA80B74
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA811BC3301
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8402D27D762;
	Tue,  8 Apr 2025 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2lSHB/GB"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582127CCF2
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117149; cv=none; b=ala7bjIs3STjtYXbK53kMCQUaq1Gujitg3MTV4VSj/YmgLoBbAzDpJNkPHgOmVFpG40JXenJczWq/JPhAo5e68mdoAR6mT/eQi14PmAANRaRuhCRdt4DgA0Mb2NUGs1zHX0A8xwjkKzT3VPAWhMk2bZArTLmlI5Bzxb+pslZ+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117149; c=relaxed/simple;
	bh=4SLJzvzR0S1SahpzMZww36hf4yU3Wn0X6J07EZsTNOI=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=G7fi3KL9PfAkAB1Vuy9YLssGA1aaJ99ld+eBGWy2vvEed1rzg9W4y7QZfZGfWaCC+LM2+c5OxNdOSMpoGhD02Br7QOJzsWTniL9QUa5bjfbgkESLK9/82Myuf6+dLFUx5GRL4vhRGnn2rXXG3URgENfym7c9032DoxTAdyaGfpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=2lSHB/GB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f74b78df93so67252327b3.0
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1744117146; x=1744721946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=er1cvijfk/qtqrLJvq3BaG+utlwHxxJl8y/1dc1tZz4=;
        b=2lSHB/GBdyuG8f7y97mPmZEPmLVfqHMUU4d//xSXSXWQlDC/AlgdQoNr4bU6lBtju6
         1cpgM0EwgxB/xVxV1bW9LM5D0jg2o2DTAIfaFN2ZTYHueG2FcDNS/KxtWOQHJSDK14jS
         1/6IDTl71fO7+3c6BRvdWgIwLGR/ImG10uCUY+ENrQsYb1osHBE+GPa49bVwVVo4/M6L
         xqSqChYQKkWiq5WIGJGCTOq0TBiMqy8lbHSXTexMJijDKaw4ZYcc3hLbWufRnSrXZUSj
         KAWE0kN9Dw08/GHg8bucWk9yxfC5++r4o3UJ2J6Co9/Gjs7z33O5GCbGVpDE5MaGGMyg
         nPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744117146; x=1744721946;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er1cvijfk/qtqrLJvq3BaG+utlwHxxJl8y/1dc1tZz4=;
        b=HybMAXZsogWEzLRyjgdXbK2yaJCBg6TyNONTmu6pfMt7Erdaw4oROgctRN0/X1UExf
         Mcrn6f0d3S2sh4Zp/WB6vVv20tPL0hfNAF4TEDGW+L0loCFRHMJUBQlXNodPfRDH9ppW
         GWaTB3jixaGoCCbmVi1i+vaymlLH8xtii7LY784CatG/drgJ9aGMkrTTeVdaIFOulMnh
         Hv14hg193Uz9ImywnvzCjMsDBlsCdS2p5ad/HS85YzekNI3CzrUxZD1bVPnFU9+cjm03
         d76qE4Kb5Ps0EDIz3h+vrvdiMNXfc2zK1bZDMou4GXba3HIZrlhgk2XZ1aqpM0vs8DfI
         sBlg==
X-Forwarded-Encrypted: i=1; AJvYcCUh9CYGa6HUYGWJE1v4NiCCvYOhn+pFcVHJR38PxPmYk32XmCzV1V0MGRKsG2E8uY3NgneSmkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfb7Ls3Q60bNJsS3RtmkO/s/qJZYwtSRMOqJJQwIVBp4ZYyvo
	9HnwYBTNQ+/Vat7Dm7bs8EgIQXm/DVlbgLK/iTXL/4JFqGiBc7H/9jJnd8NOEWLJ4RIVyVG6puQ
	Wr1zeXqxJ5WdR9re3LTW6WgrzljbNyhDbRE7m7w==
X-Gm-Gg: ASbGnct8KWBMYClltYWmCEGT+MvxYdNC632KHu38Bx94VxI5+MD8lddT1hNJR5LqhoF
	UBdrmxLUdTGk37b62T/ViYYEu8/zaCt8iVbBaTeiKqz8obUFRHuvOZ27gqeEzybm3NoASwBrVFn
	3U7LatqvF6Yo0tg/RBMhDs2jZt
X-Google-Smtp-Source: AGHT+IFanpD6FOT92A3dLfQR+GVg62agTZeT+RLaYT6aC8H5CQvzH4yJq+NxSUNyDwB4s4r7FjYCvO+H00wpJQIoTjY=
X-Received: by 2002:a05:690c:6c0f:b0:6fd:3743:1e31 with SMTP id
 00721157ae682-703e3194239mr298568527b3.18.1744117146264; Tue, 08 Apr 2025
 05:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 05:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 05:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Apr 2025 05:59:04 -0700
X-Gm-Features: ATxdqUGLxr6_qMw156Ncv0-n3ZHJzqAzfZDawWRdKop26E2uF452ixbYMPvX8K4
Message-ID: <CACo-S-2-nFk8WzfByez7nZd668z-p0rSnEU+3XqZCL-Dc3g8ig@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) in vmlinux (vmlinux.lds) [logspec:kbuild,kbuild.compiler]
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 in vmlinux (vmlinux.lds) [logspec:kbuild,kbuild.compiler]
---

- dashboard: https://d.kernelci.org/i/maestro:d8582423f1574ae10cdbf6f1574cd2d49264d0a7
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  8e9508dd93587658f8f8116bc709aeb272144427


Log excerpt:
=====================================================
arm-linux-gnueabihf-ld:./arch/arm/kernel/vmlinux.lds:31: syntax error

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67f50ceb6fa43d168f278da2

## omap2plus_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67f50c246fa43d168f278cf0

## vexpress_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67f50c296fa43d168f278cf3


#kernelci issue maestro:d8582423f1574ae10cdbf6f1574cd2d49264d0a7

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

