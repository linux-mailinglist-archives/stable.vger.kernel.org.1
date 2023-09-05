Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489BB792858
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 18:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjIEQAn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbjIEBmv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 21:42:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19181CC5
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:42:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68bedc0c268so1580414b3a.0
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693878165; x=1694482965; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjsjlwn3S0qW7KBkU6d0iBmIl1hfobGA5NhO5L0pzJU=;
        b=tCdkJnDFHJrUQsZXxBQiXRKas3KY9gc2F7P8giZI7Jv1SXHxf1UKgrHuOyCqwhhL94
         RB7LE9WcfaTDJnHrilKj7/x5YSDR5HDn/6U6pHMjx/FTcTF0RksBXE+ItqRjhHTB/rWi
         KDeUx9eYzDqj1zqc0+oxgChxIvM8oPJQFEthAvTU7CVSTWfbOY1tdAhQTnXN5dL1mWe3
         uC9+/B8PkyWfiL0YjQchFmRRmh5j1C22GJjm439M2E+sp3X8KtaugIVuogwFA2I7g1ri
         LXv8urvQecG0Er6N6QXRqjX1YpvfPxk6Seu0w9jb3S5xx62sFShTbsZi8qBVttQK2rsq
         GfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693878165; x=1694482965;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rjsjlwn3S0qW7KBkU6d0iBmIl1hfobGA5NhO5L0pzJU=;
        b=EkO+VugnsE3bX9DF/CZdfRtJl+qF88pAvvu6KVoakU7Pre+V9Ndn1NAExE69Qy7xDs
         ricl6vi8rHguALuxqKvxt216RetC8vgLh0PsT4oS86rmZAwfUASYbmHhjKoVp+t9tDuR
         QrkWl7awzfkQAiU1SYYSKBl+UbTVopJ0wWN5HJdVv6uOdbJe162BfUluO0cCIhmNfY3M
         uX+bo5QBls8g2c4HZj4aVMui5tAedEhaSNGmzICXOQ1CZ8kKWDo+e4EuasLFCuWY0sc6
         LpgbibiEQFkgdhqOt2gkjLcn+ig5t5nU7wkmWpYq9UQ2DwzIMMkGKU8ubKc5+dByMqd+
         9HPw==
X-Gm-Message-State: AOJu0Yy9UMfF1x4v3H+uYlP9fAkIKB2Pd07/g2/HwEENQ3v1WSwKUq/G
        R5+AWhdzvHiYSW0avt+3v6GKd4vkSAVCgQwa7Xg=
X-Google-Smtp-Source: AGHT+IH2f3QqLlHX9MGAMDNQbjSjO4dxk3GXhKkHn9IXhDXLUTDB3MSkmIGI5lqYHZQM9b4fV+Nmeg==
X-Received: by 2002:a05:6a20:3ca3:b0:14c:7020:d613 with SMTP id b35-20020a056a203ca300b0014c7020d613mr15726212pzj.37.1693878164880;
        Mon, 04 Sep 2023 18:42:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7928d000000b0066f37665a6asm7869451pfa.117.2023.09.04.18.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 18:42:44 -0700 (PDT)
Message-ID: <64f68794.a70a0220.82666.019d@mx.google.com>
Date:   Mon, 04 Sep 2023 18:42:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.194-24-gc60233f6ca120
Subject: stable-rc/linux-5.10.y baseline: 126 runs,
 12 regressions (v5.10.194-24-gc60233f6ca120)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 126 runs, 12 regressions (v5.10.194-24-gc6=
0233f6ca120)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.194-24-gc60233f6ca120/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.194-24-gc60233f6ca120
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c60233f6ca120a2d2d3fa410e492400847fe0b98 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f657a54e1f2e04d3286eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f657a54e1f2e04d3286=
eba
        failing since 0 day (last pass: v5.10.194, first fail: v5.10.194-24=
-g1be601d24d330) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f656e80b0aafa09f286e5c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f656e80b0aafa09f286e61
        failing since 229 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-09-04T22:14:33.534661  <8>[   11.018378] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3763169_1.5.2.4.1>
    2023-09-04T22:14:33.644173  / # #
    2023-09-04T22:14:33.747624  export SHELL=3D/bin/sh
    2023-09-04T22:14:33.748319  #
    2023-09-04T22:14:33.850007  / # export SHELL=3D/bin/sh. /lava-3763169/e=
nvironment
    2023-09-04T22:14:33.850590  =

    2023-09-04T22:14:33.952067  / # . /lava-3763169/environment/lava-376316=
