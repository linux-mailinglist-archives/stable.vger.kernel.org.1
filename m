Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DB07AC2E2
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjIWO53 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIWO52 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 10:57:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8213D3
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 07:57:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c451541f23so29962045ad.2
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695481040; x=1696085840; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oMcnmy9j10MREbDgVDwapicV2/afKNvjTQdhcM68B+s=;
        b=mFrbPmxXQB0P17Cfvy3L9YdRvbpZ6z6rkr7KlWsQlTVc/gymlC9ByRhjAg6pYQ7UhF
         pn3TYR49H7SmggIFxlYIaW0CxoYeLCJWdePyx8Yh9gJTSux6fQ4ulg+GlrJcVf3SifGw
         y4IcpqTVsd+mHGy9uTl/3FNmTJZiJs/wHScEhtCmU4pQx5vzrFbuLbrM6DgfpJpER16P
         pG87hxCgYMDt+2TB3b3bVzb67HCI2tazrRAEbQa3wtRZSNgFW/aWXkaM5kY6pt3B5+Om
         IB2nDadwP9/XYdaOY1t2uW9Cj9w4h+iH95TF/eaQ0cDTlA4ZDc6+wrb4Y1v/SKQx6Cfr
         BsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695481040; x=1696085840;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMcnmy9j10MREbDgVDwapicV2/afKNvjTQdhcM68B+s=;
        b=hhtM6OOPuMwsMoZKg08/aWQVl93O3Xc7zBPyDnY3o+jfZi3NfDzRY+tCjCEB9cPF1p
         ulZVc88oyeBj4O0vrnG5EcIHYY630MweFVC38fiOfnph3Bq4UKPLo4nO1FwoteJ3+3Tr
         466IM48IjEMFuHBZRAGYrET1fD3rvFferMD4ggmfo1ucxUZlQ04UBJlAwQb5WSK66G7M
         fIPy9qrEGLs0bDMtdtHeZBIZAF72kA6b+z44Fu5n4LEHT8Y1zTREQJyv+wc2Zhk3xOpQ
         GkO+Op6AvQ2JP7+4ZuYAXEMpOqMPU/p/ZTdyqC6xeTtmBwHwVaM6P7NVenCdLCxq5oFi
         aVoQ==
X-Gm-Message-State: AOJu0YwjKPG3dg5e+osPtNWkF6VZZCaI3XF/FvUqZ/v926KrWbRy+eal
        OXAmGmifD8FvylZYECPwkYXPlzQ7CwkZ0YVmoV9Sig==
X-Google-Smtp-Source: AGHT+IEN7ri62dpG9cin3u6ET3TuINwtn+hgxrwhOOpZ86AecJE32wFJPZ+6DX4HrOZ+FJS/rAS6hw==
X-Received: by 2002:a17:902:d2cf:b0:1c3:aef9:872e with SMTP id n15-20020a170902d2cf00b001c3aef9872emr2141798plc.34.1695481040417;
        Sat, 23 Sep 2023 07:57:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001c4247300adsm5420767ply.276.2023.09.23.07.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 07:57:19 -0700 (PDT)
Message-ID: <650efccf.170a0220.9d314.a88c@mx.google.com>
Date:   Sat, 23 Sep 2023 07:57:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.197
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 118 runs, 9 regressions (v5.10.197)
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

stable-rc/linux-5.10.y baseline: 118 runs, 9 regressions (v5.10.197)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.197/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.197
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      393e225fe8ff80ecc47065235027ce1a7fcbb8e5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec95901b0fbcf4d8a0a79

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec95901b0fbcf4d8a0a82
        failing since 178 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-23T11:17:48.915784  + set +x

    2023-09-23T11:17:48.922156  <8>[    8.088189] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601612_1.4.2.3.1>

    2023-09-23T11:17:49.026458  / # #

    2023-09-23T11:17:49.127106  export SHELL=3D/bin/sh

    2023-09-23T11:17:49.127320  #

    2023-09-23T11:17:49.227823  / # export SHELL=3D/bin/sh. /lava-11601612/=
