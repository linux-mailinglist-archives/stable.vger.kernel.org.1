Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DBD70D004
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 03:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEWBD6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 21:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjEWBDe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 21:03:34 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D559102
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:02:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53033a0b473so4759592a12.0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684803756; x=1687395756;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BoShXwk9zrLq+UyiFIWy51ONefJU1V5a5EQ81VC4oQs=;
        b=Yv24eoykc6GAcEAXLReTeNl++vJ61cxb93JgyC02v28TRqP8WZbbdYupf+GtqPJUio
         VPIjbqthmj/qV4F/2GM7LrKSvmnq39ESn9iHW10xK3gQhbMDAiJqJvMhfHVpXAouBR5G
         x8wxlFxb1vArZrvNx/4qE6K686ffp2niPbOlNN42BKNoWeG6jwrdcMPa/BQLqW2c64eP
         +pQd/bcK66CLDMFjQI27ZXywWV1Dg9tO7DTBZSo9ajdqoALDRUUFsQwUObOWYZ76Ud7q
         /r3k01M9JMTkvo8pY/7bROp49RNA9wojmPDE33z/d1MOUaZrgB6d136EmXPiJeFrqpeG
         nYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684803756; x=1687395756;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoShXwk9zrLq+UyiFIWy51ONefJU1V5a5EQ81VC4oQs=;
        b=DOnkLdB/krry/PLqpsfenLRA3lYMbbtzpxmyGdFuFhKM33QCdmKO8o15UMFP6Dgyyh
         Nv1bLMty2q+W6K7Aqy5bufsv0d31P3Ev09ZCJYqx37iYhlaiL53KMMPMdyzxNYi5GE/8
         ALG/1A7fvTqr2kMhzmTsA1oYurErvTO2l9hFrezqwl2LCBle3wsDfQgfYukp22XAgtUE
         6nLyGsUKNFdTmBBDwDBedOKmIPJUH3iTw+ah42dRVQ+el9EkXJKmzMeX0VqHRw8DJfba
         fl1rFX8yRNwx0vhWFgQz9M+7i2rIMvqjNzzxzC2DKp0HGowYm+Qtn0vaB8zZOqESKgcp
         iLhw==
X-Gm-Message-State: AC+VfDwvrAGllDWNKfelTrOP80vwHd/LNnJSF9y2uBwOqZdIHc+5fXjx
        9ILRN8Tww1Q6OiWJTy//rNR6O+9PCdqbTWFX97YEqQ==
X-Google-Smtp-Source: ACHHUZ5yPCCaFRi9cyySQwpjRhKTCO5BbUA8JYm5AVvEDnWh0i76N2h9VDgMdCSNJ2xSiYqmmeacwg==
X-Received: by 2002:a17:902:7c97:b0:1ae:3e5b:31b1 with SMTP id y23-20020a1709027c9700b001ae3e5b31b1mr12584485pll.9.1684803756101;
        Mon, 22 May 2023 18:02:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b001a6b2813c13sm5453421ple.172.2023.05.22.18.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:02:35 -0700 (PDT)
Message-ID: <646c10ab.170a0220.61200.97fc@mx.google.com>
Date:   Mon, 22 May 2023 18:02:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-292-g32cf2b40a0008
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 129 runs,
 8 regressions (v6.1.29-292-g32cf2b40a0008)
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

stable-rc/queue/6.1 baseline: 129 runs, 8 regressions (v6.1.29-292-g32cf2b4=
0a0008)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-292-g32cf2b40a0008/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-292-g32cf2b40a0008
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      32cf2b40a00084feab7bbed63daa7630c3dd37a4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bd9bf25c1ca4fe82e85f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bd9bf25c1ca4fe82e85f7
        failing since 55 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T21:08:02.228635  <8>[   10.973359] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10416716_1.4.2.3.1>

    2023-05-22T21:08:02.231871  + set +x

    2023-05-22T21:08:02.333271  #

    2023-05-22T21:08:02.333566  =


    2023-05-22T21:08:02.434106  / # #export SHELL=3D/bin/sh

    2023-05-22T21:08:02.434282  =


    2023-05-22T21:08:02.534779  / # export SHELL=3D/bin/sh. /lava-10416716/=
environment

    2023-05-22T21:08:02.534980  =


    2023-05-22T21:08:02.635545  / # . /lava-10416716/environment/lava-10416=
716/bin/lava-test-runner /lava-10416716/1

    2023-05-22T21:08:02.635813  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bd9c24c03c353282e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bd9c24c03c353282e8607
        failing since 55 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T21:07:56.211491  <8>[    7.995917] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10416729_1.4.2.3.1>

    2023-05-22T21:07:56.215244  + set +x

    2023-05-22T21:07:56.316525  #

    2023-05-22T21:07:56.316823  =


    2023-05-22T21:07:56.417541  / # #export SHELL=3D/bin/sh

    2023-05-22T21:07:56.417858  =


    2023-05-22T21:07:56.518805  / # export SHELL=3D/bin/sh. /lava-10416729/=
environment

    2023-05-22T21:07:56.519550  =


    2023-05-22T21:07:56.620884  / # . /lava-10416729/environment/lava-10416=
