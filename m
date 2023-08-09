Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA16776211
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjHIOJW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjHIOJV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 10:09:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF7F1FEE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 07:09:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso6496538b3a.3
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691590159; x=1692194959;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HMWQws7G+vqcol8F9kcwR2jX64rmpU4fpG3FYHGDyAQ=;
        b=uvg++yp7yuKbdvLBuKgL6jEZsR9VDTh5SiLDJXzSQCOuhwYCfzYJD8MvzURKAIXUEf
         cY/WQon02lgRFRAlWAt50mH4ytIYeI6wlPnI1ISuX5p8ubGJWRdq2wnzATHLrKuyqJPw
         lOLKNcJm9zLL8BbFMAlqW0Yk9O3doit3FThWw7lGC9csYg26zy3EaxEIXb9ZRmq34Ij0
         j5b8mn02I8jQGg6caH2TW4K+2Wh+wYuvu+hLx8Yv4tNi6F/LgHNkCqFdZ9UKrYqacOK9
         8wDA7QJygLdgGKIm1KEhVkoP048V3g2Baty9WR4rEjVIFQbzz6bdATXb83axERIREUVu
         TEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691590159; x=1692194959;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMWQws7G+vqcol8F9kcwR2jX64rmpU4fpG3FYHGDyAQ=;
        b=kpYNNYmGHuh/HKQZt6cllLgMxEV1uZzd9n65xyE1HK0PBXxM7llo1djBo3gC3FjRR8
         dgXiBeYin2w6ZShiKEnwx6woge382PUz3qMpOJJPjF1+pnrYgz5AmY87I/kahArKhFk6
         QOetiGFA5xJ834Ys7N8O/OPKmzIqd+49/BdlVmTuZxdWV54IxvEmkBN7I3GAj1koWHYY
         6DFmMB+mf/Knp5iKUnsmTMi0Llzh1/1s7sbkxJQ0NkR2mhTqbzKwoSr+xkpFHrOqresy
         hXtdvoaJOAHdqqohgb0Jip+nKvVwdjbBi7p1mwYumN33hZp4d22uNaFM+Ss2g/mst0gS
         z2pg==
X-Gm-Message-State: AOJu0YwbQCG609hYKfaHLj5FCqISk9yOrGMhwm8bMDv23GIU7FPxcdRi
        VDLvNVFpTGL7mM9q3523g59e7QD0mcW/YXUWzmy8RA==
X-Google-Smtp-Source: AGHT+IFLvU7cI7NAlIj4j5DtwqzmkKLmb+Lm8oUAfm4AdvX5T49XRuVysq6wj3BdSK1bwz+gqvbklg==
X-Received: by 2002:a05:6a00:80b:b0:66c:9faa:bb12 with SMTP id m11-20020a056a00080b00b0066c9faabb12mr3819461pfk.9.1691590158758;
        Wed, 09 Aug 2023 07:09:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78151000000b0064398fe3451sm9927757pfn.217.2023.08.09.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:09:17 -0700 (PDT)
