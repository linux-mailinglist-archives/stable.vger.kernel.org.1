Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2178787A97
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 23:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjHXVeT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 17:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbjHXVeR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 17:34:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C72E4B
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:34:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf3a2f4528so3082195ad.2
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692912853; x=1693517653;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lkRxUPlhyOu7EJgKWkcFrKGShq/fV0E4TWLk++Hmyho=;
        b=IRLRIlourg2NsUp9WeONCbhs7VjLK+wVxDGGIyWifPGE1OnfJBJrxr2KQluQRCUZNC
         Bk/2trHrmxXfbBL8fKwEgcVSLoqq+72JZkG/BlSX/okSRc9vFjV52lg7QOttSzUXTunr
         HFOuQtzEg8obmz6NzzO+qC+UZ8ZyD4cQ79TisDNQPnbzOlXcXrW/qym4jnLBVfBFNi13
         qMWlQmN9g1jZVVtWWnKtWCqj6pgIH5sS6qZElm4RewwHrtMB5ZxQdX4zD+R2YUp4rRxR
         GHVuQbERIzmj7LDD1N/2GEgvu/6mMTMQSVlTa7yUBRsFtAkMZ0s65sz+jOdgFvpAZ1RY
         3juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692912853; x=1693517653;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkRxUPlhyOu7EJgKWkcFrKGShq/fV0E4TWLk++Hmyho=;
        b=bPi/VC1UddMKCbna4evQjZKoesPjl9OPzHBZs+yMzGvWOi5Cu604nDII1rmv6A1om0
         sXdLVmNmh6dGql45IrgSuH9Stw2UXf9p+1pntBv6H1Szw5VCmjBow6VZophy4cLS14GH
         MHGD0tC7fknsl+vzaG8Z+7NeCSxMkDx7HxdkPmuOlAH7oTawx7M6rpI7sJ5Th8gV66Yv
         7naWqbC8IgcdXklCC51ouzojIVQZke5FS2dq7G+z1hjxQumZgpQnTEG0j9FVY4nAocxA
         qEM1c2cmRZywwJOQTRCunqYxkWDDxDtLAuetytXCFTeT/otULgVWhKYbRgYat4CARFQE
         UBgg==
X-Gm-Message-State: AOJu0YwktdlDlxH1gB84ux9KeQcBLX1DLwdbTUuyh8cS4ADQgdITwih/
        vYrG0Q4FZAo+ugbfjchHuL93FQllVaCQNEujw4Q=
X-Google-Smtp-Source: AGHT+IFKfvgjtN+gQCwhQ5kmkLJ3FSF7kyUcf+KJPs3o9zK5Ec91Oh9Jna9dfaU3wBhM2CIYl85hmA==
X-Received: by 2002:a17:902:e9c2:b0:1bb:a522:909a with SMTP id 2-20020a170902e9c200b001bba522909amr17140324plk.37.1692912853049;
        Thu, 24 Aug 2023 14:34:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902821300b001bbf7fd354csm116076pln.213.2023.08.24.14.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 14:34:12 -0700 (PDT)
Message-ID: <64e7ccd4.170a0220.3dfea.0655@mx.google.com>
Date:   Thu, 24 Aug 2023 14:34:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-136-g78bdf347b3429
Subject: stable-rc/linux-5.10.y baseline: 125 runs,
 11 regressions (v5.10.191-136-g78bdf347b3429)
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

stable-rc/linux-5.10.y baseline: 125 runs, 11 regressions (v5.10.191-136-g7=
8bdf347b3429)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

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
nel/v5.10.191-136-g78bdf347b3429/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.191-136-g78bdf347b3429
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      78bdf347b342992291284fd060ee34dbccf570a8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e79aa0aed9e41c97286d84

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e79aa0aed9e41c97286d8b
        failing since 37 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-24T17:59:49.405432  + [   13.913037] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1245847_1.5.2.4.1>
    2023-08-24T17:59:49.405721  set +x
    2023-08-24T17:59:49.510935  =

    2023-08-24T17:59:49.612138  / # #export SHELL=3D/bin/sh
    2023-08-24T17:59:49.612634  =

    2023-08-24T17:59:49.713587  / # export SHELL=3D/bin/sh. /lava-1245847/e=
nvironment
    2023-08-24T17:59:49.714015  =

    2023-08-24T17:59:49.814993  / # . /lava-1245847/environment/lava-124584=
7/bin/lava-test-runner /lava-1245847/1
    2023-08-24T17:59:49.815730  =

    2023-08-24T17:59:49.820077  / # /lava-1245847/bin/lava-test-runner /lav=
