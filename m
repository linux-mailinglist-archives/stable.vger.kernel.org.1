Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB2763207
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 11:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjGZJ3G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 05:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjGZJ2g (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 05:28:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5583A9C
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 02:26:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bba04b9df3so24751225ad.0
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 02:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690363602; x=1690968402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtW9dnM7YlyXvE5nqlk+EX53naPh0oimnQZ8X+2eBLc=;
        b=n6GltnBEzyvR4ptfemGa3QwEVfKgZmSmVM8dsS2ldNw8KdPGHVbHwWJIMnpwqnYQxC
         LWlnVjjbfmi2R5YM5MHl0Yop2SeYiiMYPdrw7w7dqNOROw/dHFx8OvGcuqjGxEHezMBw
         U4mun5AWe5waS0Rf+6nHKQL14W3jGplONeDCYBHzBPZN/lYkTfHdXjUftbdMe81J7rXH
         ZzG46yNrfegDKizuv7IoQy/JJv4pTGIL4XgbYgm8g+StDZx16aqs61b2xtyjkL7VWPiG
         j4JzYJrAJhdnam/CHQ5cwpo4uaWpVjkR0AkTrjHvGsm1/w3uipd7VZFaFd14WWJio5UE
         //kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363602; x=1690968402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtW9dnM7YlyXvE5nqlk+EX53naPh0oimnQZ8X+2eBLc=;
        b=QZlzMwSfyRvu4Uoqbp6lSRCmu0RWlHjPkew7YlmP8Z/k3Oz7zRE8iO9/so6m/xfBwU
         DEH/KCXIIDo+7w1uuubxC9gm4wAr0mb0u9+Lra2tk27Gy1wRn1PobPXYTtoK6KY6vW8+
         tBZbKSxONQipU1/U8YRCtnSBWwWDc9aqV95ZvBEweUPmqrSkWJqeaud5HGvquhQeKcRp
         RGIDP2Y42ux9djvqYcF3S9ioH7liAcweojnSSwwSQFAxjDVf5I/fRhseeXP5DMHzDXce
         C4LAxThlgg4ZIwW/+BFtTk6QX4RSA7FyBJCtqNqfnDelZ6dPlk/hVJp4rgqCc4/1EdmG
         QExQ==
X-Gm-Message-State: ABy/qLaexGSbtWL4yuoioEvCFHu9JEW8cYgV7N2T8RqcBJOUWHygULHg
        WLow0hdzoNnFfbHWtaAER7j9vLyj2cpW6DCru5PIhQ==
X-Google-Smtp-Source: APBJJlFOyCIZXOz6v3a5miwG3d9YTHCcYI1tzmv2cnPmA+Aby1wUydzygMiwqIAcLBsf3oY5n5isJQ==
X-Received: by 2002:a17:903:22d1:b0:1b8:b2c6:7e8d with SMTP id y17-20020a17090322d100b001b8b2c67e8dmr1724232plg.66.1690363602183;
        Wed, 26 Jul 2023 02:26:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001b6740207d2sm12573162plg.215.2023.07.26.02.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 02:26:41 -0700 (PDT)
Message-ID: <64c0e6d1.170a0220.5010e.7d9c@mx.google.com>
Date:   Wed, 26 Jul 2023 02:26:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.187-509-g76be48121794
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 129 runs,
 11 regressions (v5.10.187-509-g76be48121794)
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

stable-rc/linux-5.10.y baseline: 129 runs, 11 regressions (v5.10.187-509-g7=
6be48121794)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.187-509-g76be48121794/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.187-509-g76be48121794
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      76be481217944567fbdcc92f135a187cc3de8158 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b70354cf00ab798ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c0b70354cf00ab798ac=
e1d
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b4a8b9814a3be78ace36

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0b4a8b9814a3be78ace39
        failing since 8 days (last pass: v5.10.142, first fail: v5.10.186-3=
32-gf98a4d3a5cec)

    2023-07-26T05:52:23.231332  [   10.341615] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1238466_1.5.2.4.1>
    2023-07-26T05:52:23.336695  =

    2023-07-26T05:52:23.437879  / # #export SHELL=3D/bin/sh
    2023-07-26T05:52:23.438285  =

    2023-07-26T05:52:23.539231  / # export SHELL=3D/bin/sh. /lava-1238466/e=
nvironment
    2023-07-26T05:52:23.539638  =

    2023-07-26T05:52:23.640638  / # . /lava-1238466/environment/lava-123846=
6/bin/lava-test-runner /lava-1238466/1
    2023-07-26T05:52:23.641354  =

    2023-07-26T05:52:23.645380  / # /lava-1238466/bin/lava-test-runner /lav=
a-1238466/1
    2023-07-26T05:52:23.659814  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b47b9bc4989fad8acecb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0b47b9bc4989fad8acece
        failing since 144 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-07-26T05:51:30.989459  [   10.406553] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1238463_1.5.2.4.1>
    2023-07-26T05:51:31.095391  =

    2023-07-26T05:51:31.196659  / # #export SHELL=3D/bin/sh
    2023-07-26T05:51:31.197103  =

    2023-07-26T05:51:31.298081  / # export SHELL=3D/bin/sh. /lava-1238463/e=
nvironment
    2023-07-26T05:51:31.298526  =

    2023-07-26T05:51:31.399539  / # . /lava-1238463/environment/lava-123846=
3/bin/lava-test-runner /lava-1238463/1
    2023-07-26T05:51:31.400293  =

    2023-07-26T05:51:31.403123  / # /lava-1238463/bin/lava-test-runner /lav=
a-1238463/1
    2023-07-26T05:51:31.418733  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b49ee9471a24658ace20

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0b49ee9471a24658ace25
        failing since 119 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-07-26T05:52:28.992565  + set +x

    2023-07-26T05:52:28.999102  <8>[   10.262764] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11143522_1.4.2.3.1>

    2023-07-26T05:52:29.103749  / # #

    2023-07-26T05:52:29.204493  export SHELL=3D/bin/sh

    2023-07-26T05:52:29.204694  #

    2023-07-26T05:52:29.305201  / # export SHELL=3D/bin/sh. /lava-11143522/=
environment

    2023-07-26T05:52:29.305426  =


    2023-07-26T05:52:29.406012  / # . /lava-11143522/environment/lava-11143=
522/bin/lava-test-runner /lava-11143522/1

    2023-07-26T05:52:29.406362  =


    2023-07-26T05:52:29.410377  / # /lava-11143522/bin/lava-test-runner /la=
va-11143522/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b49943a18c3e0c8ace1d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0b49943a18c3e0c8ace22
        failing since 119 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-07-26T05:52:18.110446  + set +x

    2023-07-26T05:52:18.117449  <8>[   10.178367] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11143509_1.4.2.3.1>

    2023-07-26T05:52:18.219988  #

    2023-07-26T05:52:18.220246  =


    2023-07-26T05:52:18.320805  / # #export SHELL=3D/bin/sh

    2023-07-26T05:52:18.320985  =


    2023-07-26T05:52:18.421551  / # export SHELL=3D/bin/sh. /lava-11143509/=
environment

    2023-07-26T05:52:18.421700  =


    2023-07-26T05:52:18.522213  / # . /lava-11143509/environment/lava-11143=
509/bin/lava-test-runner /lava-11143509/1

    2023-07-26T05:52:18.522472  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b4c4e9471a24658ace69

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0b4c4e9471a24658acea4
        failing since 8 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-26T05:52:37.913726  / # #
    2023-07-26T05:52:38.016801  export SHELL=3D/bin/sh
    2023-07-26T05:52:38.017654  #
    2023-07-26T05:52:38.119365  / # export SHELL=3D/bin/sh. /lava-10366/env=
ironment
    2023-07-26T05:52:38.120145  =

    2023-07-26T05:52:38.222101  / # . /lava-10366/environment/lava-10366/bi=
n/lava-test-runner /lava-10366/1
    2023-07-26T05:52:38.223453  =

    2023-07-26T05:52:38.236996  / # /lava-10366/bin/lava-test-runner /lava-=
10366/1
    2023-07-26T05:52:38.296787  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-26T05:52:38.297328  + cd /lava-10366/1/tests/1_bootrr =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b86fbe159d95438ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0b86fbe159d95438ace1f
        failing since 8 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-26T06:08:16.719235  + set +x
    2023-07-26T06:08:16.719450  <8>[   83.656470] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989248_1.5.2.4.1>
    2023-07-26T06:08:16.825696  / # #
    2023-07-26T06:08:18.288231  export SHELL=3D/bin/sh
    2023-07-26T06:08:18.308807  #
    2023-07-26T06:08:18.309014  / # export SHELL=3D/bin/sh
    2023-07-26T06:08:20.194112  / # . /lava-989248/environment
    2023-07-26T06:08:23.651256  /lava-989248/bin/lava-test-runner /lava-989=
248/1
    2023-07-26T06:08:23.672001  . /lava-989248/environment
    2023-07-26T06:08:23.672110  / # /lava-989248/bin/lava-test-runner /lava=
-989248/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b6cd17a1a8ac7d8ace1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0b6cd17a1a8ac7d8ace20
        failing since 8 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-26T06:01:18.727378  + set +x
    2023-07-26T06:01:18.727571  <8>[   83.950795] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989242_1.5.2.4.1>
    2023-07-26T06:01:18.833447  / # #
    2023-07-26T06:01:20.292921  export SHELL=3D/bin/sh
    2023-07-26T06:01:20.313368  #
    2023-07-26T06:01:20.313498  / # export SHELL=3D/bin/sh
    2023-07-26T06:01:22.195966  / # . /lava-989242/environment
    2023-07-26T06:01:25.647926  /lava-989242/bin/lava-test-runner /lava-989=
242/1
    2023-07-26T06:01:25.668634  . /lava-989242/environment
    2023-07-26T06:01:25.668743  / # /lava-989242/bin/lava-test-runner /lava=
-989242/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b4d7292013bd348ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0b4d7292013bd348ace1f
        failing since 8 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-26T05:53:10.634350  / # #
    2023-07-26T05:53:12.097005  export SHELL=3D/bin/sh
    2023-07-26T05:53:12.117653  #
    2023-07-26T05:53:12.117863  / # export SHELL=3D/bin/sh
    2023-07-26T05:53:14.003236  / # . /lava-989235/environment
    2023-07-26T05:53:17.461227  /lava-989235/bin/lava-test-runner /lava-989=
235/1
    2023-07-26T05:53:17.482031  . /lava-989235/environment
    2023-07-26T05:53:17.482141  / # /lava-989235/bin/lava-test-runner /lava=
-989235/1
    2023-07-26T05:53:17.561109  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-26T05:53:17.561455  + cd /lava-989235/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b67c40de3e1d8c8ace2e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0b67c40de3e1d8c8ace31
        failing since 8 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-26T05:59:57.112578  / # #
    2023-07-26T05:59:58.574649  export SHELL=3D/bin/sh
    2023-07-26T05:59:58.595239  #
    2023-07-26T05:59:58.595452  / # export SHELL=3D/bin/sh
    2023-07-26T06:00:00.481002  / # . /lava-989244/environment
    2023-07-26T06:00:03.939481  /lava-989244/bin/lava-test-runner /lava-989=
244/1
    2023-07-26T06:00:03.960312  . /lava-989244/environment
    2023-07-26T06:00:03.960425  / # /lava-989244/bin/lava-test-runner /lava=
-989244/1
    2023-07-26T06:00:04.042335  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-26T06:00:04.042555  + cd /lava-989244/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0b42dd226c1417f8ace7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
87-509-g76be48121794/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0b42dd226c1417f8ace84
        failing since 8 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-26T05:52:08.565454  / # #

    2023-07-26T05:52:08.667513  export SHELL=3D/bin/sh

    2023-07-26T05:52:08.668225  #

    2023-07-26T05:52:08.769624  / # export SHELL=3D/bin/sh. /lava-11143481/=
environment

    2023-07-26T05:52:08.770332  =


    2023-07-26T05:52:08.871743  / # . /lava-11143481/environment/lava-11143=
481/bin/lava-test-runner /lava-11143481/1

    2023-07-26T05:52:08.872831  =


    2023-07-26T05:52:08.889577  / # /lava-11143481/bin/lava-test-runner /la=
va-11143481/1

    2023-07-26T05:52:08.933395  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-26T05:52:08.947710  + cd /lava-1114348<8>[   18.358235] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11143481_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
