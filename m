Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFCE6FEADF
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 06:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjEKEnG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 00:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjEKEnF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 00:43:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59592D5E
        for <stable@vger.kernel.org>; Wed, 10 May 2023 21:43:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaff9c93a5so56405275ad.2
        for <stable@vger.kernel.org>; Wed, 10 May 2023 21:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683780179; x=1686372179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+jYigzsTAWt1FvSPH/h2pOwM1jQcPCwOH9X+s28xTZc=;
        b=RFajI3uatbPYpHLqaK4GPBubV/mdIeosJek9xiuDygiX6ooS/ODxDbbJLu8yTmT2V5
         3QK3d+NesX7KWfFvSaBqTJHIqASh7xHx7x0gYeownzopE/dyk2uKVqXU/sf424SAoGdk
         1n82ALxbTX0Y45hV7Y1ZsQyB6jJnMCOLti67UaXifygq4M0aiMfXikXGSeOvlojGRasj
         ow42n74TTeUQUmScKTXE7806E1HRv1373KpRebSmT7Sfvjtoo6uQmqIJ77IBylFOJsRw
         o3kILfFs2HvJ0kpIX99k4FffHRdYB/wuTqo2XXu2P+JebUfn/f1Q9jDLMW9Hb9Zhldvd
         6P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683780179; x=1686372179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jYigzsTAWt1FvSPH/h2pOwM1jQcPCwOH9X+s28xTZc=;
        b=Ifo0emurv3G2TknZHglxdRpHiiVp+vMEuVKWD/H89iwAWH14QzahlQVSFFlJtjddss
         BeGYC6u+Y22vn7NWsJGeZskLI4T/5Dk+lLmU1gpAXLdFNNfczDvL0Gy7YDL/DI/ovgcK
         gGLzUIdSC/rbhzN+n39/RrxigdSGKG48y3QudBb7pxz9IaSURlbA0eV6VsONaEP09CW5
         AoignqQxjcPo3zI1Gfg4WPEgjxhNV1JD44QReDfNzvb9vlrT6qqHWEdBfILLM1Cg5dDJ
         n3LcyWWOYgANQBTCXNdqwU/aTo5SpM4qVtsRUrIQvjWv0vVQX3tPFZHYefimIMHlUzDx
         53aQ==
X-Gm-Message-State: AC+VfDxv2Vdn6oMGcaoCtZbpPaKndZGQpeD8QLbdlgIBSEX+lC9JNPTN
        U/wi0C0rNvPjjDz2igfZuLUr6pSVd7OJaGWSIUijQA==
X-Google-Smtp-Source: ACHHUZ5iDpf0Xu+F2qFINmzmc43FUwfxAp1Jc9AEEAm+7RZScqROZGi0ohRBnHLNYbD1dPAayzx39Q==
X-Received: by 2002:a17:902:c085:b0:1ab:d16:3c8a with SMTP id j5-20020a170902c08500b001ab0d163c8amr17816623pld.6.1683780178903;
        Wed, 10 May 2023 21:42:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902728d00b001a217a7a11csm1667826pll.131.2023.05.10.21.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 21:42:58 -0700 (PDT)
Message-ID: <645c7252.170a0220.728d9.3ce6@mx.google.com>
Date:   Wed, 10 May 2023 21:42:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.110
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 177 runs, 12 regressions (v5.15.110)
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

stable-rc/linux-5.15.y baseline: 177 runs, 12 regressions (v5.15.110)

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

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

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

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.110/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.110
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8a7f2a5c5aa1648edb4f2029c6ec33870afb7a95 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3c3696fda32e6b2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3c3696fda32e6b2e85ec
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T00:51:45.501709  + set +x

    2023-05-11T00:51:45.508440  <8>[   10.856994] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273420_1.4.2.3.1>

    2023-05-11T00:51:45.612691  / # #

    2023-05-11T00:51:45.713256  export SHELL=3D/bin/sh

    2023-05-11T00:51:45.713488  #

    2023-05-11T00:51:45.813985  / # export SHELL=3D/bin/sh. /lava-10273420/=
environment

    2023-05-11T00:51:45.814162  =


    2023-05-11T00:51:45.914630  / # . /lava-10273420/environment/lava-10273=
420/bin/lava-test-runner /lava-10273420/1

    2023-05-11T00:51:45.914886  =


    2023-05-11T00:51:45.920818  / # /lava-10273420/bin/lava-test-runner /la=
