Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD3C796EB0
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 03:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjIGBvk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 21:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243488AbjIGBvk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 21:51:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4917C1BC2
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 18:51:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68e369ba5f8so380107b3a.2
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 18:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694051493; x=1694656293; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PtbRwxfVt3zms2zaADWFLw6yZmyliVB4iXbG0XWl2eY=;
        b=ZIdBhiuFymH4hLxpJDCgPJrZ0o3ZGSEd/sULAkFALjmkZ0GPaFDtdOYN0/qasymoLU
         gqz7BZOmiWzISi8UmLPYZZlAkPst9rM92Wjs8BwHKEIRNy1PettpWwHoSdTruseuYvwm
         fouAtfTLAxy0u9bBgwtuScXUhRxeGokH79+ZppBz8AwVvROribzNtUnLL2x26q6p/0hu
         eU9bmdqfD6HQ5mgfKM2YzuxTGdn+eHiVlrywETbwZrvseKoNet6cENokQNd/M6dzg75W
         tfrtsICM3ZhhGeB2jAJGd0GCqOalml+71J6P9NmUVbFva4H37Z9pQP4JweicNbsuI1rt
         lWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694051493; x=1694656293;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtbRwxfVt3zms2zaADWFLw6yZmyliVB4iXbG0XWl2eY=;
        b=P3boBwbdfgb7FsyEnIrR38+kH6yWpxuJTzxwaO7vgYsXfB5drrflYWXKp1XbM+ex4t
         HtWY5w8U6KkPVIXkUrK+o2cAVPP8jALag0Yrg/OxcGJODNsPKwwjn2XdpvDFbFECpElk
         D3UgkJW8aSOS56hXj7k4yE6O8KMC16vG6z7ohf1T3VOCKfiApsMbnsaQ7nvN98NnoWZR
         6JRSTb1Y97LVy6QMzF1Sg3gQSnXy2Z7gFYCUhbGLe9Xdj7iOT5MQDeGFTEk6XUwMW3L2
         wII7iy9LZwiIvMFikn5XpqHx0fKFdWcAzIcm4wFSNF+AMD5ShYqhyoRmgG4xJMVY4as3
         Rhqg==
X-Gm-Message-State: AOJu0Ywfvh2OaN6LL0B7iRPmKzh3OGIVxKekHKbCo0s2jafnoTRYDf0q
        2teB0fBxLWZbFlFRuYUhSboDZT21iAPRE+anlPAJbw==
X-Google-Smtp-Source: AGHT+IE7eoigl5xR25c+HrlLKC8mfdVBd4dLOo+nQZnZTOsiSAHQIburbaOD6vpv8DdMbGTXX9BE9Q==
X-Received: by 2002:a05:6a21:7746:b0:140:324c:124c with SMTP id bc6-20020a056a21774600b00140324c124cmr13134377pzc.62.1694051493029;
        Wed, 06 Sep 2023 18:51:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x13-20020a656aad000000b0055c558ac4edsm10563487pgu.46.2023.09.06.18.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 18:51:32 -0700 (PDT)
Message-ID: <64f92ca4.650a0220.7479d.6000@mx.google.com>
Date:   Wed, 06 Sep 2023 18:51:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.52
Subject: stable-rc/linux-6.1.y baseline: 112 runs, 10 regressions (v6.1.52)
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

stable-rc/linux-6.1.y baseline: 112 runs, 10 regressions (v6.1.52)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.52/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.52
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      59b13c2b647e464dd85622c89d7f16c15d681e96 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8f745885bf7e877286d88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f8f745885bf7e877286=
d89
        failing since 4 days (last pass: v6.1.50-11-g1767553758a66, first f=
ail: v6.1.51) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8f719e826411416286d88

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8f719e826411416286d8d
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T22:03:53.514764  <8>[   10.456042] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451215_1.4.2.3.1>

    2023-09-06T22:03:53.518034  + set +x

    2023-09-06T22:03:53.619412  #

    2023-09-06T22:03:53.720242  / # #export SHELL=3D/bin/sh

    2023-09-06T22:03:53.720447  =


    2023-09-06T22:03:53.820973  / # export SHELL=3D/bin/sh. /lava-11451215/=
