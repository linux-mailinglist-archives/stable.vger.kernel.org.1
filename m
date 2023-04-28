Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57E66F1BE2
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 17:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjD1PuM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjD1PuL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 11:50:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE8712B
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 08:50:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-246f856d751so94171a91.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682697008; x=1685289008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+XPFFzMw5eFac6XTs+L1uttII2uS6yBZArTnFx8Fvdc=;
        b=lOAG7xutibMssI+sXMyI7oz/57MOrkKG0BxarI7kgqPucu6F+/C0IlEvVsjtJHzUFy
         S2AZaep9v4L/ukApsOUB9onnN9TLeRutilfIRCvs0UutJ4D1EQuMs7+LAhIUNgtvP+vR
         ahMKp5j0n/9y9FpsANLWSms1wHtDNMmu1npNJYHvW/+cxZmlyvqZUTGcVDF3h1xB4ucC
         d/JWRvBAqy8E0N4ZBzaFMy7/gtQ2mqN9j3jAA8sx5dCJtKduvSMXYDtiyWWG/zpq7umv
         06gPiVOCxDCZ7fzH0oJI/qX40I/lLHBWm+1oY2BA67k3dh/Fatj6PN4h4dnzvJgMnM3o
         uvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682697008; x=1685289008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XPFFzMw5eFac6XTs+L1uttII2uS6yBZArTnFx8Fvdc=;
        b=alYA2yVXaKwWdCGXdkmiTbNzKq0HgVHeUz7cEMW2IVJatWG4r1hfteXeJskaelacF1
         PZLyzGXqTY3HZRCff3TX4wCBohlEkqOi4ui+KXPgSFPvWWLNS4jC3wuZdTk/fbnWkN5v
         TpqUU7aHGEbK3uhEWF25fu0gSn8AzHW5WFL1YeiRzOX51oXmWr8f6YS71szPVoq1zlUx
         CX4TpeCrCIFvdkuv6M5mYIyYrQJSzaCo39M2KMqaGBXtQ3nD+p66W8wTxy3vMH57pZHg
         ctNir0txzNIcyz9l/atUC6SRe1P7gbX85BEmajkqHN/sMlkHt+EIvSNzrJA8F904T5F9
         JO0g==
X-Gm-Message-State: AC+VfDySZNk1DuSPFlmJtN4ttXmbwPMQCQtudXXVVo0W6vQjTl30dfen
        fgQyL1vYFpQXxSRAlntS+gzqdtUuaVYDmUr8tfI=
X-Google-Smtp-Source: ACHHUZ4vximii9HtJhkNevE4UD0uldoakVlOQa8/+tPpmcdz8XvjNmCYirbRa6rxQSjjebNaBgGZRg==
X-Received: by 2002:a17:90a:ce96:b0:246:ac68:297 with SMTP id g22-20020a17090ace9600b00246ac680297mr6022422pju.0.1682697007665;
        Fri, 28 Apr 2023 08:50:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a410c00b0024677263e36sm1589934pjf.43.2023.04.28.08.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:50:07 -0700 (PDT)
Message-ID: <644beb2f.170a0220.dd22a.3559@mx.google.com>
Date:   Fri, 28 Apr 2023 08:50:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-588-gf4ffa542abc9
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 160 runs,
 10 regressions (v6.1.22-588-gf4ffa542abc9)
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

stable-rc/linux-6.1.y baseline: 160 runs, 10 regressions (v6.1.22-588-gf4ff=
a542abc9)

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

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-sm1-sei610             | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.22-588-gf4ffa542abc9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.22-588-gf4ffa542abc9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f4ffa542abc9c770233488e0ea1b6e2a6a7760a4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bb864f1a0dade472e8654

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bb864f1a0dade472e8659
        failing since 28 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T12:13:02.737381  <8>[   10.384361] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10150949_1.4.2.3.1>

    2023-04-28T12:13:02.740646  + set +x

    2023-04-28T12:13:02.844903  / # #

    2023-04-28T12:13:02.945541  export SHELL=3D/bin/sh

    2023-04-28T12:13:02.945772  #

    2023-04-28T12:13:03.046291  / # export SHELL=3D/bin/sh. /lava-10150949/=
