Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE3B744A6C
	for <lists+stable@lfdr.de>; Sat,  1 Jul 2023 18:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGAQEy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 1 Jul 2023 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGAQEy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 1 Jul 2023 12:04:54 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D192686
        for <stable@vger.kernel.org>; Sat,  1 Jul 2023 09:04:50 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1b0605d4d11so2736524fac.1
        for <stable@vger.kernel.org>; Sat, 01 Jul 2023 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688227490; x=1690819490;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s4NrrbMIWVozgtSvLA84h3/cDpaJWLVd0mnOoHMB+sk=;
        b=hhgYUfHYtYC0xeOhYW/Jf0jBS3by6gteduHiMDcqVhSqC8NndMn3srVKXy6L6xX/g7
         JSfG8wsCJrOOTArQ7qUh70M0VxdwvjZem1ZvX3dyB0Wjgr39Gr2ncbeW97U0vzBINnBx
         D5w+cJ3wpPZJJPH8IhpeS3HpQ/ONu+sX0Awi9u1hM6hfOyMesWGhdQLwdfUAH/Tnnahy
         KyP1rQ/KrpoZ4e31VolrglqaGtJGEZs3xI6Apjcoph8adQtoOnLHDfDrcmfVIEz2JTRw
         Q7f0S3dkUJ9Lu122CvH/yE1IMZYntMXnm6xZtN7zOb4v4vZqS+v4iJ1XQfbUZV1AJhuQ
         5IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688227490; x=1690819490;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4NrrbMIWVozgtSvLA84h3/cDpaJWLVd0mnOoHMB+sk=;
        b=d+UnqTRJVBZjbftn3ils+sy7sYw4sEAZ9kqadu+TLwFSQFztac35qrYu4kTY/5fYC1
         ocRRAJawYbjj2esXg+vWeKhjudRsyeM0H9vVdYDNzf3ToepaHZQOub6zS/LXA1NHihx7
         bCMyCqMD3cYrvj9+fy2g4hyL57Gv1FK4wP6b+aGjURf6E0haEE/RbqFYuprDTfYZCSHl
         xjc03P8owYNtFlFbhhTRJUh41oO7K02ysGYPeuARDSVN9HfyYN3y2qzasijOmbtSBBXc
         STHFUnwc10mmtBCcAN9o8fqW1Psz88n0rtkYQ4W5vsM+azK2yLsjXQHCTuNGJo+vjRFV
         X7uQ==
X-Gm-Message-State: AC+VfDyT96g9hwr8CyZwAjYQlfDX6Y2JZNhcI3yuCJAbv23yim0/kR17
        kgnUGyW6JZtMme2xdrW5m68RE80mXvuLBJek241JIVRO
X-Google-Smtp-Source: ACHHUZ7L9ir2ym3t+zSpMqYdROoLnRZ7g48207Mz+7jPCBkhrBP2vFKpPC5Z3BymkTGld/Ifsr/fzA==
X-Received: by 2002:a05:6870:b604:b0:1b0:37a:97cf with SMTP id cm4-20020a056870b60400b001b0037a97cfmr7472834oab.43.1688227489548;
        Sat, 01 Jul 2023 09:04:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b00255d3bd5ce5sm15281735pjo.45.2023.07.01.09.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 09:04:48 -0700 (PDT)
Message-ID: <64a04ea0.170a0220.58ba5.e712@mx.google.com>
Date:   Sat, 01 Jul 2023 09:04:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.37
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
Subject: stable/linux-6.1.y baseline: 144 runs, 12 regressions (v6.1.37)
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

stable/linux-6.1.y baseline: 144 runs, 12 regressions (v6.1.37)

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

meson-gxbb-p200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.37/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.37
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      0f4ac6b4c5f00f45b7a429c8a5b028a598c6400c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a016f09328eaa7f0bb2a84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a016f09328eaa7f0bb2=
a85
        new failure (last pass: v6.1.36) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a016c160301da8c8bb2a84

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a016c160301da8c8bb2a89
        failing since 92 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T12:06:10.451772  <8>[   10.066881] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10974248_1.4.2.3.1>

    2023-07-01T12:06:10.455224  + set +x

    2023-07-01T12:06:10.563328  / # #

    2023-07-01T12:06:10.666049  export SHELL=3D/bin/sh

    2023-07-01T12:06:10.666833  #

    2023-07-01T12:06:10.768622  / # export SHELL=3D/bin/sh. /lava-10974248/=
