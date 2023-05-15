Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355E2702E13
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbjEON1z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 09:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbjEON1y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 09:27:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BBD1700
        for <stable@vger.kernel.org>; Mon, 15 May 2023 06:27:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24df161f84bso8734974a91.3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684157271; x=1686749271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d/0ZE/uz1k2GsNh5doqUogAKEK7XCZA7F3yLNqDgwTs=;
        b=UhvZczfB/igo+CuPWBbMl2IygX43pLEn/DSNI1hF0sDF+TXWn4lu3o9OdMRyoZ0Ifo
         7zlGCQxq/UcgkeFxYyFe7Rk4G8hLBh39HowcRHIHjEsJICER3gBtpRZCxugf5m4y3umS
         3o1VrLWWeY1XA2mE9Mgex8nTS9ZVI9T945E5+NFJpo7gOvfEpFN7eqrNCpBEvdOnyR1/
         NWxPQMRLOLAFboJ6u4UrKcbwrBzsq+UQ68z7N34u2ibnuxR5ndjmVZ5zx+O6F5JD1Eh3
         r4WshjlPztbYSYAWd24tOPpAQwD35sLqaoLRKsBCZ110Bn64N1bqmRHcL8Qg3zKaSgbv
         73yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684157271; x=1686749271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/0ZE/uz1k2GsNh5doqUogAKEK7XCZA7F3yLNqDgwTs=;
        b=M882UJYkoQ65r5sDb5Lwg4PYgDa1CjDDLZNUO8zvWejFePKVnQw9FRYSGxoBzc+vUX
         SZr6WHOnQyLIR0UE3gI+DK0X7LIj0iWyaYI+YWwmkZTWRI7kbifDdqOuvDN3UCbjfJYj
         aOHY+B2nH8UdAvRKKU/fvqpsrzFLu3i6d27UUMdXNDbxdHdHmItOAjzSeoGXWsvBISnt
         V0j/4XvVRFQWQQbi7BVOL6iY7Fdt+FSa449iZUpHeKj6N1HKJsc5Gij2r82l0+w+ciVR
         ELdfsqf+RT3WYjJ4VgvQv4q505szpzzD7Gyow0+hqIVQswGf9pze9U4ce2ZzLPQ/wW/l
         j0nA==
X-Gm-Message-State: AC+VfDzQRW2Rv2qN2VVZeiMx6Sjlr9zeCUMyJ/PXGiv+IooRHffdMqC5
        +GUXzAcRvYHxzKspwL9AWJO2NlfIXQbrCm3hwk1eVA==
X-Google-Smtp-Source: ACHHUZ5P/sfN0uAq75BD0AGI4tlSr+8fot748IEF9g+Lw8r5vPeUBVnPCYaxnbid2Rjw6Rl5fUrLig==
X-Received: by 2002:a17:90a:fa92:b0:24e:225b:c1a1 with SMTP id cu18-20020a17090afa9200b0024e225bc1a1mr34070681pjb.32.1684157271029;
        Mon, 15 May 2023 06:27:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w16-20020a63c110000000b0050f7208b4bcsm11621269pgf.89.2023.05.15.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:27:50 -0700 (PDT)
Message-ID: <64623356.630a0220.45f7.4057@mx.google.com>
Date:   Mon, 15 May 2023 06:27:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-235-g74c7a3a3e1689
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 170 runs,
 10 regressions (v6.1.28-235-g74c7a3a3e1689)
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

stable-rc/queue/6.1 baseline: 170 runs, 10 regressions (v6.1.28-235-g74c7a3=
a3e1689)

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-235-g74c7a3a3e1689/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-235-g74c7a3a3e1689
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      74c7a3a3e1689ab0fc2fae4dad08f2a77675ff02 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646201e65ce20879a52e864c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646201e65ce20879a52e8651
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T09:56:33.497198  + set +x

    2023-05-15T09:56:33.504151  <8>[   12.126175] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10321091_1.4.2.3.1>

    2023-05-15T09:56:33.612156  / # #

    2023-05-15T09:56:33.714565  export SHELL=3D/bin/sh

    2023-05-15T09:56:33.715240  #

    2023-05-15T09:56:33.816803  / # export SHELL=3D/bin/sh. /lava-10321091/=
environment

    2023-05-15T09:56:33.817653  =


    2023-05-15T09:56:33.919441  / # . /lava-10321091/environment/lava-10321=
091/bin/lava-test-runner /lava-10321091/1

    2023-05-15T09:56:33.920841  =


    2023-05-15T09:56:33.927123  / # /lava-10321091/bin/lava-test-runner /la=
va-10321091/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646201d15c25a836862e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646201d15c25a836862e860c
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T09:56:28.369480  + set<8>[   11.033153] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10321087_1.4.2.3.1>

    2023-05-15T09:56:28.369930   +x

    2023-05-15T09:56:28.476928  / # #

    2023-05-15T09:56:28.579221  export SHELL=3D/bin/sh

    2023-05-15T09:56:28.580009  #

    2023-05-15T09:56:28.681696  / # export SHELL=3D/bin/sh. /lava-10321087/=
environment

    2023-05-15T09:56:28.682506  =


    2023-05-15T09:56:28.783859  / # . /lava-10321087/environment/lava-10321=
087/bin/lava-test-runner /lava-10321087/1

    2023-05-15T09:56:28.785144  =


    2023-05-15T09:56:28.789826  / # /lava-10321087/bin/lava-test-runner /la=
