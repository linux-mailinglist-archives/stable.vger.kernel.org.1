Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B467837F4
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 04:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjHVCbq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 22:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjHVCbp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 22:31:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E202DB
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:31:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf3a2f4528so28840395ad.2
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692671502; x=1693276302;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FF5N/6UFWAw9PHBJVog9BFDML1AU6Pgy1lht56yXEYk=;
        b=Rj0C6+3DlLHFRK0Hx7D289Qy6aShhyhOCqKXGKPx1TNHCTIbi3l8OGoedLAn7tjNiP
         gxxwstwRTftJY1Xted4lv1v6bRfzYX7RQk5415XlfypOEmWliHaYlKHGFr/NqC9c8wkk
         BO4kvpFJgYgM3YMo653c+rp2DIRaP0vckY+3Q7WLIobEvBxxkA2XxHhEr3Z0JycYOvsH
         sWbDYSx9i52ZtPs3MvGumCE/qX4R0gfbpfSMtd/fHD7QAHJwvm9ksZELI8bBksWfEUQ+
         GknbvjnaMwwHtlwolzMpp8D6Db24v38zP8e5kYKzszOciVppPCLu8VvnrcyRzoP68bo5
         AUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692671502; x=1693276302;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FF5N/6UFWAw9PHBJVog9BFDML1AU6Pgy1lht56yXEYk=;
        b=dsv+2KZ4nTmUpZybxVZdCRdoTW2Q69bLB34CY7w1vByQFtuErrrYLJ1qt1Gp+Ypikb
         Eq1yDM1yaeS5KUASTWpQB8SxkGe0z74vBz5xwouJowfwhgIe6tmj2tjLPDztUnIF0lA8
         udavQW8oMkW8Sk4q7GpOemsF0Vjm+itB2DmWWYsvRPw/4esMHvsJ5plCYYbyrq+HCPMN
         kjjrwKy9mOXpxk48FnDEOZOybrg+mqcT1n9ruull6q1fN7UAyAObw4+l4q6GCMDuHM5Q
         gulHuo95RuXISO7sOro8tH1QM5IW/7pOufvTO42UdSmeRQDsaNQ9u43NhJuH+eNHxRH2
         /t/g==
X-Gm-Message-State: AOJu0YyJx0RBEabRAcU4bhivI0SkejOFGP2bAXl+jM9EOlex9Zbz1YZd
        qHIF/pw1tigQSBqgSF5vKj0Oi3xkAfZKzWkh/jG4lQ==
X-Google-Smtp-Source: AGHT+IEM3AMAn5jSSC82OWJ1F8JNKIRyIrO1rrei6T3GtOJPcBRloTvBIrFxXNnvV1JvlXMdAWCOzw==
X-Received: by 2002:a17:902:b94b:b0:1b8:a65f:b49d with SMTP id h11-20020a170902b94b00b001b8a65fb49dmr7157844pls.12.1692671501915;
        Mon, 21 Aug 2023 19:31:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090311ca00b001b850c9d7b3sm7747351plh.249.2023.08.21.19.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 19:31:41 -0700 (PDT)
