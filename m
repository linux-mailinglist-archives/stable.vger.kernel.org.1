Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E584F75710E
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 02:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGRAsx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 20:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGRAsw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 20:48:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF9710DF
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 17:48:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53482b44007so3143397a12.2
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 17:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689641329; x=1692233329;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CleJ001yQbSaOC9+rrG4P/RDQY05ToKjFPvQSEC7xnM=;
        b=ra2OM+dO3PZkCY4nNgntwE+EC7RELy/DJnk3TqCBq1yicmb+CJAmsPUGU+7uguRrAd
         kfx1zpOL0Th5Hq1nQgrwfq9eNee2aoMx2L2Y1doF3A6bSiv0HAc4vUSPhE0qypRSWLSn
         /jvnext59zveCRHNN1yTlgV4YOkNzWd1+TTuOEFQa1uiy0PYeFbTouI6cJYB8+W73YsM
         rz9img2U0jY5tr5UvMlJfrV/wFfnmc3tQ4mwp2F0Ws1cfR3g2Kn+rnJST0bPUnmAcUix
         TGnFr9RIzxpNwFCF0DUv7CLTTMqM7xTbtviayHXsoXShmpLHbBgLHTUlNUlMGgYvdt2G
         Gu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689641329; x=1692233329;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CleJ001yQbSaOC9+rrG4P/RDQY05ToKjFPvQSEC7xnM=;
        b=bNlnZOJTPsXdeXDvwHUuovfd8AQT4w84THaNzKxbZJxUc0XRSXgznd4p0PGOZYkqXU
         3lKHONjaKvVizOp/c5YR1iKYPf6immTN6OQ5T+1j5PzTeCTWhsc/C5hGXMRrJcsCBKaJ
         ZVXURy2LetosN2ms751Ouo1OrKgmXBJaJpoMNWrG2tg6x5O4JGBy+pNAImb36dEaUFiH
         jmro9znBsns1D++AaUGcej9cNklHP0ieZqCrV8k2JvGDV4uq9q6BaGqxwjrglnqu0JpH
         hVcLvQwSyjxdVGAwg2/0xrBtyojnfikIU7xt9exs8nvPxLETb03bHPdo0D5+2SP5eo4g
         3hUw==
X-Gm-Message-State: ABy/qLabGBO4Ej76caOEs/uevTLgkvvg0sYSICaOftgtgviumQCmS1Sm
        sU4fgy6Y+Arp/60F2JPRTUzwOcQXbiNfqSrrGJf/Cg==
X-Google-Smtp-Source: APBJJlET6MxIfyM5npqfl6wv2pxG4nl2dSeHuF8GKx5SoThhXVEesAhcZv6+Lz+wHN1sSFQXKDay0A==
X-Received: by 2002:a17:90a:db17:b0:262:ffd2:ced with SMTP id g23-20020a17090adb1700b00262ffd20cedmr11298666pjv.0.1689641329155;
        Mon, 17 Jul 2023 17:48:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a001b00b00263dee538b1sm401068pja.25.2023.07.17.17.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 17:48:48 -0700 (PDT)
Message-ID: <64b5e170.170a0220.a327e.150f@mx.google.com>
Date:   Mon, 17 Jul 2023 17:48:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.38-590-gce7ec1011187
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 170 runs,
 13 regressions (v6.1.38-590-gce7ec1011187)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 170 runs, 13 regressions (v6.1.38-590-gce7e=
c1011187)

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

at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.38-590-gce7ec1011187/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.38-590-gce7ec1011187
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ce7ec101118789331617601d680d905c318b4ab6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5b08759ea42646f8ace35

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5b08759ea42646f8ace3a
        failing since 109 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-17T21:19:51.977810  + <8>[   10.492904] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11103388_1.4.2.3.1>

    2023-07-17T21:19:51.980722  set +x

    2023-07-17T21:19:52.082221  #

    2023-07-17T21:19:52.082559  =


    2023-07-17T21:19:52.183187  / # #export SHELL=3D/bin/sh

    2023-07-17T21:19:52.183359  =


    2023-07-17T21:19:52.283918  / # export SHELL=3D/bin/sh. /lava-11103388/=
environment

    2023-07-17T21:19:52.284099  =


    2023-07-17T21:19:52.384626  / # . /lava-11103388/environment/lava-11103=
388/bin/lava-test-runner /lava-11103388/1

    2023-07-17T21:19:52.384894  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5b0833fc2f775468ace4f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5b0833fc2f775468ace54
        failing since 109 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-17T21:19:42.853228  + set<8>[   11.586117] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11103412_1.4.2.3.1>

    2023-07-17T21:19:42.853661   +x

    2023-07-17T21:19:42.961154  / # #

    2023-07-17T21:19:43.062496  export SHELL=3D/bin/sh

    2023-07-17T21:19:43.063227  #

    2023-07-17T21:19:43.164756  / # export SHELL=3D/bin/sh. /lava-11103412/=
