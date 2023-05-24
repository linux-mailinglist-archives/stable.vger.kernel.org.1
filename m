Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7047101B0
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 01:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjEXX2d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 19:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEXX2c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 19:28:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB799
        for <stable@vger.kernel.org>; Wed, 24 May 2023 16:28:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae4c5e1388so7380515ad.1
        for <stable@vger.kernel.org>; Wed, 24 May 2023 16:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684970908; x=1687562908;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sVSh0cHRhikefPf23wNLCdfarwLDApIewVuAuZjkc5w=;
        b=n7QaxRNfBCklGFi+XW2BWAWT3lPEZ34j5S8N8sT9G0B7PZH4e5bfJgyMzQTnB0/B3Y
         k/RElzqTHipKduPsqZtmyCoYSBWV1i3XfG6QiyV8hbiR8QxsrxnZcL1eNQoC02otfZQ0
         TCdn6DNrNMnxPFOCWugSwqjArUVqxzVfjgEEbXTmnsoFqoAIXOugHsGsVpqaulq92C00
         AHsiltrxfg0vzjxOMegCwAEisldXquVMjOPPPlFPz98Iyuy4KmnAk781tPyTxk4KxG++
         FRznriTUO5MG2MGtoGFxWrmWazqkgMgQ+KKEOHOWbg7xv6b97/A/JQeSvvg9uFwdjhey
         PiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684970908; x=1687562908;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVSh0cHRhikefPf23wNLCdfarwLDApIewVuAuZjkc5w=;
        b=YPPjkGQXLOBm63Z6cj0HZCfKFMRrYIrekbPLPBaoDWDBV1Z+x6uMZh7oID9yzxr3h7
         5IhKzdU1PHm7vtl5WE6PFpI9hchgkwXy5LpjsLUWg8kEBOG++ZMZ0C9zdoCv64Tbf2iw
         kEOlHPiROZjmWBsWNOhs7KT03JErHOu8llUFsJhU2gPC0uiWcwywKMYy5YPqhaosnftc
         BgRd45UcRmo1SE3cEPO52nlZf3me9kYgHS7zTd+R+qwNoua1ZtJPNHjGasPtEPDvJHnk
         VxxBKaA/XHHRqYnDQHY8O0DurmxsPAt4f2P19mz1LeeBqKJoq1j3fKIm6+4EP9imhCnd
         isww==
X-Gm-Message-State: AC+VfDzRTetHPPAH0imgjNTIrWEeWDxADrMBh9sFvUJk13XgrwlmhsSn
        FKe9tI5QPczxWaFt/yszcdsuUtzkEfJR0Jy8QoJtuw==
X-Google-Smtp-Source: ACHHUZ67OY8D8meAFP9cGe0NUC+NLdEna2RWVtn7ePlvcZ5+mebbBJi6U2lSlMvPfpXFmhTZeB/Y/A==
X-Received: by 2002:a17:903:188:b0:1a9:8ba4:d0e3 with SMTP id z8-20020a170903018800b001a98ba4d0e3mr23646404plg.59.1684970907520;
        Wed, 24 May 2023 16:28:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001a9af8ddb64sm9206457plg.298.2023.05.24.16.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 16:28:26 -0700 (PDT)
Message-ID: <646e9d9a.170a0220.eb86.18e9@mx.google.com>
Date:   Wed, 24 May 2023 16:28:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.15.113
X-Kernelci-Report-Type: test
Subject: stable/linux-5.15.y baseline: 191 runs, 20 regressions (v5.15.113)
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

stable/linux-5.15.y baseline: 191 runs, 20 regressions (v5.15.113)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-g12a-sei510            | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 4          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.113/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.113
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      1fe619a7d25218e9b9fdcce9fcac6a05cd62abed =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646e633fd31afc1ddb2e860b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e633fd31afc1ddb2e8610
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:19:21.169020  + set +x

    2023-05-24T19:19:21.175804  <8>[   12.171794] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10443116_1.4.2.3.1>

    2023-05-24T19:19:21.280376  / # #

    2023-05-24T19:19:21.380940  export SHELL=3D/bin/sh

    2023-05-24T19:19:21.381130  #

    2023-05-24T19:19:21.481686  / # export SHELL=3D/bin/sh. /lava-10443116/=
environment

    2023-05-24T19:19:21.481927  =


    2023-05-24T19:19:21.582691  / # . /lava-10443116/environment/lava-10443=
116/bin/lava-test-runner /lava-10443116/1

    2023-05-24T19:19:21.582984  =


    2023-05-24T19:19:21.589358  / # /lava-10443116/bin/lava-test-runner /la=
