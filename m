Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C1471698E
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 18:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjE3QcN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjE3Qbz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 12:31:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D99106
        for <stable@vger.kernel.org>; Tue, 30 May 2023 09:31:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-256c8bed212so534538a91.3
        for <stable@vger.kernel.org>; Tue, 30 May 2023 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685464286; x=1688056286;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3MFGqVHnrssksVYWIrkJoYMI+hyAxZ+Htm/sppFQys=;
        b=gHaK8oXKLTM7J70W481ju+L700ZJ/gc+YF0mI3xpmFVNSGlzkXI7wnuDLAPmDNuz+w
         WKKRwOa+wHGOivT1DWqve9PKBNQNB6uQ4lyoMu7VpI5IwGENa3IFG4z+6ylJvcwAp+VW
         oyJ6uE5d7d6vB4tBHjotqYVqGot+EQ4U2IHJEde8amj4Z4yx1xGPtFd7Dntbgs3bNLSw
         /61zER+AQVOcSj+y2IjyNrZDoJuEK8N5vONx/A4egm3XbE4eZEoO26XBZ0GXs4norNdN
         zo1z6mHz64mSlrllQizy+NekSl9KSKo+ZXll6hWAIlqT/hAMGFWys37LjTuxg1+HaE0o
         LfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464286; x=1688056286;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3MFGqVHnrssksVYWIrkJoYMI+hyAxZ+Htm/sppFQys=;
        b=ICmxJ7J4l5TqQkj6HvxtK/cDGq3aihkUmodZwYGbizjatGaMlTCIOh22G62GpoBUeQ
         Sk9c/Ga+ihyRdxB1v0V9xbY/pvmE7Eu1SQoMgK+zJtM439J8oOWTriX+OTrEOeGpwhQ1
         ZwDzps4z84Gcm+zZnSsOxQ8n5aYetZcJPkb61hd035LMAAJv/9r3UvUjkwbOyie4x6bU
         PXmMUOAB++0MK5ezzfVVTV7VVuMwgMugdDwBIMgcgcVRgd/0dnjhHsT10kH1NZqIDhDA
         /nGoO5U3CZFeX5dudpqulBBhvGEGLLXjXbCuaObwybLDu93fpIyUKta2zg41jjhiMqzr
         HOjw==
X-Gm-Message-State: AC+VfDyh53kHWVpC6RBSMzKvA+2l5Stybw7uQ/wyRuo73zenh2IKKXmE
        uZXsMAi4zGLfhovG/AhDupsuBtKhmiOweZ8fJ6Ffjg==
X-Google-Smtp-Source: ACHHUZ63TAQWvaG/0dMss28QGEohSkOjvOLLrxQnx23iNsv6N2PXM/w/wgsfyu5w38ugflWtJCFUYw==
X-Received: by 2002:a17:90a:de0e:b0:253:342b:a14e with SMTP id m14-20020a17090ade0e00b00253342ba14emr3123992pjv.21.1685464286257;
        Tue, 30 May 2023 09:31:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w123-20020a636281000000b00528b78ddbcesm9050046pgb.70.2023.05.30.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:31:25 -0700 (PDT)
Message-ID: <647624dd.630a0220.738c6.0944@mx.google.com>
Date:   Tue, 30 May 2023 09:31:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-273-g7774fe74177e
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 159 runs,
 6 regressions (v5.15.112-273-g7774fe74177e)
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

stable-rc/queue/5.15 baseline: 159 runs, 6 regressions (v5.15.112-273-g7774=
fe74177e)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-273-g7774fe74177e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-273-g7774fe74177e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7774fe74177e19a34f0e6274b0e64bdcdad3e3d7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6475f48d20802490742e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475f48d20802490742e85ff
        failing since 63 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-30T13:04:59.123899  + <8>[   11.111545] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10524315_1.4.2.3.1>

    2023-05-30T13:04:59.124018  set +x

    2023-05-30T13:04:59.227875  / # #

    2023-05-30T13:04:59.328602  export SHELL=3D/bin/sh

    2023-05-30T13:04:59.328874  #

    2023-05-30T13:04:59.429546  / # export SHELL=3D/bin/sh. /lava-10524315/=
