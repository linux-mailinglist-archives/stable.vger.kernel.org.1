Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C347774FA8
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 02:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjHIACi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 20:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHIACh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 20:02:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F261BCD
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 17:02:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc02bd4eafso53212865ad.1
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691539355; x=1692144155;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5/FSdh/bl19y4bx0Xt5WwGBVmb+Jau7AahEykhS+o8=;
        b=j4qztuMXRakBDUDT5mcRQi6sFCBJKSs5Uqscwg8P4wVMVdCbq16BXy/5+WgV6ObLaB
         GHAaI4PrveOKHZIe12gW8igcTo7NnWBc5ccGFxik0KTb1Wosa6BedBJ0+UJ++CKmdfEr
         LZGts2UHSWf9cKWbFZoCtqPJmp0MrsW6Km7sAFMgLE/814lPkIzDONInt1HEPgppwpNC
         eGTpXdGoR+IqnXeOBMD1zzVGoN3Hcqp1opf0qNTg1ow/G/x+tc8Uz60R+RsqX0sjqcQp
         NZF6vxRtm75vQnz4nA0mzU9KkMeRhql3l7jPEP9xTQSuxZj/yVUBDT7Jbpryix7DzdDs
         lRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691539355; x=1692144155;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5/FSdh/bl19y4bx0Xt5WwGBVmb+Jau7AahEykhS+o8=;
        b=Xr+px38aMzQ5kXrfsJ3eA7RH3nKNCHGnXmzAf9E9slAHsPkqqRMrPDi483D+lXhz5H
         Wh4aF358Ant2aoKSiVm+AT47dEAI+Pzvtz5Msmfm/uDIjc8Tcw1MhNV3BYcITgCBzhaB
         QShpvNs3lZT2XFCNTwLLphOwhTSXEuopA6faV+n6WKXn9EJawKf1VYBHFOP/3X6Tprry
         a2Sq+dDhuOQWgICQplH4OLODU3/2m9uvUGEXQbcRVLMgBWR3YHz7o6gSZkuBklL20sDb
         4iOT9U93un4Sy9f8Ho3WbvSJqeDwnDRhIIJpF1sqoEACXmfxDVWqZgzJVN8GHHho56Xo
         ES4w==
X-Gm-Message-State: AOJu0YwDoj/ordAKJ59oaggilWlZucSoC/gslj/Kfj1OJ7AYg8NkImUN
        Qa/26Ov/oV+An7B70VPjGazozdmbNV7cu5irmzyEIg==
X-Google-Smtp-Source: AGHT+IEEUNGSMiob3+e/yolmMhYcGBqVAc6yq5mHK9WnAAnVxcmfxd01lnwO62DkaETHTG/pDs6lfg==
X-Received: by 2002:a17:90a:3c87:b0:268:87bd:d82d with SMTP id g7-20020a17090a3c8700b0026887bdd82dmr954533pjc.18.1691539353362;
        Tue, 08 Aug 2023 17:02:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902eb4c00b001b8ad8382a4sm9540063pli.216.2023.08.08.17.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:02:32 -0700 (PDT)
Message-ID: <64d2d798.170a0220.85912.2210@mx.google.com>
Date:   Tue, 08 Aug 2023 17:02:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.189
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.10.y
Subject: stable/linux-5.10.y baseline: 121 runs, 11 regressions (v5.10.189)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y baseline: 121 runs, 11 regressions (v5.10.189)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
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

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.189/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.189
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      de5f63612d1631c89e72ecffc089f948392cf24a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a159c24f581bfe35b234

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a159c24f581bfe35b239
        failing since 202 days (last pass: v5.10.158, first fail: v5.10.164)

    2023-08-08T20:10:58.269530  <8>[   11.047060] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3733300_1.5.2.4.1>
    2023-08-08T20:10:58.379228  / # #
    2023-08-08T20:10:58.482405  export SHELL=3D/bin/sh
    2023-08-08T20:10:58.483317  #
    2023-08-08T20:10:58.585333  / # export SHELL=3D/bin/sh. /lava-3733300/e=
