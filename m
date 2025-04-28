Return-Path: <stable+bounces-136944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93CA9F900
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB0F1A859D1
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D029617E;
	Mon, 28 Apr 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="fjv2+hk0"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B929617A
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866748; cv=none; b=i2tRUu42DoXg261RaTkKbHGAXbEoh4aVdj/ugry7koN++mq8CuZtAyX2MPBFBicHF82B/DFwpdQHw4sGlprNUy732wVr0Y+Cp4KqV1vVqlKrR27Y5YgUeph5K1QKC3/LY575Wg/+HAzP0Ad8UbpX6S44QkTYKa+bF3OHoap9TkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866748; c=relaxed/simple;
	bh=8VUsPL5JI2RXeM5lzMGE1oXtQ+3+Y1Jrlg2tgNLbQ+A=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=VyrtAWjNAB42lBzuBRXznpDZFMUi6wDR+yyuhNJLSZA/mV+2L2a0zw2Hd48fRWQxSwqGujnQw6UEhdvPEjkI/UiRA58FD0tVUieCm7xaBHIYXX0PuBTy7VLdC3qV33utwkASjPKjuaw/q5EBOwJkTR1+AKtTA+7rpJ0GJhEm3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=fjv2+hk0; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e694601f624so3889854276.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866746; x=1746471546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZczNwsQuVFBymRITgJ3Uy4TB/In77PU0ufJKZCqkJw=;
        b=fjv2+hk0PnzjbWnWu2k5+6ImLk6m5PCfVR13hC/hc3sGSZ3drIvM02hWnSdBKHsSOe
         fQwyIX33CRfwbYG6GCp2YOL9rHxVbIOsz8inLDfckdOfTJMqIXIwN0wEIQpX6sr7bNMH
         Ysr6gO9lD+fYg1sEFmKn6cy86CQxr0pJZcbKsao5ByG8QpPBrGwTFxmMuQ6hk+d9bcrC
         EbymjxdWlBWIzwupLaGX0MbIL4DCsTw60CTKPHSIs7MxyXfWwn+7vYUCe7t6ohsURkGJ
         icjlinZk56KX/skzCmsW87UuiFrdIUyib76+/ts/4JoFOwGz+f9rnxPepBn1B0QNEtMx
         z/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866746; x=1746471546;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZczNwsQuVFBymRITgJ3Uy4TB/In77PU0ufJKZCqkJw=;
        b=tFn86UolcJGfNNnMYLpe7klk3f/8Mp6h6LlhSlQQ2pZRUQl+FzTaarjIBvyftEg5M2
         0S2lITuAkpZHDZWAT60cdtSO/p++V7sREYEHqWyqKEc244sPnTZYk3Y+LLkXU7Nnqi7m
         6oZS6fBCdIi8OeqV8koN0Y269OOQquHrRilS7c7W3dsmtLR3/W5R2ntG+6+fnUXI2ngq
         nVKp1GyHIHF7wFEBcyf+kT6FBeuNjX2sYTDfYIGTeXnByGfm9IZFDlbwrLQUW0ZZ1IM/
         XCYjMaIlRWID9Fm+HOnRvayKu5BStzzn0NCZSA3GEy535UGAsNkqqkkD+/cZHX/sTdhw
         ad2A==
X-Forwarded-Encrypted: i=1; AJvYcCWuLs0WRf55Zd5S+vl934YuViEbx4stryBH6w3RarPFMgCxi/6Tcq35fHmeabx2PGXbxkAvQC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWh2s0kZkBOoTP3sgWnwQh97HAlb+F9UTR/7B3BnCfvPw5Ac/G
	BgDBQbkJqxYKQzu/4Z+YWHBzA04CkeRRJKV1Kqx77RtDfNzWpOXxUjPf/c0Bs4IrSttzdhBY3c9
	+bKnbP5XrDjFKZPNCF7CbDQek+XzspPqjhiI2KA==
X-Gm-Gg: ASbGncsU3r6MzSRDkh7na5Oq/eFTI60QXpdxr5GDtA5S/AVdQ09qaock0xAvC6qhaSU
	nPKFgyFLdFBO39GghyFClzRpoccy86gf1G/wQlmCYymDsvUuvr3v+KHWoU1688ZW7gRBCA08z6z
	/WJo3OweTjXgyUtr4jzQZL
X-Google-Smtp-Source: AGHT+IGAGsWv6kP7QY+EL7LqLWCyWgdJXWHM3QrT9DCDw8itck6a6tK5/+dab1Tgji3m5wMvChbgjIO57nNirBsHssk=
X-Received: by 2002:a05:6902:188d:b0:e6d:eb74:25e with SMTP id
 3f1490d57ef6-e7351a00579mr101753276.25.1745866745736; Mon, 28 Apr 2025
 11:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:03 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 11:59:03 -0700
X-Gm-Features: ATxdqUGmu32iW7Ji7r8aZ9rNmcIi46yWNv-WXPUl15DuoheXj9ga5G3yEHW-fXo
Message-ID: <CACo-S-2eh2fTUfGzHsTZNK63JOw3fK0KeLN8syNvSZoKoQeJYw@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) use of undeclared label
 'err_put' in drivers/usb/chipidea/ci_hdrc_...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 use of undeclared label 'err_put' in
drivers/usb/chipidea/ci_hdrc_imx.o
(drivers/usb/chipidea/ci_hdrc_imx.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:0f670a2992fd569c8e6d89a8144eab56c6e1abfb
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  bcf9e2b721c5e719f339b23ddfb5b0a0c0727cc9


Log excerpt:
=====================================================
drivers/usb/chipidea/ci_hdrc_imx.c:402:10: error: use of undeclared
label 'err_put'
  402 |                                 goto err_p  CC [M]
drivers/rtc/rtc-fsl-ftm-alarm.o
ut;
      |                                      ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:680fc01743948caad95c0ced


#kernelci issue maestro:0f670a2992fd569c8e6d89a8144eab56c6e1abfb

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