a-1245847/1 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e79aa21748478ba1286d6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e79aa21748478ba1286d75
        failing since 173 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-24T17:59:46.679291  [   14.839141] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1245848_1.5.2.4.1>
    2023-08-24T17:59:46.784644  =

    2023-08-24T17:59:46.885908  / # #export SHELL=3D/bin/sh
    2023-08-24T17:59:46.886308  =

    2023-08-24T17:59:46.987301  / # export SHELL=3D/bin/sh. /lava-1245848/e=
nvironment
    2023-08-24T17:59:46.987759  =

    2023-08-24T17:59:47.088772  / # . /lava-1245848/environment/lava-124584=
8/bin/lava-test-runner /lava-1245848/1
    2023-08-24T17:59:47.089440  =

    2023-08-24T17:59:47.093378  / # /lava-1245848/bin/lava-test-runner /lav=
a-1245848/1
    2023-08-24T17:59:47.107619  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7994e2dcf3046e4286db0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7994e2dcf3046e4286db5
        failing since 148 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-24T17:54:18.628185  + set +x

    2023-08-24T17:54:18.634239  <8>[    8.140651] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11347993_1.4.2.3.1>

    2023-08-24T17:54:18.739881  / # #

    2023-08-24T17:54:18.842219  export SHELL=3D/bin/sh

    2023-08-24T17:54:18.842796  #

    2023-08-24T17:54:18.944092  / # export SHELL=3D/bin/sh. /lava-11347993/=
environment

    2023-08-24T17:54:18.944867  =


    2023-08-24T17:54:19.046420  / # . /lava-11347993/environment/lava-11347=
993/bin/lava-test-runner /lava-11347993/1

    2023-08-24T17:54:19.047576  =


    2023-08-24T17:54:19.052433  / # /lava-11347993/bin/lava-test-runner /la=
va-11347993/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e798faba5ea24f40286da9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e798faba5ea24f40286dae
        failing since 148 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-24T17:53:52.906421  + set +x

    2023-08-24T17:53:52.913127  <8>[   11.750974] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11348034_1.4.2.3.1>

    2023-08-24T17:53:53.014900  #

    2023-08-24T17:53:53.115763  / # #export SHELL=3D/bin/sh

    2023-08-24T17:53:53.115968  =


    2023-08-24T17:53:53.216452  / # export SHELL=3D/bin/sh. /lava-11348034/=
environment

    2023-08-24T17:53:53.216633  =


    2023-08-24T17:53:53.317163  / # . /lava-11348034/environment/lava-11348=
034/bin/lava-test-runner /lava-11348034/1

    2023-08-24T17:53:53.317440  =


    2023-08-24T17:53:53.322031  / # /lava-11348034/bin/lava-test-runner /la=
va-11348034/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e79abc18c0429168286e40

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e79abc18c0429168286e79
        failing since 2 days (last pass: v5.10.191, first fail: v5.10.190-1=
23-gec001faa2c729)

    2023-08-24T18:00:08.585425  / # #
    2023-08-24T18:00:08.688442  export SHELL=3D/bin/sh
    2023-08-24T18:00:08.689235  #
    2023-08-24T18:00:08.791269  / # export SHELL=3D/bin/sh. /lava-68373/env=
ironment
    2023-08-24T18:00:08.792108  =

    2023-08-24T18:00:08.894145  / # . /lava-68373/environment/lava-68373/bi=
n/lava-test-runner /lava-68373/1
    2023-08-24T18:00:08.895559  =

    2023-08-24T18:00:08.908495  / # /lava-68373/bin/lava-test-runner /lava-=
68373/1
    2023-08-24T18:00:08.968308  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-24T18:00:08.968823  + cd /lava-68373/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e79b4faf3fe96eb7286d8c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e79b4faf3fe96eb7286d93
        failing since 37 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-24T18:02:25.515944  + set +x
    2023-08-24T18:02:25.516064  <8>[   83.907683] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1000276_1.5.2.4.1>
    2023-08-24T18:02:25.621576  / # #
    2023-08-24T18:02:27.080373  export SHELL=3D/bin/sh
    2023-08-24T18:02:27.100804  #
    2023-08-24T18:02:27.100956  / # export SHELL=3D/bin/sh
    2023-08-24T18:02:29.053017  / # . /lava-1000276/environment
    2023-08-24T18:02:32.645001  /lava-1000276/bin/lava-test-runner /lava-10=
00276/1
    2023-08-24T18:02:32.665725  . /lava-1000276/environment
    2023-08-24T18:02:32.665865  / # /lava-1000276/bin/lava-test-runner /lav=