nvironment
    2023-08-08T20:10:58.586224  =

    2023-08-08T20:10:58.688326  / # . /lava-3733300/environment/lava-373330=
0/bin/lava-test-runner /lava-3733300/1
    2023-08-08T20:10:58.689965  =

    2023-08-08T20:10:58.694379  / # /lava-3733300/bin/lava-test-runner /lav=
a-3733300/1
    2023-08-08T20:10:58.777274  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a0a48528ae121d35b219

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a0a48528ae121d35b21e
        failing since 125 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-08-08T20:07:57.248219  + set +x

    2023-08-08T20:07:57.254669  <8>[   14.660269] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236290_1.4.2.3.1>

    2023-08-08T20:07:57.362704  / # #

    2023-08-08T20:07:57.465144  export SHELL=3D/bin/sh

    2023-08-08T20:07:57.466004  #

    2023-08-08T20:07:57.567561  / # export SHELL=3D/bin/sh. /lava-11236290/=
environment

    2023-08-08T20:07:57.568451  =


    2023-08-08T20:07:57.670204  / # . /lava-11236290/environment/lava-11236=
290/bin/lava-test-runner /lava-11236290/1

    2023-08-08T20:07:57.671365  =


    2023-08-08T20:07:57.676115  / # /lava-11236290/bin/lava-test-runner /la=
va-11236290/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a74450ae2b384435b1d9

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a74450ae2b384435b215
        new failure (last pass: v5.10.188)

    2023-08-08T20:36:02.425387  <8>[   14.285652] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 38932_1.5.2.4.1>
    2023-08-08T20:36:02.534959  / # #
    2023-08-08T20:36:02.638038  export SHELL=3D/bin/sh
    2023-08-08T20:36:02.638840  #
    2023-08-08T20:36:02.740848  / # export SHELL=3D/bin/sh. /lava-38932/env=
ironment
    2023-08-08T20:36:02.741648  =

    2023-08-08T20:36:02.843707  / # . /lava-38932/environment/lava-38932/bi=
n/lava-test-runner /lava-38932/1
    2023-08-08T20:36:02.845104  =

    2023-08-08T20:36:02.857645  / # /lava-38932/bin/lava-test-runner /lava-=
38932/1
    2023-08-08T20:36:02.917439  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2b5d3134900aabc35b1ea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2b5d3134900aabc35b1ed
        failing since 12 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-08-08T21:37:58.642996  + set +x
    2023-08-08T21:37:58.643119  <8>[   83.693270] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994342_1.5.2.4.1>
    2023-08-08T21:37:58.753641  / # #
    2023-08-08T21:38:00.213469  export SHELL=3D/bin/sh
    2023-08-08T21:38:00.233905  #
    2023-08-08T21:38:00.234030  / # export SHELL=3D/bin/sh
    2023-08-08T21:38:02.116003  / # . /lava-994342/environment
    2023-08-08T21:38:05.570108  /lava-994342/bin/lava-test-runner /lava-994=
342/1
    2023-08-08T21:38:05.590833  . /lava-994342/environment
    2023-08-08T21:38:05.590942  / # /lava-994342/bin/lava-test-runner /lava=
-994342/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a328cdeac946e935b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a328cdeac946e935b1dc
        failing since 12 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-08-08T20:18:20.480616  + set +x
    2023-08-08T20:18:20.480832  <8>[   83.955666] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994343_1.5.2.4.1>
    2023-08-08T20:18:20.586697  / # #
    2023-08-08T20:18:22.046050  export SHELL=3D/bin/sh
    2023-08-08T20:18:22.066622  #
    2023-08-08T20:18:22.066852  / # export SHELL=3D/bin/sh
    2023-08-08T20:18:23.948879  / # . /lava-994343/environment
    2023-08-08T20:18:27.399585  /lava-994343/bin/lava-test-runner /lava-994=