va-10443116/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e670c3298e00dd42e8621

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e670c3298e00dd42e8626
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:35:24.290198  + set +x

    2023-05-24T19:35:24.296884  <8>[   10.449156] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10443374_1.4.2.3.1>

    2023-05-24T19:35:24.398664  #

    2023-05-24T19:35:24.398961  =


    2023-05-24T19:35:24.499533  / # #export SHELL=3D/bin/sh

    2023-05-24T19:35:24.499743  =


    2023-05-24T19:35:24.600245  / # export SHELL=3D/bin/sh. /lava-10443374/=
environment

    2023-05-24T19:35:24.600441  =


    2023-05-24T19:35:24.701029  / # . /lava-10443374/environment/lava-10443=
374/bin/lava-test-runner /lava-10443374/1

    2023-05-24T19:35:24.701392  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646e634a15e553ebf02e85ec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e634a15e553ebf02e85f1
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:19:30.146107  + <8>[   12.884640] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10443109_1.4.2.3.1>

    2023-05-24T19:19:30.146258  set +x

    2023-05-24T19:19:30.251007  / # #

    2023-05-24T19:19:30.351879  export SHELL=3D/bin/sh

    2023-05-24T19:19:30.352145  #

    2023-05-24T19:19:30.452769  / # export SHELL=3D/bin/sh. /lava-10443109/=
environment

    2023-05-24T19:19:30.453046  =


    2023-05-24T19:19:30.553687  / # . /lava-10443109/environment/lava-10443=
109/bin/lava-test-runner /lava-10443109/1

    2023-05-24T19:19:30.554125  =


    2023-05-24T19:19:30.558962  / # /lava-10443109/bin/lava-test-runner /la=
va-10443109/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e670fc270f0122e2e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e670fc270f0122e2e861f
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:35:20.609072  + <8>[   11.360951] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10443413_1.4.2.3.1>

    2023-05-24T19:35:20.609508  set +x

    2023-05-24T19:35:20.716664  / # #

    2023-05-24T19:35:20.818765  export SHELL=3D/bin/sh

    2023-05-24T19:35:20.819480  #

    2023-05-24T19:35:20.920898  / # export SHELL=3D/bin/sh. /lava-10443413/=
environment

    2023-05-24T19:35:20.921563  =


    2023-05-24T19:35:21.023043  / # . /lava-10443413/environment/lava-10443=
413/bin/lava-test-runner /lava-10443413/1

    2023-05-24T19:35:21.024139  =


    2023-05-24T19:35:21.029557  / # /lava-10443413/bin/lava-test-runner /la=
va-10443413/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646e633ece6df15c4c2e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e633ece6df15c4c2e8611
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:19:17.900902  + set +x

    2023-05-24T19:19:17.907599  <8>[   11.503058] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10443089_1.4.2.3.1>

    2023-05-24T19:19:18.015781  / # #

    2023-05-24T19:19:18.117982  export SHELL=3D/bin/sh

    2023-05-24T19:19:18.118737  #

    2023-05-24T19:19:18.220227  / # export SHELL=3D/bin/sh. /lava-10443089/=
environment

    2023-05-24T19:19:18.220932  =


    2023-05-24T19:19:18.322397  / # . /lava-10443089/environment/lava-10443=
089/bin/lava-test-runner /lava-10443089/1

    2023-05-24T19:19:18.323512  =


    2023-05-24T19:19:18.328744  / # /lava-10443089/bin/lava-test-runner /la=
va-10443089/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e670efbcadfa8762e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e670efbcadfa8762e85ed
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:35:30.706630  <8>[   10.998914] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10443373_1.4.2.3.1>

    2023-05-24T19:35:30.710131  + set +x

    2023-05-24T19:35:30.815373  #

    2023-05-24T19:35:30.815821  =


    2023-05-24T19:35:30.916701  / # #export SHELL=3D/bin/sh

    2023-05-24T19:35:30.917447  =


    2023-05-24T19:35:31.018831  / # export SHELL=3D/bin/sh. /lava-10443373/=
environment

    2023-05-24T19:35:31.019525  =


    2023-05-24T19:35:31.121048  / # . /lava-10443373/environment/lava-10443=
373/bin/lava-test-runner /lava-10443373/1

    2023-05-24T19:35:31.122545  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646e6339ce6df15c4c2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e6339ce6df15c4c2e85ec
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:19:00.536140  + set +x

    2023-05-24T19:19:00.542716  <8>[   12.572699] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10443101_1.4.2.3.1>

    2023-05-24T19:19:00.647412  / # #

    2023-05-24T19:19:00.747991  export SHELL=3D/bin/sh

    2023-05-24T19:19:00.748276  #

    2023-05-24T19:19:00.848881  / # export SHELL=3D/bin/sh. /lava-10443101/=
