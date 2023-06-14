Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EF730162
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 16:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245443AbjFNOMf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 10:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245444AbjFNOMd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 10:12:33 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D785CD
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:12:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39cd0c3e8deso2716563b6e.1
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686751949; x=1689343949;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/jUx02tPOxPX3v/bdYw6B5LzWpDGe0IJX7/KdGNpICY=;
        b=m5eZV0vpMoiwa+6wE6PUhbJEFzUGMdFh8rm/IYgOJDyQjaa4eCqP+9E32ffVwYxD/1
         hdR8rBfuyMp8EbBQUWtjTHyhqxSG0yoguuGqHJmv0sH/tIT/OQaqz4rkrAm51645Nrez
         aK6+eDTDnw5+lucuXNQSpagtjUbVRo7xTqHK4lbtBv8M9rqePTUZ8MWlmyOhPXpNDUl5
         7pxF4ZR8UrayjAUHCNzgaG/1+tb8SPjRc9OLQT+Xnel7FDLVZsdsJiQ3teyRaOaFbNxL
         S6iF89MxCEpDyWjMk0nSkAm0SCq/CHn3FB6bmmWSfktNOZZehkWzETI6yZre0rsmtXCc
         V70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686751949; x=1689343949;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jUx02tPOxPX3v/bdYw6B5LzWpDGe0IJX7/KdGNpICY=;
        b=PO+QG3Kpdb0Z7bbj2H5/6DJWWbfUHL6pSJPQKAD3KE8yYUGx/Y2UV+vrFTGOWx1cWW
         XyivTUXwtA0FiMFsmqDvSe66BIe/vqlwaC1EfoigKx6XtJG+MHglrQCgK0KCwu2U886x
         X8e2G4bDlpSq1Ixxi9OGivTDiLHRLiIvnxOB0dmhkLfMDe7e1GOMbz2lYzCqv/0qXQsB
         vJq68qgj6xLz/AjZ0gZnPmjgKi8AleML5eowAxQP2PpqqstUyCBa2/DaWD+wAYOz8pZK
         h0Il6hPGfWOsDl3bw31qUXSZ2bJg4ZUGlYml/X2tXK1gCTbqsYa0xg23gLW052hDJ3dc
         cGqQ==
X-Gm-Message-State: AC+VfDyjPBRpXhcGvlW1M5X28F/S9Poky4Uy7IPv/IUzBBiGqYfYydi8
        vZLPrkF/3dVszMrEeUOkI3pHzh++vxq40JEFp6w3/w==
X-Google-Smtp-Source: ACHHUZ4LJPbaWg6s9mbCqgcPVcQ5bTnjBVF3SeEadzlrODhXeRqeuISbldwLRrW7vLswsm4xhBKNTg==
X-Received: by 2002:a05:6808:2221:b0:39a:7830:f250 with SMTP id bd33-20020a056808222100b0039a7830f250mr13151802oib.1.1686751947995;
        Wed, 14 Jun 2023 07:12:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j24-20020a17090a589800b0023b3d80c76csm11073791pji.4.2023.06.14.07.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:12:27 -0700 (PDT)
Message-ID: <6489cacb.170a0220.5c0c5.6dd9@mx.google.com>
Date:   Wed, 14 Jun 2023 07:12:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.117
Subject: stable/linux-5.15.y baseline: 159 runs, 23 regressions (v5.15.117)
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

stable/linux-5.15.y baseline: 159 runs, 23 regressions (v5.15.117)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 4          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.117/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.117
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      471e639e59d128f4bf58000a118b2ceca3893f98 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64899199a8ef7fbb43306156

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899199a8ef7fbb4330615b
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:08:16.997105  <8>[   11.678199] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10722368_1.4.2.3.1>

    2023-06-14T10:08:17.000031  + set +x

    2023-06-14T10:08:17.101371  /#

    2023-06-14T10:08:17.202136   # #export SHELL=3D/bin/sh

    2023-06-14T10:08:17.202309  =


    2023-06-14T10:08:17.302846  / # export SHELL=3D/bin/sh. /lava-10722368/=
