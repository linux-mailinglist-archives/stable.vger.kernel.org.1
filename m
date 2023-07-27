Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99A7765587
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjG0OEY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjG0OEY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 10:04:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4455619AF
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 07:04:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686b9920362so766750b3a.1
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690466660; x=1691071460;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W3oPRDnYQYTwBP+BdBb7NkEd8ZoEOXbGnZo9tU+JXLQ=;
        b=GT7MARb1h8/c234sBhMymuFcrHBD1tyHffsQyytuw4Uy0s4pfPHwik92kBjImdpDxu
         KLpdGJt4tpmu97Hr9btW82uqG+Ja4vJpA/VRqSyWwux1PuT1JxeJqXmduioq3Q9FkPfv
         BIN67n0uCfb28DVwRyO+p8Ap8ogtnbScgzSy2foH7tErPR+nzlz05CL8DoWvvM9ypCk9
         MXXt/Z6TB9GgmGt9tqQfdGI6QhOSo/rSqY3YZam4wE/fFrB+vnMTsUcDpBgUnT5Oz+Jq
         IGXu0sE3T/KYbB9qiP8fsSwI6mOpiwn920TS5xKi7Tc7eMA2AOp1CwL2DU1Q6B/6GdW8
         tVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690466660; x=1691071460;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3oPRDnYQYTwBP+BdBb7NkEd8ZoEOXbGnZo9tU+JXLQ=;
        b=jUlTKR7Vpc980YQrvPOeBhds+kO6szRVwyIMYz5oIgJCOzvp73ckDnmouiC7XhAAow
         tNKuxk2+LkJplvsCfow7KsVxFxq93clnAUqFaRGOUOaYi9SFBiMoLAowMkL//0Z0a1N6
         j4vWbMex3U3p7D6js7di7uJMogRFxLAecxdqMnOQSftA1MqjdSpRnaQTLd+yPTdvzVKO
         bMHkzAl3bIFdepnCt2I+BDvenB1kiwYNlGQCzI8Hz80+oNK2riA0QAt6xicuAd6JX4eG
         GQ6gQ6h53ez3JJeAFmsKiZGXueXAGOZadTdcV4F7xkMenWdrzYY+vhfyexSwV4p0j0re
         6NbA==
X-Gm-Message-State: ABy/qLbvyZ7Mw099ftxylxLMZggyjy7MgCA9qfq1vOzqv55HCW0sseam
        lD17vdJW1LcKtXqq0AV1Nxz7wxUjwOSuXXcU0YRVgA==
X-Google-Smtp-Source: APBJJlGqT3Fbo5FlVyN0khlUlHntGCEr7i3qdidN3J0z6nf1Nt9xu2bMCdNk5Aq8CRyUW7ap6694tg==
X-Received: by 2002:a05:6a00:230c:b0:686:290b:91f7 with SMTP id h12-20020a056a00230c00b00686290b91f7mr5413898pfh.22.1690466659918;
        Thu, 27 Jul 2023 07:04:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7870e000000b00686c77a2905sm1529188pfo.20.2023.07.27.07.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:04:19 -0700 (PDT)
Message-ID: <64c27963.a70a0220.d7d0.2d5b@mx.google.com>
Date:   Thu, 27 Jul 2023 07:04:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.123
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 125 runs, 14 regressions (v5.15.123)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 125 runs, 14 regressions (v5.15.123)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.123/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.123
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      09996673e3139a6d86fc3d95c852b3a020e2fe5f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c245703972ee511a8ace80

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c245703972ee511a8ace85
        failing since 120 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-27T10:22:30.262110  <8>[   10.894497] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150572_1.4.2.3.1>

    2023-07-27T10:22:30.265360  + set +x

    2023-07-27T10:22:30.370268  /#

    2023-07-27T10:22:30.473067   # #export SHELL=3D/bin/sh

    2023-07-27T10:22:30.474005  =


    2023-07-27T10:22:30.575749  / # export SHELL=3D/bin/sh. /lava-11150572/=
environment

    2023-07-27T10:22:30.576527  =


    2023-07-27T10:22:30.678118  / # . /lava-11150572/environment/lava-11150=
