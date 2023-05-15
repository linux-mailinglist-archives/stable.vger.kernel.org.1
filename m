Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FECB703DD3
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbjEOTpn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 15:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243499AbjEOTpm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 15:45:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A49DC55
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:45:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24e5d5782edso12268868a91.0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684179939; x=1686771939;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sidZfiRQ+1Vqx9heTAEojZbLWUIr+lJhKKB3egOZ9Kc=;
        b=hsB1WXTHzz9ZitWWmaLD53WtdtKTGd/jHkE4P2Vdwx7gKlGm98F5Ka9ayKG9Jb8c0J
         CWZrj5tE3REby+hWYVQb31sgmP3vqBEQmUpTspl43rENDZbkeiY6gQj1PA1wuapn9CQB
         2g+G+DpWzFpkjbCspvGnOTAfwWZ2VvQlAhCvO5Ca6UXMtdcuy2t9nKHZaz7gZmnufZ55
         BMjiGM6as3gge74l3zi413UFrc21PHdx9EEMqAUrGfykvY8PALVR3zKEHyWFYHrPSyES
         C+7PsjHlTLVF5qnvQFile2COUfKVTKBhNe/vx6uqFHZlwq06C7WFXa2Bgnx7c0flV5vd
         WUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684179939; x=1686771939;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sidZfiRQ+1Vqx9heTAEojZbLWUIr+lJhKKB3egOZ9Kc=;
        b=U70ZgN0IeZDw5eocLfao55yj7JXQis7ovn778Y1Grssh9K/qZQ9/96R/P4K2bIi9qp
         dIwb4f+YqA9/XaW1LizNxRRWY9eb0c7pktn6V2R4ZUeuuC46mF2i3Uf3n1fQzmTvkrVP
         6asHwJDykaohvEGWaCw5romFeOUopbFJKElu0DywKDDxrr6QvdAhqQbQoTa+6abqthVH
         oNY2hbcnTPEsLDNSY0ecN+nwh40cwbqtx6r+40YVX+WIuozRCnNgCswiZdxhjokiWy/e
         6mEfh6Oxe6rJe18YAPSzy1LXUplHflWXjZCxjF4kKT8+8eXYamfHa68RW6jR4JFayIZg
         FdeA==
X-Gm-Message-State: AC+VfDw5ePKsCIlcg18z5kOrvXxMf3mRPMuPWUHtP9ipofPBmtLZYqAY
        C2hY+saUpc2OV6t8jgx8/xN/5HgvDJMux3r1KsUrkA==
X-Google-Smtp-Source: ACHHUZ4Afymeyo1VS7VuYFyrOy13X23IkVupmAuhcp2cqugV2ZZo/KsZI/URchMvUcBiClPMptrBiw==
X-Received: by 2002:a17:90a:604b:b0:247:8b61:a41 with SMTP id h11-20020a17090a604b00b002478b610a41mr33797231pjm.25.1684179938912;
        Mon, 15 May 2023 12:45:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090ab10f00b0024df400a9e6sm134761pjq.37.2023.05.15.12.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:45:38 -0700 (PDT)
Message-ID: <64628be2.170a0220.d0a0a.0a3d@mx.google.com>
Date:   Mon, 15 May 2023 12:45:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-134-g3cb5ed78068c9
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 170 runs,
 15 regressions (v5.15.111-134-g3cb5ed78068c9)
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

stable-rc/linux-5.15.y baseline: 170 runs, 15 regressions (v5.15.111-134-g3=
cb5ed78068c9)

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

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.111-134-g3cb5ed78068c9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.111-134-g3cb5ed78068c9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3cb5ed78068c9a8239e6dbc2db19fa5eb2ea8b6f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6462562b8cff13be872e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6462562b8cff13be872e85eb
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T15:56:04.819223  <8>[   10.990763] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10326899_1.4.2.3.1>

    2023-05-15T15:56:04.822555  + set +x

    2023-05-15T15:56:04.929912  / # #

    2023-05-15T15:56:05.032256  export SHELL=3D/bin/sh

    2023-05-15T15:56:05.033010  #

    2023-05-15T15:56:05.134236  / # export SHELL=3D/bin/sh. /lava-10326899/=
environment

    2023-05-15T15:56:05.134964  =


    2023-05-15T15:56:05.236525  / # . /lava-10326899/environment/lava-10326=
899/bin/lava-test-runner /lava-10326899/1

    2023-05-15T15:56:05.237588  =


    2023-05-15T15:56:05.242407  / # /lava-10326899/bin/lava-test-runner /la=
va-10326899/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646255edceeb3ef5e32e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646255edceeb3ef5e32e85ed
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T15:55:02.759334  + set<8>[    8.860757] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10326879_1.4.2.3.1>

    2023-05-15T15:55:02.759420   +x

    2023-05-15T15:55:02.864142  / # #

    2023-05-15T15:55:02.964772  export SHELL=3D/bin/sh

    2023-05-15T15:55:02.964962  #

    2023-05-15T15:55:03.065482  / # export SHELL=3D/bin/sh. /lava-10326879/=