343/1
    2023-08-08T20:18:27.420410  . /lava-994343/environment
    2023-08-08T20:18:27.420536  / # /lava-994343/bin/lava-test-runner /lava=
-994343/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a37a6c89c9199135b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a37a6c89c9199135b1dd
        failing since 12 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-08-08T20:19:16.059659  / # #
    2023-08-08T20:19:17.518722  export SHELL=3D/bin/sh
    2023-08-08T20:19:17.539169  #
    2023-08-08T20:19:17.539330  / # export SHELL=3D/bin/sh
    2023-08-08T20:19:19.420301  / # . /lava-994345/environment
    2023-08-08T20:19:22.870491  /lava-994345/bin/lava-test-runner /lava-994=
345/1
    2023-08-08T20:19:22.891298  . /lava-994345/environment
    2023-08-08T20:19:22.891407  / # /lava-994345/bin/lava-test-runner /lava=
-994345/1
    2023-08-08T20:19:22.972730  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-08T20:19:22.972874  + cd /lava-994345/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a774a111acfa5a35b2ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a774a111acfa5a35b2f0
        failing since 12 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-08T20:36:22.072082  / # #
    2023-08-08T20:36:23.531552  export SHELL=3D/bin/sh
    2023-08-08T20:36:23.552058  #
    2023-08-08T20:36:23.552266  / # export SHELL=3D/bin/sh
    2023-08-08T20:36:25.433997  / # . /lava-994413/environment
    2023-08-08T20:36:28.884434  /lava-994413/bin/lava-test-runner /lava-994=
413/1
    2023-08-08T20:36:28.905001  . /lava-994413/environment
    2023-08-08T20:36:28.905121  / # /lava-994413/bin/lava-test-runner /lava=
-994413/1
    2023-08-08T20:36:28.984958  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-08T20:36:28.985121  + cd /lava-994413/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a6be8c1a8435e535b264

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a6be8c1a8435e535b269
        failing since 12 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-08T20:35:11.899157  / # #

    2023-08-08T20:35:12.001236  export SHELL=3D/bin/sh

    2023-08-08T20:35:12.001967  #

    2023-08-08T20:35:12.103344  / # export SHELL=3D/bin/sh. /lava-11236495/=
environment

    2023-08-08T20:35:12.104233  =


    2023-08-08T20:35:12.205837  / # . /lava-11236495/environment/lava-11236=
495/bin/lava-test-runner /lava-11236495/1

    2023-08-08T20:35:12.206997  =


    2023-08-08T20:35:12.223227  / # /lava-11236495/bin/lava-test-runner /la=
va-11236495/1

    2023-08-08T20:35:12.272668  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T20:35:12.273215  + cd /lav<8>[   16.447225] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11236495_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d2a2a923f9d526a635b233

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d2a2a923f9d526a635b239
        failing since 144 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-08-08T20:17:05.275486  /lava-11236379/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d2a2a923f9d526a635b23a
        failing since 144 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-08-08T20:17:04.239291  /lava-11236379/1/../bin/lava-test-case

    2023-08-08T20:17:04.249428  <8>[   33.868682] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a6bd8c1a8435e535b24e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.189/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a6bd8c1a8435e535b253
        failing since 12 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-08-08T20:35:23.710496  / # #

    2023-08-08T20:35:23.812523  export SHELL=3D/bin/sh

    2023-08-08T20:35:23.813207  #

    2023-08-08T20:35:23.914518  / # export SHELL=3D/bin/sh. /lava-11236494/=
environment

    2023-08-08T20:35:23.915217  =


    2023-08-08T20:35:24.016625  / # . /lava-11236494/environment/lava-11236=
494/bin/lava-test-runner /lava-11236494/1

    2023-08-08T20:35:24.017755  =


    2023-08-08T20:35:24.034593  / # /lava-11236494/bin/lava-test-runner /la=
va-11236494/1

    2023-08-08T20:35:24.077421  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T20:35:24.092573  + cd /lava-1123649<8>[   18.289541] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11236494_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
