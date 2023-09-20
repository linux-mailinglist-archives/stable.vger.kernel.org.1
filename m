Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B6C7A89AA
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbjITQm2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjITQm1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 12:42:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3DB83
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 09:42:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so62873245ad.1
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695228139; x=1695832939; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PA5DNukDbXZmXLI3r5f2SGccW4+3/ekLvXmlNPmCWnE=;
        b=MHx3dOwoT599hv7ptqsTfbmy1RmYxNbzPBdcE37CbsBVwXnWysI0jKlShkafUTclfW
         IiKOqCwa3TOTPd3jenTjXyobTJ05IEglSHUiLKF2FYXknrj2Ot1KChJ9Nk7G8sQ1h4D6
         Bm43LcNamTnkEyndEiOiZRL9Jms/8nkU4kmsHIkajQ313hM6byY3X6YlZO45jvtLEczE
         /40Ku/fGyH/FfqvuVYv8uoBfRppbRPER7eX5+LWH0rvz5W0Dfq4c4n9tEg8yG3v/sm6J
         GTyBTsNzjb/rUXvnM0N0FmG/NErGGReWtCH3QBGP44v4U4eZSS2hNRt7BbtQeqjCoRt0
         j+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695228139; x=1695832939;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PA5DNukDbXZmXLI3r5f2SGccW4+3/ekLvXmlNPmCWnE=;
        b=MbH0bRr0l18yHOXHLpt0gTx9Z15TZa570mBiVAkQR9EXb9mW/r3ESGuij2LW6CB+s1
         r83R2rbEyI8ziziVCr3dRmX2koKf+Ntm25BuvtGdqxXxF4mhtiAtwtXMENbQhsITFhQ4
         x6wWpS3Q3Sn0V9IGPsTSbWI1s6gQTIrYSm3HDTJtg9u+O68LjfRhC27eV3nHsiPraijM
         qyZr1IgTygYf09bNMKZKuf6Ow9Chzni+TTOHOogrg3WctaDzMA+386gSmeht/8eCecHw
         q7YyglDgekRt82sb803ymUzpppf7OHPqTXcZx6Uv3/koYBCtBP15LPrYIieYKbXDx5Pd
         T7Bw==
X-Gm-Message-State: AOJu0YxSWOQ1fNFef6ugXgMNFdfk8qReIlL4Uh/qiSLKL969ZegKrouV
        WQWOfBPU9iGs94JG4KCRz/i0vk6Jph/larxEtopeXg==
X-Google-Smtp-Source: AGHT+IFIURnI57ORDE9ubd8Nx+o5e6q/9oCuoDyMORGn6NV86LjaGacaR3BX087c5Zkm4G5df70tqQ==
X-Received: by 2002:a17:903:244f:b0:1c4:375c:110a with SMTP id l15-20020a170903244f00b001c4375c110amr3906160pls.19.1695228139362;
        Wed, 20 Sep 2023 09:42:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001ab2b4105ddsm12056004plg.60.2023.09.20.09.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:42:18 -0700 (PDT)
Message-ID: <650b20ea.170a0220.e2f83.9615@mx.google.com>
Date:   Wed, 20 Sep 2023 09:42:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.132-111-g634d2466eedd
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 113 runs,
 10 regressions (v5.15.132-111-g634d2466eedd)
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

stable-rc/linux-5.15.y baseline: 113 runs, 10 regressions (v5.15.132-111-g6=
34d2466eedd)

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

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

jetson-tk1                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.132-111-g634d2466eedd/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.132-111-g634d2466eedd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      634d2466eedd8795e5251256807f08190998f237 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650aebb8936920b4b48a0a84

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650aebb8936920b4b48a0a8d
        failing since 175 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-20T12:55:03.674242  <8>[   10.184492] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11579115_1.4.2.3.1>

    2023-09-20T12:55:03.677819  + set +x

    2023-09-20T12:55:03.786470  / # #

    2023-09-20T12:55:03.889042  export SHELL=3D/bin/sh

    2023-09-20T12:55:03.889819  #

    2023-09-20T12:55:03.991464  / # export SHELL=3D/bin/sh. /lava-11579115/=
environment

    2023-09-20T12:55:03.992247  =


    2023-09-20T12:55:04.093768  / # . /lava-11579115/environment/lava-11579=
115/bin/lava-test-runner /lava-11579115/1

    2023-09-20T12:55:04.095063  =


    2023-09-20T12:55:04.101258  / # /lava-11579115/bin/lava-test-runner /la=
va-11579115/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650aeb55e09c0573b78a0a60

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650aeb55e09c0573b78a0a69
        failing since 175 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-20T12:53:19.345550  <8>[   11.149014] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11579165_1.4.2.3.1>

    2023-09-20T12:53:19.349196  + set +x

    2023-09-20T12:53:19.455482  =


    2023-09-20T12:53:19.557360  / # #export SHELL=3D/bin/sh

    2023-09-20T12:53:19.558138  =


    2023-09-20T12:53:19.659779  / # export SHELL=3D/bin/sh. /lava-11579165/=
environment

    2023-09-20T12:53:19.660540  =


    2023-09-20T12:53:19.762232  / # . /lava-11579165/environment/lava-11579=
165/bin/lava-test-runner /lava-11579165/1

    2023-09-20T12:53:19.763507  =


    2023-09-20T12:53:19.769078  / # /lava-11579165/bin/lava-test-runner /la=
