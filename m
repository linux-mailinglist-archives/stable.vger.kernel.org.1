Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA4E73A226
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjFVNrA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjFVNqe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:46:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764FE1997
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:46:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-553ad54d3c6so2556282a12.1
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687441590; x=1690033590;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VDCzVOI5JoxSGO+42QEpvTusoyFGc6IJljtM1tvrQuE=;
        b=UBSqlemDm3yFh8nA6jjalIaetYsTv0xKRARe5QgCN2AQLhgwF41mJyj9lel3ws5cTD
         m1vf4z3rsooxrgAh1Dt4VGkAGIxetWki04xL8dbvISlVNQjPcBgqmBKoT9z/Xmj7CGFx
         /84rXIzE5PN+sHcKCHoUOgWdQuzjm8pEympPPQJNAWCiSpjJrTEhlQWOqxNOYDTjqZ9j
         /p9ToPhJ4q/SXp6ShK7fChWOvDhqU7nqbLST+2f3D0/KiogSuruWrhU8WXvzMwR2ALTc
         c0RTrDSFDrVB5IuvvdrdZaa/ei/z9SPV7YLrnrlIEUg5SSB39O1YjkFETbo+FrW75yrc
         QkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441590; x=1690033590;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDCzVOI5JoxSGO+42QEpvTusoyFGc6IJljtM1tvrQuE=;
        b=iO4wnCdqtUTkVnuT7IROmQbZmK7rf+DhCQoPgAgRr1J9kPchAOPe7nKn9QLQ/pH+6t
         6OjXazaLRqrfGVONQTVmxbU+T/ejA+NXt4lGa8WKs9oF1pIuB76eLsGIGZbEJF0FLTxB
         rRysjKIm5YhXsaF0i1Ft3n7cZO++zXzLtCsZVlB21/p1CjK0CS9pFHrVYxWqKrephKO3
         +s+BdTHD+xYdAARZVZmR6UiSGNVrHoNhxrozH3aXHRlcOgCnyecriT5fi9AQGIsKFHGr
         +jBebzbKNeX9biAbWUH5nuDs8Ds3ZSRJkQ5M1e9tr6RYOImXnBKFHmE1UGFQEoNypqby
         93AQ==
X-Gm-Message-State: AC+VfDx8X2gdm0xio7af9dGD/uZYnKM0sjoTvw9nKqbgvWEkOLYC0/V3
        OgakADrGphpnFOcD+vPvlP3wha0wLgAzVUjP8pFzWw==
X-Google-Smtp-Source: ACHHUZ4EierKzbMscwV8MWuirhBC0Jj1waaRqOB1iVRw/KhCssJkReOIL2rQtKroXQfUdFSL5h8ZmA==
X-Received: by 2002:a05:6a20:258d:b0:10c:7c72:bdf9 with SMTP id k13-20020a056a20258d00b0010c7c72bdf9mr15253939pzd.29.1687441590178;
        Thu, 22 Jun 2023 06:46:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902820c00b001b6a241b67esm2574186pln.296.2023.06.22.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:46:29 -0700 (PDT)
Message-ID: <649450b5.170a0220.c33e9.60cd@mx.google.com>
Date:   Thu, 22 Jun 2023 06:46:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.35-37-g639ecee7e0d3
Subject: stable-rc/linux-6.1.y baseline: 159 runs,
 12 regressions (v6.1.35-37-g639ecee7e0d3)
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

stable-rc/linux-6.1.y baseline: 159 runs, 12 regressions (v6.1.35-37-g639ec=
ee7e0d3)

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

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.35-37-g639ecee7e0d3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.35-37-g639ecee7e0d3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      639ecee7e0d33f1aaef3207acc700222a1b8d5f1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6494183069ef65fd4a30613b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494183069ef65fd4a306144
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-22T09:45:04.389790  + set +x

    2023-06-22T09:45:04.396559  <8>[    8.027223] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858288_1.4.2.3.1>

    2023-06-22T09:45:04.503074  #

    2023-06-22T09:45:04.605721  / # #export SHELL=3D/bin/sh

    2023-06-22T09:45:04.606465  =


    2023-06-22T09:45:04.707966  / # export SHELL=3D/bin/sh. /lava-10858288/=
