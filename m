Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93156F2E9D
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 07:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjEAFYw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 01:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjEAFYu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 01:24:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989BDE6
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 22:24:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115eef620so24693855b3a.1
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 22:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682918686; x=1685510686;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uGSi6a0wBUl2yDAJY4k1XP8Ip86Oc3ftY+B1/hetBoI=;
        b=S2DXDlu3rxXccnjwimFLVc4/Ex8XMRy44PnlTLEK/bAnnSBQtrKjkS9X2GjreZ/aSW
         J3Q9Y0nEWOkf2Ozd3v+TZS+K2+vlWLco7Csm0ZPSZ7pqTAag4SE/CGBLHmEynWPopJq7
         1dKv4fZKAJlCQj11fzqbB9XmIDT8LzTdBK2cqzyvQP2/FlnoFSoiNhwceFK0+tyLYXIg
         KcHVBZZ8IwTfZtnm9EuaoE3YAQ2Q81KMddVaIAPpy2x7HiEM4k8LrE6Jf6e/X+ACwZiY
         HuKnCIZM3+BR/yYC285doSmrSAiwHC1RTH0OXyfqdC6rsoeTew93INMmApLG0ybkE0Pl
         flIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682918686; x=1685510686;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGSi6a0wBUl2yDAJY4k1XP8Ip86Oc3ftY+B1/hetBoI=;
        b=JjrxZR+2fi5fTq6PHzZalYTXzkCShpM5Z8CBv1BcCrfnNQoFnpni90/0ZFGLr/T+Nd
         ExlSvzgxXqux9sBqvPaF/PcW6Bj8UtCfD+jhnAAe4+ec7nvG3z7y7jRspr1c/I69tulc
         7kWYPOqej86hTpOW6SX9Q+WfhAJIYpY2rmjUXfDKB+dB6ZDLtLwGYC/MGi0rlGzw0tXw
         cZbREDvKb0yRs7kz2ipTckhFy2cWlMnTCJ1mkCjkb62o7PBlEwY2HOQyrx8yNmb4MiBm
         O9yV5ykGthNkU/ME6cvFrXQaqZ2mnqv2MCSd8zlhh1LLJg3tuqRn2KJoXoHAV6P+MA/H
         9d4g==
X-Gm-Message-State: AC+VfDzrbvTOmu0y/Pl2NERacW3arrrzNStIKnNKm0omJKW77DcX6BW1
        NODSnsOs9VEvE/tdqiQj66gwhLkr912skSRVRZo=
X-Google-Smtp-Source: ACHHUZ5BlVfTsesLfhi8YiRTAgQD9xV5beR/Uzssh0xXyOjKDDOMPqVrPxeFjTmazudJ1FtJmaVCEQ==
X-Received: by 2002:a17:902:d4c1:b0:1a6:4770:8383 with SMTP id o1-20020a170902d4c100b001a647708383mr21786784plg.29.1682918686426;
        Sun, 30 Apr 2023 22:24:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001aafdf8063dsm398897pls.157.2023.04.30.22.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 22:24:45 -0700 (PDT)
Message-ID: <644f4d1d.170a0220.3c69b.0deb@mx.google.com>
Date:   Sun, 30 Apr 2023 22:24:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v6.1.27
X-Kernelci-Report-Type: test
Subject: stable/linux-6.1.y baseline: 170 runs, 10 regressions (v6.1.27)
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

stable/linux-6.1.y baseline: 170 runs, 10 regressions (v6.1.27)

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

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.27/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      ca48fc16c49388400eddd6c6614593ebf7c7726a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f19f205285a32f62e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f19f205285a32f62e8603
        failing since 31 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-01T01:46:14.780704  <8>[   10.592510] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164713_1.4.2.3.1>

    2023-05-01T01:46:14.783720  + set +x

    2023-05-01T01:46:14.888075  / #

    2023-05-01T01:46:14.988894  # #export SHELL=3D/bin/sh

    2023-05-01T01:46:14.989096  =


    2023-05-01T01:46:15.089618  / # export SHELL=3D/bin/sh. /lava-10164713/=
