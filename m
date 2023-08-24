Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD91787920
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbjHXUMD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 16:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbjHXUL7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 16:11:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB55CE
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 13:11:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a41031768so232301b3a.3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692907915; x=1693512715;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ixp4C+SPWsBa8ZvZbj0TqsWgu7ELIrCE3MjBSqQioLY=;
        b=gNlzwuAenauNzDGWtoJ0EQSeoYx4FhpK2GCiYV2L3Dn7NxhXTtOhmJmNUXIdN58DnH
         A1atHBRPhTCZyrItYr2iIs8hWUVcrstiGcugqQuJYzZCuVAnErwVOi43i2fsMPDWZrtt
         ZHsmrkQeTVDT6bdsVeLzsg+O4lkcM3YOdwQxN5XTEJEcBYQ1TmvceR+2/pWST9rM+55w
         V1o7FF+2FxJWE9D8TS5h2gmgRZLrww2tYuad7ZJ9EqionznDD8pxq6jqxpSt3hVvxpZy
         jiUxNVO3lDLMACmcolLp9H1/P2k+VTR7DL6U0p10OFoSiWBEDcOMCIxn0MGGPrH6JTZT
         Su5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692907915; x=1693512715;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixp4C+SPWsBa8ZvZbj0TqsWgu7ELIrCE3MjBSqQioLY=;
        b=GXIdZdPcJwz3wcSo83PdkNySNsVjVByYutuw4IFPYwJmKupTjrZzBx2+WiyVNmunPR
         haIAhR5wq4PYhWJXpNxzPUOMczEmDybUdkkBSKv150WDRH3DzJaOLdP0T2ZB5Reihewm
         NoHNiBTPAiqXl65ib4zG+PfQaMf4hkO8j+8PiUnccE0iB7IsASlyFnagb3baLWr/7/hG
         avJGUNgQ5OT1sWu8PXX5ot92wcYK5sKg15lDjWyYX00gx82vwUq29420rUaIkDquhQdI
         D4gjK0ekSpVROfshWoOthHVOWORiR5PHsovTvNVxc8NWkuXB3KClTt/flOZE8OuJZlb5
         NGrA==
X-Gm-Message-State: AOJu0YyOJDZ5PCFnuTVXKY/NiH9DJVUtMMOzJQx+udhlaVuc0ZU4Vpz9
        g9t/pZBg9l7LNNZ3rCRCOLWsKsWKgeN9toUNpqE=
X-Google-Smtp-Source: AGHT+IFeMGJ8hwNrFCWHtCT+lxV7He9mrp1IrB1frFgLOR6STBqX5G0gpkQT2gHkuR+XWs88Gf12Kw==
X-Received: by 2002:a17:90b:30c6:b0:268:5575:93d9 with SMTP id hi6-20020a17090b30c600b00268557593d9mr12830974pjb.10.1692907915007;
        Thu, 24 Aug 2023 13:11:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090a3d4300b002636dfcc6f5sm132339pjf.3.2023.08.24.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:11:54 -0700 (PDT)
Message-ID: <64e7b98a.170a0220.a0b5f.078d@mx.google.com>
Date:   Thu, 24 Aug 2023 13:11:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.190-136-gda59b7b5c515e
Subject: stable-rc/linux-5.10.y baseline: 126 runs,
 13 regressions (v5.10.190-136-gda59b7b5c515e)
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

stable-rc/linux-5.10.y baseline: 126 runs, 13 regressions (v5.10.190-136-gd=
a59b7b5c515e)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.190-136-gda59b7b5c515e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.190-136-gda59b7b5c515e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      da59b7b5c515edab9a57efd37b031b5b97e6c1cc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7898548817f9fb0286d75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e7898548817f9fb0286=
d76
        new failure (last pass: v5.10.191) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e788d3c5b8c07a1d286da0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e788d3c5b8c07a1d286da5
        failing since 218 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-24T16:43:48.075664  <8>[   11.067943] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3747883_1.5.2.4.1>
    2023-08-24T16:43:48.185595  / # #
    2023-08-24T16:43:48.288812  export SHELL=3D/bin/sh
    2023-08-24T16:43:48.289332  #
    2023-08-24T16:43:48.390899  / # export SHELL=3D/bin/sh. /lava-3747883/e=
nvironment
    2023-08-24T16:43:48.391888  =

    2023-08-24T16:43:48.493864  / # . /lava-3747883/environment/lava-374788=
3/bin/lava-test-runner /lava-3747883/1
    2023-08-24T16:43:48.495221  =

    2023-08-24T16:43:48.499874  / # /lava-3747883/bin/lava-test-runner /lav=
a-3747883/1
    2023-08-24T16:43:48.543761  <3>[   11.531811] Bluetooth: hci0: command =
