Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF176B4D2
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 14:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjHAMeR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 08:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHAMeQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 08:34:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FB41FC9
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 05:34:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686b9920362so3959538b3a.1
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690893253; x=1691498053;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOXniZ6iC2q7jKjMOsL011DwXhGTBxPJW1gqOYYlzQo=;
        b=fbfj+hNXk3SwvvRkDck/KTCUNnkspXKkWiI69+LBsw5JikpRCU/8EHjYq9WCrb1i2S
         ew5brMGHpGRB/bErOOH/+Lse6+9H3mkAjYcchO6da3D3TWID9dpBuMXg1yd/a0DCUqrt
         /kwQnhmZ9qfjPD0ogdQaf0QHS74DfN3OCP1YorylCqikFa73Hm1UZUIKOhR/xFlLG+z8
         euNg1/OtZ8+DIIMrbKBusFmBXus8AKCdFmMnpKmDgxtyOl7AplR8gdV5PyFhGxL+oVs9
         Z4bF6dCLnIV+pyTHOBVknQT6HKZH15iukBMeaAQcfsBiJwaNlbIxCD/xhe/tLH1U94QR
         8Hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690893253; x=1691498053;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOXniZ6iC2q7jKjMOsL011DwXhGTBxPJW1gqOYYlzQo=;
        b=jAUS3/YpHGJyBd1o0jlOm4/rOY++D3YuttWJT2Jk8/ir6exoqS3HLbHRqDHurKAFEM
         bhCANVSg54VCLMLNBk+r9PLY1EzRvuqzpZAYlKuf6S49GrJn60QJvfVWdwsS/vbUMZNh
         r5KVCVnZdu2G1mwF/jiLM7W7yXOAN8Km+s4Rgf/qO9+gPbjV0MsqWMms+RgWijBOrpuD
         RP55/WknWKYZ4jQl4HlufzJH03MZJIbx1ZxzDTRxxs46omks/iUUwVizKGGctLi7nyQZ
         YxW/s4g5K3MB4m5aa0wWzjJOTBKgyggv/tyg32pBXtKwVgwdyJy1WOL/hY6vmBRMDtKa
         OJMA==
X-Gm-Message-State: ABy/qLYBSGvBrYW2a/n8q/2+hnWLlkUNMtUYgX21k+ZcwsHj37OUEv04
        qxksJJV4ttglxc9gb7WoAw0CPAVtrT6fqk1wxbjIFA==
X-Google-Smtp-Source: APBJJlHIM2NlrgBZgPk97WwJ2teOmBAn+THmDhBae1dh2f9ZQS1b6k55EMMz7komejFoRt4OqIwQ+w==
X-Received: by 2002:a05:6a20:8e27:b0:13e:aede:f37e with SMTP id y39-20020a056a208e2700b0013eaedef37emr674631pzj.41.1690893252695;
        Tue, 01 Aug 2023 05:34:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g3-20020a62e303000000b00686da0e163bsm4484031pfh.11.2023.08.01.05.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:34:11 -0700 (PDT)
Message-ID: <64c8fbc3.620a0220.f852c.87f7@mx.google.com>
Date:   Tue, 01 Aug 2023 05:34:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.188-107-gc262f74329e1
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 132 runs,
 12 regressions (v5.10.188-107-gc262f74329e1)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 132 runs, 12 regressions (v5.10.188-107-gc=
262f74329e1)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.188-107-gc262f74329e1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.188-107-gc262f74329e1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c262f74329e1393b1602ad7432dd2d776c841251 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8cab6b74228ac378ace20

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8cab6b74228ac378ace25
        failing since 195 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-01T09:04:34.436203  + set +x<8>[   11.049764] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3727029_1.5.2.4.1>
    2023-08-01T09:04:34.436474  =

    2023-08-01T09:04:34.542613  / # #
    2023-08-01T09:04:34.644388  export SHELL=3D/bin/sh
    2023-08-01T09:04:34.645274  #
    2023-08-01T09:04:34.747146  / # export SHELL=3D/bin/sh. /lava-3727029/e=
nvironment
    2023-08-01T09:04:34.747948  =

    2023-08-01T09:04:34.849808  / # . /lava-3727029/environment/lava-372702=
9/bin/lava-test-runner /lava-3727029/1
    2023-08-01T09:04:34.850379  =

    2023-08-01T09:04:34.855576  / # /lava-3727029/bin/lava-test-runner /lav=
a-3727029/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8cb32a618c3dc778ace47

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8cb32a618c3dc778ace4a
        failing since 14 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-01T09:06:35.915180  [    9.388912] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1239936_1.5.2.4.1>
    2023-08-01T09:06:36.020501  =

    2023-08-01T09:06:36.121660  / # #export SHELL=3D/bin/sh
    2023-08-01T09:06:36.122060  =

    2023-08-01T09:06:36.223037  / # export SHELL=3D/bin/sh. /lava-1239936/e=
