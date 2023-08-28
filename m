Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7397578B447
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 17:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjH1PUS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjH1PTv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 11:19:51 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4727111B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 08:19:34 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bca5d6dcedso2610116a34.1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693235973; x=1693840773;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf0b3lchyVrsCYqc6FoVN8J20m0XL8L9K2hRHgLpKwU=;
        b=K2KrhyzmtaFk+c6NqD6hPUTEkieJZEC61lleMUMufRXtNSahLThgREEbRFr3SsTPjQ
         WZ11gtCmlOaIwz85KWPr7nnIqxALDtmcX7lGNhthDSY2bYhyKanGtGGqCQlDAs+RmsAI
         oVIBi/5k8pqnYogI9RqAqbHTFM90gsB8LbFMekr/XYe3ppu/L6vZltfXQhIxNyUQmtWt
         waB4m5uo5fvdiofXM8089pkgjapwpgD8cbsudUxgNwRliwDERAs6NDkzMXxWf8e48PzG
         P8lUcfkS4ykQB7RjfoCzzqYazeik5dxXkR6F0UDNV7SMzGPJh9zEh9dQz7E34SfZ6uIZ
         K5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235973; x=1693840773;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lf0b3lchyVrsCYqc6FoVN8J20m0XL8L9K2hRHgLpKwU=;
        b=PTj5WobLGIRfurxabnNPSd7FPPxwELa9Da6Rm9wRcDQNCM8HmCmXX//5PWM2L2Zh6X
         UL/evxr4EatZduBwOYMWgnZYObM92EdZYYnyDCtl2uWUO/tZzeWzlrAfFBfkm4irTXv9
         N4CoY2ptbY3D1/pLdstMq6iepYnpuHCWR5CKmf5gwmpDqJxMSdiNbsSbHSQOHV4DegD6
         NtHoD9eND5uDGRRnk3ny4fPB2v3iCgqFuqD+2LofqdvS1M8uNTTE4vk7Jz4VKIOKxTVU
         zc9HbrPEXwFL+i//0jYmUjyz08umnRCe3Gj/5kgHNjDz8Z3ig/tFjVSPAwDgz+CPdw7L
         zEng==
X-Gm-Message-State: AOJu0Yz5AU6MZiJk1iKkqag+nAXjmAv9+qOF+RtywTi36j0dXxADrQ6D
        3OIwMzgu6r5KKAKELQnJaXMGeh5VgZk33b09k3I=
X-Google-Smtp-Source: AGHT+IE6pVQh5Zr804W6UacdXnIlvdXW+nVJ8c43Vdi7wrBeYzHtnAcOPokZyBAgemhYdTRylRje/g==
X-Received: by 2002:a05:6870:6391:b0:1be:ec3b:3ae1 with SMTP id t17-20020a056870639100b001beec3b3ae1mr12941499oap.50.1693235972991;
        Mon, 28 Aug 2023 08:19:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a1a1700b00263e4dc33aasm9684345pjk.11.2023.08.28.08.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:19:32 -0700 (PDT)
Message-ID: <64ecbb04.170a0220.5ee47.050a@mx.google.com>
Date:   Mon, 28 Aug 2023 08:19:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.192-85-gc40f751018f92
Subject: stable-rc/linux-5.10.y baseline: 127 runs,
 12 regressions (v5.10.192-85-gc40f751018f92)
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

