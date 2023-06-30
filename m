Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F22743B15
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjF3Lr4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 30 Jun 2023 07:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjF3Lrz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Jun 2023 07:47:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D252EE
        for <stable@vger.kernel.org>; Fri, 30 Jun 2023 04:47:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b82bf265b2so9091295ad.0
        for <stable@vger.kernel.org>; Fri, 30 Jun 2023 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688125672; x=1690717672;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mhv0nyYaCXk6FSQRw3GI13D6CzQ8spprAxvRVQb0xmU=;
        b=rcKLuSUkJ0Es9rRvWnlyyNY0PJdg9diMy/rWw+FFlNx8wkwIEQSwBTWZNOMQX/1Zhb
         zXmrtlX5XNbfZhZujKnQHMyoUGd3HUuCb81VbrY3FYAjhsZmQezQQ5wk/O1a79AcRW9z
         kLmPvFyBQHQ/eF2BjbY7Pc7eWWRkpROcesvub4IcV43tlYLcEdIXIPGmZH9TbYExxQkD
         fh5lMJgrCvGFe/HdMe5UhhcQs0B6lQ0VS0/wJSWIKmjRqvxxQCiM8hyMgWUT4bUn0+Pa
         1/4226D8OGmakO6HIhL+xTpLhQjv7SkcbgxbGrvbGWW0nrILaTbgpuXNpGXRNLgnOfe6
         rd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125672; x=1690717672;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhv0nyYaCXk6FSQRw3GI13D6CzQ8spprAxvRVQb0xmU=;
        b=Uxpr/M82JmxuRUELJc2qhvNytmUPJxRinzkH0p/kpjJrsVaKfJAWI06HlJrqAEpK7D
         GS7dutmqwQwABJk7iPm19UTZ30+BGlJTEDY9CeVvUIQrwKFzniZZ9Ydevd+owWoWuwol
         YugBxKjxu2h51n6tBWsdrRC2GTrP759YCobptGganY6XCyqxaQpatwt4PKtd9OWdu7Qe
         7qSV7b2+81EVPxxICzgVyyrQcFAsfewWtvxSz+zPITS0mG4RathYHrCA+F2farWcPobY
         tqgo9YpaT8a5FpQDTZaCxp0lveR7oZ5fmVfjkpCRsVUgydAYC1BfGdPkjJtWaZKyWU5p
         EApg==
X-Gm-Message-State: ABy/qLYSoS12kUKp/hQNVifW76ZSyc1Tsb36FlbGvxEXDOfd7FIXAU/J
        REtAbHjImIPIongX8x+BDCqpKNZ+C77RRO2HFKdSVA==
X-Google-Smtp-Source: APBJJlHzT/GQB1bvE++FGmw2VlOD72wFBagW4SassV4mtHy+KLUyBS1fX6DE7AiVk4EIRpFw4EXkSQ==
X-Received: by 2002:a17:903:110e:b0:1b3:d4ed:8306 with SMTP id n14-20020a170903110e00b001b3d4ed8306mr1578478plh.19.1688125672275;
        Fri, 30 Jun 2023 04:47:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001a69dfd918dsm5370835plb.187.2023.06.30.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:47:51 -0700 (PDT)
Message-ID: <649ec0e7.170a0220.6b03a.b05b@mx.google.com>
Date:   Fri, 30 Jun 2023 04:47:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.36-32-ge42668f726b22
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 110 runs,
 10 regressions (v6.1.36-32-ge42668f726b22)
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

stable-rc/linux-6.1.y baseline: 110 runs, 10 regressions (v6.1.36-32-ge4266=
8f726b22)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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

odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.36-32-ge42668f726b22/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.36-32-ge42668f726b22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e42668f726b22827354594d6d2cdd5530ddc9760 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e87ef6e7e0a2c41bb2ab4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649e87ef6e7e0a2c41bb2=
ab5
        new failure (last pass: v6.1.36-31-g9e5d6a988556) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e87de6e7e0a2c41bb2a8d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e87de6e7e0a2c41bb2a92
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T07:44:08.632086  + set +x

    2023-06-30T07:44:08.638730  <8>[   10.509763] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10963725_1.4.2.3.1>

    2023-06-30T07:44:08.748159  / # #

    2023-06-30T07:44:08.850804  export SHELL=3D/bin/sh

    2023-06-30T07:44:08.851539  #

    2023-06-30T07:44:08.953154  / # export SHELL=3D/bin/sh. /lava-10963725/=
environment

    2023-06-30T07:44:08.953896  =


    2023-06-30T07:44:09.055420  / # . /lava-10963725/environment/lava-10963=
725/bin/lava-test-runner /lava-10963725/1

    2023-06-30T07:44:09.056624  =


    2023-06-30T07:44:09.062520  / # /lava-10963725/bin/lava-test-runner /la=
va-10963725/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e87c9f1468b29acbb2ab3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e87c9f1468b29acbb2ab8
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T07:44:04.732794  + <8>[   11.318332] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10963668_1.4.2.3.1>

    2023-06-30T07:44:04.732870  set +x

    2023-06-30T07:44:04.837286  / # #

    2023-06-30T07:44:04.937784  export SHELL=3D/bin/sh

    2023-06-30T07:44:04.937935  #

    2023-06-30T07:44:05.038383  / # export SHELL=3D/bin/sh. /lava-10963668/=