environment

    2023-05-24T19:19:00.849061  =


    2023-05-24T19:19:00.949577  / # . /lava-10443101/environment/lava-10443=
101/bin/lava-test-runner /lava-10443101/1

    2023-05-24T19:19:00.949837  =


    2023-05-24T19:19:00.954423  / # /lava-10443101/bin/lava-test-runner /la=
va-10443101/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e6713fbcadfa8762e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e6713fbcadfa8762e8607
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:35:21.699104  + set +x

    2023-05-24T19:35:21.705406  <8>[   10.560768] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10443408_1.4.2.3.1>

    2023-05-24T19:35:21.810272  / # #

    2023-05-24T19:35:21.911000  export SHELL=3D/bin/sh

    2023-05-24T19:35:21.911223  #

    2023-05-24T19:35:22.011779  / # export SHELL=3D/bin/sh. /lava-10443408/=
environment

    2023-05-24T19:35:22.012039  =


    2023-05-24T19:35:22.112642  / # . /lava-10443408/environment/lava-10443=
408/bin/lava-test-runner /lava-10443408/1

    2023-05-24T19:35:22.113016  =


    2023-05-24T19:35:22.117345  / # /lava-10443408/bin/lava-test-runner /la=
va-10443408/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646e6324d31afc1ddb2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e6324d31afc1ddb2e85ec
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:18:53.443160  + <8>[   11.604676] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10443066_1.4.2.3.1>

    2023-05-24T19:18:53.443267  set +x

    2023-05-24T19:18:53.544500  #

    2023-05-24T19:18:53.544760  =


    2023-05-24T19:18:53.645303  / # #export SHELL=3D/bin/sh

    2023-05-24T19:18:53.645519  =


    2023-05-24T19:18:53.746056  / # export SHELL=3D/bin/sh. /lava-10443066/=
environment

    2023-05-24T19:18:53.746274  =


    2023-05-24T19:18:53.846790  / # . /lava-10443066/environment/lava-10443=
066/bin/lava-test-runner /lava-10443066/1

    2023-05-24T19:18:53.847116  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e66f9a80ff6e1802e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e66f9a80ff6e1802e860b
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:35:05.253961  <8>[   10.909753] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10443422_1.4.2.3.1>

    2023-05-24T19:35:05.257236  + set +x

    2023-05-24T19:35:05.362080  #

    2023-05-24T19:35:05.363332  =


    2023-05-24T19:35:05.465136  / # #export SHELL=3D/bin/sh

    2023-05-24T19:35:05.465850  =


    2023-05-24T19:35:05.567189  / # export SHELL=3D/bin/sh. /lava-10443422/=
environment

    2023-05-24T19:35:05.567875  =


    2023-05-24T19:35:05.669253  / # . /lava-10443422/environment/lava-10443=
422/bin/lava-test-runner /lava-10443422/1

    2023-05-24T19:35:05.670285  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646e6340d31afc1ddb2e8616

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e6340d31afc1ddb2e861b
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:19:18.138385  + <8>[   13.201248] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10443098_1.4.2.3.1>

    2023-05-24T19:19:18.138927  set +x

    2023-05-24T19:19:18.246016  / # #

    2023-05-24T19:19:18.348221  export SHELL=3D/bin/sh

    2023-05-24T19:19:18.348917  #

    2023-05-24T19:19:18.450284  / # export SHELL=3D/bin/sh. /lava-10443098/=
environment

    2023-05-24T19:19:18.451050  =


    2023-05-24T19:19:18.552563  / # . /lava-10443098/environment/lava-10443=
098/bin/lava-test-runner /lava-10443098/1

    2023-05-24T19:19:18.553769  =


    2023-05-24T19:19:18.558887  / # /lava-10443098/bin/lava-test-runner /la=
va-10443098/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e67112dd1f0bde12e8627

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e67112dd1f0bde12e862c
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:35:29.239366  + set<8>[   10.846329] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10443405_1.4.2.3.1>

    2023-05-24T19:35:29.239451   +x

    2023-05-24T19:35:29.344037  / # #

    2023-05-24T19:35:29.444734  export SHELL=3D/bin/sh

    2023-05-24T19:35:29.444919  #

    2023-05-24T19:35:29.545567  / # export SHELL=3D/bin/sh. /lava-10443405/=
environment

    2023-05-24T19:35:29.545845  =


    2023-05-24T19:35:29.646583  / # . /lava-10443405/environment/lava-10443=
405/bin/lava-test-runner /lava-10443405/1

    2023-05-24T19:35:29.647687  =


    2023-05-24T19:35:29.653209  / # /lava-10443405/bin/lava-test-runner /la=
