Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7F7A35CA
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 16:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjIQOPg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 10:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjIQOPR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 10:15:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E011D
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 07:15:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2749ce1aa37so1382029a91.0
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694960110; x=1695564910; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6oPSWyBs8KV1Y7npqhXwRkKeKpqm2nv21aTreyrdUVY=;
        b=rMI3grIXpfiCy03YZ9ccz14fAHgBfQxR3LWtgBWudSj59XyTWO4itcfiJTeI3h591X
         NdLBq9R1/Wh7vKjCrq+xpTRX6UFVp8pi4DcjIy2zNEIjsUiBkpZ92lLJnOeMDRQ54do9
         qW6dmMfO2S/k+F1omeU20asFHJzrr/gL/T+CHZzCrEtdjYVLKhFKSOGGjrdxB3lJSv4q
         6qeSEqxBTQm/cdKUHZaSP3UkJ+H4E2fORE+Q5dGrSyntCk7vhqFv4C9YO7OvcIewfXdJ
         rLpKVJjCqbhMhH4LqW4fgN9LT4wLXduMQ1nE7qDTkkmqcgI/JNzUBZE0sk1bhJxoLuLh
         aW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694960110; x=1695564910;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6oPSWyBs8KV1Y7npqhXwRkKeKpqm2nv21aTreyrdUVY=;
        b=ZwryN6gEZwJgv53TENqmY2hWhdHu2Gpe9ywnC8KZiIvfbltTLVDwuh1252Vfbod4L2
         7XvzhopLzTpD0NR7qrOX2bXuxRRcl9vUMPrc//3cYWAkDyojQ22uwa5LbSw0UA37/y2v
         JX8JVzqJX9EClsg8MG62BITpZPLqy+aI81Ni3plEzY8ZxJc9SKVVTQ177OEVLkb/KUeH
         XjotdTZfOX22dfsx3PbJe9pkKVAqXrnqz0RXnclR8UxDjF1UVo3jN2Nv5ozt/opFw6vC
         pR3oFZ69Ufvbk9Jgwjh92CsySe+oifuy77jPDUqNMkr9EKU9Gn/e12fQconm4uoKgw/P
         WPbw==
X-Gm-Message-State: AOJu0Yw46suosi+p8t891SwDDAaw4XZRxVdRBupD8VnGqEy7LCL2IUmd
        +m8PDxI4G2M8JaJR0WwvvUvnUCtJVS0Tr+vmjGHBmQ==
X-Google-Smtp-Source: AGHT+IExS7rmq2qU5KX2nnAAvTwDiNFp7Mj0OIyMVR+fWObdQS1gkxB7O6DgJhpaL1S/LSSZHWYm2Q==
X-Received: by 2002:a17:90a:5d92:b0:26b:374f:97c2 with SMTP id t18-20020a17090a5d9200b0026b374f97c2mr8960086pji.6.1694960110162;
        Sun, 17 Sep 2023 07:15:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iq15-20020a17090afb4f00b002636e5c224asm5718590pjb.56.2023.09.17.07.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 07:15:09 -0700 (PDT)
Message-ID: <650709ed.170a0220.30571.3ef0@mx.google.com>
Date:   Sun, 17 Sep 2023 07:15:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.131-512-g5662bcffcf54
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 113 runs,
 9 regressions (v5.15.131-512-g5662bcffcf54)
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

stable-rc/linux-5.15.y baseline: 113 runs, 9 regressions (v5.15.131-512-g56=
62bcffcf54)

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

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.131-512-g5662bcffcf54/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.131-512-g5662bcffcf54
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5662bcffcf542be2ea97b96df0479d1131aff96f =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506d3945b58d0b1258a0a42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506d3955b58d0b1258a0a4b
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-17T10:24:32.538999  <8>[   10.937284] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11553144_1.4.2.3.1>

    2023-09-17T10:24:32.542280  + set +x

    2023-09-17T10:24:32.646746  / # #

    2023-09-17T10:24:32.747483  export SHELL=3D/bin/sh

    2023-09-17T10:24:32.747715  #

    2023-09-17T10:24:32.848179  / # export SHELL=3D/bin/sh. /lava-11553144/=
environment

    2023-09-17T10:24:32.848354  =


    2023-09-17T10:24:32.948853  / # . /lava-11553144/environment/lava-11553=
144/bin/lava-test-runner /lava-11553144/1

    2023-09-17T10:24:32.949150  =


    2023-09-17T10:24:32.954351  / # /lava-11553144/bin/lava-test-runner /la=
va-11553144/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506d38cf48d18ea4d8a0a59

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506d38cf48d18ea4d8a0a62
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-17T10:22:51.074950  <8>[   10.585808] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11553139_1.4.2.3.1>

    2023-09-17T10:22:51.078378  + set +x

    2023-09-17T10:22:51.184692  =


    2023-09-17T10:22:51.286667  / # #export SHELL=3D/bin/sh

    2023-09-17T10:22:51.287471  =


    2023-09-17T10:22:51.388943  / # export SHELL=3D/bin/sh. /lava-11553139/=
environment

    2023-09-17T10:22:51.389633  =


    2023-09-17T10:22:51.491088  / # . /lava-11553139/environment/lava-11553=
139/bin/lava-test-runner /lava-11553139/1

    2023-09-17T10:22:51.492247  =


    2023-09-17T10:22:51.497130  / # /lava-11553139/bin/lava-test-runner /la=