environment

    2023-07-01T12:06:10.769559  =


    2023-07-01T12:06:10.871340  / # . /lava-10974248/environment/lava-10974=
248/bin/lava-test-runner /lava-10974248/1

    2023-07-01T12:06:10.872631  =


    2023-07-01T12:06:10.877883  / # /lava-10974248/bin/lava-test-runner /la=
va-10974248/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a016c3cb121cc0b2bb2a8f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a016c3cb121cc0b2bb2a94
        failing since 92 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T12:06:09.671970  + set<8>[   10.970173] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10974241_1.4.2.3.1>

    2023-07-01T12:06:09.672076   +x

    2023-07-01T12:06:09.776252  / # #

    2023-07-01T12:06:09.876880  export SHELL=3D/bin/sh

    2023-07-01T12:06:09.877090  #

    2023-07-01T12:06:09.977653  / # export SHELL=3D/bin/sh. /lava-10974241/=
environment

    2023-07-01T12:06:09.977884  =


    2023-07-01T12:06:10.078477  / # . /lava-10974241/environment/lava-10974=
241/bin/lava-test-runner /lava-10974241/1

    2023-07-01T12:06:10.078774  =


    2023-07-01T12:06:10.083099  / # /lava-10974241/bin/lava-test-runner /la=
va-10974241/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a016ad1758352943bb2a9d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a016ad1758352943bb2aa2
        failing since 92 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T12:05:48.242485  <8>[    7.787062] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10974214_1.4.2.3.1>

    2023-07-01T12:05:48.245727  + set +x

    2023-07-01T12:05:48.351020  #

    2023-07-01T12:05:48.352096  =


    2023-07-01T12:05:48.453767  / # #export SHELL=3D/bin/sh

    2023-07-01T12:05:48.454581  =


    2023-07-01T12:05:48.556278  / # export SHELL=3D/bin/sh. /lava-10974214/=
environment

    2023-07-01T12:05:48.556968  =


    2023-07-01T12:05:48.658336  / # . /lava-10974214/environment/lava-10974=
214/bin/lava-test-runner /lava-10974214/1

    2023-07-01T12:05:48.659476  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a0174c034a233eccbb2a83

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a0174c034a233eccbb2a88
        failing since 92 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T12:08:33.175779  + set +x

    2023-07-01T12:08:33.182144  <8>[   10.262862] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10974288_1.4.2.3.1>

    2023-07-01T12:08:33.290593  / # #

    2023-07-01T12:08:33.393391  export SHELL=3D/bin/sh

    2023-07-01T12:08:33.394284  #

    2023-07-01T12:08:33.496016  / # export SHELL=3D/bin/sh. /lava-10974288/=
environment

    2023-07-01T12:08:33.496853  =


    2023-07-01T12:08:33.598385  / # . /lava-10974288/environment/lava-10974=
288/bin/lava-test-runner /lava-10974288/1

    2023-07-01T12:08:33.599668  =


    2023-07-01T12:08:33.604396  / # /lava-10974288/bin/lava-test-runner /la=
va-10974288/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a016b76626c4c55bbb2a7f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a016b76626c4c55bbb2a84
        failing since 92 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T12:06:01.731191  + set<8>[   10.357183] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10974282_1.4.2.3.1>

    2023-07-01T12:06:01.731295   +x

    2023-07-01T12:06:01.832891  #

    2023-07-01T12:06:01.933774  / # #export SHELL=3D/bin/sh

    2023-07-01T12:06:01.933948  =


    2023-07-01T12:06:02.034432  / # export SHELL=3D/bin/sh. /lava-10974282/=
environment

    2023-07-01T12:06:02.034607  =


    2023-07-01T12:06:02.135155  / # . /lava-10974282/environment/lava-10974=
282/bin/lava-test-runner /lava-10974282/1

    2023-07-01T12:06:02.135480  =


    2023-07-01T12:06:02.140429  / # /lava-10974282/bin/lava-test-runner /la=
