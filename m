Return-Path: <stable+bounces-4729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13283805B42
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 18:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2607281A01
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70468B80;
	Tue,  5 Dec 2023 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="BtKBWKw+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9D9D3
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 09:42:35 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d06819a9cbso24310965ad.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 09:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701798154; x=1702402954; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QC8DRKUWtbeDY+WcaT9NrdZ6icKm5FrVI4K/8y1H7DY=;
        b=BtKBWKw+p+Giq1LI8s3LgV/GuuJu7MV2etygepVlqe9D0VwseJVvPFIMUuUvVDQ4ZY
         JrZqiG4wDFBO5+PutxctVSUeZxPgbJ2wECDI5ev2iuzZVLLvYppw13dLD2/MsNpOKLzy
         NvoZRad40ldPWUhkTyPkUP+7g0YSNf/T06+OLiIQvrzMf2gmXtnnp4p3RQYw7yTRHvpx
         gFwSKzqYXH3sLKVT2xbLbH9BoQUDiYV9mRtK4qDg942F7vxt7ZzetGkqayPsCShIBDF3
         MuJs3/UM8Xse0eZzMd/TuD32eJCFJtnGc/7Dnpxm01OzA+WLXS7AQDpZu3dYWn939ZRM
         DHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798154; x=1702402954;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QC8DRKUWtbeDY+WcaT9NrdZ6icKm5FrVI4K/8y1H7DY=;
        b=UsQ8ETsYP36sOd3BnEPDSVjlsUxfiMgApMRq6w1A5mKfY8G8zTzRZXsdHUijOs8XZC
         GtTWvvMVx2OrDYvVjqzmHw+mK+jU8U1L22qttY593HaMJeIOqhdxSdHl6XRSW7BAPcA5
         Z4b63Ol7KE1BOb/G/ma/sc3Ns8GuYVjDiuijuQUSKio1a6GXoCv2b1LjtKN8DRym2LNC
         89jdv8km/EmM+QlcAzONJsJC9vwzSQYYeVx5um4gQqYLnX6Gm0IkhfKxHdULTjHCYQ/8
         6Ch638v00RO1kZlP/ZifGPxZTk05/KtH4E1sg0NDVKQOl6SYkZjr6eEqfcEKqnAbr4H8
         c1jA==
X-Gm-Message-State: AOJu0YxT00x0Yj6KwqAh5YmQe/Xm5Bgob1wUOpQ4jXEKo4GXg2AYZEWa
	6ajegj9axBsOsiPZDqC4MA2CAFthyiIIj0rTy7gvOA==
X-Google-Smtp-Source: AGHT+IH1xRCNXcqEZ4dg+HSKwwFtRqb2OlDZf6BkYp7qs/aFlzYtJcD/t+Zkmz9tea7urrtSBYgjJg==
X-Received: by 2002:a17:90b:390b:b0:286:6cc1:26c with SMTP id ob11-20020a17090b390b00b002866cc1026cmr1445236pjb.55.1701798154559;
        Tue, 05 Dec 2023 09:42:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bg6-20020a17090b0d8600b00286558ad352sm8266311pjb.8.2023.12.05.09.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:42:34 -0800 (PST)
Message-ID: <656f610a.170a0220.6c965.7340@mx.google.com>
Date: Tue, 05 Dec 2023 09:42:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.65-108-gc1e513337d8b
Subject: stable-rc/linux-6.1.y baseline: 140 runs,
 1 regressions (v6.1.65-108-gc1e513337d8b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y baseline: 140 runs, 1 regressions (v6.1.65-108-gc1e51=
3337d8b)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sc7180-trogdo...zor-limozeen | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.65-108-gc1e513337d8b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.65-108-gc1e513337d8b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c1e513337d8bc4364ceea88e27b9398de2d18f58 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sc7180-trogdo...zor-limozeen | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656f2e94ad8666c763e135bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.65-=
108-gc1e513337d8b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-sc7180-trogdor-lazor-limozeen.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.65-=
108-gc1e513337d8b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-sc7180-trogdor-lazor-limozeen.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656f2e94ad8666c763e13=
5bd
        new failure (last pass: v6.1.65-54-g51afe13792d3c) =

 =20

