Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC01D77AF3E
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 03:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjHNBsw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 21:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjHNBsg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 21:48:36 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C20E54
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 18:48:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a78604f47fso3742498b6e.1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 18:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691977713; x=1692582513;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nPfT98lnvudCl+wlKu129h9XfZCCND6ezsWP123qO4c=;
        b=IHkcsza3mByZBGjwwETR6G1ADK01CfspIDhJ8Yfm7ddVThHNRMvn0LxAaB178Li9hl
         I2xvYYTMLPZzb7zx/eCy9xLs9pKp0JjG9YZV0X5tL0b24YVsnRWVh+6Z3xvEb54Slxlw
         dGuUOyd5AXtitj7BdZIhlV9Yc9t+Z5ip9n1nAnhJLq/PJQ3z5kLOud+fUYTC3tiFWG+8
         HyRFeviqFxLqAWffV0Ma9dCiwnuE94DLbTQOAceNa2SzuiuIDKVuFb87hoCfmGKvXD1x
         avd7x+YSXSdmnlB4vIIb+NGn+VE4xriU7+UikX3guJq5IYBPXyd9BkoTcADFAukmd91m
         0y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691977713; x=1692582513;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPfT98lnvudCl+wlKu129h9XfZCCND6ezsWP123qO4c=;
        b=l70VxznYIBgCmo0klPUIlTFfXKbprvj7tfne4wKHhEY3wMmPfuMebD8Cv5iZb0PhDe
         R0qAQ6rQQsPzSY2wGXtZ1Aob2s08Fjo4IEYnyfacnIdmtfm1mMF/q9HlC6DDuBLCovAR
         z7SD1nae10Lwj+mxDsRMKZ7KRUmJSO17DyW9duQNKQrElhHDnVHcRbIblnD9tyKgLHh0
         XyUruTbW45DSWxZsY2935RIFVohAt0/MFHlCgghggNEFFWc7BKuBRW3qL4gH9dxd1E/e
         wGXSCOA4NOtYPsoKN45KBsG6LLGxMd4U4bCKR0WsxU6jb5mjBkmNG0hwYHXEbqrnkL9z
         orsw==
X-Gm-Message-State: AOJu0YzsBTni9hg3BiODTwZmkhk7UO5rTF4+z8+/Dj+tisqak1EQIDXc
        d6KP0WsCzza2+8wv0A0YWHFuqNtVrflRlKhXhpS/5sge
X-Google-Smtp-Source: AGHT+IHhn4kuttbZhcrNxBv2MfqHQiyHeFQQUatO/CGoZfLTz6RQPgNYGnmtEqvh9t+IpmPWl2qZuw==
X-Received: by 2002:a05:6358:60ca:b0:129:d05d:691e with SMTP id i10-20020a05635860ca00b00129d05d691emr5425822rwi.19.1691977713026;
        Sun, 13 Aug 2023 18:48:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i15-20020a63a84f000000b005634343cd9esm7318853pgp.44.2023.08.13.18.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 18:48:32 -0700 (PDT)
Message-ID: <64d987f0.630a0220.36e3b.bffd@mx.google.com>
Date:   Sun, 13 Aug 2023 18:48:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.126-90-g952b0de2b49f7
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 123 runs,
 12 regressions (v5.15.126-90-g952b0de2b49f7)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 123 runs, 12 regressions (v5.15.126-90-g95=
2b0de2b49f7)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.126-90-g952b0de2b49f7/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.126-90-g952b0de2b49f7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      952b0de2b49f760b2e3b49d93faae7a6beb96dee =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9525480d771e30135b260

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9525480d771e30135b265
        failing since 138 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-13T21:59:41.553375  <8>[   10.622944] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11280282_1.4.2.3.1>

    2023-08-13T21:59:41.556372  + set +x

    2023-08-13T21:59:41.660925  / # #

    2023-08-13T21:59:41.761480  export SHELL=3D/bin/sh

    2023-08-13T21:59:41.761640  #

    2023-08-13T21:59:41.862116  / # export SHELL=3D/bin/sh. /lava-11280282/=
environment

    2023-08-13T21:59:41.862318  =


    2023-08-13T21:59:41.962855  / # . /lava-11280282/environment/lava-11280=
282/bin/lava-test-runner /lava-11280282/1

    2023-08-13T21:59:41.963109  =


    2023-08-13T21:59:41.968624  / # /lava-11280282/bin/lava-test-runner /la=