environment

    2023-07-17T21:19:43.165590  =


    2023-07-17T21:19:43.267379  / # . /lava-11103412/environment/lava-11103=
412/bin/lava-test-runner /lava-11103412/1

    2023-07-17T21:19:43.268426  =


    2023-07-17T21:19:43.272916  / # /lava-11103412/bin/lava-test-runner /la=
va-11103412/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5b095a615a9185a8ace37

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5b095a615a9185a8ace3c
        failing since 109 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-17T21:20:01.229480  <8>[   10.879779] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11103417_1.4.2.3.1>

    2023-07-17T21:20:01.233088  + set +x

    2023-07-17T21:20:01.338709  =


    2023-07-17T21:20:01.441009  / # #export SHELL=3D/bin/sh

    2023-07-17T21:20:01.441784  =


    2023-07-17T21:20:01.543261  / # export SHELL=3D/bin/sh. /lava-11103417/=
environment

    2023-07-17T21:20:01.544100  =


    2023-07-17T21:20:01.645731  / # . /lava-11103417/environment/lava-11103=
417/bin/lava-test-runner /lava-11103417/1

    2023-07-17T21:20:01.647013  =


    2023-07-17T21:20:01.652421  / # /lava-11103417/bin/lava-test-runner /la=
va-11103417/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5af2892a08c7bb48ace27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-=
sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-=
sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b5af2892a08c7bb48ac=
e28
        new failure (last pass: v6.1.38-393-gb6386e7314b4) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5af23c3c30d2ec88aceb3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b5af23c3c30d2ec88ac=
eb4
        failing since 39 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5b07e9f70ead8538aceeb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5b07e9f70ead8538acef0
        failing since 109 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-17T21:19:42.174366  + set +x

    2023-07-17T21:19:42.180326  <8>[   10.716142] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11103423_1.4.2.3.1>

    2023-07-17T21:19:42.285185  / # #

    2023-07-17T21:19:42.385857  export SHELL=3D/bin/sh

    2023-07-17T21:19:42.386034  #

    2023-07-17T21:19:42.486553  / # export SHELL=3D/bin/sh. /lava-11103423/=
environment

    2023-07-17T21:19:42.486778  =


    2023-07-17T21:19:42.587315  / # . /lava-11103423/environment/lava-11103=
423/bin/lava-test-runner /lava-11103423/1

    2023-07-17T21:19:42.587697  =


    2023-07-17T21:19:42.592164  / # /lava-11103423/bin/lava-test-runner /la=
va-11103423/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5b085afc0c132c58ace20

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5b085afc0c132c58ace25
        failing since 109 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-17T21:19:40.432084  <8>[   10.754297] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11103418_1.4.2.3.1>

    2023-07-17T21:19:40.435956  + set +x

    2023-07-17T21:19:40.543605  / # #

    2023-07-17T21:19:40.645168  export SHELL=3D/bin/sh

    2023-07-17T21:19:40.645842  #

    2023-07-17T21:19:40.746978  / # export SHELL=3D/bin/sh. /lava-11103418/=
environment

    2023-07-17T21:19:40.747308  =


    2023-07-17T21:19:40.848057  / # . /lava-11103418/environment/lava-11103=
418/bin/lava-test-runner /lava-11103418/1

    2023-07-17T21:19:40.849127  =


    2023-07-17T21:19:40.854010  / # /lava-11103418/bin/lava-test-runner /la=
va-11103418/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5b0893b21a165b78ace37

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5b0893b21a165b78ace3c
        failing since 109 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-17T21:19:47.692979  + <8>[   10.895187] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11103392_1.4.2.3.1>

    2023-07-17T21:19:47.693060  set +x

    2023-07-17T21:19:47.797260  / # #

    2023-07-17T21:19:47.897802  export SHELL=3D/bin/sh

    2023-07-17T21:19:47.898072  #

    2023-07-17T21:19:47.998534  / # export SHELL=3D/bin/sh. /lava-11103392/=
environment

    2023-07-17T21:19:47.998681  =


    2023-07-17T21:19:48.099163  / # . /lava-11103392/environment/lava-11103=
392/bin/lava-test-runner /lava-11103392/1

    2023-07-17T21:19:48.099427  =


    2023-07-17T21:19:48.103975  / # /lava-11103392/bin/lava-test-runner /la=
