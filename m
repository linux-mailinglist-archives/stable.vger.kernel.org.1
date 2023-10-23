Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E27D28A9
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 04:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjJWCn2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 22:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjJWCn2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 22:43:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D86BDB
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 19:43:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ca052ec63bso23713725ad.1
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 19:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698029004; x=1698633804; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk7Fr1Yga8NE/of9EMhxJSfqBRfzD381fM8nt2teVhw=;
        b=dbEq4/in7nJPKDDoQgcDkUL4N6+feGVVKSCHOLrg/r4ibfa/c8WAUcN+sTsdWE2/Cp
         FR2cpFE21UMdLSOoqPT32QYryjwZkHFD7PlaL0FN4uEjK1mAaKaJbKLAGl5joUTbQke9
         xlBA0QD4Zai7KJazf1wgK4CA+ViHL4p5otxkuN66whWbox0nSi+IJMomS1GUcEok5Z++
         Eok+AfpeClKzd27RQ9a9+yN/b8014+A/vGLj/JduZ1cig1VYYpChFT9In2iMCxG7I0au
         WuNg1ODT+JZUSCNIEGkDyjvx5AHieqeT+pXKhWJJ2lnjjLBIOT8Y1LCSNdqbD1o3IbEh
         ksqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698029004; x=1698633804;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qk7Fr1Yga8NE/of9EMhxJSfqBRfzD381fM8nt2teVhw=;
        b=evY2ikLNMDeqvl++DUCCv8lG/cUOH0qDufprPbx+N91ViM08SzazWvXQ9e4p6LltB9
         XMH2zZONlYaHyOqZosm7LBx9le1FZJjNfxv/DBbScCinqaxBsO3uyOAGry26dSvrfQaM
         ef21MiGJspivqGfr6j2zxvSrVSNaHgW3/PZnD0otpq6F0G60yebd5u2i5wc2GpzfV3k0
         wYlJSewf76li6pXPpu9BqPtAlnmCEH0BT8kPyrpjjGM95cEfdtOizEUzuFcD5B61DaOh
         OjoaIvLvBWvptNlwUyHpsd5xFhYHZ388K/E7GTJGyz9fKcOInMiHv1Tvf6HH2qC+3LOp
         IQjQ==
X-Gm-Message-State: AOJu0YwGOokb+sJPi4TPgmvDo3DPF970KOOg0gfe1KfuDHdzaNVFt5RA
        Nme60weJ+hFKcEK49JhFuK9W9xm2lTSyjpU0SOeq/A==
X-Google-Smtp-Source: AGHT+IFDX07ZTOWiejM1vKFHAajqVNyVUr+A+98niMRZ/DO0N4HJT4tiwz6feTCYvKe+NJzLTTc/fQ==
X-Received: by 2002:a17:903:74d:b0:1ca:3d9c:a748 with SMTP id kl13-20020a170903074d00b001ca3d9ca748mr7283697plb.36.1698029004199;
        Sun, 22 Oct 2023 19:43:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001b7cbc5871csm4990076plf.53.2023.10.22.19.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 19:43:23 -0700 (PDT)
Message-ID: <6535ddcb.170a0220.45ca2.ef25@mx.google.com>
Date:   Sun, 22 Oct 2023 19:43:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.135-238-g07ec13925385
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 108 runs,
 10 regressions (v5.15.135-238-g07ec13925385)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 108 runs, 10 regressions (v5.15.135-238-g0=
7ec13925385)

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

sun50i-h6-pine-h64        | arm64  | lab-clabbe    | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.135-238-g07ec13925385/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.135-238-g07ec13925385
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      07ec1392538558957c4a37a8a5428190020c8f50 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535aae8e42c4fd624efcf48

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535aae8e42c4fd624efcf51
        failing since 208 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-22T23:06:13.697034  <8>[   10.238992] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11848303_1.4.2.3.1>

    2023-10-22T23:06:13.700299  + set +x

    2023-10-22T23:06:13.801629  #

    2023-10-22T23:06:13.902523  / # #export SHELL=3D/bin/sh

    2023-10-22T23:06:13.902714  =


    2023-10-22T23:06:14.003255  / # export SHELL=3D/bin/sh. /lava-11848303/=