environment

    2023-06-22T09:45:04.708691  =


    2023-06-22T09:45:04.810385  / # . /lava-10858288/environment/lava-10858=
288/bin/lava-test-runner /lava-10858288/1

    2023-06-22T09:45:04.811546  =


    2023-06-22T09:45:04.818210  / # /lava-10858288/bin/lava-test-runner /la=
va-10858288/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649417da2e393bd23c30613a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649417da2e393bd23c306143
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-22T09:43:38.720676  + set<8>[    8.952525] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10858289_1.4.2.3.1>

    2023-06-22T09:43:38.721257   +x

    2023-06-22T09:43:38.829243  / # #

    2023-06-22T09:43:38.931890  export SHELL=3D/bin/sh

    2023-06-22T09:43:38.932750  #

    2023-06-22T09:43:39.034320  / # export SHELL=3D/bin/sh. /lava-10858289/=
environment

    2023-06-22T09:43:39.035165  =


    2023-06-22T09:43:39.137134  / # . /lava-10858289/environment/lava-10858=
289/bin/lava-test-runner /lava-10858289/1

    2023-06-22T09:43:39.138504  =


    2023-06-22T09:43:39.143011  / # /lava-10858289/bin/lava-test-runner /la=
va-10858289/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649417bb7ed0013870306134

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649417bb7ed001387030613d
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-22T09:43:03.123912  <8>[   10.128482] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858260_1.4.2.3.1>

    2023-06-22T09:43:03.126901  + set +x

    2023-06-22T09:43:03.228297  =


    2023-06-22T09:43:03.328988  / # #export SHELL=3D/bin/sh

    2023-06-22T09:43:03.329152  =


    2023-06-22T09:43:03.429727  / # export SHELL=3D/bin/sh. /lava-10858260/=
environment

    2023-06-22T09:43:03.429894  =


    2023-06-22T09:43:03.530419  / # . /lava-10858260/environment/lava-10858=
260/bin/lava-test-runner /lava-10858260/1

    2023-06-22T09:43:03.530729  =


    2023-06-22T09:43:03.535821  / # /lava-10858260/bin/lava-test-runner /la=
va-10858260/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649417bec7585ab4ca306162

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649417bec7585ab4ca30616b
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-22T09:43:08.480911  + set +x

    2023-06-22T09:43:08.487423  <8>[   11.107916] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858305_1.4.2.3.1>

    2023-06-22T09:43:08.591633  / # #

    2023-06-22T09:43:08.692174  export SHELL=3D/bin/sh

    2023-06-22T09:43:08.692386  #

    2023-06-22T09:43:08.792849  / # export SHELL=3D/bin/sh. /lava-10858305/=
environment

    2023-06-22T09:43:08.793099  =


    2023-06-22T09:43:08.893583  / # . /lava-10858305/environment/lava-10858=
305/bin/lava-test-runner /lava-10858305/1

    2023-06-22T09:43:08.893851  =


    2023-06-22T09:43:08.898148  / # /lava-10858305/bin/lava-test-runner /la=
va-10858305/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649417a425fb3b3cb8306170

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649417a425fb3b3cb8306179
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-22T09:42:46.724855  + set<8>[   10.270280] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10858240_1.4.2.3.1>

    2023-06-22T09:42:46.725346   +x

    2023-06-22T09:42:46.832525  /#

    2023-06-22T09:42:46.935081   # #export SHELL=3D/bin/sh

    2023-06-22T09:42:46.935807  =


    2023-06-22T09:42:47.037232  / # export SHELL=3D/bin/sh. /lava-10858240/=
environment

    2023-06-22T09:42:47.037421  =


    2023-06-22T09:42:47.137884  / # . /lava-10858240/environment/lava-10858=
