Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744267416E4
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjF1RDH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjF1RDG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 13:03:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B9F1BD5
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 10:03:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so1679648b3a.2
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687971782; x=1690563782;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=INiK0IdA88sMBHe+00aofk5vGxc3UNivaeduwkkiU0E=;
        b=FG5AHUfNtNEaBQv0GetPgvD5GSCVixJzajEEzsoSZEGINtXRhtd+84bwWY9saNBicw
         CBS/sukK2wmhjmnF90puTVTdwyGYZUXe1lhW+ZEBXv2ZGk5Wj3FGI3F2HNoao437K823
         q6fAIeIWX22Vhll22dQ8UjbdE4zZPmHIPuZO455S7E1uZbuk5zsO/9Pdl657XN76Rn2s
         kdbS0lFbEdVgMwYYZb9ze9k3G1H2CPIWJ+vz0gQlPyCAoesIsQKhHj/Cmq5puPFLIqVZ
         Dk+51nCoTuFgTODfLN5sQhfTf/F2ZyPYk9FhEQLB6kix29U1vjqWPkjQWVWf2f1se2Ky
         ZPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687971782; x=1690563782;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INiK0IdA88sMBHe+00aofk5vGxc3UNivaeduwkkiU0E=;
        b=exgGnKSRfjX2cHRuNF/lYNEAvG+Ty8MWisxCf+t9xwp+1igMOpBcEJSK1zB6P69yxR
         0DZW5p0zYLL/+BuO2PPXZI10oJqVL4dmOoMpNKksO1tekZ/ywgtccsbIRlPKBPxl5+xr
         3GbZ1rd6WqwLquhJgPFT0YZDsi3pf46I43SvwLubNdX7DeF7KIYvQv8PuViEOlMWg6Fy
         ZaaCRRl2bzDGL37DI9e8ci2ozcOBv6TKbb9z2ZEgZJYijXD5+V0wT7sSbB45TCKn818j
         dpLmcpR7EJI738kQtteMG2R3W85d23I40mbu9b4QNMm6vXHe0lJWDDhRz5GCJOrRc6De
         lL0Q==
X-Gm-Message-State: AC+VfDxsYJct23UlE8S2anmzr3jSqG0aR5QDydWd71JKB8FVUeUpheHJ
        w7dbMUws2R5aILV016uD6u13ne4fOs80jy3ulCuiNw==
X-Google-Smtp-Source: ACHHUZ5izIc9I1mRmEWwnrkJ/WmMLjTQ/LNMl9F5M5SD/WA4iCHDW1wsE9iqZFVfAZhkK7EYd6cB5A==
X-Received: by 2002:a05:6a20:748c:b0:11f:39e2:d08c with SMTP id p12-20020a056a20748c00b0011f39e2d08cmr39342648pzd.30.1687971782048;
        Wed, 28 Jun 2023 10:03:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r2-20020a62e402000000b00672401787c6sm6007239pfh.109.2023.06.28.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:03:01 -0700 (PDT)
Message-ID: <649c67c5.620a0220.47d5.bd82@mx.google.com>
Date:   Wed, 28 Jun 2023 10:03:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.119
Subject: stable-rc/linux-5.15.y baseline: 129 runs, 11 regressions (v5.15.119)
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

stable-rc/linux-5.15.y baseline: 129 runs, 11 regressions (v5.15.119)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.119/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.119
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4af60700a60cc45ee4fb6d579cccf1b7bca20c34 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2da985926fa8aaedacc3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2da985926fa8aaedaccc
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-28T12:54:55.249963  <8>[   10.281470] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10937519_1.4.2.3.1>

    2023-06-28T12:54:55.253041  + set +x

    2023-06-28T12:54:55.357303  / # #

    2023-06-28T12:54:55.457889  export SHELL=3D/bin/sh

    2023-06-28T12:54:55.458057  #

    2023-06-28T12:54:55.558639  / # export SHELL=3D/bin/sh. /lava-10937519/=
environment

    2023-06-28T12:54:55.559361  =


    2023-06-28T12:54:55.660697  / # . /lava-10937519/environment/lava-10937=
519/bin/lava-test-runner /lava-10937519/1

    2023-06-28T12:54:55.661773  =


    2023-06-28T12:54:55.667801  / # /lava-10937519/bin/lava-test-runner /la=
