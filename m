Return-Path: <stable+bounces-3124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6287FD05D
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 09:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF8B1C20991
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E72111BE;
	Wed, 29 Nov 2023 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="aR08WhkI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFE0172E
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 00:08:50 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfcc9b3b5cso27951105ad.0
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 00:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701245329; x=1701850129; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vBCVhuvWVrBXNzixJxCQvf1fZSd2316sazKsHirsvNg=;
        b=aR08WhkIHxi7wRc5r4LRjUpV7BHKLZJ4g1lVBFkhxron+q//ZlvYDq8LYtA0EY1J5Z
         EBaYMEZwLSI0jIKsrNyPxafm/ltpok1Dz9vlexn9dyqQ07jHqSdMWGDEZINA9Dpxm9mT
         PTQEFwRLaGYJQw6neOiQ52mqs7LRIRnGYAZ1+jnIvsvyFzZH1lHh6BjxpjJ9gvaJW27y
         BVs1WnxABJMxSXRdarsWx//ChFJ7gPB+IkyDXKqDWH5vaj+bRALpob79rIBg23ZnXNZo
         QRKK2VqgCybbPVzSoMO2OI/R/RF2fKivzC2a8ae7lctfOSRcHRdYTcRBJSogzHOCRAhy
         X54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701245329; x=1701850129;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBCVhuvWVrBXNzixJxCQvf1fZSd2316sazKsHirsvNg=;
        b=BqkNi6YaTgMf+KcV0D5WdTIx9PZVeV5YcavSYt/1JY18Ojcnzha0VLVSyDdDz6Fm9T
         NJK7EWD2yDG/Ep+6z6Auc+5UKI6ZupyhMpqfGdfEVCrov3JutKtq2dntry/iNIs3k/GU
         YfLjK4BDmrU8uzpyYFKmAsbMeSXPgTOi0+LL0aUmcnB5CYj9c0iug+l7M1CRuntx62Pb
         1a+N4agpEMojU1ZPMeOFyphEATC4nXyZk7+w4K6r9yt8RntNvOgaoasuzvpSvfaUPkjz
         fEhg6ZEb3bCQ+eB3tEJzKaLyZrLGWdlXj0+tU8Gwx/NHO2CB6bCirl/ihGN3oDSkqB+l
         OSgw==
X-Gm-Message-State: AOJu0YzxbRn3Dly2RPC2tR1sbhNFmHuySxRk4qFSo32QG7UlErljWgsd
	j/TBa37Q9h2ZwEFEOkdYZtKVBEYYSW2/N1NpMu0=
X-Google-Smtp-Source: AGHT+IGDsqIJ5WbW+0tjJzM+zfIEi5F/WXVdlYP2pKKh1RLr4rF1z/kmNgMrmLoSd3ORl9H9aiWbQQ==
X-Received: by 2002:a17:902:680d:b0:1cf:f3a0:3c6f with SMTP id h13-20020a170902680d00b001cff3a03c6fmr5146304plk.26.1701245329152;
        Wed, 29 Nov 2023 00:08:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001cfb971edf2sm7489145plg.13.2023.11.29.00.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 00:08:48 -0800 (PST)
Message-ID: <6566f190.170a0220.9a312.1b34@mx.google.com>
Date: Wed, 29 Nov 2023 00:08:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.64
Subject: stable-rc/linux-6.1.y baseline: 149 runs, 1 regressions (v6.1.64)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y baseline: 149 runs, 1 regressions (v6.1.64)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.64/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.64
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6ac30d748bb080752d4078d482534b68d62f685f =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6566c121972542290a7e4ad2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.64/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.64/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6566c121972542290a7e4=
ad3
        new failure (last pass: v6.1.63-368-g60c4064a8298e) =

 =20

