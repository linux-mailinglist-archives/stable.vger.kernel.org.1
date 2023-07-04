Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1687473DE
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGDORh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 10:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjGDORg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 10:17:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E8E41
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 07:17:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b852785a65so36203765ad.0
        for <stable@vger.kernel.org>; Tue, 04 Jul 2023 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688480253; x=1691072253;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T4UKjwLSXB9PuZnRaNy6J5JBZnwstHQCmyC2tCRx/n4=;
        b=dIdztwOjTHznmRq7/26v09VZtEwEM3bsqUYx4H+Q9vodEnkojhIJ4LjbhvTfo/9Xvb
         Y/6cbhR5WeroXNSjnY8+4wh7K4MLM4tIWnjWvIii1cV3YKBwzno4HAyl1kIPrrTVT/sS
         RsPF+rGerYydjX/Zz3KVL+fKdXcJapEwZANWrpQNEXTo9dlPwHR9M77S9HUGXaJ+C9FK
         mndA+gcjcdP3245nbR73Bc8TZEvVCp0TlUiG2yk8tSXKbyFVFTMTgIFJa6fa5eRnMCNb
         9WuwjaVORImsw8WOPuxFTPSRLa5IPu65ZNVduZ9P95kz6UBae9T2PidcH53dpX7LgHKQ
         l65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688480253; x=1691072253;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4UKjwLSXB9PuZnRaNy6J5JBZnwstHQCmyC2tCRx/n4=;
        b=AMIBQ+RFUOJXVvcHhiCsQ98Fi1AK0L6MqbOOU6Djt0WqMUHys38t9ZlKREAFW3PluW
         i9IY0khgRv4MDSUYvRtQHL3lWnjNR3j5onamS5ptTe23GXHOiHSw0vfgedyex48lSe6Q
         iRmXBNxkGnlL3wjE6C6kxYCOTOO2JEaK6kBybhPKjvcavcEbDQ/8Ff6kdwbzAtXQaGji
         THIvLh/uXaVpBKTRFsNdNaC3pW5O3MDE3WRYIV68ix3kYCSj4NfBOw4Z4YmF7LiA01iD
         YrfqVEZfgXgcuouT5eIyIYYEgaWyTl6r3CMwE7DglNkBZtc2Vp0ZU5L4bnaDIZlR9pqk
         d8MQ==
X-Gm-Message-State: ABy/qLYc7S63QZODVKvcOlDENbND9LILjdWehMuGE6XIbHJGxnOFCAwE
        y65Q0PscryYh22Vmu6s9zovQEgJEeIQEdY31vkwskA==
X-Google-Smtp-Source: APBJJlHNtUq9KQJV7X+xu1y8Z5XpdNDKEn5cnRGYChKdrPYbzdSTAZ2e4gYYJ7qzhyL3b0vU9e1YGw==
X-Received: by 2002:a17:902:e9d5:b0:1b5:5a5f:368a with SMTP id 21-20020a170902e9d500b001b55a5f368amr15500732plk.27.1688480252883;
        Tue, 04 Jul 2023 07:17:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b001b8959fb293sm3984224plg.125.2023.07.04.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:17:32 -0700 (PDT)
Message-ID: <64a429fc.170a0220.c3946.7d7e@mx.google.com>
Date:   Tue, 04 Jul 2023 07:17:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.186-12-g95b8dd2315eef
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 169 runs,
 8 regressions (v5.10.186-12-g95b8dd2315eef)
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

stable-rc/linux-5.10.y baseline: 169 runs, 8 regressions (v5.10.186-12-g95b=
8dd2315eef)

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

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.186-12-g95b8dd2315eef/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.186-12-g95b8dd2315eef
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      95b8dd2315eef3107e14cafceff6d7eb77200974 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f8f7da873a431abb2ba0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f8f7da873a431abb2ba5
        failing since 167 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-07-04T10:48:00.620323  <8>[   11.106645] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3710963_1.5.2.4.1>
    2023-07-04T10:48:00.726771  / # #
    2023-07-04T10:48:00.828214  export SHELL=3D/bin/sh
    2023-07-04T10:48:00.828628  #
    2023-07-04T10:48:00.929711  / # export SHELL=3D/bin/sh. /lava-3710963/e=
nvironment
    2023-07-04T10:48:00.930057  =

    2023-07-04T10:48:00.930233  / # <3>[   11.372657] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-07-04T10:48:01.031375  . /lava-3710963/environment/lava-3710963/bi=
n/lava-test-runner /lava-3710963/1
    2023-07-04T10:48:01.031941  =

    2023-07-04T10:48:01.036982  / # /lava-3710963/bin/lava-test-runner /lav=
a-3710963/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f62fe54d48f627bb2a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f62fe54d48f627bb2a7a
        failing since 97 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-07-04T10:36:31.057412  + set +x

    2023-07-04T10:36:31.063958  <8>[   10.403380] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11006833_1.4.2.3.1>

    2023-07-04T10:36:31.168606  / # #

    2023-07-04T10:36:31.269246  export SHELL=3D/bin/sh

    2023-07-04T10:36:31.269473  #

    2023-07-04T10:36:31.370066  / # export SHELL=3D/bin/sh. /lava-11006833/=