9/bin/lava-test-runner /lava-3763169/1
    2023-09-04T22:14:33.953175  =

    2023-09-04T22:14:33.953517  / # <3>[   11.371388] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-09-04T22:14:33.957822  /lava-3763169/bin/lava-test-runner /lava-37=
63169/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f655fd2dafd4a27d286dec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f655fd2dafd4a27d286def
        failing since 48 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-09-04T22:10:44.231094  [   13.337602] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1249247_1.5.2.4.1>
    2023-09-04T22:10:44.336392  =

    2023-09-04T22:10:44.437660  / # #export SHELL=3D/bin/sh
    2023-09-04T22:10:44.438063  =

    2023-09-04T22:10:44.539041  / # export SHELL=3D/bin/sh. /lava-1249247/e=
nvironment
    2023-09-04T22:10:44.539481  =

    2023-09-04T22:10:44.640478  / # . /lava-1249247/environment/lava-124924=
7/bin/lava-test-runner /lava-1249247/1
    2023-09-04T22:10:44.641187  =

    2023-09-04T22:10:44.645177  / # /lava-1249247/bin/lava-test-runner /lav=
a-1249247/1
    2023-09-04T22:10:44.666427  + export 'TESTRUN_[   13.771946] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1249247_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f652abfac11eb4b8286d83

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f652abfac11eb4b8286d88
        failing since 160 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-04T21:56:49.377078  + set +x

    2023-09-04T21:56:49.383384  <8>[   10.930390] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11432711_1.4.2.3.1>

    2023-09-04T21:56:49.487664  / # #

    2023-09-04T21:56:49.588252  export SHELL=3D/bin/sh

    2023-09-04T21:56:49.588441  #

    2023-09-04T21:56:49.688941  / # export SHELL=3D/bin/sh. /lava-11432711/=
environment

    2023-09-04T21:56:49.689178  =


    2023-09-04T21:56:49.789788  / # . /lava-11432711/environment/lava-11432=
711/bin/lava-test-runner /lava-11432711/1

    2023-09-04T21:56:49.790062  =


    2023-09-04T21:56:49.794866  / # /lava-11432711/bin/lava-test-runner /la=
va-11432711/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f652ab097290684a286d8f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f652ab097290684a286d94
        failing since 160 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-04T21:56:43.636640  <8>[   12.486307] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11432698_1.4.2.3.1>

    2023-09-04T21:56:43.639829  + set +x

    2023-09-04T21:56:43.746599  / # #

    2023-09-04T21:56:43.849356  export SHELL=3D/bin/sh

    2023-09-04T21:56:43.850142  #

    2023-09-04T21:56:43.951707  / # export SHELL=3D/bin/sh. /lava-11432698/=
environment

    2023-09-04T21:56:43.952598  =


    2023-09-04T21:56:44.054245  / # . /lava-11432698/environment/lava-11432=
698/bin/lava-test-runner /lava-11432698/1

    2023-09-04T21:56:44.055616  =


    2023-09-04T21:56:44.061370  / # /lava-11432698/bin/lava-test-runner /la=
va-11432698/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f6566fe4c381b74a286e0a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f6566fe4c381b74a286e0d
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T22:12:44.454135  + set +x
    2023-09-04T22:12:44.454257  <8>[   83.874790] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1005076_1.5.2.4.1>
    2023-09-04T22:12:44.556951  / # #
    2023-09-04T22:12:46.017437  export SHELL=3D/bin/sh
    2023-09-04T22:12:46.038021  #
    2023-09-04T22:12:46.038235  / # export SHELL=3D/bin/sh
    2023-09-04T22:12:47.993920  / # . /lava-1005076/environment
    2023-09-04T22:12:51.590396  /lava-1005076/bin/lava-test-runner /lava-10=
05076/1
    2023-09-04T22:12:51.610939  . /lava-1005076/environment
    2023-09-04T22:12:51.611049  / # /lava-1005076/bin/lava-test-runner /lav=
a-1005076/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f657874e1f2e04d3286d75

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f657874e1f2e04d3286d78
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T22:17:13.259423  + set +x
    2023-09-04T22:17:13.259643  <8>[   84.196308] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1005075_1.5.2.4.1>
    2023-09-04T22:17:13.365287  / # #
    2023-09-04T22:17:14.828018  export SHELL=3D/bin/sh
    2023-09-04T22:17:14.848610  #
    2023-09-04T22:17:14.848818  / # export SHELL=3D/bin/sh
    2023-09-04T22:17:16.805746  / # . /lava-1005075/environment
    2023-09-04T22:17:20.405951  /lava-1005075/bin/lava-test-runner /lava-10=
