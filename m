Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781797862BE
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 23:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjHWVvm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 17:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjHWVvi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 17:51:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A474FCEA
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 14:51:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso287174b3a.1
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692827495; x=1693432295;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uA7f3m8PoHtFPthPmpcC0mW7MGDtxIGUZGrj5SKsaOU=;
        b=NT0XGG4yEm5zFWlliIfwIbnRlhJ7k9IpRchPwdz60CPmX5vNrYTG0quhQIdHUR0Gqx
         aV7E9oneRIAs93Nub6fnTm+lA8ZuSXeUQPG2LrLAid4jBCZjfms1C9S4fQSyoZ8WDkeu
         MeldSpZrrPFlSP3ogdCHi48tiDF49Lpp8yEj1foH+PHO8QFNGOegaiV3Av8CCpBvcEnA
         Odj/zhhShsrnhXn8UUVvyC5cnySviBU8JMu/Qjb+xW2Itk5iMSxHvU0lWBvt0RPWOt6I
         h8+0q+arfmOegLFMrsWbg3EM6g9itP2AXGHdt112l7JabEICAejsVDpTgerQB2lCXLh4
         7h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692827495; x=1693432295;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uA7f3m8PoHtFPthPmpcC0mW7MGDtxIGUZGrj5SKsaOU=;
        b=RnzgahL2OKI3EOKvCCvH9Br4ymj+KQ0lnguLFjzUr0gLfvJlgRbg9KMzEaEamuRq5Z
         vOWHQwL5CHdwB+NhW1Ft2Pi5FsAhu4U5x3rJ69fjTxgdY6MYbpKBgDuimfAo4LFfeVwJ
         ky9VmV6phpQ9UnSNFQx5+Edm3o9A5O8zuZcoO/cnBfcjt/Rvnhfft98fGUXjKX5OzGFx
         CUIsL7cRIGYAn/yQNoTvva6rrpKl6KY+Irc9Nmpt90CSy+xyiqF5ZFEEVn2GTgQ6fNEn
         p8QG/BEmOZlTPDnlQBHfHnHsnjTE1HE8wSDllILc3lvqvEh/lM48vaSeBpKAUw1+sAtU
         2qLg==
X-Gm-Message-State: AOJu0YymMwgwiGgv5zlGkLcEQKlav2rCpHPgVb8gIwOs8y14FjXB+zA+
        QOrxmVgsomG4VJUzlNsBS7oN+a2VO7R3xY3lEn4=
X-Google-Smtp-Source: AGHT+IHK0R9C6LIYJ+mowFJ3J/pVJr5dHj7pROAbYNHj8GtmordSzNkGFl03c63XTLG9I/XMbUSUlA==
X-Received: by 2002:a05:6a20:428c:b0:13f:4e70:ad48 with SMTP id o12-20020a056a20428c00b0013f4e70ad48mr14386262pzj.52.1692827494171;
        Wed, 23 Aug 2023 14:51:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001b8953365aesm11400484plj.22.2023.08.23.14.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:51:33 -0700 (PDT)
Message-ID: <64e67f65.170a0220.a388b.68e4@mx.google.com>
Date:   Wed, 23 Aug 2023 14:51:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 125 runs, 13 regressions (v5.10.191)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 125 runs, 13 regressions (v5.10.191)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.191/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.191
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      da742ebfa00c3add4a358dd79ec92161c07e1435 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd426a9af31c896035b1e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplaine=
d.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplaine=
d.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd426a9af31c896035b=
1e1
        new failure (last pass: v5.10.190-69-g5b1776cc14bf8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd418d5f3751648035b215

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd418d5f3751648035b21a
        failing since 210 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-16T21:37:08.315258  <8>[   11.149507] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3744026_1.5.2.4.1>
    2023-08-16T21:37:08.428915  / # #
    2023-08-16T21:37:08.532510  export SHELL=3D/bin/sh
    2023-08-16T21:37:08.533501  #
    2023-08-16T21:37:08.635746  / # export SHELL=3D/bin/sh. /lava-3744026/e=
nvironment
    2023-08-16T21:37:08.636710  =

    2023-08-16T21:37:08.637183  / # . /lava-3744026/environment<3>[   11.45=
2689] Bluetooth: hci0: command 0xfc18 tx timeout
    2023-08-16T21:37:08.739141  /lava-3744026/bin/lava-test-runner /lava-37=
44026/1
    2023-08-16T21:37:08.740583  =

    2023-08-16T21:37:08.745112  / # /lava-3744026/bin/lava-test-runner /lav=