Message-ID: <64e41e0d.170a0220.ad8f2.e10b@mx.google.com>
Date:   Mon, 21 Aug 2023 19:31:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.4.254-97-g4c1230ccede5d
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.4.y baseline: 95 runs,
 12 regressions (v5.4.254-97-g4c1230ccede5d)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y baseline: 95 runs, 12 regressions (v5.4.254-97-g4c123=
0ccede5d)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.254-97-g4c1230ccede5d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.254-97-g4c1230ccede5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4c1230ccede5dae2be2b32e5fc4e9ec3c75ce106 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3ee08c4bc8fc7e2dc95d8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3ee08c4bc8fc7e2dc95dd
        failing since 216 days (last pass: v5.4.226-68-g8c05f5e0777d, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-08-21T22:59:45.358383  <8>[    9.858397] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3744704_1.5.2.4.1>
    2023-08-21T22:59:45.464938  / # #
    2023-08-21T22:59:45.566362  export SHELL=3D/bin/sh
    2023-08-21T22:59:45.566721  #
    2023-08-21T22:59:45.667868  / # export SHELL=3D/bin/sh. /lava-3744704/e=
nvironment
    2023-08-21T22:59:45.668239  =

    2023-08-21T22:59:45.769420  / # . /lava-3744704/environment/lava-374470=
4/bin/lava-test-runner /lava-3744704/1
    2023-08-21T22:59:45.769957  =

    2023-08-21T22:59:45.775236  / # /lava-3744704/bin/lava-test-runner /lav=
a-3744704/1
    2023-08-21T22:59:45.860847  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3eba413893412e4dc95d2

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unle=
ashed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unle=
ashed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64e3eba413893412=
e4dc95db
        failing since 306 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-08-21T22:55:51.388525  / # =

    2023-08-21T22:55:51.394596  =

    2023-08-21T22:55:51.501435  / # #
    2023-08-21T22:55:51.522664  #
    2023-08-21T22:55:51.625757  / # export SHELL=3D/bin/sh
    2023-08-21T22:55:51.634707  export SHELL=3D/bin/sh
    2023-08-21T22:55:51.737231  / # . /lava-3744666/environment
    2023-08-21T22:55:51.746291  . /lava-3744666/environment
    2023-08-21T22:55:51.848582  / # /lava-3744666/bin/lava-test-runner /lav=
a-3744666/0
    2023-08-21T22:55:51.858823  /lava-3744666/bin/lava-test-runner /lava-37=
44666/0 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3ebc83ecbdff248dc95cc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3ebc83ecbdff248dc95d1
        failing since 144 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-08-21T22:56:59.798058  + <8>[    9.905102] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11327581_1.4.2.3.1>

    2023-08-21T22:56:59.798142  set +x

    2023-08-21T22:56:59.899486  =


    2023-08-21T22:57:00.000066  / # #export SHELL=3D/bin/sh

    2023-08-21T22:57:00.000288  =


    2023-08-21T22:57:00.100834  / # export SHELL=3D/bin/sh. /lava-11327581/=
environment

    2023-08-21T22:57:00.101044  =


    2023-08-21T22:57:00.201567  / # . /lava-11327581/environment/lava-11327=
581/bin/lava-test-runner /lava-11327581/1

    2023-08-21T22:57:00.201929  =


    2023-08-21T22:57:00.206415  / # /lava-11327581/bin/lava-test-runner /la=
va-11327581/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3ebd57a43d2353cdc95d0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3ebd57a43d2353cdc95d5
        failing since 144 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-08-21T22:58:10.858886  <8>[   12.606261] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11327602_1.4.2.3.1>

    2023-08-21T22:58:10.862724  + set +x

    2023-08-21T22:58:10.964111  =


    2023-08-21T22:58:11.064641  / # #export SHELL=3D/bin/sh

    2023-08-21T22:58:11.064829  =


    2023-08-21T22:58:11.165379  / # export SHELL=3D/bin/sh. /lava-11327602/=
environment

    2023-08-21T22:58:11.165620  =


    2023-08-21T22:58:11.266106  / # . /lava-11327602/environment/lava-11327=
602/bin/lava-test-runner /lava-11327602/1

    2023-08-21T22:58:11.266391  =


    2023-08-21T22:58:11.271626  / # /lava-11327602/bin/lava-test-runner /la=
va-11327602/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3fcb94b60ff928adc960c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e3fcb94b60ff928adc9=
60d
        failing since 363 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3fcc83728e877d7dc95db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e3fcc83728e877d7dc9=
5dc
        failing since 383 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3fcbc7b080c797edc9601

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e3fcbc7b080c797edc9=
602
        failing since 385 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.207-123-gb48a8f43dce6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3fcbb7340e85e05dc95e1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e3fcbb7340e85e05dc9=
5e2
        failing since 383 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.209) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3fcba07d1761104dc9630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e3fcba07d1761104dc9=
631
        failing since 363 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-390-g1cece69eaa88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3fcc920825004f6dc9626

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e3fcc920825004f6dc9=
627
        failing since 371 days (last pass: v5.4.180-59-g4f62141869c8, first=
 fail: v5.4.210-258-ge86027f8111f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64e3fcb8908f7b955cdc95cc

  Results:     82 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.254=
-97-g4c1230ccede5d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64e3fcb8908f7b955cdc95d2
        failing since 160 days (last pass: v5.4.235, first fail: v5.4.235-4=
-gb829e8b6e1a7)

    2023-08-21T23:03:34.338401  <8>[   31.277896] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-21T23:03:35.351634  /lava-11327654/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64e3fcb9908f7b955cdc95d3
        failing since 160 days (last pass: v5.4.235, first fail: v5.4.235-4=
-gb829e8b6e1a7)

    2023-08-21T23:03:33.316518  <8>[   30.255094] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-21T23:03:34.329571  /lava-11327654/1/../bin/lava-test-case
   =

 =20
