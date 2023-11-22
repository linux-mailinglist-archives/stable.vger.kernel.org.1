Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8919D7F4E81
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 18:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjKVRhQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 12:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKVRhP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 12:37:15 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90F919D
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 09:37:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2855b566683so30393a91.1
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 09:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700674631; x=1701279431; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n5K0gL1VDy7arsVfZwdLwJ+WGNNhd43e92dt0VVzD6w=;
        b=qz7w8StcIooQA92nS3Zm2rytyfrVKlPVOlFrN9kC2E9xZH7ziYcoP5OfaRJOT/2ajj
         SBLJ5eb2QVFqzLG/2shvEhBhGRZpgVMhULAmG9fMJyaLRqTPToWkWWfoxy7dY5UqB6Ps
         FiOr7VQKVrkwiTTNhws1VepZIiMiqAmrAwJ2B1wXtohITTfK6tWPNYjdzrUi4sSVrd/W
         udlHvLa/DCwgrL4u5JCQT3iNnMydyzzedh2Eprdjq5ks/LB4gEMjRRdG37X7ddzUPRyr
         KKuITKiBCOHIWB3Z7wuflCCR1xUX+60QqKwfE6oebhD/58YVr8g+raytTwERFCZKXH7Y
         rX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700674631; x=1701279431;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5K0gL1VDy7arsVfZwdLwJ+WGNNhd43e92dt0VVzD6w=;
        b=YcCH34T0Eyc9MNBVPo88MN4xxHv3FvKlKBeWx+qUzyEzPgP55OZS+oaC71n5wiM22P
         7GTIoHlj5M9ViOahcBhdOeXC5s59FgIlSf2XZ996zL44mZ1tmYalPr9YehhYyaLvyV61
         CO4wM+vndNFjQbqXv2c5ul1dJLfE5BSC5QF2fUBrny2WqOZwJb17452STv67L6RW5go/
         3R4ZVCDn1/Hq/XWtBr2h02FMBB16EuiNOe/NY8DbxQ2Yl1i33Pj1ne+Hc5sfEZ9mGsJf
         FKAz2a93wKRWp4BGlROWv5jtzhvi7qiglPb7yOpUzYNBZRDpNRaquWgLw8Rk+nD+2oJN
         hKzg==
X-Gm-Message-State: AOJu0YyHHtNeKZkl9v/JeChiHYQuqK8zlclWZtrgU4U5dyTbCcWF5sut
        a2E4GbgKZtPihHCYO7QkomdTPASqW61bof6/gIo=
X-Google-Smtp-Source: AGHT+IG3L/uTkIA2NyMdLsUfRPSheSMVjQuTx8TF0ibeTSGHNXGPROrbJcwKkdrFMO8R+SAHLY+qpw==
X-Received: by 2002:a17:90b:224a:b0:280:299d:4b7e with SMTP id hk10-20020a17090b224a00b00280299d4b7emr196010pjb.19.1700674629286;
        Wed, 22 Nov 2023 09:37:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a01d000b002850eb8b6dcsm4007pjd.44.2023.11.22.09.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:37:08 -0800 (PST)
Message-ID: <655e3c44.170a0220.7d927.0051@mx.google.com>
Date:   Wed, 22 Nov 2023 09:37:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.139-172-gb60494a37c0c
Subject: stable-rc/queue/5.15 baseline: 142 runs,
 4 regressions (v5.15.139-172-gb60494a37c0c)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/5.15 baseline: 142 runs, 4 regressions (v5.15.139-172-gb604=
94a37c0c)

Regressions Summary
-------------------

platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
qemu_arm-virt-gicv2 | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig=
 | 1          =

r8a77960-ulcb       | arm64 | lab-collabora | gcc-10   | defconfig         =
 | 1          =

sun50i-h6-pine-h64  | arm64 | lab-clabbe    | gcc-10   | defconfig         =
 | 1          =

