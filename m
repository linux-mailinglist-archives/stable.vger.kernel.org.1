Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE617466E2
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 03:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjGDBdZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 21:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGDBdY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 21:33:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E2AE4E
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:33:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b7f223994fso39651885ad.3
        for <stable@vger.kernel.org>; Mon, 03 Jul 2023 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688434402; x=1691026402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M1GYMb7uccYRwrtP/AA+9vVXpgfvJRDc8BUIFosqrAg=;
        b=XkcI4zeqj7EhlNyAAabRwL3RHlPzVeuJBQh1/nBCPE+V1ZjUA55/H7Gzi63Hb56s2v
         vKFc7HkruLz8Ii/wrJGg1GIm4TCC8C4SmxsuEWxXuwIUtQmYxAu10wBE+Kv44QRx4s1Y
         0sULMeQe1DeYTDtAzUj6VLY70VK5kscR/OQ2ivnP2UvgLHhj/BGgNBupQ9YQn8PweayY
         efZ+JQ1/jY9UmL+lnIjxmcOxh2M7e+PhPZ5/l7L5NDWse8I/VbpT8/QPMRd0IB1ImK82
         WU1f+kOyB2Ka7pWmRLK6ufucRmzJO6DCQpP88YuLU9k/z7Qa9VbFQCuVCnO93yj9YNHp
         TXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688434402; x=1691026402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1GYMb7uccYRwrtP/AA+9vVXpgfvJRDc8BUIFosqrAg=;
        b=JIcIwuaCUiyMWsgDf+1AoDgPw8ziDDYPRgCVul7L/YY5REyTBYXH1ynAsh9dKpZNaN
         p2VG1Kw/zAUGre0Zv9dwrIVrRW0FD7AfIfIRy2gd7EUjEBhh2Yq1NVhIcPNhwoPmSkxX
         bty+kzZ1J/4rtc1VrfZNLwVsT5mo9IacU046R8T7ijiWXUMJ0lldWkTZ8ZUZr2pgguJ0
         cXW1BgNiFSdHUEBD7tCrZuRuAR3n60NufhQReKgxdy00Js7OGMEoyuOZQpXmwDjb14J0
         lxIynVg4ty6kEPlAzYArWx0G8AJnHBf8mxM4tdn3T4Xao64Wl6HzZRuoKbnb89dJK87C
         d3Iw==
X-Gm-Message-State: ABy/qLaMVawejZ32hC3SwrwQmdynmrBkn9JeqcekSlYOj65PGNR8pHpK
        S1gylm5wpNeddRFcue6XbKvgsl1kdDaMc3xHaAmIZw==
X-Google-Smtp-Source: APBJJlFFJLvHWAv70BeMQhu6raQZAx6Pn+jJKVUoO1fc3Lw72day9KYnTCwPF9YlBWFupUMiK84WLQ==
X-Received: by 2002:a17:902:eac2:b0:1ac:7345:f254 with SMTP id p2-20020a170902eac200b001ac7345f254mr12405633pld.33.1688434401728;
        Mon, 03 Jul 2023 18:33:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001b80e07989csm12930897plb.200.2023.07.03.18.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 18:33:21 -0700 (PDT)
Message-ID: <64a376e1.170a0220.91071.a94a@mx.google.com>
Date:   Mon, 03 Jul 2023 18:33:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.37-12-g86236a041c0f
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 113 runs,
 9 regressions (v6.1.37-12-g86236a041c0f)
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

stable-rc/linux-6.1.y baseline: 113 runs, 9 regressions (v6.1.37-12-g86236a=
041c0f)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.37-12-g86236a041c0f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.37-12-g86236a041c0f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      86236a041c0ffc821b7c1ee4891237bdc48ac881 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33e92effb327c60bb2ad6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a33e92effb327c60bb2=
ad7
        new failure (last pass: v6.1.37) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33f3befd3db8c30bb2a7a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33f3befd3db8c30bb2a7f
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-03T21:35:32.287170  + set +x

    2023-07-03T21:35:32.294223  <8>[    8.220784] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10998695_1.4.2.3.1>

    2023-07-03T21:35:32.398157  / # #

    2023-07-03T21:35:32.498686  export SHELL=3D/bin/sh

    2023-07-03T21:35:32.498842  #

    2023-07-03T21:35:32.599304  / # export SHELL=3D/bin/sh. /lava-10998695/=
environment

    2023-07-03T21:35:32.599480  =


    2023-07-03T21:35:32.699946  / # . /lava-10998695/environment/lava-10998=
695/bin/lava-test-runner /lava-10998695/1

    2023-07-03T21:35:32.700200  =


    2023-07-03T21:35:32.706051  / # /lava-10998695/bin/lava-test-runner /la=
va-10998695/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33e69ad5bd99f55bb2ac4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33e69ad5bd99f55bb2ac9
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-03T21:32:04.940428  + <8>[   11.937676] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10998726_1.4.2.3.1>

    2023-07-03T21:32:04.940854  set +x

    2023-07-03T21:32:05.048665  / # #

    2023-07-03T21:32:05.150595  export SHELL=3D/bin/sh

    2023-07-03T21:32:05.150986  #

    2023-07-03T21:32:05.251780  / # export SHELL=3D/bin/sh. /lava-10998726/=
