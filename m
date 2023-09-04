Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCBC79166E
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 13:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjIDLsT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242529AbjIDLsM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 07:48:12 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C60CCCE
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 04:47:58 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1cd327d7cc1so1103311fac.3
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 04:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693828077; x=1694432877; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+/qtU7cjV6b+r0iDOHepc8NYQaUBqyXQQhQIuQs16vI=;
        b=neTC5CwmQEBl/X7kJHA7h7H7IJEfGhOIj9nkEYzvIs7EIvjK7HJmyKhD8SleCwXxOz
         cA/+9PBZG3g3lUvGQ8aHo/pPxjRjH5OHO61B4uI1Wbuf5kqQsBTUNKEpQ0cTwOq2kZP7
         MYaEEqiT9655z6xKvKbacR/2o6ygHj8OFGXxu7GbqthwCs9DFNjS39JMxileSYF5jzae
         TcSWm2nUoCRCVKUloECdARJgATsCRacAmsyzZ6xbgaJUww1oXQ7CnfKT/tkqzxX+CNPA
         RhNvRZ/abtzJarJaLzHz9bhF9Oc3YdXsEXwdIogHgBVTvlKeRackKLPYSYDLgrO7E4S6
         xyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693828077; x=1694432877;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/qtU7cjV6b+r0iDOHepc8NYQaUBqyXQQhQIuQs16vI=;
        b=N/b0aahWfV1x1VZNZdn+xD5SB08OXds+XK4SifZOHmaXvLrjheF99o1wSSOU1q5XDA
         5iEzAcnrF32nin9HdGSkkqMRuV4sOE2miJ02rvAre+Nk9sUJAnwlNr63LwQGwQkjJS5F
         2mj+mHjEwg0YtekTyrqzBnVd38IUf2rnOA9mSGJ0C4uqLsfQOsuRrWkISVY3DY5v7iI1
         GJWFdvJD8XCaXI5jDzDZelxc/SKsgfuCf3pDiQQG/TbHdlHk89KDVSgGlYYvE4+XBG/V
         Cz3Yd436bis285noLldaEfyrPsp91s03icPwv9bYjedttJNQDQPj8e2ei6XQ/4/q07gL
         rsVw==
X-Gm-Message-State: AOJu0Yxazk+rWswdmTl0rIwt2R9oM0vA5Drn06pYIJtbnvZPXGrmGHzI
        nlN6h0EhAD278QEjo4EO/k8K2WBWrITZY7PhJW8=
X-Google-Smtp-Source: AGHT+IGRQZjcRTht3AO5TSh7ZlSu5W0SahIf2D756kK7DwshvtYR1JAGiaq2e1RZj0HCtBGAfwcd8Q==
X-Received: by 2002:a05:6870:a50a:b0:187:e563:77b9 with SMTP id o10-20020a056870a50a00b00187e56377b9mr12796353oal.45.1693828077266;
        Mon, 04 Sep 2023 04:47:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q22-20020a638c56000000b00565f9694561sm7435016pgn.21.2023.09.04.04.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 04:47:56 -0700 (PDT)
Message-ID: <64f5c3ec.630a0220.58388.e360@mx.google.com>
Date:   Mon, 04 Sep 2023 04:47:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.51-32-g652995c5153b
Subject: stable-rc/linux-6.1.y baseline: 121 runs,
 10 regressions (v6.1.51-32-g652995c5153b)
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

stable-rc/linux-6.1.y baseline: 121 runs, 10 regressions (v6.1.51-32-g65299=
5c5153b)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.51-32-g652995c5153b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.51-32-g652995c5153b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      652995c5153b4cd24238c240f723afee17f8ce7e =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f591f2a43bece2bf286e2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f591f2a43bece2bf286=
e2b
        failing since 1 day (last pass: v6.1.50-11-g1767553758a66, first fa=
il: v6.1.51) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f59102cc6673ef9f286d6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f59102cc6673ef9f286d73
        failing since 157 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T08:11:29.497273  + set +x

    2023-09-04T08:11:29.503716  <8>[   10.116957] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11428319_1.4.2.3.1>

    2023-09-04T08:11:29.605848  #

    2023-09-04T08:11:29.606148  =


    2023-09-04T08:11:29.706714  / # #export SHELL=3D/bin/sh

    2023-09-04T08:11:29.706957  =


    2023-09-04T08:11:29.807515  / # export SHELL=3D/bin/sh. /lava-11428319/=
