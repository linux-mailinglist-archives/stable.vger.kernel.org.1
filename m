Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58F703DBF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 21:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245145AbjEOTa7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245044AbjEOTa6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 15:30:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EE87EF8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:30:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24e25e2808fso11804805a91.0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684179055; x=1686771055;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zN2kFVkeELOoen8BR1+mYOUa8f9U5GKD3ynRHT7VVeU=;
        b=MBIWcmIkQDLfchwndKekqJxmr7hUctS9p+cfT3vgNLCbp1IKd7xu2dXCjibh6MuYNn
         vB8jZl2wQDOrKGVMkOVTTXLHG02aAf6RlxQjxrn0L8niUJwnmq+MlwkeStg/zdFMDFTm
         LdsqSZq3YGyxe1MKjmYVX8tjTnVdqqQWncf6ua+OD4sQq13ELizKlevWgHwplkz1CHY9
         8MG9JQjBsuFmHzhEouzH/oUzFfuTHwu2QlQQJXfDQ+M2uq/r+osbbHNFyekTc2E+tjM+
         tXME2EZIttcXW4lGd98yRPC//ZxVhp35hJlB8feYv1IqzOABtgPFAAh0uj59QlTk29mb
         yMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684179055; x=1686771055;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN2kFVkeELOoen8BR1+mYOUa8f9U5GKD3ynRHT7VVeU=;
        b=Wt4UH9qNOE1DQD7wOY3mTPlCqlZWeMby6YwMDIE0oV9Vb4RxXrqtmU7wmCXHVQ+XHK
         a+R4vvNZCsyuCkTchj7zJmxkrBunxPcLcHJMkbNA22HxOLeqDfvlBF4UoNpUdOrYV0FU
         eg1scmPbFT99NQUGDmYSYQzs86GucdYAB2SAI7oX8p5rmbMqn69h2WS0T9JwhX7DNd1U
         4peJtTezh4+YY8k9Ax/wnwssKt6SmpwYOaO+JyJR1rcyLOc29qkSpjYhyi/5WAnbIV0H
         /WrU522sZeUfXw/R0kzLR9k2msVv0NviO2FWeimtoDAA2O2UPIC4ZOLv1D7Wd3sql6nI
         2tgA==
X-Gm-Message-State: AC+VfDz2EOEl4f43pl663hJl3RekAQ/99VGD+8Um892r5V7mdYI6M07q
        wxUJNO/iBI5MdZ8Ef3PsmM826xP0rM7K6CWS8TW3hA==
X-Google-Smtp-Source: ACHHUZ5ScAIHaWQBt8ZwTHPHn5fnLnJdfWLYS4T/wrrvT2SzAoXUYQ+E99lWVwoAbhHA9oiFzEbTiA==
X-Received: by 2002:a17:90b:3a8e:b0:247:6ead:d0ed with SMTP id om14-20020a17090b3a8e00b002476eadd0edmr35028671pjb.28.1684179055395;
        Mon, 15 May 2023 12:30:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cs23-20020a17090af51700b0024e47fbe731sm142290pjb.24.2023.05.15.12.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:30:54 -0700 (PDT)
Message-ID: <6462886e.170a0220.35455.0b5c@mx.google.com>
Date:   Mon, 15 May 2023 12:30:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-239-g553581e88bac
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 171 runs,
 10 regressions (v6.1.28-239-g553581e88bac)
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

stable-rc/linux-6.1.y baseline: 171 runs, 10 regressions (v6.1.28-239-g5535=
81e88bac)

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

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.28-239-g553581e88bac/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.28-239-g553581e88bac
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      553581e88bacb7683497a91241dd262c875764a5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646252934ed3de14622e86a5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646252934ed3de14622e86aa
        failing since 46 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T15:40:44.659051  <8>[   11.079482] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10326596_1.4.2.3.1>

    2023-05-15T15:40:44.662612  + set +x

    2023-05-15T15:40:44.768697  #

    2023-05-15T15:40:44.770020  =


    2023-05-15T15:40:44.871836  / # #export SHELL=3D/bin/sh

    2023-05-15T15:40:44.872458  =


    2023-05-15T15:40:44.973657  / # export SHELL=3D/bin/sh. /lava-10326596/=
environment

    2023-05-15T15:40:44.974566  =


    2023-05-15T15:40:45.076044  / # . /lava-10326596/environment/lava-10326=
596/bin/lava-test-runner /lava-10326596/1

    2023-05-15T15:40:45.077107  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64625285d7c47983532e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64625285d7c47983532e8613
        failing since 46 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T15:40:31.997283  + set<8>[   11.481370] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10326669_1.4.2.3.1>

    2023-05-15T15:40:31.997365   +x

    2023-05-15T15:40:32.101398  / # #

    2023-05-15T15:40:32.202193  export SHELL=3D/bin/sh

    2023-05-15T15:40:32.202414  #

    2023-05-15T15:40:32.303031  / # export SHELL=3D/bin/sh. /lava-10326669/=
environment

    2023-05-15T15:40:32.303306  =


    2023-05-15T15:40:32.403791  / # . /lava-10326669/environment/lava-10326=
669/bin/lava-test-runner /lava-10326669/1

    2023-05-15T15:40:32.404120  =


    2023-05-15T15:40:32.408988  / # /lava-10326669/bin/lava-test-runner /la=
