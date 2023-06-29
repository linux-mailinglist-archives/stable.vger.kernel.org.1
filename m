Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9574310C
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 01:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjF2XYg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 19:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF2XYe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 19:24:34 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5083585
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 16:24:32 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b708b97418so1030791a34.3
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688081071; x=1690673071;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DZJiMrqQmphdlv/QgAKjNgpi3fbq9IHRWe1SnpF0vwg=;
        b=ENIWf6sNnHajp0hsNl16vAwYPzHW02lqcDecCQSxKsZ4K5J/Hfu+TnoGr/zjUkosuM
         ZTc0ViwiM7OBTHfIOTsPBydP8rAODP2tkCM+MUWyJqeq2JM9bgJOaUXTdPfkq7cI+uo+
         yFvQjqYKIAk4G9zMHHBbuzDM7NvMb1l90S1jdFU2ZunSoKGPcpTAwMk4qO4HdKa1e+Zm
         I8blZMxHy79fBVQxDitvceYkI3o0WGtjMsPtoHJ4GKwzWU1JQw5RhVBLpvzwSUZT16Os
         2+baiIA3bWeuaa9bHqu2a+qnooMnm/4OYj/0DGt+PCnPywGXC+XEVXCU0nd1yeKds+iy
         8dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688081071; x=1690673071;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZJiMrqQmphdlv/QgAKjNgpi3fbq9IHRWe1SnpF0vwg=;
        b=ZqvdvZpEPa13Opi20LDBO1YMeekPJm3C/xX5C9E6MIz1dM3dTKWNpmuWUZL0KB/8dJ
         3+sujt+DQDnGr3tPTlWA5Nt8bBMAsyUKhASQvCH491mQQr6FMCTNWLtaIdONFqXPBYHy
         yZVpJez45Ra3sey0xcM3ThaEfDlaC0O1ce6lxJ7DLEtJbGlQp8/JYzPAbQjfN5tFp8rd
         iWYYFTB8d4Lm+Bl9enqOdKnm+6wNbWR+rYv66R4+EG/yi83QxtDCVaffmYTyH4rQjLEA
         YMuykH0ENVE5wNJ6DEtYMg3d2OamQW8zWC4C+yEMUqxl1OZ0hgeXE7itP9uivC5Du5le
         Mvjg==
X-Gm-Message-State: ABy/qLYyvAC/6vkCT4c6UPSpin0oMHvH9cGgF9cDdnEtxDLIMFZ9ZRXh
        Xt0/xGhAhRX9T3iw9VIYW6a34pq337c3RwSK4C+JqQ==
X-Google-Smtp-Source: APBJJlHTqFNJKQGEWI3vmQKEd7vrvxerI9IzogqSMKZGNpkdbMNuwNsF0l6lu+14xOyi8fju1gFnhA==
X-Received: by 2002:a05:6358:cd20:b0:134:f28f:aa47 with SMTP id gv32-20020a056358cd2000b00134f28faa47mr919473rwb.23.1688081071070;
        Thu, 29 Jun 2023 16:24:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b0064fe06fe712sm8825654pfi.129.2023.06.29.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 16:24:30 -0700 (PDT)
Message-ID: <649e12ae.620a0220.fd1b0.164f@mx.google.com>
Date:   Thu, 29 Jun 2023 16:24:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.36-30-g90c9505b275bc
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 163 runs,
 10 regressions (v6.1.36-30-g90c9505b275bc)
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

stable-rc/linux-6.1.y baseline: 163 runs, 10 regressions (v6.1.36-30-g90c95=
05b275bc)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.36-30-g90c9505b275bc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.36-30-g90c9505b275bc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      90c9505b275bc6f26f59750240c94d787bfdbe00 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649ddbeacbcb718b5abb2a9c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649ddbeacbcb718b5abb2aa1
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T19:30:52.977410  <8>[   10.562256] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10954124_1.4.2.3.1>

    2023-06-29T19:30:52.980746  + set +x

    2023-06-29T19:30:53.085777  #

    2023-06-29T19:30:53.086892  =


    2023-06-29T19:30:53.188389  / # #export SHELL=3D/bin/sh

    2023-06-29T19:30:53.188936  =


    2023-06-29T19:30:53.289990  / # export SHELL=3D/bin/sh. /lava-10954124/=
environment

    2023-06-29T19:30:53.290211  =


    2023-06-29T19:30:53.390796  / # . /lava-10954124/environment/lava-10954=
124/bin/lava-test-runner /lava-10954124/1

    2023-06-29T19:30:53.391821  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649ddc8afbb17bfe1dbb2aad

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649ddc8afbb17bfe1dbb2ab2
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T19:33:24.350162  + <8>[   11.556480] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10954099_1.4.2.3.1>

    2023-06-29T19:33:24.350247  set +x

    2023-06-29T19:33:24.454499  / # #

    2023-06-29T19:33:24.555156  export SHELL=3D/bin/sh

    2023-06-29T19:33:24.555343  #

    2023-06-29T19:33:24.655871  / # export SHELL=3D/bin/sh. /lava-10954099/=
environment

    2023-06-29T19:33:24.656063  =


    2023-06-29T19:33:24.756607  / # . /lava-10954099/environment/lava-10954=
099/bin/lava-test-runner /lava-10954099/1

    2023-06-29T19:33:24.756921  =


    2023-06-29T19:33:24.761501  / # /lava-10954099/bin/lava-test-runner /la=
