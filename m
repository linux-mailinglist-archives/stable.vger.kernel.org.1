Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438A47861F7
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 23:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjHWVLB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 17:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237039AbjHWVKw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 17:10:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5CA10C8
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 14:10:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68bec4c6b22so257900b3a.2
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692825049; x=1693429849;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKHK3Lykym40gg3elkEsxWDi2gh3z/W7+cZCAuJsnk=;
        b=pOcp0hP8xbERlKolw4hJuY3DZH4+wE0VFtWRzb54Gv7jqNpttqgbEajYW4s/X+gT16
         kwmf1w+lztzqyiOQ/X6fNBxVEI6mktb8t9ccxPhAy2oRjiZV0Na1DxvFX7a4jQM1so/k
         IcJJB9AfGFBA2k4PHSoj0u3zX23dpiN/pe06QLNIjnQjnF2ZdjCy4+KNzKDv1a1Fx5DA
         tswQe/Wt8Vs6DGN1q2/9gD8nwgCjhq0wmuuRzhYkhycORrTV98Yvo4GehVSNJg5s5VdI
         vQ+rBGjO+xf9YmNqUslbeMCzODL0v7t8L1rEaSClIpQ0PMHT4JygFjqbE7N/a65Nspgq
         D38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825049; x=1693429849;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddKHK3Lykym40gg3elkEsxWDi2gh3z/W7+cZCAuJsnk=;
        b=MHb+1TEGkwP61vLotYceJU14uC7zG2V/9Lh1PKnHm00RMQQjU7cdGVXR3onM/GXkK5
         FMvoEWTNN+MeeNpiBbMr+X8z6O+fpg+Kfp2MLNR0ut/S6YJinVYTBVW9w9xUnMPOF7Gj
         c+VLRuoSmQtCgbOUmHxhrDOrUYWG6RpT9RyK+A1llQcIX1/dHX9huhtSWofkLYgnmZ6E
         KMcsQxwk0OAJxVx3Y1s+kLH7QbXrMdlkaTRYsO+4DQS+XEp+PtOka2TtvVMuf/nuVjbo
         8lWhrFTwPOGxSst7lADiVh9WRBSXTXzFNmL3KoIAnpv/n7gUbDXNCHYkvKw5k4v+nTNR
         6hpw==
X-Gm-Message-State: AOJu0YyRlmA+CCIF3yg3jHs5LXnATHGRqXwGFGP+ZMFEvGeA+elQhqXc
        GeLYTNkW3/Ik+ql+s9WFb5CWlwjwXZH4KUmv/4I=
X-Google-Smtp-Source: AGHT+IGqI8FXWqFNBb+mt30ka0BbEGDEusocwZtpi45jaAbeNHVb/aVPHZwxCkt8Po0zpC6hMlD7Iw==
X-Received: by 2002:a05:6a20:f39d:b0:131:c760:2a0b with SMTP id qr29-20020a056a20f39d00b00131c7602a0bmr14266305pzb.52.1692825048699;
        Wed, 23 Aug 2023 14:10:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902c1c900b001bdc208ab82sm6690186plc.97.2023.08.23.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:10:48 -0700 (PDT)
Message-ID: <64e675d8.170a0220.f18fd.eccd@mx.google.com>
Date:   Wed, 23 Aug 2023 14:10:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.47
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 126 runs, 11 regressions (v6.1.47)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 126 runs, 11 regressions (v6.1.47)

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
el/v6.1.47/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.47
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      802aacbbffe2512dce9f8f33ad99d01cfec435de =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e640122ff25f0a00b1e3af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e640122ff25f0a00b1e=
3b0
        failing since 9 days (last pass: v6.1.45-128-ge73191cf0a0b2, first =
fail: v6.1.45-150-gdbb92b2240ba) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e63f1c2f1e825aebb1e3af

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e63f1c2f1e825aebb1e3b4
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T17:17:03.134357  <8>[   10.740018] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11338097_1.4.2.3.1>

    2023-08-23T17:17:03.137272  + set +x

    2023-08-23T17:17:03.241812  / # #

    2023-08-23T17:17:03.342656  export SHELL=3D/bin/sh

    2023-08-23T17:17:03.342933  #

    2023-08-23T17:17:03.443537  / # export SHELL=3D/bin/sh. /lava-11338097/=
