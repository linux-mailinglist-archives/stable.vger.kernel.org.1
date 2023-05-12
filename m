Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA7700188
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 09:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbjELHay (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 03:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbjELHax (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 03:30:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F91B7
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:30:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-643aad3bc41so8676820b3a.0
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683876650; x=1686468650;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+GlxeAVob9PZ/ml1ymrrs8/X3okdonCj3xzY7KnOjw=;
        b=mQTXIe1cwTC4vdb4kKjsaHnCadDxYLqV2PXTCsCcPtqhyRhdo1ViwabOW78UgYvTLG
         6ZYVyJrLld11Rv/gFNYpX86YH9gMuwJ6cowv9B5ounL4hid6aBuJQbfRyZdkiiF4J0Yb
         m5mY0vUN7HoBBjtTc2mr8dE3/zDMytpw9csqwcx3iI5Qq20rwi030n5HGjHDEM698tMd
         jWrSAtCrEQ78Pg9FOQkNgpK3YiHGyrWFr6W3o8PR4z7RnxqUX4A/2qK0QHcnBhlZjjCC
         W4rXpTsGpF+zmeT9W5GfEPEP9Mdp3R4fOGZhcMJw7d4Bi0Ul9WLOILRiMOr1SxDRv72K
         lSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876650; x=1686468650;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+GlxeAVob9PZ/ml1ymrrs8/X3okdonCj3xzY7KnOjw=;
        b=fpuhFfqCEudm9Mamq4Dd8tiez4AXG/v4LgLRXBfPMW7HMQiSpsJPfOtEBpfvP+BVWZ
         vnVl+DHcn/e3jEUGBNHkT4OjkM9wUPMrOM83Oj9xIuGWoIicXLHjbk5MCWS/wKfuN4im
         1MmfDkIBy3yxkiTwrb3N9RzNbb/jTkhAeUM2q/vEIx3t+pnBfdlC1ZwCItkgQT2cBhti
         lcqIvQRR9GuPzgOwMXjkJHb4fPajhvRn9j5fuq/di6cIY9YK0wVwJoyVpDxlkbzzPbfS
         HysJRvgRLrx1+ouBbptAm6FptrVqVyp9ruEZ4d3ztEvqrzSemY+OoyqJMCFGK5A4yjxg
         +pUQ==
X-Gm-Message-State: AC+VfDxJvFBx0/ArGMPbC2wIngq7w70Zbnf5lUl+bum6E88g6Dbh9Jvz
        Pm6PfBHBUS4/Pg/1PJ73Lm3qGXJ9+rFjuESQZpUAWw==
X-Google-Smtp-Source: ACHHUZ6fa8gS7mKSTbvS62EwVmJJXwQZGS61LKU+bZpJ0M9tqmgS4/oR0VsqptNdoVI9i9fjVR0Oew==
X-Received: by 2002:a05:6a00:1a09:b0:63b:7119:64a9 with SMTP id g9-20020a056a001a0900b0063b711964a9mr30753749pfv.16.1683876649975;
        Fri, 12 May 2023 00:30:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x6-20020aa793a6000000b00640f588b36dsm6460817pff.8.2023.05.12.00.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:30:49 -0700 (PDT)
Message-ID: <645deb29.a70a0220.2af39.dd7a@mx.google.com>
Date:   Fri, 12 May 2023 00:30:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-24-g46eeeec704ee
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 185 runs,
 12 regressions (v6.1.28-24-g46eeeec704ee)
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

stable-rc/queue/6.1 baseline: 185 runs, 12 regressions (v6.1.28-24-g46eeeec=
704ee)

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

meson-gxbb-p200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-24-g46eeeec704ee/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-24-g46eeeec704ee
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      46eeeec704eec505846ba50ac76e8e30287ab8d6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db6eb5305c106992e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db6eb5305c106992e85ff
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T03:47:38.363588  <8>[   27.934110] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10290273_1.4.2.3.1>

    2023-05-12T03:47:38.367147  + set +x

    2023-05-12T03:47:38.472881  #

    2023-05-12T03:47:38.474482  =


    2023-05-12T03:47:38.576649  / # #export SHELL=3D/bin/sh

    2023-05-12T03:47:38.577592  =


    2023-05-12T03:47:38.679263  / # export SHELL=3D/bin/sh. /lava-10290273/=
environment

    2023-05-12T03:47:38.680064  =


    2023-05-12T03:47:38.781672  / # . /lava-10290273/environment/lava-10290=
273/bin/lava-test-runner /lava-10290273/1

    2023-05-12T03:47:38.782952  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db6f8cdb6bd63fb2e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db6f8cdb6bd63fb2e8602
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T03:47:46.201875  + set<8>[   11.162539] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10290271_1.4.2.3.1>

    2023-05-12T03:47:46.202307   +x

    2023-05-12T03:47:46.309490  / # #

    2023-05-12T03:47:46.411847  export SHELL=3D/bin/sh

    2023-05-12T03:47:46.412594  #

    2023-05-12T03:47:46.514227  / # export SHELL=3D/bin/sh. /lava-10290271/=
environment

    2023-05-12T03:47:46.515038  =


    2023-05-12T03:47:46.616836  / # . /lava-10290271/environment/lava-10290=
271/bin/lava-test-runner /lava-10290271/1

    2023-05-12T03:47:46.618028  =


    2023-05-12T03:47:46.622954  / # /lava-10290271/bin/lava-test-runner /la=
va-10290271/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645db6b20e1514c5082e860d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-=
xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-=
xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645db6b20e1514c5082e8=
60e
        failing since 21 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db70a5961159a592e85f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db70b5961159a592e85fe
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T03:48:09.088242  + set +x

    2023-05-12T03:48:09.094853  <8>[   11.522569] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10290275_1.4.2.3.1>

    2023-05-12T03:48:09.202794  / # #

    2023-05-12T03:48:09.305339  export SHELL=3D/bin/sh

    2023-05-12T03:48:09.306159  #

    2023-05-12T03:48:09.407816  / # export SHELL=3D/bin/sh. /lava-10290275/=
environment

    2023-05-12T03:48:09.408603  =


    2023-05-12T03:48:09.510240  / # . /lava-10290275/environment/lava-10290=
275/bin/lava-test-runner /lava-10290275/1

    2023-05-12T03:48:09.511777  =


    2023-05-12T03:48:09.516646  / # /lava-10290275/bin/lava-test-runner /la=
va-10290275/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db6dc38e5941be92e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db6dc38e5941be92e85f8
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T03:47:27.098862  <8>[   10.783634] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10290283_1.4.2.3.1>

    2023-05-12T03:47:27.102026  + set +x

    2023-05-12T03:47:27.203585  #

    2023-05-12T03:47:27.203864  =


    2023-05-12T03:47:27.304399  / # #export SHELL=3D/bin/sh

    2023-05-12T03:47:27.304620  =


    2023-05-12T03:47:27.405095  / # export SHELL=3D/bin/sh. /lava-10290283/=
environment

    2023-05-12T03:47:27.405291  =


    2023-05-12T03:47:27.505804  / # . /lava-10290283/environment/lava-10290=
283/bin/lava-test-runner /lava-10290283/1

    2023-05-12T03:47:27.506074  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db6f1123b38d9462e862a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db6f1123b38d9462e862f
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T03:47:41.569135  + <8>[   11.659990] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10290289_1.4.2.3.1>

    2023-05-12T03:47:41.569567  set +x

    2023-05-12T03:47:41.677311  / # #

    2023-05-12T03:47:41.779770  export SHELL=3D/bin/sh

    2023-05-12T03:47:41.780390  #

    2023-05-12T03:47:41.881828  / # export SHELL=3D/bin/sh. /lava-10290289/=
environment

    2023-05-12T03:47:41.882464  =


    2023-05-12T03:47:41.983931  / # . /lava-10290289/environment/lava-10290=
289/bin/lava-test-runner /lava-10290289/1

    2023-05-12T03:47:41.984958  =


    2023-05-12T03:47:41.990065  / # /lava-10290289/bin/lava-test-runner /la=
va-10290289/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db6e25305c106992e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db6e25305c106992e85ed
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T03:47:33.340439  <8>[   12.179464] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10290290_1.4.2.3.1>

    2023-05-12T03:47:33.444740  / # #

    2023-05-12T03:47:33.545355  export SHELL=3D/bin/sh

    2023-05-12T03:47:33.545548  #

    2023-05-12T03:47:33.646064  / # export SHELL=3D/bin/sh. /lava-10290290/=
environment

    2023-05-12T03:47:33.646265  =


    2023-05-12T03:47:33.746792  / # . /lava-10290290/environment/lava-10290=
290/bin/lava-test-runner /lava-10290290/1

    2023-05-12T03:47:33.747098  =


    2023-05-12T03:47:33.751697  / # /lava-10290290/bin/lava-test-runner /la=
va-10290290/1

    2023-05-12T03:47:33.758231  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxbb-p200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645db9a3e0684278582e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645db9a3e0684278582e8=
5e7
        new failure (last pass: v6.1.27-610-g4b10fbec9dd8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645dba10dd34a47c262e85f4

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseli=
ne-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseli=
ne-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645dba10dd34a47c262e8610
        failing since 5 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-12T04:00:53.925625  /lava-10290517/1/../bin/lava-test-case

    2023-05-12T04:00:53.932421  <8>[   22.987806] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645dba10dd34a47c262e869c
        failing since 5 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-12T04:00:48.468321  + set +x

    2023-05-12T04:00:48.474817  <8>[   17.529836] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10290517_1.5.2.3.1>

    2023-05-12T04:00:48.579410  / # #

    2023-05-12T04:00:48.679977  export SHELL=3D/bin/sh

    2023-05-12T04:00:48.680142  #

    2023-05-12T04:00:48.780641  / # export SHELL=3D/bin/sh. /lava-10290517/=
environment

    2023-05-12T04:00:48.780838  =


    2023-05-12T04:00:48.881384  / # . /lava-10290517/environment/lava-10290=
517/bin/lava-test-runner /lava-10290517/1

    2023-05-12T04:00:48.881696  =


    2023-05-12T04:00:48.886480  / # /lava-10290517/bin/lava-test-runner /la=
va-10290517/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/645db81d5d1b144a0e2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645db81d5d1b144a0e2e8=
5e7
        new failure (last pass: v6.1.28-17-gfd8d81f05a2c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645db7c54f2e6e32422e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips=
-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-24=
-g46eeeec704ee/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips=
-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645db7c54f2e6e32422e8=
5ea
        failing since 4 days (last pass: v6.1.22-1159-g8729cbdc1402, first =
fail: v6.1.22-1196-g571a2463c150b) =

 =20
