Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE1B7837C1
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 04:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjHVCIq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 22:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjHVCIq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 22:08:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7FFD1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:08:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c06f6f98c0so11627715ad.3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692670122; x=1693274922;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b/t4k9tHTRKTN19BJxP/QvttWkG2d67247pZX77ZLmg=;
        b=zrNpYEevZS7XcRJTnCmatj1JYGOBaijFUDgfKqOX5M+Il+9FDaQpOSdIgLZAkFjFm4
         f10m5/iwjbmG3bLwklWkJ2JK8jkodM2WguUJSMpMBOYFsrv7u22KUcsX+QU99nwoHOwP
         +XAac9LVD1UnPe6vaPA2ihGL+89A/lW7+8bEVXNSbmSQXlI3d7NQTglQLiXPueYM2tZd
         xTu+IIAzdsNW0iU2yiOGTxR7hGlE2P8s/QgYrZ5K6yzCNRnEq2ICCC/4b18dBN0YPQK2
         Oogqf9E4KBlYVMx4hbfu1AP53ndRAn1ac7XFTr1LZTjE+Bcd3jUNJdUTBmcdUq/8q9Pe
         Xv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692670122; x=1693274922;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/t4k9tHTRKTN19BJxP/QvttWkG2d67247pZX77ZLmg=;
        b=KkPkc4EBue5DgycLOora5y1AfSSdIkQyodAS/L4OrzDk/nMeiEdghLqLyqyXpp2b9A
         HIIMdZSoV42E/5detPQzELYy+o3GMxhJiWxtizd93sRapFWKBdziSUhNlCUaVbUuE/Oi
         WXS661r2WD/N4laYbmM8SYr1eOpCv4d4g+7Gy1Ev1O9V/NnUXiJ0FgB0j4DydcuGWeVF
         k49sUXsM2foolykbt7woMkdhG7a8h4fRB0C0SRABMmD4Y2bxnlspYqo7crwKNHfnMW7s
         lY1Hwln17+9l0FZfTD1BxH0PjQqtTig1MEauSj8dZiixFYXZSImCbCyQI/a/lDXfDNDc
         LsRQ==
X-Gm-Message-State: AOJu0YwhIQasmSzJveTfC+MdVhH+aEQwHvVHfkfdJtxAR9TVpPKg48Cg
        9CPUevYQHo97TABm5ucFJ903Nq3GncRx6NgNVML9kA==
X-Google-Smtp-Source: AGHT+IHBT0py4xE6wnJWpbYqTFHxQCNAzcSmzdhUdduqJtz4b5EPACjp4osYc7LiTRFP5L7d4hC5Mw==
X-Received: by 2002:a17:902:d214:b0:1bc:667b:63c6 with SMTP id t20-20020a170902d21400b001bc667b63c6mr7319272ply.41.1692670122301;
        Mon, 21 Aug 2023 19:08:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902768400b001b04c2023e3sm7686521pll.218.2023.08.21.19.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 19:08:41 -0700 (PDT)
Message-ID: <64e418a9.170a0220.be473.e690@mx.google.com>
Date:   Mon, 21 Aug 2023 19:08:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-195-g5165f4e9738c4
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 127 runs,
 11 regressions (v6.1.46-195-g5165f4e9738c4)
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

stable-rc/linux-6.1.y baseline: 127 runs, 11 regressions (v6.1.46-195-g5165=
f4e9738c4)

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
el/v6.1.46-195-g5165f4e9738c4/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.46-195-g5165f4e9738c4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5165f4e9738c48a220a13b073c6ccc24824aeb74 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e5c6823a5e81d4dc9648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e3e5c6823a5e81d4dc9=
649
        failing since 7 days (last pass: v6.1.45-128-ge73191cf0a0b2, first =
fail: v6.1.45-150-gdbb92b2240ba) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e58cc6536e9bbfdc95cc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3e58cc6536e9bbfdc95d1
        failing since 144 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-21T22:30:24.527901  <8>[   10.774505] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11327295_1.4.2.3.1>

    2023-08-21T22:30:24.531334  + set +x

    2023-08-21T22:30:24.638886  / # #

    2023-08-21T22:30:24.741110  export SHELL=3D/bin/sh

    2023-08-21T22:30:24.741771  #

    2023-08-21T22:30:24.843055  / # export SHELL=3D/bin/sh. /lava-11327295/=
