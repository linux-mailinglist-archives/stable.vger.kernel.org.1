Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578E778B0AB
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjH1Mj1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 08:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjH1MjD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 08:39:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8673CE5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 05:38:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68730bafa6bso2719465b3a.1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693226338; x=1693831138;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K2PC2JqRY4QAzXpaPjzcjibcVKTbT/fS+QeQSia1VRI=;
        b=d4a7dBSKgrGNPIG9dRbXUAiOn20F9M53M6zyqbN+4U6F5485iLNNd1cRVHg5jDn9Vj
         Hv7q2mp8KG26SpfTHiIJVOn0KXOfPm5LeeOlbtYAEhH51/DBYUeaxi/jCdQ278GwLhCe
         IZFWrktRsGxYk/I4nOk0LQG0x+59Yw58SZ6buVVeBwi4DUrX7F6HlEm935Qa2l90LGtf
         MnKIvEKO8fPDZH+g250g119rzP7/TmpuNuhNwaAKO9KKNKCfkaWaVDR4el49Ab/j91qs
         yaIIJDQL8AWmvGUVztIN9/oRo0lrZbnTKnBuHDLwcvIbP2iGJEXju8CGcVn+5RJB1G73
         3yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693226338; x=1693831138;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2PC2JqRY4QAzXpaPjzcjibcVKTbT/fS+QeQSia1VRI=;
        b=jM6lh5uYwmgCid1OW0LyXGiS1BhGlSGbMxic1C9EkeTxUVgaZ/MMuFfUQ0xWBfmDiC
         YKLFdBOSA+PQbvGgbViN4PmwuSny9PUb6ohcV6EYougG1xw6x7zEFtgn9xa+K0AMUL6A
         9tw7dSLmoimzI1+OfLZOBp2sdAa+rQmu7KX3le2x1EnEFW81MnAljA2jDyzyXyB9AZm0
         iVkerZneznJThTTozXVmOPe8eFr8MXT8fLan3/UoTTSYSo4p3EPuwlE9WAY5hcqizRm3
         If52rPxh2O1eQcoWuasisBUSEim0Qut2nFlD5B0HDmxPK4jsC9gwTGZO+O1f5Zez9QS6
         m60w==
X-Gm-Message-State: AOJu0YyeLPDYG6ebaubqmcy3/SdCjDb1l1V7gFlK/6XQVmHo0U42V5+6
        hRABZSI3FQcKSUDz79xdHQGEC2ZlEpN63htwgTw=
X-Google-Smtp-Source: AGHT+IFugawMWP5Tb+obB/VPihv18gY6Y35YDo4KNqtPxwEwZrTCI1pM6h888LSAojYcSI0KJPkM9Q==
X-Received: by 2002:a05:6a20:394e:b0:149:6909:4eac with SMTP id r14-20020a056a20394e00b0014969094eacmr31495939pzg.22.1693226338281;
        Mon, 28 Aug 2023 05:38:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c6-20020a62e806000000b00682c1db7551sm6544044pfi.49.2023.08.28.05.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 05:38:57 -0700 (PDT)
Message-ID: <64ec9561.620a0220.a480b.9eaf@mx.google.com>
Date:   Mon, 28 Aug 2023 05:38:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.128-91-g59406ae6f227c
Subject: stable-rc/linux-5.15.y baseline: 124 runs,
 11 regressions (v5.15.128-91-g59406ae6f227c)
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

stable-rc/linux-5.15.y baseline: 124 runs, 11 regressions (v5.15.128-91-g59=
406ae6f227c)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.128-91-g59406ae6f227c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.128-91-g59406ae6f227c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      59406ae6f227c88a91c47b05e1aca4fc8bb4dd45 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec61b288bcbf049d286d9a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec61b288bcbf049d286da3
        failing since 152 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-28T08:59:16.081906  <8>[   10.414534] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11370892_1.4.2.3.1>

    2023-08-28T08:59:16.085129  + set +x

    2023-08-28T08:59:16.189435  / # #

    2023-08-28T08:59:16.290181  export SHELL=3D/bin/sh

    2023-08-28T08:59:16.290403  #

    2023-08-28T08:59:16.390906  / # export SHELL=3D/bin/sh. /lava-11370892/=