va-10443405/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646e63257b5a4a748e2e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e63257b5a4a748e2e860e
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:18:52.048366  + set<8>[   12.667167] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10443102_1.4.2.3.1>

    2023-05-24T19:18:52.048759   +x

    2023-05-24T19:18:52.155655  / # #

    2023-05-24T19:18:52.257687  export SHELL=3D/bin/sh

    2023-05-24T19:18:52.258304  #

    2023-05-24T19:18:52.359547  / # export SHELL=3D/bin/sh. /lava-10443102/=
environment

    2023-05-24T19:18:52.359774  =


    2023-05-24T19:18:52.460487  / # . /lava-10443102/environment/lava-10443=
102/bin/lava-test-runner /lava-10443102/1

    2023-05-24T19:18:52.461477  =


    2023-05-24T19:18:52.466268  / # /lava-10443102/bin/lava-test-runner /la=
va-10443102/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e66f8067665b1a72e866c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e66f8067665b1a72e8671
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-24T19:35:05.318862  <8>[   11.312275] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10443392_1.4.2.3.1>

    2023-05-24T19:35:05.426789  / # #

    2023-05-24T19:35:05.529000  export SHELL=3D/bin/sh

    2023-05-24T19:35:05.529705  #

    2023-05-24T19:35:05.631072  / # export SHELL=3D/bin/sh. /lava-10443392/=
environment

    2023-05-24T19:35:05.631740  =


    2023-05-24T19:35:05.733129  / # . /lava-10443392/environment/lava-10443=
392/bin/lava-test-runner /lava-10443392/1

    2023-05-24T19:35:05.734325  =


    2023-05-24T19:35:05.739183  / # /lava-10443392/bin/lava-test-runner /la=
va-10443392/1

    2023-05-24T19:35:05.751202  + export<8>[   11.742743] <LAVA_SIGNAL_STAR=
TRUN 1_bootrr 10443392_1.4.2.3.5>
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12a-sei510            | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646e65d696ccae89db2e85f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12a-sei510.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12a-sei510.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e65d696ccae89db2e85f7
        new failure (last pass: v5.15.112)

    2023-05-24T19:30:23.398711  / # #
    2023-05-24T19:30:23.500308  export SHELL=3D/bin/sh
    2023-05-24T19:30:23.500719  #
    2023-05-24T19:30:23.601962  / # export SHELL=3D/bin/sh. /lava-3615268/e=
nvironment
    2023-05-24T19:30:23.602361  =

    2023-05-24T19:30:23.703613  / # . /lava-3615268/environment/lava-361526=
8/bin/lava-test-runner /lava-3615268/1
    2023-05-24T19:30:23.704301  =

    2023-05-24T19:30:23.711707  / # /lava-3615268/bin/lava-test-runner /lav=
a-3615268/1
    2023-05-24T19:30:23.779271  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-24T19:30:23.779499  + cd /lava-3615268/1/tests/1_bootrr =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/646e649d3dea4c0c852e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646e649d3dea4c0c852e8=
5ec
        failing since 120 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 4          =


  Details:     https://kernelci.org/test/plan/id/646e643a74be7393182e85e8

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.113/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/646e643a74be7393182e8602
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-24T19:23:07.378759  /lava-10443144/1/../bin/lava-test-case

    2023-05-24T19:23:07.397334  <8>[   69.824927] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/646e643a74be7393182e8602
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-24T19:23:07.378759  /lava-10443144/1/../bin/lava-test-case

    2023-05-24T19:23:07.397334  <8>[   69.824927] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/646e643a74be7393182e8604
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-24T19:23:06.268049  /lava-10443144/1/../bin/lava-test-case

    2023-05-24T19:23:06.286311  <8>[   68.714111] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e643a74be7393182e868c
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-24T19:22:47.143367  + set +x<8>[   49.574831] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10443144_1.5.2.3.1>

    2023-05-24T19:22:47.146367  =


    2023-05-24T19:22:47.254028  / # #

    2023-05-24T19:22:47.354633  export SHELL=3D/bin/sh

    2023-05-24T19:22:47.354836  #

    2023-05-24T19:22:47.455380  / # export SHELL=3D/bin/sh. /lava-10443144/=
environment

    2023-05-24T19:22:47.455628  =


    2023-05-24T19:22:47.556253  / # . /lava-10443144/environment/lava-10443=
144/bin/lava-test-runner /lava-10443144/1

    2023-05-24T19:22:47.556624  =


    2023-05-24T19:22:47.561557  / # /lava-10443144/bin/lava-test-runner /la=
va-10443144/1
 =

    ... (13 line(s) more)  =

 =20