nvironment
    2023-08-01T09:06:36.223464  =

    2023-08-01T09:06:36.324472  / # . /lava-1239936/environment/lava-123993=
6/bin/lava-test-runner /lava-1239936/1
    2023-08-01T09:06:36.325593  =

    2023-08-01T09:06:36.328571  / # /lava-1239936/bin/lava-test-runner /lav=
a-1239936/1
    2023-08-01T09:06:36.345300  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8cb302c8ce573d68acea5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8cb302c8ce573d68acea8
        failing since 150 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-01T09:06:35.619030  [   11.469189] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1239935_1.5.2.4.1>
    2023-08-01T09:06:35.724172  =

    2023-08-01T09:06:35.825376  / # #export SHELL=3D/bin/sh
    2023-08-01T09:06:35.825795  =

    2023-08-01T09:06:35.926717  / # export SHELL=3D/bin/sh. /lava-1239935/e=
nvironment
    2023-08-01T09:06:35.927117  =

    2023-08-01T09:06:36.028110  / # . /lava-1239935/environment/lava-123993=
5/bin/lava-test-runner /lava-1239935/1
    2023-08-01T09:06:36.028769  =

    2023-08-01T09:06:36.032730  / # /lava-1239935/bin/lava-test-runner /lav=
a-1239935/1
    2023-08-01T09:06:36.048246  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8ca4b4f8252b73e8ace3b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8ca4b4f8252b73e8ace40
        failing since 125 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-01T09:03:24.811838  + <8>[   10.243804] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11182094_1.4.2.3.1>

    2023-08-01T09:03:24.811921  set +x

    2023-08-01T09:03:24.913044  #

    2023-08-01T09:03:24.913283  =


    2023-08-01T09:03:25.013969  / # #export SHELL=3D/bin/sh

    2023-08-01T09:03:25.014143  =


    2023-08-01T09:03:25.114663  / # export SHELL=3D/bin/sh. /lava-11182094/=
environment

    2023-08-01T09:03:25.114840  =


    2023-08-01T09:03:25.215395  / # . /lava-11182094/environment/lava-11182=
094/bin/lava-test-runner /lava-11182094/1

    2023-08-01T09:03:25.215719  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8ca531ae4a43b2e8ace2c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8ca531ae4a43b2e8ace31
        failing since 125 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-01T09:02:56.581418  <8>[   12.983214] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182110_1.4.2.3.1>

    2023-08-01T09:02:56.584535  + set +x

    2023-08-01T09:02:56.685745  #

    2023-08-01T09:02:56.685965  =


    2023-08-01T09:02:56.786560  / # #export SHELL=3D/bin/sh

    2023-08-01T09:02:56.786718  =


    2023-08-01T09:02:56.887235  / # export SHELL=3D/bin/sh. /lava-11182110/=
environment

    2023-08-01T09:02:56.887391  =


    2023-08-01T09:02:56.987919  / # . /lava-11182110/environment/lava-11182=
110/bin/lava-test-runner /lava-11182110/1

    2023-08-01T09:02:56.988201  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8cb647b52a7cfbb8ace3b

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8cb647b52a7cfbb8ace6a
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T09:07:31.131088  / # #
    2023-08-01T09:07:31.233890  export SHELL=3D/bin/sh
    2023-08-01T09:07:31.234646  #
    2023-08-01T09:07:31.336494  / # export SHELL=3D/bin/sh. /lava-22729/env=
ironment
    2023-08-01T09:07:31.337264  =

    2023-08-01T09:07:31.439149  / # . /lava-22729/environment/lava-22729/bi=
n/lava-test-runner /lava-22729/1
    2023-08-01T09:07:31.440416  =

    2023-08-01T09:07:31.455638  / # /lava-22729/bin/lava-test-runner /lava-=
22729/1
    2023-08-01T09:07:31.513420  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-01T09:07:31.513930  + cd /lava-22729/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8cb3e00f9dae0868acea2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8cb3e00f9dae0868acea5
        new failure (last pass: v5.10.186-10-g5f99a36aeb1c)

    2023-08-01T09:06:42.009664  + set +x
    2023-08-01T09:06:42.012876  <8>[   83.650840] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 991181_1.5.2.4.1>
    2023-08-01T09:06:42.120124  / # #
    2023-08-01T09:06:43.583955  export SHELL=3D/bin/sh
    2023-08-01T09:06:43.604810  #
    2023-08-01T09:06:43.605239  / # export SHELL=3D/bin/sh
    2023-08-01T09:06:45.491822  / # . /lava-991181/environment
    2023-08-01T09:06:48.950262  /lava-991181/bin/lava-test-runner /lava-991=