va-11579165/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650af11b79a5871ef68a0a51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650af11b79a5871ef68a0=
a52
        failing since 56 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650aeb25054991f2978a0a42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650aeb25054991f2978a0a4b
        failing since 175 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-20T12:54:07.643626  <8>[   10.931277] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11579122_1.4.2.3.1>

    2023-09-20T12:54:07.647312  + set +x

    2023-09-20T12:54:07.748914  #

    2023-09-20T12:54:07.749345  =


    2023-09-20T12:54:07.850058  / # #export SHELL=3D/bin/sh

    2023-09-20T12:54:07.850321  =


    2023-09-20T12:54:07.950955  / # export SHELL=3D/bin/sh. /lava-11579122/=
environment

    2023-09-20T12:54:07.951222  =


    2023-09-20T12:54:08.051903  / # . /lava-11579122/environment/lava-11579=
122/bin/lava-test-runner /lava-11579122/1

    2023-09-20T12:54:08.052392  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650aeb41fcd57e9bae8a0a5f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650aeb41fcd57e9bae8a0a68
        failing since 175 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-20T12:53:14.389233  + set<8>[    8.582583] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11579132_1.4.2.3.1>

    2023-09-20T12:53:14.389312   +x

    2023-09-20T12:53:14.493239  / # #

    2023-09-20T12:53:14.593759  export SHELL=3D/bin/sh

    2023-09-20T12:53:14.593931  #

    2023-09-20T12:53:14.694419  / # export SHELL=3D/bin/sh. /lava-11579132/=
environment

    2023-09-20T12:53:14.694581  =


    2023-09-20T12:53:14.795192  / # . /lava-11579132/environment/lava-11579=
132/bin/lava-test-runner /lava-11579132/1

    2023-09-20T12:53:14.796633  =


    2023-09-20T12:53:14.801239  / # /lava-11579132/bin/lava-test-runner /la=
va-11579132/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
jetson-tk1                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650aece4ce93ec55f98a0a67

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-je=
tson-tk1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-je=
tson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650aece5ce93ec55f98a0=
a68
        new failure (last pass: v5.15.131-512-ga8d93816a2f2) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650aeb46054991f2978a0ac6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650aeb46054991f2978a0acf
        failing since 175 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-20T12:53:08.710475  <8>[   12.252154] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11579170_1.4.2.3.1>

    2023-09-20T12:53:08.818329  / # #

    2023-09-20T12:53:08.921121  export SHELL=3D/bin/sh

    2023-09-20T12:53:08.921811  #

    2023-09-20T12:53:09.023305  / # export SHELL=3D/bin/sh. /lava-11579170/=
environment

    2023-09-20T12:53:09.024047  =


    2023-09-20T12:53:09.125579  / # . /lava-11579170/environment/lava-11579=
170/bin/lava-test-runner /lava-11579170/1

    2023-09-20T12:53:09.126657  =


    2023-09-20T12:53:09.131857  / # /lava-11579170/bin/lava-test-runner /la=
va-11579170/1

    2023-09-20T12:53:09.136879  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/650aeb51e09c0573b78a0a52

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650aeb51e09c0573b78a0a5b
        failing since 62 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-20T12:57:35.463769  / # #

    2023-09-20T12:57:35.564266  export SHELL=3D/bin/sh

    2023-09-20T12:57:35.564371  #

    2023-09-20T12:57:35.664875  / # export SHELL=3D/bin/sh. /lava-11579143/=
environment

    2023-09-20T12:57:35.664982  =


    2023-09-20T12:57:35.765500  / # . /lava-11579143/environment/lava-11579=
143/bin/lava-test-runner /lava-11579143/1

    2023-09-20T12:57:35.765760  =


    2023-09-20T12:57:35.777300  / # /lava-11579143/bin/lava-test-runner /la=
va-11579143/1

    2023-09-20T12:57:35.830955  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-20T12:57:35.831046  + cd /lav<8>[   16.001438] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11579143_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/650aeb6a83b39611bb8a0a91

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650aeb6a83b39611bb8a0a9a
        failing since 62 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-20T12:53:51.034234  / # #

    2023-09-20T12:53:52.114006  export SHELL=3D/bin/sh

    2023-09-20T12:53:52.115770  #

    2023-09-20T12:53:53.605203  / # export SHELL=3D/bin/sh. /lava-11579151/=
environment

    2023-09-20T12:53:53.607100  =


    2023-09-20T12:53:56.330986  / # . /lava-11579151/environment/lava-11579=
151/bin/lava-test-runner /lava-11579151/1

    2023-09-20T12:53:56.333300  =


    2023-09-20T12:53:56.342269  / # /lava-11579151/bin/lava-test-runner /la=
va-11579151/1

    2023-09-20T12:53:56.404671  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-20T12:53:56.405126  + cd /lav<8>[   25.529272] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11579151_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/650aeb53e62b855ea78a0aae

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32-111-g634d2466eedd/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650aeb53e62b855ea78a0ab7
        failing since 62 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-20T12:57:49.907467  / # #

    2023-09-20T12:57:50.009361  export SHELL=3D/bin/sh

    2023-09-20T12:57:50.009970  #

    2023-09-20T12:57:50.111151  / # export SHELL=3D/bin/sh. /lava-11579147/=
environment

    2023-09-20T12:57:50.111820  =


    2023-09-20T12:57:50.213146  / # . /lava-11579147/environment/lava-11579=
147/bin/lava-test-runner /lava-11579147/1

    2023-09-20T12:57:50.214156  =


    2023-09-20T12:57:50.216209  / # /lava-11579147/bin/lava-test-runner /la=
va-11579147/1

    2023-09-20T12:57:50.260289  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-20T12:57:50.291056  + cd /lava-1157914<8>[   16.804316] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11579147_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