240/bin/lava-test-runner /lava-10858240/1

    2023-06-22T09:42:47.138137  =


    2023-06-22T09:42:47.143629  / # /lava-10858240/bin/lava-test-runner /la=
va-10858240/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649417b8c7585ab4ca30612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649417b8c7585ab4ca306137
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-22T09:43:01.514136  + <8>[    8.757173] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10858269_1.4.2.3.1>

    2023-06-22T09:43:01.514254  set +x

    2023-06-22T09:43:01.618864  / # #

    2023-06-22T09:43:01.719624  export SHELL=3D/bin/sh

    2023-06-22T09:43:01.719921  #

    2023-06-22T09:43:01.820511  / # export SHELL=3D/bin/sh. /lava-10858269/=
environment

    2023-06-22T09:43:01.820808  =


    2023-06-22T09:43:01.921408  / # . /lava-10858269/environment/lava-10858=
269/bin/lava-test-runner /lava-10858269/1

    2023-06-22T09:43:01.921770  =


    2023-06-22T09:43:01.926523  / # /lava-10858269/bin/lava-test-runner /la=
va-10858269/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/6494199be86debe4da30612e

  Results:     29 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-imx6dl-=
udoo.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-imx6dl-=
udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6494199be=
86debe4da30613b
        new failure (last pass: v6.1.35)

    2023-06-22T09:51:09.074861  /lava-651304/1/../bin/lava-test-case
    2023-06-22T09:51:09.103010  <8>[   25.937919] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sound-card-probed: https://kernelci.org/test/case/id/64=
94199be86debe4da30613c
        new failure (last pass: v6.1.35)

    2023-06-22T09:51:08.023987  /lava-651304/1/../bin/lava-test-case
    2023-06-22T09:51:08.052159  <8>[   24.887509] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649417cf94c225ec8630613a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649417cf94c225ec86306143
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-22T09:43:20.170410  + set<8>[   11.763481] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10858298_1.4.2.3.1>

    2023-06-22T09:43:20.170849   +x

    2023-06-22T09:43:20.278023  / # #

    2023-06-22T09:43:20.380113  export SHELL=3D/bin/sh

    2023-06-22T09:43:20.380798  #

    2023-06-22T09:43:20.482134  / # export SHELL=3D/bin/sh. /lava-10858298/=
environment

    2023-06-22T09:43:20.482806  =


    2023-06-22T09:43:20.584276  / # . /lava-10858298/environment/lava-10858=
298/bin/lava-test-runner /lava-10858298/1

    2023-06-22T09:43:20.585350  =


    2023-06-22T09:43:20.590469  / # /lava-10858298/bin/lava-test-runner /la=
va-10858298/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64941fdb3c35380e9e30619c

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64941fdb3c35380e9e3061bc
        failing since 41 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-22T10:17:51.567808  /lava-10858541/1/../bin/lava-test-case

    2023-06-22T10:17:51.574343  <8>[   22.858986] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64941fdb3c35380e9e306248
        failing since 41 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-22T10:17:46.154948  + set +x

    2023-06-22T10:17:46.161434  <8>[   17.444217] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858541_1.5.2.3.1>

    2023-06-22T10:17:46.266766  / # #

    2023-06-22T10:17:46.367382  export SHELL=3D/bin/sh

    2023-06-22T10:17:46.367583  #

    2023-06-22T10:17:46.468083  / # export SHELL=3D/bin/sh. /lava-10858541/=
environment

    2023-06-22T10:17:46.468271  =


    2023-06-22T10:17:46.568804  / # . /lava-10858541/environment/lava-10858=
541/bin/lava-test-runner /lava-10858541/1

    2023-06-22T10:17:46.569086  =


    2023-06-22T10:17:46.573946  / # /lava-10858541/bin/lava-test-runner /la=
va-10858541/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649419cc6c84fd28ad30613e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroi=
d-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35-=
37-g639ecee7e0d3/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroi=
d-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649419cc6c84fd28ad306=
13f
        new failure (last pass: v6.1.35) =

 =20