environment

    2023-08-21T22:30:24.843796  =


    2023-08-21T22:30:24.945187  / # . /lava-11327295/environment/lava-11327=
295/bin/lava-test-runner /lava-11327295/1

    2023-08-21T22:30:24.946266  =


    2023-08-21T22:30:24.952082  / # /lava-11327295/bin/lava-test-runner /la=
va-11327295/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e59ac6536e9bbfdc95f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3e59ac6536e9bbfdc95f8
        failing since 144 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-21T22:30:43.335395  + <8>[   11.986379] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11327292_1.4.2.3.1>

    2023-08-21T22:30:43.335506  set +x

    2023-08-21T22:30:43.440183  / # #

    2023-08-21T22:30:43.540843  export SHELL=3D/bin/sh

    2023-08-21T22:30:43.541064  #

    2023-08-21T22:30:43.641523  / # export SHELL=3D/bin/sh. /lava-11327292/=
environment

    2023-08-21T22:30:43.641723  =


    2023-08-21T22:30:43.742238  / # . /lava-11327292/environment/lava-11327=
292/bin/lava-test-runner /lava-11327292/1

    2023-08-21T22:30:43.742686  =


    2023-08-21T22:30:43.747264  / # /lava-11327292/bin/lava-test-runner /la=
va-11327292/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e59cc6536e9bbfdc9609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3e59cc6536e9bbfdc960e
        failing since 144 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-21T22:30:30.565481  <8>[   11.422117] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11327285_1.4.2.3.1>

    2023-08-21T22:30:30.568936  + set +x

    2023-08-21T22:30:30.670150  #

    2023-08-21T22:30:30.670390  =


    2023-08-21T22:30:30.771041  / # #export SHELL=3D/bin/sh

    2023-08-21T22:30:30.771230  =


    2023-08-21T22:30:30.871708  / # export SHELL=3D/bin/sh. /lava-11327285/=
environment

    2023-08-21T22:30:30.871883  =


    2023-08-21T22:30:30.972398  / # . /lava-11327285/environment/lava-11327=
285/bin/lava-test-runner /lava-11327285/1

    2023-08-21T22:30:30.972790  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e853053cfc6cbadc95df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e3e853053cfc6cbadc9=
5e0
        failing since 75 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e59cdbffd2e0a6dc95ce

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3e59cdbffd2e0a6dc95d3
        failing since 144 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-21T22:30:37.793005  + set +x

    2023-08-21T22:30:37.799959  <8>[   10.729909] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11327289_1.4.2.3.1>

    2023-08-21T22:30:37.903892  / # #

    2023-08-21T22:30:38.004517  export SHELL=3D/bin/sh

    2023-08-21T22:30:38.004684  #

    2023-08-21T22:30:38.105175  / # export SHELL=3D/bin/sh. /lava-11327289/=
environment

    2023-08-21T22:30:38.105341  =


    2023-08-21T22:30:38.205827  / # . /lava-11327289/environment/lava-11327=
289/bin/lava-test-runner /lava-11327289/1

    2023-08-21T22:30:38.206121  =


    2023-08-21T22:30:38.210329  / # /lava-11327289/bin/lava-test-runner /la=
va-11327289/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e58dc6536e9bbfdc95d7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3e58dc6536e9bbfdc95dc
        failing since 144 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-21T22:30:18.480458  + <8>[   11.286047] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11327315_1.4.2.3.1>

    2023-08-21T22:30:18.480542  set +x

    2023-08-21T22:30:18.584748  / # #

    2023-08-21T22:30:18.685538  export SHELL=3D/bin/sh

    2023-08-21T22:30:18.686278  #

    2023-08-21T22:30:18.788031  / # export SHELL=3D/bin/sh. /lava-11327315/=