environment

    2023-05-30T13:04:59.429766  =


    2023-05-30T13:04:59.530303  / # . /lava-10524315/environment/lava-10524=
315/bin/lava-test-runner /lava-10524315/1

    2023-05-30T13:04:59.530606  =


    2023-05-30T13:04:59.535492  / # /lava-10524315/bin/lava-test-runner /la=
va-10524315/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6475f1e7a43ca4dd612e863d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475f1e7a43ca4dd612e8642
        failing since 63 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-30T12:53:53.260391  <8>[   10.746413] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10524262_1.4.2.3.1>

    2023-05-30T12:53:53.263892  + set +x

    2023-05-30T12:53:53.365223  #

    2023-05-30T12:53:53.365571  =


    2023-05-30T12:53:53.466216  / # #export SHELL=3D/bin/sh

    2023-05-30T12:53:53.466435  =


    2023-05-30T12:53:53.566950  / # export SHELL=3D/bin/sh. /lava-10524262/=
environment

    2023-05-30T12:53:53.567145  =


    2023-05-30T12:53:53.667631  / # . /lava-10524262/environment/lava-10524=
262/bin/lava-test-runner /lava-10524262/1

    2023-05-30T12:53:53.667975  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6475f3caa2c77721dc2e861a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6475f3caa2c77721dc2e8=
61b
        failing since 116 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475f03206d5842fb72e85e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475f03206d5842fb72e85ec
        failing since 133 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-30T12:46:26.629998  <8>[   10.052131] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3631167_1.5.2.4.1>
    2023-05-30T12:46:26.739329  / # #
    2023-05-30T12:46:26.843050  export SHELL=3D/bin/sh
    2023-05-30T12:46:26.844224  #
    2023-05-30T12:46:26.946799  / # export SHELL=3D/bin/sh. /lava-3631167/e=
nvironment
    2023-05-30T12:46:26.948107  =

    2023-05-30T12:46:27.050654  / # . /lava-3631167/environment/lava-363116=
7/bin/lava-test-runner /lava-3631167/1
    2023-05-30T12:46:27.052415  =

    2023-05-30T12:46:27.052853  / # <3>[   10.433061] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-05-30T12:46:27.057508  /lava-3631167/bin/lava-test-runner /lava-36=
31167/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6475f50435decfd11a2e8634

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475f50435decfd11a2e8639
        failing since 63 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-30T13:07:00.135019  + set +x

    2023-05-30T13:07:00.141908  <8>[   10.021648] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10524242_1.4.2.3.1>

    2023-05-30T13:07:00.249740  / # #

    2023-05-30T13:07:00.352359  export SHELL=3D/bin/sh

    2023-05-30T13:07:00.353223  #

    2023-05-30T13:07:00.454755  / # export SHELL=3D/bin/sh. /lava-10524242/=
environment

    2023-05-30T13:07:00.455643  =


    2023-05-30T13:07:00.557307  / # . /lava-10524242/environment/lava-10524=
242/bin/lava-test-runner /lava-10524242/1

    2023-05-30T13:07:00.558606  =


    2023-05-30T13:07:00.563947  / # /lava-10524242/bin/lava-test-runner /la=
va-10524242/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6475f20b9d7a9e86212e85ff

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g7774fe74177e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475f20b9d7a9e86212e8604
        failing since 63 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-30T12:54:14.591785  + set<8>[   10.590219] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10524243_1.4.2.3.1>

    2023-05-30T12:54:14.591873   +x

    2023-05-30T12:54:14.695731  / # #

    2023-05-30T12:54:14.796301  export SHELL=3D/bin/sh

    2023-05-30T12:54:14.796494  #

    2023-05-30T12:54:14.897019  / # export SHELL=3D/bin/sh. /lava-10524243/=
environment

    2023-05-30T12:54:14.897200  =


    2023-05-30T12:54:14.997743  / # . /lava-10524243/environment/lava-10524=
243/bin/lava-test-runner /lava-10524243/1

    2023-05-30T12:54:14.998013  =


    2023-05-30T12:54:15.002569  / # /lava-10524243/bin/lava-test-runner /la=
va-10524243/1
 =

    ... (12 line(s) more)  =

 =20
