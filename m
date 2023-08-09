Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1245A775056
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 03:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjHIB2E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 21:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHIB2B (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 21:28:01 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451B81FEA
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 18:27:58 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d4b74a4a6daso3892103276.2
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 18:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691544477; x=1692149277;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvai9aXosReTZNpKg4qfsgTh3CwzpOq6TMHrudXxE3g=;
        b=uafdZLZAgBpP14YX0uSDKrSrRiItjSY+UHJu6EI2PWxLSY3zgIuxMy+9TCPkycxkXr
         jFke4iLfJ7B1oLG0PNc9ptmQTTgfUGUYos6EhvpLax6aTvdNwEFdkL67Jyf9g9nG+oI5
         pRcvPnoFtrT2y9AIHx3XQcqCfQm6+4PqYvUPwbJcmwHeGGB1IB1NitVv+h2f+zEVUGFI
         qBzuCgilTSuzXfc1HgBuyraiLrl7yLNr3pphfsBjyrIURGV6SHKoX8XLeMRMNIY6EgRd
         FoD9h5GsAPVcbPGSIGyXGI+Uc8IfFsSjs4DfAUEu5CvWF/uyYoNtsbpCg30aAyx09r25
         5Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691544477; x=1692149277;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zvai9aXosReTZNpKg4qfsgTh3CwzpOq6TMHrudXxE3g=;
        b=Q/F34kEqLTpSCXzQY2Ly2Dk6nwXTdasqiNTuvG0rMha6/XWNaoqcrOpU9cyby3EIHL
         zZRXySHcX7BAaYFrKMINM5Qgi2fviMkEHLshaIib6mJgdUYkOiyrXX4hOVqr08DNaPvl
         UVs1lZC3wYucypQH/s3nAb4XVcrG0sW/dRUm0V+betyKiiI7SVAd/11DplI1l77AJnQw
         RZ/rVvJIbkT6C0koCIKNlH9nVgL5XN79DtDi25kmCpm0JqhrsF1yICZljkbvDAheYgt8
         fHzCd8Qjp4mfjJlcJV8Woks5T66o0MRhdRjX+qzP+PhOxeRD1AMRRgCd+xfrbDjUv37X
         nzlg==
X-Gm-Message-State: AOJu0YzMB3pMSy3nnJSRgs8PUJay5J4u+sEnETZgegJ5SVXd1WSwXzzW
        RQcjoRLr8P0U5YxZwCl+MmAj73I6hTkjEKhZ6I0ncw==
X-Google-Smtp-Source: AGHT+IFWkei09TxfWIQqJ3KjwHsEnEVh2NqAFdwMzpaFEiAyBEQCb6XWwSz0Tkt5gyy+UtqIFqdhsQ==
X-Received: by 2002:a25:ab71:0:b0:d07:707c:1106 with SMTP id u104-20020a25ab71000000b00d07707c1106mr1227029ybi.56.1691544476356;
        Tue, 08 Aug 2023 18:27:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i5-20020a639d05000000b005637030d00csm7262916pgd.30.2023.08.08.18.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:27:55 -0700 (PDT)
Message-ID: <64d2eb9b.630a0220.c60f5.d468@mx.google.com>
Date:   Tue, 08 Aug 2023 18:27:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.125-87-g976c140e8e74d
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 52 runs,
 8 regressions (v5.15.125-87-g976c140e8e74d)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 52 runs, 8 regressions (v5.15.125-87-g976c=
140e8e74d)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.125-87-g976c140e8e74d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.125-87-g976c140e8e74d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      976c140e8e74d70e726e90031451db14373cdec1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2b6ca4e592ae80b35b20c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2b6ca4e592ae80b35b211
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-08T21:42:27.891970  + set +x

    2023-08-08T21:42:27.898798  <8>[   10.309043] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11237124_1.4.2.3.1>

    2023-08-08T21:42:28.002341  #

    2023-08-08T21:42:28.103432  / # #export SHELL=3D/bin/sh

    2023-08-08T21:42:28.103595  =


    2023-08-08T21:42:28.204074  / # export SHELL=3D/bin/sh. /lava-11237124/=
environment

    2023-08-08T21:42:28.204287  =


    2023-08-08T21:42:28.304825  / # . /lava-11237124/environment/lava-11237=
124/bin/lava-test-runner /lava-11237124/1

    2023-08-08T21:42:28.305189  =


    2023-08-08T21:42:28.311071  / # /lava-11237124/bin/lava-test-runner /la=
va-11237124/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2b6b5f66524e7a435b238

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2b6b5f66524e7a435b23d
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-08T21:42:03.808078  + set<8>[   11.316185] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11237130_1.4.2.3.1>

    2023-08-08T21:42:03.808652   +x

    2023-08-08T21:42:03.916660  / # #

    2023-08-08T21:42:04.019321  export SHELL=3D/bin/sh

    2023-08-08T21:42:04.020104  #

    2023-08-08T21:42:04.121717  / # export SHELL=3D/bin/sh. /lava-11237130/=
environment

    2023-08-08T21:42:04.122511  =


    2023-08-08T21:42:04.224154  / # . /lava-11237130/environment/lava-11237=
130/bin/lava-test-runner /lava-11237130/1

    2023-08-08T21:42:04.225449  =


    2023-08-08T21:42:04.230474  / # /lava-11237130/bin/lava-test-runner /la=
va-11237130/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2b6c4ac33e9880235b1df

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2b6c4ac33e9880235b1e4
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-08T21:42:05.632878  <8>[   11.067351] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11237119_1.4.2.3.1>

    2023-08-08T21:42:05.637061  + set +x

    2023-08-08T21:42:05.742947  #

    2023-08-08T21:42:05.744276  =


    2023-08-08T21:42:05.846054  / # #export SHELL=3D/bin/sh

    2023-08-08T21:42:05.846867  =


    2023-08-08T21:42:05.948444  / # export SHELL=3D/bin/sh. /lava-11237119/=
environment

    2023-08-08T21:42:05.949252  =


    2023-08-08T21:42:06.050809  / # . /lava-11237119/environment/lava-11237=
119/bin/lava-test-runner /lava-11237119/1

    2023-08-08T21:42:06.052133  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2bbad04b8ddd33b35b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2bbad04b8ddd33b35b=
1da
        failing since 14 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2b6c04e592ae80b35b1e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2b6c04e592ae80b35b1ed
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-08T21:42:36.604527  + <8>[   10.295850] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11237111_1.4.2.3.1>

    2023-08-08T21:42:36.604636  set +x

    2023-08-08T21:42:36.706108  #

    2023-08-08T21:42:36.806878  / # #export SHELL=3D/bin/sh

    2023-08-08T21:42:36.807151  =


    2023-08-08T21:42:36.907720  / # export SHELL=3D/bin/sh. /lava-11237111/=
environment

    2023-08-08T21:42:36.907927  =


    2023-08-08T21:42:37.008418  / # . /lava-11237111/environment/lava-11237=
111/bin/lava-test-runner /lava-11237111/1

    2023-08-08T21:42:37.008703  =


    2023-08-08T21:42:37.013147  / # /lava-11237111/bin/lava-test-runner /la=
va-11237111/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2b69e1ebd5bab1735b209

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2b69e1ebd5bab1735b20e
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-08T21:41:39.701260  <8>[   10.699041] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11237101_1.4.2.3.1>

    2023-08-08T21:41:39.704659  + set +x

    2023-08-08T21:41:39.808683  / # #

    2023-08-08T21:41:39.909229  export SHELL=3D/bin/sh

    2023-08-08T21:41:39.909415  #

    2023-08-08T21:41:40.009920  / # export SHELL=3D/bin/sh. /lava-11237101/=
environment

    2023-08-08T21:41:40.010081  =


    2023-08-08T21:41:40.110545  / # . /lava-11237101/environment/lava-11237=
101/bin/lava-test-runner /lava-11237101/1

    2023-08-08T21:41:40.110860  =


    2023-08-08T21:41:40.115948  / # /lava-11237101/bin/lava-test-runner /la=
va-11237101/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2b6b41ebd5bab1735b250

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2b6b41ebd5bab1735b255
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-08T21:42:04.357268  + set<8>[   11.092697] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11237136_1.4.2.3.1>

    2023-08-08T21:42:04.357881   +x

    2023-08-08T21:42:04.465626  / # #

    2023-08-08T21:42:04.568116  export SHELL=3D/bin/sh

    2023-08-08T21:42:04.569070  #

    2023-08-08T21:42:04.670879  / # export SHELL=3D/bin/sh. /lava-11237136/=
environment

    2023-08-08T21:42:04.671667  =


    2023-08-08T21:42:04.773347  / # . /lava-11237136/environment/lava-11237=
136/bin/lava-test-runner /lava-11237136/1

    2023-08-08T21:42:04.774785  =


    2023-08-08T21:42:04.779723  / # /lava-11237136/bin/lava-test-runner /la=
va-11237136/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2b6b34e592ae80b35b1dc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-87-g976c140e8e74d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2b6b44e592ae80b35b1e1
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-08T21:41:52.202416  + set<8>[   12.266162] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11237127_1.4.2.3.1>

    2023-08-08T21:41:52.202535   +x

    2023-08-08T21:41:52.306848  / # #

    2023-08-08T21:41:52.407448  export SHELL=3D/bin/sh

    2023-08-08T21:41:52.407644  #

    2023-08-08T21:41:52.508176  / # export SHELL=3D/bin/sh. /lava-11237127/=
environment

    2023-08-08T21:41:52.508385  =


    2023-08-08T21:41:52.608934  / # . /lava-11237127/environment/lava-11237=
127/bin/lava-test-runner /lava-11237127/1

    2023-08-08T21:41:52.609208  =


    2023-08-08T21:41:52.613978  / # /lava-11237127/bin/lava-test-runner /la=
va-11237127/1
 =

    ... (12 line(s) more)  =

 =20