environment

    2023-09-04T08:11:29.807816  =


    2023-09-04T08:11:29.908419  / # . /lava-11428319/environment/lava-11428=
319/bin/lava-test-runner /lava-11428319/1

    2023-09-04T08:11:29.908785  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f590fc63b8a2e909286d6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f590fc63b8a2e909286d73
        failing since 157 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T08:10:21.864049  + set<8>[   10.987419] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11428330_1.4.2.3.1>

    2023-09-04T08:10:21.864153   +x

    2023-09-04T08:10:21.968500  / # #

    2023-09-04T08:10:22.069149  export SHELL=3D/bin/sh

    2023-09-04T08:10:22.069369  #

    2023-09-04T08:10:22.169908  / # export SHELL=3D/bin/sh. /lava-11428330/=
environment

    2023-09-04T08:10:22.170131  =


    2023-09-04T08:10:22.270675  / # . /lava-11428330/environment/lava-11428=
330/bin/lava-test-runner /lava-11428330/1

    2023-09-04T08:10:22.270991  =


    2023-09-04T08:10:22.275470  / # /lava-11428330/bin/lava-test-runner /la=
va-11428330/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f591011d2f241f2b286d8e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f591011d2f241f2b286d93
        failing since 157 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T08:10:36.035620  <8>[   10.339898] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11428283_1.4.2.3.1>

    2023-09-04T08:10:36.039049  + set +x

    2023-09-04T08:10:36.142566  =


    2023-09-04T08:10:36.243705  / # #export SHELL=3D/bin/sh

    2023-09-04T08:10:36.244222  =


    2023-09-04T08:10:36.345371  / # export SHELL=3D/bin/sh. /lava-11428283/=
environment

    2023-09-04T08:10:36.346138  =


    2023-09-04T08:10:36.447539  / # . /lava-11428283/environment/lava-11428=
283/bin/lava-test-runner /lava-11428283/1

    2023-09-04T08:10:36.448631  =


    2023-09-04T08:10:36.453399  / # /lava-11428283/bin/lava-test-runner /la=
va-11428283/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f590f30a3be84289286dba

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f590f30a3be84289286dbf
        failing since 157 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T08:10:20.195399  + set +x

    2023-09-04T08:10:20.201822  <8>[   10.388427] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11428329_1.4.2.3.1>

    2023-09-04T08:10:20.306360  / # #

    2023-09-04T08:10:20.406948  export SHELL=3D/bin/sh

    2023-09-04T08:10:20.407186  #

    2023-09-04T08:10:20.507813  / # export SHELL=3D/bin/sh. /lava-11428329/=
environment

    2023-09-04T08:10:20.508020  =


    2023-09-04T08:10:20.608620  / # . /lava-11428329/environment/lava-11428=
329/bin/lava-test-runner /lava-11428329/1

    2023-09-04T08:10:20.608943  =


    2023-09-04T08:10:20.613967  / # /lava-11428329/bin/lava-test-runner /la=
va-11428329/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f5910563b8a2e909286d95

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f5910563b8a2e909286d9a
        failing since 157 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T08:10:27.320978  + <8>[   11.343137] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11428297_1.4.2.3.1>

    2023-09-04T08:10:27.321502  set +x

    2023-09-04T08:10:27.429336  / # #

    2023-09-04T08:10:27.531438  export SHELL=3D/bin/sh

    2023-09-04T08:10:27.532274  #

    2023-09-04T08:10:27.633729  / # export SHELL=3D/bin/sh. /lava-11428297/=
