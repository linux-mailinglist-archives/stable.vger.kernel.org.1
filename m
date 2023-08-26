Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A38789934
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjHZVLk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 17:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjHZVLg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 17:11:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2FE1
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 14:11:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26f3e26e59cso1356443a91.0
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 14:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693084291; x=1693689091;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SxSBzxT7L7mubqupmppm1qb0LX2RtoKZ+NSEv/2GTqo=;
        b=QZiL+EtgLfIifg0sC2L729kJDookp4JniawPT7YlVlMYn5fXi5PJFhoJXmPdH1Xrtm
         YURqSypwF683vE9Quxgavhxwl+pyWQPQ9xpicNdAIuKPxd+Bas8q7DUB8hRT+NfXHiY8
         k/TVD77aqVuiDoas0WE+/Agpk/1N3wx0T84v77qs2gkY/aegCsSaZwPXk+KR/xpcX2eR
         DbKaXTrpoimkXIFVt7P6Q1jUoX/vU9l3oN5cPjbcrWQfW1quj0Y5l8ISVP7Iz/n7PPLl
         hSCTMuT9G7K8Xooto4ZJVdsChdtfOVl8H8CPxmmnB01i/X52QWHUsjTOHW2uHyvSbu5E
         ewyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693084291; x=1693689091;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxSBzxT7L7mubqupmppm1qb0LX2RtoKZ+NSEv/2GTqo=;
        b=SzCZ2B/mDdmBU5WU0lMdgMzcqF6vMk8RHpZ1EVBE7ZLGpS+bDQUsCr57l9ce9sMfUf
         w3skxRb3hwaqiQqp5aL4smCJEaKUEbvwkM80v9PSydLYeEHBwxml8GANmF8LVpJ/XTzf
         W00HjRl0REnhrb62hWtm62p4coGAlYVdDcfZUtUJ4rRaShnsAfKDlE6XXkyl7VdGuXkO
         yNN3RwYodRARUw/8794aFPx8VBu3A5TwbCOgNsOvqEEWlrX6Nf7glmSH2Myl7EolRcH4
         CWvJADi9EU9RAj7rKfd+gmXRgez0yvKUoqMTkfqIfdtNOdtbMqoKYmR7yO3ukyew1S3J
         9sfA==
X-Gm-Message-State: AOJu0YyW2m3s85DEEgmvrmZT8Jvk7/KHYyVpZlAZqiOG6WPPJlUngvgt
        TBogFf+nN5EJpwet8YKK86+qHsfW1kQN/MSQJo8=
X-Google-Smtp-Source: AGHT+IFM7rQZs8t80qgbdKlsoKNxsjeGMudV8Rb9ZfAIOOll8laLGQ4vVl4IfgbjlRbdVndSMYyCZA==
X-Received: by 2002:a17:90a:318e:b0:26d:5094:13ea with SMTP id j14-20020a17090a318e00b0026d509413eamr32801645pjb.0.1693084291399;
        Sat, 26 Aug 2023 14:11:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090abc8500b00268b439a0cbsm3861805pjr.23.2023.08.26.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 14:11:30 -0700 (PDT)
Message-ID: <64ea6a82.170a0220.b5a4c.53da@mx.google.com>
Date:   Sat, 26 Aug 2023 14:11:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.48-5-g1d91878df63ce
Subject: stable-rc/linux-6.1.y baseline: 125 runs,
 12 regressions (v6.1.48-5-g1d91878df63ce)
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

stable-rc/linux-6.1.y baseline: 125 runs, 12 regressions (v6.1.48-5-g1d9187=
8df63ce)

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

at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

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
el/v6.1.48-5-g1d91878df63ce/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.48-5-g1d91878df63ce
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1d91878df63ceab6316c7c84876abc7eec08a2e4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea385685a4696ea6286dec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ea385685a4696ea6286=
ded
        new failure (last pass: v6.1.48) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea383ed4fbf3babb286dca

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea383ed4fbf3babb286dcf
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T17:36:46.161240  <8>[   10.136584] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11364102_1.4.2.3.1>

    2023-08-26T17:36:46.164210  + set +x

    2023-08-26T17:36:46.268617  / # #

    2023-08-26T17:36:46.369317  export SHELL=3D/bin/sh

    2023-08-26T17:36:46.369531  #

    2023-08-26T17:36:46.470061  / # export SHELL=3D/bin/sh. /lava-11364102/=
