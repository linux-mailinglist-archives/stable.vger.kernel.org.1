Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588B46F082D
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbjD0PYK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 11:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjD0PYJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 11:24:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7DC0
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:24:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a66b9bd893so71174015ad.1
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682609046; x=1685201046;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1hb2CyVZ3WDvD+WgqW1k3WylWmbS5tBYjX4Fb3I5AV0=;
        b=vJHGsZtAMEci4X6MhG+prP9GulH+LeZC5AKkZf07LVFRquYhwDPN+gWITzw0l3yUy5
         scbBapdcS8oNeMmAIHCkKYvMqgJqdhSQZMXZJSyxeX3u4WIJ66SA6a12jTqxD9Iwyhgf
         LRbuPX1wzhNffTFnuaP6IRmSXH9bgMsxKkPV2QS6tIgVNWDIdUxLqANBUpJqAKurA/Bh
         ryoJ1LW8Rn2z8lZdn+F6K6JxgSpGX0T/BEhV38t0mylIcMgdGFoeIqtmI596HSf9Z/8D
         QlqPQhMouSODXrHulZGfLsB9tRDnIY3KIu0U4fg8aQHlHlEGOGo1JzRIkbHKfkvHliet
         /UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682609046; x=1685201046;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hb2CyVZ3WDvD+WgqW1k3WylWmbS5tBYjX4Fb3I5AV0=;
        b=XjLJAdQUJceT0S1YhsF2YVbDoW6UztR/CIRaTloO9GpyWOvXhjndqcsRTrwL2Y4X1x
         GLNkDb2rPlGSfOOYvG4u5R4dWSzSQ25tAeWIS7TJ4VcLdmlFEq2nwL89tdUeMcSMAr4x
         UicDGzbg0x5AQpPpCKh+R0DVAX5YhXHv11tNzm/RiFbGwPNMWiJJwrl2eVOwCjHqBJ8+
         NLWkgxlpVt3TxUnExUepI9zA9S6KGGzmY84yjNW8ikklsY05BovThGgzZ4Z7nQfKZhOL
         Fck5gysneOb17vHsvUdbxh3OB9jjQh6DYqcVnLZQbyX1G+Uv7hvTMtLekCOZ6zp3+JYl
         AsdA==
X-Gm-Message-State: AC+VfDyIgPDggP70hxusBviEVGu/SIHk+fgUpAxtKm7djah2z98mPvT+
        8S/JkcO76pXdywDhvON3+WHIAXnbcc17hhDSQ0/Y5Q==
X-Google-Smtp-Source: ACHHUZ5xnFdDrn0lItg/mn0wfDMiiv6kv12NT5tEyl3+7QEVIeuDauWHY3mseYRlziK1nCmw1njAgA==
X-Received: by 2002:a17:902:e549:b0:1a2:8866:e8a4 with SMTP id n9-20020a170902e54900b001a28866e8a4mr2673100plf.1.1682609045872;
        Thu, 27 Apr 2023 08:24:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902864900b001a800e03cf9sm11739952plt.256.2023.04.27.08.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 08:24:05 -0700 (PDT)
Message-ID: <644a9395.170a0220.77675.8005@mx.google.com>
Date:   Thu, 27 Apr 2023 08:24:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-584-g7bbf32a05c1d
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 110 runs,
 10 regressions (v6.1.22-584-g7bbf32a05c1d)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/6.1 baseline: 110 runs, 10 regressions (v6.1.22-584-g7bbf32=
a05c1d)

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

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =

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

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-584-g7bbf32a05c1d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-584-g7bbf32a05c1d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7bbf32a05c1d09d633b95641ec1bd609baee426c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a624c41640013912e86b1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a624c41640013912e86b6
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T11:53:31.324882  <8>[   10.090731] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141835_1.4.2.3.1>

    2023-04-27T11:53:31.328266  + set +x

    2023-04-27T11:53:31.433401  #

    2023-04-27T11:53:31.434582  =


    2023-04-27T11:53:31.536340  / # #export SHELL=3D/bin/sh

    2023-04-27T11:53:31.537075  =


    2023-04-27T11:53:31.638474  / # export SHELL=3D/bin/sh. /lava-10141835/=
environment

    2023-04-27T11:53:31.639221  =


    2023-04-27T11:53:31.740705  / # . /lava-10141835/environment/lava-10141=
835/bin/lava-test-runner /lava-10141835/1

    2023-04-27T11:53:31.741863  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a61c8469c0d75f62e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a61c8469c0d75f62e85eb
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T11:51:27.976831  + <8>[   11.906867] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10141817_1.4.2.3.1>

    2023-04-27T11:51:27.976945  set +x

    2023-04-27T11:51:28.081496  / # #

    2023-04-27T11:51:28.182208  export SHELL=3D/bin/sh

    2023-04-27T11:51:28.182399  #

    2023-04-27T11:51:28.282882  / # export SHELL=3D/bin/sh. /lava-10141817/=
environment

    2023-04-27T11:51:28.283105  =


    2023-04-27T11:51:28.383685  / # . /lava-10141817/environment/lava-10141=
817/bin/lava-test-runner /lava-10141817/1

    2023-04-27T11:51:28.384068  =


    2023-04-27T11:51:28.388691  / # /lava-10141817/bin/lava-test-runner /la=
va-10141817/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a61d3161db887e62e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a61d3161db887e62e85fb
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T11:51:25.202858  <8>[   10.947559] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141842_1.4.2.3.1>

    2023-04-27T11:51:25.206019  + set +x

    2023-04-27T11:51:25.311083  #

    2023-04-27T11:51:25.312324  =


    2023-04-27T11:51:25.414313  / # #export SHELL=3D/bin/sh

    2023-04-27T11:51:25.415109  =


    2023-04-27T11:51:25.516660  / # export SHELL=3D/bin/sh. /lava-10141842/=