va-10273420/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3c35122c11c0422e863a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3c35122c11c0422e863f
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T00:51:49.332219  + set +x<8>[   11.141707] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10273424_1.4.2.3.1>

    2023-05-11T00:51:49.332654  =


    2023-05-11T00:51:49.439471  / # #

    2023-05-11T00:51:49.540081  export SHELL=3D/bin/sh

    2023-05-11T00:51:49.540270  #

    2023-05-11T00:51:49.640788  / # export SHELL=3D/bin/sh. /lava-10273424/=
environment

    2023-05-11T00:51:49.640967  =


    2023-05-11T00:51:49.741491  / # . /lava-10273424/environment/lava-10273=
424/bin/lava-test-runner /lava-10273424/1

    2023-05-11T00:51:49.741750  =


    2023-05-11T00:51:49.745995  / # /lava-10273424/bin/lava-test-runner /la=
va-10273424/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3c4496fda32e6b2e862d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3c4496fda32e6b2e8632
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T00:51:55.255607  <8>[   10.380259] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273398_1.4.2.3.1>

    2023-05-11T00:51:55.259377  + set +x

    2023-05-11T00:51:55.360565  #

    2023-05-11T00:51:55.360870  =


    2023-05-11T00:51:55.461410  / # #export SHELL=3D/bin/sh

    2023-05-11T00:51:55.461569  =


    2023-05-11T00:51:55.562083  / # export SHELL=3D/bin/sh. /lava-10273398/=
environment

    2023-05-11T00:51:55.562260  =


    2023-05-11T00:51:55.662773  / # . /lava-10273398/environment/lava-10273=
398/bin/lava-test-runner /lava-10273398/1

    2023-05-11T00:51:55.663011  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645c40a9b0ff8f68e32e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645c40a9b0ff8f68e32e8=
5f0
        failing since 363 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645c409a740c62cf5f2e8763

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c409a740c62cf5f2e8766
        failing since 68 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-05-11T01:09:46.553647  [   11.052667] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1218206_1.5.2.4.1>
    2023-05-11T01:09:46.659418  / # #
    2023-05-11T01:09:46.761356  export SHELL=3D/bin/sh
    2023-05-11T01:09:46.762017  #
    2023-05-11T01:09:46.863564  / # export SHELL=3D/bin/sh. /lava-1218206/e=
nvironment
    2023-05-11T01:09:46.864057  =

    2023-05-11T01:09:46.965508  / # . /lava-1218206/environment/lava-121820=
6/bin/lava-test-runner /lava-1218206/1
    2023-05-11T01:09:46.966278  =

    2023-05-11T01:09:46.967993  / # /lava-1218206/bin/lava-test-runner /lav=
a-1218206/1
    2023-05-11T01:09:46.985778  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3cb95d7ccaa0372e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3cb95d7ccaa0372e85ef
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T00:54:06.611868  + <8>[   11.888477] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10273384_1.4.2.3.1>

    2023-05-11T00:54:06.611950  set +x

    2023-05-11T00:54:06.713063  #

    2023-05-11T00:54:06.713309  =


    2023-05-11T00:54:06.813916  / # #export SHELL=3D/bin/sh

    2023-05-11T00:54:06.814080  =


    2023-05-11T00:54:06.914716  / # export SHELL=3D/bin/sh. /lava-10273384/=
environment

    2023-05-11T00:54:06.915638  =


    2023-05-11T00:54:07.017210  / # . /lava-10273384/environment/lava-10273=
384/bin/lava-test-runner /lava-10273384/1

    2023-05-11T00:54:07.018516  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3c22b59b7ae6ad2e860f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3c22b59b7ae6ad2e8614
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T00:51:30.703088  + set +x

    2023-05-11T00:51:30.709556  <8>[   10.735616] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273373_1.4.2.3.1>

    2023-05-11T00:51:30.811349  =


    2023-05-11T00:51:30.911934  / # #export SHELL=3D/bin/sh

    2023-05-11T00:51:30.912119  =


    2023-05-11T00:51:31.012639  / # export SHELL=3D/bin/sh. /lava-10273373/=
environment

    2023-05-11T00:51:31.012821  =


    2023-05-11T00:51:31.113354  / # . /lava-10273373/environment/lava-10273=
373/bin/lava-test-runner /lava-10273373/1

    2023-05-11T00:51:31.113629  =


    2023-05-11T00:51:31.119323  / # /lava-10273373/bin/lava-test-runner /la=