environment

    2023-09-23T11:17:49.228031  =


    2023-09-23T11:17:49.328558  / # . /lava-11601612/environment/lava-11601=
612/bin/lava-test-runner /lava-11601612/1

    2023-09-23T11:17:49.328879  =


    2023-09-23T11:17:49.333963  / # /lava-11601612/bin/lava-test-runner /la=
va-11601612/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec9790b8b94a98b8a0a5f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec9790b8b94a98b8a0a68
        failing since 178 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-23T11:19:24.274521  <8>[   13.295801] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601634_1.4.2.3.1>

    2023-09-23T11:19:24.277294  + set +x

    2023-09-23T11:19:24.378984  #

    2023-09-23T11:19:24.379305  =


    2023-09-23T11:19:24.479957  / # #export SHELL=3D/bin/sh

    2023-09-23T11:19:24.480183  =


    2023-09-23T11:19:24.580793  / # export SHELL=3D/bin/sh. /lava-11601634/=
environment

    2023-09-23T11:19:24.581006  =


    2023-09-23T11:19:24.681559  / # . /lava-11601634/environment/lava-11601=
634/bin/lava-test-runner /lava-11601634/1

    2023-09-23T11:19:24.681908  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ecb6f4c8cda5a6d8a0a7d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ecb6f4c8cda5a6d8a0abd
        failing since 2 days (last pass: v5.10.195, first fail: v5.10.195-8=
4-gf147286de8e5)

    2023-09-23T11:26:20.528481  / # #
    2023-09-23T11:26:20.631346  export SHELL=3D/bin/sh
    2023-09-23T11:26:20.632180  #
    2023-09-23T11:26:20.734136  / # export SHELL=3D/bin/sh. /lava-127491/en=
vironment
    2023-09-23T11:26:20.734970  =

    2023-09-23T11:26:20.836955  / # . /lava-127491/environment/lava-127491/=
bin/lava-test-runner /lava-127491/1
    2023-09-23T11:26:20.838260  =

    2023-09-23T11:26:20.852473  / # /lava-127491/bin/lava-test-runner /lava=
-127491/1
    2023-09-23T11:26:20.911273  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-23T11:26:20.911776  + cd /lava-127491/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650eedb05e03e9f4828a0a4f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eedb05e03e9f4828a0a56
        failing since 67 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-23T13:52:26.129934  + set +x
    2023-09-23T13:52:26.133106  <8>[   83.898694] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1012367_1.5.2.4.1>
    2023-09-23T13:52:26.242070  / # #
    2023-09-23T13:52:27.704563  export SHELL=3D/bin/sh
    2023-09-23T13:52:27.725353  #
    2023-09-23T13:52:27.725623  / # export SHELL=3D/bin/sh
    2023-09-23T13:52:29.679918  / # . /lava-1012367/environment
    2023-09-23T13:52:33.276484  /lava-1012367/bin/lava-test-runner /lava-10=
12367/1
    2023-09-23T13:52:33.297458  . /lava-1012367/environment
    2023-09-23T13:52:33.297709  / # /lava-1012367/bin/lava-test-runner /lav=
a-1012367/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ece2cdc37a82c4a8a0a68

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ece2cdc37a82c4a8a0a6f
        failing since 67 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-23T11:37:21.893132  + set +x
    2023-09-23T11:37:21.893250  <8>[   84.241426] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1012366_1.5.2.4.1>
    2023-09-23T11:37:21.998736  / # #
    2023-09-23T11:37:23.458400  export SHELL=3D/bin/sh
    2023-09-23T11:37:23.478872  #
    2023-09-23T11:37:23.479070  / # export SHELL=3D/bin/sh
    2023-09-23T11:37:25.430696  / # . /lava-1012366/environment
    2023-09-23T11:37:29.026699  /lava-1012366/bin/lava-test-runner /lava-10=
