Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E780A7414DE
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjF1PZR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjF1PZQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 11:25:16 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3852682
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 08:25:14 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-345a0cf5b3bso20407635ab.0
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687965913; x=1690557913;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pj77vKRnN4/1Xp3OYtUvi4TT595f1EKjpwxXzkWIzbE=;
        b=tI8OgT88ory3xbMHM3sOyR4cvrGL38QluDm2MHuAk7JWZJ6w4D9qDWheKPrqir4K+f
         mop2ebb04ljSWsiIXzADe+c/79HmmzFZHDQTC5j9X72mquOVX4qaHSZuuqf+RiqmeRcG
         5Lc/+yUb0PAJh9JWr7BqCsoOEXPFNHa/+3kyfncZhvZwuU987qdwFcE4W9j2ull+fphj
         ggzpzlBw2UfX/4K4ncJr+F3akotRtQec07CydPLVHirFw+eZf+t8G6a5hU4cmU9gW8lv
         pYjLYjj14gKo8UklX/TndMSpbmEYuye+3LyVjyToeC2JQmPXczlmt8aCJ2aq4Fd4DQpC
         Fulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687965913; x=1690557913;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pj77vKRnN4/1Xp3OYtUvi4TT595f1EKjpwxXzkWIzbE=;
        b=C/VUIOfUnWe1RZpkUn/G3Y7H/URqCFjJIo1cTiNWloG8bdUGTVtRLyrwgaSFCntBHo
         McyCZWLZVfSpoD2ohVMLskAZn+OI5ne4jBDuYo8CgJsPtAcnt9OVR+ni/gFFF+kSdlDx
         irlhoW4Q0NDcNZO0gMND59LMtlERnGfBe9V7m9TqHKWGoA4irzWUp003fWE7AAVAI5hq
         LUOBpGvgvakJr1SF+ZfB0ckZHcTXtQxtGwQtB7EkgzWhewEKf+4ANHTqPuOC3stYF/Pc
         0pZbzgr7jhI/Minne3qYZUo6haHLip5b3h9xnk/L0ThBbGNLsOrQjTAJ9cFLtQTnx9Cx
         lmhw==
X-Gm-Message-State: AC+VfDxK0hVMTY22E3uV4qmOfonNcxTQ+EIBKeu8WMXhZe0DRRv+LenH
        +Cnz71QrRWgjGAYjCThGiQUXQC9Xe+qqOg0mxFjruQ==
X-Google-Smtp-Source: ACHHUZ7MIKD3EC3XV3qhaMkS73fhAYIcI3lBmYGdKHy/ddMy68QeFET0zoSdstPSURJylHFq+FXqGw==
X-Received: by 2002:a92:d243:0:b0:345:79eb:e005 with SMTP id v3-20020a92d243000000b0034579ebe005mr12274307ilg.16.1687965913242;
        Wed, 28 Jun 2023 08:25:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p5-20020a63c145000000b00519c3475f21sm7677872pgi.46.2023.06.28.08.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:25:12 -0700 (PDT)
Message-ID: <649c50d8.630a0220.456cb.e817@mx.google.com>
Date:   Wed, 28 Jun 2023 08:25:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.36
Subject: stable-rc/linux-6.1.y baseline: 154 runs, 9 regressions (v6.1.36)
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

stable-rc/linux-6.1.y baseline: 154 runs, 9 regressions (v6.1.36)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.36/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.36
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a1c449d00ff8ce2c5fcea5f755df682d1f6bc2ef =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1e7a872a733bc1d7d5e3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c1e7a872a733bc1d7d5ec
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T11:50:11.376058  + set +x

    2023-06-28T11:50:11.382704  <8>[   10.585193] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10936804_1.4.2.3.1>

    2023-06-28T11:50:11.485675  =


    2023-06-28T11:50:11.586841  / # #export SHELL=3D/bin/sh

    2023-06-28T11:50:11.587161  =


    2023-06-28T11:50:11.687972  / # export SHELL=3D/bin/sh. /lava-10936804/=
environment

    2023-06-28T11:50:11.688790  =


    2023-06-28T11:50:11.790311  / # . /lava-10936804/environment/lava-10936=
804/bin/lava-test-runner /lava-10936804/1

    2023-06-28T11:50:11.790649  =


    2023-06-28T11:50:11.797047  / # /lava-10936804/bin/lava-test-runner /la=
va-10936804/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1e6fd42d6a8a7ed7d726

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c1e6fd42d6a8a7ed7d72f
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T11:49:48.803371  + set<8>[   11.731376] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10936756_1.4.2.3.1>

    2023-06-28T11:49:48.803459   +x

    2023-06-28T11:49:48.907490  / # #

    2023-06-28T11:49:49.008153  export SHELL=3D/bin/sh

    2023-06-28T11:49:49.008326  #

    2023-06-28T11:49:49.108836  / # export SHELL=3D/bin/sh. /lava-10936756/=
environment

    2023-06-28T11:49:49.109009  =


    2023-06-28T11:49:49.209536  / # . /lava-10936756/environment/lava-10936=
756/bin/lava-test-runner /lava-10936756/1

    2023-06-28T11:49:49.210083  =


    2023-06-28T11:49:49.215391  / # /lava-10936756/bin/lava-test-runner /la=