environment

    2023-08-26T17:36:46.470240  =


    2023-08-26T17:36:46.570779  / # . /lava-11364102/environment/lava-11364=
102/bin/lava-test-runner /lava-11364102/1

    2023-08-26T17:36:46.571082  =


    2023-08-26T17:36:46.577247  / # /lava-11364102/bin/lava-test-runner /la=
va-11364102/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea3837fe654454bf286d9f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea3837fe654454bf286da4
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T17:36:37.678480  + <8>[   11.143092] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11364085_1.4.2.3.1>

    2023-08-26T17:36:37.678980  set +x

    2023-08-26T17:36:37.784838  / # #

    2023-08-26T17:36:37.887080  export SHELL=3D/bin/sh

    2023-08-26T17:36:37.887799  #

    2023-08-26T17:36:37.989180  / # export SHELL=3D/bin/sh. /lava-11364085/=
environment

    2023-08-26T17:36:37.989931  =


    2023-08-26T17:36:38.091393  / # . /lava-11364085/environment/lava-11364=
085/bin/lava-test-runner /lava-11364085/1

    2023-08-26T17:36:38.092548  =


    2023-08-26T17:36:38.097560  / # /lava-11364085/bin/lava-test-runner /la=
va-11364085/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea3839fe654454bf286dac

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea3839fe654454bf286db1
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T17:36:41.091934  <8>[    7.668904] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11364073_1.4.2.3.1>

    2023-08-26T17:36:41.095329  + set +x

    2023-08-26T17:36:41.201184  =


    2023-08-26T17:36:41.302972  / # #export SHELL=3D/bin/sh

    2023-08-26T17:36:41.303770  =


    2023-08-26T17:36:41.405200  / # export SHELL=3D/bin/sh. /lava-11364073/=
environment

    2023-08-26T17:36:41.405927  =


    2023-08-26T17:36:41.507508  / # . /lava-11364073/environment/lava-11364=
073/bin/lava-test-runner /lava-11364073/1

    2023-08-26T17:36:41.508867  =


    2023-08-26T17:36:41.514446  / # /lava-11364073/bin/lava-test-runner /la=
va-11364073/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea37ebd8ad26ff6e286d6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-s=
ama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-s=
ama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ea37ebd8ad26ff6e286=
d6e
        new failure (last pass: v6.1.46-195-g5165f4e9738c4) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea37e94b884e302b286d77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ea37e94b884e302b286=
d78
        failing since 79 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea38224b884e302b286d82

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea38224b884e302b286d87
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T17:36:37.374229  + set +x

    2023-08-26T17:36:37.380883  <8>[   10.435070] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11364105_1.4.2.3.1>

    2023-08-26T17:36:37.485137  / # #

    2023-08-26T17:36:37.585730  export SHELL=3D/bin/sh

    2023-08-26T17:36:37.585919  #

    2023-08-26T17:36:37.686430  / # export SHELL=3D/bin/sh. /lava-11364105/=
environment

    2023-08-26T17:36:37.686616  =


    2023-08-26T17:36:37.787142  / # . /lava-11364105/environment/lava-11364=
105/bin/lava-test-runner /lava-11364105/1

    2023-08-26T17:36:37.787465  =


    2023-08-26T17:36:37.792444  / # /lava-11364105/bin/lava-test-runner /la=
va-11364105/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea38394b047d9d31286d6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea38394b047d9d31286d73
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T17:36:39.520735  + set<8>[   10.969254] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11364072_1.4.2.3.1>

    2023-08-26T17:36:39.521314   +x

    2023-08-26T17:36:39.629480  / # #

    2023-08-26T17:36:39.731970  export SHELL=3D/bin/sh

    2023-08-26T17:36:39.732376  #

    2023-08-26T17:36:39.833708  / # export SHELL=3D/bin/sh. /lava-11364072/=
