Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2316FC135
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjEIIG3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjEIIGL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 04:06:11 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10377DDB0
        for <stable@vger.kernel.org>; Tue,  9 May 2023 01:05:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52cbd7d0c37so2369986a12.3
        for <stable@vger.kernel.org>; Tue, 09 May 2023 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683619493; x=1686211493;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t0uDdoTVT5zOxbM8n/XBajpH7CbUSH/3GEkCBK1jV+M=;
        b=i8jIQ2FY4YfL0BHt3OpZmVbMWxMJYDad1agpF61vpnSdtcfRGAJ4lxbGZInLn/9jh0
         hqHNUOyrNqWmGp47DGR/lISLBJg8RA5gLbQI1WTrYXnA0YCx3JDgouRA00ttiIPWO6GX
         5g7pmnYmIbCz7qyh0Vt8v+ifFDlOU/4hcyNXrfMnAIvPd84uuGuoKmxkScCA/RKArPXz
         y2UutvJdvF73/TBAmFUosEmazPMG+dTPZ3ee0uZHrx0X2CywGeI13i5X/mAmieIzgLsp
         sh8C6pt9Gf1wci9tuIBZYBOkyw2zOmdorplkhfK8hVwAEYiMEuUbys0es60TApH6EZqo
         Gtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683619493; x=1686211493;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0uDdoTVT5zOxbM8n/XBajpH7CbUSH/3GEkCBK1jV+M=;
        b=FX2Z/kbK6Vz6j+7l09OxIgBu/XTAuunjphAm98rNBrsUp7KI+y3sitd2Cw/YNRrzmC
         QwBJIZs9pYDVth9ZS9y6qd14nvJJh2h9XbMMBaZVB2j11pih8fDxbN4g26sqBVSa24Wk
         T0Y00+4bXwnKQvQVc63sHZd/K4uBXI23Usj+aPMBxthWz4vpGC73MA6kj8CU84zrQ6SL
         uut3Fy+FC8bC1OzrGzJmpICcJin/o2KMLK5ElACnv9d5pBWQtEM7O+a0LK23qoce05Lq
         YqnFDqkWPMFkP1umf22HESKGFEMfMa+2Dpwp+J8x9NwULy+gPKa3QJ+XFh1Yh2byU5/v
         WV2A==
X-Gm-Message-State: AC+VfDxSRZzp7boF58mopKbYG8OXrfN2Y5Ys6GNgD8qoQw/5K8u8WDtS
        UfAmMHwr47x/lw0V+xhxry+RMJp3gAZqM2kO3V86qA==
X-Google-Smtp-Source: ACHHUZ6rxwUtW22Z/td5rbO224RhH2Q6ZpY1aF4Bnk8CCoLJDdhsQqSNHv3nvEnTz2GX6I8slCcWhQ==
X-Received: by 2002:a17:902:d2cc:b0:1aa:ffe1:de13 with SMTP id n12-20020a170902d2cc00b001aaffe1de13mr15476726plc.5.1683619492942;
        Tue, 09 May 2023 01:04:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709029b8200b001a50ae08284sm847501plp.301.2023.05.09.01.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 01:04:52 -0700 (PDT)
Message-ID: <6459fea4.170a0220.e65d9.1829@mx.google.com>
Date:   Tue, 09 May 2023 01:04:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-731-gf083435ecac9
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 141 runs,
 8 regressions (v5.15.105-731-gf083435ecac9)
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

stable-rc/queue/5.15 baseline: 141 runs, 8 regressions (v5.15.105-731-gf083=
435ecac9)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-731-gf083435ecac9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-731-gf083435ecac9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f083435ecac97fc53bc20cabfad9fa308d32d775 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c833aba542a3142e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459c833aba542a3142e85ef
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T04:12:18.563297  + set<8>[   11.834399] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10249643_1.4.2.3.1>

    2023-05-09T04:12:18.563376   +x

    2023-05-09T04:12:18.667294  / # #

    2023-05-09T04:12:18.768089  export SHELL=3D/bin/sh

    2023-05-09T04:12:18.768741  #

    2023-05-09T04:12:18.870005  / # export SHELL=3D/bin/sh. /lava-10249643/=
environment

    2023-05-09T04:12:18.870808  =


    2023-05-09T04:12:18.972353  / # . /lava-10249643/environment/lava-10249=
643/bin/lava-test-runner /lava-10249643/1

    2023-05-09T04:12:18.973565  =


    2023-05-09T04:12:18.978294  / # /lava-10249643/bin/lava-test-runner /la=
va-10249643/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c839d6aaa6f0782e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459c839d6aaa6f0782e862b
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T04:12:20.794499  <8>[   10.522375] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10249595_1.4.2.3.1>

    2023-05-09T04:12:20.797657  + set +x

    2023-05-09T04:12:20.900136  =


    2023-05-09T04:12:21.000732  / # #export SHELL=3D/bin/sh

    2023-05-09T04:12:21.001034  =


    2023-05-09T04:12:21.101684  / # export SHELL=3D/bin/sh. /lava-10249595/=
environment

    2023-05-09T04:12:21.101994  =


    2023-05-09T04:12:21.202696  / # . /lava-10249595/environment/lava-10249=
595/bin/lava-test-runner /lava-10249595/1

    2023-05-09T04:12:21.203058  =


    2023-05-09T04:12:21.207905  / # /lava-10249595/bin/lava-test-runner /la=