environment

    2023-06-14T10:08:17.303025  =


    2023-06-14T10:08:17.403587  / # . /lava-10722368/environment/lava-10722=
368/bin/lava-test-runner /lava-10722368/1

    2023-06-14T10:08:17.403871  =


    2023-06-14T10:08:17.409701  / # /lava-10722368/bin/lava-test-runner /la=
va-10722368/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/648999084943461f1f30613d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648999084943461f1f306142
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:40:00.400113  + set +x

    2023-06-14T10:40:00.406909  <8>[   12.048650] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10722821_1.4.2.3.1>

    2023-06-14T10:40:00.514503  / # #

    2023-06-14T10:40:00.616832  export SHELL=3D/bin/sh

    2023-06-14T10:40:00.617592  #

    2023-06-14T10:40:00.719055  / # export SHELL=3D/bin/sh. /lava-10722821/=
environment

    2023-06-14T10:40:00.719803  =


    2023-06-14T10:40:00.821287  / # . /lava-10722821/environment/lava-10722=
821/bin/lava-test-runner /lava-10722821/1

    2023-06-14T10:40:00.822328  =


    2023-06-14T10:40:00.827680  / # /lava-10722821/bin/lava-test-runner /la=
va-10722821/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489917e066307fbb430612f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489917e066307fbb4306134
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:07:51.178572  + set<8>[   11.541705] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10722417_1.4.2.3.1>

    2023-06-14T10:07:51.179183   +x

    2023-06-14T10:07:51.287563  / # #

    2023-06-14T10:07:51.390249  export SHELL=3D/bin/sh

    2023-06-14T10:07:51.390993  #

    2023-06-14T10:07:51.492640  / # export SHELL=3D/bin/sh. /lava-10722417/=
environment

    2023-06-14T10:07:51.493437  =


    2023-06-14T10:07:51.595190  / # . /lava-10722417/environment/lava-10722=
417/bin/lava-test-runner /lava-10722417/1

    2023-06-14T10:07:51.596464  =


    2023-06-14T10:07:51.601358  / # /lava-10722417/bin/lava-test-runner /la=
va-10722417/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489990c74887f21c4306142

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489990c74887f21c4306147
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:40:00.806545  + <8>[   12.427040] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10722847_1.4.2.3.1>

    2023-06-14T10:40:00.807087  set +x

    2023-06-14T10:40:00.914251  / # #

    2023-06-14T10:40:01.016638  export SHELL=3D/bin/sh

    2023-06-14T10:40:01.017376  #

    2023-06-14T10:40:01.118897  / # export SHELL=3D/bin/sh. /lava-10722847/=
environment

    2023-06-14T10:40:01.119682  =


    2023-06-14T10:40:01.221322  / # . /lava-10722847/environment/lava-10722=
847/bin/lava-test-runner /lava-10722847/1

    2023-06-14T10:40:01.222474  =


    2023-06-14T10:40:01.227142  / # /lava-10722847/bin/lava-test-runner /la=
va-10722847/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64899192486ee6b25930613f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899192486ee6b259306144
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:07:56.532883  <8>[   10.265952] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10722414_1.4.2.3.1>

    2023-06-14T10:07:56.536537  + set +x

    2023-06-14T10:07:56.638095  =


    2023-06-14T10:07:56.738684  / # #export SHELL=3D/bin/sh

    2023-06-14T10:07:56.738906  =


    2023-06-14T10:07:56.839405  / # export SHELL=3D/bin/sh. /lava-10722414/=
environment

    2023-06-14T10:07:56.839620  =


    2023-06-14T10:07:56.940118  / # . /lava-10722414/environment/lava-10722=
414/bin/lava-test-runner /lava-10722414/1

    2023-06-14T10:07:56.940425  =


    2023-06-14T10:07:56.945935  / # /lava-10722414/bin/lava-test-runner /la=
va-10722414/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489991d3f85940d03306133

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489991d3f85940d03306138
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:40:24.724763  <8>[   11.890093] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10722857_1.4.2.3.1>

    2023-06-14T10:40:24.728259  + set +x

    2023-06-14T10:40:24.829683  =


    2023-06-14T10:40:24.930230  / # #export SHELL=3D/bin/sh

    2023-06-14T10:40:24.930438  =


    2023-06-14T10:40:25.030956  / # export SHELL=3D/bin/sh. /lava-10722857/=
