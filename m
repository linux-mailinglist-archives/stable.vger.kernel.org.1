Return-Path: <stable+bounces-3109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1619A7FCBBB
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 01:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4774E1C20FA5
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 00:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F39374;
	Wed, 29 Nov 2023 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="LdrIfr91"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC4219AA
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 16:47:39 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cbe716b511so4667711b3a.3
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 16:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701218859; x=1701823659; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/d9ub6jtxnYwkoy2+JmlBO7xk2gXXov0XQ5xyeHNDTs=;
        b=LdrIfr9133Xi2VdwqDpGyveU5lssGFjNFlMu0drtc3CSUTNIDG9QH5DBbVkaWY052H
         uvSoVbhYSlemUwMNvvGJ0SYiB8UdgUY3gef2v1/Vvfcsl8XjCqOdo7rdeNSQOOiELLAO
         uRrx5IwCJMVJD7HNSy1Mww8PtXGNH1ZNPpmzFu29VfKMlW2zSL2LyqOb5xcDEXNyEhdr
         Xal93AXZc0BhCP/eh1INheSsw6zJlgxyy1WUn8vwNwRVzHr10RZlRtiXf2lxSuSyy1kr
         VDRnWf5enuPY4wK1v9md2DwSdm4MrUphKFubNdsvllIJzfBb3R5Cgebfq3wZS77KBDDC
         7/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701218859; x=1701823659;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/d9ub6jtxnYwkoy2+JmlBO7xk2gXXov0XQ5xyeHNDTs=;
        b=ORrk2uQC0OYrFkSQAFziVAQ+UA075cfSjkWx5vpny6uDkOO2HY/Oh7Fo52XAdq20DD
         NaRjQoDtjb/pa7jCpF9FengGPES3WjjFVeeYrLFrf0brbQOzeexUcrsHzbMO3Vjc+9Cb
         IC07AYXZYLnS7kVWfKHo/N/iEtltPGQn+tLWXsiSETRCD3sO4Isn3Ky7Ib4xccMwO1Yf
         f7Zy7cZcwlXW/5UOQBzf5lBYKJFOrPsJRv40HdtlLjl+jSaOK/uUTbTbByi5sv61pMus
         5+F7H2+7Km3mmbpohgveJUDu0YFqui9TkNZr/x+8dpgAXGA4DqHQQJR5usIkTNHxQj+S
         w0TA==
X-Gm-Message-State: AOJu0YySRc+N11h6CB/mXt1BscpDoupeyArZWUbubai6mnluGew1ydZq
	gHETbPRNh63i7gnC/AOdJr1rJOb8WKnb50EZ7xI=
X-Google-Smtp-Source: AGHT+IEXnOexmGPnH1zCnZRDdEIIlfoXGIUDggLMeGov2CMRLQIuj/S44Fka/9VABVU/1tt52P9prQ==
X-Received: by 2002:a05:6a00:2918:b0:6bd:3157:2dfe with SMTP id cg24-20020a056a00291800b006bd31572dfemr17869300pfb.7.1701218859091;
        Tue, 28 Nov 2023 16:47:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ey25-20020a056a0038d900b006c06804cd39sm9564398pfb.153.2023.11.28.16.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:47:38 -0800 (PST)
Message-ID: <65668a2a.050a0220.ff32b.8793@mx.google.com>
Date: Tue, 28 Nov 2023 16:47:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.4.262
Subject: stable/linux-5.4.y baseline: 135 runs, 1 regressions (v5.4.262)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.4.y baseline: 135 runs, 1 regressions (v5.4.262)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.4.y/kernel/=
v5.4.262/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.4.y
  Describe: v5.4.262
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      8e221b47173d59e1b2877f6d8dc91e8be2031746 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/65665965de56af3c327e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.262/ar=
m64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.262/ar=
m64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65665965de56af3c327e4=
a6e
        new failure (last pass: v5.4.261) =

 =20

