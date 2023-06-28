Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3C741491
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjF1PHF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjF1PHA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 11:07:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540810FD
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 08:06:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b7ef3e74edso91375ad.0
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687964818; x=1690556818;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rh+7ynVDZBRP2gG/JxrfXVe19qk5OGZyo+DZmbzehIQ=;
        b=aJ8aLUHhSs1sPVstDA+G4ABSsEmeZPxoneahyGk38PnTTbjwUew18PvT7Pyxhx7rN6
         E8sV5Fxw8CLsPZl5eEPvwkyg63TTcXqJcO8N743ksexrj9fFPUavXXRRnUZQFKAqN9OU
         9MC+TdGjonyOAg3zDryW7kJq0r6hi4SXUrFJByCs0S/kkbn6iDx41Hq5PcxLPXFpuDf1
         7PIW4DK7F/Vdg8XeYfgY0e9JixR2c/orO4RW+MsphLHn4l6sZ58Qk/Bme6a+VUDVmqR0
         H/lrmzvZPItScJTQJLn364Lyc/5a1j0tBCG4dhqDTSkBccg7rPvUQ1nVET0jPs7wpKdg
         juTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964818; x=1690556818;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rh+7ynVDZBRP2gG/JxrfXVe19qk5OGZyo+DZmbzehIQ=;
        b=TbmZS45VWheTgZNyZjq4NjSK1/b5UsVGpTVN7nfGyPIfgn4Wkvq1ODixmQuC22V/CG
         9qnMB7iESM7xBgxnmYkjjyea16aD8OHzkwyaf2SNOfOfiF218oobOjSwblr3u3kHvstk
         w4td+FOz4jAGN/6qwPtPhSKvoLHWcT4Oj5YLVFNE2fvB6Mn0MqoL4KrbM8qCigGobmP4
         8G8RqE72FU22wzNqFF4kBTLwOle++UEq+a6I0UuHQYEYNKKVQXa6U8swUKLWzRJHa5nO
         VHY7JX+7LCGxxDv80MLx2iiRlmKj0OC8spOt5xcPRlsbnAD+Mgw0o6jAi0XXJOQ4N6QT
         EWMg==
X-Gm-Message-State: AC+VfDwlmFW92XlAj4C4euQJ5w8JbGTU+OVwqdcaOgUYr8tskN+p+0fh
        WzJ15gDSEcW2fr+aUsAj93jaKBhDLQXyaqnsT7+mzA==
X-Google-Smtp-Source: ACHHUZ4MOyO8ooNVHUxR9lOMK6Ra1LO/9Ij8Bk/1cFdRTVOInG5z2TlXZ2/h0mgdpS9KnAIeD5JQUQ==
X-Received: by 2002:a17:903:24d:b0:1b1:99c9:8ce1 with SMTP id j13-20020a170903024d00b001b199c98ce1mr10100212plh.51.1687964817253;
        Wed, 28 Jun 2023 08:06:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902ed4900b001b83dc8649dsm1381249plb.250.2023.06.28.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:06:56 -0700 (PDT)
Message-ID: <649c4c90.170a0220.bc39.2849@mx.google.com>
Date:   Wed, 28 Jun 2023 08:06:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Kernel: v5.4.249
Subject: stable-rc/linux-5.4.y baseline: 116 runs, 17 regressions (v5.4.249)
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

stable-rc/linux-5.4.y baseline: 116 runs, 17 regressions (v5.4.249)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.249/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.249
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b30db4f7e45f3c17cca2ba5be6f22762837a6e34 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c14834066a81fafd7d606

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/649c14834066a81f=
afd7d60b
        failing since 252 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-06-28T11:07:25.348726  / # =

    2023-06-28T11:07:25.349609  =

    2023-06-28T11:07:27.413905  / # #
    2023-06-28T11:07:27.415195  #
    2023-06-28T11:07:29.425802  / # export SHELL=3D/bin/sh
    2023-06-28T11:07:29.426238  export SHELL=3D/bin/sh
    2023-06-28T11:07:31.442027  / # . /lava-3697270/environment
    2023-06-28T11:07:31.442448  . /lava-3697270/environment
    2023-06-28T11:07:33.457696  / # /lava-3697270/bin/lava-test-runner /lav=