environment

    2023-04-28T12:13:03.046509  =


    2023-04-28T12:13:03.147010  / # . /lava-10150949/environment/lava-10150=
949/bin/lava-test-runner /lava-10150949/1

    2023-04-28T12:13:03.147314  =


    2023-04-28T12:13:03.152706  / # /lava-10150949/bin/lava-test-runner /la=
va-10150949/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bb84ae4ccc9e5042e8624

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bb84ae4ccc9e5042e8629
        failing since 28 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T12:12:40.447745  + set<8>[   11.078935] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10150901_1.4.2.3.1>

    2023-04-28T12:12:40.448188   +x

    2023-04-28T12:12:40.557179  / # #

    2023-04-28T12:12:40.659596  export SHELL=3D/bin/sh

    2023-04-28T12:12:40.660284  #

    2023-04-28T12:12:40.761672  / # export SHELL=3D/bin/sh. /lava-10150901/=
environment

    2023-04-28T12:12:40.762465  =


    2023-04-28T12:12:40.863940  / # . /lava-10150901/environment/lava-10150=
901/bin/lava-test-runner /lava-10150901/1

    2023-04-28T12:12:40.865247  =


    2023-04-28T12:12:40.869776  / # /lava-10150901/bin/lava-test-runner /la=
va-10150901/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bb87497a088390b2e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bb87497a088390b2e8605
        failing since 28 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T12:13:13.411928  <8>[   10.567397] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10150950_1.4.2.3.1>

    2023-04-28T12:13:13.414895  + set +x

    2023-04-28T12:13:13.515990  #

    2023-04-28T12:13:13.516240  =


    2023-04-28T12:13:13.616800  / # #export SHELL=3D/bin/sh

    2023-04-28T12:13:13.616972  =


    2023-04-28T12:13:13.717493  / # export SHELL=3D/bin/sh. /lava-10150950/=
environment

    2023-04-28T12:13:13.717671  =


    2023-04-28T12:13:13.818174  / # . /lava-10150950/environment/lava-10150=
950/bin/lava-test-runner /lava-10150950/1

    2023-04-28T12:13:13.818427  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bb965288f9949b62e86a5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bb965288f9949b62e8=
6a6
        new failure (last pass: v6.1.22-574-ge4ff6ff54dea) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bb83ee4ccc9e5042e85ff

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bb83ee4ccc9e5042e8604
        failing since 28 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T12:12:36.635709  + set +x

    2023-04-28T12:12:36.642371  <8>[   10.741975] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10150897_1.4.2.3.1>

    2023-04-28T12:12:36.746292  / # #

    2023-04-28T12:12:36.846873  export SHELL=3D/bin/sh

    2023-04-28T12:12:36.847117  #

    2023-04-28T12:12:36.947654  / # export SHELL=3D/bin/sh. /lava-10150897/=
environment

    2023-04-28T12:12:36.947893  =


    2023-04-28T12:12:37.048472  / # . /lava-10150897/environment/lava-10150=
897/bin/lava-test-runner /lava-10150897/1

    2023-04-28T12:12:37.048892  =


    2023-04-28T12:12:37.053270  / # /lava-10150897/bin/lava-test-runner /la=
va-10150897/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bb8368a276d783c2e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bb8368a276d783c2e85f9
        failing since 28 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T12:12:23.116438  <8>[   10.626352] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10150886_1.4.2.3.1>

    2023-04-28T12:12:23.119736  + set +x

    2023-04-28T12:12:23.221521  =


    2023-04-28T12:12:23.322151  / # #export SHELL=3D/bin/sh

    2023-04-28T12:12:23.322390  =


    2023-04-28T12:12:23.423006  / # export SHELL=3D/bin/sh. /lava-10150886/=
