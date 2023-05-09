Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C01E6FC3A2
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjEIKMz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjEIKMy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 06:12:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3845276
        for <stable@vger.kernel.org>; Tue,  9 May 2023 03:12:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so38818315ad.3
        for <stable@vger.kernel.org>; Tue, 09 May 2023 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683627162; x=1686219162;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=65CCgROOfqbC6QMBZ1nR4ywIiXsMKlUDqmyzS6K5tlY=;
        b=t3HPWBRsyd9R+YvVDj8LviWnVTEgxWtbDJZTaGmHdQZC9MX/1roKRc1UvtxlvGj2qV
         tU3vmmIaQ8IGvPgE24nwJGjqHOkpMI7zwGiXa78V3vC0MyLqifBvOFO5Bkk0rjDPKmdo
         Xd8mM5Cib38tBKcw8+iVjWomMumV7J+haLw90blMBQxUI2G2OtAMMXs9SSeb92gcqpeW
         mbaDQ/8zYd3wndESrm570eAV81wHcZRzYjxUU7WKnlj2noPNKP4/z0wkIxRtijOipPU0
         l3ujcfm2ivM4knfNs5kUmx7gTKJedbBFMrAx9MochLA/4ni1fOp9inzexDKaefzCGpze
         3E9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627162; x=1686219162;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65CCgROOfqbC6QMBZ1nR4ywIiXsMKlUDqmyzS6K5tlY=;
        b=WPRX+cgd/wDoYdTQDxGWjObtE67ZRvOc8NZ/+rkVJe5RK6bhRh+Nc0ERJpJj/Bm9U0
         cN8tVjARcWovEPoWqAdVmOGlHhLXdM2a8ZWyPwfSuWfipJTawLjnVJqaBf3MPjuBb3oh
         TCvouLimmITpvkweOQ8nf+RuwB/dpX168OWO2izOB+HZVGvCzBhfbquNhH88cOu815CO
         TqWhrybNZZaV6dk2cx4Uk0Ao9f1tANKCUoKoM490X6jg4/FTOpKLFw4MJEp/mWz9zjTr
         gLRQMO6UuZfYeX76KjDBPm/tIH3OaQlHnJ66IeeTwe4DH+s18fXdeFPHS9p94b25Lz8c
         JzMA==
X-Gm-Message-State: AC+VfDw1063REKHG32kDRWQfdlBf491hhLWRE1hmkMkKsx2iR52E/QaD
        U4tGV1v/iHs+5U6Rn+knkzJscvt8wxC7mvFooEGojg==
X-Google-Smtp-Source: ACHHUZ4scZyif4RpEZVlj+g/I4/eWC6A0bVScF+M/gHFiSctzF/WymJ0N5WtIFpuYhiQ4U6kcIIxkg==
X-Received: by 2002:a17:902:a50b:b0:19a:9880:175f with SMTP id s11-20020a170902a50b00b0019a9880175fmr12441586plq.51.1683627161952;
        Tue, 09 May 2023 03:12:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902a5c100b001a9581ed7casm1146297plq.141.2023.05.09.03.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 03:12:41 -0700 (PDT)
Message-ID: <645a1c99.170a0220.d7b8e.1ed3@mx.google.com>
Date:   Tue, 09 May 2023 03:12:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-732-g16cddd4d5f85
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 158 runs,
 13 regressions (v5.15.105-732-g16cddd4d5f85)
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

stable-rc/linux-5.15.y baseline: 158 runs, 13 regressions (v5.15.105-732-g1=
6cddd4d5f85)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.105-732-g16cddd4d5f85/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.105-732-g16cddd4d5f85
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      16cddd4d5f8571cc865a3b013db7f754966e9737 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459e513b21418cdc02e862f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459e513b21418cdc02e8634
        failing since 41 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-09T06:15:28.113534  + set +x

    2023-05-09T06:15:28.120315  <8>[   10.305793] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10251237_1.4.2.3.1>

    2023-05-09T06:15:28.223406  #

    2023-05-09T06:15:28.224584  =


    2023-05-09T06:15:28.326381  / # #export SHELL=3D/bin/sh

    2023-05-09T06:15:28.327181  =


    2023-05-09T06:15:28.428836  / # export SHELL=3D/bin/sh. /lava-10251237/=
environment

    2023-05-09T06:15:28.429043  =


    2023-05-09T06:15:28.529584  / # . /lava-10251237/environment/lava-10251=
