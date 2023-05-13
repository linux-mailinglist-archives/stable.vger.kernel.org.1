Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75877016D9
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEMNRq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjEMNRp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 09:17:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928B5E77
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:17:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64395e741fcso11428163b3a.2
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683983861; x=1686575861;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NKvhJzaCzSWZ06RSrZkhJzv/aAUSRwZGCEBWOFFGFy0=;
        b=LLcSY6eeLy/XEmQgcpsxQ5b1Tm5ZmRluOwl9YwnX6R60Czhiowvj8UFNiwwvSHwQAp
         RDwzarc+Xj9m12gA6vpdi6aPDU4QT4zLUOUjLFcVKwvtaZcpwe2LkAlvnQd3cem5YKhk
         VFLKEpG9vin1ZTXt0d+ladQBLSDT0IRw4AdEf5yv8kwTWaLSwVMJ88+3svl2KrNrxTvy
         vo+QE9PTCKhEOzMLovTOdMB1VagE5MOU5NMzA98Cx/FyUNva0rJADgY8bUN2y0XZSQDg
         11d/Yw1jk9CWsuxk0VTbsZPPrB7j12sYb+mx2yss2yC5ScWr0dbF7R62CDi7EAlClaX0
         PU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683983861; x=1686575861;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKvhJzaCzSWZ06RSrZkhJzv/aAUSRwZGCEBWOFFGFy0=;
        b=fAX1atbk7kC7iaCBSzxNBjE4ugOn0nJjnmQatVr/G1WEp2x3wVkFNT4kSaU62rvAZh
         HsPRI9hpNREIUXlspEKMYKijR96rIVmH1YCd4Q039xKapNmy5cee4Ag2L4AG+edGtrHL
         BPXP+ARZ3w7jSshNKh2AkNvVX1nKIUwg/zgvmkLG+Bs4ksKXwtPu7KQ32GpXZJa6txq/
         aDCBSCnKfM5D3vPoND1Yx2BK6Vn+W7O1hlfsRRPJptiz/gAip3j1YojoAEW0J3SksABI
         /dEhVIaDiO51xWWb0ewVhOOxbe/QTo/a5YAr1XTZJ7FsSzkksy4sRIw7rqxEQ0T6zVJT
         4vvg==
X-Gm-Message-State: AC+VfDwDsAE570VLUOZky9Sny/AZjCUZFHd67xeqrNGjsDj71NqhNaxr
        iWs5RUMX7dmtbVPBAqUUbH5QTRcW6dLORWH8SXE=
X-Google-Smtp-Source: ACHHUZ4lpS1lMhVFDiLpFggNtdvILjj2Ac1X2d/AUsWgpZz85PK0heSoKvqheNrTDd8MZ67mkIX/tg==
X-Received: by 2002:a05:6a21:78a8:b0:f1:f894:9e6e with SMTP id bf40-20020a056a2178a800b000f1f8949e6emr38295926pzc.5.1683983861238;
        Sat, 13 May 2023 06:17:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b006328ee1e56csm8723689pfm.2.2023.05.13.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 06:17:40 -0700 (PDT)
Message-ID: <645f8df4.a70a0220.9f087.228f@mx.google.com>
Date:   Sat, 13 May 2023 06:17:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-98-g74a054a6fefd1
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 181 runs,
 10 regressions (v5.15.111-98-g74a054a6fefd1)
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

stable-rc/queue/5.15 baseline: 181 runs, 10 regressions (v5.15.111-98-g74a0=
54a6fefd1)

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

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-98-g74a054a6fefd1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-98-g74a054a6fefd1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      74a054a6fefd1ca013534b56fda6d8c1c1768c57 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5c2d5219d0ab912e8620

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5c2d5219d0ab912e8625
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T09:44:55.929893  + set<8>[   11.403870] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10303284_1.4.2.3.1>

    2023-05-13T09:44:55.929979   +x

    2023-05-13T09:44:56.033856  / # #

    2023-05-13T09:44:56.134415  export SHELL=3D/bin/sh

    2023-05-13T09:44:56.134601  #

    2023-05-13T09:44:56.235140  / # export SHELL=3D/bin/sh. /lava-10303284/=
