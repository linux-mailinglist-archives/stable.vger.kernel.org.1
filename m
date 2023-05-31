Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E95A717598
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 06:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjEaE2Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 00:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjEaE1p (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 00:27:45 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA01113
        for <stable@vger.kernel.org>; Tue, 30 May 2023 21:27:03 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6af6ec3df42so4956894a34.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 21:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685507222; x=1688099222;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Icg5TLNjQy3UHpj5A9aKlvgTGA2brzkgHc81aPb5Scg=;
        b=cQlBVrJPmeksxlUjd3xZAAi8mOlN0XJJ2eBzQMebg6AACW5UQDTIcgADs4F7ldYfTm
         A7RdG+93+M0OMzdW7/Y5XbZNYvzLzveQH5dCrVEi5uS6dvy9GoWiutjDxe4f0+FKdE2m
         TRhXI4ZOsEAE4e1eYkfV+A9EY4+o2HTfdrQd1vvNV6OGRWEl2h5d5vDJWl1NOW8fSlnv
         vCOKUCgu6qtL80qOhR0O7lo3RrZUi5G3qXEa0XixSKsHqgaF6peEB9IQUFLLtyZ5K1uv
         /RdajAe0hE2v04Rf6cBq+ZEA6sV1IPUxL4tRlqwyFDJpxDgwdLkGopjvPuhUcAVFKdSE
         dt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685507222; x=1688099222;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Icg5TLNjQy3UHpj5A9aKlvgTGA2brzkgHc81aPb5Scg=;
        b=U5nuA8cBGskJUIqTLLVAI3ohFNRMRTCjCy6meZM+cHfxTlv3HVN6cw1zqXBFi627Vi
         9DLdFfm+QOyur69ihihnWvjk0Xd3h1gE4vB5prB23CC30z1ubBX85qXM3RnIx/6SkZZL
         tPcy2X/lsgOfGD4cjObyQJNV1TaaYXlrF965eQ6/shLds+U+mx4md7Lgm+Yot9IGfaFK
         dTSI6qYf2Awd3Xm0thJgUkega44MglyZgJaWI4NeCyto02b2/YAXRQRv4tmQdTfYqRWK
         BTakSwFOsFqfo8JrGoMpP2+K7cHrGSAWTPGu2+ThebsTyu4piDGenu3mXiYq3jXQVXKX
         2Ywg==
X-Gm-Message-State: AC+VfDzsiVMX0JiSstI1KzYyViXMfhBjhkhU1e/TXaa/PcaaQ8PziIeE
        hc/epd3BPdM4OD6GOxUkuDu1ze2XqzlISdPaXOz3yg==
X-Google-Smtp-Source: ACHHUZ6bSrVwcd7ls33IjEIKaw42JB3Z/IUn6n7kNugucA2hftIs2Ltj/gl4glZ7HKFGMQlGvY6fgw==
X-Received: by 2002:a05:6358:6f8e:b0:123:1a41:3d8 with SMTP id s14-20020a0563586f8e00b001231a4103d8mr715439rwn.29.1685507221851;
        Tue, 30 May 2023 21:27:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090ab39100b0024df400a9e6sm218928pjr.37.2023.05.30.21.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 21:27:01 -0700 (PDT)
Message-ID: <6476cc95.170a0220.916b3.06e1@mx.google.com>
Date:   Tue, 30 May 2023 21:27:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.31-26-gef50524405c2
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 166 runs,
 8 regressions (v6.1.31-26-gef50524405c2)
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

stable-rc/queue/6.1 baseline: 166 runs, 8 regressions (v6.1.31-26-gef505244=
05c2)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.31-26-gef50524405c2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.31-26-gef50524405c2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ef50524405c2e132c80d1d177add6e426cf041c5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476976e79f44d74002e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476976e79f44d74002e85f9
        failing since 63 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-31T00:39:56.117327  + set +x

    2023-05-31T00:39:56.123900  <8>[   11.138007] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10534818_1.4.2.3.1>

    2023-05-31T00:39:56.229192  / # #

    2023-05-31T00:39:56.331460  export SHELL=3D/bin/sh

    2023-05-31T00:39:56.332389  #

    2023-05-31T00:39:56.433901  / # export SHELL=3D/bin/sh. /lava-10534818/=
environment

    2023-05-31T00:39:56.434635  =


    2023-05-31T00:39:56.536189  / # . /lava-10534818/environment/lava-10534=
818/bin/lava-test-runner /lava-10534818/1

    2023-05-31T00:39:56.537448  =


    2023-05-31T00:39:56.542951  / # /lava-10534818/bin/lava-test-runner /la=
va-10534818/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64769767648a2d01592e87d5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64769767648a2d01592e87da
        failing since 63 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-31T00:39:45.364745  + set<8>[   11.258099] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10534859_1.4.2.3.1>

    2023-05-31T00:39:45.364831   +x

    2023-05-31T00:39:45.468960  / # #

    2023-05-31T00:39:45.569648  export SHELL=3D/bin/sh

    2023-05-31T00:39:45.569843  #

    2023-05-31T00:39:45.670371  / # export SHELL=3D/bin/sh. /lava-10534859/=
environment

    2023-05-31T00:39:45.670584  =


    2023-05-31T00:39:45.771108  / # . /lava-10534859/environment/lava-10534=
859/bin/lava-test-runner /lava-10534859/1

    2023-05-31T00:39:45.771388  =


    2023-05-31T00:39:45.776544  / # /lava-10534859/bin/lava-test-runner /la=
va-10534859/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476975b648a2d01592e874b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476975b648a2d01592e8750
        failing since 63 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-31T00:39:31.746020  <8>[   10.384121] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10534838_1.4.2.3.1>

    2023-05-31T00:39:31.749585  + set +x

    2023-05-31T00:39:31.850722  #

    2023-05-31T00:39:31.951674  / # #export SHELL=3D/bin/sh

    2023-05-31T00:39:31.952812  =


    2023-05-31T00:39:32.054587  / # export SHELL=3D/bin/sh. /lava-10534838/=
environment

    2023-05-31T00:39:32.054807  =


    2023-05-31T00:39:32.155309  / # . /lava-10534838/environment/lava-10534=
838/bin/lava-test-runner /lava-10534838/1

    2023-05-31T00:39:32.155552  =


    2023-05-31T00:39:32.160780  / # /lava-10534838/bin/lava-test-runner /la=
va-10534838/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64769932dcb3a569dd2e8602

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-=
xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-=
xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64769932dcb3a569dd2e8=
603
        failing since 40 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64769750a42ca2339d2e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64769750a42ca2339d2e8630
        failing since 63 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-31T00:39:34.703544  + set +x

    2023-05-31T00:39:34.709966  <8>[   10.607335] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10534841_1.4.2.3.1>

    2023-05-31T00:39:34.814806  / # #

    2023-05-31T00:39:34.915423  export SHELL=3D/bin/sh

    2023-05-31T00:39:34.915616  #

    2023-05-31T00:39:35.016097  / # export SHELL=3D/bin/sh. /lava-10534841/=
environment

    2023-05-31T00:39:35.016314  =


    2023-05-31T00:39:35.116801  / # . /lava-10534841/environment/lava-10534=
841/bin/lava-test-runner /lava-10534841/1

    2023-05-31T00:39:35.117093  =


    2023-05-31T00:39:35.122563  / # /lava-10534841/bin/lava-test-runner /la=
va-10534841/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64769755648a2d01592e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64769755648a2d01592e85f6
        failing since 63 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-31T00:39:37.551979  <8>[   10.665486] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10534833_1.4.2.3.1>

    2023-05-31T00:39:37.555143  + set +x

    2023-05-31T00:39:37.659974  #

    2023-05-31T00:39:37.661118  =


    2023-05-31T00:39:37.762767  / # #export SHELL=3D/bin/sh

    2023-05-31T00:39:37.763566  =


    2023-05-31T00:39:37.864926  / # export SHELL=3D/bin/sh. /lava-10534833/=
environment

    2023-05-31T00:39:37.865693  =


    2023-05-31T00:39:37.967074  / # . /lava-10534833/environment/lava-10534=
833/bin/lava-test-runner /lava-10534833/1

    2023-05-31T00:39:37.968327  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647697676401d6c27d2e86c5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647697676401d6c27d2e86ca
        failing since 63 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-31T00:39:43.650870  + <8>[   11.686066] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10534834_1.4.2.3.1>

    2023-05-31T00:39:43.651418  set +x

    2023-05-31T00:39:43.759482  / # #

    2023-05-31T00:39:43.861567  export SHELL=3D/bin/sh

    2023-05-31T00:39:43.861929  #

    2023-05-31T00:39:43.962883  / # export SHELL=3D/bin/sh. /lava-10534834/=
environment

    2023-05-31T00:39:43.963712  =


    2023-05-31T00:39:44.065277  / # . /lava-10534834/environment/lava-10534=
834/bin/lava-test-runner /lava-10534834/1

    2023-05-31T00:39:44.066538  =


    2023-05-31T00:39:44.070826  / # /lava-10534834/bin/lava-test-runner /la=
va-10534834/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476974ba42ca2339d2e8615

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.31-26=
-gef50524405c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476974ba42ca2339d2e861a
        failing since 63 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-31T00:39:28.461822  <8>[   12.340469] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10534827_1.4.2.3.1>

    2023-05-31T00:39:28.565705  / # #

    2023-05-31T00:39:28.666223  export SHELL=3D/bin/sh

    2023-05-31T00:39:28.666382  #

    2023-05-31T00:39:28.766835  / # export SHELL=3D/bin/sh. /lava-10534827/=
environment

    2023-05-31T00:39:28.767013  =


    2023-05-31T00:39:28.867649  / # . /lava-10534827/environment/lava-10534=
827/bin/lava-test-runner /lava-10534827/1

    2023-05-31T00:39:28.868858  =


    2023-05-31T00:39:28.873711  / # /lava-10534827/bin/lava-test-runner /la=
va-10534827/1

    2023-05-31T00:39:28.879970  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20