environment

    2023-05-15T15:55:03.065738  =


    2023-05-15T15:55:03.166268  / # . /lava-10326879/environment/lava-10326=
879/bin/lava-test-runner /lava-10326879/1

    2023-05-15T15:55:03.166554  =


    2023-05-15T15:55:03.171183  / # /lava-10326879/bin/lava-test-runner /la=
va-10326879/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646255fee2bf7d991f2e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646255fee2bf7d991f2e85f6
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T15:55:20.281885  <8>[   11.207193] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10326902_1.4.2.3.1>

    2023-05-15T15:55:20.286426  + set +x

    2023-05-15T15:55:20.393780  =


    2023-05-15T15:55:20.496142  / # #export SHELL=3D/bin/sh

    2023-05-15T15:55:20.496811  =


    2023-05-15T15:55:20.598368  / # export SHELL=3D/bin/sh. /lava-10326902/=
environment

    2023-05-15T15:55:20.598527  =


    2023-05-15T15:55:20.699107  / # . /lava-10326902/environment/lava-10326=
902/bin/lava-test-runner /lava-10326902/1

    2023-05-15T15:55:20.699535  =


    2023-05-15T15:55:20.704015  / # /lava-10326902/bin/lava-test-runner /la=
va-10326902/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646256e05437d69a572e85ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646256e05437d69a572e8=
5eb
        failing since 368 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646257586ba6d02c812e8618

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646257586ba6d02c812e861d
        failing since 118 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-05-15T16:01:00.730825  + set +x<8>[    9.995685] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3592021_1.5.2.4.1>
    2023-05-15T16:01:00.731496  =

    2023-05-15T16:01:00.840114  / # #
    2023-05-15T16:01:00.942837  export SHELL=3D/bin/sh
    2023-05-15T16:01:00.943594  #
    2023-05-15T16:01:01.045408  / # export SHELL=3D/bin/sh. /lava-3592021/e=
nvironment
    2023-05-15T16:01:01.046229  =

    2023-05-15T16:01:01.147942  / # . /lava-3592021/environment/lava-359202=
1/bin/lava-test-runner /lava-3592021/1
    2023-05-15T16:01:01.149634  =

    2023-05-15T16:01:01.154960  / # /lava-3592021/bin/lava-test-runner /lav=
a-3592021/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646259a9501f2fe7c82e869c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646259a9501f2fe7c82e869f
        failing since 72 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-05-15T16:10:33.760185  [   10.306458] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1222022_1.5.2.4.1>
    2023-05-15T16:10:33.866047  / # #
    2023-05-15T16:10:33.967474  export SHELL=3D/bin/sh
    2023-05-15T16:10:33.967960  #
    2023-05-15T16:10:34.069062  / # export SHELL=3D/bin/sh. /lava-1222022/e=
nvironment
    2023-05-15T16:10:34.069518  =

    2023-05-15T16:10:34.170880  / # . /lava-1222022/environment/lava-122202=
2/bin/lava-test-runner /lava-1222022/1
    2023-05-15T16:10:34.171727  =

    2023-05-15T16:10:34.173437  / # /lava-1222022/bin/lava-test-runner /lav=
a-1222022/1
    2023-05-15T16:10:34.190624  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646255dfea24b579152e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646255dfea24b579152e85eb
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T15:54:54.817171  + set +x

    2023-05-15T15:54:54.823662  <8>[   10.154693] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10326843_1.4.2.3.1>

    2023-05-15T15:54:54.928361  / # #

    2023-05-15T15:54:55.028998  export SHELL=3D/bin/sh

    2023-05-15T15:54:55.029232  #

    2023-05-15T15:54:55.129805  / # export SHELL=3D/bin/sh. /lava-10326843/=
environment

    2023-05-15T15:54:55.130023  =


    2023-05-15T15:54:55.230604  / # . /lava-10326843/environment/lava-10326=
843/bin/lava-test-runner /lava-10326843/1

    2023-05-15T15:54:55.230897  =


    2023-05-15T15:54:55.236072  / # /lava-10326843/bin/lava-test-runner /la=
va-10326843/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646255f7a27697d8cd2e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646255f7a27697d8cd2e861f
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T15:55:14.278206  + set +x<8>[   10.543382] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10326912_1.4.2.3.1>

    2023-05-15T15:55:14.278301  =


    2023-05-15T15:55:14.380059  #

    2023-05-15T15:55:14.380480  =


    2023-05-15T15:55:14.481252  / # #export SHELL=3D/bin/sh

    2023-05-15T15:55:14.481554  =


    2023-05-15T15:55:14.582212  / # export SHELL=3D/bin/sh. /lava-10326912/=
environment

    2023-05-15T15:55:14.582528  =


    2023-05-15T15:55:14.683190  / # . /lava-10326912/environment/lava-10326=
