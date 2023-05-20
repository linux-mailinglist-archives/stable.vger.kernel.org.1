Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8470ABAE
	for <lists+stable@lfdr.de>; Sun, 21 May 2023 01:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjETXy4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 20 May 2023 19:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETXyz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 20 May 2023 19:54:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A7C6
        for <stable@vger.kernel.org>; Sat, 20 May 2023 16:54:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-528dd896165so3219354a12.2
        for <stable@vger.kernel.org>; Sat, 20 May 2023 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684626891; x=1687218891;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D0bl0sNOIFBbHqnxW7NU+Z/99VlOmqeGP9YKYfKwXbg=;
        b=GjfMVpDoSCBuJFyFzNeOGrv+peWysp82KXozx9zqlPJLoq9YOwdxp4O0MVoPATx6eP
         2YGT+XhIq2m0LgoF+67z85AWQ4o9ZkK/KYiZoewlzUadl2Tjo0H6/80sz5yAzTTp/T1D
         SA1pkpJHX2qst7HFqf+jX1zz28IsM8ImZTzWrG3WEjFn2HUttxnnEoaJq1YlMbqG1WB0
         94jonCSkfOLuXBasniFmvoW7ZIQMMQO2M55zioyIW8JH2kCjF1KJjthcSbMJvrjXG0Gx
         797j6Y9ptB0mEn0QU3W0o53QmNinv7F5ogenKhx/ReY5g7Z4QWe+//VjkDKRK5F+ndSA
         aSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684626891; x=1687218891;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0bl0sNOIFBbHqnxW7NU+Z/99VlOmqeGP9YKYfKwXbg=;
        b=VBZgmsq5ev4d54l0vKU0FdHWrCrFGmIhiUHwq1ZUpw50XeIPItrgY0ZzNeRuvWbx6v
         OG+W7DFf4Zt3UCD5dD210GhfMF5DM0e0A9n6ikNLdgpYkiv8d3cKwj12AVBDPn6iJlyM
         lQZMJ0F7u+KIsCpLu9MgnYsBgAXt9uZs06S6stbgEFJKRKNgTePkrPNIwdc3W7iYZ00K
         SKUffWX1Ult8Dzo+ggHQkwEDdRoolo2553KQ7u/6b+6yAsGQ9QBvp4HUrrTcRmfPLmW+
         xJR2aqs+cBUPEMtzOB7Z0MmTbH3dmdlnQYbYtFz+mIw1ukCfX9vORb6/GvHjS7Hn0iBo
         RjUQ==
X-Gm-Message-State: AC+VfDyKAXvp7SGWFFjdAOTEf6JreBx8xi/rxvHNahW6PBeeUP8m/XFE
        Nte8tOJ3igbQ2Ygt2hrulLftrSq1KNYgWwzhEPS8MA==
X-Google-Smtp-Source: ACHHUZ5/5ZI3o4NnWL+IFoKu0QFVho64x2few+1d/wuipPYgJjut22jRpOr4UrNpTE/BMqi9+n30sg==
X-Received: by 2002:a17:903:1212:b0:1ae:2013:4bc8 with SMTP id l18-20020a170903121200b001ae20134bc8mr9917317plh.18.1684626891204;
        Sat, 20 May 2023 16:54:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jh14-20020a170903328e00b001a4fe00a8d4sm2056913plb.90.2023.05.20.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 16:54:50 -0700 (PDT)
Message-ID: <64695dca.170a0220.dd446.32db@mx.google.com>
Date:   Sat, 20 May 2023 16:54:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-106-g632aeb02f8e83
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 104 runs,
 6 regressions (v5.15.112-106-g632aeb02f8e83)
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

stable-rc/queue/5.15 baseline: 104 runs, 6 regressions (v5.15.112-106-g632a=
eb02f8e83)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-106-g632aeb02f8e83/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-106-g632aeb02f8e83
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      632aeb02f8e831197a9a01b1e93cb00b4363be05 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64692610a794cae6562e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64692610a794cae6562e85fb
        failing since 53 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T19:56:57.558743  + set +x<8>[   11.291936] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10399634_1.4.2.3.1>

    2023-05-20T19:56:57.558870  =


    2023-05-20T19:56:57.663590  / # #

    2023-05-20T19:56:57.764140  export SHELL=3D/bin/sh

    2023-05-20T19:56:57.764294  #

    2023-05-20T19:56:57.864751  / # export SHELL=3D/bin/sh. /lava-10399634/=
environment

    2023-05-20T19:56:57.864970  =


    2023-05-20T19:56:57.965554  / # . /lava-10399634/environment/lava-10399=
