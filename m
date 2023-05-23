Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3492170D098
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 03:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjEWBjT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 21:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjEWBjI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 21:39:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D797
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:39:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d2467d640so5764272b3a.1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684805945; x=1687397945;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gdvArON7G14uL1pHDdYXCg2i2kywIwBYztBY3ygFwlA=;
        b=PdyX8PVAvEHUCAaZztrYfCMrARB/9QmVAdXzymrJwYmQgoVxpxcXF2/nR1PkuU/Kql
         4K4Rn2e6upy1MrM3rbaiz+bTEGD45nq2rmmxh2NCzPhtaO4sPainlqqVl1a2bBjRf79O
         ybIyUSd1fUIuBFB8gvjix2MGxLpADaRMGn6V6srk5WotTCbwikai+tss7YmeegoZcKPk
         JZmdoa4XLcp/hon6p2eRvPswSwkM8YHK4r5e+jYpqB1eceEmdS/4aHelDO4lhk48paSB
         aF2R6sSnsKGi6Qo62zgWkp7XTYrpqqB7k0WD4WFlQnvatG+YXZWMgvXjAMdcHP6aThs0
         Jkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684805945; x=1687397945;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdvArON7G14uL1pHDdYXCg2i2kywIwBYztBY3ygFwlA=;
        b=lBC0u7BpE+JJmlZB5uQ5CtlMQhFN2JdSmz+9c9esXV7T985qyBd0dJbGQe1DFh8xdn
         q/RpcES8UHCS4vI2I7kiX9rG7l6t/VOftj+Q7z1/ukJOH3v+1+aY9xx2cmaeIys6mSwE
         h9OoB8x9YTCB5TCuQZdXAL/tGjOFiewYnAeiCbdN6DJd1pAPi0XhY1uiLBfAwTkaWRyT
         mQnEUJTtpBE0T9FbW72dG2n/9e0Ci2dk12aRChdRagyEFyBLbJ/nVLGOitWWEY6usd+T
         9g9ntynuxhuPky4Jy3OekhgYlQluReQHd735KYrxG95nc1Aeo4fR+Yp1MfDzny7r1eU4
         U2yw==
X-Gm-Message-State: AC+VfDwjmXUX125K6nAnquvPT1Roir8UCw/chLSGzt4JQD5j1OVCcy7a
        PK10s4g5DhpKvVjsngh3T7ebTio22Qu64oxWYd8Xnw==
X-Google-Smtp-Source: ACHHUZ4dQYIG8gKld0owIGITCwSYgK12t2C5AAvmgz+rvwYtkQY4mULJcNxUafxsnJ6dyeUNsivXOQ==
X-Received: by 2002:a05:6a00:2e84:b0:63b:7119:64a9 with SMTP id fd4-20020a056a002e8400b0063b711964a9mr16617406pfb.16.1684805945371;
        Mon, 22 May 2023 18:39:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d1-20020aa78e41000000b00640dbf177b8sm4700552pfr.37.2023.05.22.18.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:39:04 -0700 (PDT)
Message-ID: <646c1938.a70a0220.c63ac.8b37@mx.google.com>
Date:   Mon, 22 May 2023 18:39:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-203-gd61c066794251
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 161 runs,
 7 regressions (v5.15.112-203-gd61c066794251)
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

stable-rc/queue/5.15 baseline: 161 runs, 7 regressions (v5.15.112-203-gd61c=
066794251)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-203-gd61c066794251/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-203-gd61c066794251
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d61c0667942519a99151a9d8c99a4499d3cc48ce =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646be75930cf50fa022e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646be75930cf50fa022e85ed
        failing since 55 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T22:05:55.790611  + set<8>[   10.766364] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10417543_1.4.2.3.1>

    2023-05-22T22:05:55.791037   +x

    2023-05-22T22:05:55.898461  / # #

    2023-05-22T22:05:56.001664  export SHELL=3D/bin/sh

    2023-05-22T22:05:56.001899  #

    2023-05-22T22:05:56.102470  / # export SHELL=3D/bin/sh. /lava-10417543/=
environment

    2023-05-22T22:05:56.102721  =


    2023-05-22T22:05:56.203363  / # . /lava-10417543/environment/lava-10417=
543/bin/lava-test-runner /lava-10417543/1

    2023-05-22T22:05:56.203639  =


    2023-05-22T22:05:56.208358  / # /lava-10417543/bin/lava-test-runner /la=
va-10417543/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646be7448449eb5d182e8614

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646be7448449eb5d182e8619
        failing since 55 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T22:05:35.798410  <8>[   10.362452] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417509_1.4.2.3.1>

    2023-05-22T22:05:35.801730  + set +x

    2023-05-22T22:05:35.903096  =


    2023-05-22T22:05:36.003723  / # #export SHELL=3D/bin/sh

    2023-05-22T22:05:36.003920  =


    2023-05-22T22:05:36.104449  / # export SHELL=3D/bin/sh. /lava-10417509/=