environment

    2023-06-30T07:44:05.038525  =


    2023-06-30T07:44:05.138984  / # . /lava-10963668/environment/lava-10963=
668/bin/lava-test-runner /lava-10963668/1

    2023-06-30T07:44:05.139252  =


    2023-06-30T07:44:05.143978  / # /lava-10963668/bin/lava-test-runner /la=
va-10963668/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e87bffcec5b409ebb2ac6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e87bffcec5b409ebb2acb
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T07:43:58.248950  <8>[   11.138354] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10963645_1.4.2.3.1>

    2023-06-30T07:43:58.252083  + set +x

    2023-06-30T07:43:58.353593  #

    2023-06-30T07:43:58.353895  =


    2023-06-30T07:43:58.454460  / # #export SHELL=3D/bin/sh

    2023-06-30T07:43:58.454627  =


    2023-06-30T07:43:58.555106  / # export SHELL=3D/bin/sh. /lava-10963645/=
environment

    2023-06-30T07:43:58.555274  =


    2023-06-30T07:43:58.655806  / # . /lava-10963645/environment/lava-10963=
645/bin/lava-test-runner /lava-10963645/1

    2023-06-30T07:43:58.656102  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649e8710a54798919dbb2aa6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649e8710a54798919dbb2=
aa7
        failing since 22 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e87c3f1468b29acbb2a80

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e87c3f1468b29acbb2a85
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T07:44:03.499329  + set +x

    2023-06-30T07:44:03.505937  <8>[   11.088366] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10963706_1.4.2.3.1>

    2023-06-30T07:44:03.609990  / # #

    2023-06-30T07:44:03.710584  export SHELL=3D/bin/sh

    2023-06-30T07:44:03.710789  #

    2023-06-30T07:44:03.811295  / # export SHELL=3D/bin/sh. /lava-10963706/=
environment

    2023-06-30T07:44:03.811490  =


    2023-06-30T07:44:03.912025  / # . /lava-10963706/environment/lava-10963=
706/bin/lava-test-runner /lava-10963706/1

    2023-06-30T07:44:03.912325  =


    2023-06-30T07:44:03.917181  / # /lava-10963706/bin/lava-test-runner /la=
va-10963706/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e87caf1468b29acbb2abe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e87caf1468b29acbb2ac3
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T07:43:49.980680  + set +x

    2023-06-30T07:43:49.987023  <8>[   10.624555] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10963722_1.4.2.3.1>

    2023-06-30T07:43:50.088817  =


    2023-06-30T07:43:50.189549  / # #export SHELL=3D/bin/sh

    2023-06-30T07:43:50.189724  =


    2023-06-30T07:43:50.290339  / # export SHELL=3D/bin/sh. /lava-10963722/=
environment

    2023-06-30T07:43:50.290597  =


    2023-06-30T07:43:50.391170  / # . /lava-10963722/environment/lava-10963=
722/bin/lava-test-runner /lava-10963722/1

    2023-06-30T07:43:50.391422  =


    2023-06-30T07:43:50.396772  / # /lava-10963722/bin/lava-test-runner /la=
va-10963722/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e87c8f1468b29acbb2a8f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e87c8f1468b29acbb2a94
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T07:43:59.860194  + set<8>[   10.624125] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10963710_1.4.2.3.1>

    2023-06-30T07:43:59.860437   +x

    2023-06-30T07:43:59.965248  / # #

    2023-06-30T07:44:00.066168  export SHELL=3D/bin/sh

    2023-06-30T07:44:00.066718  #

    2023-06-30T07:44:00.167762  / # export SHELL=3D/bin/sh. /lava-10963710/=
environment

    2023-06-30T07:44:00.168382  =


    2023-06-30T07:44:00.269481  / # . /lava-10963710/environment/lava-10963=
710/bin/lava-test-runner /lava-10963710/1

    2023-06-30T07:44:00.269836  =


    2023-06-30T07:44:00.274605  / # /lava-10963710/bin/lava-test-runner /la=
va-10963710/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e87caf1468b29acbb2ac9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e87caf1468b29acbb2ace
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T07:43:53.301065  <8>[   13.592936] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10963711_1.4.2.3.1>

    2023-06-30T07:43:53.408304  / # #

    2023-06-30T07:43:53.510636  export SHELL=3D/bin/sh

    2023-06-30T07:43:53.511369  #

    2023-06-30T07:43:53.612681  / # export SHELL=3D/bin/sh. /lava-10963711/=
environment

    2023-06-30T07:43:53.613435  =


    2023-06-30T07:43:53.714663  / # . /lava-10963711/environment/lava-10963=
711/bin/lava-test-runner /lava-10963711/1

    2023-06-30T07:43:53.714909  =


    2023-06-30T07:43:53.719981  / # /lava-10963711/bin/lava-test-runner /la=
va-10963711/1

    2023-06-30T07:43:53.728130  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649e89bcb6cff3d000bb2aab

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odro=
id-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
32-ge42668f726b22/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odro=
id-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649e89bcb6cff3d000bb2=
aac
        new failure (last pass: v6.1.36-31-g9e5d6a988556) =

 =20