va-10273373/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3c2edd486cb70a2e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3c2edd486cb70a2e860b
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T00:51:52.333060  + <8>[    8.577428] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10273395_1.4.2.3.1>

    2023-05-11T00:51:52.333499  set +x

    2023-05-11T00:51:52.440858  / # #

    2023-05-11T00:51:52.542886  export SHELL=3D/bin/sh

    2023-05-11T00:51:52.543566  #

    2023-05-11T00:51:52.644877  / # export SHELL=3D/bin/sh. /lava-10273395/=
environment

    2023-05-11T00:51:52.645548  =


    2023-05-11T00:51:52.746937  / # . /lava-10273395/environment/lava-10273=
395/bin/lava-test-runner /lava-10273395/1

    2023-05-11T00:51:52.747752  =


    2023-05-11T00:51:52.752683  / # /lava-10273395/bin/lava-test-runner /la=
va-10273395/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3cde5d47cbaabf2e85ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3cde5d47cbaabf2e8604
        failing since 100 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-05-11T00:54:45.732407  + set +x
    2023-05-11T00:54:45.732614  [    9.379029] <LAVA_SIGNAL_ENDRUN 0_dmesg =
946768_1.5.2.3.1>
    2023-05-11T00:54:45.840215  / # #
    2023-05-11T00:54:45.942079  export SHELL=3D/bin/sh
    2023-05-11T00:54:45.942641  #
    2023-05-11T00:54:46.044277  / # export SHELL=3D/bin/sh. /lava-946768/en=
vironment
    2023-05-11T00:54:46.044850  =

    2023-05-11T00:54:46.146261  / # . /lava-946768/environment/lava-946768/=
bin/lava-test-runner /lava-946768/1
    2023-05-11T00:54:46.147024  =

    2023-05-11T00:54:46.149240  / # /lava-946768/bin/lava-test-runner /lava=
-946768/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3c31dd486cb70a2e8614

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3c31dd486cb70a2e8619
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T00:51:40.976893  <8>[    9.565748] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273366_1.4.2.3.1>

    2023-05-11T00:51:41.081544  / # #

    2023-05-11T00:51:41.182512  export SHELL=3D/bin/sh

    2023-05-11T00:51:41.182772  #

    2023-05-11T00:51:41.283397  / # export SHELL=3D/bin/sh. /lava-10273366/=
environment

    2023-05-11T00:51:41.283626  =


    2023-05-11T00:51:41.384148  / # . /lava-10273366/environment/lava-10273=
366/bin/lava-test-runner /lava-10273366/1

    2023-05-11T00:51:41.384479  =


    2023-05-11T00:51:41.389183  / # /lava-10273366/bin/lava-test-runner /la=
va-10273366/1

    2023-05-11T00:51:41.394311  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645c41b97d76876e9a2e85ee

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c41b97d76876e9a2e861b
        failing since 113 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-05-11T01:15:02.594842  + set +x
    2023-05-11T01:15:02.598881  <8>[   16.005528] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3573400_1.5.2.4.1>
    2023-05-11T01:15:02.719597  / # #
    2023-05-11T01:15:02.825285  export SHELL=3D/bin/sh
    2023-05-11T01:15:02.826799  #
    2023-05-11T01:15:02.930238  / # export SHELL=3D/bin/sh. /lava-3573400/e=
nvironment
    2023-05-11T01:15:02.931820  =

    2023-05-11T01:15:03.035130  / # . /lava-3573400/environment/lava-357340=
0/bin/lava-test-runner /lava-3573400/1
    2023-05-11T01:15:03.037788  =

    2023-05-11T01:15:03.041120  / # /lava-3573400/bin/lava-test-runner /lav=
a-3573400/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3c536d26e5d3a02e8635

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-=
r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
10/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-=
r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3c536d26e5d3a02e863a
        failing since 28 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-05-11T00:51:25.954051  <8>[    5.769199] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3573144_1.5.2.4.1>
    2023-05-11T00:51:26.075078  / # #
    2023-05-11T00:51:26.181561  export SHELL=3D/bin/sh
    2023-05-11T00:51:26.183934  #
    2023-05-11T00:51:26.287934  / # export SHELL=3D/bin/sh. /lava-3573144/e=
nvironment
    2023-05-11T00:51:26.290189  =

    2023-05-11T00:51:26.393906  / # . /lava-3573144/environment/lava-357314=
4/bin/lava-test-runner /lava-3573144/1
    2023-05-11T00:51:26.397088  =

    2023-05-11T00:51:26.414280  / # /lava-3573144/bin/lava-test-runner /lav=
a-3573144/1
    2023-05-11T00:51:26.559540  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
