Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3810E7D28F8
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 05:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjJWDSD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 23:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjJWDR7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 23:17:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E110C0
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 20:17:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5b5354da665so1283902a12.2
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 20:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698031074; x=1698635874; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XtZ38KrPvH1aipborMB+5uRnOAxrEqPHFIvXaemVYFE=;
        b=mbIt8KDlVrMD83eAFEugwbwwes0QKW+Y6t+/lkC91r8gcYgK2AMuEyvMJof9DEFhVs
         1xM77baP8zCbz3ZPtsglGqZ6vQDMaqjvetbbTnkQ4D7urdb53eJ7ful/oeihomi4NehP
         jC+7xULuXZ6LtuCVUQbD+Ypp8x0sPVn7wuWEacw4+7sQ93DDbK4ZMzoNy/yBxHFR1olk
         Z6wdn19uBQgRFoWgdwtFxaE6uSGQVhFgtQB8/MeAI5Og5QmNCH4hWmY+Nz0jr8YK2y6m
         hYchQARS8lzht3Pjb1Qar5wdsn9XwBiwMmpJwPNaOGUJbwdYdZF0tuYzUE7EdtWjHwLg
         BmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698031074; x=1698635874;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtZ38KrPvH1aipborMB+5uRnOAxrEqPHFIvXaemVYFE=;
        b=W4UNkXSUCd5G1IxN2qyalSrrFHU/L27rSYQER/qVcczNrgOlQ7xwu6XIcGrfZtRcCH
         5mNzEZqj0DRGDYY0xxlff6cv0rACpV5AuISjXz3PY9+ovj66xdlQeH03uSFVJTWpk/ov
         Z+F+y/qGuIV7gzmzDRcwUPvPylW4MwWOc1dJFkGtLsVthDoCngP4eCoqzJv3UdczKI8y
         R3KwCauiCxTnJWtu2EITfbhQNZLfV63aHHp+Wv/V0KJ62K8VXp5V+HOFlMWAQ/j5EKqs
         2WL1wMvBE22Id7HAtlMIIWLLGWj/VjNvY2+G12TqqXKtUeyoJFTpCIhbmGhqBj/u2hZR
         9TBg==
X-Gm-Message-State: AOJu0YyoESx/3f4ylCfbRanTeCbnMjqxYPBxgih3z2VzefGwsLWpdGw1
        F/27XfV/za1q9U3Y7dsmdxQD21e2oI9nnHIdwC3xAw==
X-Google-Smtp-Source: AGHT+IHDmZkz03oONHlM1j3xoBI05wbK2CpRC9MmUOWEQt7Q5XebGeSn6UBA6t/bXGZMH9L3FfNvgQ==
X-Received: by 2002:a05:6a20:a121:b0:147:fd40:2482 with SMTP id q33-20020a056a20a12100b00147fd402482mr6144015pzk.44.1698031074538;
        Sun, 22 Oct 2023 20:17:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iy17-20020a170903131100b001ca86a9caccsm5061101plb.228.2023.10.22.20.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 20:17:53 -0700 (PDT)
Message-ID: <6535e5e1.170a0220.94ddf.f393@mx.google.com>
Date:   Sun, 22 Oct 2023 20:17:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-336-g8056f2017920
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 161 runs,
 10 regressions (v6.1.58-336-g8056f2017920)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 161 runs, 10 regressions (v6.1.58-336-g8056=
f2017920)

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

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.58-336-g8056f2017920/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.58-336-g8056f2017920
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8056f201792097a9f1a4ad286326f00d7c2bd500 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535b2b04fae1b4388efcf0f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535b2b04fae1b4388efcf18
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-22T23:39:02.730675  + set +x

    2023-10-22T23:39:02.736894  <8>[   10.000958] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11848539_1.4.2.3.1>

    2023-10-22T23:39:02.841555  / # #

    2023-10-22T23:39:02.942141  export SHELL=3D/bin/sh

    2023-10-22T23:39:02.942355  #

    2023-10-22T23:39:03.042849  / # export SHELL=3D/bin/sh. /lava-11848539/=
environment

    2023-10-22T23:39:03.043083  =


    2023-10-22T23:39:03.143609  / # . /lava-11848539/environment/lava-11848=
539/bin/lava-test-runner /lava-11848539/1

    2023-10-22T23:39:03.143951  =


    2023-10-22T23:39:03.149252  / # /lava-11848539/bin/lava-test-runner /la=
va-11848539/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535b2a1a1757e321defcf53

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535b2a1a1757e321defcf5c
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-22T23:38:52.304292  + <8>[   11.767653] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11848555_1.4.2.3.1>

    2023-10-22T23:38:52.304381  set +x

    2023-10-22T23:38:52.408496  / # #

    2023-10-22T23:38:52.509035  export SHELL=3D/bin/sh

    2023-10-22T23:38:52.509227  #

    2023-10-22T23:38:52.609745  / # export SHELL=3D/bin/sh. /lava-11848555/=
environment

    2023-10-22T23:38:52.609946  =


    2023-10-22T23:38:52.710611  / # . /lava-11848555/environment/lava-11848=
555/bin/lava-test-runner /lava-11848555/1

    2023-10-22T23:38:52.710909  =


    2023-10-22T23:38:52.715907  / # /lava-11848555/bin/lava-test-runner /la=
va-11848555/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535b27d47f8f00969efcf14

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535b27d47f8f00969efcf1d
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-22T23:38:26.650034  <8>[   11.286761] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11848505_1.4.2.3.1>

    2023-10-22T23:38:26.653480  + set +x

    2023-10-22T23:38:26.755960  =


    2023-10-22T23:38:26.856592  / # #export SHELL=3D/bin/sh

    2023-10-22T23:38:26.856793  =


    2023-10-22T23:38:26.957469  / # export SHELL=3D/bin/sh. /lava-11848505/=
