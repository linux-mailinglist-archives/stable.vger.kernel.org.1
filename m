Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0789A7D3B36
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjJWPri (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjJWPrg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 11:47:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C8D7F
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 08:47:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so2757766b3a.3
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698076050; x=1698680850; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wJQIwFj8kU4C/XEcwyzThcaCHv5revkj7p8ne1qB/5k=;
        b=D/hki8Xr6pouQt/eUEBcJMseU1odLV4jqOQMR3zNmKBHQ9cwGFu62S2u8fk5ta5i2E
         vWcWQ/qoVcfhQdQvLpfIkOG2JqSJzrUHTK9DtuicpS3Z3wt/FCpX4deVwLb+dp2G8uwl
         dJvbb9u0Vh6eYRdn7Zj6Q6tR1OUuK2/l7uDCwmZDINPeENI1/Lhhmj0Wo/cUtcLNdWCo
         DIhilcRafLuAdRz5zjf/b4pMZLB5dXG0QRypxaDdH7mWz5IsqnU0GFx93z1gk7meVrwy
         06kf//q1DMaPZR4Um1wZkZ0fqJh6UFswNF6FgpqVSpoAduCW6jlp0YZy1m0pnHwnFiC3
         1Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698076050; x=1698680850;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJQIwFj8kU4C/XEcwyzThcaCHv5revkj7p8ne1qB/5k=;
        b=FsK5x2HIn/S59r6BCdVqGD4p5fEV5EcKE814y/pmDCiOpGHLGx91D9DjWhjsQWMLmZ
         uDgaoeqaivZ3KTlbdnv1AN6BEBTcupRuIYJxZ7jDQQGMz4fQawunCgQ3PBeExmcf+iov
         HvK4sJoX6QGj5k/KiQrzU+VDmekgKxSZ0Lv1YEJ2Wt4+ymUuVVQMzLu5/QLYEOSh5aNH
         gOOmJZHQU3dUN4xy5atbjQ9dX3gxjC3lPhiZMibSsJbuYTZ3Ujc1wVMZ5GzRPjjKEmeS
         5cR/hexHiwTmMmgm8no4AHCDVeSh2gOFPK05MS8iOLozd0wL4zV2ECUtt+WKPhxuvLWe
         sPeQ==
X-Gm-Message-State: AOJu0YyiM/97TE80yeNOliMabGfiiUb4Tp7Kjp8TZTgTRVBWpoyhc+wy
        7bYHHUKRmOwJOH/Z5lYAuaE0i7DJqVB2eC/hRIIt7w==
X-Google-Smtp-Source: AGHT+IGQbYcdAm64PtfoC6tMvT9KxEm4FL9EHr6aR4XilxVo06ApOqrE/Pajzx+pho39tg2Qcy/6yQ==
X-Received: by 2002:a05:6a21:4887:b0:179:f7cc:c7e6 with SMTP id av7-20020a056a21488700b00179f7ccc7e6mr7065080pzc.38.1698076050092;
        Mon, 23 Oct 2023 08:47:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7952f000000b006934e7ceb79sm6233231pfp.32.2023.10.23.08.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:47:29 -0700 (PDT)
Message-ID: <65369591.a70a0220.5c3e3.210f@mx.google.com>
Date:   Mon, 23 Oct 2023 08:47:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-328-gfa9447b759f6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 155 runs,
 10 regressions (v6.1.58-328-gfa9447b759f6)
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

stable-rc/linux-6.1.y baseline: 155 runs, 10 regressions (v6.1.58-328-gfa94=
47b759f6)

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

bcm2711-rpi-4-b              | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.58-328-gfa9447b759f6/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.58-328-gfa9447b759f6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fa9447b759f65cb3a25b4092562576311f245dff =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65365f683baf297f49efcf29

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65365f683baf297f49efcf32
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-23T11:56:26.267308  <8>[   10.032520] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11854600_1.4.2.3.1>

    2023-10-23T11:56:26.270998  + set +x

    2023-10-23T11:56:26.372902  =


    2023-10-23T11:56:26.473588  / # #export SHELL=3D/bin/sh

    2023-10-23T11:56:26.473795  =


    2023-10-23T11:56:26.574370  / # export SHELL=3D/bin/sh. /lava-11854600/=
environment

    2023-10-23T11:56:26.574567  =


    2023-10-23T11:56:26.675122  / # . /lava-11854600/environment/lava-11854=
600/bin/lava-test-runner /lava-11854600/1

    2023-10-23T11:56:26.675402  =


    2023-10-23T11:56:26.681299  / # /lava-11854600/bin/lava-test-runner /la=
va-11854600/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65365ed894e02dca4eefcf24

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65365ed894e02dca4eefcf2d
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-23T11:53:44.310346  + <8>[   10.754100] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11854523_1.4.2.3.1>

    2023-10-23T11:53:44.310430  set +x

    2023-10-23T11:53:44.414692  / # #

    2023-10-23T11:53:44.515439  export SHELL=3D/bin/sh

    2023-10-23T11:53:44.515659  #

    2023-10-23T11:53:44.616256  / # export SHELL=3D/bin/sh. /lava-11854523/=
environment

    2023-10-23T11:53:44.616449  =


    2023-10-23T11:53:44.717016  / # . /lava-11854523/environment/lava-11854=
523/bin/lava-test-runner /lava-11854523/1

    2023-10-23T11:53:44.717327  =


    2023-10-23T11:53:44.722332  / # /lava-11854523/bin/lava-test-runner /la=
va-11854523/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65365ed1f400741482efcf25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65365ed1f400741482efcf2e
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-23T11:53:39.663227  <8>[    9.848012] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11854563_1.4.2.3.1>

    2023-10-23T11:53:39.666443  + set +x

    2023-10-23T11:53:39.767906  =


    2023-10-23T11:53:39.868481  / # #export SHELL=3D/bin/sh

    2023-10-23T11:53:39.868636  =


    2023-10-23T11:53:39.969162  / # export SHELL=3D/bin/sh. /lava-11854563/=
environment

    2023-10-23T11:53:39.969322  =


    2023-10-23T11:53:40.069880  / # . /lava-11854563/environment/lava-11854=
563/bin/lava-test-runner /lava-11854563/1

    2023-10-23T11:53:40.070130  =


    2023-10-23T11:53:40.075269  / # /lava-11854563/bin/lava-test-runner /la=
va-11854563/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/653662ba14886a1995efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/arm64/defconfig/gcc-10/lab-collabora/baseline-bcm2711-rpi=
-4-b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/arm64/defconfig/gcc-10/lab-collabora/baseline-bcm2711-rpi=
-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653662ba14886a1995efc=
ef4
        new failure (last pass: v6.1.58-336-g8056f2017920) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65365f1140f3583adfefcf48

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65365f1140f3583adfefcf51
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-23T11:56:17.596252  + set +x

    2023-10-23T11:56:17.603304  <8>[    9.909963] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11854536_1.4.2.3.1>

    2023-10-23T11:56:17.707084  / # #

    2023-10-23T11:56:17.807682  export SHELL=3D/bin/sh

    2023-10-23T11:56:17.807852  #

    2023-10-23T11:56:17.908361  / # export SHELL=3D/bin/sh. /lava-11854536/=
environment

    2023-10-23T11:56:17.908534  =


    2023-10-23T11:56:18.009078  / # . /lava-11854536/environment/lava-11854=
536/bin/lava-test-runner /lava-11854536/1

    2023-10-23T11:56:18.009334  =


    2023-10-23T11:56:18.013782  / # /lava-11854536/bin/lava-test-runner /la=
va-11854536/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65365edaf400741482efcf42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65365edaf400741482efcf4b
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-23T11:53:43.102707  + <8>[   11.109351] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11854524_1.4.2.3.1>

    2023-10-23T11:53:43.102861  set +x

    2023-10-23T11:53:43.207706  / # #

    2023-10-23T11:53:43.308442  export SHELL=3D/bin/sh

    2023-10-23T11:53:43.308679  #

    2023-10-23T11:53:43.409226  / # export SHELL=3D/bin/sh. /lava-11854524/=
environment

    2023-10-23T11:53:43.409460  =


    2023-10-23T11:53:43.510032  / # . /lava-11854524/environment/lava-11854=
524/bin/lava-test-runner /lava-11854524/1

    2023-10-23T11:53:43.510378  =


    2023-10-23T11:53:43.515427  / # /lava-11854524/bin/lava-test-runner /la=
va-11854524/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65365ec5daa705ef56efcf3b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65365ec5daa705ef56efcf44
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-23T11:53:31.911796  + set<8>[   12.103139] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11854554_1.4.2.3.1>

    2023-10-23T11:53:31.911882   +x

    2023-10-23T11:53:32.015973  / # #

    2023-10-23T11:53:32.116523  export SHELL=3D/bin/sh

    2023-10-23T11:53:32.116702  #

    2023-10-23T11:53:32.217238  / # export SHELL=3D/bin/sh. /lava-11854554/=
environment

    2023-10-23T11:53:32.217475  =


    2023-10-23T11:53:32.318003  / # . /lava-11854554/environment/lava-11854=
554/bin/lava-test-runner /lava-11854554/1

    2023-10-23T11:53:32.318282  =


    2023-10-23T11:53:32.323137  / # /lava-11854554/bin/lava-test-runner /la=
va-11854554/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6536614c9dcdb33c3defcf34

  Results:     167 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.panel-edp-probed: https://kernelci.org/test/case/id/653=
6614c9dcdb33c3defcf87
        failing since 0 day (last pass: v6.1.58-132-g9b707223d2e98, first f=
ail: v6.1.58-336-g8056f2017920)

    2023-10-23T12:04:15.412066  /lava-11854644/1/../bin/lava-test-case

    2023-10-23T12:04:15.418310  <8>[   20.837860] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dpanel-edp-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/653662677918f34595efcf14

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653662677918f34595efcf1d
        failing since 97 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-10-23T12:08:52.729062  <8>[   18.096254] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 440048_1.5.2.4.1>
    2023-10-23T12:08:52.834231  / # #
    2023-10-23T12:08:52.935921  export SHELL=3D/bin/sh
    2023-10-23T12:08:52.936501  #
    2023-10-23T12:08:53.037505  / # export SHELL=3D/bin/sh. /lava-440048/en=
vironment
    2023-10-23T12:08:53.038138  =

    2023-10-23T12:08:53.139176  / # . /lava-440048/environment/lava-440048/=
bin/lava-test-runner /lava-440048/1
    2023-10-23T12:08:53.140151  =

    2023-10-23T12:08:53.144206  / # /lava-440048/bin/lava-test-runner /lava=
-440048/1
    2023-10-23T12:08:53.223405  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65366260f8cf06c9baefcf40

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
328-gfa9447b759f6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65366260f8cf06c9baefcf49
        failing since 97 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-10-23T12:13:15.139786  / # #

    2023-10-23T12:13:15.241872  export SHELL=3D/bin/sh

    2023-10-23T12:13:15.242558  #

    2023-10-23T12:13:15.343917  / # export SHELL=3D/bin/sh. /lava-11854700/=
environment

    2023-10-23T12:13:15.344635  =


    2023-10-23T12:13:15.446134  / # . /lava-11854700/environment/lava-11854=
700/bin/lava-test-runner /lava-11854700/1

    2023-10-23T12:13:15.447176  =


    2023-10-23T12:13:15.449221  / # /lava-11854700/bin/lava-test-runner /la=
va-11854700/1

    2023-10-23T12:13:15.529351  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-23T12:13:15.529844  + cd /lava-1185470<8>[   18.748768] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11854700_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
