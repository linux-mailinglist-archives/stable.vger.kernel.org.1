Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D851C70012D
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 09:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbjELHPx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 03:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbjELHPZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 03:15:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA25A1208B
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:13:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-643ac91c51fso5972981b3a.1
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683875587; x=1686467587;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pllStuL69CmdbmyzSwWcstek2uIn4qTw/AI0S5LyrjE=;
        b=TR0cuuI2po4mItr+rJ5AzFUwanG2pg78HX2nUXziAvgeZiC45qbjD5zvNUC4M9d2qN
         z3Cg+UA7g+YQvsnjEwioQtfE8wuzdhO+TZsTw5EsT1ZFGKVNZSb0cydaACKJdAilPFVw
         QiaQiQh5GEs0vWPuZKaZqy850fQB1Tdqef4lIgD6ip8qEKA5HCMdXtSx7FSaQ9AEPyG8
         YZMTJ4t0BQWHsiFuCz4n300ZFJ67XJNtQ4O6/9NLvdsRhWTBaouyBKuVobrBGPBimIho
         l1D/5kwHg2C67QC7X69buC0UldFBXc6lounHGmUwVbyZVAipyVWiWd3Jnc5APqS37gxF
         u27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875587; x=1686467587;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pllStuL69CmdbmyzSwWcstek2uIn4qTw/AI0S5LyrjE=;
        b=I3jfa/1WlDmYC2+l8te6TlgPhiNRMQ/8lq1GycQOnoKuDb1OqMUz9xUBTlBCRZYlT+
         bfWhc2PtnFXOb8JUdItkCnbrjtJ6LVhBhgt8XNt0VpRdZ02JnUr4ks8p7RScMhcZzSYF
         Am7nIAqKSxKIeTG6zGjLjzmwHS8WInRSnCEMENzVXHIaQdd+llLTud1oFwpkaqfHbsGG
         cdypyGsStE7fY0vJwu7U0+1qWQP6bz9o4fmCAsXPJ+Yx50oYj7WI99Di2k+6RpO9ARp/
         Ka9ZtlKT5DkxQtxyND6mLMYY8B39Y6AVLSur2/TBRQU6KeiplzWBYo4ocZYJSW0sMd3r
         KiKA==
X-Gm-Message-State: AC+VfDyr3MtArQgETjbcCc1E2dybmm4H2VyO39p5Auis2WLvVoBr70Pq
        QuM61br1jtDaSOZKcBk+onez+EDwoGRMnaUZonumIw==
X-Google-Smtp-Source: ACHHUZ5060LJpQ1WOridROsfnnob9c18WxgyQC0kidpL6oLMN27Ky3U4kxPGyxnJYG3kw90igXZ2NQ==
X-Received: by 2002:a05:6a00:2d97:b0:636:f899:4696 with SMTP id fb23-20020a056a002d9700b00636f8994696mr31935416pfb.24.1683875586458;
        Fri, 12 May 2023 00:13:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x6-20020aa793a6000000b00640f588b36dsm6426122pff.8.2023.05.12.00.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:13:05 -0700 (PDT)
Message-ID: <645de701.a70a0220.2af39.dcc4@mx.google.com>
Date:   Fri, 12 May 2023 00:13:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-18-gda7b520f32030
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 185 runs,
 11 regressions (v5.15.111-18-gda7b520f32030)
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

stable-rc/queue/5.15 baseline: 185 runs, 11 regressions (v5.15.111-18-gda7b=
520f32030)

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

meson-gxbb-p200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-18-gda7b520f32030/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-18-gda7b520f32030
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      da7b520f32030bc21bdac76f608b8c199510d6c3 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db4d074968fdce02e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db4d074968fdce02e85f0
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T03:38:40.862505  + <8>[   11.473557] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10290087_1.4.2.3.1>

    2023-05-12T03:38:40.862621  set +x

    2023-05-12T03:38:40.966934  / # #

    2023-05-12T03:38:41.067487  export SHELL=3D/bin/sh

    2023-05-12T03:38:41.067683  #

    2023-05-12T03:38:41.168227  / # export SHELL=3D/bin/sh. /lava-10290087/=