572/bin/lava-test-runner /lava-11150572/1

    2023-07-27T10:22:30.679348  =


    2023-07-27T10:22:30.685996  / # /lava-11150572/bin/lava-test-runner /la=
va-11150572/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c245743972ee511a8acea4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c245743972ee511a8acea9
        failing since 120 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-27T10:22:26.984831  + set<8>[   11.428800] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11150559_1.4.2.3.1>

    2023-07-27T10:22:26.984914   +x

    2023-07-27T10:22:27.089512  / # #

    2023-07-27T10:22:27.190059  export SHELL=3D/bin/sh

    2023-07-27T10:22:27.190218  #

    2023-07-27T10:22:27.290742  / # export SHELL=3D/bin/sh. /lava-11150559/=
environment

    2023-07-27T10:22:27.290926  =


    2023-07-27T10:22:27.391447  / # . /lava-11150559/environment/lava-11150=
559/bin/lava-test-runner /lava-11150559/1

    2023-07-27T10:22:27.391673  =


    2023-07-27T10:22:27.396555  / # /lava-11150559/bin/lava-test-runner /la=
va-11150559/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c245703972ee511a8ace75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c245703972ee511a8ace7a
        failing since 120 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-27T10:22:22.962520  <8>[   10.131031] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150555_1.4.2.3.1>

    2023-07-27T10:22:22.966066  + set +x

    2023-07-27T10:22:23.067379  =


    2023-07-27T10:22:23.167954  / # #export SHELL=3D/bin/sh

    2023-07-27T10:22:23.168110  =


    2023-07-27T10:22:23.268618  / # export SHELL=3D/bin/sh. /lava-11150555/=
environment

    2023-07-27T10:22:23.268798  =


    2023-07-27T10:22:23.369314  / # . /lava-11150555/environment/lava-11150=
555/bin/lava-test-runner /lava-11150555/1

    2023-07-27T10:22:23.369573  =


    2023-07-27T10:22:23.375096  / # /lava-11150555/bin/lava-test-runner /la=
va-11150555/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c248a08cfb2e86b68ace23

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c248a08cfb2e86b68ace28
        failing since 191 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-07-27T10:35:55.081748  + set +x<8>[   10.118777] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3725861_1.5.2.4.1>
    2023-07-27T10:35:55.082386  =

    2023-07-27T10:35:55.192234  / # #
    2023-07-27T10:35:55.295672  export SHELL=3D/bin/sh
    2023-07-27T10:35:55.296530  #
    2023-07-27T10:35:55.296975  / # <3>[   10.273381] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-07-27T10:35:55.398801  export SHELL=3D/bin/sh. /lava-3725861/envir=
onment
    2023-07-27T10:35:55.399207  =

    2023-07-27T10:35:55.500413  / # . /lava-3725861/environment/lava-372586=
1/bin/lava-test-runner /lava-3725861/1
    2023-07-27T10:35:55.500877   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c246696e129ed2c48ace65

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c246696e129ed2c48ace68
        failing since 13 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-07-27T10:26:25.074331  + [   11.819644] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1238965_1.5.2.4.1>
    2023-07-27T10:26:25.074667  set +x
    2023-07-27T10:26:25.180752  =

    2023-07-27T10:26:25.282040  / # #export SHELL=3D/bin/sh
    2023-07-27T10:26:25.282652  =

    2023-07-27T10:26:25.383861  / # export SHELL=3D/bin/sh. /lava-1238965/e=
nvironment
    2023-07-27T10:26:25.384466  =

    2023-07-27T10:26:25.485659  / # . /lava-1238965/environment/lava-123896=
5/bin/lava-test-runner /lava-1238965/1
    2023-07-27T10:26:25.486647  =

    2023-07-27T10:26:25.490277  / # /lava-1238965/bin/lava-test-runner /lav=