environment

    2023-08-23T17:17:03.443740  =


    2023-08-23T17:17:03.544292  / # . /lava-11338097/environment/lava-11338=
097/bin/lava-test-runner /lava-11338097/1

    2023-08-23T17:17:03.544636  =


    2023-08-23T17:17:03.549899  / # /lava-11338097/bin/lava-test-runner /la=
va-11338097/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e63f4ad7bfbcb810b1e41f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e63f4ad7bfbcb810b1e424
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T17:17:45.197611  + set<8>[   11.172855] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11338125_1.4.2.3.1>

    2023-08-23T17:17:45.198184   +x

    2023-08-23T17:17:45.305945  / # #

    2023-08-23T17:17:45.408421  export SHELL=3D/bin/sh

    2023-08-23T17:17:45.409497  #

    2023-08-23T17:17:45.511520  / # export SHELL=3D/bin/sh. /lava-11338125/=
environment

    2023-08-23T17:17:45.512311  =


    2023-08-23T17:17:45.614125  / # . /lava-11338125/environment/lava-11338=
125/bin/lava-test-runner /lava-11338125/1

    2023-08-23T17:17:45.615399  =


    2023-08-23T17:17:45.620638  / # /lava-11338125/bin/lava-test-runner /la=
va-11338125/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e63f173ca4e4e513b1e3d8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e63f173ca4e4e513b1e3dd
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T17:16:55.547077  <8>[   10.882761] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11338136_1.4.2.3.1>

    2023-08-23T17:16:55.550650  + set +x

    2023-08-23T17:16:55.655813  #

    2023-08-23T17:16:55.758419  / # #export SHELL=3D/bin/sh

    2023-08-23T17:16:55.759055  =


    2023-08-23T17:16:55.860321  / # export SHELL=3D/bin/sh. /lava-11338136/=
environment

    2023-08-23T17:16:55.860968  =


    2023-08-23T17:16:55.962310  / # . /lava-11338136/environment/lava-11338=
136/bin/lava-test-runner /lava-11338136/1

    2023-08-23T17:16:55.963449  =


    2023-08-23T17:16:55.968787  / # /lava-11338136/bin/lava-test-runner /la=
va-11338136/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e6432d158711637cb1e3c1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e6432d158711637cb1e=
3c2
        failing since 76 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e63fb23fadd62041b1e3c1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e63fb23fadd62041b1e3c6
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T17:19:44.790566  + set +x

    2023-08-23T17:19:44.797358  <8>[   10.567020] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11338116_1.4.2.3.1>

    2023-08-23T17:19:44.904809  / # #

    2023-08-23T17:19:45.006791  export SHELL=3D/bin/sh

    2023-08-23T17:19:45.007494  #

    2023-08-23T17:19:45.108938  / # export SHELL=3D/bin/sh. /lava-11338116/=
environment

    2023-08-23T17:19:45.109682  =


    2023-08-23T17:19:45.211220  / # . /lava-11338116/environment/lava-11338=
116/bin/lava-test-runner /lava-11338116/1

    2023-08-23T17:19:45.212359  =


    2023-08-23T17:19:45.217105  / # /lava-11338116/bin/lava-test-runner /la=
va-11338116/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e63f39d7bfbcb810b1e3f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e63f39d7bfbcb810b1e3f5
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T17:17:16.942086  + <8>[   19.126704] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11338111_1.4.2.3.1>

    2023-08-23T17:17:16.942222  set +x

    2023-08-23T17:17:17.047187  / # #

    2023-08-23T17:17:17.147924  export SHELL=3D/bin/sh

    2023-08-23T17:17:18.173619  #

    2023-08-23T17:17:18.173887  / # export SHELL=3D/bin/sh

    2023-08-23T17:17:18.274585  / # . /lava-11338111/environment

    2023-08-23T17:17:18.375245  /lava-11338111/bin/lava-test-runner /lava-1=