environment

    2023-04-27T11:51:25.517406  =


    2023-04-27T11:51:25.618940  / # . /lava-10141842/environment/lava-10141=
842/bin/lava-test-runner /lava-10141842/1

    2023-04-27T11:51:25.620201  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/644a5d7992acf456362e85ed

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835-r=
pi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835-r=
pi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a5d7992acf456362e8620
        failing since 0 day (last pass: v6.1.22-573-g35b4c8b34dab, first fa=
il: v6.1.22-580-ga9ca34ec26f3)

    2023-04-27T11:32:51.052833  + set +x
    2023-04-27T11:32:51.056581  <8>[   18.304805] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 393688_1.5.2.4.1>
    2023-04-27T11:32:51.178381  / # #
    2023-04-27T11:32:51.282739  export SHELL=3D/bin/sh
    2023-04-27T11:32:51.283771  #
    2023-04-27T11:32:51.386494  / # export SHELL=3D/bin/sh. /lava-393688/en=
vironment
    2023-04-27T11:32:51.387882  =

    2023-04-27T11:32:51.490808  / # . /lava-393688/environment/lava-393688/=
bin/lava-test-runner /lava-393688/1
    2023-04-27T11:32:51.493145  =

    2023-04-27T11:32:51.499513  / # /lava-393688/bin/lava-test-runner /lava=
-393688/1 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644a63a0d622fe43ce2e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a63a0d622fe43ce2e8=
5ea
        failing since 6 days (last pass: v6.1.22-477-g2128d4458cbc, first f=
ail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a61bd1b3d7d0a632e8608

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a61bd1b3d7d0a632e860d
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T11:51:10.429795  + set +x

    2023-04-27T11:51:10.436721  <8>[   10.467810] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141838_1.4.2.3.1>

    2023-04-27T11:51:10.541433  / # #

    2023-04-27T11:51:10.642163  export SHELL=3D/bin/sh

    2023-04-27T11:51:10.642329  #

    2023-04-27T11:51:10.742914  / # export SHELL=3D/bin/sh. /lava-10141838/=
environment

    2023-04-27T11:51:10.743081  =


    2023-04-27T11:51:10.843594  / # . /lava-10141838/environment/lava-10141=
838/bin/lava-test-runner /lava-10141838/1

    2023-04-27T11:51:10.843855  =


    2023-04-27T11:51:10.848443  / # /lava-10141838/bin/lava-test-runner /la=
va-10141838/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a61c61b3d7d0a632e8645

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a61c61b3d7d0a632e864a
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T11:51:14.879036  <8>[   10.256581] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141877_1.4.2.3.1>

    2023-04-27T11:51:14.882502  + set +x

    2023-04-27T11:51:14.987369  #

    2023-04-27T11:51:14.988410  =


    2023-04-27T11:51:15.090039  / # #export SHELL=3D/bin/sh

    2023-04-27T11:51:15.090726  =


    2023-04-27T11:51:15.192209  / # export SHELL=3D/bin/sh. /lava-10141877/=
environment

    2023-04-27T11:51:15.192400  =


    2023-04-27T11:51:15.292956  / # . /lava-10141877/environment/lava-10141=
877/bin/lava-test-runner /lava-10141877/1

    2023-04-27T11:51:15.293222  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a61e24649c369792e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a61e24649c369792e85ff
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T11:51:40.202699  + set<8>[   10.941410] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10141861_1.4.2.3.1>

    2023-04-27T11:51:40.203315   +x

    2023-04-27T11:51:40.310903  / # #

    2023-04-27T11:51:40.411579  export SHELL=3D/bin/sh

    2023-04-27T11:51:40.411776  #

    2023-04-27T11:51:40.512328  / # export SHELL=3D/bin/sh. /lava-10141861/=
environment

    2023-04-27T11:51:40.512552  =


    2023-04-27T11:51:40.613098  / # . /lava-10141861/environment/lava-10141=
861/bin/lava-test-runner /lava-10141861/1

    2023-04-27T11:51:40.613427  =


    2023-04-27T11:51:40.617997  / # /lava-10141861/bin/lava-test-runner /la=
va-10141861/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a61c93ca1b421f72e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a61c93ca1b421f72e8611
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T11:51:15.216919  <8>[    8.927784] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141854_1.4.2.3.1>

    2023-04-27T11:51:15.321427  / # #

    2023-04-27T11:51:15.422071  export SHELL=3D/bin/sh

    2023-04-27T11:51:15.422269  #

    2023-04-27T11:51:15.522852  / # export SHELL=3D/bin/sh. /lava-10141854/=
environment

    2023-04-27T11:51:15.523042  =


    2023-04-27T11:51:15.623685  / # . /lava-10141854/environment/lava-10141=
854/bin/lava-test-runner /lava-10141854/1

    2023-04-27T11:51:15.623993  =


    2023-04-27T11:51:15.629087  / # /lava-10141854/bin/lava-test-runner /la=
va-10141854/1

    2023-04-27T11:51:15.635530  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/644a5e15f763e89be82e85f7

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
4-g7bbf32a05c1d/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/mipsel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/644a5e15f763e89=
be82e85ff
        failing since 3 days (last pass: v6.1.22-560-gc4a6f990f6a64, first =
fail: v6.1.22-564-g3588497f7ea83)
        1 lines

    2023-04-27T11:35:42.751331  kern  :alert : CPU 0 Unable to handle kerne=
l paging request at virtual address 3213685c, epc =3D=3D 80202234, ra =3D=
=3D 80204b84
    2023-04-27T11:35:42.751490  =


    2023-04-27T11:35:42.771904  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-04-27T11:35:42.772029  =

   =

 =20
