Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82E4711A23
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 00:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbjEYW0T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 18:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEYW0S (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 18:26:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B7F1A4
        for <stable@vger.kernel.org>; Thu, 25 May 2023 15:26:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d41763796so203479b3a.2
        for <stable@vger.kernel.org>; Thu, 25 May 2023 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685053571; x=1687645571;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UJn/B815y/bkxkWzl4xcjjsQDBC1t2ZGOGoA7v0A878=;
        b=4psjwhS4aRkKelUQSOnJ3WnnAGuCio/Um5PgON3CN1sl2I8R3oICaX5isuApo/Re9M
         i28aG/Oki387cJWK+ocvnduhaP4OXfbHugdQr+TH0CgVXVsCndPZUDC6pughNgglWffh
         YRFvV08G4YEk27MMglZegZ/RqDHbzWXMe9la7ZMgEEXjWQ80/HCE5QANFQATWxi/npCu
         YowVWyTLnbF8Ak1ZflFP+SlOG5FCF3kwQWVgSLSnpbA3vFOqfc7eInO2I814hESJER7y
         4KCCUEUYjmo587Va5RGg7smLngPTVRux5+qU7Wrb6o3XlG+5dtIHiBR19t3WAHSs0QqU
         Heig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685053571; x=1687645571;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJn/B815y/bkxkWzl4xcjjsQDBC1t2ZGOGoA7v0A878=;
        b=I6Qo98irosDwk2CbQjtN3ILfeTV+Hu3SrH+fDhCD0X7XPCqGs53Hug3SZaibYae6vN
         LFRrs+Cj9XCTpU2TwWiYP0EspsiN6ozmlkP7SJka3huCLtti5KCyn1UxK5LzUx/fMpy3
         2N7QA6rap4HB4fe5IwAAAabQtbTlfVzF96xe3I15USlRFUkVRkLuaaMhJYp74sSdhe/W
         dsF5qKOnX7IjkFpjtGEr5slJa+u9AlHqtbN04nfex+B3RIh8Nn9BvWx7hATcai88HgSb
         o9m9uZdMDNpAwXAIlK/1l6h0Hpdbtzlez0wb7iK9ZsLhJPijkzeLQEQPc8Y5XMulH224
         Z1bA==
X-Gm-Message-State: AC+VfDwJF/Y/NhHffC6TeC3NEbkCBcL8is17qGBR3E76Bg/OobLs7DpE
        j3CLVsGzcyEFH/UohnqXPyA0kF1B8hIqkJHT2gnj5A==
X-Google-Smtp-Source: ACHHUZ4QzqFPg2osyQZBa5vxZYkd/UibR+6uwSO2/K/V4W00hdeSZr0I6UdK+tcDl794Ur87dhV9Sw==
X-Received: by 2002:a05:6a20:258b:b0:105:5800:c51b with SMTP id k11-20020a056a20258b00b001055800c51bmr25015389pzd.30.1685053571388;
        Thu, 25 May 2023 15:26:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709027c9200b001a9bfd4c5dfsm1858265pll.147.2023.05.25.15.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 15:26:10 -0700 (PDT)
Message-ID: <646fe082.170a0220.3af98.433f@mx.google.com>
Date:   Thu, 25 May 2023 15:26:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-300-g6985ea609f7c
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 183 runs,
 10 regressions (v6.1.29-300-g6985ea609f7c)
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

stable-rc/queue/6.1 baseline: 183 runs, 10 regressions (v6.1.29-300-g6985ea=
609f7c)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-300-g6985ea609f7c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-300-g6985ea609f7c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6985ea609f7c9a5aea657eda92e4857ea41fbb48 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fab896dbc8ae2e22e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fab896dbc8ae2e22e8601
        failing since 57 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-25T18:39:51.868344  <8>[   10.947837] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10456312_1.4.2.3.1>

    2023-05-25T18:39:51.871791  + set +x

    2023-05-25T18:39:51.980028  / # #

    2023-05-25T18:39:52.082379  export SHELL=3D/bin/sh

    2023-05-25T18:39:52.083161  #

    2023-05-25T18:39:52.184779  / # export SHELL=3D/bin/sh. /lava-10456312/=
environment

    2023-05-25T18:39:52.185535  =


    2023-05-25T18:39:52.287183  / # . /lava-10456312/environment/lava-10456=
312/bin/lava-test-runner /lava-10456312/1

    2023-05-25T18:39:52.287910  =


    2023-05-25T18:39:52.293881  / # /lava-10456312/bin/lava-test-runner /la=
va-10456312/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fab7f79a79647722e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fab7f79a79647722e8603
        failing since 57 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-25T18:39:37.401457  + set<8>[   11.186608] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10456268_1.4.2.3.1>

    2023-05-25T18:39:37.401545   +x

    2023-05-25T18:39:37.505677  / # #

    2023-05-25T18:39:37.607657  export SHELL=3D/bin/sh

    2023-05-25T18:39:37.607847  #

    2023-05-25T18:39:37.708391  / # export SHELL=3D/bin/sh. /lava-10456268/=
environment

    2023-05-25T18:39:37.708570  =


    2023-05-25T18:39:37.809208  / # . /lava-10456268/environment/lava-10456=
268/bin/lava-test-runner /lava-10456268/1

    2023-05-25T18:39:37.810268  =


    2023-05-25T18:39:37.815104  / # /lava-10456268/bin/lava-test-runner /la=
va-10456268/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fab8679a79647722e8677

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fab8679a79647722e867c
        failing since 57 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-25T18:39:48.865206  <8>[   14.125808] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10456309_1.4.2.3.1>

    2023-05-25T18:39:48.868489  + set +x

    2023-05-25T18:39:48.974271  =


    2023-05-25T18:39:49.076097  / # #export SHELL=3D/bin/sh

    2023-05-25T18:39:49.076865  =


    2023-05-25T18:39:49.178304  / # export SHELL=3D/bin/sh. /lava-10456309/=
environment

    2023-05-25T18:39:49.179113  =


    2023-05-25T18:39:49.280744  / # . /lava-10456309/environment/lava-10456=
309/bin/lava-test-runner /lava-10456309/1

    2023-05-25T18:39:49.281935  =


    2023-05-25T18:39:49.287244  / # /lava-10456309/bin/lava-test-runner /la=
va-10456309/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646fbc20a8b790cc022e866c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646fbc20a8b790cc022e8=
66d
        failing since 35 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fab8e04fe2b67442e860d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fab8e04fe2b67442e8612
        failing since 57 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-25T18:39:50.140943  + set +x

    2023-05-25T18:39:50.147457  <8>[   11.247943] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10456273_1.4.2.3.1>

    2023-05-25T18:39:50.252058  / # #

    2023-05-25T18:39:50.352695  export SHELL=3D/bin/sh

    2023-05-25T18:39:50.352921  #

    2023-05-25T18:39:50.453484  / # export SHELL=3D/bin/sh. /lava-10456273/=
environment

    2023-05-25T18:39:50.453692  =


    2023-05-25T18:39:50.554242  / # . /lava-10456273/environment/lava-10456=
273/bin/lava-test-runner /lava-10456273/1

    2023-05-25T18:39:50.554527  =


    2023-05-25T18:39:50.559501  / # /lava-10456273/bin/lava-test-runner /la=
va-10456273/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fab705f46db50262e8604

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fab705f46db50262e8609
        failing since 57 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-25T18:39:29.124271  <8>[   10.166124] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10456285_1.4.2.3.1>

    2023-05-25T18:39:29.127434  + set +x

    2023-05-25T18:39:29.232529  / # #

    2023-05-25T18:39:29.333142  export SHELL=3D/bin/sh

    2023-05-25T18:39:29.333421  #

    2023-05-25T18:39:29.434073  / # export SHELL=3D/bin/sh. /lava-10456285/=
environment

    2023-05-25T18:39:29.434291  =


    2023-05-25T18:39:29.534853  / # . /lava-10456285/environment/lava-10456=
285/bin/lava-test-runner /lava-10456285/1

    2023-05-25T18:39:29.535311  =


    2023-05-25T18:39:29.540090  / # /lava-10456285/bin/lava-test-runner /la=
va-10456285/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fab8a6dbc8ae2e22e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fab8a6dbc8ae2e22e860c
        failing since 57 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-25T18:39:46.951406  + <8>[   11.461494] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10456314_1.4.2.3.1>

    2023-05-25T18:39:46.951515  set +x

    2023-05-25T18:39:47.055399  / # #

    2023-05-25T18:39:47.156023  export SHELL=3D/bin/sh

    2023-05-25T18:39:47.156237  #

    2023-05-25T18:39:47.256714  / # export SHELL=3D/bin/sh. /lava-10456314/=
environment

    2023-05-25T18:39:47.256939  =


    2023-05-25T18:39:47.357419  / # . /lava-10456314/environment/lava-10456=
314/bin/lava-test-runner /lava-10456314/1

    2023-05-25T18:39:47.357703  =


    2023-05-25T18:39:47.362652  / # /lava-10456314/bin/lava-test-runner /la=
va-10456314/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646fa9ece7748300162e85f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fa9ece7748300162e85fb
        new failure (last pass: v6.1.29-292-gdc336616135a)

    2023-05-25T18:32:53.926110  + set[   14.903217] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 959611_1.5.2.3.1>
    2023-05-25T18:32:53.926300   +x
    2023-05-25T18:32:54.032001  / # #
    2023-05-25T18:32:54.133939  export SHELL=3D/bin/sh
    2023-05-25T18:32:54.134493  #
    2023-05-25T18:32:54.235727  / # export SHELL=3D/bin/sh. /lava-959611/en=
vironment
    2023-05-25T18:32:54.236271  =

    2023-05-25T18:32:54.337552  / # . /lava-959611/environment/lava-959611/=
bin/lava-test-runner /lava-959611/1
    2023-05-25T18:32:54.338110  =

    2023-05-25T18:32:54.341048  / # /lava-959611/bin/lava-test-runner /lava=
-959611/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646fab7ce1b3e0dc172e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646fab7ce1b3e0dc172e860e
        failing since 57 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-25T18:39:46.451698  <8>[   11.521576] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10456305_1.4.2.3.1>

    2023-05-25T18:39:46.556265  / # #

    2023-05-25T18:39:46.656985  export SHELL=3D/bin/sh

    2023-05-25T18:39:46.657200  #

    2023-05-25T18:39:46.757700  / # export SHELL=3D/bin/sh. /lava-10456305/=
environment

    2023-05-25T18:39:46.757904  =


    2023-05-25T18:39:46.858481  / # . /lava-10456305/environment/lava-10456=
305/bin/lava-test-runner /lava-10456305/1

    2023-05-25T18:39:46.858801  =


    2023-05-25T18:39:46.863498  / # /lava-10456305/bin/lava-test-runner /la=
va-10456305/1

    2023-05-25T18:39:46.869904  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646fb12d9a918534042e873d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
0-g6985ea609f7c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646fb12d9a918534042e8=
73e
        new failure (last pass: v6.1.29-292-g32cf2b40a0008) =

 =20
