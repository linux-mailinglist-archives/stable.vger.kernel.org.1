Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF8E791743
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 14:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjIDMhs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 08:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjIDMhs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 08:37:48 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B0CEC
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 05:37:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-56963f2e48eso555096a12.1
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693831063; x=1694435863; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nU+Qd9ZXyFy1c/IHO7S96Y9O5g+q1Kp/BD/v5Tc0PEo=;
        b=GnjnucebQ7+tzPjMDvJXdgQfhZRLzOEmAFdRrNSTSADeZADRFTqRjMxVUl7S4ooHJy
         fqIbTMCsyWjoUvf69U4IIq4oFXVnSwV+SCuKp9EEcHKn5PgSN+6V/to8LnTwaExETFym
         WhMdQiy/WSb5IFNVl0c1Zk2cYua0E7HMtuYs7b83F2ZCyEGpGm8A4pk0L0rv+BqK9EfK
         3OHhC8I6c0zALA0UANMiTH10oLLubZTGdZexJ+hyUtdS6JNngvJ3dmEFM/+5r+/4tj+l
         EXNLVsf5OfdE2yktZu8qJ9Wd5Ul81MmolgNtm4YdUDw9LiY4vFMfmFIRse2VvB+bmNUw
         rcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693831063; x=1694435863;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nU+Qd9ZXyFy1c/IHO7S96Y9O5g+q1Kp/BD/v5Tc0PEo=;
        b=cfLCBOXOVqe0u5R1i+zcydPOG38fHGyEumW6uxuL0wGvJeOd+SSZTspH2eC3SfdUIP
         Ok8CPtvkNqePpfTfeHsT8DhXOJOWLHC26fi3nSS+7e4+AMTUMXVINMZ3O1bLULlWzAGz
         EBaf2WKbXwKJqOw4+/CJ4y6YbGsglgLaXUrpKi/ONqhpTdsTOwna/rJdSJ9UPOgqhbcw
         2yrNSV3lNTK4luQnMYsFk3UNiIBvGBIUNMuoIzySozQqgG6McmQEA5nfDBSnoq4jWIAZ
         VBvjXDNL8QhjqsfnNU90TvIBFgpj5hN1/EpDQvAJNRK4J1DXCnrGyIMbE8Ug9GqMFkJj
         UyMw==
X-Gm-Message-State: AOJu0Yzh+9oTQFBLc2QTEAyj9jspFqR70ioThhZETk5QS4Xa0IYjAZX3
        L79+xkeoPGJbc3IR6VvY9wonzkRo0OXXo7rYGe4=
X-Google-Smtp-Source: AGHT+IEERCGjkAk84cTB+a38iSwHzP5l4QttxbTB3H1KGoRFrYSwkaDa6eap+/XnGrFPm2bnH9W7JQ==
X-Received: by 2002:a05:6a20:7f97:b0:140:a25:1c1d with SMTP id d23-20020a056a207f9700b001400a251c1dmr10501520pzj.51.1693831062827;
        Mon, 04 Sep 2023 05:37:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w1-20020a63a741000000b0056b6d1ac949sm7553136pgo.13.2023.09.04.05.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 05:37:42 -0700 (PDT)
Message-ID: <64f5cf96.630a0220.796e8.e4c1@mx.google.com>
Date:   Mon, 04 Sep 2023 05:37:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.130-27-g8b47c0181c8e
Subject: stable-rc/linux-5.15.y baseline: 96 runs,
 9 regressions (v5.15.130-27-g8b47c0181c8e)
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

stable-rc/linux-5.15.y baseline: 96 runs, 9 regressions (v5.15.130-27-g8b47=
c0181c8e)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.130-27-g8b47c0181c8e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.130-27-g8b47c0181c8e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8b47c0181c8e7dac2978a87dcad976913f34e282 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59a418e28510dfb286da9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f59a418e28510dfb286dae
        failing since 159 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-04T08:50:03.049986  <8>[   10.884564] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11428568_1.4.2.3.1>

    2023-09-04T08:50:03.053368  + set +x

    2023-09-04T08:50:03.160909  / # #

    2023-09-04T08:50:03.263297  export SHELL=3D/bin/sh

    2023-09-04T08:50:03.264165  #

    2023-09-04T08:50:03.365706  / # export SHELL=3D/bin/sh. /lava-11428568/=
environment

    2023-09-04T08:50:03.366505  =


    2023-09-04T08:50:03.468084  / # . /lava-11428568/environment/lava-11428=
568/bin/lava-test-runner /lava-11428568/1

    2023-09-04T08:50:03.469291  =


    2023-09-04T08:50:03.476311  / # /lava-11428568/bin/lava-test-runner /la=
va-11428568/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59a2da03d3195c4286d73

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f59a2da03d3195c4286d78
        failing since 159 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-04T08:49:43.742172  <8>[    9.935448] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11428551_1.4.2.3.1>

    2023-09-04T08:49:43.745214  + set +x

    2023-09-04T08:49:43.846677  =


    2023-09-04T08:49:43.947300  / # #export SHELL=3D/bin/sh

    2023-09-04T08:49:43.947537  =


    2023-09-04T08:49:44.048095  / # export SHELL=3D/bin/sh. /lava-11428551/=
environment

    2023-09-04T08:49:44.048328  =


    2023-09-04T08:49:44.148937  / # . /lava-11428551/environment/lava-11428=
551/bin/lava-test-runner /lava-11428551/1

    2023-09-04T08:49:44.149310  =


    2023-09-04T08:49:44.154005  / # /lava-11428551/bin/lava-test-runner /la=
