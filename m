Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D486A70180D
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbjEMPcS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 11:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMPcR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 11:32:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9A30C2
        for <stable@vger.kernel.org>; Sat, 13 May 2023 08:32:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64ab2a37812so10849291b3a.1
        for <stable@vger.kernel.org>; Sat, 13 May 2023 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683991934; x=1686583934;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+LWf8uBgvgozpWCiW2Wh/9U8ID2GksRXmNeQEkyeWs4=;
        b=Gj07JXA4OLN2nWnhfeEME/4W0EjAX+6asUOKxgifKOiWtZzwMEAauGKsW8gxlRB2JS
         HHhX3OJxvR2rYaomnfqbB7cJ6jnn8XlvVGQjnqEWuFxNoTToPvP1E0K9VlcFtJF8jbkX
         4xAm7XOyfOL5vXbj1eWMrGSJ+TZgqUfJY9wsomIgV6JRv8jWgaEI6UKgJ++UK/leRNHt
         kQXnWIjSbFE3pKg8A6QiVia1eHELyHjJAxWB/JGThef8jFmb1yLzvVSa8VAQ36ccuUqc
         ubdHnAr3NBP6J1KHahHOuATVkGSVToIrVCo6nEphdP3Mb9IqoKEtMiA/LNPhiE8EZOAv
         fxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683991934; x=1686583934;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LWf8uBgvgozpWCiW2Wh/9U8ID2GksRXmNeQEkyeWs4=;
        b=Rn1JCy2tVxFxdG4SjcoPQDOs9+pwnYKYModT8+yK1W447/D6a/SBWrqS0Yl7NIMcFh
         XtDKQjQv311oLBalcRBrqh6wOSnGxrIDpHMyIsZmElC9ULzi4YEarguiuxeqETzbBg5k
         EvFmFDCB4rIFpTZRPTpB+TePPzKIc73RtMO0c96vWl+ZcYhMOPccprJDVA00wGXU2c9J
         MjaeDldGdUmwYx2j5ZT/6xJ8b6PZ9kN9BJfa9AKaNFPqxFQaWWIjPX7W/rYxtYVv/Xtw
         U31EDZKnpTBQpgNOW1CUZuFqj2eWQ17fQrHlrTgy+387Zo82PINqeV01NLEZmahLX0+f
         NB2Q==
X-Gm-Message-State: AC+VfDwjplj/BijgwTwgN/heGzJ5GwEVeYskjloc00GLqFq2x4K8QGci
        lUdhKNFdsRbRZE6FsmfhVIIHqpb9gRu3wIqiWho=
X-Google-Smtp-Source: ACHHUZ4Aowr4PVJPBNzTVGgsi12PGb+cBs3QfTmtRh9YYe9bMlsh8lAMCKPPzKzZ6LS3Apd1DHHABg==
X-Received: by 2002:a17:90a:502:b0:250:648b:781d with SMTP id h2-20020a17090a050200b00250648b781dmr27819356pjh.23.1683991933527;
        Sat, 13 May 2023 08:32:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm11325004pjb.6.2023.05.13.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 08:32:13 -0700 (PDT)
Message-ID: <645fad7d.170a0220.2dc39.58be@mx.google.com>
Date:   Sat, 13 May 2023 08:32:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-183-gb35b1f6de36bb
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 181 runs,
 11 regressions (v6.1.28-183-gb35b1f6de36bb)
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

stable-rc/queue/6.1 baseline: 181 runs, 11 regressions (v6.1.28-183-gb35b1f=
6de36bb)

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

odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-183-gb35b1f6de36bb/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-183-gb35b1f6de36bb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b35b1f6de36bba692669bc17cc73a8c04ab72347 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f7a089793dc63d72e86c6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f7a089793dc63d72e86cb
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T11:52:31.006582  <8>[   16.426091] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10304438_1.4.2.3.1>

    2023-05-13T11:52:31.010248  + set +x

    2023-05-13T11:52:31.114180  / # #

    2023-05-13T11:52:31.214812  export SHELL=3D/bin/sh

    2023-05-13T11:52:31.215030  #

    2023-05-13T11:52:31.315544  / # export SHELL=3D/bin/sh. /lava-10304438/=
environment

    2023-05-13T11:52:31.315758  =


    2023-05-13T11:52:31.416273  / # . /lava-10304438/environment/lava-10304=
438/bin/lava-test-runner /lava-10304438/1

    2023-05-13T11:52:31.416560  =


    2023-05-13T11:52:31.422105  / # /lava-10304438/bin/lava-test-runner /la=
va-10304438/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f7a0c7953a510a02e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f7a0c7953a510a02e85fa
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T11:52:24.191361  + set<8>[   11.600031] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10304471_1.4.2.3.1>

    2023-05-13T11:52:24.191498   +x

    2023-05-13T11:52:24.295600  / # #

    2023-05-13T11:52:24.396345  export SHELL=3D/bin/sh

    2023-05-13T11:52:24.396568  #

    2023-05-13T11:52:24.497121  / # export SHELL=3D/bin/sh. /lava-10304471/=
environment

    2023-05-13T11:52:24.497347  =


    2023-05-13T11:52:24.597912  / # . /lava-10304471/environment/lava-10304=
471/bin/lava-test-runner /lava-10304471/1

    2023-05-13T11:52:24.598319  =


    2023-05-13T11:52:24.603377  / # /lava-10304471/bin/lava-test-runner /la=