0x0c03 tx timeout =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e788323a47fd2de4286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e788323a47fd2de4286d73
        failing since 37 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-24T16:41:02.277610  [   10.536708] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1245815_1.5.2.4.1>
    2023-08-24T16:41:02.383091  =

    2023-08-24T16:41:02.484451  / # #export SHELL=3D/bin/sh
    2023-08-24T16:41:02.485004  =

    2023-08-24T16:41:02.586013  / # export SHELL=3D/bin/sh. /lava-1245815/e=
nvironment
    2023-08-24T16:41:02.586587  =

    2023-08-24T16:41:02.687703  / # . /lava-1245815/environment/lava-124581=
5/bin/lava-test-runner /lava-1245815/1
    2023-08-24T16:41:02.688530  =

    2023-08-24T16:41:02.692439  / # /lava-1245815/bin/lava-test-runner /lav=
a-1245815/1
    2023-08-24T16:41:02.712944  + export 'TESTRUN_[   10.971247] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1245815_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e788363a47fd2de4286d78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e788363a47fd2de4286d7f
        failing since 173 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-24T16:41:00.483102  [   10.994885] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1245816_1.5.2.4.1>
    2023-08-24T16:41:00.589048  =

    2023-08-24T16:41:00.690313  / # #export SHELL=3D/bin/sh
    2023-08-24T16:41:00.690760  =

    2023-08-24T16:41:00.791699  / # export SHELL=3D/bin/sh. /lava-1245816/e=
nvironment
    2023-08-24T16:41:00.792148  =

    2023-08-24T16:41:00.893135  / # . /lava-1245816/environment/lava-124581=
6/bin/lava-test-runner /lava-1245816/1
    2023-08-24T16:41:00.893912  =

    2023-08-24T16:41:00.897599  / # /lava-1245816/bin/lava-test-runner /lav=
a-1245816/1
    2023-08-24T16:41:00.911965  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7895cfc04c2339f286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7895cfc04c2339f286d71
        failing since 148 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-24T16:46:18.123357  + set +x

    2023-08-24T16:46:18.129908  <8>[   10.141198] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11347265_1.4.2.3.1>

    2023-08-24T16:46:18.237996  / # #

    2023-08-24T16:46:18.340525  export SHELL=3D/bin/sh

    2023-08-24T16:46:18.341304  #

    2023-08-24T16:46:18.442763  / # export SHELL=3D/bin/sh. /lava-11347265/=
environment

    2023-08-24T16:46:18.443580  =


    2023-08-24T16:46:18.545069  / # . /lava-11347265/environment/lava-11347=
265/bin/lava-test-runner /lava-11347265/1

    2023-08-24T16:46:18.546067  =


    2023-08-24T16:46:18.551337  / # /lava-11347265/bin/lava-test-runner /la=
va-11347265/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7959e163aa845a9286d73

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7959e163aa845a9286d78
        failing since 148 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-24T17:39:25.600127  + set +x

    2023-08-24T17:39:25.606766  <8>[   12.191879] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11347267_1.4.2.3.1>

    2023-08-24T17:39:25.711107  / # #

    2023-08-24T17:39:25.811665  export SHELL=3D/bin/sh

    2023-08-24T17:39:25.811844  #

    2023-08-24T17:39:25.912355  / # export SHELL=3D/bin/sh. /lava-11347267/=
environment

    2023-08-24T17:39:25.912555  =


    2023-08-24T17:39:26.013108  / # . /lava-11347267/environment/lava-11347=
267/bin/lava-test-runner /lava-11347267/1

    2023-08-24T17:39:26.013364  =


    2023-08-24T17:39:26.018470  / # /lava-11347267/bin/lava-test-runner /la=
va-11347267/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7887196b223d002286d80

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7887196b223d002286db7
        failing since 2 days (last pass: v5.10.191, first fail: v5.10.190-1=
23-gec001faa2c729)

    2023-08-24T16:42:06.807314  / # #
    2023-08-24T16:42:06.910118  export SHELL=3D/bin/sh
    2023-08-24T16:42:06.910897  #
    2023-08-24T16:42:07.012831  / # export SHELL=3D/bin/sh. /lava-68236/env=
ironment
    2023-08-24T16:42:07.013826  =

    2023-08-24T16:42:07.116254  / # . /lava-68236/environment/lava-68236/bi=
n/lava-test-runner /lava-68236/1
    2023-08-24T16:42:07.117729  =

    2023-08-24T16:42:07.131637  / # /lava-68236/bin/lava-test-runner /lava-=
68236/1
    2023-08-24T16:42:07.190483  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-24T16:42:07.190978  + cd /lava-68236/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7882e1e5586e419286d83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7882e1e5586e419286d8a
        failing since 23 days (last pass: v5.10.186-10-g5f99a36aeb1c, first=
 fail: v5.10.188-107-gc262f74329e1)

    2023-08-24T16:40:57.399760  + set +x
    2023-08-24T16:40:57.399973  <8>[   83.927865] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1000204_1.5.2.4.1>
    2023-08-24T16:40:57.506471  / # #
    2023-08-24T16:40:58.966556  export SHELL=3D/bin/sh
    2023-08-24T16:40:58.987146  #
    2023-08-24T16:40:58.987412  / # export SHELL=3D/bin/sh
    2023-08-24T16:41:00.940327  / # . /lava-1000204/environment
    2023-08-24T16:41:04.533512  /lava-1000204/bin/lava-test-runner /lava-10=
