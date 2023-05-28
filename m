Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41DD7139C7
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjE1N6C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjE1N6C (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 09:58:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4730B8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 06:57:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso2833093b3a.3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685282279; x=1687874279;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DXu4i0h63e6GZ1JGELvME0xDSh3RUs4h7WyexnBOnwM=;
        b=Xm6w1zU9aL90qSxGRQPZ+So6FdiI6BorbVKSdq445G7zpXm33cif0R6JI5xMfyQN41
         R4K0Td48lUaStPvd+bgsGpaCwWODvBEBk6uU4USkTSPTRTeeBmJ1rgthd9vjn9GXGxSv
         Zq0zziR8JHKv3GWr361MalaLEBZ7VMUsqilpgWxYH9XpM6Mlcg49+J7aCH5KXFW3TS/e
         z40p9RjCT8LKdN+0Un4+Sllgv3CwsG7zNB+AZv/BOWvzdd9qK+wBEs/YMW32ImSrPDlN
         UiEHpEz7vRi+GVZyvuJHhS4MFXz8WRhNJfuR+NgLN/9IX5uuw8GBv1mThAogVyoLnv42
         UqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685282279; x=1687874279;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXu4i0h63e6GZ1JGELvME0xDSh3RUs4h7WyexnBOnwM=;
        b=gxTjbDkfbGi3QFq6WIyeR0m5gkNqLHQXCHyMA5N0LhyoN+lNCL146dCS/zBIwnhSQb
         i265mRRYlxY1/9jV+opi3GGERWtsD+xRpj4x74SdB8YN8Nx+ZABcRWWV0G9G9MIGmgoh
         J86tHMDdszREUe/94futEZuuZQJ2kyFyxwJ1aaRu8jPQDO29ywcoflM8koFM098XlYYO
         yUJZk0R0Gp1Dde7tdh6klhjjU77ieZCJOlJJihL3K4bHapTXHRMctpr+iUl/lLawQKYf
         tC3+Nu2Adqgx7fxweJ+gIyQzF9u/vrDqOLmCI7/hb/3iXRnWnjbuC9I74wFJr1BBADZh
         5x9w==
X-Gm-Message-State: AC+VfDxFn+jnN7sBiZG3mMm0L2/iApZEzqE0l8o9bVDmdeFLyRNz2s19
        p15tc0A9o540vOhrNNovrmPl55P1/Wmn6Zl51/Y=
X-Google-Smtp-Source: ACHHUZ7yxPyGSXnDMakXyNpMBWhS34V+t44jSuceAwU49H5DM7oPcllBFyvRuheY5dz0njxB7BZUHg==
X-Received: by 2002:a05:6a20:43a5:b0:10f:5fc:80d5 with SMTP id i37-20020a056a2043a500b0010f05fc80d5mr4968518pzl.35.1685282278766;
        Sun, 28 May 2023 06:57:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a62b40f000000b0064d59e194c8sm5251411pfn.115.2023.05.28.06.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 06:57:58 -0700 (PDT)
Message-ID: <64735de6.620a0220.cb927.9ea7@mx.google.com>
Date:   Sun, 28 May 2023 06:57:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-229-gf0f8d123660a
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 176 runs,
 8 regressions (v5.15.112-229-gf0f8d123660a)
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

stable-rc/queue/5.15 baseline: 176 runs, 8 regressions (v5.15.112-229-gf0f8=
d123660a)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-229-gf0f8d123660a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-229-gf0f8d123660a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f0f8d123660aba0ae10ddcaf47599f69fc54d3f6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647329a5d1e52c32d82e8628

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647329a5d1e52c32d82e862d
        failing since 60 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T10:14:39.206676  + set<8>[   11.214885] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10492300_1.4.2.3.1>

    2023-05-28T10:14:39.206808   +x

    2023-05-28T10:14:39.311167  / # #

    2023-05-28T10:14:39.411908  export SHELL=3D/bin/sh

    2023-05-28T10:14:39.412149  #

    2023-05-28T10:14:39.512723  / # export SHELL=3D/bin/sh. /lava-10492300/=
environment

    2023-05-28T10:14:39.512928  =


    2023-05-28T10:14:39.613485  / # . /lava-10492300/environment/lava-10492=
300/bin/lava-test-runner /lava-10492300/1

    2023-05-28T10:14:39.613774  =


    2023-05-28T10:14:39.618297  / # /lava-10492300/bin/lava-test-runner /la=
va-10492300/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473299f2c8854282d2e85f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473299f2c8854282d2e85f7
        failing since 60 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T10:14:34.413842  <8>[   11.407575] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10492313_1.4.2.3.1>

    2023-05-28T10:14:34.416945  + set +x

    2023-05-28T10:14:34.518308  #

    2023-05-28T10:14:34.518621  =


    2023-05-28T10:14:34.619225  / # #export SHELL=3D/bin/sh

    2023-05-28T10:14:34.619451  =


    2023-05-28T10:14:34.719956  / # export SHELL=3D/bin/sh. /lava-10492313/=
environment

    2023-05-28T10:14:34.720178  =


    2023-05-28T10:14:34.820760  / # . /lava-10492313/environment/lava-10492=
313/bin/lava-test-runner /lava-10492313/1

    2023-05-28T10:14:34.821102  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64732af69c621f5db72e86e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64732af69c621f5db72e8=
6e6
        failing since 114 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64732d2c8cff3f872c2e85fa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64732d2c8cff3f872c2e85ff
        failing since 131 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-28T10:29:27.697712  <8>[   10.061028] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3626040_1.5.2.4.1>
    2023-05-28T10:29:27.806868  / # #
    2023-05-28T10:29:27.909355  export SHELL=3D/bin/sh
    2023-05-28T10:29:27.910177  #
    2023-05-28T10:29:27.910670  / # export SHELL=3D/bin/sh<3>[   10.273217]=
 Bluetooth: hci0: command 0xfc18 tx timeout
    2023-05-28T10:29:28.012658  . /lava-3626040/environment
    2023-05-28T10:29:28.013535  =

    2023-05-28T10:29:28.115434  / # . /lava-3626040/environment/lava-362604=
0/bin/lava-test-runner /lava-3626040/1
    2023-05-28T10:29:28.116053  =

    2023-05-28T10:29:28.120952  / # /lava-3626040/bin/lava-test-runner /lav=
a-3626040/1 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647329881290b4ae792e8632

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647329881290b4ae792e8637
        failing since 60 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T10:14:23.865690  + set +x

    2023-05-28T10:14:23.872608  <8>[   10.754602] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10492299_1.4.2.3.1>

    2023-05-28T10:14:23.976913  / # #

    2023-05-28T10:14:24.077455  export SHELL=3D/bin/sh

    2023-05-28T10:14:24.077633  #

    2023-05-28T10:14:24.178098  / # export SHELL=3D/bin/sh. /lava-10492299/=
environment

    2023-05-28T10:14:24.178270  =


    2023-05-28T10:14:24.278747  / # . /lava-10492299/environment/lava-10492=
299/bin/lava-test-runner /lava-10492299/1

    2023-05-28T10:14:24.279017  =


    2023-05-28T10:14:24.283856  / # /lava-10492299/bin/lava-test-runner /la=
va-10492299/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64732994d1e52c32d82e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64732994d1e52c32d82e85ef
        failing since 60 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T10:14:32.994415  <8>[   10.330893] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10492368_1.4.2.3.1>

    2023-05-28T10:14:32.998127  + set +x

    2023-05-28T10:14:33.099308  /#

    2023-05-28T10:14:33.200160   # #export SHELL=3D/bin/sh

    2023-05-28T10:14:33.200379  =


    2023-05-28T10:14:33.300936  / # export SHELL=3D/bin/sh. /lava-10492368/=
environment

    2023-05-28T10:14:33.301159  =


    2023-05-28T10:14:33.401766  / # . /lava-10492368/environment/lava-10492=
368/bin/lava-test-runner /lava-10492368/1

    2023-05-28T10:14:33.402078  =


    2023-05-28T10:14:33.407455  / # /lava-10492368/bin/lava-test-runner /la=
va-10492368/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473299c8124a9a8bd2e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473299c8124a9a8bd2e860c
        failing since 60 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T10:14:31.807729  + set<8>[   11.166190] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10492308_1.4.2.3.1>

    2023-05-28T10:14:31.807817   +x

    2023-05-28T10:14:31.912090  / # #

    2023-05-28T10:14:32.012707  export SHELL=3D/bin/sh

    2023-05-28T10:14:32.012920  #

    2023-05-28T10:14:32.113498  / # export SHELL=3D/bin/sh. /lava-10492308/=
environment

    2023-05-28T10:14:32.113678  =


    2023-05-28T10:14:32.214378  / # . /lava-10492308/environment/lava-10492=
308/bin/lava-test-runner /lava-10492308/1

    2023-05-28T10:14:32.214648  =


    2023-05-28T10:14:32.219367  / # /lava-10492308/bin/lava-test-runner /la=
va-10492308/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64732a9474ddfd569c2e876b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-229-gf0f8d123660a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64732a9474ddfd569c2e8=
76c
        new failure (last pass: v5.15.112-223-g2be1bc05e2ff) =

 =20