va-10304471/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f7a12f2f350184b2e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f7a12f2f350184b2e85f6
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T11:52:27.168840  <8>[   10.303804] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10304458_1.4.2.3.1>

    2023-05-13T11:52:27.171872  + set +x

    2023-05-13T11:52:27.273292  /#

    2023-05-13T11:52:27.374232   # #export SHELL=3D/bin/sh

    2023-05-13T11:52:27.374473  =


    2023-05-13T11:52:27.475039  / # export SHELL=3D/bin/sh. /lava-10304458/=
environment

    2023-05-13T11:52:27.475280  =


    2023-05-13T11:52:27.575849  / # . /lava-10304458/environment/lava-10304=
458/bin/lava-test-runner /lava-10304458/1

    2023-05-13T11:52:27.576244  =


    2023-05-13T11:52:27.581058  / # /lava-10304458/bin/lava-test-runner /la=
va-10304458/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645f7d94892e14dad82e8606

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645f7d94892e14dad82e8=
607
        failing since 23 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f7a024defb0a7112e8614

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f7a024defb0a7112e8619
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T11:52:23.269220  + set +x

    2023-05-13T11:52:23.276039  <8>[   11.594183] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10304426_1.4.2.3.1>

    2023-05-13T11:52:23.380201  / # #

    2023-05-13T11:52:23.480841  export SHELL=3D/bin/sh

    2023-05-13T11:52:23.481038  #

    2023-05-13T11:52:23.581581  / # export SHELL=3D/bin/sh. /lava-10304426/=
environment

    2023-05-13T11:52:23.581775  =


    2023-05-13T11:52:23.682252  / # . /lava-10304426/environment/lava-10304=
426/bin/lava-test-runner /lava-10304426/1

    2023-05-13T11:52:23.682549  =


    2023-05-13T11:52:23.686869  / # /lava-10304426/bin/lava-test-runner /la=
va-10304426/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f79f541b59f7ecb2e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f79f541b59f7ecb2e85f6
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T11:52:07.076899  <8>[    9.871519] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10304412_1.4.2.3.1>

    2023-05-13T11:52:07.080301  + set +x

    2023-05-13T11:52:07.181506  #

    2023-05-13T11:52:07.181764  =


    2023-05-13T11:52:07.282329  / # #export SHELL=3D/bin/sh

    2023-05-13T11:52:07.282530  =


    2023-05-13T11:52:07.383064  / # export SHELL=3D/bin/sh. /lava-10304412/=
environment

    2023-05-13T11:52:07.383264  =


    2023-05-13T11:52:07.483849  / # . /lava-10304412/environment/lava-10304=
412/bin/lava-test-runner /lava-10304412/1

    2023-05-13T11:52:07.484220  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f7a13208adacb002e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f7a13208adacb002e85f9
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T11:52:27.031998  + set<8>[   11.203505] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10304495_1.4.2.3.1>

    2023-05-13T11:52:27.032147   +x

    2023-05-13T11:52:27.136531  / # #

    2023-05-13T11:52:27.237300  export SHELL=3D/bin/sh

    2023-05-13T11:52:27.237531  #

    2023-05-13T11:52:27.338027  / # export SHELL=3D/bin/sh. /lava-10304495/=
environment

    2023-05-13T11:52:27.338314  =


    2023-05-13T11:52:27.438922  / # . /lava-10304495/environment/lava-10304=
495/bin/lava-test-runner /lava-10304495/1

    2023-05-13T11:52:27.439245  =


    2023-05-13T11:52:27.443785  / # /lava-10304495/bin/lava-test-runner /la=
va-10304495/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f79f79793dc63d72e864a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f79f79793dc63d72e864f
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T11:52:10.108685  + <8>[   12.212227] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10304441_1.4.2.3.1>

    2023-05-13T11:52:10.108777  set +x

    2023-05-13T11:52:10.213228  / # #

    2023-05-13T11:52:10.313856  export SHELL=3D/bin/sh

    2023-05-13T11:52:10.314067  #

    2023-05-13T11:52:10.414611  / # export SHELL=3D/bin/sh. /lava-10304441/=
environment

    2023-05-13T11:52:10.414843  =


    2023-05-13T11:52:10.515365  / # . /lava-10304441/environment/lava-10304=
441/bin/lava-test-runner /lava-10304441/1

    2023-05-13T11:52:10.515627  =


    2023-05-13T11:52:10.520567  / # /lava-10304441/bin/lava-test-runner /la=
va-10304441/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645f79e15c1f71cae02e8606

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645f79e15c1f71cae02e8622
        failing since 6 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-13T11:51:45.008627  /lava-10304372/1/../bin/lava-test-case

    2023-05-13T11:51:45.017983  <8>[   22.961428] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f79e15c1f71cae02e86ae
        failing since 6 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-13T11:51:39.562396  + set +x

    2023-05-13T11:51:39.565616  <8>[   17.512644] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10304372_1.5.2.3.1>

    2023-05-13T11:51:39.674604  / # #

    2023-05-13T11:51:39.775404  export SHELL=3D/bin/sh

    2023-05-13T11:51:39.775636  #

    2023-05-13T11:51:39.876187  / # export SHELL=3D/bin/sh. /lava-10304372/=
environment

    2023-05-13T11:51:39.876377  =


    2023-05-13T11:51:39.976876  / # . /lava-10304372/environment/lava-10304=
372/bin/lava-test-runner /lava-10304372/1

    2023-05-13T11:51:39.977211  =


    2023-05-13T11:51:39.982831  / # /lava-10304372/bin/lava-test-runner /la=
va-10304372/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645f7ae11d80f7db5a2e86b4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroi=
d-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
3-gb35b1f6de36bb/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroi=
d-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645f7ae11d80f7db5a2e8=
6b5
        new failure (last pass: v6.1.28-181-g0875fdeac3382) =

 =20
