Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130467431D3
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 02:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjF3Amd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 20:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjF3Amb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 20:42:31 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71F110
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 17:42:26 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b7206f106cso1055289a34.1
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 17:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688085745; x=1690677745;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M70JQ4HRWEp10ujXpSSDkOZsE/MBvDddasYc3bswwso=;
        b=Idh1rN5/baZsXSFtx3rgvY3mrGKNU/sAGywbLemlelw5k8CGSNwNZqcOMNXZejlodl
         l4UXt4HwQ+gYEX3wpNTpjvXrFkOgnzbUz8ubcf4bdT2MR3baHnaffQCxfSwC5sWE8AUJ
         MbRNOUmWZloSTe/Bkmih26A0B9W08A4Mh/m2aRMZNo+T2peX9IFAhqvoqtLPP4rpV84Y
         skc38EcbD8/MGv5LVLzqrPbS/05nEErM5of8jvOmSDZSfteg2EfR7x8mY3X1jdL1iyLL
         +o3GLAgQdjVdGFgMx8Q2XGoyoPj3GNbAA5fyMe4dy0NH6iFi4oR+yIZnKtjtVErMt2OG
         F3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688085745; x=1690677745;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M70JQ4HRWEp10ujXpSSDkOZsE/MBvDddasYc3bswwso=;
        b=FNn2Brhez2NnE0A420fUC46RxgA+YPpd8yKWbFqqixkVooGjS47ZKWmlGpjgX/oSth
         0iuIvghyDBhcQaAj8kmCR4kM05gAin3/Ej//20iJlbkhsvw94kehU/LNQPVwlls/899/
         I0i/AfWZZg3oJO1QwC0xQz7AnHd8XeUED4uEkUrW2brpdW0JtOn0pnZPfjMvWcFd0+sg
         HDNM/UN3Rvh9Vmb3PGUEl6FEtslFql2w804379CFw8Gll9icgx65dDau+pYS17O4fLbl
         lx/S8AGX7qgZ8VU+jleh4lnU5aHXiIJYdHaSO1p+IwUGVg1SvIMdSZ/unFEsSfsDRPkp
         NoMg==
X-Gm-Message-State: AC+VfDyAL4lgKB/5LG14URvjuXb1Vk1dRQmgoczOvOWCwEkuhKdjlfWV
        HpAYhUD70ON8Kju+LDhsJDlJq45vgQ2aNuICRuH6ww==
X-Google-Smtp-Source: ACHHUZ7YRBSZPxKpxKUXXGvGyNh9azB3BANSvdn+kIQdHkVXrBI18BOYlq0ynwYjLoomeYyTvTyFwA==
X-Received: by 2002:a9d:76d2:0:b0:6b8:7ebd:2db9 with SMTP id p18-20020a9d76d2000000b006b87ebd2db9mr1386056otl.26.1688085744928;
        Thu, 29 Jun 2023 17:42:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m9-20020a654389000000b00553d42a7cb5sm8284517pgp.68.2023.06.29.17.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 17:42:24 -0700 (PDT)
Message-ID: <649e24f0.650a0220.1cff3.f824@mx.google.com>
Date:   Thu, 29 Jun 2023 17:42:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.36-31-g9e5d6a988556
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 166 runs,
 8 regressions (v6.1.36-31-g9e5d6a988556)
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

stable-rc/linux-6.1.y baseline: 166 runs, 8 regressions (v6.1.36-31-g9e5d6a=
988556)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.36-31-g9e5d6a988556/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.36-31-g9e5d6a988556
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9e5d6a988556f9677b1d454e17951ac313eb291f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649deead32dd26b734bb2ab2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649deead32dd26b734bb2ab7
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T20:50:54.102393  + set +x

    2023-06-29T20:50:54.108912  <8>[   11.174171] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10955432_1.4.2.3.1>

    2023-06-29T20:50:54.216984  #

    2023-06-29T20:50:54.218266  =


    2023-06-29T20:50:54.320055  / # #export SHELL=3D/bin/sh

    2023-06-29T20:50:54.320847  =


    2023-06-29T20:50:54.422223  / # export SHELL=3D/bin/sh. /lava-10955432/=
environment

    2023-06-29T20:50:54.422446  =


    2023-06-29T20:50:54.523191  / # . /lava-10955432/environment/lava-10955=
432/bin/lava-test-runner /lava-10955432/1

    2023-06-29T20:50:54.524636  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649def7ec3a6e1dbf1bb2a8f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649def7ec3a6e1dbf1bb2a94
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T20:54:10.641016  + set<8>[   12.074609] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10955429_1.4.2.3.1>

    2023-06-29T20:54:10.641102   +x

    2023-06-29T20:54:10.745453  / # #

    2023-06-29T20:54:10.846024  export SHELL=3D/bin/sh

    2023-06-29T20:54:10.846178  #

    2023-06-29T20:54:10.946668  / # export SHELL=3D/bin/sh. /lava-10955429/=