a-1238965/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c246da3795a97fbd8ace82

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c246da3795a97fbd8ace85
        failing since 145 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-07-27T10:28:22.070611  [   14.108331] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1238967_1.5.2.4.1>
    2023-07-27T10:28:22.175891  =

    2023-07-27T10:28:22.277128  / # #export SHELL=3D/bin/sh
    2023-07-27T10:28:22.277545  =

    2023-07-27T10:28:22.378507  / # export SHELL=3D/bin/sh. /lava-1238967/e=
nvironment
    2023-07-27T10:28:22.378925  =

    2023-07-27T10:28:22.479951  / # . /lava-1238967/environment/lava-123896=
7/bin/lava-test-runner /lava-1238967/1
    2023-07-27T10:28:22.480672  =

    2023-07-27T10:28:22.484655  / # /lava-1238967/bin/lava-test-runner /lav=
a-1238967/1
    2023-07-27T10:28:22.500049  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2455cafd0900d4d8ace3c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2455cafd0900d4d8ace41
        failing since 120 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-27T10:22:06.987857  + set +x

    2023-07-27T10:22:06.994079  <8>[   10.736868] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150525_1.4.2.3.1>

    2023-07-27T10:22:07.098818  / # #

    2023-07-27T10:22:07.199428  export SHELL=3D/bin/sh

    2023-07-27T10:22:07.199653  #

    2023-07-27T10:22:07.300193  / # export SHELL=3D/bin/sh. /lava-11150525/=
environment

    2023-07-27T10:22:07.300380  =


    2023-07-27T10:22:07.400861  / # . /lava-11150525/environment/lava-11150=
525/bin/lava-test-runner /lava-11150525/1

    2023-07-27T10:22:07.401190  =


    2023-07-27T10:22:07.406002  / # /lava-11150525/bin/lava-test-runner /la=
va-11150525/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c245597690933eb58ace83

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c245597690933eb58ace88
        failing since 120 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-27T10:22:02.680709  + set +x

    2023-07-27T10:22:02.687474  <8>[   10.618664] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150521_1.4.2.3.1>

    2023-07-27T10:22:02.789034  #

    2023-07-27T10:22:02.789322  =


    2023-07-27T10:22:02.889866  / # #export SHELL=3D/bin/sh

    2023-07-27T10:22:02.890074  =


    2023-07-27T10:22:02.990662  / # export SHELL=3D/bin/sh. /lava-11150521/=
environment

    2023-07-27T10:22:02.990830  =


    2023-07-27T10:22:03.091314  / # . /lava-11150521/environment/lava-11150=
521/bin/lava-test-runner /lava-11150521/1

    2023-07-27T10:22:03.091568  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24573c15c391f538ace34

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24573c15c391f538ace39
        failing since 120 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-27T10:22:20.649190  + set +x<8>[   11.641912] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11150570_1.4.2.3.1>

    2023-07-27T10:22:20.649768  =


    2023-07-27T10:22:20.757718  / # #

    2023-07-27T10:22:20.860138  export SHELL=3D/bin/sh

    2023-07-27T10:22:20.860934  #

    2023-07-27T10:22:20.962538  / # export SHELL=3D/bin/sh. /lava-11150570/=
environment

    2023-07-27T10:22:20.963349  =


    2023-07-27T10:22:21.065089  / # . /lava-11150570/environment/lava-11150=
570/bin/lava-test-runner /lava-11150570/1

    2023-07-27T10:22:21.066352  =


    2023-07-27T10:22:21.071993  / # /lava-11150570/bin/lava-test-runner /la=
va-11150570/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2486d4c4a292a888ace1e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2486d4c4a292a888ace23
        failing since 177 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-07-27T10:35:03.483692  + set +x
    2023-07-27T10:35:03.484058  [    9.425898] <LAVA_SIGNAL_ENDRUN 0_dmesg =
996375_1.5.2.3.1>
    2023-07-27T10:35:03.592937  / # #
    2023-07-27T10:35:03.694671  export SHELL=3D/bin/sh
    2023-07-27T10:35:03.695146  #
    2023-07-27T10:35:03.796376  / # export SHELL=3D/bin/sh. /lava-996375/en=
vironment
    2023-07-27T10:35:03.796870  =

    2023-07-27T10:35:03.898193  / # . /lava-996375/environment/lava-996375/=