912/bin/lava-test-runner /lava-10326912/1

    2023-05-15T15:55:14.683650  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646255dfe4bffdbfb52e8604

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646255dfe4bffdbfb52e8609
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T15:54:44.164345  + <8>[   11.230302] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10326884_1.4.2.3.1>

    2023-05-15T15:54:44.164476  set +x

    2023-05-15T15:54:44.269086  / # #

    2023-05-15T15:54:44.369796  export SHELL=3D/bin/sh

    2023-05-15T15:54:44.370060  #

    2023-05-15T15:54:44.470615  / # export SHELL=3D/bin/sh. /lava-10326884/=
environment

    2023-05-15T15:54:44.470835  =


    2023-05-15T15:54:44.571380  / # . /lava-10326884/environment/lava-10326=
884/bin/lava-test-runner /lava-10326884/1

    2023-05-15T15:54:44.571687  =


    2023-05-15T15:54:44.576507  / # /lava-10326884/bin/lava-test-runner /la=
va-10326884/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646255e07e829a244a2e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646255e07e829a244a2e85ef
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T15:55:06.088654  + set<8>[   11.444535] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10326911_1.4.2.3.1>

    2023-05-15T15:55:06.088748   +x

    2023-05-15T15:55:06.193350  / # #

    2023-05-15T15:55:06.294018  export SHELL=3D/bin/sh

    2023-05-15T15:55:06.294251  #

    2023-05-15T15:55:06.394792  / # export SHELL=3D/bin/sh. /lava-10326911/=
environment

    2023-05-15T15:55:06.395035  =


    2023-05-15T15:55:06.495590  / # . /lava-10326911/environment/lava-10326=
911/bin/lava-test-runner /lava-10326911/1

    2023-05-15T15:55:06.495928  =


    2023-05-15T15:55:06.500758  / # /lava-10326911/bin/lava-test-runner /la=
va-10326911/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/64625b25f1b1fc7fbb2e85e7

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64625b25f1b1fc7fbb2e85f8
        failing since 0 day (last pass: v5.15.110, first fail: v5.15.111-13=
0-g93ae50a86a5dd)

    2023-05-15T16:17:15.026994  /lava-10327240/1/../bin/lava-test-case

    2023-05-15T16:17:15.033481  <8>[   61.602247] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64625b25f1b1fc7fbb2e85f8
        failing since 0 day (last pass: v5.15.110, first fail: v5.15.111-13=
0-g93ae50a86a5dd)

    2023-05-15T16:17:15.026994  /lava-10327240/1/../bin/lava-test-case

    2023-05-15T16:17:15.033481  <8>[   61.602247] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64625b25f1b1fc7fbb2e85fa
        failing since 0 day (last pass: v5.15.110, first fail: v5.15.111-13=
0-g93ae50a86a5dd)

    2023-05-15T16:17:13.987696  /lava-10327240/1/../bin/lava-test-case

    2023-05-15T16:17:13.994515  <8>[   60.563260] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64625b25f1b1fc7fbb2e868b
        failing since 0 day (last pass: v5.15.110, first fail: v5.15.111-13=
0-g93ae50a86a5dd)

    2023-05-15T16:16:59.849505  <8>[   46.421937] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10327240_1.5.2.3.1>

    2023-05-15T16:16:59.852857  + set +x

    2023-05-15T16:16:59.957730  / # #

    2023-05-15T16:17:00.058345  export SHELL=3D/bin/sh

    2023-05-15T16:17:00.058594  #

    2023-05-15T16:17:00.159168  / # export SHELL=3D/bin/sh. /lava-10327240/=
environment

    2023-05-15T16:17:00.159400  =


    2023-05-15T16:17:00.259988  / # . /lava-10327240/environment/lava-10327=
240/bin/lava-test-runner /lava-10327240/1

    2023-05-15T16:17:00.260374  =


    2023-05-15T16:17:00.265230  / # /lava-10327240/bin/lava-test-runner /la=
va-10327240/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/646253533735d913b82e85ec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-134-g3cb5ed78068c9/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646253533735d913b82e85f1
        failing since 32 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-05-15T15:44:07.458834  <8>[    5.749574] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3591956_1.5.2.4.1>
    2023-05-15T15:44:07.600539  / # #
    2023-05-15T15:44:07.711175  export SHELL=3D/bin/sh
    2023-05-15T15:44:07.712696  #
    2023-05-15T15:44:07.816014  / # export SHELL=3D/bin/sh. /lava-3591956/e=
nvironment
    2023-05-15T15:44:07.817544  =

    2023-05-15T15:44:07.920957  / # . /lava-3591956/environment/lava-359195=
6/bin/lava-test-runner /lava-3591956/1
    2023-05-15T15:44:07.923671  =

    2023-05-15T15:44:07.944301  / # /lava-3591956/bin/lava-test-runner /lav=
a-3591956/1
    2023-05-15T15:44:08.040167  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