237/bin/lava-test-runner /lava-10251237/1

    2023-05-09T06:15:28.529953  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459e512f6f2b4eb882e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459e512f6f2b4eb882e860c
        failing since 41 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-09T06:15:24.944349  + <8>[   11.059022] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10251218_1.4.2.3.1>

    2023-05-09T06:15:24.944438  set +x

    2023-05-09T06:15:25.049606  / # #

    2023-05-09T06:15:25.150202  export SHELL=3D/bin/sh

    2023-05-09T06:15:25.150388  #

    2023-05-09T06:15:25.250908  / # export SHELL=3D/bin/sh. /lava-10251218/=
environment

    2023-05-09T06:15:25.251100  =


    2023-05-09T06:15:25.351657  / # . /lava-10251218/environment/lava-10251=
218/bin/lava-test-runner /lava-10251218/1

    2023-05-09T06:15:25.351962  =


    2023-05-09T06:15:25.356735  / # /lava-10251218/bin/lava-test-runner /la=
va-10251218/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459e517f6f2b4eb882e8632

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459e517f6f2b4eb882e8637
        failing since 41 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-09T06:15:28.152786  <8>[   10.790843] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10251238_1.4.2.3.1>

    2023-05-09T06:15:28.156036  + set +x

    2023-05-09T06:15:28.260430  =


    2023-05-09T06:15:28.362667  / # #export SHELL=3D/bin/sh

    2023-05-09T06:15:28.363553  =


    2023-05-09T06:15:28.465349  / # export SHELL=3D/bin/sh. /lava-10251238/=
environment

    2023-05-09T06:15:28.466033  =


    2023-05-09T06:15:28.567719  / # . /lava-10251238/environment/lava-10251=
238/bin/lava-test-runner /lava-10251238/1

    2023-05-09T06:15:28.568777  =


    2023-05-09T06:15:28.574216  / # /lava-10251238/bin/lava-test-runner /la=
va-10251238/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459e5019429c32cc72e864e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459e5019429c32cc72e8653
        failing since 41 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-09T06:15:18.916429  + <8>[   10.815327] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10251210_1.4.2.3.1>

    2023-05-09T06:15:18.916507  set +x

    2023-05-09T06:15:19.017910  =


    2023-05-09T06:15:19.118458  / # #export SHELL=3D/bin/sh

    2023-05-09T06:15:19.118626  =


    2023-05-09T06:15:19.219168  / # export SHELL=3D/bin/sh. /lava-10251210/=
environment

    2023-05-09T06:15:19.219891  =


    2023-05-09T06:15:19.321556  / # . /lava-10251210/environment/lava-10251=
210/bin/lava-test-runner /lava-10251210/1

    2023-05-09T06:15:19.321890  =


    2023-05-09T06:15:19.326102  / # /lava-10251210/bin/lava-test-runner /la=
va-10251210/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459e4ff6a51ab618f2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459e4ff6a51ab618f2e85eb
        failing since 41 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-09T06:15:12.248690  + set +x

    2023-05-09T06:15:12.254894  <8>[   10.296175] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10251178_1.4.2.3.1>

    2023-05-09T06:15:12.360014  / # #

    2023-05-09T06:15:12.460880  export SHELL=3D/bin/sh

    2023-05-09T06:15:12.461163  #

    2023-05-09T06:15:12.561776  / # export SHELL=3D/bin/sh. /lava-10251178/=
environment

    2023-05-09T06:15:12.561987  =


    2023-05-09T06:15:12.662533  / # . /lava-10251178/environment/lava-10251=
178/bin/lava-test-runner /lava-10251178/1

    2023-05-09T06:15:12.662866  =


    2023-05-09T06:15:12.667988  / # /lava-10251178/bin/lava-test-runner /la=
va-10251178/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459e51430e051e53f2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459e51430e051e53f2e85eb
        failing since 41 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-09T06:15:19.091309  + set<8>[   11.137489] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10251225_1.4.2.3.1>

    2023-05-09T06:15:19.091397   +x

    2023-05-09T06:15:19.195323  / # #

    2023-05-09T06:15:19.295914  export SHELL=3D/bin/sh

    2023-05-09T06:15:19.296179  #

    2023-05-09T06:15:19.396692  / # export SHELL=3D/bin/sh. /lava-10251225/=
environment

    2023-05-09T06:15:19.396903  =


    2023-05-09T06:15:19.497461  / # . /lava-10251225/environment/lava-10251=
225/bin/lava-test-runner /lava-10251225/1

    2023-05-09T06:15:19.497810  =


    2023-05-09T06:15:19.502660  / # /lava-10251225/bin/lava-test-runner /la=
va-10251225/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6459e84436ff5cb7412e85e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459e84436ff5cb7412e85ec
        failing since 98 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, first=
 fail: v5.15.90-205-g5605d15db022)

    2023-05-09T06:29:15.998366  + set +x
    2023-05-09T06:29:15.998672  [    9.415982] <LAVA_SIGNAL_ENDRUN 0_dmesg =
