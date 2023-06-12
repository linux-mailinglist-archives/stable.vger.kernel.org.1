Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2762D72C85F
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbjFLO0m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 10:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbjFLO0R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 10:26:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E15295E
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 07:24:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25bc612be7cso1012131a91.1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686579868; x=1689171868;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hjeF7teYipIxNXxasGUTGneOYfXo/DS8tPl/IzPSNPQ=;
        b=Z0EF6ciDxtMzY+Q95vcs42vUdWleF2scXPaCKyxZ/kPzDYiRhg5BME1vkiPogpbDII
         X/DJkBkoZtC2mFV9VTZPgUmc8Y3oQpXNt1T3gJNYLv4HuAexMtYQDI2KqliSShb+4rtH
         dpiTKSCZOT2yPzPnlyBD+rSFGZ5lRsRYwK9UNaN/kC93dj8QV5bgXrHhCQ30B1heNuFN
         WZ7KdXyL6VlWLr67TSpu4+UZ7Ohit1KyHA64EiffKysEUkaqvLXyFxh/k8GQva0VZGif
         i1lzkCoktxNh9zKcDXFrBFweIHWHAuROnXnr0qhObg7+x7+3Pcgnqk9bg7RDkggu1RYf
         zGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579868; x=1689171868;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjeF7teYipIxNXxasGUTGneOYfXo/DS8tPl/IzPSNPQ=;
        b=ioMKaO/46wh4NMLfOFvs2A9FvkE5X5vg6CCmz1LRie6VyopaF3MrOFPmqCSsS6vJiJ
         Y2eoliEfSWhrBIkgTDHI4a9LhDB4WavjYY96xfGrGCXtZLY+tf9oayZO6axn+mPHHJGY
         3pm3W4xw20RBczhk0ViJggYoVVyR0572BAXxC6e5n9CRQwF8rfQqARAMprjZdBDr7qPH
         DE+nd6KDNVWdc/vTWmUwk7VOlBEV3cWdSp3xywUfmIDOoAnUhFWl0lM0S2Bel3HOQ2Hd
         04bvBSTQEJ++ITBqBfSWL+RQjqgcwqnqprQrYwvf00H6zKR/7muvh/nYcuBd6jZ7Uayk
         XP1Q==
X-Gm-Message-State: AC+VfDw229q05DnFCePaTY+EkyUkigOr5x8u+5D6MU7wh98iSP9+U11W
        +cF3wk9A5BqrolaMrg5wjGSela4liTogXnTJagBDhA==
X-Google-Smtp-Source: ACHHUZ4hjnAB1YHYiOHffiuN7bGEVa+sC/R6aD8nL8MVBag1epTRcPZPjpop9/OceVS2XmV6ir+ouw==
X-Received: by 2002:a05:6a20:8e1a:b0:116:5321:63bf with SMTP id y26-20020a056a208e1a00b00116532163bfmr10820015pzj.41.1686579396187;
        Mon, 12 Jun 2023 07:16:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l13-20020a65680d000000b0053474697607sm7023885pgt.4.2023.06.12.07.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:16:35 -0700 (PDT)
Message-ID: <648728c3.650a0220.c646b.cdc3@mx.google.com>
Date:   Mon, 12 Jun 2023 07:16:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.183-62-g8bf0074a4df28
Subject: stable-rc/linux-5.10.y baseline: 182 runs,
 7 regressions (v5.10.183-62-g8bf0074a4df28)
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

stable-rc/linux-5.10.y baseline: 182 runs, 7 regressions (v5.10.183-62-g8bf=
0074a4df28)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.183-62-g8bf0074a4df28/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.183-62-g8bf0074a4df28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8bf0074a4df280eb3e7fb61096d38cacbb082563 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f7480ccfc6b86730613b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f7480ccfc6b867306140
        failing since 145 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-12T10:44:43.815405  <8>[   11.091060] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3658737_1.5.2.4.1>
    2023-06-12T10:44:43.925500  / # #
    2023-06-12T10:44:44.027244  export SHELL=3D/bin/sh
    2023-06-12T10:44:44.027615  #
    2023-06-12T10:44:44.128783  / # export SHELL=3D/bin/sh. /lava-3658737/e=
nvironment
    2023-06-12T10:44:44.129409  =

    2023-06-12T10:44:44.230946  / # . /lava-3658737/environment/lava-365873=
7/bin/lava-test-runner /lava-3658737/1
    2023-06-12T10:44:44.232557  =

    2023-06-12T10:44:44.241961  / # /lava-3658737/bin/lava-test-runner /lav=
a-3658737/1
    2023-06-12T10:44:44.284979  <3>[   11.532091] Bluetooth: hci0: command =
0x0c03 tx timeout =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f333dba137169b3061a7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f333dba137169b3061ac
        failing since 75 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-12T10:27:44.769355  + set +x

    2023-06-12T10:27:44.776636  <8>[   10.577641] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10687921_1.4.2.3.1>

    2023-06-12T10:27:44.880381  / # #

    2023-06-12T10:27:44.980945  export SHELL=3D/bin/sh

    2023-06-12T10:27:44.981110  #

    2023-06-12T10:27:45.081613  / # export SHELL=3D/bin/sh. /lava-10687921/=