environment

    2023-05-12T03:38:41.168431  =


    2023-05-12T03:38:41.268924  / # . /lava-10290087/environment/lava-10290=
087/bin/lava-test-runner /lava-10290087/1

    2023-05-12T03:38:41.269162  =


    2023-05-12T03:38:41.273952  / # /lava-10290087/bin/lava-test-runner /la=
va-10290087/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db4eea97296b0612e8629

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db4eea97296b0612e862e
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T03:39:05.666524  <8>[   10.228355] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10290105_1.4.2.3.1>

    2023-05-12T03:39:05.670175  + set +x

    2023-05-12T03:39:05.771805  =


    2023-05-12T03:39:05.872422  / # #export SHELL=3D/bin/sh

    2023-05-12T03:39:05.872642  =


    2023-05-12T03:39:05.973264  / # export SHELL=3D/bin/sh. /lava-10290105/=
environment

    2023-05-12T03:39:05.974032  =


    2023-05-12T03:39:06.075355  / # . /lava-10290105/environment/lava-10290=
105/bin/lava-test-runner /lava-10290105/1

    2023-05-12T03:39:06.075723  =


    2023-05-12T03:39:06.080625  / # /lava-10290105/bin/lava-test-runner /la=
va-10290105/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645db55da510c5c0d42e863f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645db55da510c5c0d42e8=
640
        failing since 97 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645db615678c9753492e85f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db615678c9753492e85f8
        failing since 114 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-12T03:43:51.243321  + set +x<8>[    9.897814] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3578393_1.5.2.4.1>
    2023-05-12T03:43:51.243504  =

    2023-05-12T03:43:51.349401  / # #
    2023-05-12T03:43:51.450819  export SHELL=3D/bin/sh
    2023-05-12T03:43:51.451150  #
    2023-05-12T03:43:51.552241  / # export SHELL=3D/bin/sh. /lava-3578393/e=
nvironment
    2023-05-12T03:43:51.552599  =

    2023-05-12T03:43:51.653519  / # . /lava-3578393/environment/lava-357839=
3/bin/lava-test-runner /lava-3578393/1
    2023-05-12T03:43:51.654278  =

    2023-05-12T03:43:51.659227  / # /lava-3578393/bin/lava-test-runner /lav=
a-3578393/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db6b70e1514c5082e8634

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db6b70e1514c5082e8639
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T03:46:46.400500  + set +x

    2023-05-12T03:46:46.407063  <8>[   10.008965] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10290094_1.4.2.3.1>

    2023-05-12T03:46:46.511362  / # #

    2023-05-12T03:46:46.612019  export SHELL=3D/bin/sh

    2023-05-12T03:46:46.612188  #

    2023-05-12T03:46:46.712705  / # export SHELL=3D/bin/sh. /lava-10290094/=
environment

    2023-05-12T03:46:46.712869  =


    2023-05-12T03:46:46.813406  / # . /lava-10290094/environment/lava-10290=
094/bin/lava-test-runner /lava-10290094/1

    2023-05-12T03:46:46.813662  =


    2023-05-12T03:46:46.818370  / # /lava-10290094/bin/lava-test-runner /la=
va-10290094/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db600780f4b4a9c2e85ec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db600780f4b4a9c2e85f1
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T03:43:38.663210  <8>[   10.534535] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10290102_1.4.2.3.1>

    2023-05-12T03:43:38.666694  + set +x

    2023-05-12T03:43:38.767978  =


    2023-05-12T03:43:38.868805  / # #export SHELL=3D/bin/sh

    2023-05-12T03:43:38.868998  =


    2023-05-12T03:43:38.969585  / # export SHELL=3D/bin/sh. /lava-10290102/=
environment

    2023-05-12T03:43:38.969740  =


    2023-05-12T03:43:39.070281  / # . /lava-10290102/environment/lava-10290=