va-10954099/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649ddbdf292f3658e8bb2a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649ddbdf292f3658e8bb2a7a
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T19:30:17.875524  <8>[   10.067944] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10954085_1.4.2.3.1>

    2023-06-29T19:30:17.878753  + set +x

    2023-06-29T19:30:17.983724  #

    2023-06-29T19:30:17.985013  =


    2023-06-29T19:30:18.086847  / # #export SHELL=3D/bin/sh

    2023-06-29T19:30:18.087578  =


    2023-06-29T19:30:18.189089  / # export SHELL=3D/bin/sh. /lava-10954085/=
environment

    2023-06-29T19:30:18.189850  =


    2023-06-29T19:30:18.291390  / # . /lava-10954085/environment/lava-10954=
085/bin/lava-test-runner /lava-10954085/1

    2023-06-29T19:30:18.292667  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649e09e006ba32a1d2bb2a9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649e09e006ba32a1d2bb2=
aa0
        failing since 22 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649ddcacf94cd0afbfbb2ac8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649ddcacf94cd0afbfbb2acd
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T19:33:50.461813  + set +x

    2023-06-29T19:33:50.468981  <8>[   10.066988] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10954115_1.4.2.3.1>

    2023-06-29T19:33:50.573058  / # #

    2023-06-29T19:33:50.673749  export SHELL=3D/bin/sh

    2023-06-29T19:33:50.673957  #

    2023-06-29T19:33:50.774504  / # export SHELL=3D/bin/sh. /lava-10954115/=
environment

    2023-06-29T19:33:50.774728  =


    2023-06-29T19:33:50.875314  / # . /lava-10954115/environment/lava-10954=
115/bin/lava-test-runner /lava-10954115/1

    2023-06-29T19:33:50.875648  =


    2023-06-29T19:33:50.880503  / # /lava-10954115/bin/lava-test-runner /la=
va-10954115/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649ddc2f16a614cb53bb2ab9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649ddc3016a614cb53bb2abe
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T19:31:41.199654  <8>[   10.790877] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10954108_1.4.2.3.1>

    2023-06-29T19:31:41.203147  + set +x

    2023-06-29T19:31:41.310045  / # #

    2023-06-29T19:31:41.412344  export SHELL=3D/bin/sh

    2023-06-29T19:31:41.412593  #

    2023-06-29T19:31:41.513143  / # export SHELL=3D/bin/sh. /lava-10954108/=
environment

    2023-06-29T19:31:41.513385  =


    2023-06-29T19:31:41.614093  / # . /lava-10954108/environment/lava-10954=
108/bin/lava-test-runner /lava-10954108/1

    2023-06-29T19:31:41.615158  =


    2023-06-29T19:31:41.620967  / # /lava-10954108/bin/lava-test-runner /la=
va-10954108/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649ddbe0cbcb718b5abb2a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649ddbe0cbcb718b5abb2a7a
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T19:30:27.168420  + <8>[   11.365816] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10954110_1.4.2.3.1>

    2023-06-29T19:30:27.168518  set +x

    2023-06-29T19:30:27.273094  / # #

    2023-06-29T19:30:27.373759  export SHELL=3D/bin/sh

    2023-06-29T19:30:27.373959  #

    2023-06-29T19:30:27.474498  / # export SHELL=3D/bin/sh. /lava-10954110/=
environment

    2023-06-29T19:30:27.474691  =


    2023-06-29T19:30:27.575184  / # . /lava-10954110/environment/lava-10954=
110/bin/lava-test-runner /lava-10954110/1

    2023-06-29T19:30:27.575467  =


    2023-06-29T19:30:27.580438  / # /lava-10954110/bin/lava-test-runner /la=
va-10954110/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649ddbf1a1c097d5bfbb2af6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649ddbf1a1c097d5bfbb2afb
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T19:30:35.641051  <8>[   11.969058] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10954114_1.4.2.3.1>

    2023-06-29T19:30:35.745185  / # #

    2023-06-29T19:30:35.845843  export SHELL=3D/bin/sh

    2023-06-29T19:30:35.846100  #

    2023-06-29T19:30:35.946806  / # export SHELL=3D/bin/sh. /lava-10954114/=
environment

    2023-06-29T19:30:35.947617  =


    2023-06-29T19:30:36.049246  / # . /lava-10954114/environment/lava-10954=
114/bin/lava-test-runner /lava-10954114/1

    2023-06-29T19:30:36.050406  =


    2023-06-29T19:30:36.055470  / # /lava-10954114/bin/lava-test-runner /la=
va-10954114/1

    2023-06-29T19:30:36.062184  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/649de1f9ba7f4d63fbbb2a83

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
30-g90c9505b275bc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/649de1f9ba7f4d63fbbb2a91
        failing since 49 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-29T19:56:26.748990  /lava-10954295/1/../bin/lava-test-case
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649de1f9ba7f4d63fbbb2b2b
        failing since 49 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-29T19:56:21.247653  + set +x

    2023-06-29T19:56:21.253949  <8>[   17.529158] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10954295_1.5.2.3.1>

    2023-06-29T19:56:21.359714  / # #

    2023-06-29T19:56:21.460313  export SHELL=3D/bin/sh

    2023-06-29T19:56:21.460462  #

    2023-06-29T19:56:21.560940  / # export SHELL=3D/bin/sh. /lava-10954295/=
environment

    2023-06-29T19:56:21.561090  =


    2023-06-29T19:56:21.661611  / # . /lava-10954295/environment/lava-10954=
295/bin/lava-test-runner /lava-10954295/1

    2023-06-29T19:56:21.661845  =


    2023-06-29T19:56:21.666976  / # /lava-10954295/bin/lava-test-runner /la=
va-10954295/1
 =

    ... (13 line(s) more)  =

 =20
