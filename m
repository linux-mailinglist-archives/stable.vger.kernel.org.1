Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0315278A386
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 01:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjH0XoB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 19:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjH0Xni (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 19:43:38 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B581FEA
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 16:43:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4109c8ece5aso18996421cf.1
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693179812; x=1693784612;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2MsB6g0xHAAoMx5mVBOTYqJrqETVNfghuqDDvE0wrkc=;
        b=3b72NpgvLocyfuMT9pwR0s230oChcfnBGB3NcRb5tBJ6eAAYoYASOtO4V046R6YmB8
         RhgNwYmnSrqSDvWRm3vV8TXjJinoVJgC7JJqkdt+98UEBL4Jhs+s3Cih6dgQgpajZWw1
         kPEfcX8a2wXlBlaFRspjsKXLCuu/INL3yPFPcEoClH6r0f62Kb6XIk5qpfdpWbWoLGte
         EnszAbJy3vjhLaDbodvsLsLFFwR1ffeYlISqueTmjYXle50+S4y4hPVnM7jROqc1fYHK
         e7pyh7X73Scp2U6r2JxSHImHok6CzV5j6Pkxrq+97PDOTyRxZc6RI+LcQIYH/fjWT+z1
         b+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179812; x=1693784612;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MsB6g0xHAAoMx5mVBOTYqJrqETVNfghuqDDvE0wrkc=;
        b=h7gOfLzn2+JUYEX1Q5Jy4KAufwSANdQWgTAaQdnAz2D4m1RsjGqSBa/4+D6zt1PjCh
         ybBN4kvlAL6IjKNHgFpISph2FQ622ru5hgjimDiedri7+PK1ZyRncr8rb+ZomEBOLAhK
         J/fpChv5cB1EsJ4nt3yZuKgPAGRMF/R1O1uGf1H5s7U3smB1cYn3F4Fy5WOk34iuzn/X
         qcYtqeVbfxuNY5nB5LwMbzXur1DP71XtjAPZ8vURjcHK/8qRXUV48ZdLLIfAVvX0yjlD
         XyzSdrP9tf+CmZ/qOKoZ+Qd/kd4PxkALIgOsyGk87H4Xv1qISk0aBNXUU2wR5Quw7Oj8
         bXEQ==
X-Gm-Message-State: AOJu0YyLy5hQr1JoTJ+w8C4B4s2gQUPlzMaVZK3WUwfQIDTnW0nS4EtZ
        p3IReY87LLVJTSme1Wc1OoF2rUszPUxiyLZQIUs=
X-Google-Smtp-Source: AGHT+IG9x5b4tbV74TnvBbscszWdjIMdolQ0EiqwkRAjdLsh8fPPvEzgudkse9RU0RU6XW4R+cGFLg==
X-Received: by 2002:a05:620a:4501:b0:76c:9427:5c54 with SMTP id t1-20020a05620a450100b0076c94275c54mr29423586qkp.27.1693179811920;
        Sun, 27 Aug 2023 16:43:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bd10-20020a170902830a00b001bc56c1a384sm5761398plb.277.2023.08.27.16.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:43:31 -0700 (PDT)
Message-ID: <64ebdfa3.170a0220.f522a.8ec5@mx.google.com>
Date:   Sun, 27 Aug 2023 16:43:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.49
Subject: stable/linux-6.1.y baseline: 124 runs, 14 regressions (v6.1.49)
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

stable/linux-6.1.y baseline: 124 runs, 14 regressions (v6.1.49)

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

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
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

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.49/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.49
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      024f76bca9d0e29513fa99e1cd0f86bfa841743b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebaac2cc0e614671286da6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebaac2cc0e614671286=
da7
        new failure (last pass: v6.1.48) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebaa9956013470c0286d7c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebaa9956013470c0286d85
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-27T19:57:18.153947  <8>[   10.031314] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11367491_1.4.2.3.1>

    2023-08-27T19:57:18.157375  + set +x

    2023-08-27T19:57:18.264155  / # #

    2023-08-27T19:57:18.366726  export SHELL=3D/bin/sh

    2023-08-27T19:57:18.367565  #

    2023-08-27T19:57:18.469223  / # export SHELL=3D/bin/sh. /lava-11367491/=
environment

    2023-08-27T19:57:18.469997  =


    2023-08-27T19:57:18.571593  / # . /lava-11367491/environment/lava-11367=
491/bin/lava-test-runner /lava-11367491/1

    2023-08-27T19:57:18.572807  =


    2023-08-27T19:57:18.579498  / # /lava-11367491/bin/lava-test-runner /la=
va-11367491/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebab8da0bf3193ef286d9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523=
NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523=
NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebab8da0bf3193ef286=
da0
        new failure (last pass: v6.1.48) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebaa92cb94bf2902286d9c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebaa92cb94bf2902286da5
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-27T19:56:52.582416  + set<8>[   11.532573] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11367502_1.4.2.3.1>

    2023-08-27T19:56:52.582525   +x

    2023-08-27T19:56:52.686634  / # #

    2023-08-27T19:56:52.787224  export SHELL=3D/bin/sh

    2023-08-27T19:56:52.787374  #

    2023-08-27T19:56:52.887881  / # export SHELL=3D/bin/sh. /lava-11367502/=
environment

    2023-08-27T19:56:52.888020  =


    2023-08-27T19:56:52.988491  / # . /lava-11367502/environment/lava-11367=
502/bin/lava-test-runner /lava-11367502/1

    2023-08-27T19:56:52.988861  =


    2023-08-27T19:56:52.993544  / # /lava-11367502/bin/lava-test-runner /la=
va-11367502/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebaa9dcb94bf2902286dcf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebaa9dcb94bf2902286dd8
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-27T19:57:03.626930  <8>[   10.868621] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11367524_1.4.2.3.1>

    2023-08-27T19:57:03.629943  + set +x

    2023-08-27T19:57:03.734623  #

    2023-08-27T19:57:03.735751  =


    2023-08-27T19:57:03.837694  / # #export SHELL=3D/bin/sh

    2023-08-27T19:57:03.838538  =


    2023-08-27T19:57:03.940075  / # export SHELL=3D/bin/sh. /lava-11367524/=
environment

    2023-08-27T19:57:03.940861  =


    2023-08-27T19:57:04.042495  / # . /lava-11367524/environment/lava-11367=
524/bin/lava-test-runner /lava-11367524/1

    2023-08-27T19:57:04.043796  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebafa11a5d929ba0286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebafa11a5d929ba0286=
d6d
        failing since 4 days (last pass: v6.1.46, first fail: v6.1.47) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebaa9bebd7b54508286d6f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebaa9bebd7b54508286d78
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-27T19:57:02.367344  + set +x

    2023-08-27T19:57:02.374270  <8>[   10.898972] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11367506_1.4.2.3.1>

    2023-08-27T19:57:02.482298  / # #

    2023-08-27T19:57:02.585085  export SHELL=3D/bin/sh

    2023-08-27T19:57:02.585882  #

    2023-08-27T19:57:02.687388  / # export SHELL=3D/bin/sh. /lava-11367506/=
environment

    2023-08-27T19:57:02.688127  =


    2023-08-27T19:57:02.789634  / # . /lava-11367506/environment/lava-11367=
506/bin/lava-test-runner /lava-11367506/1

    2023-08-27T19:57:02.790753  =


    2023-08-27T19:57:02.795775  / # /lava-11367506/bin/lava-test-runner /la=
va-11367506/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebaa7faa85a467e8286d85

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebaa7faa85a467e8286d8e
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-27T19:56:36.349936  <8>[   10.271419] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11367529_1.4.2.3.1>

    2023-08-27T19:56:36.353136  + set +x

    2023-08-27T19:56:36.454488  =


    2023-08-27T19:56:36.555022  / # #export SHELL=3D/bin/sh

    2023-08-27T19:56:36.555283  =


    2023-08-27T19:56:36.655815  / # export SHELL=3D/bin/sh. /lava-11367529/=
environment

    2023-08-27T19:56:36.656001  =


    2023-08-27T19:56:36.756572  / # . /lava-11367529/environment/lava-11367=
529/bin/lava-test-runner /lava-11367529/1

    2023-08-27T19:56:36.756876  =


    2023-08-27T19:56:36.761975  / # /lava-11367529/bin/lava-test-runner /la=
va-11367529/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebaa91cb94bf2902286d86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebaa91cb94bf2902286d8f
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-27T19:56:50.964850  + <8>[   11.518676] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11367497_1.4.2.3.1>

    2023-08-27T19:56:50.964937  set +x

    2023-08-27T19:56:51.069656  / # #

    2023-08-27T19:56:51.170284  export SHELL=3D/bin/sh

    2023-08-27T19:56:51.170440  #

    2023-08-27T19:56:51.270967  / # export SHELL=3D/bin/sh. /lava-11367497/=
environment

    2023-08-27T19:56:51.271111  =


    2023-08-27T19:56:51.371622  / # . /lava-11367497/environment/lava-11367=
497/bin/lava-test-runner /lava-11367497/1

    2023-08-27T19:56:51.371875  =


    2023-08-27T19:56:51.376204  / # /lava-11367497/bin/lava-test-runner /la=
va-11367497/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebac3758ffaba429286d81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/arm=
64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/arm=
64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebac3758ffaba429286=
d82
        new failure (last pass: v6.1.48) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebaa77cc7dc35023286d92

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebaa77cc7dc35023286d9b
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-27T19:56:27.132808  + set<8>[   12.303463] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11367503_1.4.2.3.1>

    2023-08-27T19:56:27.132912   +x

    2023-08-27T19:56:27.237363  / # #

    2023-08-27T19:56:27.337874  export SHELL=3D/bin/sh

    2023-08-27T19:56:27.338033  #

    2023-08-27T19:56:27.438564  / # export SHELL=3D/bin/sh. /lava-11367503/=
environment

    2023-08-27T19:56:27.438730  =


    2023-08-27T19:56:27.539328  / # . /lava-11367503/environment/lava-11367=
503/bin/lava-test-runner /lava-11367503/1

    2023-08-27T19:56:27.539607  =


    2023-08-27T19:56:27.544421  / # /lava-11367503/bin/lava-test-runner /la=
va-11367503/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebab7fe0e15f997b286e9c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebab80e0e15f997b286ea5
        failing since 39 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-27T20:02:31.946798  / # #

    2023-08-27T20:02:32.048941  export SHELL=3D/bin/sh

    2023-08-27T20:02:32.049640  #

    2023-08-27T20:02:32.150898  / # export SHELL=3D/bin/sh. /lava-11367543/=
environment

    2023-08-27T20:02:32.151571  =


    2023-08-27T20:02:32.252947  / # . /lava-11367543/environment/lava-11367=
543/bin/lava-test-runner /lava-11367543/1

    2023-08-27T20:02:32.254027  =


    2023-08-27T20:02:32.270923  / # /lava-11367543/bin/lava-test-runner /la=
va-11367543/1

    2023-08-27T20:02:32.318885  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-27T20:02:32.319396  + cd /lav<8>[   19.110490] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11367543_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebaba2a0d397c3a0286dab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebaba2a0d397c3a0286db4
        failing since 39 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-27T20:02:33.776270  / # #

    2023-08-27T20:02:34.857107  export SHELL=3D/bin/sh

    2023-08-27T20:02:34.859004  #

    2023-08-27T20:02:36.350706  / # export SHELL=3D/bin/sh. /lava-11367552/=
environment

    2023-08-27T20:02:36.352446  =


    2023-08-27T20:02:39.077454  / # . /lava-11367552/environment/lava-11367=
552/bin/lava-test-runner /lava-11367552/1

    2023-08-27T20:02:39.079963  =


    2023-08-27T20:02:39.082836  / # /lava-11367552/bin/lava-test-runner /la=
va-11367552/1

    2023-08-27T20:02:39.147429  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-27T20:02:39.147962  + cd /lava-<8>[   28.480486] <LAVA_SIGNAL_S=
TARTRUN 1_bootrr 11367552_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebab94a0bf3193ef286dde

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.49/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebab94a0bf3193ef286de7
        failing since 39 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-27T20:02:41.498559  / # #

    2023-08-27T20:02:41.600680  export SHELL=3D/bin/sh

    2023-08-27T20:02:41.601458  #

    2023-08-27T20:02:41.702823  / # export SHELL=3D/bin/sh. /lava-11367553/=
environment

    2023-08-27T20:02:41.703565  =


    2023-08-27T20:02:41.805041  / # . /lava-11367553/environment/lava-11367=
553/bin/lava-test-runner /lava-11367553/1

    2023-08-27T20:02:41.806243  =


    2023-08-27T20:02:41.823251  / # /lava-11367553/bin/lava-test-runner /la=
va-11367553/1

    2023-08-27T20:02:41.889190  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-27T20:02:41.889728  + cd /lava-11367553/1/tests/1_boot<8>[   16=
.926659] <LAVA_SIGNAL_STARTRUN 1_bootrr 11367553_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