181/1
    2023-08-01T09:06:48.971784  . /lava-991181/environment
    2023-08-01T09:06:48.972207  / # /lava-991181/bin/lava-test-runner /lava=
-991181/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8cbacbb329034bb8ace68

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8cbacbb329034bb8ace6b
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T09:08:44.609416  + set +x
    2023-08-01T09:08:44.609525  <8>[   83.558759] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 991174_1.5.2.4.1>
    2023-08-01T09:08:44.715601  / # #
    2023-08-01T09:08:46.174840  export SHELL=3D/bin/sh
    2023-08-01T09:08:46.195253  #
    2023-08-01T09:08:46.195407  / # export SHELL=3D/bin/sh
    2023-08-01T09:08:48.076959  / # . /lava-991174/environment
    2023-08-01T09:08:51.527961  /lava-991174/bin/lava-test-runner /lava-991=
174/1
    2023-08-01T09:08:51.548580  . /lava-991174/environment
    2023-08-01T09:08:51.548699  / # /lava-991174/bin/lava-test-runner /lava=
-991174/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8cbb1bb329034bb8ace78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8cbb1bb329034bb8ace7b
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T09:08:24.495390  + set +x
    2023-08-01T09:08:24.495501  <8>[   84.060521] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 991175_1.5.2.4.1>
    2023-08-01T09:08:24.601305  / # #
    2023-08-01T09:08:26.060236  export SHELL=3D/bin/sh
    2023-08-01T09:08:26.080705  #
    2023-08-01T09:08:26.080847  / # export SHELL=3D/bin/sh
    2023-08-01T09:08:27.961990  / # . /lava-991175/environment
    2023-08-01T09:08:31.412715  /lava-991175/bin/lava-test-runner /lava-991=
175/1
    2023-08-01T09:08:31.433305  . /lava-991175/environment
    2023-08-01T09:08:31.433422  / # /lava-991175/bin/lava-test-runner /lava=
-991175/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8cbc1bb329034bb8ace96

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8cbc1bb329034bb8ace99
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T09:08:53.732431  / # #
    2023-08-01T09:08:55.191528  export SHELL=3D/bin/sh
    2023-08-01T09:08:55.211975  #
    2023-08-01T09:08:55.212141  / # export SHELL=3D/bin/sh
    2023-08-01T09:08:57.093726  / # . /lava-991180/environment
    2023-08-01T09:09:00.545494  /lava-991180/bin/lava-test-runner /lava-991=
180/1
    2023-08-01T09:09:00.566364  . /lava-991180/environment
    2023-08-01T09:09:00.566495  / # /lava-991180/bin/lava-test-runner /lava=
-991180/1
    2023-08-01T09:09:00.647321  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-01T09:09:00.647545  + cd /lava-991180/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8ccecbdf155fbf38ace2f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8ccecbdf155fbf38ace32
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T09:13:58.132004  / # #
    2023-08-01T09:13:59.590994  export SHELL=3D/bin/sh
    2023-08-01T09:13:59.611399  #
    2023-08-01T09:13:59.611532  / # export SHELL=3D/bin/sh
    2023-08-01T09:14:01.492798  / # . /lava-991183/environment
    2023-08-01T09:14:04.942953  /lava-991183/bin/lava-test-runner /lava-991=
183/1
    2023-08-01T09:14:04.963524  . /lava-991183/environment
    2023-08-01T09:14:04.963634  / # /lava-991183/bin/lava-test-runner /lava=
-991183/1
    2023-08-01T09:14:05.044888  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-01T09:14:05.045013  + cd /lava-991183/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8cad7b74228ac378acebf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-107-gc262f74329e1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8cad7b74228ac378acec4
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T09:06:43.950842  / # #

    2023-08-01T09:06:44.052930  export SHELL=3D/bin/sh

    2023-08-01T09:06:44.053631  #

    2023-08-01T09:06:44.154713  / # export SHELL=3D/bin/sh. /lava-11182177/=
environment

    2023-08-01T09:06:44.154910  =


    2023-08-01T09:06:44.255353  / # . /lava-11182177/environment/lava-11182=
177/bin/lava-test-runner /lava-11182177/1

    2023-08-01T09:06:44.255543  =


    2023-08-01T09:06:44.258848  / # /lava-11182177/bin/lava-test-runner /la=
va-11182177/1

    2023-08-01T09:06:44.327736  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T09:06:44.327812  + cd /lava-1118217<8>[   18.296763] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11182177_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