environment

    2023-05-22T22:05:36.104623  =


    2023-05-22T22:05:36.205207  / # . /lava-10417509/environment/lava-10417=
509/bin/lava-test-runner /lava-10417509/1

    2023-05-22T22:05:36.205464  =


    2023-05-22T22:05:36.210702  / # /lava-10417509/bin/lava-test-runner /la=
va-10417509/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646be77e47a0fa25492e8627

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646be77e47a0fa25492e862c
        failing since 55 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T22:06:39.167504  + set +x

    2023-05-22T22:06:39.174004  <8>[   11.023973] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417514_1.4.2.3.1>

    2023-05-22T22:06:39.278618  / # #

    2023-05-22T22:06:39.379253  export SHELL=3D/bin/sh

    2023-05-22T22:06:39.379478  #

    2023-05-22T22:06:39.479977  / # export SHELL=3D/bin/sh. /lava-10417514/=
environment

    2023-05-22T22:06:39.480201  =


    2023-05-22T22:06:39.580773  / # . /lava-10417514/environment/lava-10417=
514/bin/lava-test-runner /lava-10417514/1

    2023-05-22T22:06:39.581135  =


    2023-05-22T22:06:39.585967  / # /lava-10417514/bin/lava-test-runner /la=
va-10417514/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646be77e47a0fa25492e861c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646be77e47a0fa25492e8621
        failing since 55 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T22:06:33.948388  + set +x

    2023-05-22T22:06:33.955163  <8>[   10.587657] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417522_1.4.2.3.1>

    2023-05-22T22:06:34.058289  =


    2023-05-22T22:06:34.159041  / # #export SHELL=3D/bin/sh

    2023-05-22T22:06:34.159283  =


    2023-05-22T22:06:34.259903  / # export SHELL=3D/bin/sh. /lava-10417522/=
environment

    2023-05-22T22:06:34.260148  =


    2023-05-22T22:06:34.360780  / # . /lava-10417522/environment/lava-10417=
522/bin/lava-test-runner /lava-10417522/1

    2023-05-22T22:06:34.361186  =


    2023-05-22T22:06:34.365672  / # /lava-10417522/bin/lava-test-runner /la=
va-10417522/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646be747c9053840f92e85f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646be747c9053840f92e85f5
        failing since 55 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T22:05:39.223228  + set<8>[   10.694829] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10417498_1.4.2.3.1>

    2023-05-22T22:05:39.223314   +x

    2023-05-22T22:05:39.327218  / # #

    2023-05-22T22:05:39.427795  export SHELL=3D/bin/sh

    2023-05-22T22:05:39.428006  #

    2023-05-22T22:05:39.528525  / # export SHELL=3D/bin/sh. /lava-10417498/=
environment

    2023-05-22T22:05:39.528776  =


    2023-05-22T22:05:39.629288  / # . /lava-10417498/environment/lava-10417=
498/bin/lava-test-runner /lava-10417498/1

    2023-05-22T22:05:39.629622  =


    2023-05-22T22:05:39.634485  / # /lava-10417498/bin/lava-test-runner /la=
va-10417498/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646be6a69b526eb1a32e8610

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646be6a69b526eb1a32e8615
        failing since 115 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-22T22:02:52.114066  + set +x
    2023-05-22T22:02:52.114254  [    9.440012] <LAVA_SIGNAL_ENDRUN 0_dmesg =
956785_1.5.2.3.1>
    2023-05-22T22:02:52.221934  / # #
    2023-05-22T22:02:52.323722  export SHELL=3D/bin/sh
    2023-05-22T22:02:52.324154  #
    2023-05-22T22:02:52.425331  / # export SHELL=3D/bin/sh. /lava-956785/en=
vironment
    2023-05-22T22:02:52.425736  =

    2023-05-22T22:02:52.527021  / # . /lava-956785/environment/lava-956785/=
bin/lava-test-runner /lava-956785/1
    2023-05-22T22:02:52.527704  =

    2023-05-22T22:02:52.530099  / # /lava-956785/bin/lava-test-runner /lava=
-956785/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646be74604a09fc6802e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-gd61c066794251/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646be74604a09fc6802e85eb
        failing since 55 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T22:05:35.882072  + set<8>[   12.188650] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10417533_1.4.2.3.1>

    2023-05-22T22:05:35.882156   +x

    2023-05-22T22:05:35.986000  / # #

    2023-05-22T22:05:36.086551  export SHELL=3D/bin/sh

    2023-05-22T22:05:36.086748  #

    2023-05-22T22:05:36.187271  / # export SHELL=3D/bin/sh. /lava-10417533/=
environment

    2023-05-22T22:05:36.187528  =


    2023-05-22T22:05:36.288220  / # . /lava-10417533/environment/lava-10417=
533/bin/lava-test-runner /lava-10417533/1

    2023-05-22T22:05:36.288774  =


    2023-05-22T22:05:36.293653  / # /lava-10417533/bin/lava-test-runner /la=
va-10417533/1
 =

    ... (12 line(s) more)  =

 =20