environment

    2023-04-28T12:12:23.423265  =


    2023-04-28T12:12:23.523881  / # . /lava-10150886/environment/lava-10150=
886/bin/lava-test-runner /lava-10150886/1

    2023-04-28T12:12:23.524205  =


    2023-04-28T12:12:23.529024  / # /lava-10150886/bin/lava-test-runner /la=
va-10150886/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bb853694263964e2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bb853694263964e2e85eb
        failing since 28 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T12:12:57.812937  + set<8>[   11.130016] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10150924_1.4.2.3.1>

    2023-04-28T12:12:57.813035   +x

    2023-04-28T12:12:57.917694  / # #

    2023-04-28T12:12:58.018377  export SHELL=3D/bin/sh

    2023-04-28T12:12:58.018617  #

    2023-04-28T12:12:58.119248  / # export SHELL=3D/bin/sh. /lava-10150924/=
environment

    2023-04-28T12:12:58.119465  =


    2023-04-28T12:12:58.219970  / # . /lava-10150924/environment/lava-10150=
924/bin/lava-test-runner /lava-10150924/1

    2023-04-28T12:12:58.220325  =


    2023-04-28T12:12:58.224678  / # /lava-10150924/bin/lava-test-runner /la=
va-10150924/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bb851f1a0dade472e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bb851f1a0dade472e8605
        failing since 28 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-28T12:12:48.170821  <8>[   12.496814] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10150915_1.4.2.3.1>

    2023-04-28T12:12:48.275244  / # #

    2023-04-28T12:12:48.375894  export SHELL=3D/bin/sh

    2023-04-28T12:12:48.376107  #

    2023-04-28T12:12:48.476627  / # export SHELL=3D/bin/sh. /lava-10150915/=
environment

    2023-04-28T12:12:48.476877  =


    2023-04-28T12:12:48.577420  / # . /lava-10150915/environment/lava-10150=
915/bin/lava-test-runner /lava-10150915/1

    2023-04-28T12:12:48.577757  =


    2023-04-28T12:12:48.583002  / # /lava-10150915/bin/lava-test-runner /la=
va-10150915/1

    2023-04-28T12:12:48.589516  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-sm1-sei610             | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644baf4cf17f4741e02e8627

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-sm1-se=
i610.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-sm1-se=
i610.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644baf4cf17f4741e02e862c
        new failure (last pass: v6.1.22-574-ge4ff6ff54dea)

    2023-04-28T11:34:17.343066  / # #
    2023-04-28T11:34:17.446281  export SHELL=3D/bin/sh
    2023-04-28T11:34:17.447299  #
    2023-04-28T11:34:17.447951  / # export SHELL=3D/bin/sh<3>[   25.050262]=
 brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): clkctl 0x50
    2023-04-28T11:34:17.549940  . /lava-3540665/environment
    2023-04-28T11:34:17.550862  =

    2023-04-28T11:34:17.653041  / # . /lava-3540665/environment/lava-354066=
5/bin/lava-test-runner /lava-3540665/1
    2023-04-28T11:34:17.654515  =

    2023-04-28T11:34:17.664818  / # /lava-3540665/bin/lava-test-runner /lav=
a-3540665/1
    2023-04-28T11:34:17.730786  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/644baf697d913bc6c52e869e

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
588-gf4ffa542abc9/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/mipsel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/644baf697d913bc=
6c52e86a6
        new failure (last pass: v6.1.22-574-ge4ff6ff54dea)
        1 lines

    2023-04-28T11:34:57.513421  kern  :alert : CPU 0 Unable to handle kerne=
l paging request at virtual address 326781d8, epc =3D=3D 80202234, ra =3D=
=3D 80204b84
    2023-04-28T11:34:57.513554  =


    2023-04-28T11:34:57.538329  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-04-28T11:34:57.538451  =

   =

 =20