environment

    2023-10-22T23:06:14.003433  =


    2023-10-22T23:06:14.104080  / # . /lava-11848303/environment/lava-11848=
303/bin/lava-test-runner /lava-11848303/1

    2023-10-22T23:06:14.104348  =


    2023-10-22T23:06:14.109844  / # /lava-11848303/bin/lava-test-runner /la=
va-11848303/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535aaece42c4fd624efcf5e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535aaece42c4fd624efcf67
        failing since 208 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-22T23:05:55.980360  <8>[   11.431988] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11848334_1.4.2.3.1>

    2023-10-22T23:05:55.983756  + set +x

    2023-10-22T23:05:56.089347  =


    2023-10-22T23:05:56.191210  / # #export SHELL=3D/bin/sh

    2023-10-22T23:05:56.191933  =


    2023-10-22T23:05:56.293333  / # export SHELL=3D/bin/sh. /lava-11848334/=
environment

    2023-10-22T23:05:56.293598  =


    2023-10-22T23:05:56.394715  / # . /lava-11848334/environment/lava-11848=
334/bin/lava-test-runner /lava-11848334/1

    2023-10-22T23:05:56.395842  =


    2023-10-22T23:05:56.401616  / # /lava-11848334/bin/lava-test-runner /la=
va-11848334/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6535ac4399fe8e397aefcf0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6535ac4399fe8e397aefc=
f0f
        failing since 6 days (last pass: v5.15.133, first fail: v5.15.135-1=
03-gf11fc66f963f) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535aac1f4e6c4507cefceff

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535aac1f4e6c4507cefcf08
        failing since 208 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-22T23:05:38.528304  + set +x

    2023-10-22T23:05:38.534957  <8>[   10.728254] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11848310_1.4.2.3.1>

    2023-10-22T23:05:38.636553  #

    2023-10-22T23:05:38.636773  =


    2023-10-22T23:05:38.737407  / # #export SHELL=3D/bin/sh

    2023-10-22T23:05:38.737594  =


    2023-10-22T23:05:38.838164  / # export SHELL=3D/bin/sh. /lava-11848310/=
environment

    2023-10-22T23:05:38.838373  =


    2023-10-22T23:05:38.938936  / # . /lava-11848310/environment/lava-11848=
310/bin/lava-test-runner /lava-11848310/1

    2023-10-22T23:05:38.939184  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535aac8bde5c1cb02efcef6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535aac8bde5c1cb02efceff
        failing since 208 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-22T23:05:38.340280  + set<8>[   11.303065] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11848282_1.4.2.3.1>

    2023-10-22T23:05:38.340358   +x

    2023-10-22T23:05:38.444482  / # #

    2023-10-22T23:05:38.545022  export SHELL=3D/bin/sh

    2023-10-22T23:05:38.545203  #

    2023-10-22T23:05:38.645771  / # export SHELL=3D/bin/sh. /lava-11848282/=
environment

    2023-10-22T23:05:38.645947  =


    2023-10-22T23:05:38.746430  / # . /lava-11848282/environment/lava-11848=
282/bin/lava-test-runner /lava-11848282/1

    2023-10-22T23:05:38.746777  =


    2023-10-22T23:05:38.751523  / # /lava-11848282/bin/lava-test-runner /la=
va-11848282/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6535aad5f4e6c4507cefcf47

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535aad5f4e6c4507cefcf50
        failing since 208 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-22T23:05:34.912893  <8>[   11.646172] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11848322_1.4.2.3.1>

    2023-10-22T23:05:35.017699  / # #

    2023-10-22T23:05:35.119284  export SHELL=3D/bin/sh

    2023-10-22T23:05:35.119789  #

    2023-10-22T23:05:35.221134  / # export SHELL=3D/bin/sh. /lava-11848322/=
environment

    2023-10-22T23:05:35.221771  =


    2023-10-22T23:05:35.323299  / # . /lava-11848322/environment/lava-11848=
322/bin/lava-test-runner /lava-11848322/1

    2023-10-22T23:05:35.324164  =


    2023-10-22T23:05:35.329092  / # /lava-11848322/bin/lava-test-runner /la=