a-3697270/0
    2023-06-28T11:07:33.459430  /lava-3697270/bin/lava-test-runner /lava-36=
97270/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16770753a47e2ad7d60c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c16770753a47e2ad7d615
        failing since 89 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-06-28T11:15:49.738229  + set<8>[   10.294897] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10936519_1.4.2.3.1>

    2023-06-28T11:15:49.738353   +x

    2023-06-28T11:15:49.840295  =


    2023-06-28T11:15:49.940931  / # #export SHELL=3D/bin/sh

    2023-06-28T11:15:49.941141  =


    2023-06-28T11:15:50.041658  / # export SHELL=3D/bin/sh. /lava-10936519/=
environment

    2023-06-28T11:15:50.041857  =


    2023-06-28T11:15:50.142408  / # . /lava-10936519/environment/lava-10936=
519/bin/lava-test-runner /lava-10936519/1

    2023-06-28T11:15:50.142688  =


    2023-06-28T11:15:50.147346  / # /lava-10936519/bin/lava-test-runner /la=
va-10936519/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c164a04309b4c85d7d5fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c164a04309b4c85d7d607
        failing since 89 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-06-28T11:15:08.180320  + set +x

    2023-06-28T11:15:08.186682  <8>[   12.882369] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10936486_1.4.2.3.1>

    2023-06-28T11:15:08.293962  / # #

    2023-06-28T11:15:08.396595  export SHELL=3D/bin/sh

    2023-06-28T11:15:08.397397  #

    2023-06-28T11:15:08.498781  / # export SHELL=3D/bin/sh. /lava-10936486/=
environment

    2023-06-28T11:15:08.499506  =


    2023-06-28T11:15:08.601225  / # . /lava-10936486/environment/lava-10936=
486/bin/lava-test-runner /lava-10936486/1

    2023-06-28T11:15:08.602442  =


    2023-06-28T11:15:08.607955  / # /lava-10936486/bin/lava-test-runner /la=
va-10936486/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16db48dd7fb803d7d60e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16db48dd7fb803d7d=
60f
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16ece420d37717d7d606

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16ece420d37717d7d=
607
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16b61f16bc1143d7d5ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16b71f16bc1143d7d=
5ed
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16dccab7797328d7d606

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16dccab7797328d7d=
607
        failing since 330 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1700d7d786b3e0d7d62c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c1700d7d786b3e0d7d=
62d
        failing since 330 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16b6858b53e184d7d622

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16b6858b53e184d7d=
623
        failing since 330 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16dfe420d37717d7d5e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16dfe420d37717d7d=
5e8
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1764a626067a6dd7d5f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c1764a626067a6dd7d=
5f1
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16b7858b53e184d7d630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16b7858b53e184d7d=
631
        failing since 328 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16dde420d37717d7d5e1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16dde420d37717d7d=
5e2
        failing since 317 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-258-ge86027f8111f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1702e420d37717d7d62c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c1702e420d37717d7d=
62d
        failing since 317 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-258-ge86027f8111f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c16b73ba8f89559d7d618

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c16b73ba8f89559d7d=
619
        failing since 317 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-258-ge86027f8111f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/649c166a0e0d072b82d7d61a

  Results:     82 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-=
kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-=
kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/649c166a0e0d072b82d7d624
        failing since 106 days (last pass: v5.4.235, first fail: v5.4.235-4=
-gb829e8b6e1a7)

    2023-06-28T11:15:44.456608  /lava-10936374/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/649c166a0e0d072b82d7d625
        failing since 106 days (last pass: v5.4.235, first fail: v5.4.235-4=
-gb829e8b6e1a7)

    2023-06-28T11:15:43.433764  /lava-10936374/1/../bin/lava-test-case

    2023-06-28T11:15:43.442501  <8>[   32.569283] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20