environment

    2023-06-14T10:40:25.031246  =


    2023-06-14T10:40:25.131792  / # . /lava-10722857/environment/lava-10722=
857/bin/lava-test-runner /lava-10722857/1

    2023-06-14T10:40:25.132102  =


    2023-06-14T10:40:25.137120  / # /lava-10722857/bin/lava-test-runner /la=
va-10722857/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64899225bc75eb37bd30614d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64899225bc75eb37bd306=
14e
        failing since 69 days (last pass: v5.15.105, first fail: v5.15.106) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489932db0d01b1de0306151

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489932db0d01b1de0306156
        failing since 146 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-06-14T10:14:48.914270  + set +x<8>[   10.029705] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3663706_1.5.2.4.1>
    2023-06-14T10:14:48.914476  =

    2023-06-14T10:14:49.017635  / # #
    2023-06-14T10:14:49.119100  export SHELL=3D/bin/sh
    2023-06-14T10:14:49.119483  #
    2023-06-14T10:14:49.119660  / # <3>[   10.193566] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-06-14T10:14:49.220755  export SHELL=3D/bin/sh. /lava-3663706/envir=
onment
    2023-06-14T10:14:49.221130  =

    2023-06-14T10:14:49.322296  / # . /lava-3663706/environment/lava-366370=
6/bin/lava-test-runner /lava-3663706/1
    2023-06-14T10:14:49.322870   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648991aaa150aef9c5306159

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648991aaa150aef9c530615e
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:08:33.122576  + set +x

    2023-06-14T10:08:33.129368  <8>[   10.737510] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10722385_1.4.2.3.1>

    2023-06-14T10:08:33.236647  / # #

    2023-06-14T10:08:33.338683  export SHELL=3D/bin/sh

    2023-06-14T10:08:33.339428  #

    2023-06-14T10:08:33.440873  / # export SHELL=3D/bin/sh. /lava-10722385/=
environment

    2023-06-14T10:08:33.441531  =


    2023-06-14T10:08:33.542863  / # . /lava-10722385/environment/lava-10722=
385/bin/lava-test-runner /lava-10722385/1

    2023-06-14T10:08:33.544011  =


    2023-06-14T10:08:33.548751  / # /lava-10722385/bin/lava-test-runner /la=
va-10722385/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489990974887f21c4306131

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489990974887f21c4306136
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:39:43.642114  + set +x<8>[   35.686023] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10722844_1.4.2.3.1>

    2023-06-14T10:39:43.642201  =


    2023-06-14T10:39:43.746777  / # #

    2023-06-14T10:39:43.847421  export SHELL=3D/bin/sh

    2023-06-14T10:39:43.847606  #

    2023-06-14T10:39:43.948145  / # export SHELL=3D/bin/sh. /lava-10722844/=
environment

    2023-06-14T10:39:43.948328  =


    2023-06-14T10:39:44.048883  / # . /lava-10722844/environment/lava-10722=
844/bin/lava-test-runner /lava-10722844/1

    2023-06-14T10:39:44.049162  =


    2023-06-14T10:39:44.053365  / # /lava-10722844/bin/lava-test-runner /la=
va-10722844/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489917d568789e913306133

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489917d568789e913306138
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:07:36.480635  <8>[   10.828323] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10722401_1.4.2.3.1>

    2023-06-14T10:07:36.484709  + set +x

    2023-06-14T10:07:36.588892  / # #

    2023-06-14T10:07:36.689548  export SHELL=3D/bin/sh

    2023-06-14T10:07:36.689754  #

    2023-06-14T10:07:36.790309  / # export SHELL=3D/bin/sh. /lava-10722401/=
environment

    2023-06-14T10:07:36.790527  =


    2023-06-14T10:07:36.891078  / # . /lava-10722401/environment/lava-10722=
401/bin/lava-test-runner /lava-10722401/1

    2023-06-14T10:07:36.891416  =


    2023-06-14T10:07:36.896720  / # /lava-10722401/bin/lava-test-runner /la=
