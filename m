Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330DE6F9876
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjEGM00 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGM0Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 08:26:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A336911B5A
        for <stable@vger.kernel.org>; Sun,  7 May 2023 05:26:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24e3b69bc99so2496082a91.2
        for <stable@vger.kernel.org>; Sun, 07 May 2023 05:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683462383; x=1686054383;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L10CQjaoFIy5KfslBthpE9upnX+AaPWeVpBd4zRRmSk=;
        b=TQ248HqBl/QuM2OI2SGPYFM/35HlLAwhDpOKbkoo7RO6qfreUgTITE5m5wpAOSR/p8
         cjqJnlpEBChG8/yreaGTUE1noGALwfdooT2C2m2OSVO/Eew/OXOVtA4dqIh66NP4I2Yu
         bi5U2foLhuMiLi4GHhzOlhDJgA27HILk9s7ZAxWeLW5meSft+pW56wbcUOmydgI7875x
         Dr1v+GrFwgWta3/X/i9wDKFUEX0jV6rpxuV+hWj0DTbIxhvBDbc4V562VCKtOjc4gAMN
         6Nfh+5OHfxF9nkfgl4wDfJ8vJIPt5DeaiAR9O+lKwgGWcV+6+7WDrLJDVLqw0fsHcaVu
         849Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683462383; x=1686054383;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L10CQjaoFIy5KfslBthpE9upnX+AaPWeVpBd4zRRmSk=;
        b=l4ObAH3ynJl67pIGFPpNL8OMB58uj9v0syiZCPairsX+Mutx2rPN4Rw4N6XVozxnGh
         y/VQacNN+1XcvRiHkvDx3Zv/vywVCpS2XmBoYST0cpFQRwfnl0qia0AFP1qg9sqSveUe
         Tw5H2tnJY3kMPaZlnZib9J8VzhgUFtzGer1zTltu45n4KSaXkWWuyn9KMuwik8/9kNgI
         /EaBuIHVVGpYqJuFTNozRmUHzZh0VseCdSMkARhVnUo8AW7JnZBgOxSagPgTEsMm2Ynu
         o1CCzsQA3RjVg9zqfcGur1v/rcbAxuuVqGRt3kQ1UjKabldZtqgURfB9RCw8WJtOSZFm
         tx+Q==
X-Gm-Message-State: AC+VfDygtQHcaNCeec5XCtxZbUtUcgpvioDv4dY4dtSnpuMHE8CNiOjm
        8nrZNv7UVLMWQfBsDO2jyi/nev8FDTxCs7eWYalUlg==
X-Google-Smtp-Source: ACHHUZ698zpdAGFw4r/AzTOcQseT98/G3CEa6HuNUWjoHxRK5uJwJT/a/6G4TS2Co6VzFJD5lvTXTg==
X-Received: by 2002:a17:90b:198b:b0:24b:8480:39d6 with SMTP id mv11-20020a17090b198b00b0024b848039d6mr7469155pjb.0.1683462382575;
        Sun, 07 May 2023 05:26:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iq14-20020a17090afb4e00b0024df400a9e6sm12619932pjb.37.2023.05.07.05.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 05:26:22 -0700 (PDT)
Message-ID: <645798ee.170a0220.5f575.8c44@mx.google.com>
Date:   Sun, 07 May 2023 05:26:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-1159-g8729cbdc1402
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 163 runs,
 10 regressions (v6.1.22-1159-g8729cbdc1402)
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

stable-rc/queue/6.1 baseline: 163 runs, 10 regressions (v6.1.22-1159-g8729c=
bdc1402)

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