a-3744026/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd424bf776fbfd0235b253

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd424bf776fbfd0235b256
        failing since 29 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-23T18:24:32.185968  + [   13.501127] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1245353_1.5.2.4.1>
    2023-08-23T18:24:32.186257  set +x
    2023-08-23T18:24:32.291419  =

    2023-08-23T18:24:32.392567  / # #export SHELL=3D/bin/sh
    2023-08-23T18:24:32.392965  =

    2023-08-23T18:24:32.493896  / # export SHELL=3D/bin/sh. /lava-1245353/e=
nvironment
    2023-08-23T18:24:32.494297  =

    2023-08-23T18:24:32.595215  / # . /lava-1245353/environment/lava-124535=
3/bin/lava-test-runner /lava-1245353/1
    2023-08-23T18:24:32.595881  =

    2023-08-23T18:24:32.599359  / # /lava-1245353/bin/lava-test-runner /lav=
a-1245353/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd429cd39fe2704135b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd429cd39fe2704135b1dc
        failing since 166 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-23T18:24:50.783380  [   15.263419] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1245354_1.5.2.4.1>
    2023-08-23T18:24:50.888929  =

    2023-08-23T18:24:50.990381  / # #export SHELL=3D/bin/sh
    2023-08-23T18:24:50.990879  =

    2023-08-23T18:24:51.091930  / # export SHELL=3D/bin/sh. /lava-1245354/e=
nvironment
    2023-08-23T18:24:51.092390  =

    2023-08-23T18:24:51.193426  / # . /lava-1245354/environment/lava-124535=
4/bin/lava-test-runner /lava-1245354/1
    2023-08-23T18:24:51.194201  =

    2023-08-23T18:24:51.198090  / # /lava-1245354/bin/lava-test-runner /lav=
a-1245354/1
    2023-08-23T18:24:51.212548  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e64c239753b547e4b1e3b3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e64c239753b547e4b1e3b8
        failing since 147 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-23T18:12:49.868799  + <8>[   14.679025] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11338380_1.4.2.3.1>

    2023-08-23T18:12:49.868901  set +x

    2023-08-23T18:12:49.970289  #

    2023-08-23T18:12:50.073006  / # #export SHELL=3D/bin/sh

    2023-08-23T18:12:50.073756  =


    2023-08-23T18:12:50.175315  / # export SHELL=3D/bin/sh. /lava-11338380/=
environment

    2023-08-23T18:12:50.176056  =


    2023-08-23T18:12:50.277516  / # . /lava-11338380/environment/lava-11338=
380/bin/lava-test-runner /lava-11338380/1

    2023-08-23T18:12:50.278624  =


    2023-08-23T18:12:50.283305  / # /lava-11338380/bin/lava-test-runner /la=
va-11338380/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd405c074ff3c0b935b1e5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd405c074ff3c0b935b1ea
        failing since 141 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-23T18:12:25.577222  <8>[   11.732736] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11338359_1.4.2.3.1>

    2023-08-23T18:12:25.580458  + set +x

    2023-08-23T18:12:25.685369  #

    2023-08-23T18:12:25.686557  =


    2023-08-23T18:12:25.788511  / # #export SHELL=3D/bin/sh

    2023-08-23T18:12:25.789251  =


    2023-08-23T18:12:25.890758  / # export SHELL=3D/bin/sh. /lava-11338359/=
environment

    2023-08-23T18:12:25.891489  =


    2023-08-23T18:12:25.992973  / # . /lava-11338359/environment/lava-11338=
359/bin/lava-test-runner /lava-11338359/1

    2023-08-23T18:12:25.994076  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd431f1c3ca5fc4b35b1f9

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd431f1c3ca5fc4b35b235
        failing since 1 day (last pass: v5.10.191, first fail: v5.10.190-12=
3-gec001faa2c729)

    2023-08-23T18:24:59.033793  / # #
    2023-08-23T18:24:59.136569  export SHELL=3D/bin/sh
    2023-08-23T18:24:59.137301  #
    2023-08-23T18:24:59.239226  / # export SHELL=3D/bin/sh. /lava-66452/env=
ironment
    2023-08-23T18:24:59.239951  =

    2023-08-23T18:24:59.341918  / # . /lava-66452/environment/lava-66452/bi=
n/lava-test-runner /lava-66452/1
    2023-08-23T18:24:59.343108  =

    2023-08-23T18:24:59.357960  / # /lava-66452/bin/lava-test-runner /lava-=
66452/1
    2023-08-23T18:24:59.415922  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-23T18:24:59.416445  + cd /lava-66452/1/tests/1_bootrr =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4a9bbd26d1074535b1e2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4a9bbd26d1074535b1e5
        failing since 29 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-23T18:14:32.220141  + set +x
    2023-08-23T18:14:32.220270  <8>[   83.553331] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 999770_1.5.2.4.1>
    2023-08-23T18:14:32.326261  / # #
    2023-08-23T18:14:33.785059  export SHELL=3D/bin/sh
    2023-08-23T18:14:33.805544  #
    2023-08-23T18:14:33.805753  / # export SHELL=3D/bin/sh
    2023-08-23T18:14:35.686684  / # . /lava-999770/environment
    2023-08-23T18:14:39.136735  /lava-999770/bin/lava-test-runner /lava-999=