environment

    2023-07-04T10:36:31.370259  =


    2023-07-04T10:36:31.470755  / # . /lava-11006833/environment/lava-11006=
833/bin/lava-test-runner /lava-11006833/1

    2023-07-04T10:36:31.471107  =


    2023-07-04T10:36:31.475719  / # /lava-11006833/bin/lava-test-runner /la=
va-11006833/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f62628d0ce43fbbb2a93

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f62628d0ce43fbbb2a98
        failing since 97 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-07-04T10:36:43.449393  + set +x

    2023-07-04T10:36:43.456090  <8>[   11.951117] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11006800_1.4.2.3.1>

    2023-07-04T10:36:43.560117  / # #

    2023-07-04T10:36:43.660782  export SHELL=3D/bin/sh

    2023-07-04T10:36:43.661001  #

    2023-07-04T10:36:43.761531  / # export SHELL=3D/bin/sh. /lava-11006800/=
environment

    2023-07-04T10:36:43.761755  =


    2023-07-04T10:36:43.862316  / # . /lava-11006800/environment/lava-11006=
800/bin/lava-test-runner /lava-11006800/1

    2023-07-04T10:36:43.862632  =


    2023-07-04T10:36:43.867783  / # /lava-11006800/bin/lava-test-runner /la=
va-11006800/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f900e9a0000110bb2aa9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a3f900e9a0000110bb2=
aaa
        new failure (last pass: v5.10.186-10-g5f99a36aeb1c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f90b396681a530bb2aa6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f90b396681a530bb2aab
        failing since 66 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-07-04T10:48:35.309667  [   15.999551] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3710986_1.5.2.4.1>
    2023-07-04T10:48:35.414094  =

    2023-07-04T10:48:35.414288  / # #[   16.062119] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-07-04T10:48:35.515684  export SHELL=3D/bin/sh
    2023-07-04T10:48:35.516244  =

    2023-07-04T10:48:35.617852  / # export SHELL=3D/bin/sh. /lava-3710986/e=
nvironment
    2023-07-04T10:48:35.618350  =

    2023-07-04T10:48:35.719881  / # . /lava-3710986/environment/lava-371098=
6/bin/lava-test-runner /lava-3710986/1
    2023-07-04T10:48:35.720538  =

    2023-07-04T10:48:35.724057  / # /lava-3710986/bin/lava-test-runner /lav=
a-3710986/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f8cfc969737d2cbb2aa9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f8cfc969737d2cbb2aae
        failing since 150 days (last pass: v5.10.147, first fail: v5.10.166=
-10-g6278b8c9832e)

    2023-07-04T10:47:28.445346  <8>[   18.010134] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3710964_1.5.2.4.1>
    2023-07-04T10:47:28.552302  / # #
    2023-07-04T10:47:28.654039  export SHELL=3D/bin/sh
    2023-07-04T10:47:28.654676  #
    2023-07-04T10:47:28.756498  / # export SHELL=3D/bin/sh. /lava-3710964/e=
nvironment
    2023-07-04T10:47:28.757080  =

    2023-07-04T10:47:28.858636  / # . /lava-3710964/environment/lava-371096=
4/bin/lava-test-runner /lava-3710964/1
    2023-07-04T10:47:28.859352  =

    2023-07-04T10:47:28.863580  / # /lava-3710964/bin/lava-test-runner /lav=
a-3710964/1
    2023-07-04T10:47:28.929425  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3fb37967a5d9217bb2aa3

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3fb37967a5d9217bb2ac4
        failing since 154 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-07-04T10:57:11.411188  + set +x
    2023-07-04T10:57:11.415231  <8>[   17.119640] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3711001_1.5.2.4.1>
    2023-07-04T10:57:11.537901  / # #
    2023-07-04T10:57:11.644318  export SHELL=3D/bin/sh
    2023-07-04T10:57:11.645911  #
    2023-07-04T10:57:11.749993  / # export SHELL=3D/bin/sh. /lava-3711001/e=
nvironment
    2023-07-04T10:57:11.751811  =

    2023-07-04T10:57:11.856010  / # . /lava-3711001/environment/lava-371100=
1/bin/lava-test-runner /lava-3711001/1
    2023-07-04T10:57:11.859427  =

    2023-07-04T10:57:11.862288  / # /lava-3711001/bin/lava-test-runner /lav=
a-3711001/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3f9c37e61011357bb2a8d

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-g95b8dd2315eef/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3f9c37e61011357bb2ab9
        failing since 154 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-07-04T10:51:31.831521  + set +x
    2023-07-04T10:51:31.835457  <8>[   17.071083] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 695211_1.5.2.4.1>
    2023-07-04T10:51:31.947992  / # #
    2023-07-04T10:51:32.050910  export SHELL=3D/bin/sh
    2023-07-04T10:51:32.051903  #
    2023-07-04T10:51:32.154378  / # export SHELL=3D/bin/sh. /lava-695211/en=
vironment
    2023-07-04T10:51:32.155004  =

    2023-07-04T10:51:32.257670  / # . /lava-695211/environment/lava-695211/=
bin/lava-test-runner /lava-695211/1
    2023-07-04T10:51:32.259171  =

    2023-07-04T10:51:32.263199  / # /lava-695211/bin/lava-test-runner /lava=
-695211/1 =

    ... (12 line(s) more)  =

 =20