environment

    2023-08-28T08:59:16.391127  =


    2023-08-28T08:59:16.491668  / # . /lava-11370892/environment/lava-11370=
892/bin/lava-test-runner /lava-11370892/1

    2023-08-28T08:59:16.491945  =


    2023-08-28T08:59:16.497877  / # /lava-11370892/bin/lava-test-runner /la=
va-11370892/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec61b750a37f71d9286dc7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec61b750a37f71d9286dd0
        failing since 152 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-28T08:58:08.644291  <8>[   10.621691] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11370923_1.4.2.3.1>

    2023-08-28T08:58:08.647584  + set +x

    2023-08-28T08:58:08.752858  #

    2023-08-28T08:58:08.754015  =


    2023-08-28T08:58:08.855811  / # #export SHELL=3D/bin/sh

    2023-08-28T08:58:08.856568  =


    2023-08-28T08:58:08.958080  / # export SHELL=3D/bin/sh. /lava-11370923/=
environment

    2023-08-28T08:58:08.958998  =


    2023-08-28T08:58:09.060613  / # . /lava-11370923/environment/lava-11370=
923/bin/lava-test-runner /lava-11370923/1

    2023-08-28T08:58:09.061943  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec659abd29c3793d286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ec659abd29c3793d286=
d6d
        failing since 33 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec64e46e12f50169286daf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec64e46e12f50169286db8
        failing since 223 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-28T09:11:41.279231  <8>[    9.984599] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3753609_1.5.2.4.1>
    2023-08-28T09:11:41.388685  / # #
    2023-08-28T09:11:41.492234  export SHELL=3D/bin/sh
    2023-08-28T09:11:41.493333  #
    2023-08-28T09:11:41.595627  / # export SHELL=3D/bin/sh. /lava-3753609/e=
nvironment
    2023-08-28T09:11:41.596783  =

    2023-08-28T09:11:41.698884  / # . /lava-3753609/environment/lava-375360=
9/bin/lava-test-runner /lava-3753609/1
    2023-08-28T09:11:41.700701  =

    2023-08-28T09:11:41.705552  / # /lava-3753609/bin/lava-test-runner /lav=
a-3753609/1
    2023-08-28T09:11:41.799423  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec63800a2080d057286db1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec63800a2080d057286db4
        failing since 177 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-28T09:05:43.139778  [   10.611130] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247130_1.5.2.4.1>
    2023-08-28T09:05:43.244987  =

    2023-08-28T09:05:43.346252  / # #export SHELL=3D/bin/sh
    2023-08-28T09:05:43.346666  =

    2023-08-28T09:05:43.447636  / # export SHELL=3D/bin/sh. /lava-1247130/e=
nvironment
    2023-08-28T09:05:43.448068  =

    2023-08-28T09:05:43.549045  / # . /lava-1247130/environment/lava-124713=
0/bin/lava-test-runner /lava-1247130/1
    2023-08-28T09:05:43.549717  =

    2023-08-28T09:05:43.552693  / # /lava-1247130/bin/lava-test-runner /lav=
a-1247130/1
    2023-08-28T09:05:43.569269  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec619e1d9a639235286d7c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec619e1d9a639235286d85
        failing since 152 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-28T08:57:54.930233  <8>[   10.110246] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11370889_1.4.2.3.1>

    2023-08-28T08:57:54.933626  + set +x

    2023-08-28T08:57:55.038406  #

    2023-08-28T08:57:55.140941  / # #export SHELL=3D/bin/sh

    2023-08-28T08:57:55.141710  =


    2023-08-28T08:57:55.243296  / # export SHELL=3D/bin/sh. /lava-11370889/=
environment

    2023-08-28T08:57:55.244106  =


    2023-08-28T08:57:55.345790  / # . /lava-11370889/environment/lava-11370=
889/bin/lava-test-runner /lava-11370889/1

    2023-08-28T08:57:55.347090  =


    2023-08-28T08:57:55.352131  / # /lava-11370889/bin/lava-test-runner /la=