va-11280282/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9524e4f3623fd3d35b21d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9524e4f3623fd3d35b222
        failing since 138 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-13T21:59:33.592374  <8>[   10.638368] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11280274_1.4.2.3.1>

    2023-08-13T21:59:33.595475  + set +x

    2023-08-13T21:59:33.697205  /#

    2023-08-13T21:59:33.797964   # #export SHELL=3D/bin/sh

    2023-08-13T21:59:33.798097  =


    2023-08-13T21:59:33.898637  / # export SHELL=3D/bin/sh. /lava-11280274/=
environment

    2023-08-13T21:59:33.898774  =


    2023-08-13T21:59:33.999294  / # . /lava-11280274/environment/lava-11280=
274/bin/lava-test-runner /lava-11280274/1

    2023-08-13T21:59:33.999505  =


    2023-08-13T21:59:34.004377  / # /lava-11280274/bin/lava-test-runner /la=
va-11280274/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9581f5e542233dd35b1f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9581f5e542233dd35b=
1f6
        failing since 19 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9526d73a9d111ff35b20a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9526d73a9d111ff35b20f
        failing since 208 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-13T21:59:59.770000  <8>[   10.013111] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3741244_1.5.2.4.1>
    2023-08-13T21:59:59.882949  / # #
    2023-08-13T21:59:59.986221  export SHELL=3D/bin/sh
    2023-08-13T21:59:59.986692  #
    2023-08-13T21:59:59.986908  / # export SHELL=3D/bin<3>[   10.194279] Bl=
uetooth: hci0: command 0xfc18 tx timeout
    2023-08-13T22:00:00.088347  /sh. /lava-3741244/environment
    2023-08-13T22:00:00.089653  =

    2023-08-13T22:00:00.192464  / # . /lava-3741244/environment/lava-374124=
4/bin/lava-test-runner /lava-3741244/1
    2023-08-13T22:00:00.194446  =

    2023-08-13T22:00:00.204580  / # /lava-3741244/bin/lava-test-runner /lav=
a-3741244/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d953d39c54aa29c735b231

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d953d39c54aa29c735b234
        failing since 30 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-13T22:05:48.291603  + [   11.278622] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1243435_1.5.2.4.1>
    2023-08-13T22:05:48.291881  set +x
    2023-08-13T22:05:48.397599  =

    2023-08-13T22:05:48.498909  / # #export SHELL=3D/bin/sh
    2023-08-13T22:05:48.499383  =

    2023-08-13T22:05:48.600375  / # export SHELL=3D/bin/sh. /lava-1243435/e=
nvironment
    2023-08-13T22:05:48.600813  =

    2023-08-13T22:05:48.701817  / # . /lava-1243435/environment/lava-124343=
5/bin/lava-test-runner /lava-1243435/1
    2023-08-13T22:05:48.702670  =

    2023-08-13T22:05:48.706630  / # /lava-1243435/bin/lava-test-runner /lav=
a-1243435/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d953e712f44fffde35b237

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d953e812f44fffde35b23a
        failing since 163 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-13T22:06:08.190839  [   10.869831] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243437_1.5.2.4.1>
    2023-08-13T22:06:08.295923  =

    2023-08-13T22:06:08.397073  / # #export SHELL=3D/bin/sh
    2023-08-13T22:06:08.397471  =

    2023-08-13T22:06:08.498403  / # export SHELL=3D/bin/sh. /lava-1243437/e=
nvironment
    2023-08-13T22:06:08.498804  =

    2023-08-13T22:06:08.599755  / # . /lava-1243437/environment/lava-124343=
7/bin/lava-test-runner /lava-1243437/1
    2023-08-13T22:06:08.600415  =

    2023-08-13T22:06:08.604384  / # /lava-1243437/bin/lava-test-runner /lav=
a-1243437/1
    2023-08-13T22:06:08.620306  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9523fae5f1553b635b203

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9523fae5f1553b635b208
        failing since 138 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-13T21:59:12.018252  <8>[   10.335190] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11280278_1.4.2.3.1>

    2023-08-13T21:59:12.021559  + set +x

    2023-08-13T21:59:12.122884  =


    2023-08-13T21:59:12.223451  / # #export SHELL=3D/bin/sh

    2023-08-13T21:59:12.223616  =


    2023-08-13T21:59:12.324184  / # export SHELL=3D/bin/sh. /lava-11280278/=
environment

    2023-08-13T21:59:12.324350  =


    2023-08-13T21:59:12.424864  / # . /lava-11280278/environment/lava-11280=
278/bin/lava-test-runner /lava-11280278/1

    2023-08-13T21:59:12.425119  =


    2023-08-13T21:59:12.430646  / # /lava-11280278/bin/lava-test-runner /la=