00204/1
    2023-08-24T16:41:04.554311  . /lava-1000204/environment
    2023-08-24T16:41:04.554481  / # /lava-1000204/bin/lava-test-runner /lav=
a-1000204/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e788a3823aac1e2c286d83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek87=
4.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek87=
4.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e788a3823aac1e2c286d8a
        failing since 37 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-24T16:42:53.294992  / # #
    2023-08-24T16:42:54.754775  export SHELL=3D/bin/sh
    2023-08-24T16:42:54.775227  #
    2023-08-24T16:42:54.775360  / # export SHELL=3D/bin/sh
    2023-08-24T16:42:56.728123  / # . /lava-1000207/environment
    2023-08-24T16:43:00.321446  /lava-1000207/bin/lava-test-runner /lava-10=
00207/1
    2023-08-24T16:43:00.342056  . /lava-1000207/environment
    2023-08-24T16:43:00.342164  / # /lava-1000207/bin/lava-test-runner /lav=
a-1000207/1
    2023-08-24T16:43:00.418433  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-24T16:43:00.418598  + cd /lava-1000207/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e789e35304e11ae1286eae

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e789e35304e11ae1286eb5
        failing since 37 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-24T16:48:04.929034  / # #
    2023-08-24T16:48:06.391121  export SHELL=3D/bin/sh
    2023-08-24T16:48:06.411657  #
    2023-08-24T16:48:06.411859  / # export SHELL=3D/bin/sh
    2023-08-24T16:48:08.366801  / # . /lava-1000221/environment
    2023-08-24T16:48:11.964205  /lava-1000221/bin/lava-test-runner /lava-10=
00221/1
    2023-08-24T16:48:11.984935  . /lava-1000221/environment
    2023-08-24T16:48:11.985046  / # /lava-1000221/bin/lava-test-runner /lav=
a-1000221/1
    2023-08-24T16:48:12.064622  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-24T16:48:12.064840  + cd /lava-1000221/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e787e59eb910a6ac286d7d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e787e59eb910a6ac286d82
        failing since 37 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-24T16:41:20.213442  / # #

    2023-08-24T16:41:20.315400  export SHELL=3D/bin/sh

    2023-08-24T16:41:20.316109  #

    2023-08-24T16:41:20.417511  / # export SHELL=3D/bin/sh. /lava-11347228/=
environment

    2023-08-24T16:41:20.418212  =


    2023-08-24T16:41:20.519615  / # . /lava-11347228/environment/lava-11347=
228/bin/lava-test-runner /lava-11347228/1

    2023-08-24T16:41:20.520688  =


    2023-08-24T16:41:20.537790  / # /lava-11347228/bin/lava-test-runner /la=
va-11347228/1

    2023-08-24T16:41:20.586435  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T16:41:20.586939  + cd /lav<8>[   16.394090] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11347228_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e788281e5586e419286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-=
rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-=
rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e788281e5586e419286d76
        new failure (last pass: v5.10.191)

    2023-08-24T16:40:46.552046  / # #

    2023-08-24T16:40:47.812921  export SHELL=3D/bin/sh

    2023-08-24T16:40:47.823897  #

    2023-08-24T16:40:47.824376  / # export SHELL=3D/bin/sh

    2023-08-24T16:40:49.568438  / # . /lava-11347230/environment

    2023-08-24T16:40:52.773345  /lava-11347230/bin/lava-test-runner /lava-1=
1347230/1

    2023-08-24T16:40:52.784818  . /lava-11347230/environment

    2023-08-24T16:40:52.788611  / # /lava-11347230/bin/lava-test-runner /la=
va-11347230/1

    2023-08-24T16:40:52.839521  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T16:40:52.839995  + cd /lava-11347230/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e787e4742f5657d5286dab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-136-gda59b7b5c515e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e787e4742f5657d5286db0
        failing since 37 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-24T16:41:36.085348  / # #

    2023-08-24T16:41:36.187479  export SHELL=3D/bin/sh

    2023-08-24T16:41:36.188198  #

    2023-08-24T16:41:36.289652  / # export SHELL=3D/bin/sh. /lava-11347223/=
environment

    2023-08-24T16:41:36.290388  =


    2023-08-24T16:41:36.392206  / # . /lava-11347223/environment/lava-11347=
223/bin/lava-test-runner /lava-11347223/1

    2023-08-24T16:41:36.393349  =


    2023-08-24T16:41:36.409656  / # /lava-11347223/bin/lava-test-runner /la=
va-11347223/1

    2023-08-24T16:41:36.467607  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T16:41:36.468106  + cd /lava-1134722<8>[   18.341460] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11347223_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