environment

    2023-09-04T08:10:27.634533  =


    2023-09-04T08:10:27.736232  / # . /lava-11428297/environment/lava-11428=
297/bin/lava-test-runner /lava-11428297/1

    2023-09-04T08:10:27.737435  =


    2023-09-04T08:10:27.742604  / # /lava-11428297/bin/lava-test-runner /la=
va-11428297/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f5902977dc6cef43286e00

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx=
6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx=
6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f5902977dc6cef43286e05
        new failure (last pass: v6.1.51)

    2023-09-04T08:06:41.311490  + set[   14.922312] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 999429_1.5.2.3.1>
    2023-09-04T08:06:41.311709   +x
    2023-09-04T08:06:41.417414  / # #
    2023-09-04T08:06:41.519063  export SHELL=3D/bin/sh
    2023-09-04T08:06:41.519569  #
    2023-09-04T08:06:41.620870  / # export SHELL=3D/bin/sh. /lava-999429/en=
vironment
    2023-09-04T08:06:41.621364  =

    2023-09-04T08:06:41.722645  / # . /lava-999429/environment/lava-999429/=
bin/lava-test-runner /lava-999429/1
    2023-09-04T08:06:41.723257  =

    2023-09-04T08:06:41.726141  / # /lava-999429/bin/lava-test-runner /lava=
-999429/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f5910a1d2f241f2b286db2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f5910a1d2f241f2b286db7
        failing since 157 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-04T08:10:30.631838  <8>[   10.869295] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11428328_1.4.2.3.1>

    2023-09-04T08:10:30.736038  / # #

    2023-09-04T08:10:30.836684  export SHELL=3D/bin/sh

    2023-09-04T08:10:30.836877  #

    2023-09-04T08:10:30.937392  / # export SHELL=3D/bin/sh. /lava-11428328/=
environment

    2023-09-04T08:10:30.937568  =


    2023-09-04T08:10:31.038181  / # . /lava-11428328/environment/lava-11428=
328/bin/lava-test-runner /lava-11428328/1

    2023-09-04T08:10:31.038430  =


    2023-09-04T08:10:31.043330  / # /lava-11428328/bin/lava-test-runner /la=
va-11428328/1

    2023-09-04T08:10:31.050681  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f58f45bf8c875eda286db4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f58f45bf8c875eda286db9
        failing since 48 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-04T08:04:27.391408  / # #

    2023-09-04T08:04:28.468601  export SHELL=3D/bin/sh

    2023-09-04T08:04:28.469919  #

    2023-09-04T08:04:29.958756  / # export SHELL=3D/bin/sh. /lava-11428143/=
environment

    2023-09-04T08:04:29.960550  =


    2023-09-04T08:04:32.683083  / # . /lava-11428143/environment/lava-11428=
143/bin/lava-test-runner /lava-11428143/1

    2023-09-04T08:04:32.685279  =


    2023-09-04T08:04:32.690894  / # /lava-11428143/bin/lava-test-runner /la=
va-11428143/1

    2023-09-04T08:04:32.753704  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T08:04:32.754205  + cd /lava-114281<8>[   28.450968] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11428143_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f58f1bb9db795226286d7c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51-=
32-g652995c5153b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f58f1bb9db795226286d81
        failing since 48 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-04T08:04:03.026373  / # #

    2023-09-04T08:04:03.128741  export SHELL=3D/bin/sh

    2023-09-04T08:04:03.129024  #

    2023-09-04T08:04:03.229964  / # export SHELL=3D/bin/sh. /lava-11428146/=
environment

    2023-09-04T08:04:03.230683  =


    2023-09-04T08:04:03.332149  / # . /lava-11428146/environment/lava-11428=
146/bin/lava-test-runner /lava-11428146/1

    2023-09-04T08:04:03.333286  =


    2023-09-04T08:04:03.377453  / # /lava-11428146/bin/lava-test-runner /la=
va-11428146/1

    2023-09-04T08:04:03.377961  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T08:04:03.413812  + cd /lava-1142814<8>[   18.749638] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11428146_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
