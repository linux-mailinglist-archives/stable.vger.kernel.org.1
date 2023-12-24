Return-Path: <stable+bounces-8428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D384281DC5F
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 21:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6164A1F21643
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3CD2EE;
	Sun, 24 Dec 2023 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KpZXWfhJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59DFBE7
	for <stable@vger.kernel.org>; Sun, 24 Dec 2023 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35fd9e40039so15671175ab.1
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 12:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703450726; x=1704055526; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M3Uy3bprJteVg+3lKvGZPZ//VyHJe2768FomErTqWyE=;
        b=KpZXWfhJIpxb1SIBxq4+YMNBB+Tu9giNseVz0OUXfR8uZilpyPRptupHsyEh9eNcOh
         D5rxjNG4h/PYxBtCeP3UC8jO1kYKjy22lXYJcGt7Tmkr/G6gvx5SOa2jE5ok8Ll9icMm
         JSF1u0+SFCt1/BhD+Jz1wxNIJCXM7t5r7hLJeJiduBI9tJxjni7o+0z1+qxNOaPO8VJ3
         6T0DcTXVD3BKxjXj9gDxKoilPCapkop9MeiNd1MHhAEf2ahmi7UfklDe/8YqHfyqcsxj
         z4fDRTRCeYstHPNt7I/RwIlSkqlHHuXiMCPgwzIiUf2kILTZ32+fyYBaYLXNYNHUB5Ce
         TRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703450726; x=1704055526;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3Uy3bprJteVg+3lKvGZPZ//VyHJe2768FomErTqWyE=;
        b=BgcGV+kq+mtGlCb2VDw7m2Md07GCGK3o0nwGcPVhIFyEPeBaitjqs1YKTTiSOYIBzc
         EiRghwFggBCSppJ397EnWrZczAdATMm2n+SwiOTA8/fIfaDt1YIQoLYAes8MN/9L1l4I
         C+2iRAqN53vtOEQTeWNaCqV2rG6FG1XUU1b/LVzTdu3B6d54h67iKfRfp1pk/8yeMUuA
         Cef6zHch4KjYkfCZhXqef5hl2ef79ysswVwyTASSXWJjzHRttZ7PedVQ7MZAa6Qeyeda
         vZFI8iQgjxgG8K9OZRoX+oN/RojUCGQ7MmcK3ef1LZcvB4Q/ZQd9Zaxue16WFG5xKkba
         1ucQ==
X-Gm-Message-State: AOJu0YyATSX1/PJJd7bztZIbtK+HRauV3w6iZeYYOqKarjTmof12wxYo
	OGJRwzQIxCLXXzxxZSVflNaAj4ZPU6xlw4Xt2JB8trE/JfM=
X-Google-Smtp-Source: AGHT+IE7ZwZgG/ECC4sjx273cPUoG5whvDa/hIb6m8iGmH4AwGzhDFe+TFKzyp6i+Ei3TNWQkBQ2Gg==
X-Received: by 2002:a05:6e02:1aa6:b0:35f:d2ae:3b2f with SMTP id l6-20020a056e021aa600b0035fd2ae3b2fmr8879034ilv.61.1703450726123;
        Sun, 24 Dec 2023 12:45:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090301cc00b001d052d1aaf2sm627427plh.101.2023.12.24.12.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 12:45:25 -0800 (PST)
Message-ID: <65889865.170a0220.3e748.113b@mx.google.com>
Date: Sun, 24 Dec 2023 12:45:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.6
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.6.7-247-ga9715522c0820
Subject: stable-rc/queue/6.6 baseline: 87 runs,
 3 regressions (v6.6.7-247-ga9715522c0820)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 baseline: 87 runs, 3 regressions (v6.6.7-247-ga9715522c=
0820)

Regressions Summary
-------------------

platform                    | arch  | lab           | compiler | defconfig =
                 | regressions
----------------------------+-------+---------------+----------+-----------=
-----------------+------------
mt8192-asurada-spherion-r0  | arm64 | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =

mt8195-cherry-tomato-r2     | arm64 | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =

sun50i-h6-orangepi-one-plus | arm64 | lab-clabbe    | gcc-10   | defconfig =
                 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.6/kern=
el/v6.6.7-247-ga9715522c0820/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.6
  Describe: v6.6.7-247-ga9715522c0820
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a9715522c08209efd55ae0f87268aedf54b78433 =



Test Regressions
---------------- =



platform                    | arch  | lab           | compiler | defconfig =
                 | regressions
----------------------------+-------+---------------+----------+-----------=
-----------------+------------
mt8192-asurada-spherion-r0  | arm64 | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6588667813dae93e58e1361e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-247=
-ga9715522c0820/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-247=
-ga9715522c0820/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6588667813dae93e58e13=
61f
        failing since 1 day (last pass: v6.6.7-236-g5f9f9b8ff175a, first fa=
il: v6.6.7-236-g0ddffa163cd8) =

 =



platform                    | arch  | lab           | compiler | defconfig =
                 | regressions
----------------------------+-------+---------------+----------+-----------=
-----------------+------------
mt8195-cherry-tomato-r2     | arm64 | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/658866361c01b37bc3e1379b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-247=
-ga9715522c0820/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8195-cherry-tomato-r2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-247=
-ga9715522c0820/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8195-cherry-tomato-r2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658866361c01b37bc3e13=
79c
        new failure (last pass: v6.6.7-246-g9ddf911049886) =

 =



platform                    | arch  | lab           | compiler | defconfig =
                 | regressions
----------------------------+-------+---------------+----------+-----------=
-----------------+------------
sun50i-h6-orangepi-one-plus | arm64 | lab-clabbe    | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/65886569131c2185aae13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-247=
-ga9715522c0820/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-orange=
pi-one-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-247=
-ga9715522c0820/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-orange=
pi-one-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65886569131c2185aae13=
476
        new failure (last pass: v6.6.7-246-g9ddf911049886) =

 =20

