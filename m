Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8499B6FBEF3
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 08:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjEIGDB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 02:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEIGDA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 02:03:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA4F903C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 23:02:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a5197f00e9so38318225ad.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 23:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683612178; x=1686204178;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4O9M/NpJ50ZYUC5FP/oyA285lDqbypARttd0QGnshrA=;
        b=OBRyVHLi5kq3qlpydOPQF42J6y+uGOfp0SnCxOh9WURepUwD2I4kvymNZ9SdzRvKbj
         Df66f2PFQ+Hw4Kn/JXjS2qh0O/t+iqH9KCnqfdR+7yJ5wD3QtMtX8p9XHHTZXOj8b3DG
         rUCXA71TbkFYkinYWOuZMXOWNxejHmyIIpxs0vtAGDHwatgKCuSXnoSWnarhyQWR3+Jj
         KtaK50cU4FGqRlsYW3m3KwnSWOctL95n2THSXeLRvTdNM+IjPcplzYWpXVK1GqvyTP6p
         3Uc1nsvZMatvGgOn+xvMNGKUOgjzI8V1HYX3wkI8TcIgQp4WSbmw6q/TWz9Oj7qPoJM5
         qEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683612178; x=1686204178;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4O9M/NpJ50ZYUC5FP/oyA285lDqbypARttd0QGnshrA=;
        b=EpAONCocD4/RqU7l9VVhHWI/mOYQ569r7tBNIVk94CPT35/q1RrCOgTpJrx32G/zSx
         94+ZmivYhSDrqpfmNLWCjSh9Ug+nUOZ2JJOxUKLcvvj0S3bGrl+NSwgAdg/sicgFlpIx
         +1SgK0dPs6FFJshDWdTTWPBzJtX8wvNTHAdlgNaTgc/nYA3eQ2VG0w9h22aLI9AStHLS
         ado7Sl3qrmdIGQELaZBk+dyW4zzhMqE3ay+F82I/6ek9kY+DWsfzOhSdE4o/uuZtzAIJ
         h+0Q4Y5WxWS1En1zwydCyiCyN87Ea/rrOdvwgzsTqiG4sRRZZMnHs+u4JfSxGbUYQ3K6
         YFGQ==
X-Gm-Message-State: AC+VfDxdzUEP88hXrYVrLP4FKHDJ/4XJkvnHDMGLOBYaKD5SnjSn90lg
        6yUu6oF58wStvMgDxXZyDKPFKWDXiF0+slJQi/fT4w==
X-Google-Smtp-Source: ACHHUZ4t0ZmCO2VrQGgKRdAjDrInNIFlafH7TaDR3lV+QZvj69G3rLdMRtRyQny4qSs04Elm9sPqqw==
X-Received: by 2002:a17:902:bd44:b0:1a6:9d98:e763 with SMTP id b4-20020a170902bd4400b001a69d98e763mr11962757plx.26.1683612177547;
        Mon, 08 May 2023 23:02:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902868700b001aad4be4503sm588090plo.2.2023.05.08.23.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 23:02:56 -0700 (PDT)
Message-ID: <6459e210.170a0220.1d16a.13c0@mx.google.com>
Date:   Mon, 08 May 2023 23:02:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-1203-gcbbb6e9daa79
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 161 runs,
 10 regressions (v6.1.22-1203-gcbbb6e9daa79)
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

stable-rc/queue/6.1 baseline: 161 runs, 10 regressions (v6.1.22-1203-gcbbb6=
e9daa79)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-1203-gcbbb6e9daa79/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-1203-gcbbb6e9daa79
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      cbbb6e9daa792f86bc9001b7a52da6b7d420e1af =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459aef7c13a2823f32e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459aef7c13a2823f32e85fb
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T02:24:32.570565  <8>[   10.322030] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10247921_1.4.2.3.1>

    2023-05-09T02:24:32.573689  + set +x

    2023-05-09T02:24:32.678725  / # #

    2023-05-09T02:24:32.779459  export SHELL=3D/bin/sh

    2023-05-09T02:24:32.779678  #

    2023-05-09T02:24:32.880224  / # export SHELL=3D/bin/sh. /lava-10247921/=