12366/1
    2023-09-23T11:37:29.047372  . /lava-1012366/environment
    2023-09-23T11:37:29.047482  / # /lava-1012366/bin/lava-test-runner /lav=
a-1012366/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ece2eb3cc5c173f8a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ece2eb3cc5c173f8a0a49
        failing since 67 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-23T11:37:36.878292  / # #
    2023-09-23T11:37:38.337398  export SHELL=3D/bin/sh
    2023-09-23T11:37:38.357857  #
    2023-09-23T11:37:38.358021  / # export SHELL=3D/bin/sh
    2023-09-23T11:37:40.309267  / # . /lava-1012368/environment
    2023-09-23T11:37:43.899928  /lava-1012368/bin/lava-test-runner /lava-10=
12368/1
    2023-09-23T11:37:43.920553  . /lava-1012368/environment
    2023-09-23T11:37:43.920690  / # /lava-1012368/bin/lava-test-runner /lav=
a-1012368/1
    2023-09-23T11:37:43.999942  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-23T11:37:44.000130  + cd /lava-1012368/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ecae24158f0e7c98a0a45

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ecae24158f0e7c98a0a4e
        failing since 67 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-23T11:28:18.990797  / # #

    2023-09-23T11:28:19.091616  export SHELL=3D/bin/sh

    2023-09-23T11:28:19.092275  #

    2023-09-23T11:28:19.193533  / # export SHELL=3D/bin/sh. /lava-11601646/=
environment

    2023-09-23T11:28:19.194287  =


    2023-09-23T11:28:19.295666  / # . /lava-11601646/environment/lava-11601=
646/bin/lava-test-runner /lava-11601646/1

    2023-09-23T11:28:19.296665  =


    2023-09-23T11:28:19.299632  / # /lava-11601646/bin/lava-test-runner /la=
va-11601646/1

    2023-09-23T11:28:19.362106  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T11:28:19.362467  + cd /lav<8>[   16.471958] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11601646_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ecb169f687593498a0a53

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ecb169f687593498a0a5c
        failing since 29 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-09-23T11:24:43.986613  / # #

    2023-09-23T11:24:45.247392  export SHELL=3D/bin/sh

    2023-09-23T11:24:45.258359  #

    2023-09-23T11:24:45.258829  / # export SHELL=3D/bin/sh

    2023-09-23T11:24:47.002975  / # . /lava-11601643/environment

    2023-09-23T11:24:50.208910  /lava-11601643/bin/lava-test-runner /lava-1=
1601643/1

    2023-09-23T11:24:50.220362  . /lava-11601643/environment

    2023-09-23T11:24:50.223456  / # /lava-11601643/bin/lava-test-runner /la=
va-11601643/1

    2023-09-23T11:24:50.275489  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T11:24:50.275981  + cd /lava-11601643/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ecaf7e10c3e35298a0af0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
97/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ecaf7e10c3e35298a0af9
        failing since 67 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-23T11:28:34.931759  / # #

    2023-09-23T11:28:35.033921  export SHELL=3D/bin/sh

    2023-09-23T11:28:35.034604  #

    2023-09-23T11:28:35.136005  / # export SHELL=3D/bin/sh. /lava-11601652/=
environment

    2023-09-23T11:28:35.136704  =


    2023-09-23T11:28:35.238143  / # . /lava-11601652/environment/lava-11601=
652/bin/lava-test-runner /lava-11601652/1

    2023-09-23T11:28:35.239209  =


    2023-09-23T11:28:35.256074  / # /lava-11601652/bin/lava-test-runner /la=
va-11601652/1

    2023-09-23T11:28:35.300348  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T11:28:35.315090  + cd /lava-1160165<8>[   18.190009] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11601652_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