environment

    2023-10-22T23:38:26.957792  =


    2023-10-22T23:38:27.058546  / # . /lava-11848505/environment/lava-11848=
505/bin/lava-test-runner /lava-11848505/1

    2023-10-22T23:38:27.059305  =


    2023-10-22T23:38:27.064463  / # /lava-11848505/bin/lava-test-runner /la=
va-11848505/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6535b4f1e55ec1fb6aefd009

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6535b4f1e55ec1fb6aefd=
00a
        failing since 137 days (last pass: v6.1.31-40-g7d0a9678d276, first =
fail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535b27c0dbfaf1e7befcf68

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535b27c0dbfaf1e7befcf71
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-22T23:38:47.783183  + set +x

    2023-10-22T23:38:47.789558  <8>[    7.915645] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11848496_1.4.2.3.1>

    2023-10-22T23:38:47.894141  / # #

    2023-10-22T23:38:47.994788  export SHELL=3D/bin/sh

    2023-10-22T23:38:47.994988  #

    2023-10-22T23:38:48.095520  / # export SHELL=3D/bin/sh. /lava-11848496/=
environment

    2023-10-22T23:38:48.095728  =


    2023-10-22T23:38:48.196271  / # . /lava-11848496/environment/lava-11848=
496/bin/lava-test-runner /lava-11848496/1

    2023-10-22T23:38:48.196634  =


    2023-10-22T23:38:48.201218  / # /lava-11848496/bin/lava-test-runner /la=
va-11848496/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535b2990ce5cac52befcf4e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535b29a0ce5cac52befcf57
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-22T23:38:47.070543  + set<8>[   11.427891] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11848520_1.4.2.3.1>

    2023-10-22T23:38:47.070633   +x

    2023-10-22T23:38:47.175050  / # #

    2023-10-22T23:38:47.275689  export SHELL=3D/bin/sh

    2023-10-22T23:38:47.275921  #

    2023-10-22T23:38:47.376426  / # export SHELL=3D/bin/sh. /lava-11848520/=
environment

    2023-10-22T23:38:47.376685  =


    2023-10-22T23:38:47.477328  / # . /lava-11848520/environment/lava-11848=
520/bin/lava-test-runner /lava-11848520/1

    2023-10-22T23:38:47.477600  =


    2023-10-22T23:38:47.481957  / # /lava-11848520/bin/lava-test-runner /la=
va-11848520/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535b2921cf73ee2d3efcf22

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535b2921cf73ee2d3efcf2b
        failing since 206 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-22T23:39:00.855985  + set<8>[   11.414992] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11848577_1.4.2.3.1>

    2023-10-22T23:39:00.856081   +x

    2023-10-22T23:39:00.960894  / # #

    2023-10-22T23:39:01.061531  export SHELL=3D/bin/sh

    2023-10-22T23:39:01.061738  #

    2023-10-22T23:39:01.162238  / # export SHELL=3D/bin/sh. /lava-11848577/=
environment

    2023-10-22T23:39:01.162475  =


    2023-10-22T23:39:01.263047  / # . /lava-11848577/environment/lava-11848=
577/bin/lava-test-runner /lava-11848577/1

    2023-10-22T23:39:01.263352  =


    2023-10-22T23:39:01.268217  / # /lava-11848577/bin/lava-test-runner /la=
va-11848577/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6535b5243116ef65beefcf76

  Results:     167 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.panel-edp-probed: https://kernelci.org/test/case/id/653=
5b5243116ef65beefcfc9
        new failure (last pass: v6.1.58-132-g9b707223d2e98)

    2023-10-22T23:50:08.098765  /lava-11848692/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6535b4d49c2e443b03efcf00

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535b4d49c2e443b03efcf09
        failing since 97 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-10-22T23:48:09.521392  / # #
    2023-10-22T23:48:09.623331  export SHELL=3D/bin/sh
    2023-10-22T23:48:09.624184  #
    2023-10-22T23:48:09.725338  / # export SHELL=3D/bin/sh. /lava-439851/en=
vironment
    2023-10-22T23:48:09.725948  =

    2023-10-22T23:48:09.827115  / # . /lava-439851/environment/lava-439851/=
bin/lava-test-runner /lava-439851/1
    2023-10-22T23:48:09.828136  =

    2023-10-22T23:48:09.831048  / # /lava-439851/bin/lava-test-runner /lava=
-439851/1
    2023-10-22T23:48:09.911358  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-22T23:48:09.911710  + cd /lava-439851/<8>[   18.587288] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 439851_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6535b4d4149458b189efcf36

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
336-g8056f2017920/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535b4d4149458b189efcf3f
        failing since 97 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-10-22T23:52:33.463988  / # #

    2023-10-22T23:52:33.565976  export SHELL=3D/bin/sh

    2023-10-22T23:52:33.566677  #

    2023-10-22T23:52:33.668047  / # export SHELL=3D/bin/sh. /lava-11848625/=
environment

    2023-10-22T23:52:33.668743  =


    2023-10-22T23:52:33.770124  / # . /lava-11848625/environment/lava-11848=
625/bin/lava-test-runner /lava-11848625/1

    2023-10-22T23:52:33.771016  =


    2023-10-22T23:52:33.772863  / # /lava-11848625/bin/lava-test-runner /la=
va-11848625/1

    2023-10-22T23:52:33.854318  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-22T23:52:33.854802  + cd /lava-1184862<8>[   18.732808] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11848625_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