944593_1.5.2.3.1>
    2023-05-09T06:29:16.106768  / # #
    2023-05-09T06:29:16.208797  export SHELL=3D/bin/sh
    2023-05-09T06:29:16.209413  #
    2023-05-09T06:29:16.310865  / # export SHELL=3D/bin/sh. /lava-944593/en=
vironment
    2023-05-09T06:29:16.311353  =

    2023-05-09T06:29:16.412654  / # . /lava-944593/environment/lava-944593/=
bin/lava-test-runner /lava-944593/1
    2023-05-09T06:29:16.413390  =

    2023-05-09T06:29:16.415860  / # /lava-944593/bin/lava-test-runner /lava=
-944593/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459e4f89429c32cc72e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459e4f89429c32cc72e8605
        failing since 41 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-09T06:15:09.833468  <8>[   14.051031] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10251206_1.4.2.3.1>

    2023-05-09T06:15:09.941283  / # #

    2023-05-09T06:15:10.043909  export SHELL=3D/bin/sh

    2023-05-09T06:15:10.044624  #

    2023-05-09T06:15:10.146128  / # export SHELL=3D/bin/sh. /lava-10251206/=
environment

    2023-05-09T06:15:10.146904  =


    2023-05-09T06:15:10.248491  / # . /lava-10251206/environment/lava-10251=
206/bin/lava-test-runner /lava-10251206/1

    2023-05-09T06:15:10.249718  =


    2023-05-09T06:15:10.254500  / # /lava-10251206/bin/lava-test-runner /la=
va-10251206/1

    2023-05-09T06:15:10.260279  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6459ea057dba26659c2e8651

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6459ea057dba26659c2e866b
        failing since 1 day (last pass: v5.15.105-361-g64fb7ad7e758, first =
fail: v5.15.105-738-g89e0c91492bf3)

    2023-05-09T06:36:28.277733  /lava-10251356/1/../bin/lava-test-case

    2023-05-09T06:36:28.284622  <8>[   32.186349] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6459ea057dba26659c2e866b
        failing since 1 day (last pass: v5.15.105-361-g64fb7ad7e758, first =
fail: v5.15.105-738-g89e0c91492bf3)

    2023-05-09T06:36:28.277733  /lava-10251356/1/../bin/lava-test-case

    2023-05-09T06:36:28.284622  <8>[   32.186349] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6459ea057dba26659c2e866d
        failing since 1 day (last pass: v5.15.105-361-g64fb7ad7e758, first =
fail: v5.15.105-738-g89e0c91492bf3)

    2023-05-09T06:36:27.237812  /lava-10251356/1/../bin/lava-test-case

    2023-05-09T06:36:27.244625  <8>[   31.146272] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459ea057dba26659c2e86f5
        failing since 1 day (last pass: v5.15.105-361-g64fb7ad7e758, first =
fail: v5.15.105-738-g89e0c91492bf3)

    2023-05-09T06:36:13.054257  <8>[   16.958929] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10251356_1.5.2.3.1>

    2023-05-09T06:36:13.057334  + set +x

    2023-05-09T06:36:13.165243  / # #

    2023-05-09T06:36:13.265970  export SHELL=3D/bin/sh

    2023-05-09T06:36:13.266211  #

    2023-05-09T06:36:13.366799  / # export SHELL=3D/bin/sh. /lava-10251356/=
environment

    2023-05-09T06:36:13.367053  =


    2023-05-09T06:36:13.467633  / # . /lava-10251356/environment/lava-10251=
356/bin/lava-test-runner /lava-10251356/1

    2023-05-09T06:36:13.467987  =


    2023-05-09T06:36:13.473397  / # /lava-10251356/bin/lava-test-runner /la=
va-10251356/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6459e8f14d27e90faf2e8642

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-732-g16cddd4d5f85/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459e8f14d27e90faf2e866f
        failing since 111 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-05-09T06:31:19.892105  <8>[   16.096601] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3566922_1.5.2.4.1>
    2023-05-09T06:31:20.018885  / # #
    2023-05-09T06:31:20.126720  export SHELL=3D/bin/sh
    2023-05-09T06:31:20.128486  #
    2023-05-09T06:31:20.234585  / # export SHELL=3D/bin/sh. /lava-3566922/e=
nvironment
    2023-05-09T06:31:20.236511  =

    2023-05-09T06:31:20.340954  / # . /lava-3566922/environment/lava-356692=
2/bin/lava-test-runner /lava-3566922/1
    2023-05-09T06:31:20.345438  =

    2023-05-09T06:31:20.348386  / # /lava-3566922/bin/lava-test-runner /lav=
a-3566922/1
    2023-05-09T06:31:20.396867  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