va-11848322/1

    2023-10-22T23:05:35.334605  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6535ac620d35fdb28cefcef3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535ac620d35fdb28cefcefc
        failing since 95 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-22T23:16:30.060969  / # #

    2023-10-22T23:16:30.163027  export SHELL=3D/bin/sh

    2023-10-22T23:16:30.163762  #

    2023-10-22T23:16:30.265080  / # export SHELL=3D/bin/sh. /lava-11848372/=
environment

    2023-10-22T23:16:30.265339  =


    2023-10-22T23:16:30.366159  / # . /lava-11848372/environment/lava-11848=
372/bin/lava-test-runner /lava-11848372/1

    2023-10-22T23:16:30.367253  =


    2023-10-22T23:16:30.369556  / # /lava-11848372/bin/lava-test-runner /la=
va-11848372/1

    2023-10-22T23:16:30.433061  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-22T23:16:30.433567  + cd /lav<8>[   16.002704] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11848372_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6535ac81d0849f8c5cefcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535ac81d0849f8c5cefcefc
        failing since 95 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-22T23:15:29.360480  / # #

    2023-10-22T23:15:30.440335  export SHELL=3D/bin/sh

    2023-10-22T23:15:30.442110  #

    2023-10-22T23:15:31.932446  / # export SHELL=3D/bin/sh. /lava-11848373/=
environment

    2023-10-22T23:15:31.934181  =


    2023-10-22T23:15:34.655315  / # . /lava-11848373/environment/lava-11848=
373/bin/lava-test-runner /lava-11848373/1

    2023-10-22T23:15:34.656686  =


    2023-10-22T23:15:34.668665  / # /lava-11848373/bin/lava-test-runner /la=
va-11848373/1

    2023-10-22T23:15:34.727747  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-22T23:15:34.727821  + cd /lava-11848373/1/tes<8>[   25.510522] =
<LAVA_SIGNAL_STARTRUN 1_bootrr 11848373_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-clabbe    | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6535ac61a7bf9e247aefd06b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535ac61a7bf9e247aefd074
        failing since 12 days (last pass: v5.15.105-194-g415a9d81c640, firs=
t fail: v5.15.135)

    2023-10-22T23:12:11.186022  / # #
    2023-10-22T23:12:11.288024  export SHELL=3D/bin/sh
    2023-10-22T23:12:11.288785  #
    2023-10-22T23:12:11.389990  / # export SHELL=3D/bin/sh. /lava-439840/en=
vironment
    2023-10-22T23:12:11.390755  =

    2023-10-22T23:12:11.491971  / # . /lava-439840/environment/lava-439840/=
bin/lava-test-runner /lava-439840/1
    2023-10-22T23:12:11.492991  =

    2023-10-22T23:12:11.510690  / # /lava-439840/bin/lava-test-runner /lava=
-439840/1
    2023-10-22T23:12:11.568085  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-22T23:12:11.568527  + cd /lava-439840/<8>[   16.564863] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 439840_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6535ac61a7bf9e247aefd076

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-238-g07ec13925385/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6535ac61a7bf9e247aefd07f
        failing since 12 days (last pass: v5.15.105-194-g415a9d81c640, firs=
t fail: v5.15.135)

    2023-10-22T23:16:45.898349  / # #

    2023-10-22T23:16:46.000626  export SHELL=3D/bin/sh

    2023-10-22T23:16:46.001354  #

    2023-10-22T23:16:46.102837  / # export SHELL=3D/bin/sh. /lava-11848359/=
environment

    2023-10-22T23:16:46.103568  =


    2023-10-22T23:16:46.205116  / # . /lava-11848359/environment/lava-11848=
359/bin/lava-test-runner /lava-11848359/1

    2023-10-22T23:16:46.206337  =


    2023-10-22T23:16:46.222514  / # /lava-11848359/bin/lava-test-runner /la=
va-11848359/1

    2023-10-22T23:16:46.280527  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-22T23:16:46.281036  + cd /lava-1184835<8>[   16.821017] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11848359_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