va-11428551/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59a345b5593a070286d9b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f59a345b5593a070286=
d9c
        failing since 40 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f599ed06ad851ef5286d7e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f599ee06ad851ef5286d81
        failing since 52 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-09-04T08:48:25.106246  [   10.658011] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1249085_1.5.2.4.1>
    2023-09-04T08:48:25.211323  =

    2023-09-04T08:48:25.312469  / # #export SHELL=3D/bin/sh
    2023-09-04T08:48:25.312869  =

    2023-09-04T08:48:25.413794  / # export SHELL=3D/bin/sh. /lava-1249085/e=
nvironment
    2023-09-04T08:48:25.414188  =

    2023-09-04T08:48:25.515187  / # . /lava-1249085/environment/lava-124908=
5/bin/lava-test-runner /lava-1249085/1
    2023-09-04T08:48:25.516006  =

    2023-09-04T08:48:25.520299  / # /lava-1249085/bin/lava-test-runner /lav=
a-1249085/1
    2023-09-04T08:48:25.536688  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59a2baac5f5d44e286d7f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f59a2baac5f5d44e286d84
        failing since 159 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-04T08:49:36.781989  <8>[   10.628949] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11428554_1.4.2.3.1>

    2023-09-04T08:49:36.785159  + set +x

    2023-09-04T08:49:36.888992  / # #

    2023-09-04T08:49:36.989700  export SHELL=3D/bin/sh

    2023-09-04T08:49:36.989879  #

    2023-09-04T08:49:37.090411  / # export SHELL=3D/bin/sh. /lava-11428554/=
environment

    2023-09-04T08:49:37.090580  =


    2023-09-04T08:49:37.191146  / # . /lava-11428554/environment/lava-11428=
554/bin/lava-test-runner /lava-11428554/1

    2023-09-04T08:49:37.191427  =


    2023-09-04T08:49:37.196566  / # /lava-11428554/bin/lava-test-runner /la=
va-11428554/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59a3f8e28510dfb286d93

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f59a3f8e28510dfb286d98
        failing since 159 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-04T08:49:51.373122  + <8>[   10.776018] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11428555_1.4.2.3.1>

    2023-09-04T08:49:51.373206  set +x

    2023-09-04T08:49:51.477780  / # #

    2023-09-04T08:49:51.578398  export SHELL=3D/bin/sh

    2023-09-04T08:49:51.578619  #

    2023-09-04T08:49:51.679174  / # export SHELL=3D/bin/sh. /lava-11428555/=
environment

    2023-09-04T08:49:51.679391  =


    2023-09-04T08:49:51.779883  / # . /lava-11428555/environment/lava-11428=
555/bin/lava-test-runner /lava-11428555/1

    2023-09-04T08:49:51.780194  =


    2023-09-04T08:49:51.785147  / # /lava-11428555/bin/lava-test-runner /la=
va-11428555/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59a428e28510dfb286db4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f59a428e28510dfb286db9
        failing since 159 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-04T08:49:59.653471  + set<8>[   11.463831] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11428563_1.4.2.3.1>

    2023-09-04T08:49:59.653562   +x

    2023-09-04T08:49:59.758019  / # #

    2023-09-04T08:49:59.858652  export SHELL=3D/bin/sh

    2023-09-04T08:49:59.858900  #

    2023-09-04T08:49:59.959484  / # export SHELL=3D/bin/sh. /lava-11428563/=
environment

    2023-09-04T08:49:59.959738  =


    2023-09-04T08:50:00.060269  / # . /lava-11428563/environment/lava-11428=
563/bin/lava-test-runner /lava-11428563/1

    2023-09-04T08:50:00.060601  =


    2023-09-04T08:50:00.065013  / # /lava-11428563/bin/lava-test-runner /la=
va-11428563/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f599b6f705d29ae7286d82

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f599b6f705d29ae7286d87
        failing since 46 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-04T08:47:50.842457  / # #

    2023-09-04T08:47:51.922056  export SHELL=3D/bin/sh

    2023-09-04T08:47:51.923984  #

    2023-09-04T08:47:53.411858  / # export SHELL=3D/bin/sh. /lava-11428505/=
environment

    2023-09-04T08:47:53.413809  =


    2023-09-04T08:47:56.137736  / # . /lava-11428505/environment/lava-11428=
505/bin/lava-test-runner /lava-11428505/1

    2023-09-04T08:47:56.140009  =


    2023-09-04T08:47:56.149783  / # /lava-11428505/bin/lava-test-runner /la=
va-11428505/1

    2023-09-04T08:47:56.210122  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T08:47:56.210616  + cd /lava-114285<8>[   25.538999] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11428505_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f599a71530e94338286d8e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-27-g8b47c0181c8e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f599a71530e94338286d93
        failing since 46 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-04T08:49:00.914050  / # #

    2023-09-04T08:49:01.014487  export SHELL=3D/bin/sh

    2023-09-04T08:49:01.014609  #

    2023-09-04T08:49:01.115062  / # export SHELL=3D/bin/sh. /lava-11428513/=
environment

    2023-09-04T08:49:01.115264  =


    2023-09-04T08:49:01.215830  / # . /lava-11428513/environment/lava-11428=
513/bin/lava-test-runner /lava-11428513/1

    2023-09-04T08:49:01.216986  =


    2023-09-04T08:49:01.228417  / # /lava-11428513/bin/lava-test-runner /la=
va-11428513/1

    2023-09-04T08:49:01.289212  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T08:49:01.289352  + cd /lava-1142851<8>[   16.881972] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11428513_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