meson-gxbb-nanopi-k2         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-1159-g8729cbdc1402/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-1159-g8729cbdc1402
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8729cbdc14026eeef3605e111002797b7930cc59 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645761a8f1ff6aa1e72e85ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645761a8f1ff6aa1e72e85f3
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T08:30:13.729230  <8>[   10.487993] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10224534_1.4.2.3.1>

    2023-05-07T08:30:13.732736  + set +x

    2023-05-07T08:30:13.833911  #

    2023-05-07T08:30:13.834559  =


    2023-05-07T08:30:13.935746  / # #export SHELL=3D/bin/sh

    2023-05-07T08:30:13.936498  =


    2023-05-07T08:30:14.037963  / # export SHELL=3D/bin/sh. /lava-10224534/=
environment

    2023-05-07T08:30:14.038693  =


    2023-05-07T08:30:14.140166  / # . /lava-10224534/environment/lava-10224=
534/bin/lava-test-runner /lava-10224534/1

    2023-05-07T08:30:14.141304  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645761acff1cffa5192e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645761acff1cffa5192e8607
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T08:30:13.060762  + set<8>[   11.454004] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10224560_1.4.2.3.1>

    2023-05-07T08:30:13.061377   +x

    2023-05-07T08:30:13.169596  / # #

    2023-05-07T08:30:13.272382  export SHELL=3D/bin/sh

    2023-05-07T08:30:13.273204  #

    2023-05-07T08:30:13.374900  / # export SHELL=3D/bin/sh. /lava-10224560/=
environment

    2023-05-07T08:30:13.375764  =


    2023-05-07T08:30:13.477433  / # . /lava-10224560/environment/lava-10224=
560/bin/lava-test-runner /lava-10224560/1

    2023-05-07T08:30:13.478694  =


    2023-05-07T08:30:13.483953  / # /lava-10224560/bin/lava-test-runner /la=
va-10224560/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645761abff1cffa5192e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645761abff1cffa5192e85ed
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T08:30:13.192751  <8>[   11.646114] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10224552_1.4.2.3.1>

    2023-05-07T08:30:13.197345  + set +x

    2023-05-07T08:30:13.302940  =


    2023-05-07T08:30:13.404839  / # #export SHELL=3D/bin/sh

    2023-05-07T08:30:13.405619  =


    2023-05-07T08:30:13.507093  / # export SHELL=3D/bin/sh. /lava-10224552/=
environment

    2023-05-07T08:30:13.507837  =


    2023-05-07T08:30:13.609498  / # . /lava-10224552/environment/lava-10224=
552/bin/lava-test-runner /lava-10224552/1

    2023-05-07T08:30:13.610704  =


    2023-05-07T08:30:13.615840  / # /lava-10224552/bin/lava-test-runner /la=
va-10224552/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457619a0d69c891f52e861e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457619a0d69c891f52e8623
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T08:30:08.844929  + set +x

    2023-05-07T08:30:08.851441  <8>[   10.934613] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10224540_1.4.2.3.1>

    2023-05-07T08:30:08.955858  / # #

    2023-05-07T08:30:09.056779  export SHELL=3D/bin/sh

    2023-05-07T08:30:09.057017  #

    2023-05-07T08:30:09.157540  / # export SHELL=3D/bin/sh. /lava-10224540/=
environment

    2023-05-07T08:30:09.157763  =


    2023-05-07T08:30:09.258312  / # . /lava-10224540/environment/lava-10224=
540/bin/lava-test-runner /lava-10224540/1

    2023-05-07T08:30:09.258685  =


    2023-05-07T08:30:09.263385  / # /lava-10224540/bin/lava-test-runner /la=
va-10224540/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645761a15cd52fa1212e8605

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645761a15cd52fa1212e860a
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T08:30:08.794306  <8>[   10.060924] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10224504_1.4.2.3.1>

    2023-05-07T08:30:08.798002  + set +x

    2023-05-07T08:30:08.902364  / # #

    2023-05-07T08:30:09.002977  export SHELL=3D/bin/sh

    2023-05-07T08:30:09.003168  #

    2023-05-07T08:30:09.103641  / # export SHELL=3D/bin/sh. /lava-10224504/=
