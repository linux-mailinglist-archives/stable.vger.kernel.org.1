Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5062799A83
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbjIITBC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241593AbjIITBC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 15:01:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D45413D
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 12:00:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68e403bb448so1881770b3a.1
        for <stable@vger.kernel.org>; Sat, 09 Sep 2023 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694286055; x=1694890855; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sWu/fhmKjiFw0f71b2dX0gfE895jTJ+hnfe2dNCU050=;
        b=RQqI44Tj59g0uy5XAqSYT8+VI0aKpJuPdL2Yak/XxkkbgDDY611x7R+G+u1CNdFDfD
         OcUATjxHkLXFzfu4KdoPR4gttdddWAnGC0jQHQCaC4HXYG6PZKi8pOOlqHHrSOQxKfiG
         4QbaEGwHghzIL4jwr5rFDDbVpc6R++sAhgmiULire5bv8jUGfUwgFbNoH/lTbgZCLAzw
         OaBZ+5kVwmRoEmxjbSVD78I4ZB4j8Re0N+AoJspt2ExL0VxdfqnSqH/ffIrijGAbykJD
         a8QRoZyaXNu4kAyltb3CMmOGU95Lqrr1+tEu5sVBikWAhRVjoXBSAirqTW5wKqIekEVD
         RiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694286055; x=1694890855;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWu/fhmKjiFw0f71b2dX0gfE895jTJ+hnfe2dNCU050=;
        b=nnzAXXUPGmnJKzo0EQ2OezHbHpTghdQhFq0Uac/uHMa/bYvMd8or6QNtKKTIYC08t1
         wRCcmiDJaWAMLppy6AyUiwLbdiXGKNfKLeIH2gWRrfyT6YhD3fCgCRHPjma9G2JROjGD
         dCmz/w4y88mbQF1WgQPvuD0fqCJFVBpPKQ7Vq6QoXHS3ZZvScQeV8WJEMs4uzwhgW9yv
         01QXG992ctLP2e39VBVk3DCUoMa2OlXnBZP3fxDvUnhUv/wwanWk2N2znbowYmKbhsD8
         84CooLsoifsM9PT8YzTdfuf5krkWkAlLg8l8sSvpBct3Bt6K6MjhSi+LGt3n0vWuK9Ih
         /HJQ==
X-Gm-Message-State: AOJu0YzEYABMRoovJ65bnvNE3ipR4P8CwVdttPY7Wh3gt2pDasNt3OMm
        EPhM7SjGp6hhdP6qjWRLq7GTO3+6pP7k4FJJSKw=
X-Google-Smtp-Source: AGHT+IE49YrT0T1NOAN38ZwomR+BA1fIqmsOnYNDJfFfaa7+9FP8S9yqdPbtGcZXFDgIOYLjVZuw1A==
X-Received: by 2002:a05:6a00:238c:b0:68e:2c87:fbc6 with SMTP id f12-20020a056a00238c00b0068e2c87fbc6mr7340322pfc.14.1694286055275;
        Sat, 09 Sep 2023 12:00:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j4-20020a62b604000000b0065a1b05193asm2961887pff.185.2023.09.09.12.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 12:00:54 -0700 (PDT)
Message-ID: <64fcc0e6.620a0220.6e040.753f@mx.google.com>
Date:   Sat, 09 Sep 2023 12:00:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.194-287-ga910bb4a67e8
Subject: stable-rc/linux-5.10.y baseline: 113 runs,
 10 regressions (v5.10.194-287-ga910bb4a67e8)
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

stable-rc/linux-5.10.y baseline: 113 runs, 10 regressions (v5.10.194-287-ga=
910bb4a67e8)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.194-287-ga910bb4a67e8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.194-287-ga910bb4a67e8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a910bb4a67e8b8c6136e264f9c7931a754de2285 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8d1e1951408c0c286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8d1e1951408c0c286d70
        failing since 53 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-09-09T15:19:46.557115  + [    9.461773] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1250399_1.5.2.4.1>
    2023-09-09T15:19:46.557404  set +x
    2023-09-09T15:19:46.662535  =

    2023-09-09T15:19:46.763701  / # #export SHELL=3D/bin/sh
    2023-09-09T15:19:46.764105  =

    2023-09-09T15:19:46.865062  / # export SHELL=3D/bin/sh. /lava-1250399/e=
