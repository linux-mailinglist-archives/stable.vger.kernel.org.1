Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E8D7141D2
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 04:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjE2CBi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 22:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2CBh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 22:01:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3CB8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:01:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso3224390b3a.3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685325695; x=1687917695;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VE5WVIkeve9FCSSJVhzGiJIW+S4nsBLJHs6+nfgdHMA=;
        b=y+DUikaRYlYZidWrjdMYTFAsSKFzdLDk9LGs9GP7m/koquKCCnKGY9oZJzKj1Y0oa2
         8QoHqmZw3bW75kIe6LivygG3s7ew4cK4QJ4KvFbrbpvfX6QQMwt3r1oNaZMiiCKOECAd
         GYOG//oNI8hq+Cs/HSzqNOaMHgS4ciSxcQrD+zwm4kKa9IzRz2lQ6lcvNTlqB9NCaWn2
         6cCckXe2/TBYJq7D8FKapkf43HeT4b5XzTacPvcD+AeGBZZErb1nRwuL0bkbfdRxr2y6
         bBzkRfxpaFGv9OsvyLPPWX109iHnIbdhcd9JdsB7FvAlbTjjKUFexkm4334a7WBi27h2
         INYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685325695; x=1687917695;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VE5WVIkeve9FCSSJVhzGiJIW+S4nsBLJHs6+nfgdHMA=;
        b=BSAqZHa85tpjIb/Ns6rrUUrh8ALSNvyaMziFcYRDvlTF4QO1QizwOf+CaTVsSx7RM4
         XaPNv6saCRrgB+Yuq2x7cUaiHAE722wVUmEo0A5XZH+7Tk2lkX+2NO80eMEkn8ej034y
         OFB/Ap44nPJwX6aBkXVhkiR/bHMShc4hqI1h8pPF8O0pfZzSzTwitheQZCOqNva5pT8S
         2JE/1d4ZWc3gMrvfngiUXEugl5x6edqClrRZcyYWBi/6vop7F8IlW20P2vy9In+Tr0rB
         lDx/t7ztllNmT4MjjVG+DxxRR65j/dM3sJGltPkXQe/pkfeI94vLDWq0Houfc2bXJ1cx
         Pcag==
X-Gm-Message-State: AC+VfDzJAdem2mC5Xb3vRp6z45um4PUP7z2BrKk9HRQw8iFzdBpsgaWH
        BPmCzS9V6FfKcenR3jFZH3GDzjMBSMXxKgaHZJziVg==
X-Google-Smtp-Source: ACHHUZ6XVEo2j2/CA0Cdg4M8xrpDNfouKcA85tBGSMKyOm7Wc5xZyKDTaGwGV+d4pG0VGulqmZ5Ocg==
X-Received: by 2002:a05:6a20:94cd:b0:10b:e90d:13a2 with SMTP id ht13-20020a056a2094cd00b0010be90d13a2mr6604447pzb.36.1685325694703;
        Sun, 28 May 2023 19:01:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a17-20020a62bd11000000b0063b6bd2216dsm5685400pff.187.2023.05.28.19.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 19:01:34 -0700 (PDT)
Message-ID: <6474077e.620a0220.b3e6d.adb4@mx.google.com>
Date:   Sun, 28 May 2023 19:01:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-212-g80ae453d08c19
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 168 runs,
 4 regressions (v5.10.180-212-g80ae453d08c19)
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

stable-rc/linux-5.10.y baseline: 168 runs, 4 regressions (v5.10.180-212-g80=
ae453d08c19)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.180-212-g80ae453d08c19/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.180-212-g80ae453d08c19
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      80ae453d08c191989cbf98440279674059eca336 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473d066da6983defd2e8625

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g80ae453d08c19/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g80ae453d08c19/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473d066da6983defd2e862a
        failing since 130 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-05-28T22:06:19.753418  <8>[   11.077906] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3628317_1.5.2.4.1>
    2023-05-28T22:06:19.865519  / # #
    2023-05-28T22:06:19.969205  export SHELL=3D/bin/sh
    2023-05-28T22:06:19.970255  #
    2023-05-28T22:06:20.072737  / # export SHELL=3D/bin/sh. /lava-3628317/e=
nvironment
    2023-05-28T22:06:20.073888  =

    2023-05-28T22:06:20.176176  / # . /lava-3628317/environment/lava-362831=
7/bin/lava-test-runner /lava-3628317/1
    2023-05-28T22:06:20.177444  =

    2023-05-28T22:06:20.182167  / # /lava-3628317/bin/lava-test-runner /lav=
a-3628317/1
    2023-05-28T22:06:20.268327  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473d1f97877b1df322e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g80ae453d08c19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g80ae453d08c19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473d1f97877b1df322e85ec
        failing since 61 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-28T22:12:56.584516  + set +x

    2023-05-28T22:12:56.590411  <8>[   10.213770] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10499681_1.4.2.3.1>

    2023-05-28T22:12:56.695515  / # #

    2023-05-28T22:12:56.797099  export SHELL=3D/bin/sh

    2023-05-28T22:12:56.797912  #

    2023-05-28T22:12:56.899252  / # export SHELL=3D/bin/sh. /lava-10499681/=
environment

    2023-05-28T22:12:56.900037  =


    2023-05-28T22:12:57.001418  / # . /lava-10499681/environment/lava-10499=
681/bin/lava-test-runner /lava-10499681/1

    2023-05-28T22:12:57.002663  =


    2023-05-28T22:12:57.007834  / # /lava-10499681/bin/lava-test-runner /la=
va-10499681/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473d1ce6460e3ded32e862f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g80ae453d08c19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g80ae453d08c19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473d1ce6460e3ded32e8634
        failing since 61 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-28T22:12:08.476620  <8>[   13.657546] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10499654_1.4.2.3.1>

    2023-05-28T22:12:08.480112  + set +x

    2023-05-28T22:12:08.584164  / # #

    2023-05-28T22:12:08.684717  export SHELL=3D/bin/sh

    2023-05-28T22:12:08.684903  #

    2023-05-28T22:12:08.785380  / # export SHELL=3D/bin/sh. /lava-10499654/=
environment

    2023-05-28T22:12:08.785648  =


    2023-05-28T22:12:08.886227  / # . /lava-10499654/environment/lava-10499=
654/bin/lava-test-runner /lava-10499654/1

    2023-05-28T22:12:08.886513  =


    2023-05-28T22:12:08.891315  / # /lava-10499654/bin/lava-test-runner /la=
va-10499654/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473d08feb7c29be922e8618

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g80ae453d08c19/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a774=
3-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g80ae453d08c19/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a774=
3-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6473d08feb7c29be922e8=
619
        failing since 0 day (last pass: v5.10.180-154-gfd59dd82642d, first =
fail: v5.10.180-212-g5bb979836617c) =

 =20