environment

    2023-09-06T22:03:53.821172  =


    2023-09-06T22:03:53.921708  / # . /lava-11451215/environment/lava-11451=
215/bin/lava-test-runner /lava-11451215/1

    2023-09-06T22:03:53.922016  =


    2023-09-06T22:03:53.928019  / # /lava-11451215/bin/lava-test-runner /la=
va-11451215/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8f97d2441d083c5286dae

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8f97d2441d083c5286db3
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T22:12:56.591196  + set<8>[   11.175173] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11451227_1.4.2.3.1>

    2023-09-06T22:12:56.591620   +x

    2023-09-06T22:12:56.698649  / # #

    2023-09-06T22:12:56.800661  export SHELL=3D/bin/sh

    2023-09-06T22:12:56.801517  #

    2023-09-06T22:12:56.903198  / # export SHELL=3D/bin/sh. /lava-11451227/=
environment

    2023-09-06T22:12:56.903849  =


    2023-09-06T22:12:57.005347  / # . /lava-11451227/environment/lava-11451=
227/bin/lava-test-runner /lava-11451227/1

    2023-09-06T22:12:57.006817  =


    2023-09-06T22:12:57.011754  / # /lava-11451227/bin/lava-test-runner /la=
va-11451227/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fc8218c05b8baa286ec3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fc8218c05b8baa286ec8
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T22:25:46.633046  <8>[   11.077347] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451199_1.4.2.3.1>

    2023-09-06T22:25:46.636431  + set +x

    2023-09-06T22:25:46.739076  =


    2023-09-06T22:25:46.840806  / # #export SHELL=3D/bin/sh

    2023-09-06T22:25:46.841633  =


    2023-09-06T22:25:46.943250  / # export SHELL=3D/bin/sh. /lava-11451199/=
environment

    2023-09-06T22:25:46.944059  =


    2023-09-06T22:25:47.045816  / # . /lava-11451199/environment/lava-11451=
199/bin/lava-test-runner /lava-11451199/1

    2023-09-06T22:25:47.047075  =


    2023-09-06T22:25:47.052692  / # /lava-11451199/bin/lava-test-runner /la=
va-11451199/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fc14fb1a91fe79286e3c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fc14fb1a91fe79286e41
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T22:24:55.777219  + set +x

    2023-09-06T22:24:55.784132  <8>[   10.864746] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451205_1.4.2.3.1>

    2023-09-06T22:24:55.892479  / # #

    2023-09-06T22:24:55.995021  export SHELL=3D/bin/sh

    2023-09-06T22:24:55.995772  #

    2023-09-06T22:24:56.097308  / # export SHELL=3D/bin/sh. /lava-11451205/=
environment

    2023-09-06T22:24:56.098206  =


    2023-09-06T22:24:56.199982  / # . /lava-11451205/environment/lava-11451=
205/bin/lava-test-runner /lava-11451205/1

    2023-09-06T22:24:56.201082  =


    2023-09-06T22:24:56.206062  / # /lava-11451205/bin/lava-test-runner /la=
va-11451205/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8f721a62e1fbadc286d6f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8f721a62e1fbadc286d74
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T22:02:56.195970  + set<8>[    8.591876] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11451187_1.4.2.3.1>

    2023-09-06T22:02:56.196084   +x

    2023-09-06T22:02:56.300275  / # #

    2023-09-06T22:02:56.400976  export SHELL=3D/bin/sh

    2023-09-06T22:02:56.401202  #

    2023-09-06T22:02:56.501762  / # export SHELL=3D/bin/sh. /lava-11451187/=