environment

    2023-07-03T21:32:05.252000  =


    2023-07-03T21:32:05.352564  / # . /lava-10998726/environment/lava-10998=
726/bin/lava-test-runner /lava-10998726/1

    2023-07-03T21:32:05.352861  =


    2023-07-03T21:32:05.357266  / # /lava-10998726/bin/lava-test-runner /la=
va-10998726/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33e6b935efc647ebb2aae

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33e6b935efc647ebb2ab3
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-03T21:32:04.943366  <8>[   11.082945] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10998732_1.4.2.3.1>

    2023-07-03T21:32:04.946904  + set +x

    2023-07-03T21:32:05.052481  #

    2023-07-03T21:32:05.053529  =


    2023-07-03T21:32:05.155274  / # #export SHELL=3D/bin/sh

    2023-07-03T21:32:05.155811  =


    2023-07-03T21:32:05.256731  / # export SHELL=3D/bin/sh. /lava-10998732/=
environment

    2023-07-03T21:32:05.256937  =


    2023-07-03T21:32:05.357478  / # . /lava-10998732/environment/lava-10998=
732/bin/lava-test-runner /lava-10998732/1

    2023-07-03T21:32:05.357841  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33f4cae101a96eabb2a84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a33f4cae101a96eabb2=
a85
        failing since 25 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33ea6d6737d82fcbb2a9e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33ea6d6737d82fcbb2aa3
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-03T21:33:10.631297  + set +x

    2023-07-03T21:33:10.637863  <8>[   10.040047] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10998713_1.4.2.3.1>

    2023-07-03T21:33:10.742059  / # #

    2023-07-03T21:33:10.842700  export SHELL=3D/bin/sh

    2023-07-03T21:33:10.842964  #

    2023-07-03T21:33:10.943530  / # export SHELL=3D/bin/sh. /lava-10998713/=
environment

    2023-07-03T21:33:10.943732  =


    2023-07-03T21:33:11.044284  / # . /lava-10998713/environment/lava-10998=
713/bin/lava-test-runner /lava-10998713/1

    2023-07-03T21:33:11.044597  =


    2023-07-03T21:33:11.049084  / # /lava-10998713/bin/lava-test-runner /la=
va-10998713/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33e54ab3a3dd160bb2a9e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33e54ab3a3dd160bb2aa3
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-03T21:31:47.410467  <8>[    7.996365] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10998684_1.4.2.3.1>

    2023-07-03T21:31:47.413431  + set +x

    2023-07-03T21:31:47.514901  #

    2023-07-03T21:31:47.515212  =


    2023-07-03T21:31:47.615766  / # #export SHELL=3D/bin/sh

    2023-07-03T21:31:47.616011  =


    2023-07-03T21:31:47.716602  / # export SHELL=3D/bin/sh. /lava-10998684/=
environment

    2023-07-03T21:31:47.716852  =


    2023-07-03T21:31:47.817465  / # . /lava-10998684/environment/lava-10998=
684/bin/lava-test-runner /lava-10998684/1

    2023-07-03T21:31:47.817846  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33e74ad5bd99f55bb2aef

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33e74ad5bd99f55bb2af3
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-03T21:32:11.233182  + set<8>[   11.355297] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10998729_1.4.2.3.1>

    2023-07-03T21:32:11.233266   +x

    2023-07-03T21:32:11.337465  / # #

    2023-07-03T21:32:11.438122  export SHELL=3D/bin/sh

    2023-07-03T21:32:11.438324  #

    2023-07-03T21:32:11.538855  / # export SHELL=3D/bin/sh. /lava-10998729/=
environment

    2023-07-03T21:32:11.539092  =


    2023-07-03T21:32:11.639608  / # . /lava-10998729/environment/lava-10998=
729/bin/lava-test-runner /lava-10998729/1

    2023-07-03T21:32:11.639877  =


    2023-07-03T21:32:11.644403  / # /lava-10998729/bin/lava-test-runner /la=
va-10998729/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33e6a815eadd404bb2a8a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.37-=
12-g86236a041c0f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33e6a815eadd404bb2a8f
        failing since 95 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-03T21:32:12.591103  + set +x<8>[   10.872264] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10998673_1.4.2.3.1>

    2023-07-03T21:32:12.591215  =


    2023-07-03T21:32:12.695601  / # #

    2023-07-03T21:32:12.796226  export SHELL=3D/bin/sh

    2023-07-03T21:32:12.796441  #

    2023-07-03T21:32:12.896967  / # export SHELL=3D/bin/sh. /lava-10998673/=
environment

    2023-07-03T21:32:12.897188  =


    2023-07-03T21:32:12.997700  / # . /lava-10998673/environment/lava-10998=
673/bin/lava-test-runner /lava-10998673/1

    2023-07-03T21:32:12.998046  =


    2023-07-03T21:32:13.003179  / # /lava-10998673/bin/lava-test-runner /la=
va-10998673/1
 =

    ... (12 line(s) more)  =

 =20