environment

    2023-05-09T02:24:32.880495  =


    2023-05-09T02:24:32.981076  / # . /lava-10247921/environment/lava-10247=
921/bin/lava-test-runner /lava-10247921/1

    2023-05-09T02:24:32.981443  =


    2023-05-09T02:24:32.986770  / # /lava-10247921/bin/lava-test-runner /la=
va-10247921/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ae9b5e04f3a1b42e8620

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459ae9b5e04f3a1b42e8625
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T02:22:58.655220  + set<8>[    8.927870] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10247885_1.4.2.3.1>

    2023-05-09T02:22:58.655341   +x

    2023-05-09T02:22:58.759153  / # #

    2023-05-09T02:22:58.859827  export SHELL=3D/bin/sh

    2023-05-09T02:22:58.860013  #

    2023-05-09T02:22:58.960524  / # export SHELL=3D/bin/sh. /lava-10247885/=
environment

    2023-05-09T02:22:58.960700  =


    2023-05-09T02:22:59.061237  / # . /lava-10247885/environment/lava-10247=
885/bin/lava-test-runner /lava-10247885/1

    2023-05-09T02:22:59.061489  =


    2023-05-09T02:22:59.066660  / # /lava-10247885/bin/lava-test-runner /la=
va-10247885/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ae995d838a21d42e85ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459ae995d838a21d42e85f3
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T02:23:10.974162  <8>[   10.252484] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10247886_1.4.2.3.1>

    2023-05-09T02:23:10.977475  + set +x

    2023-05-09T02:23:11.083188  =


    2023-05-09T02:23:11.185200  / # #export SHELL=3D/bin/sh

    2023-05-09T02:23:11.185990  =


    2023-05-09T02:23:11.287304  / # export SHELL=3D/bin/sh. /lava-10247886/=
environment

    2023-05-09T02:23:11.288091  =


    2023-05-09T02:23:11.389343  / # . /lava-10247886/environment/lava-10247=
886/bin/lava-test-runner /lava-10247886/1

    2023-05-09T02:23:11.389594  =


    2023-05-09T02:23:11.394960  / # /lava-10247886/bin/lava-test-runner /la=
va-10247886/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ae945e04f3a1b42e8608

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459ae945e04f3a1b42e860d
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T02:22:58.344709  + set +x

    2023-05-09T02:22:58.351000  <8>[   11.649748] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10247924_1.4.2.3.1>

    2023-05-09T02:22:58.455408  / # #

    2023-05-09T02:22:58.556050  export SHELL=3D/bin/sh

    2023-05-09T02:22:58.556262  #

    2023-05-09T02:22:58.656871  / # export SHELL=3D/bin/sh. /lava-10247924/=
environment

    2023-05-09T02:22:58.657146  =


    2023-05-09T02:22:58.757700  / # . /lava-10247924/environment/lava-10247=
924/bin/lava-test-runner /lava-10247924/1

    2023-05-09T02:22:58.758018  =


    2023-05-09T02:22:58.762260  / # /lava-10247924/bin/lava-test-runner /la=
va-10247924/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ae7b48602bfe4b2e85f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459ae7b48602bfe4b2e85f7
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T02:22:37.145600  <8>[   10.040099] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10247894_1.4.2.3.1>

    2023-05-09T02:22:37.148788  + set +x

    2023-05-09T02:22:37.254089  /#

    2023-05-09T02:22:37.357100   # #export SHELL=3D/bin/sh

    2023-05-09T02:22:37.357896  =


    2023-05-09T02:22:37.459518  / # export SHELL=3D/bin/sh. /lava-10247894/=
