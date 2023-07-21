Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B11D75D0D8
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGURrT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGURrS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 13:47:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3430D0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 10:47:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668709767b1so1566989b3a.2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689961635; x=1690566435;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dJebsZc/fC8kb3sBIPHISjOiXvLb/djY9ndmrH9xC8I=;
        b=uKHcfbUXO5vKldpjob8ZcRvig/aL+s/jrZoODcUtuhEtUi/ObCd+jwkRLQE97FgdtF
         XNtzW3yMwSgjkDZqIO3/dZEcG18eTIGSy4dQJpxQGu61O//Qfhmno5Nd1lviqZNd/KXh
         zspqbkjJM5URvE61xIHo5MsgLUtwy9QW7Y3nvYpEwCgiWT4B/pZRIVjyvGnTLvSREezj
         RvSbdnBRj/Kf20RfMndmD3Jo8OlaJUUy13SnMOXYpgy8PXR3NuTkQ2WbSWEphrNwmG8M
         yKZxvBnZD+PhQm4qj/nhRRkS1jQCUFnMRdLw1xtpatC24Jt0ZR61cJrgPiCvUh3Wm3Gt
         CXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961635; x=1690566435;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJebsZc/fC8kb3sBIPHISjOiXvLb/djY9ndmrH9xC8I=;
        b=a/HrOUGwec+vessCKGtjQKgaGU5xlhYorn5vDWc489cEMEH1hR55xtNtOeaW4KnMIM
         uZTBuW6foo/hghdE2CQgVd6sS4wU26M5twnQZTmpkzK1XHGmwlK7xb9QjVSCABpbohd0
         3BoUzCz4HQdObazBDV79/1r7zJUry1N/jrOc8SlzfWIeOFuPOXLkvdCivmv08l1S+pt7
         Zg6CqaVm0trEinwxHUniigpiVk13ZhoULwWSE5Oy+We8XvrTxdWGHDTtKNyEWJQLBzVd
         N+U7dXvJt5PmBE318IUWrfDtChuW9TvcCeaAeOsNQD6Ora8mRbwojEqPDWFhivwXkHA5
         NyPA==
X-Gm-Message-State: ABy/qLbta43BvOTv+8Z/I2RfmVydx5YFpSzMX9C9exXj2w0rwBvayCeb
        mZGvzi5WA5Oug3NlBv1z0lKQytRR+XdvuC3dcUw=
X-Google-Smtp-Source: APBJJlGY+99DMQ5uARZJcHrwGYSMVbgxPwGnj7SM5jPSzbru67e2jiEVcQLkNKl5df5q7x8itzaG0A==
X-Received: by 2002:a05:6a20:b297:b0:136:eec5:c65b with SMTP id ei23-20020a056a20b29700b00136eec5c65bmr2014799pzb.31.1689961635464;
        Fri, 21 Jul 2023 10:47:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bb11-20020a170902bc8b00b001b03b7f8adfsm3745165plb.246.2023.07.21.10.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:47:14 -0700 (PDT)
Message-ID: <64bac4a2.170a0220.b4c2d.6fa9@mx.google.com>
Date:   Fri, 21 Jul 2023 10:47:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.120-461-gf00f5bd44794
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 33 runs,
 7 regressions (v5.15.120-461-gf00f5bd44794)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 33 runs, 7 regressions (v5.15.120-461-gf00=
f5bd44794)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.120-461-gf00f5bd44794/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.120-461-gf00f5bd44794
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f00f5bd447944c43362d06c5029e5c78ae14d2da =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ba8f317a999e3c3b8ace54

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ba8f317a999e3c3b8ace59
        failing since 114 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-21T13:59:27.032849  <8>[   11.073466] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11123367_1.4.2.3.1>

    2023-07-21T13:59:27.036006  + set +x

    2023-07-21T13:59:27.140267  / # #

    2023-07-21T13:59:27.240973  export SHELL=3D/bin/sh

    2023-07-21T13:59:27.241170  #

    2023-07-21T13:59:27.341658  / # export SHELL=3D/bin/sh. /lava-11123367/=
environment

    2023-07-21T13:59:27.341884  =


    2023-07-21T13:59:27.442443  / # . /lava-11123367/environment/lava-11123=
367/bin/lava-test-runner /lava-11123367/1

    2023-07-21T13:59:27.442756  =


    2023-07-21T13:59:27.448224  / # /lava-11123367/bin/lava-test-runner /la=
va-11123367/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ba8f902851d814ea8ace33

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ba8f902851d814ea8ace38
        failing since 114 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-21T14:00:33.394201  + set<8>[   11.757933] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11123341_1.4.2.3.1>

    2023-07-21T14:00:33.394316   +x

    2023-07-21T14:00:33.499207  / # #

    2023-07-21T14:00:33.599942  export SHELL=3D/bin/sh

    2023-07-21T14:00:33.600202  #

    2023-07-21T14:00:33.700765  / # export SHELL=3D/bin/sh. /lava-11123341/=