Message-ID: <64d39e0d.a70a0220.f41e7.1d68@mx.google.com>
Date:   Wed, 09 Aug 2023 07:09:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.189-202-gb9dd551c546f
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 122 runs,
 13 regressions (v5.10.189-202-gb9dd551c546f)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 122 runs, 13 regressions (v5.10.189-202-gb=
9dd551c546f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
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
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.189-202-gb9dd551c546f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.189-202-gb9dd551c546f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b9dd551c546fb01fe5f91b8aaad6183005e2af20 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36cda18aa70ebe435b220

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36cda18aa70ebe435b225
        failing since 203 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-09T10:39:11.818991  <8>[   11.067274] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3734947_1.5.2.4.1>
    2023-08-09T10:39:11.929078  / # #
    2023-08-09T10:39:12.033281  export SHELL=3D/bin/sh
    2023-08-09T10:39:12.034584  #
    2023-08-09T10:39:12.137280  / # export SHELL=3D/bin/sh. /lava-3734947/e=
nvironment
    2023-08-09T10:39:12.138578  =

    2023-08-09T10:39:12.241393  / # . /lava-3734947/environment/lava-373494=
7/bin/lava-test-runner /lava-3734947/1
    2023-08-09T10:39:12.243430  =

    2023-08-09T10:39:12.248303  / # /lava-3734947/bin/lava-test-runner /lav=
a-3734947/1
    2023-08-09T10:39:12.334767  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36d2989d71c34b935b1dd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36d2989d71c34b935b1e0
        failing since 22 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-09T10:40:19.935127  [    9.484074] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242091_1.5.2.4.1>
    2023-08-09T10:40:20.040378  =

    2023-08-09T10:40:20.141536  / # #export SHELL=3D/bin/sh
    2023-08-09T10:40:20.141934  =

    2023-08-09T10:40:20.242874  / # export SHELL=3D/bin/sh. /lava-1242091/e=
nvironment
    2023-08-09T10:40:20.243286  =

    2023-08-09T10:40:20.344263  / # . /lava-1242091/environment/lava-124209=
1/bin/lava-test-runner /lava-1242091/1
    2023-08-09T10:40:20.344998  =

    2023-08-09T10:40:20.349292  / # /lava-1242091/bin/lava-test-runner /lav=
a-1242091/1
    2023-08-09T10:40:20.365722  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36d1611634c0cb035b20f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36d1611634c0cb035b212
        failing since 158 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-09T10:39:59.365320  [   10.882908] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242092_1.5.2.4.1>
    2023-08-09T10:39:59.470832  =

    2023-08-09T10:39:59.572017  / # #export SHELL=3D/bin/sh
    2023-08-09T10:39:59.572461  =

    2023-08-09T10:39:59.673422  / # export SHELL=3D/bin/sh. /lava-1242092/e=
nvironment
    2023-08-09T10:39:59.673948  =

    2023-08-09T10:39:59.774963  / # . /lava-1242092/environment/lava-124209=
2/bin/lava-test-runner /lava-1242092/1
    2023-08-09T10:39:59.775852  =

    2023-08-09T10:39:59.778651  / # /lava-1242092/bin/lava-test-runner /lav=
a-1242092/1
    2023-08-09T10:39:59.794185  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36abae22f6076bb35b208

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36abae22f6076bb35b20d
        failing since 133 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-09T10:30:11.031388  + set +x

    2023-08-09T10:30:11.037585  <8>[   14.284937] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11243889_1.4.2.3.1>

    2023-08-09T10:30:11.142319  / # #

    2023-08-09T10:30:11.242870  export SHELL=3D/bin/sh

    2023-08-09T10:30:11.243038  #

    2023-08-09T10:30:11.343525  / # export SHELL=3D/bin/sh. /lava-11243889/=
environment

    2023-08-09T10:30:11.343708  =


    2023-08-09T10:30:11.444282  / # . /lava-11243889/environment/lava-11243=
889/bin/lava-test-runner /lava-11243889/1

    2023-08-09T10:30:11.444543  =


    2023-08-09T10:30:11.449408  / # /lava-11243889/bin/lava-test-runner /la=
va-11243889/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36ad471af8daaef35b1fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36ad471af8daaef35b201
        failing since 133 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-09T10:30:35.727534  <8>[   13.074733] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11243899_1.4.2.3.1>

    2023-08-09T10:30:35.730701  + set +x

    2023-08-09T10:30:35.836160  =


    2023-08-09T10:30:35.937843  / # #export SHELL=3D/bin/sh

    2023-08-09T10:30:35.938612  =


    2023-08-09T10:30:36.040323  / # export SHELL=3D/bin/sh. /lava-11243899/=
environment

    2023-08-09T10:30:36.041053  =


    2023-08-09T10:30:36.142495  / # . /lava-11243899/environment/lava-11243=
899/bin/lava-test-runner /lava-11243899/1

    2023-08-09T10:30:36.143706  =


    2023-08-09T10:30:36.148571  / # /lava-11243899/bin/lava-test-runner /la=
va-11243899/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36e0e9f88f9235d35b202

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36e0e9f88f9235d35b23e
        new failure (last pass: v5.10.189-186-g6bbe4c818f99)

    2023-08-09T10:44:03.058603  / # #
    2023-08-09T10:44:03.161385  export SHELL=3D/bin/sh
    2023-08-09T10:44:03.162154  #
    2023-08-09T10:44:03.264070  / # export SHELL=3D/bin/sh. /lava-40710/env=
ironment
    2023-08-09T10:44:03.264832  =

    2023-08-09T10:44:03.366754  / # . /lava-40710/environment/lava-40710/bi=
n/lava-test-runner /lava-40710/1
    2023-08-09T10:44:03.368008  =

    2023-08-09T10:44:03.382494  / # /lava-40710/bin/lava-test-runner /lava-=
40710/1
    2023-08-09T10:44:03.441374  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T10:44:03.441876  + cd /lava-40710/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36d4689d71c34b935b21d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36d4689d71c34b935b220
        failing since 8 days (last pass: v5.10.186-10-g5f99a36aeb1c, first =
fail: v5.10.188-107-gc262f74329e1)

    2023-08-09T10:40:26.062948  + set +x
    2023-08-09T10:40:26.066183  <8>[   83.665371] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994825_1.5.2.4.1>
    2023-08-09T10:40:26.173266  / # #
    2023-08-09T10:40:27.634163  export SHELL=3D/bin/sh
    2023-08-09T10:40:27.655035  #
    2023-08-09T10:40:27.655412  / # export SHELL=3D/bin/sh
    2023-08-09T10:40:29.540337  / # . /lava-994825/environment
    2023-08-09T10:40:32.996229  /lava-994825/bin/lava-test-runner /lava-994=
825/1
    2023-08-09T10:40:33.016993  . /lava-994825/environment
    2023-08-09T10:40:33.017166  / # /lava-994825/bin/lava-test-runner /lava=
-994825/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36dfcee40b05ce735b20d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36dfcee40b05ce735b210
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T10:43:50.473277  + set +x
    2023-08-09T10:43:50.473494  <8>[   83.773074] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994843_1.5.2.4.1>
    2023-08-09T10:43:50.579570  / # #
    2023-08-09T10:43:52.042143  export SHELL=3D/bin/sh
    2023-08-09T10:43:52.063151  #
    2023-08-09T10:43:52.063359  / # export SHELL=3D/bin/sh
    2023-08-09T10:43:53.949008  / # . /lava-994843/environment
    2023-08-09T10:43:57.406655  /lava-994843/bin/lava-test-runner /lava-994=
843/1
    2023-08-09T10:43:57.427437  . /lava-994843/environment
    2023-08-09T10:43:57.427545  / # /lava-994843/bin/lava-test-runner /lava=
-994843/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36eebd46dbee4e235b1ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36eebd46dbee4e235b1f0
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T10:47:40.866632  + set +x
    2023-08-09T10:47:40.866849  <8>[   83.977715] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994844_1.5.2.4.1>
    2023-08-09T10:47:40.972845  / # #
    2023-08-09T10:47:42.435230  export SHELL=3D/bin/sh
    2023-08-09T10:47:42.455803  #
    2023-08-09T10:47:42.456012  / # export SHELL=3D/bin/sh
    2023-08-09T10:47:44.340907  / # . /lava-994844/environment
    2023-08-09T10:47:47.798724  /lava-994844/bin/lava-test-runner /lava-994=
844/1
    2023-08-09T10:47:47.819597  . /lava-994844/environment
    2023-08-09T10:47:47.819708  / # /lava-994844/bin/lava-test-runner /lava=
-994844/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36d70009036d73335b260

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36d70009036d73335b263
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T10:41:32.389934  / # #
    2023-08-09T10:41:33.849957  export SHELL=3D/bin/sh
    2023-08-09T10:41:33.870470  #
    2023-08-09T10:41:33.870631  / # export SHELL=3D/bin/sh
    2023-08-09T10:41:35.752810  / # . /lava-994826/environment
    2023-08-09T10:41:39.205133  /lava-994826/bin/lava-test-runner /lava-994=
826/1
    2023-08-09T10:41:39.225792  . /lava-994826/environment
    2023-08-09T10:41:39.225922  / # /lava-994826/bin/lava-test-runner /lava=
-994826/1
    2023-08-09T10:41:39.303364  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T10:41:39.303571  + cd /lava-994826/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36e4b4e107f6f6035b1df

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36e4b4e107f6f6035b1e2
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T10:45:12.355229  / # #
    2023-08-09T10:45:13.814425  export SHELL=3D/bin/sh
    2023-08-09T10:45:13.834849  #
    2023-08-09T10:45:13.834972  / # export SHELL=3D/bin/sh
    2023-08-09T10:45:15.718320  / # . /lava-994840/environment
    2023-08-09T10:45:19.171279  /lava-994840/bin/lava-test-runner /lava-994=
840/1
    2023-08-09T10:45:19.191912  . /lava-994840/environment
    2023-08-09T10:45:19.192030  / # /lava-994840/bin/lava-test-runner /lava=
-994840/1
    2023-08-09T10:45:19.271174  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T10:45:19.271399  + cd /lava-994840/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38e3353ca9bd28035b1ed

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38e3353ca9bd28035b1f2
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T13:02:55.496216  / # #

    2023-08-09T13:02:55.597024  export SHELL=3D/bin/sh

    2023-08-09T13:02:55.597272  #

    2023-08-09T13:02:55.697761  / # export SHELL=3D/bin/sh. /lava-11243953/=
environment

    2023-08-09T13:02:55.697958  =


    2023-08-09T13:02:55.798431  / # . /lava-11243953/environment/lava-11243=
953/bin/lava-test-runner /lava-11243953/1

    2023-08-09T13:02:55.798618  =


    2023-08-09T13:02:55.809775  / # /lava-11243953/bin/lava-test-runner /la=
va-11243953/1

    2023-08-09T13:02:55.856926  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T13:02:55.868736  + cd /lav<8>[   16.397713] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11243953_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d36ccad2af52644335b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-gb9dd551c546f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d36ccad2af52644335b1df
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T10:40:30.557092  / # #

    2023-08-09T10:40:30.659175  export SHELL=3D/bin/sh

    2023-08-09T10:40:30.659838  #

    2023-08-09T10:40:30.761087  / # export SHELL=3D/bin/sh. /lava-11243959/=
environment

    2023-08-09T10:40:30.761788  =


    2023-08-09T10:40:30.863242  / # . /lava-11243959/environment/lava-11243=
959/bin/lava-test-runner /lava-11243959/1

    2023-08-09T10:40:30.864343  =


    2023-08-09T10:40:30.909291  / # /lava-11243959/bin/lava-test-runner /la=
va-11243959/1

    2023-08-09T10:40:30.939531  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T10:40:30.940004  + cd /lava-1124395<8>[   18.250329] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11243959_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