stable-rc/linux-5.10.y baseline: 127 runs, 12 regressions (v5.10.192-85-gc4=
0f751018f92)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
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
nel/v5.10.192-85-gc40f751018f92/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.192-85-gc40f751018f92
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c40f751018f92a4de17117a9018b24e538e55b50 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec8aee71b0c83cde286d78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ec8aee71b0c83cde286=
d79
        new failure (last pass: v5.10.192-85-gdb025f893b6a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec8b98fb447fdb80286dc5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec8b98fb447fdb80286dce
        failing since 222 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-28T11:56:49.031453  + set +x<8>[   11.045803] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3754094_1.5.2.4.1>
    2023-08-28T11:56:49.031675  =

    2023-08-28T11:56:49.137770  / # #
    2023-08-28T11:56:49.239380  export SHELL=3D/bin/sh
    2023-08-28T11:56:49.239739  #
    2023-08-28T11:56:49.340927  / # export SHELL=3D/bin/sh. /lava-3754094/e=
nvironment
    2023-08-28T11:56:49.341294  =

    2023-08-28T11:56:49.442446  / # . /lava-3754094/environment/lava-375409=
4/bin/lava-test-runner /lava-3754094/1
    2023-08-28T11:56:49.443000  =

    2023-08-28T11:56:49.447667  / # /lava-3754094/bin/lava-test-runner /lav=
a-3754094/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec8a01eebfcafee9286dec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec8a01eebfcafee9286def
        failing since 41 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-28T11:50:05.095894  [   10.283507] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247193_1.5.2.4.1>
    2023-08-28T11:50:05.201129  =

    2023-08-28T11:50:05.302300  / # #export SHELL=3D/bin/sh
    2023-08-28T11:50:05.302821  =

    2023-08-28T11:50:05.403834  / # export SHELL=3D/bin/sh. /lava-1247193/e=
nvironment
    2023-08-28T11:50:05.404314  =

    2023-08-28T11:50:05.505353  / # . /lava-1247193/environment/lava-124719=
3/bin/lava-test-runner /lava-1247193/1
    2023-08-28T11:50:05.506399  =

    2023-08-28T11:50:05.510041  / # /lava-1247193/bin/lava-test-runner /lav=
a-1247193/1
    2023-08-28T11:50:05.532605  + export 'TESTRUN_[   10.719211] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1247193_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec8a16bfe1362531286d80

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec8a16bfe1362531286d83
        failing since 177 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-28T11:50:23.606690  [   10.666619] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247191_1.5.2.4.1>
    2023-08-28T11:50:23.711976  =

    2023-08-28T11:50:23.813224  / # #export SHELL=3D/bin/sh
    2023-08-28T11:50:23.813617  =

    2023-08-28T11:50:23.914602  / # export SHELL=3D/bin/sh. /lava-1247191/e=
nvironment
    2023-08-28T11:50:23.914996  =

    2023-08-28T11:50:24.016008  / # . /lava-1247191/environment/lava-124719=
1/bin/lava-test-runner /lava-1247191/1
    2023-08-28T11:50:24.016768  =

    2023-08-28T11:50:24.020683  / # /lava-1247191/bin/lava-test-runner /lav=
a-1247191/1
    2023-08-28T11:50:24.035210  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec88d8728edac772286d75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec88d8728edac772286d7e
        failing since 152 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-28T11:45:16.378473  + set +x

    2023-08-28T11:45:16.384704  <8>[   10.219032] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11371779_1.4.2.3.1>

    2023-08-28T11:45:16.488713  / # #

    2023-08-28T11:45:16.589322  export SHELL=3D/bin/sh

    2023-08-28T11:45:16.589554  #

    2023-08-28T11:45:16.690141  / # export SHELL=3D/bin/sh. /lava-11371779/=
environment

    2023-08-28T11:45:16.690408  =


    2023-08-28T11:45:16.790953  / # . /lava-11371779/environment/lava-11371=
779/bin/lava-test-runner /lava-11371779/1

    2023-08-28T11:45:16.791280  =


    2023-08-28T11:45:16.795712  / # /lava-11371779/bin/lava-test-runner /la=
va-11371779/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec88dba924d898be286d76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec88dba924d898be286d7f
        failing since 152 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-28T11:46:26.536727  + set +x

    2023-08-28T11:46:26.542784  <8>[   12.588049] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11371792_1.4.2.3.1>

    2023-08-28T11:46:26.644858  #

    2023-08-28T11:46:26.645116  =


    2023-08-28T11:46:26.745677  / # #export SHELL=3D/bin/sh

    2023-08-28T11:46:26.745882  =


    2023-08-28T11:46:26.846425  / # export SHELL=3D/bin/sh. /lava-11371792/=
environment

    2023-08-28T11:46:26.846632  =


    2023-08-28T11:46:26.947118  / # . /lava-11371792/environment/lava-11371=
792/bin/lava-test-runner /lava-11371792/1

    2023-08-28T11:46:26.947385  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec8a567ab60fb496286df6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec8a577ab60fb496286df9
        failing since 41 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-28T11:51:31.567394  + set +x
    2023-08-28T11:51:31.567974  <8>[   84.008856] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1002172_1.5.2.4.1>
    2023-08-28T11:51:31.679024  / # #
    2023-08-28T11:51:33.146999  export SHELL=3D/bin/sh
    2023-08-28T11:51:33.168457  #
    2023-08-28T11:51:33.169109  / # export SHELL=3D/bin/sh
    2023-08-28T11:51:35.131816  / # . /lava-1002172/environment
    2023-08-28T11:51:38.740503  /lava-1002172/bin/lava-test-runner /lava-10=
02172/1
    2023-08-28T11:51:38.762727  . /lava-1002172/environment
    2023-08-28T11:51:38.763239  / # /lava-1002172/bin/lava-test-runner /lav=
a-1002172/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec8a3ae3080abe44286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec8a3ae3080abe44286d6f
        failing since 41 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-28T11:50:56.702552  / # #
    2023-08-28T11:50:58.165276  export SHELL=3D/bin/sh
    2023-08-28T11:50:58.185855  #
    2023-08-28T11:50:58.186063  / # export SHELL=3D/bin/sh
    2023-08-28T11:51:00.142270  / # . /lava-1002164/environment
    2023-08-28T11:51:03.742311  /lava-1002164/bin/lava-test-runner /lava-10=
02164/1
    2023-08-28T11:51:03.762886  . /lava-1002164/environment
    2023-08-28T11:51:03.762994  / # /lava-1002164/bin/lava-test-runner /lav=
a-1002164/1
    2023-08-28T11:51:03.842198  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T11:51:03.842419  + cd /lava-1002164/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec8b167a971fbe6d286dc2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec8b167a971fbe6d286dc5
        failing since 41 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-28T11:54:39.508364  / # #
    2023-08-28T11:54:40.973048  export SHELL=3D/bin/sh
    2023-08-28T11:54:40.994135  #
    2023-08-28T11:54:40.994452  / # export SHELL=3D/bin/sh
    2023-08-28T11:54:42.951448  / # . /lava-1002174/environment
    2023-08-28T11:54:46.551362  /lava-1002174/bin/lava-test-runner /lava-10=
02174/1
    2023-08-28T11:54:46.572157  . /lava-1002174/environment
    2023-08-28T11:54:46.572286  / # /lava-1002174/bin/lava-test-runner /lav=
a-1002174/1
    2023-08-28T11:54:46.653140  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T11:54:46.653363  + cd /lava-1002174/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec962082bd771c07286d73

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec962082bd771c07286d7c
        failing since 41 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-28T12:43:23.997030  / # #

    2023-08-28T12:43:24.099253  export SHELL=3D/bin/sh

    2023-08-28T12:43:24.099977  #

    2023-08-28T12:43:24.201470  / # export SHELL=3D/bin/sh. /lava-11371832/=
environment

    2023-08-28T12:43:24.202181  =


    2023-08-28T12:43:24.303678  / # . /lava-11371832/environment/lava-11371=
832/bin/lava-test-runner /lava-11371832/1

    2023-08-28T12:43:24.304800  =


    2023-08-28T12:43:24.321221  / # /lava-11371832/bin/lava-test-runner /la=
va-11371832/1

    2023-08-28T12:43:24.370636  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T12:43:24.371148  + cd /lav<8>[   16.395267] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11371832_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec89d1363a83894e286db4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec89d1363a83894e286dbd
        failing since 3 days (last pass: v5.10.191, first fail: v5.10.190-1=
36-gda59b7b5c515e)

    2023-08-28T11:49:15.392593  / # #

    2023-08-28T11:49:16.653867  export SHELL=3D/bin/sh

    2023-08-28T11:49:16.664832  #

    2023-08-28T11:49:16.665303  / # export SHELL=3D/bin/sh

    2023-08-28T11:49:18.409571  / # . /lava-11371837/environment

    2023-08-28T11:49:21.615059  /lava-11371837/bin/lava-test-runner /lava-1=
1371837/1

    2023-08-28T11:49:21.626508  . /lava-11371837/environment

    2023-08-28T11:49:21.627167  / # /lava-11371837/bin/lava-test-runner /la=
va-11371837/1

    2023-08-28T11:49:21.681386  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T11:49:21.681878  + cd /lava-11371837/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec89a170944e182d286d84

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92-85-gc40f751018f92/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec89a170944e182d286d8d
        failing since 41 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-28T11:50:13.872126  / # #

    2023-08-28T11:50:13.974195  export SHELL=3D/bin/sh

    2023-08-28T11:50:13.974550  #

    2023-08-28T11:50:14.075226  / # export SHELL=3D/bin/sh. /lava-11371833/=
environment

    2023-08-28T11:50:14.075587  =


    2023-08-28T11:50:14.176234  / # . /lava-11371833/environment/lava-11371=
833/bin/lava-test-runner /lava-11371833/1

    2023-08-28T11:50:14.176523  =


    2023-08-28T11:50:14.179509  / # /lava-11371833/bin/lava-test-runner /la=
va-11371833/1

    2023-08-28T11:50:14.247710  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T11:50:14.247853  + cd /lava-1137183<8>[   18.296670] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11371833_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