va-11370889/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec61b3aa67775518286d86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec61b3aa67775518286d8f
        failing since 152 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-28T08:58:18.248313  + <8>[   11.682912] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11370905_1.4.2.3.1>

    2023-08-28T08:58:18.248399  set +x

    2023-08-28T08:58:18.352856  / # #

    2023-08-28T08:58:18.453417  export SHELL=3D/bin/sh

    2023-08-28T08:58:18.453608  #

    2023-08-28T08:58:18.554136  / # export SHELL=3D/bin/sh. /lava-11370905/=
environment

    2023-08-28T08:58:18.554319  =


    2023-08-28T08:58:18.654808  / # . /lava-11370905/environment/lava-11370=
905/bin/lava-test-runner /lava-11370905/1

    2023-08-28T08:58:18.655122  =


    2023-08-28T08:58:18.659784  / # /lava-11370905/bin/lava-test-runner /la=
va-11370905/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec61a203fc83fe4b286d72

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec61a203fc83fe4b286d77
        failing since 152 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-28T08:57:55.460031  + set<8>[   11.474750] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11370887_1.4.2.3.1>

    2023-08-28T08:57:55.460115   +x

    2023-08-28T08:57:55.564136  / # #

    2023-08-28T08:57:55.664892  export SHELL=3D/bin/sh

    2023-08-28T08:57:55.665095  #

    2023-08-28T08:57:55.765587  / # export SHELL=3D/bin/sh. /lava-11370887/=
environment

    2023-08-28T08:57:55.765776  =


    2023-08-28T08:57:55.866273  / # . /lava-11370887/environment/lava-11370=
887/bin/lava-test-runner /lava-11370887/1

    2023-08-28T08:57:55.866559  =


    2023-08-28T08:57:55.871105  / # /lava-11370887/bin/lava-test-runner /la=
va-11370887/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec95452c36f57242286d70

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec95452c36f57242286d79
        failing since 39 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-28T12:39:44.702539  / # #

    2023-08-28T12:39:44.804674  export SHELL=3D/bin/sh

    2023-08-28T12:39:44.805412  #

    2023-08-28T12:39:44.906784  / # export SHELL=3D/bin/sh. /lava-11371023/=
environment

    2023-08-28T12:39:44.907488  =


    2023-08-28T12:39:45.008974  / # . /lava-11371023/environment/lava-11371=
023/bin/lava-test-runner /lava-11371023/1

    2023-08-28T12:39:45.010079  =


    2023-08-28T12:39:45.026402  / # /lava-11371023/bin/lava-test-runner /la=
va-11371023/1

    2023-08-28T12:39:45.075686  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T12:39:45.076193  + cd /lav<8>[   15.989061] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11371023_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec63252a35bdd3f2286daa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec63252a35bdd3f2286db3
        failing since 39 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-28T09:04:32.684776  / # #

    2023-08-28T09:04:33.764354  export SHELL=3D/bin/sh

    2023-08-28T09:04:33.766286  #

    2023-08-28T09:04:35.257127  / # export SHELL=3D/bin/sh. /lava-11371021/=
environment

    2023-08-28T09:04:35.259081  =


    2023-08-28T09:04:37.983567  / # . /lava-11371021/environment/lava-11371=
021/bin/lava-test-runner /lava-11371021/1

    2023-08-28T09:04:37.985885  =


    2023-08-28T09:04:37.992054  / # /lava-11371021/bin/lava-test-runner /la=
va-11371021/1

    2023-08-28T09:04:38.055707  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T09:04:38.056280  + cd /lava-113710<8>[   25.510025] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11371021_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec631b7865808273286db9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-91-g59406ae6f227c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec631b7865808273286dc2
        failing since 39 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-28T09:05:53.360620  / # #

    2023-08-28T09:05:53.461142  export SHELL=3D/bin/sh

    2023-08-28T09:05:53.461245  #

    2023-08-28T09:05:53.561747  / # export SHELL=3D/bin/sh. /lava-11371027/=
environment

    2023-08-28T09:05:53.561851  =


    2023-08-28T09:05:53.662341  / # . /lava-11371027/environment/lava-11371=
027/bin/lava-test-runner /lava-11371027/1

    2023-08-28T09:05:53.662543  =


    2023-08-28T09:05:53.674313  / # /lava-11371027/bin/lava-test-runner /la=
va-11371027/1

    2023-08-28T09:05:53.734247  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T09:05:53.734323  + cd /lava-1137102<8>[   16.761996] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11371027_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