05075/1
    2023-09-04T22:17:20.426975  . /lava-1005075/environment
    2023-09-04T22:17:20.427153  / # /lava-1005075/bin/lava-test-runner /lav=
a-1005075/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f655f72dafd4a27d286dde

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f655f72dafd4a27d286de1
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T22:10:45.329320  / # #
    2023-09-04T22:10:46.788584  export SHELL=3D/bin/sh
    2023-09-04T22:10:46.808998  #
    2023-09-04T22:10:46.809136  / # export SHELL=3D/bin/sh
    2023-09-04T22:10:48.760802  / # . /lava-1005066/environment
    2023-09-04T22:10:52.351655  /lava-1005066/bin/lava-test-runner /lava-10=
05066/1
    2023-09-04T22:10:52.372452  . /lava-1005066/environment
    2023-09-04T22:10:52.372562  / # /lava-1005066/bin/lava-test-runner /lav=
a-1005066/1
    2023-09-04T22:10:52.453087  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-04T22:10:52.453326  + cd /lava-1005066/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f656e70b0aafa09f286e51

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f656e70b0aafa09f286e54
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T22:14:40.777401  / # #
    2023-09-04T22:14:42.236999  export SHELL=3D/bin/sh
    2023-09-04T22:14:42.257440  #
    2023-09-04T22:14:42.257563  / # export SHELL=3D/bin/sh
    2023-09-04T22:14:44.209920  / # . /lava-1005071/environment
    2023-09-04T22:14:47.803600  /lava-1005071/bin/lava-test-runner /lava-10=
05071/1
    2023-09-04T22:14:47.824387  . /lava-1005071/environment
    2023-09-04T22:14:47.824498  / # /lava-1005071/bin/lava-test-runner /lav=
a-1005071/1
    2023-09-04T22:14:47.901425  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-04T22:14:47.901644  + cd /lava-1005071/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f6553fc7d6118b87286d6d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f6553fc7d6118b87286d72
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T22:09:13.424105  / # #

    2023-09-04T22:09:13.524624  export SHELL=3D/bin/sh

    2023-09-04T22:09:13.524751  #

    2023-09-04T22:09:13.625251  / # export SHELL=3D/bin/sh. /lava-11432743/=
environment

    2023-09-04T22:09:13.625400  =


    2023-09-04T22:09:13.725903  / # . /lava-11432743/environment/lava-11432=
743/bin/lava-test-runner /lava-11432743/1

    2023-09-04T22:09:13.726117  =


    2023-09-04T22:09:13.737741  / # /lava-11432743/bin/lava-test-runner /la=
va-11432743/1

    2023-09-04T22:09:13.791465  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T22:09:13.791543  + cd /lav<8>[   16.433299] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11432743_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f65570c7d6118b87286d89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f65570c7d6118b87286d8e
        failing since 11 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-09-04T22:08:18.216153  / # #

    2023-09-04T22:08:19.477550  export SHELL=3D/bin/sh

    2023-09-04T22:08:19.488507  #

    2023-09-04T22:08:19.488978  / # export SHELL=3D/bin/sh

    2023-09-04T22:08:21.233030  / # . /lava-11432738/environment

    2023-09-04T22:08:24.438753  /lava-11432738/bin/lava-test-runner /lava-1=
1432738/1

    2023-09-04T22:08:24.450250  . /lava-11432738/environment

    2023-09-04T22:08:24.451676  / # /lava-11432738/bin/lava-test-runner /la=
va-11432738/1

    2023-09-04T22:08:24.504710  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T22:08:24.505208  + cd /lava-11432738/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f6553d61f33c5d45286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-24-gc60233f6ca120/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f6553e61f33c5d45286d71
        failing since 48 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-04T22:09:27.816416  / # #

    2023-09-04T22:09:27.917413  export SHELL=3D/bin/sh

    2023-09-04T22:09:27.918086  #

    2023-09-04T22:09:28.019414  / # export SHELL=3D/bin/sh. /lava-11432739/=
environment

    2023-09-04T22:09:28.020101  =


    2023-09-04T22:09:28.121577  / # . /lava-11432739/environment/lava-11432=
739/bin/lava-test-runner /lava-11432739/1

    2023-09-04T22:09:28.122623  =


    2023-09-04T22:09:28.130251  / # /lava-11432739/bin/lava-test-runner /la=
va-11432739/1

    2023-09-04T22:09:28.194339  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T22:09:28.194828  + cd /lava-1143273<8>[   18.198139] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11432739_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