va-11553139/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6506d916e7d33d0f3c8a0a7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6506d916e7d33d0f3c8a0=
a7e
        failing since 53 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506d3748ca824985d8a0a5b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506d3748ca824985d8a0a64
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-17T10:22:53.489321  <8>[   10.716982] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11553141_1.4.2.3.1>

    2023-09-17T10:22:53.492687  + set +x

    2023-09-17T10:22:53.594222  /#

    2023-09-17T10:22:53.695110   # #export SHELL=3D/bin/sh

    2023-09-17T10:22:53.695341  =


    2023-09-17T10:22:53.795875  / # export SHELL=3D/bin/sh. /lava-11553141/=
environment

    2023-09-17T10:22:53.796082  =


    2023-09-17T10:22:53.896629  / # . /lava-11553141/environment/lava-11553=
141/bin/lava-test-runner /lava-11553141/1

    2023-09-17T10:22:53.896986  =


    2023-09-17T10:22:53.902003  / # /lava-11553141/bin/lava-test-runner /la=
va-11553141/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506d393b1f28d4c2b8a0aa0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506d393b1f28d4c2b8a0aa9
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-17T10:22:54.416311  + set<8>[   11.074447] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11553132_1.4.2.3.1>

    2023-09-17T10:22:54.416401   +x

    2023-09-17T10:22:54.520667  / # #

    2023-09-17T10:22:54.621219  export SHELL=3D/bin/sh

    2023-09-17T10:22:54.621380  #

    2023-09-17T10:22:54.721873  / # export SHELL=3D/bin/sh. /lava-11553132/=
environment

    2023-09-17T10:22:54.722056  =


    2023-09-17T10:22:54.822596  / # . /lava-11553132/environment/lava-11553=
132/bin/lava-test-runner /lava-11553132/1

    2023-09-17T10:22:54.822894  =


    2023-09-17T10:22:54.828189  / # /lava-11553132/bin/lava-test-runner /la=
va-11553132/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6506d380b1f28d4c2b8a0a4f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506d380b1f28d4c2b8a0a58
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-17T10:22:40.552783  <8>[   12.165928] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11553168_1.4.2.3.1>

    2023-09-17T10:22:40.657470  / # #

    2023-09-17T10:22:40.758030  export SHELL=3D/bin/sh

    2023-09-17T10:22:40.758192  #

    2023-09-17T10:22:40.858708  / # export SHELL=3D/bin/sh. /lava-11553168/=
environment

    2023-09-17T10:22:40.858853  =


    2023-09-17T10:22:40.959413  / # . /lava-11553168/environment/lava-11553=
168/bin/lava-test-runner /lava-11553168/1

    2023-09-17T10:22:40.959634  =


    2023-09-17T10:22:40.964279  / # /lava-11553168/bin/lava-test-runner /la=
va-11553168/1

    2023-09-17T10:22:40.970068  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6506f33683418727c88a0a42

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506f33683418727c88a0a4b
        failing since 59 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-17T12:42:11.998914  / # #

    2023-09-17T12:42:12.101104  export SHELL=3D/bin/sh

    2023-09-17T12:42:12.101809  #

    2023-09-17T12:42:12.203215  / # export SHELL=3D/bin/sh. /lava-11553196/=
environment

    2023-09-17T12:42:12.203967  =


    2023-09-17T12:42:12.305412  / # . /lava-11553196/environment/lava-11553=
196/bin/lava-test-runner /lava-11553196/1

    2023-09-17T12:42:12.306512  =


    2023-09-17T12:42:12.323089  / # /lava-11553196/bin/lava-test-runner /la=
va-11553196/1

    2023-09-17T12:42:12.371914  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T12:42:12.372424  + cd /lav<8>[   15.970079] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11553196_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6506d5752480592f738a0aa6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506d5752480592f738a0aaf
        failing since 59 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-17T10:33:03.923589  / # #

    2023-09-17T10:33:05.004103  export SHELL=3D/bin/sh

    2023-09-17T10:33:05.005909  #

    2023-09-17T10:33:06.496828  / # export SHELL=3D/bin/sh. /lava-11553204/=
environment

    2023-09-17T10:33:06.498806  =


    2023-09-17T10:33:09.223531  / # . /lava-11553204/environment/lava-11553=
204/bin/lava-test-runner /lava-11553204/1

    2023-09-17T10:33:09.226071  =


    2023-09-17T10:33:09.231920  / # /lava-11553204/bin/lava-test-runner /la=
va-11553204/1

    2023-09-17T10:33:09.297325  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T10:33:09.297819  + cd /lava-115532<8>[   25.549541] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11553204_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6506d56d07713d23b98a0aa0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-g5662bcffcf54/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6506d56d07713d23b98a0aa9
        failing since 59 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-17T10:35:16.198048  / # #

    2023-09-17T10:35:16.300175  export SHELL=3D/bin/sh

    2023-09-17T10:35:16.300889  #

    2023-09-17T10:35:16.402233  / # export SHELL=3D/bin/sh. /lava-11553197/=
environment

    2023-09-17T10:35:16.402970  =


    2023-09-17T10:35:16.504427  / # . /lava-11553197/environment/lava-11553=
197/bin/lava-test-runner /lava-11553197/1

    2023-09-17T10:35:16.505502  =


    2023-09-17T10:35:16.522120  / # /lava-11553197/bin/lava-test-runner /la=
va-11553197/1

    2023-09-17T10:35:16.580264  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T10:35:16.580783  + cd /lava-1155319<8>[   16.829372] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11553197_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