environment

    2023-06-29T20:54:10.946829  =


    2023-06-29T20:54:11.047364  / # . /lava-10955429/environment/lava-10955=
429/bin/lava-test-runner /lava-10955429/1

    2023-06-29T20:54:11.047616  =


    2023-06-29T20:54:11.052031  / # /lava-10955429/bin/lava-test-runner /la=
va-10955429/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649def319c6d6c0f98bb2aa9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649def319c6d6c0f98bb2aae
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T20:52:42.479938  <8>[   13.709236] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10955438_1.4.2.3.1>

    2023-06-29T20:52:42.483925  + set +x

    2023-06-29T20:52:42.590285  #

    2023-06-29T20:52:42.591565  =


    2023-06-29T20:52:42.693544  / # #export SHELL=3D/bin/sh

    2023-06-29T20:52:42.694528  =


    2023-06-29T20:52:42.796441  / # export SHELL=3D/bin/sh. /lava-10955438/=
environment

    2023-06-29T20:52:42.797363  =


    2023-06-29T20:52:42.899017  / # . /lava-10955438/environment/lava-10955=
438/bin/lava-test-runner /lava-10955438/1

    2023-06-29T20:52:42.899553  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649e14a68ee1fd4859bb2b4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649e14a68ee1fd4859bb2=
b4c
        failing since 22 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649deecb6866c837e7bb2a76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649deecb6866c837e7bb2a7b
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T20:51:09.237825  + set +x

    2023-06-29T20:51:09.244469  <8>[   10.085865] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10955373_1.4.2.3.1>

    2023-06-29T20:51:09.348898  / # #

    2023-06-29T20:51:09.449541  export SHELL=3D/bin/sh

    2023-06-29T20:51:09.449761  #

    2023-06-29T20:51:09.550303  / # export SHELL=3D/bin/sh. /lava-10955373/=
environment

    2023-06-29T20:51:09.550513  =


    2023-06-29T20:51:09.651035  / # . /lava-10955373/environment/lava-10955=
373/bin/lava-test-runner /lava-10955373/1

    2023-06-29T20:51:09.651333  =


    2023-06-29T20:51:09.656014  / # /lava-10955373/bin/lava-test-runner /la=
va-10955373/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649def1d9c6d6c0f98bb2a8b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649def1d9c6d6c0f98bb2a90
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T20:52:26.651119  <8>[   10.710689] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10955363_1.4.2.3.1>

    2023-06-29T20:52:26.654196  + set +x

    2023-06-29T20:52:26.756239  #

    2023-06-29T20:52:26.757432  =


    2023-06-29T20:52:26.859123  / # #export SHELL=3D/bin/sh

    2023-06-29T20:52:26.859451  =


    2023-06-29T20:52:26.960242  / # export SHELL=3D/bin/sh. /lava-10955363/=
environment

    2023-06-29T20:52:26.961068  =


    2023-06-29T20:52:27.062802  / # . /lava-10955363/environment/lava-10955=
363/bin/lava-test-runner /lava-10955363/1

    2023-06-29T20:52:27.064153  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649dee8fe4774b870cbb2a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649dee8fe4774b870cbb2a7a
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T20:50:07.122579  + <8>[   10.950131] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10955396_1.4.2.3.1>

    2023-06-29T20:50:07.123055  set +x

    2023-06-29T20:50:07.230372  / # #

    2023-06-29T20:50:07.330983  export SHELL=3D/bin/sh

    2023-06-29T20:50:07.331778  #

    2023-06-29T20:50:07.433219  / # export SHELL=3D/bin/sh. /lava-10955396/=
environment

    2023-06-29T20:50:07.433436  =


    2023-06-29T20:50:07.534191  / # . /lava-10955396/environment/lava-10955=
396/bin/lava-test-runner /lava-10955396/1

    2023-06-29T20:50:07.534554  =


    2023-06-29T20:50:07.538953  / # /lava-10955396/bin/lava-test-runner /la=
va-10955396/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649deeda6866c837e7bb2b03

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
31-g9e5d6a988556/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649deeda6866c837e7bb2b08
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-29T20:51:24.636631  + set<8>[   11.898151] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10955437_1.4.2.3.1>

    2023-06-29T20:51:24.636744   +x

    2023-06-29T20:51:24.741341  / # #

    2023-06-29T20:51:24.841977  export SHELL=3D/bin/sh

    2023-06-29T20:51:24.842196  #

    2023-06-29T20:51:24.942693  / # export SHELL=3D/bin/sh. /lava-10955437/=
environment

    2023-06-29T20:51:24.942902  =


    2023-06-29T20:51:25.043422  / # . /lava-10955437/environment/lava-10955=
437/bin/lava-test-runner /lava-10955437/1

    2023-06-29T20:51:25.043755  =


    2023-06-29T20:51:25.048508  / # /lava-10955437/bin/lava-test-runner /la=
va-10955437/1
 =

    ... (12 line(s) more)  =

 =20