102/bin/lava-test-runner /lava-10290102/1

    2023-05-12T03:43:39.070559  =


    2023-05-12T03:43:39.075074  / # /lava-10290102/bin/lava-test-runner /la=
va-10290102/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db4e7bffc6c8e942e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db4e7bffc6c8e942e8611
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T03:38:56.076140  + <8>[   10.704960] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10290122_1.4.2.3.1>

    2023-05-12T03:38:56.076302  set +x

    2023-05-12T03:38:56.180335  / # #

    2023-05-12T03:38:56.280898  export SHELL=3D/bin/sh

    2023-05-12T03:38:56.281126  #

    2023-05-12T03:38:56.381663  / # export SHELL=3D/bin/sh. /lava-10290122/=
environment

    2023-05-12T03:38:56.381926  =


    2023-05-12T03:38:56.482544  / # . /lava-10290122/environment/lava-10290=
122/bin/lava-test-runner /lava-10290122/1

    2023-05-12T03:38:56.482943  =


    2023-05-12T03:38:56.487017  / # /lava-10290122/bin/lava-test-runner /la=
va-10290122/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645db4d474968fdce02e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db4d474968fdce02e85fc
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T03:38:34.225701  + set +x<8>[    9.804672] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10290159_1.4.2.3.1>

    2023-05-12T03:38:34.225819  =


    2023-05-12T03:38:34.329773  / # #

    2023-05-12T03:38:34.430467  export SHELL=3D/bin/sh

    2023-05-12T03:38:34.430673  #

    2023-05-12T03:38:34.531231  / # export SHELL=3D/bin/sh. /lava-10290159/=
environment

    2023-05-12T03:38:34.531431  =


    2023-05-12T03:38:34.631949  / # . /lava-10290159/environment/lava-10290=
159/bin/lava-test-runner /lava-10290159/1

    2023-05-12T03:38:34.632231  =


    2023-05-12T03:38:34.637011  / # /lava-10290159/bin/lava-test-runner /la=
va-10290159/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxbb-p200              | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645db4b69e5504104d2e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645db4b69e5504104d2e8=
5ed
        new failure (last pass: v5.15.111-10-g437e125656ffc) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645db429d437a427e32e8605

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db429d437a427e32e8632
        failing since 114 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-12T03:35:48.136157  + set +x
    2023-05-12T03:35:48.140305  <8>[   16.066339] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3578301_1.5.2.4.1>
    2023-05-12T03:35:48.260927  / # #
    2023-05-12T03:35:48.366593  export SHELL=3D/bin/sh
    2023-05-12T03:35:48.368158  #
    2023-05-12T03:35:48.471458  / # export SHELL=3D/bin/sh. /lava-3578301/e=
nvironment
    2023-05-12T03:35:48.472954  =

    2023-05-12T03:35:48.576422  / # . /lava-3578301/environment/lava-357830=
1/bin/lava-test-runner /lava-3578301/1
    2023-05-12T03:35:48.579104  =

    2023-05-12T03:35:48.582403  / # /lava-3578301/bin/lava-test-runner /lav=
a-3578301/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645db48dfe2be494d32e860a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-18-gda7b520f32030/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645db48dfe2be494d32e860f
        failing since 100 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.90-203-gea2e94bef77e)

    2023-05-12T03:37:35.931297  <8>[    5.708309] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3578278_1.5.2.4.1>
    2023-05-12T03:37:36.050666  / # #
    2023-05-12T03:37:36.156254  export SHELL=3D/bin/sh
    2023-05-12T03:37:36.157819  #
    2023-05-12T03:37:36.261106  / # export SHELL=3D/bin/sh. /lava-3578278/e=
nvironment
    2023-05-12T03:37:36.262711  =

    2023-05-12T03:37:36.366085  / # . /lava-3578278/environment/lava-357827=
8/bin/lava-test-runner /lava-3578278/1
    2023-05-12T03:37:36.368729  =

    2023-05-12T03:37:36.376137  / # /lava-3578278/bin/lava-test-runner /lav=
a-3578278/1
    2023-05-12T03:37:36.530932  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