environment

    2023-09-06T22:02:56.501966  =


    2023-09-06T22:02:56.602477  / # . /lava-11451187/environment/lava-11451=
187/bin/lava-test-runner /lava-11451187/1

    2023-09-06T22:02:56.602785  =


    2023-09-06T22:02:56.607096  / # /lava-11451187/bin/lava-test-runner /la=
va-11451187/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8f97c2441d083c5286da1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8f97c2441d083c5286da6
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T22:12:58.775689  + set<8>[   11.169326] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11451208_1.4.2.3.1>

    2023-09-06T22:12:58.776308   +x

    2023-09-06T22:12:58.884172  / # #

    2023-09-06T22:12:58.986563  export SHELL=3D/bin/sh

    2023-09-06T22:12:58.987338  #

    2023-09-06T22:12:59.089078  / # export SHELL=3D/bin/sh. /lava-11451208/=
environment

    2023-09-06T22:12:59.089880  =


    2023-09-06T22:12:59.191789  / # . /lava-11451208/environment/lava-11451=
208/bin/lava-test-runner /lava-11451208/1

    2023-09-06T22:12:59.193105  =


    2023-09-06T22:12:59.198427  / # /lava-11451208/bin/lava-test-runner /la=
va-11451208/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fb85a46b2c266c286d6d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fb85a46b2c266c286d72
        failing since 51 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-06T22:23:11.465704  / # #

    2023-09-06T22:23:11.566456  export SHELL=3D/bin/sh

    2023-09-06T22:23:11.566725  #

    2023-09-06T22:23:11.667287  / # export SHELL=3D/bin/sh. /lava-11451451/=
environment

    2023-09-06T22:23:11.667574  =


    2023-09-06T22:23:11.768422  / # . /lava-11451451/environment/lava-11451=
451/bin/lava-test-runner /lava-11451451/1

    2023-09-06T22:23:11.769639  =


    2023-09-06T22:23:11.774288  / # /lava-11451451/bin/lava-test-runner /la=
va-11451451/1

    2023-09-06T22:23:11.834595  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-06T22:23:11.835097  + cd /lav<8>[   19.134982] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11451451_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fbabee72ec8051286d96

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fbabee72ec8051286d9b
        failing since 51 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-06T22:23:46.099603  / # #

    2023-09-06T22:23:47.178402  export SHELL=3D/bin/sh

    2023-09-06T22:23:47.180163  #

    2023-09-06T22:23:48.668765  / # export SHELL=3D/bin/sh. /lava-11451447/=
environment

    2023-09-06T22:23:48.670543  =


    2023-09-06T22:23:51.387929  / # . /lava-11451447/environment/lava-11451=
447/bin/lava-test-runner /lava-11451447/1

    2023-09-06T22:23:51.390073  =


    2023-09-06T22:23:51.391174  / # /lava-11451447/bin/lava-test-runner /la=
va-11451447/1

    2023-09-06T22:23:51.458085  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-06T22:23:51.458571  + cd /lava-114514<8>[   28.471552] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11451447_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8fb876d166516c5286dfc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f8fb876d166516c5286e01
        failing since 51 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-06T22:23:24.619383  / # #

    2023-09-06T22:23:24.721565  export SHELL=3D/bin/sh

    2023-09-06T22:23:24.722269  #

    2023-09-06T22:23:24.823682  / # export SHELL=3D/bin/sh. /lava-11451453/=
environment

    2023-09-06T22:23:24.824393  =


    2023-09-06T22:23:24.925817  / # . /lava-11451453/environment/lava-11451=
453/bin/lava-test-runner /lava-11451453/1

    2023-09-06T22:23:24.926902  =


    2023-09-06T22:23:24.943665  / # /lava-11451453/bin/lava-test-runner /la=
va-11451453/1

    2023-09-06T22:23:25.009642  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-06T22:23:25.010162  + cd /lava-1145145<8>[   17.037107] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11451453_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