environment

    2023-05-09T02:22:37.460222  =


    2023-05-09T02:22:37.561601  / # . /lava-10247894/environment/lava-10247=
894/bin/lava-test-runner /lava-10247894/1

    2023-05-09T02:22:37.562814  =


    2023-05-09T02:22:37.568441  / # /lava-10247894/bin/lava-test-runner /la=
va-10247894/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ae909d96a9cc8e2e860d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459ae909d96a9cc8e2e8612
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T02:22:49.793177  + set<8>[    8.747449] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10247963_1.4.2.3.1>

    2023-05-09T02:22:49.793603   +x

    2023-05-09T02:22:49.901076  / # #

    2023-05-09T02:22:50.003290  export SHELL=3D/bin/sh

    2023-05-09T02:22:50.003955  #

    2023-05-09T02:22:50.105413  / # export SHELL=3D/bin/sh. /lava-10247963/=
environment

    2023-05-09T02:22:50.106121  =


    2023-05-09T02:22:50.207680  / # . /lava-10247963/environment/lava-10247=
963/bin/lava-test-runner /lava-10247963/1

    2023-05-09T02:22:50.209010  =


    2023-05-09T02:22:50.213934  / # /lava-10247963/bin/lava-test-runner /la=
va-10247963/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459ae879d96a9cc8e2e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459ae879d96a9cc8e2e85ef
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T02:22:52.087440  + set +x<8>[   11.313697] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10247940_1.4.2.3.1>

    2023-05-09T02:22:52.087559  =


    2023-05-09T02:22:52.192740  / # #

    2023-05-09T02:22:52.293518  export SHELL=3D/bin/sh

    2023-05-09T02:22:52.293756  #

    2023-05-09T02:22:52.394358  / # export SHELL=3D/bin/sh. /lava-10247940/=
environment

    2023-05-09T02:22:52.394583  =


    2023-05-09T02:22:52.495172  / # . /lava-10247940/environment/lava-10247=
940/bin/lava-test-runner /lava-10247940/1

    2023-05-09T02:22:52.495474  =


    2023-05-09T02:22:52.499852  / # /lava-10247940/bin/lava-test-runner /la=
va-10247940/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6459b17984601303d22e863f

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6459b17984601303d22e8651
        failing since 1 day (last pass: v6.1.22-704-ga3dcd1f09de2, first fa=
il: v6.1.22-1160-g24230ce6f2e2)

    2023-05-09T02:35:14.030793  /lava-10248065/1/../bin/lava-test-case

    2023-05-09T02:35:14.037488  <8>[   22.967614] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459b17a84601303d22e86dd
        failing since 1 day (last pass: v6.1.22-704-ga3dcd1f09de2, first fa=
il: v6.1.22-1160-g24230ce6f2e2)

    2023-05-09T02:35:08.563654  + <8>[   17.495620] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10248065_1.5.2.3.1>

    2023-05-09T02:35:08.566977  set +x

    2023-05-09T02:35:08.671745  / # #

    2023-05-09T02:35:08.772344  export SHELL=3D/bin/sh

    2023-05-09T02:35:08.772550  #

    2023-05-09T02:35:08.873124  / # export SHELL=3D/bin/sh. /lava-10248065/=
environment

    2023-05-09T02:35:08.873301  =


    2023-05-09T02:35:08.973836  / # . /lava-10248065/environment/lava-10248=
065/bin/lava-test-runner /lava-10248065/1

    2023-05-09T02:35:08.974088  =


    2023-05-09T02:35:08.979269  / # /lava-10248065/bin/lava-test-runner /la=
va-10248065/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6459b05d6a5ccc55482e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mi=
ps-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
03-gcbbb6e9daa79/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mi=
ps-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459b05d6a5ccc55482e8=
5e8
        failing since 1 day (last pass: v6.1.22-1159-g8729cbdc1402, first f=
ail: v6.1.22-1196-g571a2463c150b) =

 =20
