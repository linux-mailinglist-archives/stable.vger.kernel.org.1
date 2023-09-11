Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D979B9DD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242921AbjIKU6r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbjIKM32 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 08:29:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BEFE50
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 05:29:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso37656745ad.1
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 05:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694435362; x=1695040162; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oaLw8iq5UO8cdq8i43X/3FyzKNsEi2qlbyTEcOQW/n8=;
        b=WmooaEESGdnDjJyOUqOj+g/oTkrad4oOO01GZE32aponnzpCwuufD3k08KtsU/Ipnm
         o7+DanUrBKf3RgrlLTKDQ1zhN3e7wobcglJ6AlLcXdxj7LLfVGPFleK0sl27BGdpdOG0
         4+5L+mHwaOebXnF5D/UiC6CDnLiLoUKNsBkVNgLDZB9c9t0O0Hl0QaqtA9WUiDJFbf/D
         mNKm3wOfrsF5nAPJl3eq93CEXa/VErsE40nyIIImbH/RoiOFeo9SnY5LCO9swR6ghqhd
         qioVnxyD9RiPzCBLnk9RQe4jePzz/qAWXLJIUbIx8g6KEdHccCqyttkxuyXX/tnA3Zqx
         SNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694435362; x=1695040162;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaLw8iq5UO8cdq8i43X/3FyzKNsEi2qlbyTEcOQW/n8=;
        b=KOTKMahlNb6enRp5z7bnQ4tvf4iiE68UuR+f0v1JC5Q/TALmBo28F25CG6Q5FHYydo
         u6DjVUXiUiG3ebfr51Df89zNNqLWxNjU2Qp+uwnAZ0wfRbD2LbQMNsLHVACWMVbf+qxd
         Vqz9ecmD13H+ZYaGbfNhKINPsWsqo5jBNsKqb6ia8v3+rSQg997Ed91tHudGm7bN60Pe
         6BM6kRgBdyfL1z3jkyKvWJmdPg3Q2mDxy93jX6r6MBy5jqNyUoLzsbzvG7JXGcBwc471
         1r2k9o1G5Vae/Ejop2Ep6GwG5o44Ec7MuD3oQ4OrGc2GxPkNJ3iAf+eZQEYGsNvheV3G
         rcww==
X-Gm-Message-State: AOJu0Yy9jziRcLCKUUlyF0Yequpi9Et/RzYGVGxzLlZOD3JEhgsbenfu
        pz9qkczILcqE1xYOSiSUULhKZXtABaGkCsY5s9k=
X-Google-Smtp-Source: AGHT+IG4DD3MMvFVXy/UgOIGwNJcEsW6E34Ox0Px9nYg6iFML3o9b6EcjJyO3b8ms6nq8ikGWmtEsQ==
X-Received: by 2002:a17:902:8c8e:b0:1bc:98dd:e872 with SMTP id t14-20020a1709028c8e00b001bc98dde872mr8079448plo.29.1694435361605;
        Mon, 11 Sep 2023 05:29:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902c38100b001c3267ae314sm6313094plg.156.2023.09.11.05.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 05:29:20 -0700 (PDT)
Message-ID: <64ff0820.170a0220.1f747.f047@mx.google.com>
Date:   Mon, 11 Sep 2023 05:29:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.131-378-g0d005f1330c2
Subject: stable-rc/linux-5.15.y baseline: 104 runs,
 8 regressions (v5.15.131-378-g0d005f1330c2)
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

stable-rc/linux-5.15.y baseline: 104 runs, 8 regressions (v5.15.131-378-g0d=
005f1330c2)

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
nel/v5.15.131-378-g0d005f1330c2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.131-378-g0d005f1330c2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0d005f1330c27847e09ba2bc8d7c76cb9962a56a =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed909a24d9cd2a8286d86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed909a24d9cd2a8286d8f
        failing since 166 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-11T09:09:29.546568  + set +x

    2023-09-11T09:09:29.552809  <8>[   10.355464] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11492995_1.4.2.3.1>

    2023-09-11T09:09:29.654707  #

    2023-09-11T09:09:29.654991  =


    2023-09-11T09:09:29.755632  / # #export SHELL=3D/bin/sh

    2023-09-11T09:09:29.755877  =


    2023-09-11T09:09:29.856364  / # export SHELL=3D/bin/sh. /lava-11492995/=
environment

    2023-09-11T09:09:29.856566  =


    2023-09-11T09:09:29.957067  / # . /lava-11492995/environment/lava-11492=
995/bin/lava-test-runner /lava-11492995/1

    2023-09-11T09:09:29.957348  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64feeea6e23c32ffa0286d7e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64feeea6e23c32ffa0286d87
        failing since 166 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-11T10:40:33.978989  <8>[   10.480459] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11493008_1.4.2.3.1>

    2023-09-11T10:40:33.982651  + set +x

    2023-09-11T10:40:34.087778  #

    2023-09-11T10:40:34.088773  =


    2023-09-11T10:40:34.190340  / # #export SHELL=3D/bin/sh

    2023-09-11T10:40:34.191012  =


    2023-09-11T10:40:34.292320  / # export SHELL=3D/bin/sh. /lava-11493008/=
environment

    2023-09-11T10:40:34.292979  =


    2023-09-11T10:40:34.394325  / # . /lava-11493008/environment/lava-11493=