sun50i-h6-pine-h64  | arm64 | lab-collabora | gcc-10   | defconfig         =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.139-172-gb60494a37c0c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.139-172-gb60494a37c0c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b60494a37c0cc3a25cf54580748c08d8e36e92ee =



Test Regressions
---------------- =



platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
qemu_arm-virt-gicv2 | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/655e0b9a9a14a99e157e4a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-172-gb60494a37c0c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-172-gb60494a37c0c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655e0b9a9a14a99e157e4=
a70
        new failure (last pass: v5.15.114-13-g095e387c3889) =

 =



platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
r8a77960-ulcb       | arm64 | lab-collabora | gcc-10   | defconfig         =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/655e09d9cac48bea247e4a70

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-172-gb60494a37c0c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-172-gb60494a37c0c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e09d9cac48bea247e4a79
        new failure (last pass: v5.15.114-13-g095e387c3889)

    2023-11-22T14:08:24.456846  / # #

    2023-11-22T14:08:24.558569  export SHELL=3D/bin/sh

    2023-11-22T14:08:24.558812  #

    2023-11-22T14:08:24.659340  / # export SHELL=3D/bin/sh. /lava-12059227/=
environment

    2023-11-22T14:08:24.659602  =


    2023-11-22T14:08:24.760295  / # . /lava-12059227/environment/lava-12059=
227/bin/lava-test-runner /lava-12059227/1

    2023-11-22T14:08:24.761445  =


    2023-11-22T14:08:24.765678  / # /lava-12059227/bin/lava-test-runner /la=
va-12059227/1

    2023-11-22T14:08:24.828348  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T14:08:24.828856  + cd /lav<8>[   16.067872] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12059227_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
sun50i-h6-pine-h64  | arm64 | lab-clabbe    | gcc-10   | defconfig         =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/655e09d8d04ebc4db37e4a7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-172-gb60494a37c0c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-172-gb60494a37c0c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e09d8d04ebc4db37e4a88
        new failure (last pass: v5.15.105-206-g4548859116b8)

    2023-11-22T14:01:51.768508  <8>[   16.148541] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 444835_1.5.2.4.1>
    2023-11-22T14:01:51.873527  / # #
    2023-11-22T14:01:51.975171  export SHELL=3D/bin/sh
    2023-11-22T14:01:51.975793  #
    2023-11-22T14:01:52.076784  / # export SHELL=3D/bin/sh. /lava-444835/en=
vironment
    2023-11-22T14:01:52.077360  =

    2023-11-22T14:01:52.178392  / # . /lava-444835/environment/lava-444835/=
bin/lava-test-runner /lava-444835/1
    2023-11-22T14:01:52.179257  =

    2023-11-22T14:01:52.183858  / # /lava-444835/bin/lava-test-runner /lava=
-444835/1
    2023-11-22T14:01:52.215904  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
sun50i-h6-pine-h64  | arm64 | lab-collabora | gcc-10   | defconfig         =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/655e09edd04ebc4db37e4a95

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-172-gb60494a37c0c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-172-gb60494a37c0c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e09edd04ebc4db37e4a9e
        new failure (last pass: v5.15.105-206-g4548859116b8)

    2023-11-22T14:08:37.256903  / # #

    2023-11-22T14:08:37.358557  export SHELL=3D/bin/sh

    2023-11-22T14:08:37.358769  #

    2023-11-22T14:08:37.459404  / # export SHELL=3D/bin/sh. /lava-12059234/=
environment

    2023-11-22T14:08:37.459615  =


    2023-11-22T14:08:37.560166  / # . /lava-12059234/environment/lava-12059=
234/bin/lava-test-runner /lava-12059234/1

    2023-11-22T14:08:37.560482  =


    2023-11-22T14:08:37.601513  / # /lava-12059234/bin/lava-test-runner /la=
va-12059234/1

    2023-11-22T14:08:37.634147  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T14:08:37.634651  + cd /lava-1205923<8>[   16.835830] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12059234_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
