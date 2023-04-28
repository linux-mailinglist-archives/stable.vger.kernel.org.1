Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D878B6F1C98
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjD1Q3l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbjD1Q3k (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 12:29:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1467198
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 09:29:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso160031b3a.3
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682699378; x=1685291378;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IUSruLs1Lpfwm5xdygaURojLZBzF68GGoTOLPl15LeQ=;
        b=vyGcAf5y5m7deh31Hks6DfbDbPyXuDoWVlrsRI+zqIHyf748mztzTF0ErYy66v7+CT
         pcPDt1mihTMGeuEKCn1SxYkhnZKXxtW6SwQI9aLs2vED+x49bTZa03pRbYrivwfG7KGe
         CIK8QMI6mV8c0j7FC1ZTSsbPhdOAnbgn1UtVc30z3r+f7wm5TfHY2AfcPOBTJGYkBKUW
         KPoE8qCdtJirMmmEJF+iEZvIApHLXK3oxGyDxCNT3k1hhXHVLpTZZydww8Or+Q/TWxaw
         1rXfAmMoWS1FXq+M5GXJGu/SS7eBUlZJYHgOAGybW/ONvJaNyAhLPNyd/LEioeTsSaUf
         GR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682699378; x=1685291378;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUSruLs1Lpfwm5xdygaURojLZBzF68GGoTOLPl15LeQ=;
        b=TlN34oAjfYKnjQb3A80U82BhamqWQf3ot8LhT/Zb0lNkfqEfHcHdPBC12EAwWu0vGi
         xd4W+4GR1QiSR3IQwMbPNY8V9xPB0NGgW3V4DoqmdMniY3wca0f6WBXSvDayzSZiv0fw
         rVauqifcWBIkaGjeLjRDbxGonQ9MjHWWv2ZsfOipJ7IoJz5sHOAuWxX5HvPRas6VqgJ3
         Nr/SqKkLgaP82b4J6Sn3YVA3A9kkr74+rj2fwAUC5efkFVcLGUUN30n3Kc9sGwINLWMR
         3PBwmizW2xA+VXHWOKK4NQfqRqq3K4V8003213mPlipxVjUUUtgfXEpauApXr8DadNA0
         lmrw==
X-Gm-Message-State: AC+VfDyzv+9zCD8t7jGEvvvXzs0noVOlpfXdRAgszY9yzYazmZ0xVQGI
        8TsR3/q03K3KvZzXpjxsHXj5RNcikB6WSRqqGI8=
X-Google-Smtp-Source: ACHHUZ7ATGlEuShRKddzhhApsZqhT+whiTc7fOSW/aq4yn/RDUlkQBmO+6nRA5VXU/PX/Zr8e89BMg==
X-Received: by 2002:a05:6a21:9991:b0:f0:cef6:9d2e with SMTP id ve17-20020a056a21999100b000f0cef69d2emr7258770pzb.28.1682699377763;
        Fri, 28 Apr 2023 09:29:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b200-20020a621bd1000000b0063b1bb2e0a7sm15261021pfb.203.2023.04.28.09.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 09:29:37 -0700 (PDT)
Message-ID: <644bf471.620a0220.66631.03ae@mx.google.com>
Date:   Fri, 28 Apr 2023 09:29:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-360-gae1121374086
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 82 runs,
 8 regressions (v5.15.105-360-gae1121374086)
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

stable-rc/queue/5.15 baseline: 82 runs, 8 regressions (v5.15.105-360-gae112=
1374086)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-360-gae1121374086/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-360-gae1121374086
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ae11213740865a9862989bab15783bf9aa002977 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbac5e799cd4a2c2e860f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbac5e799cd4a2c2e8=
610
        new failure (last pass: v5.15.105-356-gaada006b099b) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbb1a27539075ce2e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bbb1a27539075ce2e85f0
        failing since 31 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T12:24:39.269509  + set<8>[   11.794118] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10151102_1.4.2.3.1>

    2023-04-28T12:24:39.269594   +x

    2023-04-28T12:24:39.373602  / # #

    2023-04-28T12:24:39.474377  export SHELL=3D/bin/sh

    2023-04-28T12:24:39.474583  #

    2023-04-28T12:24:39.575112  / # export SHELL=3D/bin/sh. /lava-10151102/=
environment

    2023-04-28T12:24:39.575468  =


    2023-04-28T12:24:39.676049  / # . /lava-10151102/environment/lava-10151=
102/bin/lava-test-runner /lava-10151102/1

    2023-04-28T12:24:39.676394  =


    2023-04-28T12:24:39.680810  / # /lava-10151102/bin/lava-test-runner /la=
va-10151102/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbb7e2e249a792a2e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bbb7e2e249a792a2e8601
        failing since 31 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T12:26:27.824247  <8>[    7.883977] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151129_1.4.2.3.1>

    2023-04-28T12:26:27.827942  + set +x

    2023-04-28T12:26:27.929503  =


    2023-04-28T12:26:28.030137  / # #export SHELL=3D/bin/sh

    2023-04-28T12:26:28.030379  =


    2023-04-28T12:26:28.131003  / # export SHELL=3D/bin/sh. /lava-10151129/=
environment

    2023-04-28T12:26:28.131285  =


    2023-04-28T12:26:28.231856  / # . /lava-10151129/environment/lava-10151=
129/bin/lava-test-runner /lava-10151129/1

    2023-04-28T12:26:28.232192  =


    2023-04-28T12:26:28.237437  / # /lava-10151129/bin/lava-test-runner /la=
va-10151129/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbb055917c78c232e860e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbb055917c78c232e8=
60f
        failing since 84 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbd3ddea9d302ea2e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bbd3ddea9d302ea2e85ff
        failing since 31 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T12:33:49.995027  + <8>[   10.843859] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10151135_1.4.2.3.1>

    2023-04-28T12:33:49.995110  set +x

    2023-04-28T12:33:50.096753  =


    2023-04-28T12:33:50.197362  / # #export SHELL=3D/bin/sh

    2023-04-28T12:33:50.197559  =


    2023-04-28T12:33:50.298103  / # export SHELL=3D/bin/sh. /lava-10151135/=
environment

    2023-04-28T12:33:50.298312  =


    2023-04-28T12:33:50.398845  / # . /lava-10151135/environment/lava-10151=
135/bin/lava-test-runner /lava-10151135/1

    2023-04-28T12:33:50.399185  =


    2023-04-28T12:33:50.403962  / # /lava-10151135/bin/lava-test-runner /la=
va-10151135/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbc3fa1e9d0b2db2e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bbc3fa1e9d0b2db2e860c
        failing since 31 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T12:29:39.762466  <8>[   10.742369] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151087_1.4.2.3.1>

    2023-04-28T12:29:39.765691  + set +x

    2023-04-28T12:29:39.867146  =


    2023-04-28T12:29:39.967901  / # #export SHELL=3D/bin/sh

    2023-04-28T12:29:39.968109  =


    2023-04-28T12:29:40.068686  / # export SHELL=3D/bin/sh. /lava-10151087/=
environment

    2023-04-28T12:29:40.069355  =


    2023-04-28T12:29:40.170697  / # . /lava-10151087/environment/lava-10151=
087/bin/lava-test-runner /lava-10151087/1

    2023-04-28T12:29:40.171783  =


    2023-04-28T12:29:40.176795  / # /lava-10151087/bin/lava-test-runner /la=
va-10151087/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bb9d6e0e05535a72e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bb9d6e0e05535a72e85f9
        failing since 31 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T12:19:24.951121  + set<8>[   10.501904] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10151146_1.4.2.3.1>

    2023-04-28T12:19:24.951231   +x

    2023-04-28T12:19:25.055535  / # #

    2023-04-28T12:19:25.156171  export SHELL=3D/bin/sh

    2023-04-28T12:19:25.156409  #

    2023-04-28T12:19:25.256930  / # export SHELL=3D/bin/sh. /lava-10151146/=
environment

    2023-04-28T12:19:25.257185  =


    2023-04-28T12:19:25.357751  / # . /lava-10151146/environment/lava-10151=
146/bin/lava-test-runner /lava-10151146/1

    2023-04-28T12:19:25.358103  =


    2023-04-28T12:19:25.362424  / # /lava-10151146/bin/lava-test-runner /la=
va-10151146/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bbb65b765a78c922e866f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-360-gae1121374086/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bbb65b765a78c922e8674
        failing since 31 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T12:26:06.316421  <8>[   11.178288] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10151147_1.4.2.3.1>

    2023-04-28T12:26:06.424210  / # #

    2023-04-28T12:26:06.526522  export SHELL=3D/bin/sh

    2023-04-28T12:26:06.527311  #

    2023-04-28T12:26:06.628969  / # export SHELL=3D/bin/sh. /lava-10151147/=
environment

    2023-04-28T12:26:06.629799  =


    2023-04-28T12:26:06.731210  / # . /lava-10151147/environment/lava-10151=
147/bin/lava-test-runner /lava-10151147/1

    2023-04-28T12:26:06.732433  =


    2023-04-28T12:26:06.737376  / # /lava-10151147/bin/lava-test-runner /la=
va-10151147/1

    2023-04-28T12:26:06.742312  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20
