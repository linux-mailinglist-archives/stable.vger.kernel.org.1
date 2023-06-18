Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97E9734879
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 23:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjFRVBE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 17:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFRVBD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 17:01:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D739FCC
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 14:01:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b51488ad67so13188245ad.3
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 14:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687122060; x=1689714060;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bJWrjhb13LgFIcrUAqsITMZQXf7F/aydds6RclCAI1I=;
        b=cvPWukEfd9CjCncIc4vNUCTGrb2u/Dl2Gmur61B5JBWkn0AJnC+iSkrPAZT1lP0Kac
         CM0h02TOs+uTsooYA1P9JqXj8xnzT8OCEx8gelbPg9cCKfwVYk6AYdyAZoc0X879J0K9
         RWfKklwqhyoMqtF0aMoeqxxnZsclVIIGnESqEYNOqo1JarJHWx3vGRwpJ6Xy4ThGKtv3
         h+FH9ccx99LwbkQ7FDmKmt+jlvgit9WquggDbVIVFS5FkrsJK5NZlTICmoloQJnelPwI
         T72iuiFixSEKtBjRiOyJJWtV+8DnpiavWGdsTmnIwUVqPjNgGlPHsSHIZNIb6mJ0qWWP
         YgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687122060; x=1689714060;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJWrjhb13LgFIcrUAqsITMZQXf7F/aydds6RclCAI1I=;
        b=ECqKyAsaHMJ+pxVPbY/NEcVudRCBg6GJ27lDjWKfrHs6QUVEIMCVcp/kkNTiUymCjU
         cXXOuw0af6bYmIJjp/yNsgwyY1A4bwYKuIzB6+Q+TsK2nksaxDa31SvTuPDp3Ik9ldh5
         coZLxxANogJ3a7czF6gRsNCYWMNs/X8GzJjaCFQR/PC1BHuynop6f94RIew6eAfkPo2d
         BspdNYh9CD4sAhbk8SY9VwEd+71U91Si3BPHH3hFVM1l8si+fXIPLWuUZJRcHI7acoLZ
         iPOfG2+t7WaiLCT4yGBdHY4SsVcnIjQyrz2HwtudWLUgMWgxddxk7QrefsdAyLa145x/
         +v1A==
X-Gm-Message-State: AC+VfDzub2Qy56CgoKuZLHqqvqMm6wOnqrTgbRgrOt1wkYJTqludEFxv
        C4khoCgqPyzY1WEw8uw4D6l/ZXab813rJP3UND4A80P/
X-Google-Smtp-Source: ACHHUZ7V4OjUD/TvHTsLwFOsFJjnx1QD0kXFYaH297COdgaJGqRNZagR25IMnm4UY64KNQFZZpSlqw==
X-Received: by 2002:a17:902:ea83:b0:1b0:7c3c:31f9 with SMTP id x3-20020a170902ea8300b001b07c3c31f9mr6199359plb.53.1687122059333;
        Sun, 18 Jun 2023 14:00:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b001b3df595582sm4577167plb.124.2023.06.18.14.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 14:00:58 -0700 (PDT)
Message-ID: <648f708a.170a0220.b1757.7788@mx.google.com>
Date:   Sun, 18 Jun 2023 14:00:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.4.247-61-g952936ff81a6
Subject: stable-rc/linux-5.4.y baseline: 144 runs,
 21 regressions (v5.4.247-61-g952936ff81a6)
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

stable-rc/linux-5.4.y baseline: 144 runs, 21 regressions (v5.4.247-61-g9529=
36ff81a6)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | multi_v5=
_defconfig           | 1          =

hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a7795-salvator-x           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.247-61-g952936ff81a6/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.247-61-g952936ff81a6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      952936ff81a60f61f5cb21cd02076e396109eaf8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648f387bee36d6f74f30612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubie=
truck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubie=
truck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f387bee36d6f74f306133
        failing since 152 days (last pass: v5.4.226-68-g8c05f5e0777d, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-06-18T17:01:26.311298  <8>[    9.822962] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3673305_1.5.2.4.1>
    2023-06-18T17:01:26.422279  / # #
    2023-06-18T17:01:26.524111  export SHELL=3D/bin/sh
    2023-06-18T17:01:26.524581  #
    2023-06-18T17:01:26.626461  / # export SHELL=3D/bin/sh. /lava-3673305/e=
nvironment
    2023-06-18T17:01:26.626981  =

    2023-06-18T17:01:26.728461  / # . /lava-3673305/environment/lava-367330=
5/bin/lava-test-runner /lava-3673305/1
    2023-06-18T17:01:26.731357  =

    2023-06-18T17:01:26.735310  / # /lava-3673305/bin/lava-test-runner /lav=
a-3673305/1
    2023-06-18T17:01:26.819573  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648f36f76b0ec4ab5030614f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da850=
-lcdk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da850=
-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f36f76b0ec4ab50306154
        failing since 152 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-06-18T16:55:04.563089  / # #
    2023-06-18T16:55:04.666555  export SHELL=3D/bin/sh
    2023-06-18T16:55:04.667593  #
    2023-06-18T16:55:04.769876  / # export SHELL=3D/bin/sh. /lava-3673282/e=
nvironment
    2023-06-18T16:55:04.770981  =

    2023-06-18T16:55:04.874744  / # . /lava-3673282/environment/lava-367328=
2/bin/lava-test-runner /lava-3673282/1
    2023-06-18T16:55:04.877269  =

    2023-06-18T16:55:04.884977  / # /lava-3673282/bin/lava-test-runner /lav=
a-3673282/1
    2023-06-18T16:55:05.132289  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-18T16:55:05.135590  + cd /lava-3673282/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f378e301a8b30e0306147

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unlea=
shed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unlea=
shed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/648f378e301a8b30=
e0306150
        failing since 242 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-06-18T16:57:29.111273  / # =

    2023-06-18T16:57:29.112856  =

    2023-06-18T16:57:31.175227  / # #
    2023-06-18T16:57:31.175878  #
    2023-06-18T16:57:33.190439  / # export SHELL=3D/bin/sh
    2023-06-18T16:57:33.190892  export SHELL=3D/bin/sh
    2023-06-18T16:57:35.206236  / # . /lava-3673291/environment
    2023-06-18T16:57:35.206654  . /lava-3673291/environment
    2023-06-18T16:57:37.222137  / # /lava-3673291/bin/lava-test-runner /lav=
a-3673291/0
    2023-06-18T16:57:37.224262  /lava-3673291/bin/lava-test-runner /lava-36=
73291/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f37e48545b6d549306136

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f37e48545b6d54930613b
        failing since 80 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-06-18T16:58:59.878741  + set<8>[   11.913402] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10795741_1.4.2.3.1>

    2023-06-18T16:58:59.879289   +x

    2023-06-18T16:58:59.987189  #

    2023-06-18T16:58:59.988440  =


    2023-06-18T16:59:00.090462  / # #export SHELL=3D/bin/sh

    2023-06-18T16:59:00.091089  =


    2023-06-18T16:59:00.192324  / # export SHELL=3D/bin/sh. /lava-10795741/=
environment

    2023-06-18T16:59:00.192710  =


    2023-06-18T16:59:00.293576  / # . /lava-10795741/environment/lava-10795=
741/bin/lava-test-runner /lava-10795741/1

    2023-06-18T16:59:00.294805  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f37e68545b6d549306146

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f37e68545b6d54930614b
        failing since 80 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-06-18T16:59:00.204820  <8>[   13.318730] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10795800_1.4.2.3.1>

    2023-06-18T16:59:00.208135  + set +x

    2023-06-18T16:59:00.313795  #

    2023-06-18T16:59:00.314843  =


    2023-06-18T16:59:00.416416  / # #export SHELL=3D/bin/sh

    2023-06-18T16:59:00.417129  =


    2023-06-18T16:59:00.518521  / # export SHELL=3D/bin/sh. /lava-10795800/=
environment

    2023-06-18T16:59:00.519195  =


    2023-06-18T16:59:00.620688  / # . /lava-10795800/environment/lava-10795=
800/bin/lava-test-runner /lava-10795800/1

    2023-06-18T16:59:00.622060  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3720618420e3af30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f3720618420e3af306=
12f
        failing since 299 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f37585e3b587458306154

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f37585e3b587458306=
155
        failing since 299 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3716a9722cb066306134

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f3716a9722cb066306=
135
        failing since 299 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f371fba26557af2306169

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f371fba26557af2306=
16a
        failing since 320 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3757998a5f70c7306137

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f3757998a5f70c7306=
138
        failing since 320 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3703c42da17c9a306153

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f3703c42da17c9a306=
154
        failing since 320 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3723618420e3af30613d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f3723618420e3af306=
13e
        failing since 319 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f37cf2fbb598638306150

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f37cf2fbb598638306=
151
        failing since 319 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3718a9722cb066306140

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f3718a9722cb066306=
141
        failing since 319 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3722618420e3af30613a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f3722618420e3af306=
13b
        failing since 299 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f377f18706d5fe4306141

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-vi=
rt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f377f18706d5fe4306=
142
        failing since 299 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3717a9722cb06630613a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f3717a9722cb066306=
13b
        failing since 299 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7795-salvator-x           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f364de89e571b0f30613d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-salv=
ator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-salv=
ator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f364de89e571b0f306142
        failing since 51 days (last pass: v5.4.217, first fail: v5.4.238-24=
5-g14f076931beb)

    2023-06-18T16:52:24.198562  + set +x
    2023-06-18T16:52:24.201687  <8>[   68.972495] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3673246_1.5.2.4.1>
    2023-06-18T16:52:24.306808  / # #
    2023-06-18T16:52:24.408749  export SHELL=3D/bin/sh
    2023-06-18T16:52:24.409237  #
    2023-06-18T16:52:24.510628  / # export SHELL=3D/bin/sh. /lava-3673246/e=
nvironment
    2023-06-18T16:52:24.511155  =

    2023-06-18T16:52:24.612579  / # . /lava-3673246/environment/lava-367324=
6/bin/lava-test-runner /lava-3673246/1
    2023-06-18T16:52:24.613381  =

    2023-06-18T16:52:24.616911  / # /lava-3673246/bin/lava-test-runner /lav=
a-3673246/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f364ee89e571b0f306148

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock6=
4.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock6=
4.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f364ee89e571b0f306=
149
        failing since 51 days (last pass: v5.4.224-157-g3e1fbfce73e5, first=
 fail: v5.4.238-245-g14f076931beb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f38cf15df53f98b30617e

  Results:     32 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f38cf15df53f98b3061a8
        failing since 151 days (last pass: v5.4.226-68-g97ed976894df, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-06-18T17:02:39.236192  <8>[   16.692775] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3673254_1.5.2.4.1>
    2023-06-18T17:02:39.355976  / # #
    2023-06-18T17:02:39.461559  export SHELL=3D/bin/sh
    2023-06-18T17:02:39.463062  #
    2023-06-18T17:02:39.566370  / # export SHELL=3D/bin/sh. /lava-3673254/e=
nvironment
    2023-06-18T17:02:39.567870  =

    2023-06-18T17:02:39.671311  / # . /lava-3673254/environment/lava-367325=
4/bin/lava-test-runner /lava-3673254/1
    2023-06-18T17:02:39.674063  =

    2023-06-18T17:02:39.677273  / # /lava-3673254/bin/lava-test-runner /lav=
a-3673254/1
    2023-06-18T17:02:39.709722  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648f362961f852d75f306194

  Results:     32 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pi=
ne64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.247=
-61-g952936ff81a6/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pi=
ne64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f362961f852d75f3061bc
        failing since 151 days (last pass: v5.4.226-68-g97ed976894df, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-06-18T16:51:29.071384  <8>[   16.664640] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 626715_1.5.2.4.1>
    2023-06-18T16:51:29.177479  / # #
    2023-06-18T16:51:29.279191  export SHELL=3D/bin/sh
    2023-06-18T16:51:29.279754  #
    2023-06-18T16:51:29.381302  / # export SHELL=3D/bin/sh. /lava-626715/en=
vironment
    2023-06-18T16:51:29.381816  =

    2023-06-18T16:51:29.483459  / # . /lava-626715/environment/lava-626715/=
bin/lava-test-runner /lava-626715/1
    2023-06-18T16:51:29.484216  =

    2023-06-18T16:51:29.488348  / # /lava-626715/bin/lava-test-runner /lava=
-626715/1
    2023-06-18T16:51:29.521496  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20