va-10936756/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1e70c41fb721b0d7d5ec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c1e70c41fb721b0d7d5f5
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T11:50:03.225870  <8>[   10.411102] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10936785_1.4.2.3.1>

    2023-06-28T11:50:03.229144  + set +x

    2023-06-28T11:50:03.333859  #

    2023-06-28T11:50:03.335049  =


    2023-06-28T11:50:03.437092  / # #export SHELL=3D/bin/sh

    2023-06-28T11:50:03.438102  =


    2023-06-28T11:50:03.539808  / # export SHELL=3D/bin/sh. /lava-10936785/=
environment

    2023-06-28T11:50:03.540136  =


    2023-06-28T11:50:03.640990  / # . /lava-10936785/environment/lava-10936=
785/bin/lava-test-runner /lava-10936785/1

    2023-06-28T11:50:03.642112  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1e50212be5dbb3d7d5fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c1e50212be5dbb3d7d606
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T11:49:44.747041  + set +x

    2023-06-28T11:49:44.753762  <8>[   10.952866] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10936729_1.4.2.3.1>

    2023-06-28T11:49:44.860930  / # #

    2023-06-28T11:49:44.962990  export SHELL=3D/bin/sh

    2023-06-28T11:49:44.963693  #

    2023-06-28T11:49:45.064836  / # export SHELL=3D/bin/sh. /lava-10936729/=
environment

    2023-06-28T11:49:45.065020  =


    2023-06-28T11:49:45.165561  / # . /lava-10936729/environment/lava-10936=
729/bin/lava-test-runner /lava-10936729/1

    2023-06-28T11:49:45.165814  =


    2023-06-28T11:49:45.170054  / # /lava-10936729/bin/lava-test-runner /la=
va-10936729/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1e5bdde152a657d7d5e1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c1e5bdde152a657d7d5ea
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T11:49:38.340931  <8>[   10.922566] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10936770_1.4.2.3.1>

    2023-06-28T11:49:38.344009  + set +x

    2023-06-28T11:49:38.448904  #

    2023-06-28T11:49:38.551701  / # #export SHELL=3D/bin/sh

    2023-06-28T11:49:38.552485  =


    2023-06-28T11:49:38.654222  / # export SHELL=3D/bin/sh. /lava-10936770/=
environment

    2023-06-28T11:49:38.655007  =


    2023-06-28T11:49:38.756862  / # . /lava-10936770/environment/lava-10936=
770/bin/lava-test-runner /lava-10936770/1

    2023-06-28T11:49:38.758097  =


    2023-06-28T11:49:38.764098  / # /lava-10936770/bin/lava-test-runner /la=
va-10936770/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1e5fd42d6a8a7ed7d610

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c1e5fd42d6a8a7ed7d619
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T11:49:33.878931  + set<8>[   12.564914] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10936727_1.4.2.3.1>

    2023-06-28T11:49:33.879049   +x

    2023-06-28T11:49:33.983380  / # #

    2023-06-28T11:49:34.084015  export SHELL=3D/bin/sh

    2023-06-28T11:49:34.084225  #

    2023-06-28T11:49:34.184778  / # export SHELL=3D/bin/sh. /lava-10936727/=
environment

    2023-06-28T11:49:34.185074  =


    2023-06-28T11:49:34.285599  / # . /lava-10936727/environment/lava-10936=
727/bin/lava-test-runner /lava-10936727/1

    2023-06-28T11:49:34.285960  =


    2023-06-28T11:49:34.290683  / # /lava-10936727/bin/lava-test-runner /la=
va-10936727/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c1e62d42d6a8a7ed7d6b8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c1e62d42d6a8a7ed7d6c1
        failing since 89 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-28T11:49:46.634194  + <8>[   11.019587] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10936810_1.4.2.3.1>

    2023-06-28T11:49:46.634325  set +x

    2023-06-28T11:49:46.739468  / # #

    2023-06-28T11:49:46.840100  export SHELL=3D/bin/sh

    2023-06-28T11:49:46.840325  #

    2023-06-28T11:49:46.940865  / # export SHELL=3D/bin/sh. /lava-10936810/=
environment

    2023-06-28T11:49:46.941087  =


    2023-06-28T11:49:47.041664  / # . /lava-10936810/environment/lava-10936=
810/bin/lava-test-runner /lava-10936810/1

    2023-06-28T11:49:47.041984  =


    2023-06-28T11:49:47.046441  / # /lava-10936810/bin/lava-test-runner /la=
va-10936810/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/649c2078026cf8ef90d7d5ec

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/649c2078026cf8ef90d7d60c
        failing since 47 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-28T11:58:35.554341  /lava-10936907/1/../bin/lava-test-case
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2078026cf8ef90d7d698
        failing since 47 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-28T11:58:30.048537  + set +x

    2023-06-28T11:58:30.054717  <8>[   17.489121] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10936907_1.5.2.3.1>

    2023-06-28T11:58:30.161789  / # #

    2023-06-28T11:58:30.262467  export SHELL=3D/bin/sh

    2023-06-28T11:58:30.262700  #

    2023-06-28T11:58:30.363253  / # export SHELL=3D/bin/sh. /lava-10936907/=
environment

    2023-06-28T11:58:30.363484  =


    2023-06-28T11:58:30.464060  / # . /lava-10936907/environment/lava-10936=
907/bin/lava-test-runner /lava-10936907/1

    2023-06-28T11:58:30.464369  =


    2023-06-28T11:58:30.469311  / # /lava-10936907/bin/lava-test-runner /la=
va-10936907/1
 =

    ... (13 line(s) more)  =

 =20