environment

    2023-05-13T09:44:56.235306  =


    2023-05-13T09:44:56.335798  / # . /lava-10303284/environment/lava-10303=
284/bin/lava-test-runner /lava-10303284/1

    2023-05-13T09:44:56.336098  =


    2023-05-13T09:44:56.340488  / # /lava-10303284/bin/lava-test-runner /la=
va-10303284/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5c3121ae0195db2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5c3121ae0195db2e85eb
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T09:44:58.697254  <8>[   10.968214] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10303331_1.4.2.3.1>

    2023-05-13T09:44:58.701097  + set +x

    2023-05-13T09:44:58.802791  =


    2023-05-13T09:44:58.903344  / # #export SHELL=3D/bin/sh

    2023-05-13T09:44:58.903555  =


    2023-05-13T09:44:59.004065  / # export SHELL=3D/bin/sh. /lava-10303331/=
environment

    2023-05-13T09:44:59.004289  =


    2023-05-13T09:44:59.104807  / # . /lava-10303331/environment/lava-10303=
331/bin/lava-test-runner /lava-10303331/1

    2023-05-13T09:44:59.105107  =


    2023-05-13T09:44:59.110388  / # /lava-10303331/bin/lava-test-runner /la=
va-10303331/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5cf81f7824fddd2e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645f5cf81f7824fddd2e8=
5f3
        failing since 98 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645f594a977fbc911b2e8619

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f594a977fbc911b2e861e
        failing since 116 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-13T09:32:29.506811  + set +x<8>[    9.975977] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3583194_1.5.2.4.1>
    2023-05-13T09:32:29.507418  =

    2023-05-13T09:32:29.617979  / # #
    2023-05-13T09:32:29.721116  export SHELL=3D/bin/sh
    2023-05-13T09:32:29.722077  #
    2023-05-13T09:32:29.722667  / # <3>[   10.112616] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-05-13T09:32:29.824679  export SHELL=3D/bin/sh. /lava-3583194/envir=
onment
    2023-05-13T09:32:29.825531  =

    2023-05-13T09:32:29.927554  / # . /lava-3583194/environment/lava-358319=
4/bin/lava-test-runner /lava-3583194/1
    2023-05-13T09:32:29.929082   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5c2086bcbf7ee62e8610

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5c2086bcbf7ee62e8615
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T09:44:53.576836  + set +x

    2023-05-13T09:44:53.583520  <8>[   10.457798] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10303312_1.4.2.3.1>

    2023-05-13T09:44:53.687693  / # #

    2023-05-13T09:44:53.788269  export SHELL=3D/bin/sh

    2023-05-13T09:44:53.788472  #

    2023-05-13T09:44:53.888952  / # export SHELL=3D/bin/sh. /lava-10303312/=
environment

    2023-05-13T09:44:53.889145  =


    2023-05-13T09:44:53.989638  / # . /lava-10303312/environment/lava-10303=
312/bin/lava-test-runner /lava-10303312/1

    2023-05-13T09:44:53.989918  =


    2023-05-13T09:44:53.994359  / # /lava-10303312/bin/lava-test-runner /la=
va-10303312/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5c1823a45667772e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5c1823a45667772e85f0
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T09:44:41.373620  <8>[   10.574702] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10303290_1.4.2.3.1>

    2023-05-13T09:44:41.377158  + set +x

    2023-05-13T09:44:41.482313  #

    2023-05-13T09:44:41.483656  =


    2023-05-13T09:44:41.585527  / # #export SHELL=3D/bin/sh

    2023-05-13T09:44:41.586327  =


    2023-05-13T09:44:41.687949  / # export SHELL=3D/bin/sh. /lava-10303290/=
