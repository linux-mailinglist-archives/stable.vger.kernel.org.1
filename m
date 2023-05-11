Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1666FEA92
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 06:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjEKEVt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 00:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjEKEVs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 00:21:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6372120
        for <stable@vger.kernel.org>; Wed, 10 May 2023 21:21:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643557840e4so8750482b3a.2
        for <stable@vger.kernel.org>; Wed, 10 May 2023 21:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683778902; x=1686370902;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NdwXkZKcaFgk6k1K4xeU06miatIFdTRb49EwGV5GIM4=;
        b=VL5CGsfMzJmMccOm44d7NY+kYXFZe8bLi8WDbN8lMBnQEHOnQIWvVzsaQT3XPkWwFu
         WlBIptsE4eJ84NxgNVSfSxO3VR02Av1TfWt4RisaAmA/HnpGoiObmitsdh4RqsRbg+J8
         sqj/Eg20pPFSCJdkS5S8px1ONglRClRk+GlIUyDR70rvv615DUtupWllk5dFDKx0WKcU
         zLUOFaLi58t2VDnsrbzF2dxbAH0ziF4n4jIwWCKd2k2s57YIcQqrAd8q40ftn6E1EHKh
         RvqIfkX2KbY3p0chZYuo7g+qlwVsb/YFFBOYSecsj+7spUqi4q/231jqXxcJMeUa2V8w
         25Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683778902; x=1686370902;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdwXkZKcaFgk6k1K4xeU06miatIFdTRb49EwGV5GIM4=;
        b=eVwnfZeayGfm3ukfBx5kZXI34y4E0L7qadEs0j+S6znii2k09ZJ+vZm2X4cH8UpDIV
         cxUs0L8xSkTI7GeeZa71JB7I0DMIPbXMFmcZM3YrIr8IK+2yFSxbHERwOkpBBzYdO9XS
         IFgzdxkNeMWzVSWk1dk7K4aENHwDz+uUC+ZtMTQmVhkRsg63Hu3LOJ2901Co40VKz8iS
         aE7hm/ILttNO3yfGQfc9P3nLX7QMzGuS9IKebEDnnd9uPX/9oo6PIsqU2dyBOhqgvhYE
         VYBhBx3sBvywLDalGGg7hovsbid1//x0wtlkeNmqkhDfGUnJj8vamdp7Ogm+1NkP82cc
         m+wQ==
X-Gm-Message-State: AC+VfDykRL+5iIj335Ybn+xqFBqh4EYOuxTHl4hJYidjR3tPJekaq6P4
        hoPZAhlvgsxQ+e1Rrw/x3DU2R5OpQhbzm0cbxuGQMw==
X-Google-Smtp-Source: ACHHUZ4zGJHri+A9Hqep0zJU2jQJxtreyBnDx8BzC9jeeLgYZ51Jmyi6oNHmERsLwaySDoSINhjiLQ==
X-Received: by 2002:a05:6a00:16ca:b0:643:4d69:efb8 with SMTP id l10-20020a056a0016ca00b006434d69efb8mr30900692pfc.6.1683778902382;
        Wed, 10 May 2023 21:21:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b005d22639b577sm4272497pff.165.2023.05.10.21.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 21:21:41 -0700 (PDT)
Message-ID: <645c6d55.a70a0220.41497.9beb@mx.google.com>
Date:   Wed, 10 May 2023 21:21:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.110-371-g69627af95b9d
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 134 runs,
 9 regressions (v5.15.110-371-g69627af95b9d)
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

stable-rc/queue/5.15 baseline: 134 runs, 9 regressions (v5.15.110-371-g6962=
7af95b9d)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

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

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.110-371-g69627af95b9d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.110-371-g69627af95b9d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      69627af95b9da1876842839667c1a47373cf990d =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3894077ac1a5792e862e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3894077ac1a5792e8633
        failing since 43 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T00:36:26.160286  + set +x<8>[    8.966309] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10273034_1.4.2.3.1>

    2023-05-11T00:36:26.160413  =


    2023-05-11T00:36:26.264924  / # #

    2023-05-11T00:36:26.365647  export SHELL=3D/bin/sh

    2023-05-11T00:36:26.365792  #

    2023-05-11T00:36:26.466252  / # export SHELL=3D/bin/sh. /lava-10273034/=
environment

    2023-05-11T00:36:26.466469  =


    2023-05-11T00:36:26.567052  / # . /lava-10273034/environment/lava-10273=
034/bin/lava-test-runner /lava-10273034/1

    2023-05-11T00:36:26.567399  =


    2023-05-11T00:36:26.571823  / # /lava-10273034/bin/lava-test-runner /la=
va-10273034/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c363d51bacc49992e8621

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c363d51bacc49992e8626
        failing since 43 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T00:26:18.767353  <8>[    8.129668] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273081_1.4.2.3.1>

    2023-05-11T00:26:18.770585  + set +x

    2023-05-11T00:26:18.872185  #

    2023-05-11T00:26:18.973099  / # #export SHELL=3D/bin/sh

    2023-05-11T00:26:18.973331  =


    2023-05-11T00:26:19.073898  / # export SHELL=3D/bin/sh. /lava-10273081/=
environment

    2023-05-11T00:26:19.074131  =


    2023-05-11T00:26:19.174694  / # . /lava-10273081/environment/lava-10273=
081/bin/lava-test-runner /lava-10273081/1

    2023-05-11T00:26:19.175055  =


    2023-05-11T00:26:19.179572  / # /lava-10273081/bin/lava-test-runner /la=