environment

    2023-08-21T22:30:18.788749  =


    2023-08-21T22:30:18.890183  / # . /lava-11327315/environment/lava-11327=
315/bin/lava-test-runner /lava-11327315/1

    2023-08-21T22:30:18.891441  =


    2023-08-21T22:30:18.896602  / # /lava-11327315/bin/lava-test-runner /la=
va-11327315/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e59dfcb7baf958dc95ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3e59dfcb7baf958dc95f7
        failing since 144 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-21T22:30:30.860627  <8>[   17.286961] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11327300_1.4.2.3.1>

    2023-08-21T22:30:30.964889  / # #

    2023-08-21T22:30:31.065586  export SHELL=3D/bin/sh

    2023-08-21T22:30:34.377476  #

    2023-08-21T22:30:34.377709  / # export SHELL=3D/bin/sh

    2023-08-21T22:30:34.478392  / # . /lava-11327300/environment

    2023-08-21T22:30:34.579790  /lava-11327300/bin/lava-test-runner /lava-1=
1327300/1

    2023-08-21T22:30:35.243907  . /lava-11327300/environment

    2023-08-21T22:30:35.250337  // # /lava-1327300/bin/lava-test-runner /la=
va-11327300/1

    2023-08-21T22:30:35.255976  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e7a0ea5e896e0adc962e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3e7a0ea5e896e0adc9633
        failing since 35 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-21T22:40:43.391521  / # #

    2023-08-21T22:40:43.493723  export SHELL=3D/bin/sh

    2023-08-21T22:40:43.494433  #

    2023-08-21T22:40:43.595843  / # export SHELL=3D/bin/sh. /lava-11327414/=
environment

    2023-08-21T22:40:43.596552  =


    2023-08-21T22:40:43.698035  / # . /lava-11327414/environment/lava-11327=
414/bin/lava-test-runner /lava-11327414/1

    2023-08-21T22:40:43.699128  =


    2023-08-21T22:40:43.716071  / # /lava-11327414/bin/lava-test-runner /la=
va-11327414/1

    2023-08-21T22:40:43.764195  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-21T22:40:43.764704  + cd /lav<8>[   19.107621] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11327414_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e7bc135e48362bdc9638

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3e7bc135e48362bdc963d
        failing since 35 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-21T22:39:47.102725  / # #

    2023-08-21T22:39:48.182132  export SHELL=3D/bin/sh

    2023-08-21T22:39:48.183885  #

    2023-08-21T22:39:49.672292  / # export SHELL=3D/bin/sh. /lava-11327419/=
environment

    2023-08-21T22:39:49.674086  =


    2023-08-21T22:39:52.394221  / # . /lava-11327419/environment/lava-11327=
419/bin/lava-test-runner /lava-11327419/1

    2023-08-21T22:39:52.396338  =


    2023-08-21T22:39:52.410837  / # /lava-11327419/bin/lava-test-runner /la=
va-11327419/1

    2023-08-21T22:39:52.426869  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-21T22:39:52.469871  + cd /lava-113274<8>[   28.521044] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11327419_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e3e79eea5e896e0adc9623

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.46-=
195-g5165f4e9738c4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e3e79eea5e896e0adc9628
        failing since 35 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-21T22:40:56.582530  / # #

    2023-08-21T22:40:56.683044  export SHELL=3D/bin/sh

    2023-08-21T22:40:56.683156  #

    2023-08-21T22:40:56.783683  / # export SHELL=3D/bin/sh. /lava-11327412/=
environment

    2023-08-21T22:40:56.783798  =


    2023-08-21T22:40:56.884291  / # . /lava-11327412/environment/lava-11327=
412/bin/lava-test-runner /lava-11327412/1

    2023-08-21T22:40:56.884493  =


    2023-08-21T22:40:56.896152  / # /lava-11327412/bin/lava-test-runner /la=
va-11327412/1

    2023-08-21T22:40:56.964850  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-21T22:40:56.964946  + cd /lava-1132741<8>[   18.762111] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11327412_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