nvironment
    2023-09-09T15:19:46.865462  =

    2023-09-09T15:19:46.966420  / # . /lava-1250399/environment/lava-125039=
9/bin/lava-test-runner /lava-1250399/1
    2023-09-09T15:19:46.967177  =

    2023-09-09T15:19:46.971190  / # /lava-1250399/bin/lava-test-runner /lav=
a-1250399/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8d0bd63a2713f2286d99

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8d0bd63a2713f2286da2
        failing since 164 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-09T15:20:34.814485  + set +x

    2023-09-09T15:20:34.821127  <8>[   14.359709] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11480914_1.4.2.3.1>

    2023-09-09T15:20:34.925733  / # #

    2023-09-09T15:20:35.026611  export SHELL=3D/bin/sh

    2023-09-09T15:20:35.026821  #

    2023-09-09T15:20:35.127407  / # export SHELL=3D/bin/sh. /lava-11480914/=
environment

    2023-09-09T15:20:35.127671  =


    2023-09-09T15:20:35.228221  / # . /lava-11480914/environment/lava-11480=
914/bin/lava-test-runner /lava-11480914/1

    2023-09-09T15:20:35.228514  =


    2023-09-09T15:20:35.233243  / # /lava-11480914/bin/lava-test-runner /la=
va-11480914/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8d75342853ec95286dbb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8d75342853ec95286dc4
        failing since 164 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-09T15:21:10.355700  + set +x

    2023-09-09T15:21:10.362341  <8>[   12.859089] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11480892_1.4.2.3.1>

    2023-09-09T15:21:10.467219  / # #

    2023-09-09T15:21:10.567839  export SHELL=3D/bin/sh

    2023-09-09T15:21:10.568042  #

    2023-09-09T15:21:10.668524  / # export SHELL=3D/bin/sh. /lava-11480892/=
environment

    2023-09-09T15:21:10.668754  =


    2023-09-09T15:21:10.769321  / # . /lava-11480892/environment/lava-11480=
892/bin/lava-test-runner /lava-11480892/1

    2023-09-09T15:21:10.769647  =


    2023-09-09T15:21:10.775091  / # /lava-11480892/bin/lava-test-runner /la=
va-11480892/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8f139612ba3118286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8f139612ba3118286d70
        failing since 53 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-09T15:27:54.221405  + set +x
    2023-09-09T15:27:54.221632  <8>[   83.694200] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1007004_1.5.2.4.1>
    2023-09-09T15:27:54.327320  / # #
    2023-09-09T15:27:55.789383  export SHELL=3D/bin/sh
    2023-09-09T15:27:55.810078  #
    2023-09-09T15:27:55.810283  / # export SHELL=3D/bin/sh
    2023-09-09T15:27:57.766717  / # . /lava-1007004/environment
    2023-09-09T15:28:01.365602  /lava-1007004/bin/lava-test-runner /lava-10=
07004/1
    2023-09-09T15:28:01.386379  . /lava-1007004/environment
    2023-09-09T15:28:01.386487  / # /lava-1007004/bin/lava-test-runner /lav=
a-1007004/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8f279612ba3118286e3b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8f279612ba3118286e3e
        failing since 53 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-09T15:28:16.023926  + set +x
    2023-09-09T15:28:16.024145  <8>[   84.207611] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1007005_1.5.2.4.1>
    2023-09-09T15:28:16.130089  / # #
    2023-09-09T15:28:17.592555  export SHELL=3D/bin/sh
    2023-09-09T15:28:17.613132  #
    2023-09-09T15:28:17.613339  / # export SHELL=3D/bin/sh
    2023-09-09T15:28:19.570700  / # . /lava-1007005/environment
    2023-09-09T15:28:23.170632  /lava-1007005/bin/lava-test-runner /lava-10=
07005/1
    2023-09-09T15:28:23.191503  . /lava-1007005/environment
    2023-09-09T15:28:23.191613  / # /lava-1007005/bin/lava-test-runner /lav=
