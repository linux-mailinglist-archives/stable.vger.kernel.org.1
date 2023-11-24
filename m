Return-Path: <stable+bounces-2559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5977F863F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 23:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888421C20DDA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 22:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A133090;
	Fri, 24 Nov 2023 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="qacfZTNj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8941707
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:43:49 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so1719329a12.0
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700865828; x=1701470628; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KUG/wjr0+t3YUf5BF+08SmYE81X/wOJgKvk+/sJbGxw=;
        b=qacfZTNjXgbdoLpYxZUk6sFZLB2Iz9BtuCc72CaH2NIiLGDV+KF2HvWebPMPZO6vJo
         W21s00BQEPlsPYqBSVaTUEe6YBUJs4MmxzDrt0rJ9GR3bepteLQQTRuDJl33I8eBK4cr
         ibDawXF2hpHSLonGJShGLgxWkAGe1lUaM8Ez0YCUim5yn0rmeIpKrErVFSusBuyP8BGh
         CPUVrTS6U1QJle02a4kHoTFE+cQZ17Xr0MJGRMzhPF9LzedzRhOFYMEnWvhP0qftWPSj
         E4x1JBCpOweGT39pnxA5Oo6gMKMkwmYBSfuET1dyZvQO7E7UBuiXYjZOjihENooRSfZq
         F7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700865828; x=1701470628;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUG/wjr0+t3YUf5BF+08SmYE81X/wOJgKvk+/sJbGxw=;
        b=HmOT/H7mTUmXggnp1Y02lGPJ26/YWV8OgHs4nW8A6xXHtO8TGp3/mxLNZko7xeaBGP
         Id09tsN5E0f6/CropO1hWQBRudsFTmwSM/lEfIwGPDqKZsDJjn9NUxGyU6tgdFiK2q5N
         UGJxwitmBVpOsMfVmBv38YggGhXBS8wXZiwIa/3sW5IcA9Fs4+akm3J5nQkYDE5tXFOw
         ENOUIzyiK82CMs1szDIjADDzHAavmdSmGmT/MTp9LgnKJrphjsaUAuYyy3MkusshE90L
         3UOTKi2/XLA0KaaRjgHnnXzYiC2xkeOYojL7xSSMbiRYNKdDLEof+HDx7hphzzgLVSo5
         Vaag==
X-Gm-Message-State: AOJu0YyJ+7TKPoxn51ehJM2VGW7VvPT1izT7lvXoi9FU7cAx3O/LwOjT
	+j7ImCTciDH44FAs3AlMV3W7mEoFlsi8GwqwIrg=
X-Google-Smtp-Source: AGHT+IHvmzRSWZkPfrx+q6172IKYWuMFeL6Dx0kRUWkpi7A1HOeglBLosjqV6ubbwiBGXeeycvcx1w==
X-Received: by 2002:a17:90b:3902:b0:285:5753:8c44 with SMTP id ob2-20020a17090b390200b0028557538c44mr5291829pjb.47.1700865827960;
        Fri, 24 Nov 2023 14:43:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a195700b0028596286f5fsm1237855pjh.6.2023.11.24.14.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 14:43:47 -0800 (PST)
Message-ID: <65612723.170a0220.2c482.39aa@mx.google.com>
Date: Fri, 24 Nov 2023 14:43:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.299-98-g859b6f4860d8b
Subject: stable-rc/linux-4.19.y baseline: 57 runs,
 2 regressions (v4.19.299-98-g859b6f4860d8b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 57 runs, 2 regressions (v4.19.299-98-g859b=
6f4860d8b)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.299-98-g859b6f4860d8b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.299-98-g859b6f4860d8b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      859b6f4860d8b2f7c5b502c0939301b21742012f =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6560f5b56f5f4cc9ad7e4ab4

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-98-g859b6f4860d8b/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-98-g859b6f4860d8b/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560f5b56f5f4cc9ad7e4ae2
        new failure (last pass: v4.19.299)

    2023-11-24T19:12:14.522513  + set +x
    2023-11-24T19:12:14.523041  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 270469_1.5.2=
.4.1>
    2023-11-24T19:12:14.636391  / # #
    2023-11-24T19:12:14.739340  export SHELL=3D/bin/sh
    2023-11-24T19:12:14.740107  #
    2023-11-24T19:12:14.841995  / # export SHELL=3D/bin/sh. /lava-270469/en=
vironment
    2023-11-24T19:12:14.842799  =

    2023-11-24T19:12:14.944716  / # . /lava-270469/environment/lava-270469/=
bin/lava-test-runner /lava-270469/1
    2023-11-24T19:12:14.945956  =

    2023-11-24T19:12:14.949684  / # /lava-270469/bin/lava-test-runner /lava=
-270469/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6560f7817c911fa4617e4a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-98-g859b6f4860d8b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-98-g859b6f4860d8b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6560f7817c911fa4617e4=
a76
        new failure (last pass: v4.19.299) =

 =20