environment

    2023-07-21T14:00:33.701019  =


    2023-07-21T14:00:33.801600  / # . /lava-11123341/environment/lava-11123=
341/bin/lava-test-runner /lava-11123341/1

    2023-07-21T14:00:33.801987  =


    2023-07-21T14:00:33.806364  / # /lava-11123341/bin/lava-test-runner /la=
va-11123341/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ba8f3d3fc23de3248ace4e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ba8f3d3fc23de3248ace53
        failing since 114 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-21T13:58:58.629509  <8>[   10.973802] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11123327_1.4.2.3.1>

    2023-07-21T13:58:58.632848  + set +x

    2023-07-21T13:58:58.740233  /#

    2023-07-21T13:58:58.843040   # #export SHELL=3D/bin/sh

    2023-07-21T13:58:58.843821  =


    2023-07-21T13:58:58.945332  / # export SHELL=3D/bin/sh. /lava-11123327/=
environment

    2023-07-21T13:58:58.946170  =


    2023-07-21T13:58:59.047766  / # . /lava-11123327/environment/lava-11123=
327/bin/lava-test-runner /lava-11123327/1

    2023-07-21T13:58:59.049157  =


    2023-07-21T13:58:59.054219  / # /lava-11123327/bin/lava-test-runner /la=
va-11123327/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ba9103465d46fc4d8ace25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ba9103465d46fc4d8ace2a
        failing since 114 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-21T14:06:44.372438  + set +x

    2023-07-21T14:06:44.379186  <8>[   10.562859] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11123363_1.4.2.3.1>

    2023-07-21T14:06:44.483487  / # #

    2023-07-21T14:06:44.584095  export SHELL=3D/bin/sh

    2023-07-21T14:06:44.584413  #

    2023-07-21T14:06:44.684973  / # export SHELL=3D/bin/sh. /lava-11123363/=
environment

    2023-07-21T14:06:44.685177  =


    2023-07-21T14:06:44.785668  / # . /lava-11123363/environment/lava-11123=
363/bin/lava-test-runner /lava-11123363/1

    2023-07-21T14:06:44.785956  =


    2023-07-21T14:06:44.790300  / # /lava-11123363/bin/lava-test-runner /la=
va-11123363/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ba91d94dfd82d1158ace25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ba91d94dfd82d1158ace2a
        failing since 114 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-21T14:10:11.773987  + set +x

    2023-07-21T14:10:11.780802  <8>[   10.737173] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11123351_1.4.2.3.1>

    2023-07-21T14:10:11.883442  =


    2023-07-21T14:10:11.984111  / # #export SHELL=3D/bin/sh

    2023-07-21T14:10:11.984354  =


    2023-07-21T14:10:12.084924  / # export SHELL=3D/bin/sh. /lava-11123351/=
environment

    2023-07-21T14:10:12.085170  =


    2023-07-21T14:10:12.185763  / # . /lava-11123351/environment/lava-11123=
351/bin/lava-test-runner /lava-11123351/1

    2023-07-21T14:10:12.186132  =


    2023-07-21T14:10:12.190656  / # /lava-11123351/bin/lava-test-runner /la=
va-11123351/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ba8f30799f9eed128ace29

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ba8f30799f9eed128ace2e
        failing since 114 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-21T13:58:53.086390  + set +x<8>[   11.844846] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11123324_1.4.2.3.1>

    2023-07-21T13:58:53.086781  =


    2023-07-21T13:58:53.193256  / # #

    2023-07-21T13:58:53.295344  export SHELL=3D/bin/sh

    2023-07-21T13:58:53.296053  #

    2023-07-21T13:58:53.397407  / # export SHELL=3D/bin/sh. /lava-11123324/=
environment

    2023-07-21T13:58:53.398062  =


    2023-07-21T13:58:53.499432  / # . /lava-11123324/environment/lava-11123=
324/bin/lava-test-runner /lava-11123324/1

    2023-07-21T13:58:53.499736  =


    2023-07-21T13:58:53.504174  / # /lava-11123324/bin/lava-test-runner /la=
va-11123324/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ba8f2e799f9eed128ace1c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
20-461-gf00f5bd44794/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ba8f2e799f9eed128ace21
        failing since 114 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-07-21T13:58:55.840613  + set<8>[   12.872116] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11123325_1.4.2.3.1>

    2023-07-21T13:58:55.840705   +x

    2023-07-21T13:58:55.945417  / # #

    2023-07-21T13:58:56.046211  export SHELL=3D/bin/sh

    2023-07-21T13:58:56.046425  #

    2023-07-21T13:58:56.146933  / # export SHELL=3D/bin/sh. /lava-11123325/=
environment

    2023-07-21T13:58:56.147134  =


    2023-07-21T13:58:56.247724  / # . /lava-11123325/environment/lava-11123=
325/bin/lava-test-runner /lava-11123325/1

    2023-07-21T13:58:56.248148  =


    2023-07-21T13:58:56.253382  / # /lava-11123325/bin/lava-test-runner /la=
va-11123325/1
 =

    ... (12 line(s) more)  =

 =20