va-10321087/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646201d7f0c494658d2e85f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646201d7f0c494658d2e85fe
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T09:56:29.848031  <8>[    8.015196] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10321055_1.4.2.3.1>

    2023-05-15T09:56:29.851439  + set +x

    2023-05-15T09:56:29.952883  =


    2023-05-15T09:56:30.053497  / # #export SHELL=3D/bin/sh

    2023-05-15T09:56:30.053688  =


    2023-05-15T09:56:30.154248  / # export SHELL=3D/bin/sh. /lava-10321055/=
environment

    2023-05-15T09:56:30.154460  =


    2023-05-15T09:56:30.255000  / # . /lava-10321055/environment/lava-10321=
055/bin/lava-test-runner /lava-10321055/1

    2023-05-15T09:56:30.255268  =


    2023-05-15T09:56:30.260659  / # /lava-10321055/bin/lava-test-runner /la=
va-10321055/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6461fdec4a0e8fe09b2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6461fdec4a0e8fe09b2e8=
5e7
        failing since 24 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646201e6f0c494658d2e8644

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646201e6f0c494658d2e8649
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T09:56:38.416201  + set +x

    2023-05-15T09:56:38.422546  <8>[   10.614556] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10321078_1.4.2.3.1>

    2023-05-15T09:56:38.527205  / # #

    2023-05-15T09:56:38.627856  export SHELL=3D/bin/sh

    2023-05-15T09:56:38.628046  #

    2023-05-15T09:56:38.728642  / # export SHELL=3D/bin/sh. /lava-10321078/=
environment

    2023-05-15T09:56:38.728815  =


    2023-05-15T09:56:38.829362  / # . /lava-10321078/environment/lava-10321=
078/bin/lava-test-runner /lava-10321078/1

    2023-05-15T09:56:38.829633  =


    2023-05-15T09:56:38.834101  / # /lava-10321078/bin/lava-test-runner /la=
va-10321078/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646201d0f0c494658d2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646201d0f0c494658d2e85eb
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T09:56:19.508445  + set +x<8>[   10.591160] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10321110_1.4.2.3.1>

    2023-05-15T09:56:19.508984  =


    2023-05-15T09:56:19.616389  #

    2023-05-15T09:56:19.719309  / # #export SHELL=3D/bin/sh

    2023-05-15T09:56:19.720071  =


    2023-05-15T09:56:19.821690  / # export SHELL=3D/bin/sh. /lava-10321110/=
environment

    2023-05-15T09:56:19.822532  =


    2023-05-15T09:56:19.924054  / # . /lava-10321110/environment/lava-10321=
110/bin/lava-test-runner /lava-10321110/1

    2023-05-15T09:56:19.925224  =


    2023-05-15T09:56:19.930083  / # /lava-10321110/bin/lava-test-runner /la=
va-10321110/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646201d9e3724e84282e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646201d9e3724e84282e860c
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T09:56:31.669632  + <8>[   10.792223] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10321090_1.4.2.3.1>

    2023-05-15T09:56:31.669716  set +x

    2023-05-15T09:56:31.774168  / # #

    2023-05-15T09:56:31.874733  export SHELL=3D/bin/sh

    2023-05-15T09:56:31.874916  #

    2023-05-15T09:56:31.975460  / # export SHELL=3D/bin/sh. /lava-10321090/=
environment

    2023-05-15T09:56:31.975621  =


    2023-05-15T09:56:32.076177  / # . /lava-10321090/environment/lava-10321=
090/bin/lava-test-runner /lava-10321090/1

    2023-05-15T09:56:32.076438  =


    2023-05-15T09:56:32.081155  / # /lava-10321090/bin/lava-test-runner /la=
va-10321090/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646201d5108493009e2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646201d5108493009e2e85eb
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T09:56:32.298324  <8>[   10.893354] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10321044_1.4.2.3.1>

    2023-05-15T09:56:32.403098  / # #

    2023-05-15T09:56:32.503810  export SHELL=3D/bin/sh

    2023-05-15T09:56:32.504034  #

    2023-05-15T09:56:32.604542  / # export SHELL=3D/bin/sh. /lava-10321044/=
environment

    2023-05-15T09:56:32.604765  =


    2023-05-15T09:56:32.705309  / # . /lava-10321044/environment/lava-10321=
044/bin/lava-test-runner /lava-10321044/1

    2023-05-15T09:56:32.705672  =


    2023-05-15T09:56:32.710666  / # /lava-10321044/bin/lava-test-runner /la=
va-10321044/1

    2023-05-15T09:56:32.717082  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6461ff7f93c10cd9b42e860b

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
5-g74c7a3a3e1689/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6461ff7f93c10cd9b42e8627
        failing since 8 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-15T09:46:13.174031  /lava-10320959/1/../bin/lava-test-case

    2023-05-15T09:46:13.181122  <8>[   22.919069] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461ff7f93c10cd9b42e86b3
        failing since 8 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-15T09:46:07.768996  + set +x

    2023-05-15T09:46:07.775056  <8>[   17.512821] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10320959_1.5.2.3.1>

    2023-05-15T09:46:07.879600  / # #

    2023-05-15T09:46:07.980161  export SHELL=3D/bin/sh

    2023-05-15T09:46:07.980380  #

    2023-05-15T09:46:08.080929  / # export SHELL=3D/bin/sh. /lava-10320959/=
environment

    2023-05-15T09:46:08.081178  =


    2023-05-15T09:46:08.181730  / # . /lava-10320959/environment/lava-10320=
959/bin/lava-test-runner /lava-10320959/1

    2023-05-15T09:46:08.182087  =


    2023-05-15T09:46:08.187094  / # /lava-10320959/bin/lava-test-runner /la=
va-10320959/1
 =

    ... (13 line(s) more)  =

 =20