1338111/1

    2023-08-23T17:17:18.377919  . /lava-11338111/environment

    2023-08-23T17:17:18.381264  / # /lava-11338111/bin/lava-test-runner /la=
va-11338111/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e63f1f3ca4e4e513b1e3e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e63f1f3ca4e4e513b1e3ed
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T17:17:00.005148  + set<8>[   11.318931] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11338129_1.4.2.3.1>

    2023-08-23T17:17:00.005235   +x

    2023-08-23T17:17:00.109684  / # #

    2023-08-23T17:17:00.210382  export SHELL=3D/bin/sh

    2023-08-23T17:17:00.210642  #

    2023-08-23T17:17:00.311237  / # export SHELL=3D/bin/sh. /lava-11338129/=
environment

    2023-08-23T17:17:00.311478  =


    2023-08-23T17:17:00.411999  / # . /lava-11338129/environment/lava-11338=
129/bin/lava-test-runner /lava-11338129/1

    2023-08-23T17:17:00.412340  =


    2023-08-23T17:17:00.417064  / # /lava-11338129/bin/lava-test-runner /la=
va-11338129/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e6408ab766f1dcb2b1e49a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e6408ab766f1dcb2b1e49f
        failing since 36 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-23T17:24:40.366300  / # #

    2023-08-23T17:24:40.468354  export SHELL=3D/bin/sh

    2023-08-23T17:24:40.469081  #

    2023-08-23T17:24:40.570549  / # export SHELL=3D/bin/sh. /lava-11338155/=
environment

    2023-08-23T17:24:40.571258  =


    2023-08-23T17:24:40.672755  / # . /lava-11338155/environment/lava-11338=
155/bin/lava-test-runner /lava-11338155/1

    2023-08-23T17:24:40.674003  =


    2023-08-23T17:24:40.690178  / # /lava-11338155/bin/lava-test-runner /la=
va-11338155/1

    2023-08-23T17:24:40.738978  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T17:24:40.739476  + cd /lava-113381<8>[   19.054346] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11338155_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e64098e94cc5d611b1e415

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e64098e94cc5d611b1e41a
        failing since 36 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-23T17:24:36.660458  / # #

    2023-08-23T17:24:37.739342  export SHELL=3D/bin/sh

    2023-08-23T17:24:37.741158  #

    2023-08-23T17:24:39.226557  / # export SHELL=3D/bin/sh. /lava-11338160/=
environment

    2023-08-23T17:24:39.228369  =


    2023-08-23T17:24:41.952916  / # . /lava-11338160/environment/lava-11338=
160/bin/lava-test-runner /lava-11338160/1

    2023-08-23T17:24:41.955259  =


    2023-08-23T17:24:41.968172  / # /lava-11338160/bin/lava-test-runner /la=
va-11338160/1

    2023-08-23T17:24:41.984181  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T17:24:42.027223  + cd /lava-113381<8>[   28.499491] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11338160_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e6408c1e27e3be67b1e3c3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e6408c1e27e3be67b1e3c8
        failing since 36 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-23T17:24:56.219024  / # #

    2023-08-23T17:24:56.321134  export SHELL=3D/bin/sh

    2023-08-23T17:24:56.321839  #

    2023-08-23T17:24:56.423238  / # export SHELL=3D/bin/sh. /lava-11338157/=
environment

    2023-08-23T17:24:56.423941  =


    2023-08-23T17:24:56.525362  / # . /lava-11338157/environment/lava-11338=
157/bin/lava-test-runner /lava-11338157/1

    2023-08-23T17:24:56.526440  =


    2023-08-23T17:24:56.543260  / # /lava-11338157/bin/lava-test-runner /la=
va-11338157/1

    2023-08-23T17:24:56.608206  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T17:24:56.608720  + cd /lava-1133815<8>[   18.619695] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11338157_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