770/1
    2023-08-23T18:14:39.157371  . /lava-999770/environment
    2023-08-23T18:14:39.157500  / # /lava-999770/bin/lava-test-runner /lava=
-999770/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e64c7e44de721bd4b1e3bf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e64c7e44de721bd4b1e3c2
        failing since 36 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-23T18:14:09.265860  + set +x
    2023-08-23T18:14:09.265983  <8>[   84.014316] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 999766_1.5.2.4.1>
    2023-08-23T18:14:09.371431  / # #
    2023-08-23T18:14:10.830393  export SHELL=3D/bin/sh
    2023-08-23T18:14:10.850861  #
    2023-08-23T18:14:10.851040  / # export SHELL=3D/bin/sh
    2023-08-23T18:14:12.732272  / # . /lava-999766/environment
    2023-08-23T18:14:16.182362  /lava-999766/bin/lava-test-runner /lava-999=
766/1
    2023-08-23T18:14:16.203055  . /lava-999766/environment
    2023-08-23T18:14:16.203208  / # /lava-999766/bin/lava-test-runner /lava=
-999766/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e64c9244de721bd4b1e3e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e64c9244de721bd4b1e3ec
        failing since 36 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-23T18:14:20.932801  / # #
    2023-08-23T18:14:22.391811  export SHELL=3D/bin/sh
    2023-08-23T18:14:22.412257  #
    2023-08-23T18:14:22.412428  / # export SHELL=3D/bin/sh
    2023-08-23T18:14:24.293466  / # . /lava-999768/environment
    2023-08-23T18:14:27.745338  /lava-999768/bin/lava-test-runner /lava-999=
768/1
    2023-08-23T18:14:27.766087  . /lava-999768/environment
    2023-08-23T18:14:27.766196  / # /lava-999768/bin/lava-test-runner /lava=
-999768/1
    2023-08-23T18:14:27.845332  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-23T18:14:27.845552  + cd /lava-999768/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e64f635c8b629730b1e3c2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e64f635c8b629730b1e3c5
        failing since 36 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-23T18:26:16.408318  / # #
    2023-08-23T18:26:17.867779  export SHELL=3D/bin/sh
    2023-08-23T18:26:17.888268  #
    2023-08-23T18:26:17.888496  / # export SHELL=3D/bin/sh
    2023-08-23T18:26:19.770191  / # . /lava-999773/environment
    2023-08-23T18:26:23.221608  /lava-999773/bin/lava-test-runner /lava-999=
773/1
    2023-08-23T18:26:23.242301  . /lava-999773/environment
    2023-08-23T18:26:23.242424  / # /lava-999773/bin/lava-test-runner /lava=
-999773/1
    2023-08-23T18:26:23.321070  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-23T18:26:23.321264  + cd /lava-999773/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4218a2a8982ac835b1dc

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4218a2a8982ac835b1e1
        failing since 29 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-23T18:24:16.653948  / # #

    2023-08-23T18:24:16.756071  export SHELL=3D/bin/sh

    2023-08-23T18:24:16.756782  #

    2023-08-23T18:24:16.858235  / # export SHELL=3D/bin/sh. /lava-11338410/=
environment

    2023-08-23T18:24:16.858944  =


    2023-08-23T18:24:16.960384  / # . /lava-11338410/environment/lava-11338=
410/bin/lava-test-runner /lava-11338410/1

    2023-08-23T18:24:16.961507  =


    2023-08-23T18:24:16.978622  / # /lava-11338410/bin/lava-test-runner /la=
va-11338410/1

    2023-08-23T18:24:17.027067  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T18:24:17.027580  + cd /lav<8>[   16.414382] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11338410_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd421a461736367d35b27b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd421a461736367d35b280
        failing since 29 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-23T18:24:32.735251  / # #

    2023-08-23T18:24:32.837430  export SHELL=3D/bin/sh

    2023-08-23T18:24:32.838154  #

    2023-08-23T18:24:32.939592  / # export SHELL=3D/bin/sh. /lava-11338415/=
environment

    2023-08-23T18:24:32.940314  =


    2023-08-23T18:24:33.041794  / # . /lava-11338415/environment/lava-11338=
415/bin/lava-test-runner /lava-11338415/1

    2023-08-23T18:24:33.042901  =


    2023-08-23T18:24:33.059682  / # /lava-11338415/bin/lava-test-runner /la=
va-11338415/1

    2023-08-23T18:24:33.101467  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T18:24:33.118663  + cd /lava-1133841<8>[   18.208357] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11338415_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