environment

    2023-08-26T17:36:39.834553  =


    2023-08-26T17:36:39.936337  / # . /lava-11364072/environment/lava-11364=
072/bin/lava-test-runner /lava-11364072/1

    2023-08-26T17:36:39.937790  =


    2023-08-26T17:36:39.942549  / # /lava-11364072/bin/lava-test-runner /la=
va-11364072/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea38273134160a22286e9c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea38273134160a22286ea1
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T17:36:24.446817  <8>[   12.125048] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11364104_1.4.2.3.1>

    2023-08-26T17:36:24.550279  / # #

    2023-08-26T17:36:24.650872  export SHELL=3D/bin/sh

    2023-08-26T17:36:24.651086  #

    2023-08-26T17:36:24.751588  / # export SHELL=3D/bin/sh. /lava-11364104/=
environment

    2023-08-26T17:36:24.751823  =


    2023-08-26T17:36:24.852386  / # . /lava-11364104/environment/lava-11364=
104/bin/lava-test-runner /lava-11364104/1

    2023-08-26T17:36:24.852662  =


    2023-08-26T17:36:24.857343  / # /lava-11364104/bin/lava-test-runner /la=
va-11364104/1

    2023-08-26T17:36:24.863729  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea36a8c4d100f151286d6c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea36a8c4d100f151286d71
        failing since 39 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-26T17:31:39.401473  / # #

    2023-08-26T17:31:39.503302  export SHELL=3D/bin/sh

    2023-08-26T17:31:39.504045  #

    2023-08-26T17:31:39.605333  / # export SHELL=3D/bin/sh. /lava-11363983/=
environment

    2023-08-26T17:31:39.606249  =


    2023-08-26T17:31:39.707721  / # . /lava-11363983/environment/lava-11363=
983/bin/lava-test-runner /lava-11363983/1

    2023-08-26T17:31:39.708663  =


    2023-08-26T17:31:39.709831  / # /lava-11363983/bin/lava-test-runner /la=
va-11363983/1

    2023-08-26T17:31:39.773574  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T17:31:39.774103  + cd /lav<8>[   19.091163] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11363983_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea36bff9d092fe15286da3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea36bff9d092fe15286da8
        failing since 39 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-26T17:30:35.595350  / # #

    2023-08-26T17:30:36.674744  export SHELL=3D/bin/sh

    2023-08-26T17:30:36.676493  #

    2023-08-26T17:30:38.165687  / # export SHELL=3D/bin/sh. /lava-11363977/=
environment

    2023-08-26T17:30:38.167539  =


    2023-08-26T17:30:40.890447  / # . /lava-11363977/environment/lava-11363=
977/bin/lava-test-runner /lava-11363977/1

    2023-08-26T17:30:40.891809  =


    2023-08-26T17:30:40.901498  / # /lava-11363977/bin/lava-test-runner /la=
va-11363977/1

    2023-08-26T17:30:40.961007  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T17:30:40.961282  + cd /lava-113639<8>[   28.466973] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11363977_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea36bef9d092fe15286d8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
5-g1d91878df63ce/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea36bef9d092fe15286d92
        failing since 39 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-26T17:31:53.898674  / # #

    2023-08-26T17:31:53.999406  export SHELL=3D/bin/sh

    2023-08-26T17:31:53.999685  #

    2023-08-26T17:31:54.100446  / # export SHELL=3D/bin/sh. /lava-11363978/=
environment

    2023-08-26T17:31:54.101127  =


    2023-08-26T17:31:54.202546  / # . /lava-11363978/environment/lava-11363=
978/bin/lava-test-runner /lava-11363978/1

    2023-08-26T17:31:54.203733  =


    2023-08-26T17:31:54.212365  / # /lava-11363978/bin/lava-test-runner /la=
va-11363978/1

    2023-08-26T17:31:54.284526  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T17:31:54.285086  + cd /lava-1136397<8>[   18.705015] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11363978_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