va-10722401/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/648998e60e53913134306143

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648998e60e53913134306148
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:39:27.275294  + <8>[   11.425888] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10722834_1.4.2.3.1>

    2023-06-14T10:39:27.275725  set +x

    2023-06-14T10:39:27.381107  =


    2023-06-14T10:39:27.482854  / # #export SHELL=3D/bin/sh

    2023-06-14T10:39:27.483467  =


    2023-06-14T10:39:27.584856  / # export SHELL=3D/bin/sh. /lava-10722834/=
environment

    2023-06-14T10:39:27.585477  =


    2023-06-14T10:39:27.686964  / # . /lava-10722834/environment/lava-10722=
834/bin/lava-test-runner /lava-10722834/1

    2023-06-14T10:39:27.688077  =


    2023-06-14T10:39:27.693978  / # /lava-10722834/bin/lava-test-runner /la=
va-10722834/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489917a9e20c54b78306170

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489917a9e20c54b78306175
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:07:46.508721  + <8>[   11.420807] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10722380_1.4.2.3.1>

    2023-06-14T10:07:46.508806  set +x

    2023-06-14T10:07:46.612152  / # #

    2023-06-14T10:07:46.712823  export SHELL=3D/bin/sh

    2023-06-14T10:07:46.713378  #

    2023-06-14T10:07:46.814508  / # export SHELL=3D/bin/sh. /lava-10722380/=
environment

    2023-06-14T10:07:46.815264  =


    2023-06-14T10:07:46.916744  / # . /lava-10722380/environment/lava-10722=
380/bin/lava-test-runner /lava-10722380/1

    2023-06-14T10:07:46.918030  =


    2023-06-14T10:07:46.923614  / # /lava-10722380/bin/lava-test-runner /la=
va-10722380/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64899918130e822bea306193

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899918130e822bea306198
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:40:14.814462  + <8>[   12.283132] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10722858_1.4.2.3.1>

    2023-06-14T10:40:14.814560  set +x

    2023-06-14T10:40:14.918704  / # #

    2023-06-14T10:40:15.019285  export SHELL=3D/bin/sh

    2023-06-14T10:40:15.019463  #

    2023-06-14T10:40:15.119967  / # export SHELL=3D/bin/sh. /lava-10722858/=
environment

    2023-06-14T10:40:15.120146  =


    2023-06-14T10:40:15.220669  / # . /lava-10722858/environment/lava-10722=
858/bin/lava-test-runner /lava-10722858/1

    2023-06-14T10:40:15.220949  =


    2023-06-14T10:40:15.226167  / # /lava-10722858/bin/lava-test-runner /la=
va-10722858/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64899283cbd517ae30306159

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64899283cbd517ae3030615e
        failing since 133 days (last pass: v5.15.81, first fail: v5.15.91)

    2023-06-14T10:12:12.405714  + set +x
    2023-06-14T10:12:12.405916  [    9.447729] <LAVA_SIGNAL_ENDRUN 0_dmesg =
977053_1.5.2.3.1>
    2023-06-14T10:12:12.513493  / # #
    2023-06-14T10:12:12.614956  export SHELL=3D/bin/sh
    2023-06-14T10:12:12.615503  #
    2023-06-14T10:12:12.716828  / # export SHELL=3D/bin/sh. /lava-977053/en=
vironment
    2023-06-14T10:12:12.717332  =

    2023-06-14T10:12:12.818546  / # . /lava-977053/environment/lava-977053/=
bin/lava-test-runner /lava-977053/1
    2023-06-14T10:12:12.819131  =

    2023-06-14T10:12:12.822352  / # /lava-977053/bin/lava-test-runner /lava=
-977053/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648991699e20c54b78306131

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648991699e20c54b78306136
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:07:21.903653  <8>[   11.747864] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10722370_1.4.2.3.1>

    2023-06-14T10:07:22.008044  / # #

    2023-06-14T10:07:22.108662  export SHELL=3D/bin/sh

    2023-06-14T10:07:22.108850  #

    2023-06-14T10:07:22.209363  / # export SHELL=3D/bin/sh. /lava-10722370/=