environment

    2023-06-12T10:27:45.081783  =


    2023-06-12T10:27:45.182346  / # . /lava-10687921/environment/lava-10687=
921/bin/lava-test-runner /lava-10687921/1

    2023-06-12T10:27:45.182599  =


    2023-06-12T10:27:45.187581  / # /lava-10687921/bin/lava-test-runner /la=
va-10687921/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f335f93fd73c533061de

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f335f93fd73c533061e3
        failing since 75 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-12T10:27:58.065314  <8>[   12.648624] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10687929_1.4.2.3.1>

    2023-06-12T10:27:58.069035  + set +x

    2023-06-12T10:27:58.170394  =


    2023-06-12T10:27:58.270900  / # #export SHELL=3D/bin/sh

    2023-06-12T10:27:58.271081  =


    2023-06-12T10:27:58.371558  / # export SHELL=3D/bin/sh. /lava-10687929/=
environment

    2023-06-12T10:27:58.371750  =


    2023-06-12T10:27:58.472231  / # . /lava-10687929/environment/lava-10687=
929/bin/lava-test-runner /lava-10687929/1

    2023-06-12T10:27:58.472531  =


    2023-06-12T10:27:58.477839  / # /lava-10687929/bin/lava-test-runner /la=
va-10687929/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f7cc32bd74ea50306130

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f7cc32bd74ea50306135
        failing since 44 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-12T10:47:24.535120  [   15.947688] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3658801_1.5.2.4.1>
    2023-06-12T10:47:24.640130  =

    2023-06-12T10:47:24.741385  / # #export SHELL=3D/bin/sh
    2023-06-12T10:47:24.741906  =

    2023-06-12T10:47:24.742218  / # [   16.093409] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-06-12T10:47:24.843291  export SHELL=3D/bin/sh. /lava-3658801/envir=
onment
    2023-06-12T10:47:24.843758  =

    2023-06-12T10:47:24.945108  / # . /lava-3658801/environment/lava-365880=
1/bin/lava-test-runner /lava-3658801/1
    2023-06-12T10:47:24.945863  =

    2023-06-12T10:47:24.948370  / # /lava-3658801/bin/lava-test-runner /lav=
a-3658801/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f6f05cd592f4f330613f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f6f05cd592f4f3306144
        failing since 128 days (last pass: v5.10.147, first fail: v5.10.166=
-10-g6278b8c9832e)

    2023-06-12T10:43:38.977608  <8>[   12.659056] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3658735_1.5.2.4.1>
    2023-06-12T10:43:39.085304  / # #
    2023-06-12T10:43:39.187220  export SHELL=3D/bin/sh
    2023-06-12T10:43:39.187629  #
    2023-06-12T10:43:39.288921  / # export SHELL=3D/bin/sh. /lava-3658735/e=
nvironment
    2023-06-12T10:43:39.289381  =

    2023-06-12T10:43:39.390768  / # . /lava-3658735/environment/lava-365873=
5/bin/lava-test-runner /lava-3658735/1
    2023-06-12T10:43:39.391579  =

    2023-06-12T10:43:39.395744  / # /lava-3658735/bin/lava-test-runner /lav=
a-3658735/1
    2023-06-12T10:43:39.461670  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486fb728001c185b730612e

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486fb728001c185b730615a
        failing since 132 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-12T11:02:38.982117  + set +x
    2023-06-12T11:02:38.986208  <8>[   17.119880] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3658795_1.5.2.4.1>
    2023-06-12T11:02:39.106277  / # #
    2023-06-12T11:02:39.211857  export SHELL=3D/bin/sh
    2023-06-12T11:02:39.213438  #
    2023-06-12T11:02:39.316695  / # export SHELL=3D/bin/sh. /lava-3658795/e=
nvironment
    2023-06-12T11:02:39.318209  =

    2023-06-12T11:02:39.421688  / # . /lava-3658795/environment/lava-365879=
5/bin/lava-test-runner /lava-3658795/1
    2023-06-12T11:02:39.424401  =

    2023-06-12T11:02:39.427620  / # /lava-3658795/bin/lava-test-runner /lav=
a-3658795/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6486f825e656005fe6306133

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-62-g8bf0074a4df28/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6486f825e656005fe630615e
        failing since 132 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-12T10:48:50.740309  + set +x
    2023-06-12T10:48:50.744415  <8>[   17.052153] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 597085_1.5.2.4.1>
    2023-06-12T10:48:50.857910  / # #
    2023-06-12T10:48:50.960610  export SHELL=3D/bin/sh
    2023-06-12T10:48:50.961402  #
    2023-06-12T10:48:51.063451  / # export SHELL=3D/bin/sh. /lava-597085/en=
vironment
    2023-06-12T10:48:51.064064  =

    2023-06-12T10:48:51.166505  / # . /lava-597085/environment/lava-597085/=
bin/lava-test-runner /lava-597085/1
    2023-06-12T10:48:51.169472  =

    2023-06-12T10:48:51.172218  / # /lava-597085/bin/lava-test-runner /lava=
-597085/1 =

    ... (12 line(s) more)  =

 =20