va-11280278/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95248143743a8ae35b1e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d95248143743a8ae35b1eb
        failing since 138 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-13T21:59:15.901674  + set<8>[   11.400880] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11280284_1.4.2.3.1>

    2023-08-13T21:59:15.902243   +x

    2023-08-13T21:59:16.010238  / # #

    2023-08-13T21:59:16.112908  export SHELL=3D/bin/sh

    2023-08-13T21:59:16.113890  #

    2023-08-13T21:59:16.215490  / # export SHELL=3D/bin/sh. /lava-11280284/=
environment

    2023-08-13T21:59:16.216275  =


    2023-08-13T21:59:16.317847  / # . /lava-11280284/environment/lava-11280=
284/bin/lava-test-runner /lava-11280284/1

    2023-08-13T21:59:16.319092  =


    2023-08-13T21:59:16.323836  / # /lava-11280284/bin/lava-test-runner /la=
va-11280284/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9523d4f3623fd3d35b1f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9523d4f3623fd3d35b1f9
        failing since 138 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-13T21:59:13.120988  + set<8>[   11.804127] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11280265_1.4.2.3.1>

    2023-08-13T21:59:13.121070   +x

    2023-08-13T21:59:13.225716  / # #

    2023-08-13T21:59:13.326259  export SHELL=3D/bin/sh

    2023-08-13T21:59:13.326428  #

    2023-08-13T21:59:13.426929  / # export SHELL=3D/bin/sh. /lava-11280265/=
environment

    2023-08-13T21:59:13.427078  =


    2023-08-13T21:59:13.527540  / # . /lava-11280265/environment/lava-11280=
265/bin/lava-test-runner /lava-11280265/1

    2023-08-13T21:59:13.527772  =


    2023-08-13T21:59:13.532601  / # /lava-11280265/bin/lava-test-runner /la=
va-11280265/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9537e6d5777f52235b240

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9537e6d5777f52235b245
        failing since 25 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-13T22:06:15.845953  / # #

    2023-08-13T22:06:15.946567  export SHELL=3D/bin/sh

    2023-08-13T22:06:15.946688  #

    2023-08-13T22:06:16.047226  / # export SHELL=3D/bin/sh. /lava-11280292/=
environment

    2023-08-13T22:06:16.047345  =


    2023-08-13T22:06:16.147887  / # . /lava-11280292/environment/lava-11280=
292/bin/lava-test-runner /lava-11280292/1

    2023-08-13T22:06:16.148082  =


    2023-08-13T22:06:16.159570  / # /lava-11280292/bin/lava-test-runner /la=
va-11280292/1

    2023-08-13T22:06:16.201051  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-13T22:06:16.218692  + cd /lav<8>[   15.981548] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11280292_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d953966d5777f52235b366

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d953966d5777f52235b36b
        failing since 25 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-13T22:05:16.778225  / # #

    2023-08-13T22:05:17.854483  export SHELL=3D/bin/sh

    2023-08-13T22:05:17.856421  #

    2023-08-13T22:05:19.346797  / # export SHELL=3D/bin/sh. /lava-11280293/=
environment

    2023-08-13T22:05:19.348729  =


    2023-08-13T22:05:22.072105  / # . /lava-11280293/environment/lava-11280=
293/bin/lava-test-runner /lava-11280293/1

    2023-08-13T22:05:22.074533  =


    2023-08-13T22:05:22.074994  / # /lava-11280293/bin/lava-test-runner /la=
va-11280293/1

    2023-08-13T22:05:22.144169  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-13T22:05:22.144657  + cd /lava-112802<8>[   25.531663] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11280293_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d953927cdb979c8f35b222

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26-90-g952b0de2b49f7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d953927cdb979c8f35b227
        failing since 25 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-13T22:06:28.656782  / # #

    2023-08-13T22:06:28.759000  export SHELL=3D/bin/sh

    2023-08-13T22:06:28.759714  #

    2023-08-13T22:06:28.861125  / # export SHELL=3D/bin/sh. /lava-11280302/=
environment

    2023-08-13T22:06:28.861851  =


    2023-08-13T22:06:28.963288  / # . /lava-11280302/environment/lava-11280=
302/bin/lava-test-runner /lava-11280302/1

    2023-08-13T22:06:28.964315  =


    2023-08-13T22:06:28.980995  / # /lava-11280302/bin/lava-test-runner /la=
va-11280302/1

    2023-08-13T22:06:29.039025  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-13T22:06:29.039539  + cd /lava-1128030<8>[   16.857698] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11280302_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