va-10937519/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2d9d5ff8d4fa13edacea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2d9d5ff8d4fa13edacf3
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-28T12:54:35.712362  + set<8>[   11.421401] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10937530_1.4.2.3.1>

    2023-06-28T12:54:35.712949   +x

    2023-06-28T12:54:35.822065  / # #

    2023-06-28T12:54:35.924669  export SHELL=3D/bin/sh

    2023-06-28T12:54:35.925558  #

    2023-06-28T12:54:36.027085  / # export SHELL=3D/bin/sh. /lava-10937530/=
environment

    2023-06-28T12:54:36.027906  =


    2023-06-28T12:54:36.129505  / # . /lava-10937530/environment/lava-10937=
530/bin/lava-test-runner /lava-10937530/1

    2023-06-28T12:54:36.130836  =


    2023-06-28T12:54:36.136078  / # /lava-10937530/bin/lava-test-runner /la=
va-10937530/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2d991b255eb9e7edad1b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2d991b255eb9e7edad24
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-28T12:54:31.867507  <8>[   10.643445] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10937501_1.4.2.3.1>

    2023-06-28T12:54:31.871191  + set +x

    2023-06-28T12:54:31.976780  #

    2023-06-28T12:54:31.978137  =


    2023-06-28T12:54:32.080096  / # #export SHELL=3D/bin/sh

    2023-06-28T12:54:32.080928  =


    2023-06-28T12:54:32.182667  / # export SHELL=3D/bin/sh. /lava-10937501/=
environment

    2023-06-28T12:54:32.183458  =


    2023-06-28T12:54:32.285235  / # . /lava-10937501/environment/lava-10937=
501/bin/lava-test-runner /lava-10937501/1

    2023-06-28T12:54:32.286627  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2d8d1b85e3ff01edacec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2d8d1b85e3ff01edacf5
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-28T12:54:30.726266  + <8>[   10.428961] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10937495_1.4.2.3.1>

    2023-06-28T12:54:30.726383  set +x

    2023-06-28T12:54:30.827722  #

    2023-06-28T12:54:30.928559  / # #export SHELL=3D/bin/sh

    2023-06-28T12:54:30.928784  =


    2023-06-28T12:54:31.029341  / # export SHELL=3D/bin/sh. /lava-10937495/=
environment

    2023-06-28T12:54:31.029585  =


    2023-06-28T12:54:31.130162  / # . /lava-10937495/environment/lava-10937=
495/bin/lava-test-runner /lava-10937495/1

    2023-06-28T12:54:31.130534  =


    2023-06-28T12:54:31.135617  / # /lava-10937495/bin/lava-test-runner /la=
va-10937495/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2d8503d3409951edacce

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2d8503d3409951edacd7
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-28T12:54:11.506809  <8>[    8.029132] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10937539_1.4.2.3.1>

    2023-06-28T12:54:11.510250  + set +x

    2023-06-28T12:54:11.618881  / # #

    2023-06-28T12:54:11.721432  export SHELL=3D/bin/sh

    2023-06-28T12:54:11.722282  #

    2023-06-28T12:54:11.823762  / # export SHELL=3D/bin/sh. /lava-10937539/=
environment

    2023-06-28T12:54:11.824660  =


    2023-06-28T12:54:11.926187  / # . /lava-10937539/environment/lava-10937=
539/bin/lava-test-runner /lava-10937539/1

    2023-06-28T12:54:11.927472  =


    2023-06-28T12:54:11.932790  / # /lava-10937539/bin/lava-test-runner /la=
va-10937539/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2da3eabcdc9c82edace0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2da3eabcdc9c82edace9
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-28T12:54:40.753271  + set<8>[   11.224247] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10937523_1.4.2.3.1>

    2023-06-28T12:54:40.753363   +x

    2023-06-28T12:54:40.858087  / # #

    2023-06-28T12:54:40.958748  export SHELL=3D/bin/sh

    2023-06-28T12:54:40.958957  #

    2023-06-28T12:54:41.059501  / # export SHELL=3D/bin/sh. /lava-10937523/=
environment

    2023-06-28T12:54:41.059729  =


    2023-06-28T12:54:41.160273  / # . /lava-10937523/environment/lava-10937=
523/bin/lava-test-runner /lava-10937523/1

    2023-06-28T12:54:41.160577  =


    2023-06-28T12:54:41.165373  / # /lava-10937523/bin/lava-test-runner /la=
va-10937523/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2e0d1504f15401edad5a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2e0d1504f15401edad63
        failing since 148 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-28T12:56:35.261695  + set +x
    2023-06-28T12:56:35.261861  [    9.474740] <LAVA_SIGNAL_ENDRUN 0_dmesg =