634/bin/lava-test-runner /lava-10399634/1

    2023-05-20T19:56:57.965864  =


    2023-05-20T19:56:57.970839  / # /lava-10399634/bin/lava-test-runner /la=
va-10399634/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6469260ac8dd3e35822e8621

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6469260ac8dd3e35822e8626
        failing since 53 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T19:56:50.482899  <8>[   11.375834] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10399641_1.4.2.3.1>

    2023-05-20T19:56:50.486081  + set +x

    2023-05-20T19:56:50.587365  #

    2023-05-20T19:56:50.587602  =


    2023-05-20T19:56:50.688197  / # #export SHELL=3D/bin/sh

    2023-05-20T19:56:50.688354  =


    2023-05-20T19:56:50.788901  / # export SHELL=3D/bin/sh. /lava-10399641/=
environment

    2023-05-20T19:56:50.789067  =


    2023-05-20T19:56:50.889566  / # . /lava-10399641/environment/lava-10399=
641/bin/lava-test-runner /lava-10399641/1

    2023-05-20T19:56:50.889822  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646925fac95af539c72e8603

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646925fac95af539c72e8608
        failing since 53 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T19:56:30.136172  + <8>[   10.120028] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10399599_1.4.2.3.1>

    2023-05-20T19:56:30.136269  set +x

    2023-05-20T19:56:30.237456  #

    2023-05-20T19:56:30.237729  =


    2023-05-20T19:56:30.338334  / # #export SHELL=3D/bin/sh

    2023-05-20T19:56:30.338559  =


    2023-05-20T19:56:30.439075  / # export SHELL=3D/bin/sh. /lava-10399599/=
environment

    2023-05-20T19:56:30.439280  =


    2023-05-20T19:56:30.539839  / # . /lava-10399599/environment/lava-10399=
599/bin/lava-test-runner /lava-10399599/1

    2023-05-20T19:56:30.540111  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646925fdc95af539c72e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646925fdc95af539c72e8613
        failing since 53 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T19:56:28.950703  <8>[   10.505616] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10399597_1.4.2.3.1>

    2023-05-20T19:56:28.954018  + set +x

    2023-05-20T19:56:29.055575  #

    2023-05-20T19:56:29.055900  =


    2023-05-20T19:56:29.156537  / # #export SHELL=3D/bin/sh

    2023-05-20T19:56:29.156764  =


    2023-05-20T19:56:29.257329  / # export SHELL=3D/bin/sh. /lava-10399597/=
environment

    2023-05-20T19:56:29.257562  =


    2023-05-20T19:56:29.358138  / # . /lava-10399597/environment/lava-10399=
597/bin/lava-test-runner /lava-10399597/1

    2023-05-20T19:56:29.358457  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64692609f481d6f60a2e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64692609f481d6f60a2e85fc
        failing since 53 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T19:56:35.006321  + set<8>[   10.821165] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10399601_1.4.2.3.1>

    2023-05-20T19:56:35.006404   +x

    2023-05-20T19:56:35.110971  / # #

    2023-05-20T19:56:35.211558  export SHELL=3D/bin/sh

    2023-05-20T19:56:35.211734  #

    2023-05-20T19:56:35.312191  / # export SHELL=3D/bin/sh. /lava-10399601/=
environment

    2023-05-20T19:56:35.312378  =


    2023-05-20T19:56:35.412845  / # . /lava-10399601/environment/lava-10399=
601/bin/lava-test-runner /lava-10399601/1

    2023-05-20T19:56:35.413104  =


    2023-05-20T19:56:35.417811  / # /lava-10399601/bin/lava-test-runner /la=
va-10399601/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646926127d87c1210d2e8617

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-g632aeb02f8e83/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646926127d87c1210d2e861c
        failing since 53 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T19:56:46.410918  + <8>[   12.410751] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10399621_1.4.2.3.1>

    2023-05-20T19:56:46.411000  set +x

    2023-05-20T19:56:46.515982  / # #

    2023-05-20T19:56:46.616705  export SHELL=3D/bin/sh

    2023-05-20T19:56:46.616900  #

    2023-05-20T19:56:46.717378  / # export SHELL=3D/bin/sh. /lava-10399621/=
environment

    2023-05-20T19:56:46.717559  =


    2023-05-20T19:56:46.818079  / # . /lava-10399621/environment/lava-10399=
621/bin/lava-test-runner /lava-10399621/1

    2023-05-20T19:56:46.818357  =


    2023-05-20T19:56:46.823156  / # /lava-10399621/bin/lava-test-runner /la=
va-10399621/1
 =

    ... (12 line(s) more)  =

 =20