008/bin/lava-test-runner /lava-11493008/1

    2023-09-11T10:40:34.395345  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fee7794d804b1b76286d77

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fee7794d804b1b76286d80
        failing since 166 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-11T10:09:54.411550  <8>[   10.850059] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11493020_1.4.2.3.1>

    2023-09-11T10:09:54.413825  + set +x

    2023-09-11T10:09:54.518755  / # #

    2023-09-11T10:09:54.619420  export SHELL=3D/bin/sh

    2023-09-11T10:09:54.619632  #

    2023-09-11T10:09:54.720177  / # export SHELL=3D/bin/sh. /lava-11493020/=
environment

    2023-09-11T10:09:54.720411  =


    2023-09-11T10:09:54.820913  / # . /lava-11493020/environment/lava-11493=
020/bin/lava-test-runner /lava-11493020/1

    2023-09-11T10:09:54.821227  =


    2023-09-11T10:09:54.826202  / # /lava-11493020/bin/lava-test-runner /la=
va-11493020/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed921a24d9cd2a8286d93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed921a24d9cd2a8286d9c
        failing since 166 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-11T09:08:55.261305  + set<8>[   10.460691] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11493003_1.4.2.3.1>

    2023-09-11T09:08:55.261389   +x

    2023-09-11T09:08:55.365313  / # #

    2023-09-11T09:08:55.466056  export SHELL=3D/bin/sh

    2023-09-11T09:08:55.466257  #

    2023-09-11T09:08:55.566739  / # export SHELL=3D/bin/sh. /lava-11493003/=
environment

    2023-09-11T09:08:55.566979  =


    2023-09-11T09:08:55.667566  / # . /lava-11493003/environment/lava-11493=
003/bin/lava-test-runner /lava-11493003/1

    2023-09-11T09:08:55.667945  =


    2023-09-11T09:08:55.672281  / # /lava-11493003/bin/lava-test-runner /la=
va-11493003/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64feec6200bdab49d6286dbc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64feec6200bdab49d6286dc5
        failing since 166 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-11T10:30:45.000678  + set +x<8>[   12.066340] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11492978_1.4.2.3.1>

    2023-09-11T10:30:45.000992  =


    2023-09-11T10:30:45.107695  / # #

    2023-09-11T10:30:45.210029  export SHELL=3D/bin/sh

    2023-09-11T10:30:45.211029  #

    2023-09-11T10:30:45.312731  / # export SHELL=3D/bin/sh. /lava-11492978/=
environment

    2023-09-11T10:30:45.312968  =


    2023-09-11T10:30:45.413626  / # . /lava-11492978/environment/lava-11492=
978/bin/lava-test-runner /lava-11492978/1

    2023-09-11T10:30:45.415397  =


    2023-09-11T10:30:45.420179  / # /lava-11492978/bin/lava-test-runner /la=
va-11492978/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed60c8f09552083286de1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed60d8f09552083286dea
        failing since 53 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-11T08:59:43.427188  / # #

    2023-09-11T08:59:43.529114  export SHELL=3D/bin/sh

    2023-09-11T08:59:43.529329  #

    2023-09-11T08:59:43.630089  / # export SHELL=3D/bin/sh. /lava-11493023/=
environment

    2023-09-11T08:59:43.630776  =


    2023-09-11T08:59:43.732082  / # . /lava-11493023/environment/lava-11493=
023/bin/lava-test-runner /lava-11493023/1

    2023-09-11T08:59:43.733046  =


    2023-09-11T08:59:43.735045  / # /lava-11493023/bin/lava-test-runner /la=
va-11493023/1

    2023-09-11T08:59:43.799356  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T08:59:43.799904  + cd /lav<8>[   15.983213] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11493023_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed6260c3936b342286d9a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed6260c3936b342286da3
        failing since 53 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-11T08:55:58.796781  / # #

    2023-09-11T08:55:59.872584  export SHELL=3D/bin/sh

    2023-09-11T08:55:59.874462  #

    2023-09-11T08:56:01.363683  / # export SHELL=3D/bin/sh. /lava-11493026/=
environment

    2023-09-11T08:56:01.365328  =


    2023-09-11T08:56:04.087925  / # . /lava-11493026/environment/lava-11493=
026/bin/lava-test-runner /lava-11493026/1

    2023-09-11T08:56:04.090173  =


    2023-09-11T08:56:04.094590  / # /lava-11493026/bin/lava-test-runner /la=
va-11493026/1

    2023-09-11T08:56:04.160390  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T08:56:04.160855  + cd /lava-11493026/<8>[   25.455815] <LAVA=
_SIGNAL_STARTRUN 1_bootrr 11493026_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed61da758083a9f286e92

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g0d005f1330c2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed61ea758083a9f286e9b
        failing since 53 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-11T08:59:56.486910  / # #

    2023-09-11T08:59:56.588766  export SHELL=3D/bin/sh

    2023-09-11T08:59:56.588989  #

    2023-09-11T08:59:56.689900  / # export SHELL=3D/bin/sh. /lava-11493033/=
environment

    2023-09-11T08:59:56.690561  =


    2023-09-11T08:59:56.791922  / # . /lava-11493033/environment/lava-11493=
033/bin/lava-test-runner /lava-11493033/1

    2023-09-11T08:59:56.792989  =


    2023-09-11T08:59:56.799778  / # /lava-11493033/bin/lava-test-runner /la=
va-11493033/1

    2023-09-11T08:59:56.865626  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T08:59:56.866050  + cd /lava-1149303<8>[   16.851161] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11493033_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