va-10273081/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3e4c0f917537b72e85ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645c3e4c0f917537b72e8=
5eb
        failing since 96 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c388a9b27d446fb2e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c388a9b27d446fb2e85fa
        failing since 43 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T00:36:11.621706  + <8>[   10.223017] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10273046_1.4.2.3.1>

    2023-05-11T00:36:11.622173  set +x

    2023-05-11T00:36:11.727914  =


    2023-05-11T00:36:11.829719  / # #export SHELL=3D/bin/sh

    2023-05-11T00:36:11.830508  =


    2023-05-11T00:36:11.932054  / # export SHELL=3D/bin/sh. /lava-10273046/=
environment

    2023-05-11T00:36:11.932822  =


    2023-05-11T00:36:12.034341  / # . /lava-10273046/environment/lava-10273=
046/bin/lava-test-runner /lava-10273046/1

    2023-05-11T00:36:12.035627  =


    2023-05-11T00:36:12.040470  / # /lava-10273046/bin/lava-test-runner /la=
va-10273046/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3635bc4bfb3efe2e8619

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3635bc4bfb3efe2e861e
        failing since 43 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T00:26:05.448618  <8>[   11.048826] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273014_1.4.2.3.1>

    2023-05-11T00:26:05.452415  + set +x

    2023-05-11T00:26:05.553967  #

    2023-05-11T00:26:05.554318  =


    2023-05-11T00:26:05.654973  / # #export SHELL=3D/bin/sh

    2023-05-11T00:26:05.655203  =


    2023-05-11T00:26:05.755735  / # export SHELL=3D/bin/sh. /lava-10273014/=
environment

    2023-05-11T00:26:05.755962  =


    2023-05-11T00:26:05.856560  / # . /lava-10273014/environment/lava-10273=
014/bin/lava-test-runner /lava-10273014/1

    2023-05-11T00:26:05.856852  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3647943f0141832e8609

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3647943f0141832e860e
        failing since 43 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T00:26:22.654871  + set<8>[   10.616873] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10273071_1.4.2.3.1>

    2023-05-11T00:26:22.654957   +x

    2023-05-11T00:26:22.759730  / # #

    2023-05-11T00:26:22.860361  export SHELL=3D/bin/sh

    2023-05-11T00:26:22.860557  #

    2023-05-11T00:26:22.961071  / # export SHELL=3D/bin/sh. /lava-10273071/=
environment

    2023-05-11T00:26:22.961279  =


    2023-05-11T00:26:23.061806  / # . /lava-10273071/environment/lava-10273=
071/bin/lava-test-runner /lava-10273071/1

    2023-05-11T00:26:23.062149  =


    2023-05-11T00:26:23.066277  / # /lava-10273071/bin/lava-test-runner /la=
va-10273071/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3aae3c423766e32e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3aae3c423766e32e85fd
        failing since 103 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-11T00:45:10.205553  + set +x
    2023-05-11T00:45:10.205721  [    9.431319] <LAVA_SIGNAL_ENDRUN 0_dmesg =
946744_1.5.2.3.1>
    2023-05-11T00:45:10.313105  / # #
    2023-05-11T00:45:10.414876  export SHELL=3D/bin/sh
    2023-05-11T00:45:10.415353  #
    2023-05-11T00:45:10.516580  / # export SHELL=3D/bin/sh. /lava-946744/en=
vironment
    2023-05-11T00:45:10.517094  =

    2023-05-11T00:45:10.618423  / # . /lava-946744/environment/lava-946744/=
bin/lava-test-runner /lava-946744/1
    2023-05-11T00:45:10.619144  =

    2023-05-11T00:45:10.621350  / # /lava-946744/bin/lava-test-runner /lava=
-946744/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3826b324f4e0692e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3826b324f4e0692e85ec
        failing since 43 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T00:34:27.356690  + set<8>[   11.950634] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10273018_1.4.2.3.1>

    2023-05-11T00:34:27.357129   +x

    2023-05-11T00:34:27.464189  / # #

    2023-05-11T00:34:27.566229  export SHELL=3D/bin/sh

    2023-05-11T00:34:27.566936  #

    2023-05-11T00:34:27.668870  / # export SHELL=3D/bin/sh. /lava-10273018/=
environment

    2023-05-11T00:34:27.669632  =


    2023-05-11T00:34:27.771019  / # . /lava-10273018/environment/lava-10273=
018/bin/lava-test-runner /lava-10273018/1

    2023-05-11T00:34:27.771286  =


    2023-05-11T00:34:27.776101  / # /lava-10273018/bin/lava-test-runner /la=
va-10273018/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645c328d9f634df39e2e85f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g69627af95b9d/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c328d9f634df39e2e85f5
        failing since 99 days (last pass: v5.15.82-123-gd03dbdba21ef, first=
 fail: v5.15.90-203-gea2e94bef77e)

    2023-05-11T00:10:26.773750  #
    2023-05-11T00:10:26.880486  / # #export SHELL=3D/bin/sh
    2023-05-11T00:10:26.882069  =

    2023-05-11T00:10:26.985232  / # export SHELL=3D/bin/sh. /lava-3573011/e=
nvironment
    2023-05-11T00:10:26.986967  =

    2023-05-11T00:10:27.090567  / # . /lava-3573011/environment/lava-357301=
1/bin/lava-test-runner /lava-3573011/1
    2023-05-11T00:10:27.093449  =

    2023-05-11T00:10:27.098659  / # /lava-3573011/bin/lava-test-runner /lav=
a-3573011/1
    2023-05-11T00:10:27.195478  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-11T00:10:27.229281  + cd /lava-3573011/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