a-1007005/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8d70c545a80d27286de4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8d70c545a80d27286de7
        failing since 53 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-09T15:21:06.511603  / # #
    2023-09-09T15:21:07.971605  export SHELL=3D/bin/sh
    2023-09-09T15:21:07.992041  #
    2023-09-09T15:21:07.992161  / # export SHELL=3D/bin/sh
    2023-09-09T15:21:09.944930  / # . /lava-1006994/environment
    2023-09-09T15:21:13.538126  /lava-1006994/bin/lava-test-runner /lava-10=
06994/1
    2023-09-09T15:21:13.558689  . /lava-1006994/environment
    2023-09-09T15:21:13.558797  / # /lava-1006994/bin/lava-test-runner /lav=
a-1006994/1
    2023-09-09T15:21:13.637072  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-09T15:21:13.637281  + cd /lava-1006994/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8e87efde6e0afd286dcd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8e87efde6e0afd286dd0
        failing since 53 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-09T15:25:28.819676  / # #
    2023-09-09T15:25:30.279523  export SHELL=3D/bin/sh
    2023-09-09T15:25:30.300091  #
    2023-09-09T15:25:30.300310  / # export SHELL=3D/bin/sh
    2023-09-09T15:25:32.252969  / # . /lava-1007003/environment
    2023-09-09T15:25:35.845222  /lava-1007003/bin/lava-test-runner /lava-10=
07003/1
    2023-09-09T15:25:35.865766  . /lava-1007003/environment
    2023-09-09T15:25:35.865875  / # /lava-1007003/bin/lava-test-runner /lav=
a-1007003/1
    2023-09-09T15:25:35.943016  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-09T15:25:35.943136  + cd /lava-1007003/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8cb8c5e8482c8e286d7b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8cb8c5e8482c8e286d84
        failing since 53 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-09T15:19:43.741940  / # #

    2023-09-09T15:19:43.844153  export SHELL=3D/bin/sh

    2023-09-09T15:19:43.844862  #

    2023-09-09T15:19:43.946275  / # export SHELL=3D/bin/sh. /lava-11480860/=
environment

    2023-09-09T15:19:43.946979  =


    2023-09-09T15:19:44.048423  / # . /lava-11480860/environment/lava-11480=
860/bin/lava-test-runner /lava-11480860/1

    2023-09-09T15:19:44.049559  =


    2023-09-09T15:19:44.066341  / # /lava-11480860/bin/lava-test-runner /la=
va-11480860/1

    2023-09-09T15:19:44.115478  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-09T15:19:44.115987  + cd /lav<8>[   16.416982] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11480860_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8e046df842b364286d70

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8e046df842b364286d75
        failing since 15 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-09-09T15:23:34.085886  / # #

    2023-09-09T15:23:35.345071  export SHELL=3D/bin/sh

    2023-09-09T15:23:35.355914  #

    2023-09-09T15:23:35.356365  / # export SHELL=3D/bin/sh

    2023-09-09T15:23:37.098354  / # . /lava-11480856/environment

    2023-09-09T15:23:40.299191  /lava-11480856/bin/lava-test-runner /lava-1=
1480856/1

    2023-09-09T15:23:40.310550  . /lava-11480856/environment

    2023-09-09T15:23:40.310876  / # /lava-11480856/bin/lava-test-runner /la=
va-11480856/1

    2023-09-09T15:23:40.366422  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-09T15:23:40.366929  + cd /lava-11480856/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8cccc5e8482c8e286d88

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-287-ga910bb4a67e8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8cccc5e8482c8e286d91
        failing since 53 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-09T15:20:00.469388  / # #

    2023-09-09T15:20:00.571359  export SHELL=3D/bin/sh

    2023-09-09T15:20:00.572062  #

    2023-09-09T15:20:00.673489  / # export SHELL=3D/bin/sh. /lava-11480850/=
environment

    2023-09-09T15:20:00.674193  =


    2023-09-09T15:20:00.775634  / # . /lava-11480850/environment/lava-11480=
850/bin/lava-test-runner /lava-11480850/1

    2023-09-09T15:20:00.776813  =


    2023-09-09T15:20:00.777839  / # /lava-11480850/bin/lava-test-runner /la=
va-11480850/1

    2023-09-09T15:20:00.821407  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-09T15:20:00.852152  + cd /lava-1148085<8>[   18.236894] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11480850_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