va-10326669/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64625279e632b7fe4b2e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64625279e632b7fe4b2e860e
        failing since 46 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T15:40:24.782540  <8>[   10.882797] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10326616_1.4.2.3.1>

    2023-05-15T15:40:24.785584  + set +x

    2023-05-15T15:40:24.890160  / # #

    2023-05-15T15:40:24.990738  export SHELL=3D/bin/sh

    2023-05-15T15:40:24.990939  #

    2023-05-15T15:40:25.091436  / # export SHELL=3D/bin/sh. /lava-10326616/=
environment

    2023-05-15T15:40:25.091681  =


    2023-05-15T15:40:25.192175  / # . /lava-10326616/environment/lava-10326=
616/bin/lava-test-runner /lava-10326616/1

    2023-05-15T15:40:25.192458  =


    2023-05-15T15:40:25.197397  / # /lava-10326616/bin/lava-test-runner /la=
va-10326616/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64625277d7c47983532e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64625277d7c47983532e85eb
        failing since 46 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T15:40:26.208848  + set +x

    2023-05-15T15:40:26.215827  <8>[   11.741065] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10326654_1.4.2.3.1>

    2023-05-15T15:40:26.320206  / # #

    2023-05-15T15:40:26.420858  export SHELL=3D/bin/sh

    2023-05-15T15:40:26.421072  #

    2023-05-15T15:40:26.521612  / # export SHELL=3D/bin/sh. /lava-10326654/=
environment

    2023-05-15T15:40:26.521864  =


    2023-05-15T15:40:26.622404  / # . /lava-10326654/environment/lava-10326=
654/bin/lava-test-runner /lava-10326654/1

    2023-05-15T15:40:26.622794  =


    2023-05-15T15:40:26.626932  / # /lava-10326654/bin/lava-test-runner /la=
va-10326654/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64625284e632b7fe4b2e866f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64625284e632b7fe4b2e8674
        failing since 46 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T15:40:30.545315  <8>[   10.415470] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10326655_1.4.2.3.1>

    2023-05-15T15:40:30.548949  + set +x

    2023-05-15T15:40:30.650209  #

    2023-05-15T15:40:30.650496  =


    2023-05-15T15:40:30.751107  / # #export SHELL=3D/bin/sh

    2023-05-15T15:40:30.751295  =


    2023-05-15T15:40:30.851801  / # export SHELL=3D/bin/sh. /lava-10326655/=
environment

    2023-05-15T15:40:30.851998  =


    2023-05-15T15:40:30.952525  / # . /lava-10326655/environment/lava-10326=
655/bin/lava-test-runner /lava-10326655/1

    2023-05-15T15:40:30.952843  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6462527a9c0506845e2e8641

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6462527a9c0506845e2e8646
        failing since 46 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T15:40:28.757450  + <8>[   11.316396] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10326622_1.4.2.3.1>

    2023-05-15T15:40:28.757564  set +x

    2023-05-15T15:40:28.861863  / # #

    2023-05-15T15:40:28.962536  export SHELL=3D/bin/sh

    2023-05-15T15:40:28.962749  #

    2023-05-15T15:40:29.063284  / # export SHELL=3D/bin/sh. /lava-10326622/=
environment

    2023-05-15T15:40:29.063493  =


    2023-05-15T15:40:29.163991  / # . /lava-10326622/environment/lava-10326=
622/bin/lava-test-runner /lava-10326622/1

    2023-05-15T15:40:29.164284  =


    2023-05-15T15:40:29.168561  / # /lava-10326622/bin/lava-test-runner /la=
va-10326622/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646252642b960ce0622e8618

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646252642b960ce0622e861d
        failing since 46 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T15:40:10.092202  + set<8>[   11.671289] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10326602_1.4.2.3.1>

    2023-05-15T15:40:10.092307   +x

    2023-05-15T15:40:10.196730  / # #

    2023-05-15T15:40:10.297404  export SHELL=3D/bin/sh

    2023-05-15T15:40:10.297627  #

    2023-05-15T15:40:10.398106  / # export SHELL=3D/bin/sh. /lava-10326602/=
environment

    2023-05-15T15:40:10.398293  =


    2023-05-15T15:40:10.498799  / # . /lava-10326602/environment/lava-10326=
602/bin/lava-test-runner /lava-10326602/1

    2023-05-15T15:40:10.499086  =


    2023-05-15T15:40:10.504340  / # /lava-10326602/bin/lava-test-runner /la=
va-10326602/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6462528c4ed3de14622e85eb

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6462528c4ed3de14622e8607
        failing since 3 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-15T15:40:47.748635  /lava-10326515/1/../bin/lava-test-case

    2023-05-15T15:40:47.755165  <8>[   23.018893] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6462528d4ed3de14622e8693
        failing since 3 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-15T15:40:42.273462  + set +x

    2023-05-15T15:40:42.279823  <8>[   17.541745] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10326515_1.5.2.3.1>

    2023-05-15T15:40:42.386321  / # #

    2023-05-15T15:40:42.486949  export SHELL=3D/bin/sh

    2023-05-15T15:40:42.487191  #

    2023-05-15T15:40:42.587792  / # export SHELL=3D/bin/sh. /lava-10326515/=
environment

    2023-05-15T15:40:42.588083  =


    2023-05-15T15:40:42.688689  / # . /lava-10326515/environment/lava-10326=
515/bin/lava-test-runner /lava-10326515/1

    2023-05-15T15:40:42.689112  =


    2023-05-15T15:40:42.694032  / # /lava-10326515/bin/lava-test-runner /la=
va-10326515/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/646254b9755c8868f72e8624

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
239-g553581e88bac/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646254b9755c8868f72e8=
625
        failing since 3 days (last pass: v6.1.27, first fail: v6.1.28) =

 =20
