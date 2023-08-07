Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2937726D2
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjHGN4q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHGN4T (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 09:56:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017663595
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 06:54:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so28437045ad.3
        for <stable@vger.kernel.org>; Mon, 07 Aug 2023 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691416433; x=1692021233;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uObWGDv+k+hQ0ne2dFPDeuR7d+JyBhKL2lD9tQIcMn4=;
        b=KPRKYPa373AbXiUE4SoR908Mn5RfzIqSQur/3JJR9DICLSVvzqUIwrkI9JpGD6vswq
         e3R5xlbKwyl9uBapo7s5HllBDRsJZFZ+/OPSuX8z9025k5U8rLrMZn0F7VXHYw2AARGG
         nzZanHgA8XnNNJrokkBkd+dlRbA/Zf3GX+CsAoj8jCk1SoBN8pfrs0YPAMO1n2BSgA0w
         mMDlSEkZJgCXRaSnu9n57b9PKUmQbTqTBcRyC51ocPkc11zjS/dH9Ey/RfNC60FUwkvM
         xMz5kH4I7NgZPqXT2zjRfvy0mMzaDytzgeTToEvS1Sa/fr+pwCzdF0jz4LcZoVe33O+0
         uacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416433; x=1692021233;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uObWGDv+k+hQ0ne2dFPDeuR7d+JyBhKL2lD9tQIcMn4=;
        b=OGAaD69tlQewi6e9ZNsv1/smlW88Vw8kBKTY4+xwcEiJHTXFs/l1toXM2spfxvJejd
         p9GQOn4Mmbu7Kj/WWHMKoLoFPWUcwH9mLouM5DqvAK6iEHNUz6f8oMGBQHrKTN0PCAkC
         GlYv5GHZV01yOhPdjmJU/Ux4VK/kbGARgew7967/1b1aYZI6bL/SxBb6HUYtzRrS1nCN
         Xk4e/NQKlyY+H+SML6LhU0TZZPTK6N03G4zhftJSVTRhOdKc9hmyoLFA7+Ha5g4Emk3r
         wLHICXrovO+dDDw8kv0P3f270eRbsOA8A3sPYVC25Vopo6+UfVCENdJPUD2CSmR71O5M
         GMdQ==
X-Gm-Message-State: AOJu0YxneFi3LAYumb685FFFEkd1Tzz/nP9JLDzEQkmvf7yGsi8Ffz1D
        /KHxy7zf1LkGCcx82idgp3gTvsnT+jLaHP/iioQPlw==
X-Google-Smtp-Source: AGHT+IGgMjhBkVN+Rfh0f5noZj3UsLLQnLHpXauwg56/sTZZVVSSC+sbYkj9XM6aloFTK+jBYgJKDw==
X-Received: by 2002:a17:902:d48c:b0:1bc:1df2:4c07 with SMTP id c12-20020a170902d48c00b001bc1df24c07mr9684096plg.63.1691416432638;
        Mon, 07 Aug 2023 06:53:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090282c100b001bbf7fd354csm6864884plz.213.2023.08.07.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:53:51 -0700 (PDT)
Message-ID: <64d0f76f.170a0220.6b431.c522@mx.google.com>
Date:   Mon, 07 Aug 2023 06:53:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.43-111-g565bca90c30e
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 127 runs,
 10 regressions (v6.1.43-111-g565bca90c30e)
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

stable-rc/linux-6.1.y baseline: 127 runs, 10 regressions (v6.1.43-111-g565b=
ca90c30e)

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

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.43-111-g565bca90c30e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.43-111-g565bca90c30e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      565bca90c30ecf86c2b3a78473840668ac6621f6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c47d3c5fed1c0235b1e0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0c47d3c5fed1c0235b1e5
        failing since 129 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-07T10:15:39.207568  + set +x

    2023-08-07T10:15:39.213438  <8>[   10.592634] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11221442_1.4.2.3.1>

    2023-08-07T10:15:39.322645  =


    2023-08-07T10:15:39.424896  / # #export SHELL=3D/bin/sh

    2023-08-07T10:15:39.425720  =


    2023-08-07T10:15:39.527503  / # export SHELL=3D/bin/sh. /lava-11221442/=
environment

    2023-08-07T10:15:39.528340  =


    2023-08-07T10:15:39.629941  / # . /lava-11221442/environment/lava-11221=
442/bin/lava-test-runner /lava-11221442/1

    2023-08-07T10:15:39.631246  =


    2023-08-07T10:15:39.637185  / # /lava-11221442/bin/lava-test-runner /la=
va-11221442/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c47d86e4ccd40435b1da

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0c47d86e4ccd40435b1df
        failing since 129 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-07T10:15:45.374105  + set<8>[   11.881215] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11221419_1.4.2.3.1>

    2023-08-07T10:15:45.374190   +x

    2023-08-07T10:15:45.478313  / # #

    2023-08-07T10:15:45.578831  export SHELL=3D/bin/sh

    2023-08-07T10:15:45.578968  #

    2023-08-07T10:15:45.679509  / # export SHELL=3D/bin/sh. /lava-11221419/=
environment

    2023-08-07T10:15:45.679639  =


    2023-08-07T10:15:45.780129  / # . /lava-11221419/environment/lava-11221=
419/bin/lava-test-runner /lava-11221419/1

    2023-08-07T10:15:45.780376  =


    2023-08-07T10:15:45.784938  / # /lava-11221419/bin/lava-test-runner /la=
va-11221419/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c479e3db19b55535b1e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0c479e3db19b55535b1ed
        failing since 129 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-07T10:15:31.660607  <8>[   10.310042] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11221430_1.4.2.3.1>

    2023-08-07T10:15:31.664210  + set +x

    2023-08-07T10:15:31.768302  #

    2023-08-07T10:15:31.769200  =


    2023-08-07T10:15:31.870706  / # #export SHELL=3D/bin/sh

    2023-08-07T10:15:31.871302  =


    2023-08-07T10:15:31.972626  / # export SHELL=3D/bin/sh. /lava-11221430/=
environment

    2023-08-07T10:15:31.973087  =


    2023-08-07T10:15:32.074187  / # . /lava-11221430/environment/lava-11221=
430/bin/lava-test-runner /lava-11221430/1

    2023-08-07T10:15:32.075155  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c77b94376bd6f135b1ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d0c77b94376bd6f135b=
1eb
        failing since 60 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c4765f0509846e35b1db

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0c4765f0509846e35b1e0
        failing since 129 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-07T10:15:51.188332  + set +x

    2023-08-07T10:15:51.195179  <8>[   10.166769] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11221420_1.4.2.3.1>

    2023-08-07T10:15:51.299247  / # #

    2023-08-07T10:15:51.399798  export SHELL=3D/bin/sh

    2023-08-07T10:15:51.399957  #

    2023-08-07T10:15:51.500398  / # export SHELL=3D/bin/sh. /lava-11221420/=
environment

    2023-08-07T10:15:51.500556  =


    2023-08-07T10:15:51.601041  / # . /lava-11221420/environment/lava-11221=
420/bin/lava-test-runner /lava-11221420/1

    2023-08-07T10:15:51.601314  =


    2023-08-07T10:15:51.606124  / # /lava-11221420/bin/lava-test-runner /la=
va-11221420/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c47e540207d61235b1f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0c47e540207d61235b1f8
        failing since 129 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-07T10:15:28.415636  + set<8>[   11.175064] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11221452_1.4.2.3.1>

    2023-08-07T10:15:28.415720   +x

    2023-08-07T10:15:28.520105  / # #

    2023-08-07T10:15:28.620765  export SHELL=3D/bin/sh

    2023-08-07T10:15:28.620960  #

    2023-08-07T10:15:28.721531  / # export SHELL=3D/bin/sh. /lava-11221452/=
environment

    2023-08-07T10:15:28.721746  =


    2023-08-07T10:15:28.822252  / # . /lava-11221452/environment/lava-11221=
452/bin/lava-test-runner /lava-11221452/1

    2023-08-07T10:15:28.822585  =


    2023-08-07T10:15:28.827052  / # /lava-11221452/bin/lava-test-runner /la=
va-11221452/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c4790e8e367fcd35b1e5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0c4790e8e367fcd35b1ea
        failing since 129 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-07T10:15:33.144738  + set<8>[   11.741010] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11221422_1.4.2.3.1>

    2023-08-07T10:15:33.144827   +x

    2023-08-07T10:15:33.249214  / # #

    2023-08-07T10:15:33.349840  export SHELL=3D/bin/sh

    2023-08-07T10:15:33.350027  #

    2023-08-07T10:15:33.450513  / # export SHELL=3D/bin/sh. /lava-11221422/=
environment

    2023-08-07T10:15:33.450711  =


    2023-08-07T10:15:33.551248  / # . /lava-11221422/environment/lava-11221=
422/bin/lava-test-runner /lava-11221422/1

    2023-08-07T10:15:33.551525  =


    2023-08-07T10:15:33.556211  / # /lava-11221422/bin/lava-test-runner /la=
va-11221422/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c1e780f6d8a52d35b242

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0c1e780f6d8a52d35b247
        failing since 20 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-07T10:06:53.163620  / # #

    2023-08-07T10:06:53.265828  export SHELL=3D/bin/sh

    2023-08-07T10:06:53.266515  #

    2023-08-07T10:06:53.367810  / # export SHELL=3D/bin/sh. /lava-11221363/=
environment

    2023-08-07T10:06:53.368524  =


    2023-08-07T10:06:53.470096  / # . /lava-11221363/environment/lava-11221=
363/bin/lava-test-runner /lava-11221363/1

    2023-08-07T10:06:53.471268  =


    2023-08-07T10:06:53.487847  / # /lava-11221363/bin/lava-test-runner /la=
va-11221363/1

    2023-08-07T10:06:53.536319  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-07T10:06:53.536851  + cd /lav<8>[   19.024654] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11221363_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c2254315a9854835b286

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0c2254315a9854835b28b
        failing since 20 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-07T10:06:22.880230  / # #

    2023-08-07T10:06:23.959927  export SHELL=3D/bin/sh

    2023-08-07T10:06:23.961790  #

    2023-08-07T10:06:25.451514  / # export SHELL=3D/bin/sh. /lava-11221365/=
environment

    2023-08-07T10:06:25.453456  =


    2023-08-07T10:06:28.176272  / # . /lava-11221365/environment/lava-11221=
365/bin/lava-test-runner /lava-11221365/1

    2023-08-07T10:06:28.178409  =


    2023-08-07T10:06:28.187360  / # /lava-11221365/bin/lava-test-runner /la=
va-11221365/1

    2023-08-07T10:06:28.246421  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-07T10:06:28.246922  + cd /lava-112213<8>[   28.500908] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11221365_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0c1fd80f6d8a52d35b294

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.43-=
111-g565bca90c30e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0c1fd80f6d8a52d35b299
        failing since 20 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-07T10:07:04.132362  / # #

    2023-08-07T10:07:04.234401  export SHELL=3D/bin/sh

    2023-08-07T10:07:04.235110  #

    2023-08-07T10:07:04.336508  / # export SHELL=3D/bin/sh. /lava-11221361/=
environment

    2023-08-07T10:07:04.337263  =


    2023-08-07T10:07:04.438708  / # . /lava-11221361/environment/lava-11221=
361/bin/lava-test-runner /lava-11221361/1

    2023-08-07T10:07:04.439815  =


    2023-08-07T10:07:04.456652  / # /lava-11221361/bin/lava-test-runner /la=
va-11221361/1

    2023-08-07T10:07:04.521573  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-07T10:07:04.522071  + cd /lava-11221361/1/tests/1_boot<8>[   16=
.973623] <LAVA_SIGNAL_STARTRUN 1_bootrr 11221361_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