a-1000276/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e79ad71748478ba1286ddf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek87=
4.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek87=
4.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e79ad71748478ba1286de6
        failing since 37 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-24T18:00:40.465366  / # #
    2023-08-24T18:00:41.925171  export SHELL=3D/bin/sh
    2023-08-24T18:00:41.945741  #
    2023-08-24T18:00:41.945943  / # export SHELL=3D/bin/sh
    2023-08-24T18:00:43.901713  / # . /lava-1000269/environment
    2023-08-24T18:00:47.499659  /lava-1000269/bin/lava-test-runner /lava-10=
00269/1
    2023-08-24T18:00:47.520466  . /lava-1000269/environment
    2023-08-24T18:00:47.520576  / # /lava-1000269/bin/lava-test-runner /lav=
a-1000269/1
    2023-08-24T18:00:47.553353  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-24T18:00:47.601924  + cd /lava-1000269/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e79bc71fa2684dd8286d79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e79bc71fa2684dd8286d80
        failing since 37 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-24T18:04:32.008319  / # #
    2023-08-24T18:04:33.471687  export SHELL=3D/bin/sh
    2023-08-24T18:04:33.492267  #
    2023-08-24T18:04:33.492475  / # export SHELL=3D/bin/sh
    2023-08-24T18:04:35.446722  / # . /lava-1000278/environment
    2023-08-24T18:04:39.045712  /lava-1000278/bin/lava-test-runner /lava-10=
00278/1
    2023-08-24T18:04:39.066508  . /lava-1000278/environment
    2023-08-24T18:04:39.066619  / # /lava-1000278/bin/lava-test-runner /lav=
a-1000278/1
    2023-08-24T18:04:39.144936  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-24T18:04:39.145159  + cd /lava-1000278/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e79a1782d8ba13bb286d6f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e79a1782d8ba13bb286d74
        failing since 37 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-24T17:59:15.432642  / # #

    2023-08-24T17:59:15.534626  export SHELL=3D/bin/sh

    2023-08-24T17:59:15.534875  #

    2023-08-24T17:59:15.635714  / # export SHELL=3D/bin/sh. /lava-11348110/=
environment

    2023-08-24T17:59:15.636412  =


    2023-08-24T17:59:15.737850  / # . /lava-11348110/environment/lava-11348=
110/bin/lava-test-runner /lava-11348110/1

    2023-08-24T17:59:15.739036  =


    2023-08-24T17:59:15.746429  / # /lava-11348110/bin/lava-test-runner /la=
va-11348110/1

    2023-08-24T17:59:15.805624  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T17:59:15.806139  + cd /lav<8>[   16.436270] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11348110_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e79a49e4dfc643ad286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-=
rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-=
rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e79a49e4dfc643ad286d76
        failing since 0 day (last pass: v5.10.191, first fail: v5.10.190-13=
6-gda59b7b5c515e)

    2023-08-24T17:58:08.336823  / # #

    2023-08-24T17:58:09.590991  export SHELL=3D/bin/sh

    2023-08-24T17:58:09.601260  #

    2023-08-24T17:58:09.601349  / # export SHELL=3D/bin/sh

    2023-08-24T17:58:11.336942  . /lava-11348117/environment

    2023-08-24T17:58:14.527430  / # . /lava-11348117/environment/lava-11348=
117/bin/lava-test-runner /lava-11348117/1

    2023-08-24T17:58:14.537820  =


    2023-08-24T17:58:14.542024  / # /lava-11348117/bin/lava-test-runner /la=
va-11348117/1

    2023-08-24T17:58:14.593931  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T17:58:14.594010  + cd /lava-11348117/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e79a2ccebd5bb3de286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91-136-g78bdf347b3429/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e79a2ccebd5bb3de286d71
        failing since 37 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-24T17:59:34.155246  / # #

    2023-08-24T17:59:34.257158  export SHELL=3D/bin/sh

    2023-08-24T17:59:34.257865  #

    2023-08-24T17:59:34.359276  / # export SHELL=3D/bin/sh. /lava-11348115/=
environment

    2023-08-24T17:59:34.359997  =


    2023-08-24T17:59:34.461479  / # . /lava-11348115/environment/lava-11348=
115/bin/lava-test-runner /lava-11348115/1

    2023-08-24T17:59:34.462574  =


    2023-08-24T17:59:34.479719  / # /lava-11348115/bin/lava-test-runner /la=
va-11348115/1

    2023-08-24T17:59:34.521508  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T17:59:34.538564  + cd /lava-1134811<8>[   18.174751] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11348115_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
