Return-Path: <stable+bounces-2566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162837F871C
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 01:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3A8B214E0
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 00:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD78199;
	Sat, 25 Nov 2023 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0EZOoSl6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7CB1702
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:13:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6be0277c05bso2191913b3a.0
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700871218; x=1701476018; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aZJD9TJGaaQRJrei9TgI3t1f1Wyfpeha2c0TbIOrAD8=;
        b=0EZOoSl6ckuQDJpwIA6KE0JDAFr62pUIU641Jw17d+M6pF0PY5HzP9PL2Osp3pcp2E
         zlrfEx5Y+Dnr7C976Ojt+N5OlqKu1L6+F45vc86kfyTKDZP8bLr11Ie5inldP96/Ft1d
         8vPXOiYlx/9DO96qqum2s5b2zaMt/7Jcv4dyH1Nr/fKzePb8wKKwe+C7dKhpBkjRaHjp
         acHH7/YMRtoU3RYWZQu+0G0gg70QmTSRZbc68QCeYQeR3NL4KyIDOXGGemfoi7TNyG3L
         z37uBgU9d05Yv+81VWOVyi4ZhCrxs3ochqbB3G68hKrKLZG3UXnfdP7kV2xVD33djq4J
         x6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700871218; x=1701476018;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZJD9TJGaaQRJrei9TgI3t1f1Wyfpeha2c0TbIOrAD8=;
        b=t/t/JXGPZMk+RAqPKsS/eahT+VDaJE2GtCOIHvP592YD9RtjAyUOMZcN0hExt1Yt18
         VUO3KGQs090QOVoax3xSpi1dbLuwiWfdJO80pJHDMkpeowWXgvNE2ZO03+61kWbtiS3s
         IkRx6uM0/mRlr68SkyJONndmx53dKwWYi831ffOwffcm9JljfqNDgeHENFzzWnxEM3Y4
         4MiclsLfOrXXeCXtbEoWDd12Wu0MKZ65dQK59mXIr2TBlS6VJ62/UapOU3YMDy2vu/d7
         vQK7xV2sU//a8+W25ro41p1hkJW2ddKqLWlUTLtBSalSCYqaXUW5jXdNcHfg56Fn0Eea
         duYw==
X-Gm-Message-State: AOJu0YwwLK+bMd4MpVtWOVcfxhtBv02jmwOOL3VkWLTCiysCO3Dtvhgx
	hw6qgcBOoG7RqjPT1hYIBgVGkmtIvFWAipbJXt4=
X-Google-Smtp-Source: AGHT+IE8TU5xQMj0i7DwliIrhjYAxPTlafNzmzssEAUjkgPZ8xXSWyaxRwOxx9dO6e84yi6F+p+5MQ==
X-Received: by 2002:a05:6a00:3312:b0:6bd:7cbd:15a2 with SMTP id cq18-20020a056a00331200b006bd7cbd15a2mr5123485pfb.26.1700871218293;
        Fri, 24 Nov 2023 16:13:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7810c000000b00690c52267easm3342579pfi.40.2023.11.24.16.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 16:13:37 -0800 (PST)
Message-ID: <65613c31.a70a0220.c9da0.8c39@mx.google.com>
Date: Fri, 24 Nov 2023 16:13:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.299-97-gfe3bb28dbe2d0
Subject: stable-rc/queue/4.19 baseline: 55 runs,
 2 regressions (v4.19.299-97-gfe3bb28dbe2d0)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 baseline: 55 runs, 2 regressions (v4.19.299-97-gfe3bb2=
8dbe2d0)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F4.19/ker=
nel/v4.19.299-97-gfe3bb28dbe2d0/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.19
  Describe: v4.19.299-97-gfe3bb28dbe2d0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fe3bb28dbe2d08170a833ae1f6bde4262f2799db =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6561096819757eafc17e4a6d

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.299=
-97-gfe3bb28dbe2d0/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.299=
-97-gfe3bb28dbe2d0/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6561096819757eafc17e4aa2
        failing since 2 days (last pass: v4.19.284-5-gd33af5806015, first f=
ail: v4.19.299-50-gaa3fbf0e1c59)

    2023-11-24T20:36:18.423211  + set +x
    2023-11-24T20:36:18.423688  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 270682_1.5.2=
.4.1>
    2023-11-24T20:36:18.537640  / # #
    2023-11-24T20:36:18.640801  export SHELL=3D/bin/sh
    2023-11-24T20:36:18.641625  #
    2023-11-24T20:36:18.743669  / # export SHELL=3D/bin/sh. /lava-270682/en=
vironment
    2023-11-24T20:36:18.744449  =

    2023-11-24T20:36:18.846488  / # . /lava-270682/environment/lava-270682/=
bin/lava-test-runner /lava-270682/1
    2023-11-24T20:36:18.847879  =

    2023-11-24T20:36:18.851347  / # /lava-270682/bin/lava-test-runner /lava=
-270682/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65610b76d99f877a147e4a74

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.299=
-97-gfe3bb28dbe2d0/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.299=
-97-gfe3bb28dbe2d0/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65610b76d99f877a147e4aaa
        failing since 0 day (last pass: v4.19.299-70-gb7330b98ae65, first f=
ail: v4.19.299-97-g7841746109202)

    2023-11-24T20:45:17.814086  + set +x<8>[   13.315406] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 270698_1.5.2.4.1>
    2023-11-24T20:45:17.814560  =

    2023-11-24T20:45:17.925401  / # #
    2023-11-24T20:45:18.027624  export SHELL=3D/bin/sh
    2023-11-24T20:45:18.028262  #
    2023-11-24T20:45:18.130122  / # export SHELL=3D/bin/sh. /lava-270698/en=
vironment
    2023-11-24T20:45:18.130769  =

    2023-11-24T20:45:18.232698  / # . /lava-270698/environment/lava-270698/=
bin/lava-test-runner /lava-270698/1
    2023-11-24T20:45:18.233565  =

    2023-11-24T20:45:18.238531  / # /lava-270698/bin/lava-test-runner /lava=
-270698/1 =

    ... (12 line(s) more)  =

 =20

