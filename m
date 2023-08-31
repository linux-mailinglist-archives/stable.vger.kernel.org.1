Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B887778EF52
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjHaOKd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 10:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjHaOKd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 10:10:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22943A3
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 07:10:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdc19b782aso5906535ad.0
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693491029; x=1694095829; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aXQ1ZA5csWbGiGijNUx2klW2+t/3IsbFDD/uIJ4iWBk=;
        b=Co9c/UWYemsoirCXVExEoy9xZSpfAq0t/bG7reVmJPClHGyIeJJ9/vHNzu2O8enRwn
         OExjtg/yjzexzB258azqRiBNRKXbWYXDm9pvxTx3WiqwB2ooJN3ZSyuLWAEA6kZ43xvg
         5xS8YnfF35U6wQjS9BKvxPqx+VBr3l8TwLuQiNpS46j37URcMzQU+frwuP81k4yn4OHR
         LJVVGYuMXxF2AYlwWS7rVJrgvCcX5420s+WeiEJBliQ35GheIwcKD8d9D4j9UZRHC34l
         k4BsH00xlMWCc+Rhn2xCrxmG0uaFB5Tw5flk/2YIPVJqBZHJSx2IH1WagCX3yPmXNQV9
         bxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693491029; x=1694095829;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXQ1ZA5csWbGiGijNUx2klW2+t/3IsbFDD/uIJ4iWBk=;
        b=i+eWEZy6FiwIVhFddMRM3Zp9C5r+R2vsCRh4ijIqRWlpHn7lzZvY/R5NtpeoeolDJz
         Na8k84IQ9XfRB1ONYO3D+Uif8NjuDsDOHFRuQVo4WI5IAigYsDElO/9kR14+OC9zyTVg
         cbLOb+IRlZ9Y62hOgO3RYRvKxgtZenj9CyuF5oFOMXVTs8KawaE+5GLs5IPWQda8+M+e
         QZcHBZYPY6DnjAd+CJUYObF0S/zMHXIRCqGsBeR46FUKlFsdTujXKLF2SvU7R+XJ+sRg
         /LH5DjhICjM05pPbVoqLOG+jMQQhKDWUyiCyBm3YHDiJg2wwDbLHFKrItygrQyAbfuoz
         Ey8Q==
X-Gm-Message-State: AOJu0YxYEnIdAGlESEybhJGncgPAgBpLVtRp6gzY/5CdgPHjsvq98TGZ
        NMOMlvc68Rl2ZILcnSxS1eg6JEnCeIUtnifZsSw=
X-Google-Smtp-Source: AGHT+IESltBDA3EofofILR97W8q5/cum+xZ9XLOgnZk/1yJEaHQoOmCm64fFPRWI0A4VEitSarTYHA==
X-Received: by 2002:a17:903:110d:b0:1bf:6c4e:4d60 with SMTP id n13-20020a170903110d00b001bf6c4e4d60mr5717126plh.3.1693491024130;
        Thu, 31 Aug 2023 07:10:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b001bdcd4b1616sm1303141plf.260.2023.08.31.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:10:23 -0700 (PDT)
Message-ID: <64f09f4f.170a0220.9afe6.25b3@mx.google.com>
Date:   Thu, 31 Aug 2023 07:10:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.4.255
Subject: stable-rc/linux-5.4.y baseline: 69 runs, 4 regressions (v5.4.255)
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

stable-rc/linux-5.4.y baseline: 69 runs, 4 regressions (v5.4.255)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.255/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.255
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5eb967dd50a5a29952ab6e6b1ef4bf216cf1652c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f06992f0d30fd67c286d7e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.255=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.255=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f06992f0d30fd67c286d87
        failing since 226 days (last pass: v5.4.226-68-g8c05f5e0777d, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-08-31T10:20:57.438823  <8>[    9.792306] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3757350_1.5.2.4.1>
    2023-08-31T10:20:57.549027  / # #
    2023-08-31T10:20:57.652626  export SHELL=3D/bin/sh
    2023-08-31T10:20:57.653703  #
    2023-08-31T10:20:57.755958  / # export SHELL=3D/bin/sh. /lava-3757350/e=
nvironment
    2023-08-31T10:20:57.757157  =

    2023-08-31T10:20:57.859785  / # . /lava-3757350/environment/lava-375735=
0/bin/lava-test-runner /lava-3757350/1
    2023-08-31T10:20:57.861871  =

    2023-08-31T10:20:57.862419  / # <3>[   10.160057] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-08-31T10:20:57.867026  /lava-3757350/bin/lava-test-runner /lava-37=
57350/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hifive-unleashed-a00         | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f06bfec56cf60fe8286d7c

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.255=
/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a00.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.255=
/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64f06bfec56cf60f=
e8286d81
        failing since 316 days (last pass: v5.4.219, first fail: v5.4.219-2=
67-g4a976f825745)
        3 lines

    2023-08-31T10:31:06.717035  / # =

    2023-08-31T10:31:06.722814  =

    2023-08-31T10:31:06.845578  / # #
    2023-08-31T10:31:06.866879  #
    2023-08-31T10:31:06.970265  / # export SHELL=3D/bin/sh
    2023-08-31T10:31:06.978746  export SHELL=3D/bin/sh
    2023-08-31T10:31:07.081388  / # . /lava-3757364/environment
    2023-08-31T10:31:07.091112  . /lava-3757364/environment
    2023-08-31T10:31:07.194045  / # /lava-3757364/bin/lava-test-runner /lav=
a-3757364/0
    2023-08-31T10:31:07.203098  /lava-3757364/bin/lava-test-runner /lava-37=
57364/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f06e5e359629cfd5286d91

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.255=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.255=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f06e5e359629cfd5286d9a
        failing since 153 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-08-31T10:42:28.435895  + set<8>[    9.908079] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11389185_1.4.2.3.1>

    2023-08-31T10:42:28.435977   +x

    2023-08-31T10:42:28.537062  / ##

    2023-08-31T10:42:28.637765  export SHELL=3D/bin/sh

    2023-08-31T10:42:28.637962   #

    2023-08-31T10:42:28.738461  / # export SHELL=3D/bin/sh. /lava-11389185/=
environment

    2023-08-31T10:42:28.738690  =


    2023-08-31T10:42:28.839244  / # . /lava-11389185/environment/lava-11389=
185/bin/lava-test-runner /lava-11389185/1

    2023-08-31T10:42:28.839560  =


    2023-08-31T10:42:28.844204  / # /lava-11389185/bin/lava-test-runner /la=
va-11389185/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f06e61359629cfd5286dbe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.255=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.255=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f06e61359629cfd5286dc7
        failing since 153 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-08-31T10:41:22.968968  + set +x

    2023-08-31T10:41:22.975383  <8>[   12.350566] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11389180_1.4.2.3.1>

    2023-08-31T10:41:23.077424  =


    2023-08-31T10:41:23.178306  / # #export SHELL=3D/bin/sh

    2023-08-31T10:41:23.179071  =


    2023-08-31T10:41:23.280576  / # export SHELL=3D/bin/sh. /lava-11389180/=
environment

    2023-08-31T10:41:23.281325  =


    2023-08-31T10:41:23.382684  / # . /lava-11389180/environment/lava-11389=
180/bin/lava-test-runner /lava-11389180/1

    2023-08-31T10:41:23.383872  =


    2023-08-31T10:41:23.389456  / # /lava-11389180/bin/lava-test-runner /la=
va-11389180/1
 =

    ... (12 line(s) more)  =

 =20
