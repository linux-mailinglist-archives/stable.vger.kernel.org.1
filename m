Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8D7A6872
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 17:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjISP6c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 11:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjISP6b (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 11:58:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6291
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 08:58:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c43166b7e5so40396035ad.3
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695139103; x=1695743903; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6u1UALHp3mAZ+wLqGit7/VDqbwSSeHX7Qk8hPGMOx70=;
        b=HWl0TKJg/JnvZdXaXrLfnmEzhE2xTo+ZIJRUPngmq3iH996NDWSM04/kvhjwa66BqZ
         UOGI/Ynq03dPQN1Kob9wb8FNCjSrxi6ykgJsU+6WBHV1OzvqUa5DKxcobccCNGmycYZS
         X76e9sAojVynR5nD7fMdQfFd9ZOOynazXkKqr7ySC+hhf0VCC4sJvzTsjTGj0FPqnikQ
         ylorfF6fLsph3jbf1t2GLLLBWAO5tx5CSPgXLmZdmM8J6JQsG719R2M/nniHoB5V/So0
         mTAz7i650jWaHSb2/nQKOM5UBRWSJ87xRtNRwx+uGspT0v501JGCmz/udgt857JKa0Ik
         nPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695139103; x=1695743903;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u1UALHp3mAZ+wLqGit7/VDqbwSSeHX7Qk8hPGMOx70=;
        b=hQ5oArzxC7RnuQxHBfLbrUotDQeVAlbR8kwQtAfIIKs0EHUkeAgtJl+toRfhVs2p6y
         hR/LkCuG0LZb5liAKZgWk54T0YsQEewZqTYgcU8xFNS7KmQ2gnuNR7fmUaBqdUtF6u/d
         HxKsZdx8mSnjMbfTXdHk5mA/KI2y2i6Y7JR9EQJW+9eGNBUco4F+IO0xn2KgojDXCQDB
         sM2kn9H8ANFrwRqOwNBV9HvrW4ofqEcR5bIq4bGP98cjnkMQCTw+4UEwbp2xEyqa2D5G
         1/aTInVxJhS7KCQvnK6M6rqJsrGBLuGZixFo+w7WEw6/6o2Ghu7wNjbWTdcPyZ8W133t
         0R5w==
X-Gm-Message-State: AOJu0Yw+oR2zcn2/YNditImjtRz5It5UdkxB5yuWEQndXE8E6PCVntlK
        6264ET60dzXfh7BLUyWIoJ/+Ff2oVL9psYbiCB42JQ==
X-Google-Smtp-Source: AGHT+IHjXn/bq+sfOPMHtM+bY/iBvd8Tnb0DDWvohSW4yH4Q0a383HXLi30BKFweeGV4jWywduAwJA==
X-Received: by 2002:a17:903:2352:b0:1c3:aee0:7d27 with SMTP id c18-20020a170903235200b001c3aee07d27mr15336187plh.24.1695139102789;
        Tue, 19 Sep 2023 08:58:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709029a0700b001bdeedd8579sm10103708plp.252.2023.09.19.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 08:58:22 -0700 (PDT)
Message-ID: <6509c51e.170a0220.ac39a.2d01@mx.google.com>
Date:   Tue, 19 Sep 2023 08:58:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.54
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 93 runs, 9 regressions (v6.1.54)
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

stable-rc/linux-6.1.y baseline: 93 runs, 9 regressions (v6.1.54)

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

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.54/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.54
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a356197db198ad9825ce225f19f2c7448ef9eea0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65098f7a2aaaa84dbb8a0a48

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098f7a2aaaa84dbb8a0a51
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T12:10:39.384607  <8>[    9.990770] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570614_1.4.2.3.1>

    2023-09-19T12:10:39.387697  + set +x

    2023-09-19T12:10:39.489205  /#

    2023-09-19T12:10:39.590031   # #export SHELL=3D/bin/sh

    2023-09-19T12:10:39.590221  =


    2023-09-19T12:10:39.690756  / # export SHELL=3D/bin/sh. /lava-11570614/=
environment

    2023-09-19T12:10:39.691026  =


    2023-09-19T12:10:39.791664  / # . /lava-11570614/environment/lava-11570=
614/bin/lava-test-runner /lava-11570614/1

    2023-09-19T12:10:39.791941  =


    2023-09-19T12:10:39.798043  / # /lava-11570614/bin/lava-test-runner /la=
va-11570614/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65098ec43ea98ac7158a0a58

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098ec43ea98ac7158a0a61
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T12:06:11.025191  + set<8>[   11.542383] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11570628_1.4.2.3.1>

    2023-09-19T12:06:11.025275   +x

    2023-09-19T12:06:11.129708  / # #

    2023-09-19T12:06:11.230475  export SHELL=3D/bin/sh

    2023-09-19T12:06:11.230682  #

    2023-09-19T12:06:11.331250  / # export SHELL=3D/bin/sh. /lava-11570628/=
environment

    2023-09-19T12:06:11.331545  =


    2023-09-19T12:06:11.432108  / # . /lava-11570628/environment/lava-11570=
628/bin/lava-test-runner /lava-11570628/1

    2023-09-19T12:06:11.432399  =


    2023-09-19T12:06:11.437362  / # /lava-11570628/bin/lava-test-runner /la=
va-11570628/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65098eb21178a24fd98a0abc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098eb21178a24fd98a0ac5
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T12:07:21.013589  <8>[   10.432036] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570602_1.4.2.3.1>

    2023-09-19T12:07:21.016627  + set +x

    2023-09-19T12:07:21.117930  =


    2023-09-19T12:07:21.218445  / # #export SHELL=3D/bin/sh

    2023-09-19T12:07:21.218642  =


    2023-09-19T12:07:21.319136  / # export SHELL=3D/bin/sh. /lava-11570602/=
environment

    2023-09-19T12:07:21.319316  =


    2023-09-19T12:07:21.419916  / # . /lava-11570602/environment/lava-11570=
602/bin/lava-test-runner /lava-11570602/1

    2023-09-19T12:07:21.420215  =


    2023-09-19T12:07:21.425141  / # /lava-11570602/bin/lava-test-runner /la=
va-11570602/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099050e9f0fdf6ba8a0a78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65099050e9f0fdf6ba8a0=
a79
        failing since 103 days (last pass: v6.1.31-40-g7d0a9678d276, first =
fail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65098e9e1178a24fd98a0a44

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098e9e1178a24fd98a0a4d
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T12:05:41.530054  + set +x

    2023-09-19T12:05:41.536537  <8>[   11.061611] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570604_1.4.2.3.1>

    2023-09-19T12:05:41.644578  / # #

    2023-09-19T12:05:41.746901  export SHELL=3D/bin/sh

    2023-09-19T12:05:41.747527  #

    2023-09-19T12:05:41.849024  / # export SHELL=3D/bin/sh. /lava-11570604/=
environment

    2023-09-19T12:05:41.849786  =


    2023-09-19T12:05:41.951470  / # . /lava-11570604/environment/lava-11570=
604/bin/lava-test-runner /lava-11570604/1

    2023-09-19T12:05:41.952949  =


    2023-09-19T12:05:41.957704  / # /lava-11570604/bin/lava-test-runner /la=
va-11570604/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65098ec1dd218127368a0a4f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098ec1dd218127368a0a58
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T12:06:09.593597  + <8>[   11.180321] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11570613_1.4.2.3.1>

    2023-09-19T12:06:09.593770  set +x

    2023-09-19T12:06:09.697957  / # #

    2023-09-19T12:06:09.798777  export SHELL=3D/bin/sh

    2023-09-19T12:06:09.799000  #

    2023-09-19T12:06:09.899555  / # export SHELL=3D/bin/sh. /lava-11570613/=
environment

    2023-09-19T12:06:09.899774  =


    2023-09-19T12:06:10.000281  / # . /lava-11570613/environment/lava-11570=
613/bin/lava-test-runner /lava-11570613/1

    2023-09-19T12:06:10.000597  =


    2023-09-19T12:06:10.005479  / # /lava-11570613/bin/lava-test-runner /la=
va-11570613/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65098eb9d7bf62d63a8a0a56

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098ebad7bf62d63a8a0a5f
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T12:06:00.799430  + set<8>[   11.701146] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11570603_1.4.2.3.1>

    2023-09-19T12:06:00.799529   +x

    2023-09-19T12:06:00.903634  / # #

    2023-09-19T12:06:01.004270  export SHELL=3D/bin/sh

    2023-09-19T12:06:01.004434  #

    2023-09-19T12:06:01.104994  / # export SHELL=3D/bin/sh. /lava-11570603/=
environment

    2023-09-19T12:06:01.105165  =


    2023-09-19T12:06:01.205645  / # . /lava-11570603/environment/lava-11570=
603/bin/lava-test-runner /lava-11570603/1

    2023-09-19T12:06:01.206030  =


    2023-09-19T12:06:01.210539  / # /lava-11570603/bin/lava-test-runner /la=
va-11570603/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f65dff95a3cdc8a0a56

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65099f65dff95a3cdc8a0a5f
        failing since 63 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-19T13:21:31.577690  / # #

    2023-09-19T13:21:31.679836  export SHELL=3D/bin/sh

    2023-09-19T13:21:31.680539  #

    2023-09-19T13:21:31.782012  / # export SHELL=3D/bin/sh. /lava-11570764/=
environment

    2023-09-19T13:21:31.782729  =


    2023-09-19T13:21:31.884197  / # . /lava-11570764/environment/lava-11570=
764/bin/lava-test-runner /lava-11570764/1

    2023-09-19T13:21:31.885270  =


    2023-09-19T13:21:31.901513  / # /lava-11570764/bin/lava-test-runner /la=
va-11570764/1

    2023-09-19T13:21:31.950458  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T13:21:31.950962  + cd /lav<8>[   19.152848] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11570764_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509904ee9f0fdf6ba8a0a68

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.54/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509904ee9f0fdf6ba8a0a71
        failing since 63 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-19T12:17:01.013003  / # #

    2023-09-19T12:17:01.115334  export SHELL=3D/bin/sh

    2023-09-19T12:17:01.116110  #

    2023-09-19T12:17:01.217496  / # export SHELL=3D/bin/sh. /lava-11570763/=
environment

    2023-09-19T12:17:01.218266  =


    2023-09-19T12:17:01.319786  / # . /lava-11570763/environment/lava-11570=
763/bin/lava-test-runner /lava-11570763/1

    2023-09-19T12:17:01.321031  =


    2023-09-19T12:17:01.338069  / # /lava-11570763/bin/lava-test-runner /la=
va-11570763/1

    2023-09-19T12:17:01.404001  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T12:17:01.404509  + cd /lava-1157076<8>[   16.963584] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11570763_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