va-10249595/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c865d9cf410ec72e85ec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459c865d9cf410ec72e85f1
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T04:13:09.353846  + set +x

    2023-05-09T04:13:09.359998  <8>[   10.782262] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10249630_1.4.2.3.1>

    2023-05-09T04:13:09.464372  / # #

    2023-05-09T04:13:09.564882  export SHELL=3D/bin/sh

    2023-05-09T04:13:09.565093  #

    2023-05-09T04:13:09.665650  / # export SHELL=3D/bin/sh. /lava-10249630/=
environment

    2023-05-09T04:13:09.665820  =


    2023-05-09T04:13:09.766374  / # . /lava-10249630/environment/lava-10249=
630/bin/lava-test-runner /lava-10249630/1

    2023-05-09T04:13:09.766700  =


    2023-05-09T04:13:09.771107  / # /lava-10249630/bin/lava-test-runner /la=
va-10249630/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c81fb41be08a0b2e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459c81fb41be08a0b2e861f
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T04:12:00.208227  + set +x<8>[   10.325333] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10249602_1.4.2.3.1>

    2023-05-09T04:12:00.208318  =


    2023-05-09T04:12:00.309911  #

    2023-05-09T04:12:00.410719  / # #export SHELL=3D/bin/sh

    2023-05-09T04:12:00.410889  =


    2023-05-09T04:12:00.511558  / # export SHELL=3D/bin/sh. /lava-10249602/=
environment

    2023-05-09T04:12:00.512283  =


    2023-05-09T04:12:00.613626  / # . /lava-10249602/environment/lava-10249=
602/bin/lava-test-runner /lava-10249602/1

    2023-05-09T04:12:00.615124  =


    2023-05-09T04:12:00.619764  / # /lava-10249602/bin/lava-test-runner /la=
va-10249602/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c83397ba2c01262e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459c83397ba2c01262e8605
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T04:12:12.225509  + set<8>[   10.694024] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10249585_1.4.2.3.1>

    2023-05-09T04:12:12.225626   +x

    2023-05-09T04:12:12.330871  / # #

    2023-05-09T04:12:12.431544  export SHELL=3D/bin/sh

    2023-05-09T04:12:12.431817  #

    2023-05-09T04:12:12.532476  / # export SHELL=3D/bin/sh. /lava-10249585/=
environment

    2023-05-09T04:12:12.532712  =


    2023-05-09T04:12:12.633242  / # . /lava-10249585/environment/lava-10249=
585/bin/lava-test-runner /lava-10249585/1

    2023-05-09T04:12:12.633579  =


    2023-05-09T04:12:12.638389  / # /lava-10249585/bin/lava-test-runner /la=
va-10249585/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c48fd9d0da7de92e85e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459c48fd9d0da7de92e85ed
        failing since 101 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-09T03:56:54.310503  + set +x
    2023-05-09T03:56:54.310719  [    9.422647] <LAVA_SIGNAL_ENDRUN 0_dmesg =
944415_1.5.2.3.1>
    2023-05-09T03:56:54.417639  / # #
    2023-05-09T03:56:54.519124  export SHELL=3D/bin/sh
    2023-05-09T03:56:54.519551  #
    2023-05-09T03:56:54.620733  / # export SHELL=3D/bin/sh. /lava-944415/en=
vironment
    2023-05-09T03:56:54.621168  =

    2023-05-09T03:56:54.722638  / # . /lava-944415/environment/lava-944415/=
bin/lava-test-runner /lava-944415/1
    2023-05-09T03:56:54.723266  =

    2023-05-09T03:56:54.725981  / # /lava-944415/bin/lava-test-runner /lava=
-944415/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459c82db41be08a0b2e8695

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459c82db41be08a0b2e869a
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T04:12:18.310626  <8>[   11.246976] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10249638_1.4.2.3.1>

    2023-05-09T04:12:18.417812  / # #

    2023-05-09T04:12:18.520229  export SHELL=3D/bin/sh

    2023-05-09T04:12:18.521011  #

    2023-05-09T04:12:18.622505  / # export SHELL=3D/bin/sh. /lava-10249638/=
environment

    2023-05-09T04:12:18.623267  =


    2023-05-09T04:12:18.724806  / # . /lava-10249638/environment/lava-10249=
638/bin/lava-test-runner /lava-10249638/1

    2023-05-09T04:12:18.726390  =


    2023-05-09T04:12:18.730993  / # /lava-10249638/bin/lava-test-runner /la=
va-10249638/1

    2023-05-09T04:12:18.736678  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459cba165b8ee2cab2e8632

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-731-gf083435ecac9/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459cba165b8ee2cab2e865f
        failing since 111 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-09T04:25:43.695955  + set +x
    2023-05-09T04:25:43.699981  <8>[   16.076747] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3565952_1.5.2.4.1>
    2023-05-09T04:25:43.820289  / # #
    2023-05-09T04:25:43.925868  export SHELL=3D/bin/sh
    2023-05-09T04:25:43.927479  #
    2023-05-09T04:25:44.030884  / # export SHELL=3D/bin/sh. /lava-3565952/e=
nvironment
    2023-05-09T04:25:44.032480  =

    2023-05-09T04:25:44.135924  / # . /lava-3565952/environment/lava-356595=
2/bin/lava-test-runner /lava-3565952/1
    2023-05-09T04:25:44.138568  =

    2023-05-09T04:25:44.141922  / # /lava-3565952/bin/lava-test-runner /lav=
a-3565952/1 =

    ... (12 line(s) more)  =

 =20
