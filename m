Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893816FC9D2
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbjEIPFf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 11:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbjEIPFe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 11:05:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB3C35AE
        for <stable@vger.kernel.org>; Tue,  9 May 2023 08:05:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaebed5bd6so42450535ad.1
        for <stable@vger.kernel.org>; Tue, 09 May 2023 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683644730; x=1686236730;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KjKcKQqVEY14myv6W6zGv4BSTpsDjWLX/EUMNSw3/DY=;
        b=2OpdE5cywMHvuv/IsXU6xV8NqNJKdfeojNgiovilG8gbnics8zBqLYTRNKUtqhvqK5
         AQdc5Bw/qsLCzkwyiLPMubKeJ/Q65RsMq2MqagyKvlpVd+q37SijuPkHWCBMUyL1734r
         TtxY+172GvbRzJ3YFiacQ1ZuGS4qb4Zr6g2/dLFumwDlGiVrdcXyzvpHY3EcJeK8sqhW
         vJ953GA0rl/6cooFnm3BH42UTiIbPerr0wwOljfN1mdLUkMtpEoJK39lPXPKO2XM1jTk
         LEASqCKnbMhGqwd8CfN8uBaG5E4WXl4qn+pk0rRxcEfVS70x7p/hNnsHFmSZgttA8Ymb
         6xJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683644730; x=1686236730;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjKcKQqVEY14myv6W6zGv4BSTpsDjWLX/EUMNSw3/DY=;
        b=i56NQuZ0nUTkq9sid1t19WCX9Aju3/nZ7Xe+smIj6MTBeGZni8iqFIKFKxofaI4FzL
         nJkwvGgjUheCpCG/c48j+5OYJB8LiFqkAhOtz3BuGIQyEvwtzT+zRZVRz1CEtOfOOds4
         ZKEP+daeSEAd5ixoScDwRP29fNGspPA/8VG9pqVSmbcdcwdxQj3FQYgg7ZJQXl/mOrhC
         KNb9eQAkcwEjcHrqFmbP+qut5T/ou5KrQcR+aF2PzwS+/76oMsNO3MSnBBpsQfOC/PTT
         pNbIpMzT78p/NfDVBxGTcdk+uPebb2oLQW3n1SKuGnfWOVUZxGZjWdauZm1MaUBKu05m
         o/KA==
X-Gm-Message-State: AC+VfDwNjJ8vvjHIVN7au6zJkC/WKmwQ0Drj68UZ0s79DVpZpiyO0C6G
        OAIz4UEHC9NXPF/NcDIZPxkvKJC0kaiHAtYSC2Xkkw==
X-Google-Smtp-Source: ACHHUZ6Uqn5c4jz357YWp5AKi5tkvT/QYImO52oEA9TLX3r17aH6ZV2MUWQi54Kl/gNr+v8wvsVfOQ==
X-Received: by 2002:a17:903:1c6:b0:1ac:946e:468e with SMTP id e6-20020a17090301c600b001ac946e468emr3588748plh.57.1683644730155;
        Tue, 09 May 2023 08:05:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bf12-20020a170902b90c00b001ac95be5081sm1671807plb.307.2023.05.09.08.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:05:29 -0700 (PDT)
Message-ID: <645a6139.170a0220.dd275.32a8@mx.google.com>
Date:   Tue, 09 May 2023 08:05:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-1202-g7787f1dda0d3
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 129 runs,
 10 regressions (v6.1.22-1202-g7787f1dda0d3)
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

stable-rc/queue/6.1 baseline: 129 runs, 10 regressions (v6.1.22-1202-g7787f=
1dda0d3)

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
el/v6.1.22-1202-g7787f1dda0d3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-1202-g7787f1dda0d3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7787f1dda0d3f5f7fef01f8350ec13e8946f7229 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a2acf1d8c6adb462e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a2acf1d8c6adb462e85eb
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T11:12:54.981760  <8>[   10.569689] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10256150_1.4.2.3.1>

    2023-05-09T11:12:54.985262  + set +x

    2023-05-09T11:12:55.087018  =


    2023-05-09T11:12:55.187680  / # #export SHELL=3D/bin/sh

    2023-05-09T11:12:55.187944  =


    2023-05-09T11:12:55.288502  / # export SHELL=3D/bin/sh. /lava-10256150/=
environment

    2023-05-09T11:12:55.288780  =


    2023-05-09T11:12:55.389310  / # . /lava-10256150/environment/lava-10256=
150/bin/lava-test-runner /lava-10256150/1

    2023-05-09T11:12:55.389729  =


    2023-05-09T11:12:55.394603  / # /lava-10256150/bin/lava-test-runner /la=
va-10256150/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a2aabaec89cd5842e85f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a2aabaec89cd5842e85f7
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T11:12:23.329532  + set<8>[   11.367227] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10256187_1.4.2.3.1>

    2023-05-09T11:12:23.329609   +x

    2023-05-09T11:12:23.433926  / # #

    2023-05-09T11:12:23.536189  export SHELL=3D/bin/sh

    2023-05-09T11:12:23.536393  #

    2023-05-09T11:12:23.636881  / # export SHELL=3D/bin/sh. /lava-10256187/=
environment

    2023-05-09T11:12:23.637058  =


    2023-05-09T11:12:23.737534  / # . /lava-10256187/environment/lava-10256=
187/bin/lava-test-runner /lava-10256187/1

    2023-05-09T11:12:23.737895  =


    2023-05-09T11:12:23.742500  / # /lava-10256187/bin/lava-test-runner /la=