bin/lava-test-runner /lava-996375/1
    2023-07-27T10:35:03.899062  =

    2023-07-27T10:35:03.901378  / # /lava-996375/bin/lava-test-runner /lava=
-996375/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c245683972ee511a8ace54

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c245683972ee511a8ace59
        failing since 120 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-27T10:22:33.533105  + set<8>[   11.620404] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11150541_1.4.2.3.1>

    2023-07-27T10:22:33.533690   +x

    2023-07-27T10:22:33.641344  / # #

    2023-07-27T10:22:33.743441  export SHELL=3D/bin/sh

    2023-07-27T10:22:33.744142  #

    2023-07-27T10:22:33.845494  / # export SHELL=3D/bin/sh. /lava-11150541/=
environment

    2023-07-27T10:22:33.846197  =


    2023-07-27T10:22:33.947826  / # . /lava-11150541/environment/lava-11150=
541/bin/lava-test-runner /lava-11150541/1

    2023-07-27T10:22:33.948953  =


    2023-07-27T10:22:33.953735  / # /lava-11150541/bin/lava-test-runner /la=
va-11150541/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c26693f2b6d73b668ace49

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c26693f2b6d73b668ace4e
        failing since 7 days (last pass: v5.15.120-274-g478387c57e172, firs=
t fail: v5.15.120)

    2023-07-27T12:45:18.746894  / # #

    2023-07-27T12:45:18.849006  export SHELL=3D/bin/sh

    2023-07-27T12:45:18.849710  #

    2023-07-27T12:45:18.951164  / # export SHELL=3D/bin/sh. /lava-11150582/=
environment

    2023-07-27T12:45:18.951870  =


    2023-07-27T12:45:19.053317  / # . /lava-11150582/environment/lava-11150=
582/bin/lava-test-runner /lava-11150582/1

    2023-07-27T12:45:19.054406  =


    2023-07-27T12:45:19.071049  / # /lava-11150582/bin/lava-test-runner /la=
va-11150582/1

    2023-07-27T12:45:19.120017  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T12:45:19.120525  + cd /lav<8>[   15.994993] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11150582_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2462f346e1e69238ace47

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2462f346e1e69238ace4c
        failing since 7 days (last pass: v5.15.120-274-g478387c57e172, firs=
t fail: v5.15.120)

    2023-07-27T10:26:00.569112  / # #

    2023-07-27T10:26:01.649843  export SHELL=3D/bin/sh

    2023-07-27T10:26:01.651781  #

    2023-07-27T10:26:03.142958  / # export SHELL=3D/bin/sh. /lava-11150580/=
environment

    2023-07-27T10:26:03.144933  =


    2023-07-27T10:26:05.870905  / # . /lava-11150580/environment/lava-11150=
580/bin/lava-test-runner /lava-11150580/1

    2023-07-27T10:26:05.873324  =


    2023-07-27T10:26:05.878625  / # /lava-11150580/bin/lava-test-runner /la=
va-11150580/1

    2023-07-27T10:26:05.944187  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T10:26:05.944701  + cd /lava-111505<8>[   25.560197] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11150580_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24623319174b8898ace29

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
23/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24623319174b8898ace2e
        failing since 7 days (last pass: v5.15.120-274-g478387c57e172, firs=
t fail: v5.15.120)

    2023-07-27T10:27:06.680847  / # #

    2023-07-27T10:27:06.783357  export SHELL=3D/bin/sh

    2023-07-27T10:27:06.784140  #

    2023-07-27T10:27:06.885638  / # export SHELL=3D/bin/sh. /lava-11150585/=
environment

    2023-07-27T10:27:06.886347  =


    2023-07-27T10:27:06.987882  / # . /lava-11150585/environment/lava-11150=
585/bin/lava-test-runner /lava-11150585/1

    2023-07-27T10:27:06.989157  =


    2023-07-27T10:27:07.005119  / # /lava-11150585/bin/lava-test-runner /la=
va-11150585/1

    2023-07-27T10:27:07.063031  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T10:27:07.063541  + cd /lava-1115058<8>[   16.870848] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11150585_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
