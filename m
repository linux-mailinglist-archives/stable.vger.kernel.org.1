Return-Path: <stable+bounces-2857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4267FB163
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 06:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B6D1C20BDB
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 05:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8E310791;
	Tue, 28 Nov 2023 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UMGT58w2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD6EDA
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 21:41:38 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c2139492d9so2993411a12.0
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 21:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701150097; x=1701754897; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mtf1dNF3tKOyzG0PsDMDEUtXSFlrLGcaReltYL/Bf70=;
        b=UMGT58w2nXrjLBrKX6dBtw4m29ZUskhxBYLES7cUn9xSs5R01jwhpMvAMlZL1MpHYZ
         mfpvese+FbT5+bT5lK3U5/o4aFD5+rsTBWZ4aGIeYTiyT/IQBF2XzLzOGTP39owmv+3Y
         KqjyC6x30GWXMmTeeS5iqhguLdxsqPvXOUzGaR3xOkvRqsE4cfDMKQhcrD0byRd+ME8i
         byE9PdFjY4vQPNPoBSogJjVW6FPWz0tm2nUCuntpgHirZNpZu/Mz2851n+DQWMoOw26J
         KxY5cSOFjWSGnghNntd5RCG9tSL2X/NSXymhvwuh/K9m0p5pTACfi9mHDix47akm3bZu
         b5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701150097; x=1701754897;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtf1dNF3tKOyzG0PsDMDEUtXSFlrLGcaReltYL/Bf70=;
        b=v+VppOEIiMNr+xptqppzIn1nhZXi8kGse+K1YKbftYHY2eXuoYn3YFQbgPw3e5ofc8
         6hTb/xj1wo8zNFDv+t06Yrg9WW2NtA399Ugjr9lqo29BicwdukqK+fHB+atbi9vl5fMq
         qD5MLTUwde418Ljq/br/XK43qNJHZe8R9qo2PToJOR4b4P48Vim+pX1o148D4tzMaPzz
         VDippfEDDFvHDn9D2oXMCE90rjvrHrsN/t5F7xouI5hFlAIenU4RjkKUtdUQiRPSXBof
         x0JXvT5kQZbfSz+cUi2udsS6W/R3VOzfjtSGskVRC6MqoOsps9nSv+3sjir7qijAFoOE
         eyhQ==
X-Gm-Message-State: AOJu0YzQ/rXH07TrdQ2MV7SkLPjtUlbHinr1fwyj6ox9HK/eL1zYc4Ox
	KxdffwDuB6QxX9BK/AqUf8+EdTAAt2N53N8Mi2c=
X-Google-Smtp-Source: AGHT+IFSLEK/OrnP5+tQlGc2jN4GrtCViFJkPnPX7yUdVnHQANptH4nd/G6MkurIzKavOV9QwP5/RA==
X-Received: by 2002:a05:6a21:7894:b0:18b:a5ab:bb0b with SMTP id bf20-20020a056a21789400b0018ba5abbb0bmr12397442pzc.62.1701150097431;
        Mon, 27 Nov 2023 21:41:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jl14-20020a170903134e00b001cf6453b237sm9256593plb.236.2023.11.27.21.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 21:41:37 -0800 (PST)
Message-ID: <65657d91.170a0220.f16c4.69e8@mx.google.com>
Date: Mon, 27 Nov 2023 21:41:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.139-292-g659e621811001
Subject: stable-rc/linux-5.15.y baseline: 143 runs,
 1 regressions (v5.15.139-292-g659e621811001)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.15.y baseline: 143 runs, 1 regressions (v5.15.139-292-g65=
9e621811001)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.139-292-g659e621811001/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.139-292-g659e621811001
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      659e621811001944973a85712a1f1ce31200daec =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/65654b744c5dc9d4457e4abc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
39-292-g659e621811001/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-p=
itx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
39-292-g659e621811001/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-p=
itx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65654b744c5dc9d4457e4=
abd
        new failure (last pass: v5.15.139-293-g0dd3c4f0979f2) =

 =20