environment

    2023-05-07T08:30:09.103831  =


    2023-05-07T08:30:09.204354  / # . /lava-10224504/environment/lava-10224=
504/bin/lava-test-runner /lava-10224504/1

    2023-05-07T08:30:09.204652  =


    2023-05-07T08:30:09.209922  / # /lava-10224504/bin/lava-test-runner /la=
va-10224504/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645761a9f1ff6aa1e72e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645761a9f1ff6aa1e72e860c
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T08:30:12.285455  + set<8>[   11.125931] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10224524_1.4.2.3.1>

    2023-05-07T08:30:12.286029   +x

    2023-05-07T08:30:12.394214  / # #

    2023-05-07T08:30:12.496759  export SHELL=3D/bin/sh

    2023-05-07T08:30:12.497514  #

    2023-05-07T08:30:12.599126  / # export SHELL=3D/bin/sh. /lava-10224524/=
environment

    2023-05-07T08:30:12.599882  =


    2023-05-07T08:30:12.701442  / # . /lava-10224524/environment/lava-10224=
524/bin/lava-test-runner /lava-10224524/1

    2023-05-07T08:30:12.702704  =


    2023-05-07T08:30:12.707966  / # /lava-10224524/bin/lava-test-runner /la=
va-10224524/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645761a25cd52fa1212e8613

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645761a25cd52fa1212e8618
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T08:30:11.205068  + set<8>[   12.429378] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10224544_1.4.2.3.1>

    2023-05-07T08:30:11.205154   +x

    2023-05-07T08:30:11.309002  / # #

    2023-05-07T08:30:11.409595  export SHELL=3D/bin/sh

    2023-05-07T08:30:11.409773  #

    2023-05-07T08:30:11.510340  / # export SHELL=3D/bin/sh. /lava-10224544/=
environment

    2023-05-07T08:30:11.510555  =


    2023-05-07T08:30:11.611062  / # . /lava-10224544/environment/lava-10224=
544/bin/lava-test-runner /lava-10224544/1

    2023-05-07T08:30:11.611324  =


    2023-05-07T08:30:11.616188  / # /lava-10224544/bin/lava-test-runner /la=
va-10224544/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxbb-nanopi-k2         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64576501a8607496c22e85fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-na=
nopi-k2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-na=
nopi-k2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64576501a8607496c22e8=
5fb
        new failure (last pass: v6.1.22-1160-g97929780b450) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64576602d7edb40e732e85f6

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
59-g8729cbdc1402/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64576602d7edb40e732e85fa
        failing since 0 day (last pass: v6.1.22-704-ga3dcd1f09de2, first fa=
il: v6.1.22-1160-g24230ce6f2e2)

    2023-05-07T08:48:49.492772  /lava-10224738/1/../bin/lava-test-case

    2023-05-07T08:48:49.498919  <8>[   22.936313] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64576602d7edb40e732e8686
        failing since 0 day (last pass: v6.1.22-704-ga3dcd1f09de2, first fa=
il: v6.1.22-1160-g24230ce6f2e2)

    2023-05-07T08:48:44.061869  + set +x

    2023-05-07T08:48:44.068477  <8>[   17.504953] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10224738_1.5.2.3.1>

    2023-05-07T08:48:44.174846  / # #

    2023-05-07T08:48:44.275416  export SHELL=3D/bin/sh

    2023-05-07T08:48:44.275577  #

    2023-05-07T08:48:44.376032  / # export SHELL=3D/bin/sh. /lava-10224738/=
environment

    2023-05-07T08:48:44.376202  =


    2023-05-07T08:48:44.476674  / # . /lava-10224738/environment/lava-10224=
738/bin/lava-test-runner /lava-10224738/1

    2023-05-07T08:48:44.476980  =


    2023-05-07T08:48:44.482293  / # /lava-10224738/bin/lava-test-runner /la=
va-10224738/1
 =

    ... (13 line(s) more)  =

 =20