environment

    2023-05-13T09:44:41.688776  =


    2023-05-13T09:44:41.790313  / # . /lava-10303290/environment/lava-10303=
290/bin/lava-test-runner /lava-10303290/1

    2023-05-13T09:44:41.791495  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5c3321ae0195db2e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5c3421ae0195db2e85fc
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T09:45:01.522515  + <8>[   10.900161] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10303305_1.4.2.3.1>

    2023-05-13T09:45:01.522608  set +x

    2023-05-13T09:45:01.626553  / # #

    2023-05-13T09:45:01.727298  export SHELL=3D/bin/sh

    2023-05-13T09:45:01.727515  #

    2023-05-13T09:45:01.828046  / # export SHELL=3D/bin/sh. /lava-10303305/=
environment

    2023-05-13T09:45:01.828258  =


    2023-05-13T09:45:01.928778  / # . /lava-10303305/environment/lava-10303=
305/bin/lava-test-runner /lava-10303305/1

    2023-05-13T09:45:01.929070  =


    2023-05-13T09:45:01.933857  / # /lava-10303305/bin/lava-test-runner /la=
va-10303305/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5c1b54257cece32e8610

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5c1b54257cece32e8615
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-13T09:44:42.922756  <8>[   11.712294] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10303323_1.4.2.3.1>

    2023-05-13T09:44:43.030893  / # #

    2023-05-13T09:44:43.131998  export SHELL=3D/bin/sh

    2023-05-13T09:44:43.132810  #

    2023-05-13T09:44:43.234359  / # export SHELL=3D/bin/sh. /lava-10303323/=
environment

    2023-05-13T09:44:43.235136  =


    2023-05-13T09:44:43.336907  / # . /lava-10303323/environment/lava-10303=
323/bin/lava-test-runner /lava-10303323/1

    2023-05-13T09:44:43.338511  =


    2023-05-13T09:44:43.343556  / # /lava-10303323/bin/lava-test-runner /la=
va-10303323/1

    2023-05-13T09:44:43.348802  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5ab2823dc2d56a2e860d

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5ab2823dc2d56a2e863a
        failing since 115 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-13T09:38:40.970873  + set +x
    2023-05-13T09:38:40.974309  <8>[   16.061553] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3583237_1.5.2.4.1>
    2023-05-13T09:38:41.096659  / # #
    2023-05-13T09:38:41.203042  export SHELL=3D/bin/sh
    2023-05-13T09:38:41.204639  #
    2023-05-13T09:38:41.308268  / # export SHELL=3D/bin/sh. /lava-3583237/e=
nvironment
    2023-05-13T09:38:41.309973  =

    2023-05-13T09:38:41.413690  / # . /lava-3583237/environment/lava-358323=
7/bin/lava-test-runner /lava-3583237/1
    2023-05-13T09:38:41.416621  =

    2023-05-13T09:38:41.419643  / # /lava-3583237/bin/lava-test-runner /lav=
a-3583237/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645f55452d7a3eefa72e8603

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-98-g74a054a6fefd1/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f55452d7a3eefa72e8608
        failing since 101 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.90-203-gea2e94bef77e)

    2023-05-13T09:15:29.510898  / # #
    2023-05-13T09:15:29.621401  export SHELL=3D/bin/sh
    2023-05-13T09:15:29.622974  #
    2023-05-13T09:15:29.726211  / # export SHELL=3D/bin/sh. /lava-3583116/e=
nvironment
    2023-05-13T09:15:29.727724  =

    2023-05-13T09:15:29.831145  / # . /lava-3583116/environment/lava-358311=
6/bin/lava-test-runner /lava-3583116/1
    2023-05-13T09:15:29.833816  =

    2023-05-13T09:15:29.840533  / # /lava-3583116/bin/lava-test-runner /lav=
a-3583116/1
    2023-05-13T09:15:29.977324  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-13T09:15:29.978452  + cd /lava-3583116/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