environment

    2023-06-14T10:07:22.209551  =


    2023-06-14T10:07:22.310073  / # . /lava-10722370/environment/lava-10722=
370/bin/lava-test-runner /lava-10722370/1

    2023-06-14T10:07:22.310396  =


    2023-06-14T10:07:22.315147  / # /lava-10722370/bin/lava-test-runner /la=
va-10722370/1

    2023-06-14T10:07:22.320845  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/648998ee7abe278a7a30612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648998ee7abe278a7a306133
        failing since 75 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-14T10:39:42.075074  + <8>[   12.880377] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10722825_1.4.2.3.1>

    2023-06-14T10:39:42.075661  set +x

    2023-06-14T10:39:42.183496  / # #

    2023-06-14T10:39:42.286155  export SHELL=3D/bin/sh

    2023-06-14T10:39:42.286976  #

    2023-06-14T10:39:42.388430  / # export SHELL=3D/bin/sh. /lava-10722825/=
environment

    2023-06-14T10:39:42.389248  =


    2023-06-14T10:39:42.490862  / # . /lava-10722825/environment/lava-10722=
825/bin/lava-test-runner /lava-10722825/1

    2023-06-14T10:39:42.492128  =


    2023-06-14T10:39:42.497274  / # /lava-10722825/bin/lava-test-runner /la=
va-10722825/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64899a611cdf23f13c30613e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64899a611cdf23f13c306=
13f
        failing since 141 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 4          =


  Details:     https://kernelci.org/test/plan/id/648999ae0bf6158ca730614c

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/648999ae0bf6158ca730615d
        failing since 33 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-06-14T10:42:24.388600  /lava-10722888/1/../bin/lava-test-case

    2023-06-14T10:42:24.406191  <8>[   69.934008] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/648999ae0bf6158ca730615d
        failing since 33 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-06-14T10:42:24.388600  /lava-10722888/1/../bin/lava-test-case

    2023-06-14T10:42:24.406191  <8>[   69.934008] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/648999ae0bf6158ca730618c
        failing since 33 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-06-14T10:42:23.276822  /lava-10722888/1/../bin/lava-test-case

    2023-06-14T10:42:23.295428  <8>[   68.822695] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648999ae0bf6158ca73061f0
        failing since 33 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-06-14T10:42:04.129835  + set +x<8>[   49.661439] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10722888_1.5.2.3.1>

    2023-06-14T10:42:04.133412  =


    2023-06-14T10:42:04.243387  / # #

    2023-06-14T10:42:04.345942  export SHELL=3D/bin/sh

    2023-06-14T10:42:04.346752  #

    2023-06-14T10:42:04.448348  / # export SHELL=3D/bin/sh. /lava-10722888/=
environment

    2023-06-14T10:42:04.449138  =


    2023-06-14T10:42:04.550650  / # . /lava-10722888/environment/lava-10722=
888/bin/lava-test-runner /lava-10722888/1

    2023-06-14T10:42:04.552230  =


    2023-06-14T10:42:04.557522  / # /lava-10722888/bin/lava-test-runner /la=
va-10722888/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6489921928b3f02a563061e3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.=
txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.117/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489921928b3f02a563061e8
        failing since 132 days (last pass: v5.15.82, first fail: v5.15.91)

    2023-06-14T10:09:51.733828  <8>[    5.882395] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3663679_1.5.2.4.1>
    2023-06-14T10:09:51.853052  / # #
    2023-06-14T10:09:51.958645  export SHELL=3D/bin/sh
    2023-06-14T10:09:51.960647  #
    2023-06-14T10:09:52.064166  / # export SHELL=3D/bin/sh. /lava-3663679/e=
nvironment
    2023-06-14T10:09:52.066117  =

    2023-06-14T10:09:52.169800  / # . /lava-3663679/environment/lava-366367=
9/bin/lava-test-runner /lava-3663679/1
    2023-06-14T10:09:52.172497  =

    2023-06-14T10:09:52.178734  / # /lava-3663679/bin/lava-test-runner /lav=
a-3663679/1
    2023-06-14T10:09:52.309411  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