va-10256187/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a2ab96516e626c82e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a2ab96516e626c82e8606
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T11:12:43.013870  <8>[   11.289914] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10256147_1.4.2.3.1>

    2023-05-09T11:12:43.017089  + set +x

    2023-05-09T11:12:43.119368  =


    2023-05-09T11:12:43.220163  / # #export SHELL=3D/bin/sh

    2023-05-09T11:12:43.220500  =


    2023-05-09T11:12:43.321155  / # export SHELL=3D/bin/sh. /lava-10256147/=
environment

    2023-05-09T11:12:43.321465  =


    2023-05-09T11:12:43.422131  / # . /lava-10256147/environment/lava-10256=
147/bin/lava-test-runner /lava-10256147/1

    2023-05-09T11:12:43.422604  =


    2023-05-09T11:12:43.427507  / # /lava-10256147/bin/lava-test-runner /la=
va-10256147/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a30a92a62a65f312e8620

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a30a92a62a65f312e8625
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T11:38:02.209464  + set +x

    2023-05-09T11:38:02.216078  <8>[   11.032124] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10256220_1.4.2.3.1>

    2023-05-09T11:38:02.321414  / # #

    2023-05-09T11:38:02.422082  export SHELL=3D/bin/sh

    2023-05-09T11:38:02.422363  #

    2023-05-09T11:38:02.522951  / # export SHELL=3D/bin/sh. /lava-10256220/=
environment

    2023-05-09T11:38:02.523139  =


    2023-05-09T11:38:02.623703  / # . /lava-10256220/environment/lava-10256=
220/bin/lava-test-runner /lava-10256220/1

    2023-05-09T11:38:02.624052  =


    2023-05-09T11:38:02.628466  / # /lava-10256220/bin/lava-test-runner /la=
va-10256220/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a2ab5eaeb66a27c2e85f8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a2ab5eaeb66a27c2e85fd
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T11:12:30.279519  <8>[    9.917703] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10256175_1.4.2.3.1>

    2023-05-09T11:12:30.282428  + set +x

    2023-05-09T11:12:30.383903  /#

    2023-05-09T11:12:30.484700   # #export SHELL=3D/bin/sh

    2023-05-09T11:12:30.484950  =


    2023-05-09T11:12:30.585552  / # export SHELL=3D/bin/sh. /lava-10256175/=
environment

    2023-05-09T11:12:30.585773  =


    2023-05-09T11:12:30.686333  / # . /lava-10256175/environment/lava-10256=
175/bin/lava-test-runner /lava-10256175/1

    2023-05-09T11:12:30.686663  =


    2023-05-09T11:12:30.691350  / # /lava-10256175/bin/lava-test-runner /la=
va-10256175/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a2ab603a0ef52bd2e8d20

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a2ab603a0ef52bd2e8d25
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T11:12:47.710728  + set<8>[   12.659133] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10256180_1.4.2.3.1>

    2023-05-09T11:12:47.710842   +x

    2023-05-09T11:12:47.815123  / # #

    2023-05-09T11:12:47.915837  export SHELL=3D/bin/sh

    2023-05-09T11:12:47.916077  #

    2023-05-09T11:12:48.016617  / # export SHELL=3D/bin/sh. /lava-10256180/=
environment

    2023-05-09T11:12:48.016837  =


    2023-05-09T11:12:48.117389  / # . /lava-10256180/environment/lava-10256=
180/bin/lava-test-runner /lava-10256180/1

    2023-05-09T11:12:48.117747  =


    2023-05-09T11:12:48.122673  / # /lava-10256180/bin/lava-test-runner /la=
va-10256180/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a2ea8fa3f7890b82e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a2ea8fa3f7890b82e85fc
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T11:29:27.455355  + set<8>[   11.305106] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10256208_1.4.2.3.1>

    2023-05-09T11:29:27.455475   +x

    2023-05-09T11:29:27.559690  / # #

    2023-05-09T11:29:27.660434  export SHELL=3D/bin/sh

    2023-05-09T11:29:27.660677  #

    2023-05-09T11:29:27.761246  / # export SHELL=3D/bin/sh. /lava-10256208/=
environment

    2023-05-09T11:29:27.761492  =


    2023-05-09T11:29:27.862077  / # . /lava-10256208/environment/lava-10256=
208/bin/lava-test-runner /lava-10256208/1

    2023-05-09T11:29:27.862471  =


    2023-05-09T11:29:27.866835  / # /lava-10256208/bin/lava-test-runner /la=
va-10256208/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645a2f807fa0ad88e92e85fe

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645a2f807fa0ad88e92e861a
        failing since 2 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-09T11:32:56.640611  /lava-10256521/1/../bin/lava-test-case

    2023-05-09T11:32:56.647539  <8>[   23.182871] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a2f807fa0ad88e92e86a6
        failing since 2 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-09T11:32:51.134299  + set +x

    2023-05-09T11:32:51.140557  <8>[   17.674468] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10256521_1.5.2.3.1>

    2023-05-09T11:32:51.245587  / # #

    2023-05-09T11:32:51.346504  export SHELL=3D/bin/sh

    2023-05-09T11:32:51.346703  #

    2023-05-09T11:32:51.447188  / # export SHELL=3D/bin/sh. /lava-10256521/=
environment

    2023-05-09T11:32:51.447382  =


    2023-05-09T11:32:51.547928  / # . /lava-10256521/environment/lava-10256=
521/bin/lava-test-runner /lava-10256521/1

    2023-05-09T11:32:51.548470  =


    2023-05-09T11:32:51.553808  / # /lava-10256521/bin/lava-test-runner /la=
va-10256521/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645a2aa27892e295cf2e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mi=
ps-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
02-g7787f1dda0d3/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mi=
ps-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645a2aa27892e295cf2e8=
5f3
        failing since 1 day (last pass: v6.1.22-1159-g8729cbdc1402, first f=
ail: v6.1.22-1196-g571a2463c150b) =

 =20
