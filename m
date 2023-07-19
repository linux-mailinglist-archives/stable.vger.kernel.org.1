Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B0B75A024
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGSUsf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 16:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGSUse (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 16:48:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C255E1FD7
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 13:48:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9cd6a0051so505015ad.1
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689799709; x=1692391709;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kk/FrAsv1uZ732h/bJGJwynNiTucUdG/fX15xXUOxEQ=;
        b=T0uJmM6tJ3G2usQZIX11TnLl4APp2X9aysiRhu6MTYS8vmY73TUgqRSl3zk/TtT7Bq
         M7CghtXEVJHQoJW96qeYKBaxcKOl8uJP8eaEoqhqledlwPQzpmqH6Ia9ZBnMGg9FmtRG
         NrlAaEg9E+903WoFGF8iyrqHJ9fHoR+zdYeRoF2b2uansmzQkY6Lh7fkTdwH7sEbNr7S
         BqFNT7kyfK4zVJpU5sE0PI0Ph7IdQHXvtr2qYoOcNTorcT8hndnjbq6d06eNBFZ3Qt6S
         rB0MebJ3E3P7qKDGQRNzOc0/2e/ibKM1N/IzJFIctFRJkm3f4o4V8204acUTe7eWvkxr
         UfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689799709; x=1692391709;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kk/FrAsv1uZ732h/bJGJwynNiTucUdG/fX15xXUOxEQ=;
        b=i0c1zEpfaWNg7nLQlPX984KjWNaQgFwqkV/Ra+NoWr/YXaK2Ann4UXoYgDzFrNFMXb
         66DRATnYK6p7/3icw7cVQkq7/+NIqR9AcuO2Dg4BRIvd75hBsHl1+958/4L3+C0P7D0y
         IjDIO5bECJw8mzUwvbycoR1n+/u28of1SCGoN//WMxKQzRzg53hLaY8W5UaHPYdpqEXH
         cY8NSKOJ9dXTOZQXeeTwqLoYbSRcvhl/1dTFaeXRqZL74mOlvCN683DJj+HLkCKazshO
         r6w2ZnJcDWQumHhp8eGTEOlye++Vr3eDhh8VZ3bqTqwTQdQ8cC6Aii1eTDax+Dum+mXm
         NQZw==
X-Gm-Message-State: ABy/qLZw/Wyn4e65K5XYNCE1DJS/J/DEQfBZgt244JLBqVnDbBsx6p5W
        KngIa5C8aPhTy8+4zSa6MKBTkEEkQwiOgu33jcnXuw==
X-Google-Smtp-Source: APBJJlHqrdO0SsymitY1xo8elwBMXF/sMdXO5gT2aockSeKx/LspphsiNpVPYxeLNJh4WIIWY49g4g==
X-Received: by 2002:a17:902:d305:b0:1af:ffda:855a with SMTP id b5-20020a170902d30500b001afffda855amr5490634plc.9.1689799709237;
        Wed, 19 Jul 2023 13:48:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001b89b1b99fasm4393029plg.243.2023.07.19.13.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:48:28 -0700 (PDT)
Message-ID: <64b84c1c.170a0220.7d36b.a29d@mx.google.com>
Date:   Wed, 19 Jul 2023 13:48:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.39
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 124 runs, 10 regressions (v6.1.39)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 124 runs, 10 regressions (v6.1.39)

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

at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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
el/v6.1.39/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.39
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a456e17438819ed77f63d16926f96101ca215f09 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b815c0363ba66d608ace49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b815c0363ba66d608ac=
e4a
        new failure (last pass: v6.1.38-590-gce7ec1011187) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b8158da10eff0edf8ace36

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b8158da10eff0edf8ace3b
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:55:20.192969  + set +x

    2023-07-19T16:55:20.200197  <8>[   10.208068] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11113357_1.4.2.3.1>

    2023-07-19T16:55:20.308376  / # #

    2023-07-19T16:55:20.408993  export SHELL=3D/bin/sh

    2023-07-19T16:55:20.409282  #

    2023-07-19T16:55:20.509964  / # export SHELL=3D/bin/sh. /lava-11113357/=
environment

    2023-07-19T16:55:20.510175  =


    2023-07-19T16:55:20.610929  / # . /lava-11113357/environment/lava-11113=
357/bin/lava-test-runner /lava-11113357/1

    2023-07-19T16:55:20.611289  =


    2023-07-19T16:55:20.617074  / # /lava-11113357/bin/lava-test-runner /la=
va-11113357/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b815925555ae3c268ace62

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b815925555ae3c268ace67
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:55:28.138577  + <8>[   11.899909] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11113349_1.4.2.3.1>

    2023-07-19T16:55:28.138708  set +x

    2023-07-19T16:55:28.243214  / # #

    2023-07-19T16:55:28.343913  export SHELL=3D/bin/sh

    2023-07-19T16:55:28.344143  #

    2023-07-19T16:55:28.444679  / # export SHELL=3D/bin/sh. /lava-11113349/=
environment

    2023-07-19T16:55:28.444907  =


    2023-07-19T16:55:28.545493  / # . /lava-11113349/environment/lava-11113=
349/bin/lava-test-runner /lava-11113349/1

    2023-07-19T16:55:28.545816  =


    2023-07-19T16:55:28.550347  / # /lava-11113349/bin/lava-test-runner /la=
va-11113349/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b815905555ae3c268ace56

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b815905555ae3c268ace5b
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:55:26.508979  <8>[    9.937588] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11113345_1.4.2.3.1>

    2023-07-19T16:55:26.512832  + set +x

    2023-07-19T16:55:26.614755  =


    2023-07-19T16:55:26.715524  / # #export SHELL=3D/bin/sh

    2023-07-19T16:55:26.715739  =


    2023-07-19T16:55:26.816308  / # export SHELL=3D/bin/sh. /lava-11113345/=
environment

    2023-07-19T16:55:26.816520  =


    2023-07-19T16:55:26.917099  / # . /lava-11113345/environment/lava-11113=
345/bin/lava-test-runner /lava-11113345/1

    2023-07-19T16:55:26.917418  =


    2023-07-19T16:55:26.922855  / # /lava-11113345/bin/lava-test-runner /la=
va-11113345/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b8182a49ccf5dc5a8acea8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b8182a49ccf5dc5a8ac=
ea9
        failing since 1 day (last pass: v6.1.38-393-gb6386e7314b4, first fa=
il: v6.1.38-590-gce7ec1011187) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b818f2d28976251f8acef0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b818f2d28976251f8ac=
ef1
        failing since 41 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b8158931befa9c4e8ace77

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b8158931befa9c4e8ace7c
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:55:59.101726  + set +x

    2023-07-19T16:55:59.108588  <8>[   10.581291] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11113341_1.4.2.3.1>

    2023-07-19T16:55:59.213427  / # #

    2023-07-19T16:55:59.314203  export SHELL=3D/bin/sh

    2023-07-19T16:55:59.314430  #

    2023-07-19T16:55:59.415005  / # export SHELL=3D/bin/sh. /lava-11113341/=
environment

    2023-07-19T16:55:59.415214  =


    2023-07-19T16:55:59.515779  / # . /lava-11113341/environment/lava-11113=
341/bin/lava-test-runner /lava-11113341/1

    2023-07-19T16:55:59.516065  =


    2023-07-19T16:55:59.521004  / # /lava-11113341/bin/lava-test-runner /la=
va-11113341/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b8157ca047fba3da8ace4f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b8157ca047fba3da8ace54
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:55:11.933137  <8>[   10.806749] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11113344_1.4.2.3.1>

    2023-07-19T16:55:11.936137  + set +x

    2023-07-19T16:55:12.037578  #

    2023-07-19T16:55:12.037916  =


    2023-07-19T16:55:12.138676  / # #export SHELL=3D/bin/sh

    2023-07-19T16:55:12.139324  =


    2023-07-19T16:55:12.240681  / # export SHELL=3D/bin/sh. /lava-11113344/=
environment

    2023-07-19T16:55:12.241347  =


    2023-07-19T16:55:12.342973  / # . /lava-11113344/environment/lava-11113=
344/bin/lava-test-runner /lava-11113344/1

    2023-07-19T16:55:12.344224  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b8159aad90426f238ace51

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b8159aad90426f238ace56
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:55:40.354500  + set<8>[   10.780692] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11113327_1.4.2.3.1>

    2023-07-19T16:55:40.354585   +x

    2023-07-19T16:55:40.458936  / # #

    2023-07-19T16:55:40.559709  export SHELL=3D/bin/sh

    2023-07-19T16:55:40.559924  #

    2023-07-19T16:55:40.660478  / # export SHELL=3D/bin/sh. /lava-11113327/=
environment

    2023-07-19T16:55:40.660695  =


    2023-07-19T16:55:40.761242  / # . /lava-11113327/environment/lava-11113=
327/bin/lava-test-runner /lava-11113327/1

    2023-07-19T16:55:40.761557  =


    2023-07-19T16:55:40.766486  / # /lava-11113327/bin/lava-test-runner /la=
va-11113327/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b81584a10eff0edf8ace1c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.39/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b81584a10eff0edf8ace21
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:55:21.767379  + set +x<8>[   12.651185] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11113342_1.4.2.3.1>

    2023-07-19T16:55:21.767464  =


    2023-07-19T16:55:21.871143  / # #

    2023-07-19T16:55:21.971757  export SHELL=3D/bin/sh

    2023-07-19T16:55:21.971901  #

    2023-07-19T16:55:22.072411  / # export SHELL=3D/bin/sh. /lava-11113342/=
environment

    2023-07-19T16:55:22.072552  =


    2023-07-19T16:55:22.173070  / # . /lava-11113342/environment/lava-11113=
342/bin/lava-test-runner /lava-11113342/1

    2023-07-19T16:55:22.173320  =


    2023-07-19T16:55:22.177965  / # /lava-11113342/bin/lava-test-runner /la=
va-11113342/1
 =

    ... (12 line(s) more)  =

 =20