989784_1.5.2.3.1>
    2023-06-28T12:56:35.369270  / # #
    2023-06-28T12:56:35.470810  export SHELL=3D/bin/sh
    2023-06-28T12:56:35.471234  #
    2023-06-28T12:56:35.572368  / # export SHELL=3D/bin/sh. /lava-989784/en=
vironment
    2023-06-28T12:56:35.572700  =

    2023-06-28T12:56:35.673882  / # . /lava-989784/environment/lava-989784/=
bin/lava-test-runner /lava-989784/1
    2023-06-28T12:56:35.674439  =

    2023-06-28T12:56:35.677297  / # /lava-989784/bin/lava-test-runner /lava=
-989784/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2da0f2d2315861edace6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2da0f2d2315861edacef
        failing since 91 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-28T12:54:33.827242  + set<8>[   10.867197] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10937486_1.4.2.3.1>

    2023-06-28T12:54:33.827765   +x

    2023-06-28T12:54:33.935151  / # #

    2023-06-28T12:54:34.037363  export SHELL=3D/bin/sh

    2023-06-28T12:54:34.038094  #

    2023-06-28T12:54:34.139385  / # export SHELL=3D/bin/sh. /lava-10937486/=
environment

    2023-06-28T12:54:34.139594  =


    2023-06-28T12:54:34.240097  / # . /lava-10937486/environment/lava-10937=
486/bin/lava-test-runner /lava-10937486/1

    2023-06-28T12:54:34.240401  =


    2023-06-28T12:54:34.244923  / # /lava-10937486/bin/lava-test-runner /la=
va-10937486/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c314ae44c65d713edacfa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c314ae44c65d713edad03
        failing since 20 days (last pass: v5.15.72-38-gebe70cd7f5413, first=
 fail: v5.15.114-196-g00621f2608ac)

    2023-06-28T13:10:22.486137  [   15.993886] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3697865_1.5.2.4.1>
    2023-06-28T13:10:22.589719  =

    2023-06-28T13:10:22.589870  / # #[   16.092980] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-28T13:10:22.691028  export SHELL=3D/bin/sh
    2023-06-28T13:10:22.691548  =

    2023-06-28T13:10:22.792914  / # export SHELL=3D/bin/sh. /lava-3697865/e=
nvironment
    2023-06-28T13:10:22.793296  =

    2023-06-28T13:10:22.894423  / # . /lava-3697865/environment/lava-369786=
5/bin/lava-test-runner /lava-3697865/1
    2023-06-28T13:10:22.894918  =

    2023-06-28T13:10:22.898282  / # /lava-3697865/bin/lava-test-runner /lav=
a-3697865/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c32949e2d3b3e9eedacd2

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c32949e2d3b3e9eedad01
        failing since 162 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-28T13:15:44.002416  + set +x
    2023-06-28T13:15:44.006548  <8>[   16.206226] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3697847_1.5.2.4.1>
    2023-06-28T13:15:44.126657  / # #
    2023-06-28T13:15:44.232257  export SHELL=3D/bin/sh
    2023-06-28T13:15:44.233772  #
    2023-06-28T13:15:44.337122  / # export SHELL=3D/bin/sh. /lava-3697847/e=
nvironment
    2023-06-28T13:15:44.338626  =

    2023-06-28T13:15:44.442072  / # . /lava-3697847/environment/lava-369784=
7/bin/lava-test-runner /lava-3697847/1
    2023-06-28T13:15:44.444756  =

    2023-06-28T13:15:44.448074  / # /lava-3697847/bin/lava-test-runner /lav=
a-3697847/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c3158541e280a0eedacd1

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
19/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c3159541e280a0eedacfe
        failing since 162 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-28T13:10:20.164823  + set +x
    2023-06-28T13:10:20.168810  <8>[   16.212468] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 672780_1.5.2.4.1>
    2023-06-28T13:10:20.279864  / # #
    2023-06-28T13:10:20.382823  export SHELL=3D/bin/sh
    2023-06-28T13:10:20.383626  #
    2023-06-28T13:10:20.486028  / # export SHELL=3D/bin/sh. /lava-672780/en=
vironment
    2023-06-28T13:10:20.486743  =

    2023-06-28T13:10:20.589217  / # . /lava-672780/environment/lava-672780/=
bin/lava-test-runner /lava-672780/1
    2023-06-28T13:10:20.590356  =

    2023-06-28T13:10:20.594820  / # /lava-672780/bin/lava-test-runner /lava=
-672780/1 =

    ... (12 line(s) more)  =

 =20