va-10974282/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a016bf0482e5bd4fbb2a78

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a016bf0482e5bd4fbb2a7d
        failing since 92 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T12:06:15.518478  + set<8>[   11.038298] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10974266_1.4.2.3.1>

    2023-07-01T12:06:15.519078   +x

    2023-07-01T12:06:15.627952  / # #

    2023-07-01T12:06:15.730067  export SHELL=3D/bin/sh

    2023-07-01T12:06:15.730729  #

    2023-07-01T12:06:15.831959  / # export SHELL=3D/bin/sh. /lava-10974266/=
environment

    2023-07-01T12:06:15.832158  =


    2023-07-01T12:06:15.932745  / # . /lava-10974266/environment/lava-10974=
266/bin/lava-test-runner /lava-10974266/1

    2023-07-01T12:06:15.934330  =


    2023-07-01T12:06:15.937911  / # /lava-10974266/bin/lava-test-runner /la=
va-10974266/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/64a0177cb9d30127ccbb2a87

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/arm=
64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/arm=
64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a0177cb9d30127ccbb2a8a
        new failure (last pass: v6.1.34)

    2023-07-01T12:09:23.383511  / # #
    2023-07-01T12:09:23.486247  export SHELL=3D/bin/sh
    2023-07-01T12:09:23.487068  #
    2023-07-01T12:09:23.588963  / # export SHELL=3D/bin/sh. /lava-367660/en=
vironment
    2023-07-01T12:09:23.589789  =

    2023-07-01T12:09:23.691612  / # . /lava-367660/environment/lava-367660/=
bin/lava-test-runner /lava-367660/1
    2023-07-01T12:09:23.692832  =

    2023-07-01T12:09:23.697608  / # /lava-367660/bin/lava-test-runner /lava=
-367660/1
    2023-07-01T12:09:23.762559  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-01T12:09:23.763042  + cd /l<8>[   14.450655] <LAVA_SIGNAL_START=
RUN 1_bootrr 367660_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/64a=
0177cb9d30127ccbb2a9a
        new failure (last pass: v6.1.34)

    2023-07-01T12:09:26.116983  /lava-367660/1/../bin/lava-test-case
    2023-07-01T12:09:26.117126  <8>[   16.899790] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-07-01T12:09:26.117226  /lava-367660/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a016b3ad01c5bb77bb2a86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a016b3ad01c5bb77bb2a8b
        failing since 92 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-01T12:06:04.373701  + set +x<8>[   12.203514] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10974234_1.4.2.3.1>

    2023-07-01T12:06:04.373809  =


    2023-07-01T12:06:04.478078  / # #

    2023-07-01T12:06:04.578766  export SHELL=3D/bin/sh

    2023-07-01T12:06:04.578986  #

    2023-07-01T12:06:04.679506  / # export SHELL=3D/bin/sh. /lava-10974234/=
environment

    2023-07-01T12:06:04.679706  =


    2023-07-01T12:06:04.780287  / # . /lava-10974234/environment/lava-10974=
234/bin/lava-test-runner /lava-10974234/1

    2023-07-01T12:06:04.780561  =


    2023-07-01T12:06:04.785093  / # /lava-10974234/bin/lava-test-runner /la=
va-10974234/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxbb-p200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64a01a07693d474655bb2aff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/arm=
64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/arm=
64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a01a07693d474655bb2=
b00
        new failure (last pass: v6.1.34) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64a01769daad0e9a06bb2ab5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/arm=
/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.37/arm=
/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a01769daad0e9a06bb2aba
        new failure (last pass: v6.1.34)

    2023-07-01T12:08:50.721451  <8>[   10.124171] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3705031_1.5.2.4.1>
    2023-07-01T12:08:50.842825  / # #
    2023-07-01T12:08:50.949656  export SHELL=3D/bin/sh
    2023-07-01T12:08:50.951295  #
    2023-07-01T12:08:51.054930  / # export SHELL=3D/bin/sh. /lava-3705031/e=
nvironment
    2023-07-01T12:08:51.056636  =

    2023-07-01T12:08:51.160246  / # . /lava-3705031/environment/lava-370503=
1/bin/lava-test-runner /lava-3705031/1
    2023-07-01T12:08:51.163143  =

    2023-07-01T12:08:51.181053  / # /lava-3705031/bin/lava-test-runner /lav=
a-3705031/1
    2023-07-01T12:08:51.333285  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20