va-11103392/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5b08aafc0c132c58ace2e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5b08aafc0c132c58ace33
        failing since 109 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-17T21:20:02.652807  <8>[   11.709282] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11103422_1.4.2.3.1>

    2023-07-17T21:20:02.757592  / # #

    2023-07-17T21:20:02.858163  export SHELL=3D/bin/sh

    2023-07-17T21:20:02.858328  #

    2023-07-17T21:20:02.958852  / # export SHELL=3D/bin/sh. /lava-11103422/=
environment

    2023-07-17T21:20:02.959014  =


    2023-07-17T21:20:03.059516  / # . /lava-11103422/environment/lava-11103=
422/bin/lava-test-runner /lava-11103422/1

    2023-07-17T21:20:03.059755  =


    2023-07-17T21:20:03.064395  / # /lava-11103422/bin/lava-test-runner /la=
va-11103422/1

    2023-07-17T21:20:03.071680  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5ae81e67adcbce28ace39

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5ae81e67adcbce28ace3e
        new failure (last pass: v6.1.38-393-gb6386e7314b4)

    2023-07-17T21:12:52.332620  / # #

    2023-07-17T21:12:52.434731  export SHELL=3D/bin/sh

    2023-07-17T21:12:52.435428  #

    2023-07-17T21:12:52.536691  / # export SHELL=3D/bin/sh. /lava-11103315/=
environment

    2023-07-17T21:12:52.537428  =


    2023-07-17T21:12:52.638836  / # . /lava-11103315/environment/lava-11103=
315/bin/lava-test-runner /lava-11103315/1

    2023-07-17T21:12:52.639912  =


    2023-07-17T21:12:52.656944  / # /lava-11103315/bin/lava-test-runner /la=
va-11103315/1

    2023-07-17T21:12:52.704916  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-17T21:12:52.705423  + cd /lav<8>[   19.102131] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11103315_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5ae95e31e7e622c8ace1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5ae95e31e7e622c8ace22
        new failure (last pass: v6.1.38-393-gb6386e7314b4)

    2023-07-17T21:11:37.258534  / # #

    2023-07-17T21:11:38.332623  export SHELL=3D/bin/sh

    2023-07-17T21:11:38.333914  #

    2023-07-17T21:11:39.817340  / # export SHELL=3D/bin/sh. /lava-11103322/=
environment

    2023-07-17T21:11:39.818595  =


    2023-07-17T21:11:42.535490  / # . /lava-11103322/environment/lava-11103=
322/bin/lava-test-runner /lava-11103322/1

    2023-07-17T21:11:42.537750  =


    2023-07-17T21:11:42.541953  / # /lava-11103322/bin/lava-test-runner /la=
va-11103322/1

    2023-07-17T21:11:42.605680  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-17T21:11:42.606147  + cd /lava-111033<8>[   28.411611] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11103322_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5aea1bb071b6e158ace4b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5aea1bb071b6e158ace50
        new failure (last pass: v6.1.38-393-gb6386e7314b4)

    2023-07-17T21:11:33.135660  / # #
    2023-07-17T21:11:33.237437  export SHELL=3D/bin/sh
    2023-07-17T21:11:33.237813  #
    2023-07-17T21:11:33.339148  / # export SHELL=3D/bin/sh. /lava-3721476/e=
nvironment
    2023-07-17T21:11:33.339538  =

    2023-07-17T21:11:33.440885  / # . /lava-3721476/environment/lava-372147=
6/bin/lava-test-runner /lava-3721476/1
    2023-07-17T21:11:33.441580  =

    2023-07-17T21:11:33.446533  / # /lava-3721476/bin/lava-test-runner /lav=
a-3721476/1
    2023-07-17T21:11:33.524314  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-17T21:11:33.524894  + cd /lava-3721476<8>[   18.770840] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3721476_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5ae82e67adcbce28ace47

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.38-=
590-gce7ec1011187/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5ae82e67adcbce28ace4c
        new failure (last pass: v6.1.38-393-gb6386e7314b4)

    2023-07-17T21:13:03.728575  / # #

    2023-07-17T21:13:03.830618  export SHELL=3D/bin/sh

    2023-07-17T21:13:03.831326  #

    2023-07-17T21:13:03.932734  / # export SHELL=3D/bin/sh. /lava-11103319/=
environment

    2023-07-17T21:13:03.933483  =


    2023-07-17T21:13:04.034927  / # . /lava-11103319/environment/lava-11103=
319/bin/lava-test-runner /lava-11103319/1

    2023-07-17T21:13:04.036022  =


    2023-07-17T21:13:04.053019  / # /lava-11103319/bin/lava-test-runner /la=
va-11103319/1

    2023-07-17T21:13:04.118984  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-17T21:13:04.119512  + cd /lava-11103319/1/tests/1_boot<8>[   16=
.963330] <LAVA_SIGNAL_STARTRUN 1_bootrr 11103319_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