729/bin/lava-test-runner /lava-10416729/1

    2023-05-22T21:07:56.621247  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bd9c04c03c353282e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bd9c04c03c353282e85ef
        failing since 55 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T21:07:51.159650  + set +x

    2023-05-22T21:07:51.165877  <8>[   13.274699] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10416739_1.4.2.3.1>

    2023-05-22T21:07:51.273964  / # #

    2023-05-22T21:07:51.376332  export SHELL=3D/bin/sh

    2023-05-22T21:07:51.377004  #

    2023-05-22T21:07:51.478421  / # export SHELL=3D/bin/sh. /lava-10416739/=
environment

    2023-05-22T21:07:51.479109  =


    2023-05-22T21:07:51.580473  / # . /lava-10416739/environment/lava-10416=
739/bin/lava-test-runner /lava-10416739/1

    2023-05-22T21:07:51.581546  =


    2023-05-22T21:07:51.586437  / # /lava-10416739/bin/lava-test-runner /la=
va-10416739/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bd9a938ef0c04312e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bd9a938ef0c04312e85fc
        failing since 55 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T21:07:39.026433  + set +x

    2023-05-22T21:07:39.033125  <8>[   10.658447] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10416690_1.4.2.3.1>

    2023-05-22T21:07:39.137383  / # #

    2023-05-22T21:07:39.237990  export SHELL=3D/bin/sh

    2023-05-22T21:07:39.238164  #

    2023-05-22T21:07:39.338752  / # export SHELL=3D/bin/sh. /lava-10416690/=
environment

    2023-05-22T21:07:39.338937  =


    2023-05-22T21:07:39.439432  / # . /lava-10416690/environment/lava-10416=
690/bin/lava-test-runner /lava-10416690/1

    2023-05-22T21:07:39.439703  =


    2023-05-22T21:07:39.444474  / # /lava-10416690/bin/lava-test-runner /la=
va-10416690/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bd9c525c1ca4fe82e8605

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bd9c525c1ca4fe82e860a
        failing since 55 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T21:08:03.675284  + set<8>[   11.194637] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10416720_1.4.2.3.1>

    2023-05-22T21:08:03.675865   +x

    2023-05-22T21:08:03.783927  / # #

    2023-05-22T21:08:03.886532  export SHELL=3D/bin/sh

    2023-05-22T21:08:03.887394  #

    2023-05-22T21:08:03.988957  / # export SHELL=3D/bin/sh. /lava-10416720/=
environment

    2023-05-22T21:08:03.989759  =


    2023-05-22T21:08:04.091467  / # . /lava-10416720/environment/lava-10416=
720/bin/lava-test-runner /lava-10416720/1

    2023-05-22T21:08:04.092892  =


    2023-05-22T21:08:04.097629  / # /lava-10416720/bin/lava-test-runner /la=
va-10416720/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bd9b282ed3994642e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bd9b282ed3994642e85fb
        failing since 55 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T21:07:48.923402  <8>[   12.171886] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10416733_1.4.2.3.1>

    2023-05-22T21:07:49.031036  / # #

    2023-05-22T21:07:49.133133  export SHELL=3D/bin/sh

    2023-05-22T21:07:49.133949  #

    2023-05-22T21:07:49.235501  / # export SHELL=3D/bin/sh. /lava-10416733/=
environment

    2023-05-22T21:07:49.236323  =


    2023-05-22T21:07:49.337927  / # . /lava-10416733/environment/lava-10416=
733/bin/lava-test-runner /lava-10416733/1

    2023-05-22T21:07:49.339232  =


    2023-05-22T21:07:49.344636  / # /lava-10416733/bin/lava-test-runner /la=
va-10416733/1

    2023-05-22T21:07:49.350598  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646bdec2ed7217faa12e8650

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-g32cf2b40a0008/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/646bdec2ed7217faa12e866c
        failing since 15 days (last pass: v6.1.22-704-ga3dcd1f09de2, first =
fail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-22T21:29:09.546740  /lava-10417026/1/../bin/lava-test-case

    2023-05-22T21:29:09.556218  <8>[   22.951139] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bdec2ed7217faa12e86f8
        failing since 15 days (last pass: v6.1.22-704-ga3dcd1f09de2, first =
fail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-22T21:29:04.117218  + set +x

    2023-05-22T21:29:04.124281  <8>[   17.519844] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417026_1.5.2.3.1>

    2023-05-22T21:29:04.230187  / # #

    2023-05-22T21:29:04.331304  export SHELL=3D/bin/sh

    2023-05-22T21:29:04.331565  #

    2023-05-22T21:29:04.432166  / # export SHELL=3D/bin/sh. /lava-10417026/=
environment

    2023-05-22T21:29:04.432383  =


    2023-05-22T21:29:04.532929  / # . /lava-10417026/environment/lava-10417=
026/bin/lava-test-runner /lava-10417026/1

    2023-05-22T21:29:04.533249  =


    2023-05-22T21:29:04.538701  / # /lava-10417026/bin/lava-test-runner /la=
va-10417026/1
 =

    ... (13 line(s) more)  =

 =20
