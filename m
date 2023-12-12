Return-Path: <stable+bounces-6487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3933380F5A4
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 19:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF94B20DD3
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C07F546;
	Tue, 12 Dec 2023 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="c4gfaC8Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC9BCE
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 10:46:38 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-28ad44e5d5aso424485a91.3
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 10:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702406797; x=1703011597; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qlpo8CUysbutpbVG9tA4TbQt88DWc7+TPXpqWZzjKUg=;
        b=c4gfaC8QbhYbcm2flY+NTdpDlEgJzZU71KiEHU51FkpHaA8ZUcZaNZqDy53o2QI99/
         rOBKqwK8Yy/X+6TqC4MPh5qLH7xVil1ERfql31qc5mlUQdrTCGicIK/os4x/iglKlmUJ
         whP6H3La5UKnFqF5mXy2Jwu0cv27jpFFkdju7N8yCka9evK/ScOM4yfF0lRuR+b4WRR1
         hlggH1VjduPNl/wtT1uMfJnNZcmGi/LC9e8TMy4bHMO69goEjuT+17LKvZYlMVU9MA3c
         O7kgjNx+GaHEplg2l2cs8SHQHPaAUb1GFmhT12jzZcexAQvM0ZYX2XCPaq69GvQPzZck
         zXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702406797; x=1703011597;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlpo8CUysbutpbVG9tA4TbQt88DWc7+TPXpqWZzjKUg=;
        b=tISOeeffDwBsJ41ZCHKHUIU5FtEX3DxDt0EW61OBjIUKIJUwTCgZlUBWKYq02h9uoz
         cwnd2pri0Ckbbxm4VCw9Fb6I8AafYgWE2asKj4vXODxh6fcPwTWhw5pBGLwjglJL2Qp2
         FLz/3/tG1BYEKwDfC5WDYQAJ9hFshT4piI/G48fSF8h/cpqkHCkidF+DxNg/rK0L/jou
         k4F66C4KZ9d7G1l2TDv8lF9vAXOJKCqKhhFOLFMXAo5KmbYoKjCmBcr2pwYJufWX8tBQ
         lD1r9XxgVlqvRXi+gPtkIhiJo/qU4dC9a+zrwiDVRe4HNY4yVrskqYdnO0si0M8LgoyV
         oX/g==
X-Gm-Message-State: AOJu0YyK7YpUUYoixYywI9iw4zkkoRVz+Ah04FqQbDU4rcZgU3lLL9oC
	cEkou7XqTJDzin+Qmr6Xdt6Q4CpC0Jwto4iLCnwNWQ==
X-Google-Smtp-Source: AGHT+IFViqWG6XnEr1oitfV1s2CwnjFhJ+vNpY6xMbArQUOR447XLbsm7sthB5MB+xbhAWYrqsHutw==
X-Received: by 2002:a17:90a:2c84:b0:286:6cc1:77f8 with SMTP id n4-20020a17090a2c8400b002866cc177f8mr5359784pjd.59.1702406797619;
        Tue, 12 Dec 2023 10:46:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a5300b002802a080d1dsm10285108pjl.16.2023.12.12.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:46:37 -0800 (PST)
Message-ID: <6578aa8d.170a0220.fe598.f920@mx.google.com>
Date: Tue, 12 Dec 2023 10:46:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.301-54-ga7780f896379d
Subject: stable-rc/linux-4.19.y baseline: 95 runs,
 2 regressions (v4.19.301-54-ga7780f896379d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 95 runs, 2 regressions (v4.19.301-54-ga778=
0f896379d)

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
nel/v4.19.301-54-ga7780f896379d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.301-54-ga7780f896379d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a7780f896379de16bc4e805ecf216959b5b876a4 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/657877d272d384581ce13476

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01-54-ga7780f896379d/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01-54-ga7780f896379d/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657877d272d384581ce134ac
        failing since 14 days (last pass: v4.19.299-93-g263cae4d5493f, firs=
t fail: v4.19.299-93-gc66845304b463)

    2023-12-12T15:09:30.875258  + set +x
    2023-12-12T15:09:30.875789  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 345181_1.5.2=
.4.1>
    2023-12-12T15:09:30.988081  / # #
    2023-12-12T15:09:31.091258  export SHELL=3D/bin/sh
    2023-12-12T15:09:31.092046  #
    2023-12-12T15:09:31.193974  / # export SHELL=3D/bin/sh. /lava-345181/en=
vironment
    2023-12-12T15:09:31.194837  =

    2023-12-12T15:09:31.296850  / # . /lava-345181/environment/lava-345181/=
bin/lava-test-runner /lava-345181/1
    2023-12-12T15:09:31.298236  =

    2023-12-12T15:09:31.301826  / # /lava-345181/bin/lava-test-runner /lava=
-345181/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65787d73ab457bd79be134a4

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01-54-ga7780f896379d/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01-54-ga7780f896379d/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65787d73ab457bd79be134da
        failing since 0 day (last pass: v4.19.301, first fail: v4.19.301-56=
-g47e943e888e77)

    2023-12-12T15:33:35.514377  / # #
    2023-12-12T15:33:35.615416  export SHELL=3D/bin/sh
    2023-12-12T15:33:35.615885  #
    2023-12-12T15:33:35.716516  / # export SHELL=3D/bin/sh. /lava-1057453/e=
nvironment
    2023-12-12T15:33:35.717049  =

    2023-12-12T15:33:35.818005  / # . /lava-1057453/environment/lava-105745=
3/bin/lava-test-runner /lava-1057453/1
    2023-12-12T15:33:35.818499  =

    2023-12-12T15:33:35.860865  / # /lava-1057453/bin/lava-test-runner /lav=
a-1057453/1
    2023-12-12T15:33:36.037335  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-12T15:33:36.037790  + cd /lava-1057453/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