environment

    2023-05-01T01:46:15.089817  =


    2023-05-01T01:46:15.190323  / # . /lava-10164713/environment/lava-10164=
713/bin/lava-test-runner /lava-10164713/1

    2023-05-01T01:46:15.190615  =


    2023-05-01T01:46:15.195917  / # /lava-10164713/bin/lava-test-runner /la=
va-10164713/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f19ee05285a32f62e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f19ee05285a32f62e85f8
        failing since 31 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-01T01:46:06.648557  + set<8>[   11.564789] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10164729_1.4.2.3.1>

    2023-05-01T01:46:06.648641   +x

    2023-05-01T01:46:06.753160  / # #

    2023-05-01T01:46:06.853807  export SHELL=3D/bin/sh

    2023-05-01T01:46:06.853995  #

    2023-05-01T01:46:06.954505  / # export SHELL=3D/bin/sh. /lava-10164729/=
environment

    2023-05-01T01:46:06.954673  =


    2023-05-01T01:46:07.055154  / # . /lava-10164729/environment/lava-10164=
729/bin/lava-test-runner /lava-10164729/1

    2023-05-01T01:46:07.055436  =


    2023-05-01T01:46:07.059872  / # /lava-10164729/bin/lava-test-runner /la=
va-10164729/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f19fffab5c2a3612e9fa8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f19fffab5c2a3612e9fad
        failing since 31 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-01T01:46:32.266190  <8>[    9.859931] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164742_1.4.2.3.1>

    2023-05-01T01:46:32.269665  + set +x

    2023-05-01T01:46:32.370883  #

    2023-05-01T01:46:32.471796  / # #export SHELL=3D/bin/sh

    2023-05-01T01:46:32.472029  =


    2023-05-01T01:46:32.572559  / # export SHELL=3D/bin/sh. /lava-10164742/=
environment

    2023-05-01T01:46:32.572833  =


    2023-05-01T01:46:32.673509  / # . /lava-10164742/environment/lava-10164=
742/bin/lava-test-runner /lava-10164742/1

    2023-05-01T01:46:32.673808  =


    2023-05-01T01:46:32.678964  / # /lava-10164742/bin/lava-test-runner /la=
va-10164742/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/644f16db83e5e72bea2e85fa

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/arm=
/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/arm=
/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f16db83e5e72bea2e862d
        new failure (last pass: v6.1.26)

    2023-05-01T01:32:51.669491  + set +x
    2023-05-01T01:32:51.673345  <8>[   17.820689] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 402921_1.5.2.4.1>
    2023-05-01T01:32:51.789601  / # #
    2023-05-01T01:32:51.892832  export SHELL=3D/bin/sh
    2023-05-01T01:32:51.893709  #
    2023-05-01T01:32:51.996258  / # export SHELL=3D/bin/sh. /lava-402921/en=
vironment
    2023-05-01T01:32:51.997198  =

    2023-05-01T01:32:52.099716  / # . /lava-402921/environment/lava-402921/=
bin/lava-test-runner /lava-402921/1
    2023-05-01T01:32:52.101292  =

    2023-05-01T01:32:52.108360  / # /lava-402921/bin/lava-test-runner /lava=
-402921/1 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f19ea927d6e0c562e8852

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f19ea927d6e0c562e8857
        failing since 31 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-01T01:46:09.352263  + set +x

    2023-05-01T01:46:09.358460  <8>[   10.055996] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164707_1.4.2.3.1>

    2023-05-01T01:46:09.463156  / # #

    2023-05-01T01:46:09.563756  export SHELL=3D/bin/sh

    2023-05-01T01:46:09.563931  #

    2023-05-01T01:46:09.664432  / # export SHELL=3D/bin/sh. /lava-10164707/=
environment

    2023-05-01T01:46:09.664673  =


    2023-05-01T01:46:09.765201  / # . /lava-10164707/environment/lava-10164=
707/bin/lava-test-runner /lava-10164707/1

    2023-05-01T01:46:09.765547  =


    2023-05-01T01:46:09.770701  / # /lava-10164707/bin/lava-test-runner /la=
