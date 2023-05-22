Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A592470B48D
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 07:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjEVF3J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 01:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVF3I (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 01:29:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAEDA8
        for <stable@vger.kernel.org>; Sun, 21 May 2023 22:29:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae52ce3250so52315795ad.2
        for <stable@vger.kernel.org>; Sun, 21 May 2023 22:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684733345; x=1687325345;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ifOxlOTwo1WQvyozu4xGEhHGujUCgmzleF9qds5BDY8=;
        b=R3KHOGNJ7seUOdP8z6W1w/U3wloaLyePow7POiWBq6axf3JkYdxLlHFYmztANnQZWd
         my+z/rTnGr7g6HW5RZV6euHV6mG0FX03KtU9AKY+vJ2xpGkHVv5W+jc+rOwEzNsD7JTX
         LCPtQ9uISD2Ikm9IoroHTqMA5bcRyJ4uuPZwjzQTyvkZQVdpE4I3Xsj91o2ufGgblOhT
         M5xCEAFFTXGO5l4f6wPzTDjao+WCnzH0R1rIJDL1gpgm6kKwuV8mNn8aSVYgRg3lSk94
         ATNv/RmIq9ysMPZKVoKlBswzsfCZBK148IPWLNDUnf+7hYQIQk1kycLqlLZzgJC//VdE
         wJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733345; x=1687325345;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifOxlOTwo1WQvyozu4xGEhHGujUCgmzleF9qds5BDY8=;
        b=DDk1L25GWrztxAXIQj0IAyLP4iwXwj7dHimyuxLzI/Z6TkhKCbu9Hlv/xrKj2wa8V6
         1m0SHaNByApfwVBhQ3eY2s6DJsr95l8GQez1i7l40BRTO9Js7W7tfSf12feLlbbuEjQZ
         lbrtNzbYZWujJw6yhFfV/tAvZwAvXaH3aqkKx2atamTndEbkMW9OLH3TtsqBc6rnUYMW
         NosA4VoqtAQgnJUTuwm9BBMt478GKTjyC7e/9ARFs/COi7sUuhL7lSeuw1/dcax4fP8b
         /s/sfvYhtKzucL8j8E+1y4KqN0sRh3d87B1t5VXGf3tjyQZbQ3TH+0DW4siD8VYSx9fJ
         a14w==
X-Gm-Message-State: AC+VfDzUMBEaVSTyvvoxZWAZqR81TYhpiwGAmyFRroFJGuQFBFtCaO1e
        I0Xg7C0Nq7qtiEXOclpDoBCWnzShLYipmfCh7u8=
X-Google-Smtp-Source: ACHHUZ6h0V3RBICxIFU+hgQK6+ln7UEqYxKDaceIE/O+N6/j6F1UrJwvaSujmLfLudtN4z/wRY+VWg==
X-Received: by 2002:a17:90b:68f:b0:250:aa60:b4bc with SMTP id m15-20020a17090b068f00b00250aa60b4bcmr9173569pjz.10.1684733345302;
        Sun, 21 May 2023 22:29:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id nn2-20020a17090b38c200b0024e1236f599sm3255163pjb.8.2023.05.21.22.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:29:04 -0700 (PDT)
Message-ID: <646afda0.170a0220.d6eec.4db1@mx.google.com>
Date:   Sun, 21 May 2023 22:29:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-150-g25825cbc65ca
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 159 runs,
 9 regressions (v6.1.29-150-g25825cbc65ca)
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

stable-rc/queue/6.1 baseline: 159 runs, 9 regressions (v6.1.29-150-g25825cb=
c65ca)

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
el/v6.1.29-150-g25825cbc65ca/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-150-g25825cbc65ca
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      25825cbc65ca72f9f1581db9dc8d91da2de6b963 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac960f596fb7d592e8634

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac960f596fb7d592e8639
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T01:45:45.814776  + set +x

    2023-05-22T01:45:45.821097  <8>[   10.682468] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10405893_1.4.2.3.1>

    2023-05-22T01:45:45.925611  / # #

    2023-05-22T01:45:46.026201  export SHELL=3D/bin/sh

    2023-05-22T01:45:46.026432  #

    2023-05-22T01:45:46.126899  / # export SHELL=3D/bin/sh. /lava-10405893/=
environment

    2023-05-22T01:45:46.127121  =


    2023-05-22T01:45:46.227675  / # . /lava-10405893/environment/lava-10405=
893/bin/lava-test-runner /lava-10405893/1

    2023-05-22T01:45:46.227979  =


    2023-05-22T01:45:46.233446  / # /lava-10405893/bin/lava-test-runner /la=
va-10405893/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac94cb0035cdfd62e8662

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac94cb0035cdfd62e8667
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T01:45:42.221180  + <8>[   12.164545] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10405918_1.4.2.3.1>

    2023-05-22T01:45:42.221336  set +x

    2023-05-22T01:45:42.326273  / # #

    2023-05-22T01:45:42.427128  export SHELL=3D/bin/sh

    2023-05-22T01:45:42.427471  #

    2023-05-22T01:45:42.528132  / # export SHELL=3D/bin/sh. /lava-10405918/=
environment

    2023-05-22T01:45:42.528460  =


    2023-05-22T01:45:42.629106  / # . /lava-10405918/environment/lava-10405=
918/bin/lava-test-runner /lava-10405918/1

    2023-05-22T01:45:42.629524  =


    2023-05-22T01:45:42.633617  / # /lava-10405918/bin/lava-test-runner /la=
va-10405918/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac9531f045407ab2e865a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac9531f045407ab2e865f
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T01:45:48.402618  <8>[   11.314443] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10405925_1.4.2.3.1>

    2023-05-22T01:45:48.402690  + set +x

    2023-05-22T01:45:48.506947  / # #

    2023-05-22T01:45:48.607767  export SHELL=3D/bin/sh

    2023-05-22T01:45:48.607973  #

    2023-05-22T01:45:48.708507  / # export SHELL=3D/bin/sh. /lava-10405925/=
environment

    2023-05-22T01:45:48.708790  =


    2023-05-22T01:45:48.809381  / # . /lava-10405925/environment/lava-10405=
925/bin/lava-test-runner /lava-10405925/1

    2023-05-22T01:45:48.809791  =


    2023-05-22T01:45:48.814867  / # /lava-10405925/bin/lava-test-runner /la=
va-10405925/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac94cb0035cdfd62e8657

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac94cb0035cdfd62e865c
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T01:45:31.803847  + set +x

    2023-05-22T01:45:31.810408  <8>[   11.282287] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10405881_1.4.2.3.1>

    2023-05-22T01:45:31.914675  / # #

    2023-05-22T01:45:32.015410  export SHELL=3D/bin/sh

    2023-05-22T01:45:32.015639  #

    2023-05-22T01:45:32.116204  / # export SHELL=3D/bin/sh. /lava-10405881/=
environment

    2023-05-22T01:45:32.116443  =


    2023-05-22T01:45:32.217035  / # . /lava-10405881/environment/lava-10405=
881/bin/lava-test-runner /lava-10405881/1

    2023-05-22T01:45:32.217310  =


    2023-05-22T01:45:32.221935  / # /lava-10405881/bin/lava-test-runner /la=
va-10405881/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac94cf596fb7d592e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac94cf596fb7d592e8603
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T01:45:33.430558  <8>[   10.034853] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10405886_1.4.2.3.1>

    2023-05-22T01:45:33.434008  + set +x

    2023-05-22T01:45:33.538229  / # #

    2023-05-22T01:45:33.638808  export SHELL=3D/bin/sh

    2023-05-22T01:45:33.638975  #

    2023-05-22T01:45:33.739533  / # export SHELL=3D/bin/sh. /lava-10405886/=
environment

    2023-05-22T01:45:33.739705  =


    2023-05-22T01:45:33.840206  / # . /lava-10405886/environment/lava-10405=
886/bin/lava-test-runner /lava-10405886/1

    2023-05-22T01:45:33.840522  =


    2023-05-22T01:45:33.845618  / # /lava-10405886/bin/lava-test-runner /la=
va-10405886/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac96a33db211e4c2e8627

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac96a33db211e4c2e862c
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T01:45:53.996634  + <8>[   11.366508] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10405916_1.4.2.3.1>

    2023-05-22T01:45:53.997127  set +x

    2023-05-22T01:45:54.104924  / # #

    2023-05-22T01:45:54.207450  export SHELL=3D/bin/sh

    2023-05-22T01:45:54.208234  #

    2023-05-22T01:45:54.309618  / # export SHELL=3D/bin/sh. /lava-10405916/=
environment

    2023-05-22T01:45:54.310344  =


    2023-05-22T01:45:54.411886  / # . /lava-10405916/environment/lava-10405=
916/bin/lava-test-runner /lava-10405916/1

    2023-05-22T01:45:54.413054  =


    2023-05-22T01:45:54.417762  / # /lava-10405916/bin/lava-test-runner /la=
va-10405916/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac967768b2474622e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac967768b2474622e85ed
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T01:45:51.044822  + set<8>[   11.691161] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10405878_1.4.2.3.1>

    2023-05-22T01:45:51.044940   +x

    2023-05-22T01:45:51.149551  / # #

    2023-05-22T01:45:51.250307  export SHELL=3D/bin/sh

    2023-05-22T01:45:51.250533  #

    2023-05-22T01:45:51.351059  / # export SHELL=3D/bin/sh. /lava-10405878/=
environment

    2023-05-22T01:45:51.351266  =


    2023-05-22T01:45:51.451823  / # . /lava-10405878/environment/lava-10405=
878/bin/lava-test-runner /lava-10405878/1

    2023-05-22T01:45:51.452084  =


    2023-05-22T01:45:51.456875  / # /lava-10405878/bin/lava-test-runner /la=
va-10405878/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646acad9e90eca462e2e85f0

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-15=
0-g25825cbc65ca/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/646acadae90eca462e2e860c
        failing since 14 days (last pass: v6.1.22-704-ga3dcd1f09de2, first =
fail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-22T01:52:10.538457  /lava-10405953/1/../bin/lava-test-case

    2023-05-22T01:52:10.544927  <8>[   22.998565] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646acadae90eca462e2e8698
        failing since 14 days (last pass: v6.1.22-704-ga3dcd1f09de2, first =
fail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-22T01:52:05.093951  + set +x

    2023-05-22T01:52:05.100716  <8>[   17.552961] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10405953_1.5.2.3.1>

    2023-05-22T01:52:05.205551  / # #

    2023-05-22T01:52:05.306135  export SHELL=3D/bin/sh

    2023-05-22T01:52:05.306317  #

    2023-05-22T01:52:05.406849  / # export SHELL=3D/bin/sh. /lava-10405953/=
environment

    2023-05-22T01:52:05.407057  =


    2023-05-22T01:52:05.507615  / # . /lava-10405953/environment/lava-10405=
953/bin/lava-test-runner /lava-10405953/1

    2023-05-22T01:52:05.507881  =


    2023-05-22T01:52:05.512710  / # /lava-10405953/bin/lava-test-runner /la=
va-10405953/1
 =

    ... (13 line(s) more)  =

 =20