va-10164707/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f1a0432178b735a2e8635

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f1a0432178b735a2e863a
        failing since 31 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-01T01:46:21.838323  <8>[   10.233166] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164764_1.4.2.3.1>

    2023-05-01T01:46:21.841667  + set +x

    2023-05-01T01:46:21.946771  #

    2023-05-01T01:46:21.948203  =


    2023-05-01T01:46:22.050168  / # #export SHELL=3D/bin/sh

    2023-05-01T01:46:22.051081  =


    2023-05-01T01:46:22.152551  / # export SHELL=3D/bin/sh. /lava-10164764/=
environment

    2023-05-01T01:46:22.152988  =


    2023-05-01T01:46:22.254034  / # . /lava-10164764/environment/lava-10164=
764/bin/lava-test-runner /lava-10164764/1

    2023-05-01T01:46:22.255327  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f19f54b3bd42f322e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f19f54b3bd42f322e8605
        failing since 31 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-01T01:46:21.864738  + set<8>[   11.241871] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10164773_1.4.2.3.1>

    2023-05-01T01:46:21.864828   +x

    2023-05-01T01:46:21.969313  / # #

    2023-05-01T01:46:22.070057  export SHELL=3D/bin/sh

    2023-05-01T01:46:22.070268  #

    2023-05-01T01:46:22.170793  / # export SHELL=3D/bin/sh. /lava-10164773/=
environment

    2023-05-01T01:46:22.171043  =


    2023-05-01T01:46:22.271557  / # . /lava-10164773/environment/lava-10164=
773/bin/lava-test-runner /lava-10164773/1

    2023-05-01T01:46:22.271829  =


    2023-05-01T01:46:22.276593  / # /lava-10164773/bin/lava-test-runner /la=
va-10164773/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/644f17698870972ba12e85f5

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/arm=
64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/arm=
64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f17698870972ba12e85f8
        new failure (last pass: v6.1.25)

    2023-05-01T01:35:26.421625  / # #
    2023-05-01T01:35:26.524517  export SHELL=3D/bin/sh
    2023-05-01T01:35:26.525369  #
    2023-05-01T01:35:26.627365  / # export SHELL=3D/bin/sh. /lava-328569/en=
vironment
    2023-05-01T01:35:26.628191  =

    2023-05-01T01:35:26.730108  / # . /lava-328569/environment/lava-328569/=
bin/lava-test-runner /lava-328569/1
    2023-05-01T01:35:26.731440  =

    2023-05-01T01:35:26.747693  / # /lava-328569/bin/lava-test-runner /lava=
-328569/1
    2023-05-01T01:35:26.802520  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-01T01:35:26.803017  + cd /l<8>[   14.544184] <LAVA_SIGNAL_START=
RUN 1_bootrr 328569_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/644=
f17698870972ba12e8608
        new failure (last pass: v6.1.25)

    2023-05-01T01:35:29.154432  /lava-328569/1/../bin/lava-test-case
    2023-05-01T01:35:29.154805  <8>[   16.992435] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-05-01T01:35:29.155154  /lava-328569/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f19f405285a32f62e8616

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.27/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f19f405285a32f62e861b
        failing since 31 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-01T01:46:08.746840  + set +x<8>[   11.338000] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10164736_1.4.2.3.1>

    2023-05-01T01:46:08.746936  =


    2023-05-01T01:46:08.851212  / # #

    2023-05-01T01:46:08.951790  export SHELL=3D/bin/sh

    2023-05-01T01:46:08.951972  #

    2023-05-01T01:46:09.052517  / # export SHELL=3D/bin/sh. /lava-10164736/=
environment

    2023-05-01T01:46:09.052704  =


    2023-05-01T01:46:09.153257  / # . /lava-10164736/environment/lava-10164=
736/bin/lava-test-runner /lava-10164736/1

    2023-05-01T01:46:09.153525  =


    2023-05-01T01:46:09.158000  / # /lava-10164736/bin/lava-test-runner /la=
va-10164736/1
 =

    ... (12 line(s) more)  =

 =20
