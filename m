Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3CC7898B6
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 20:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjHZSsL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHZSsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 14:48:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC926CA
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 11:48:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-565403bda57so958744a12.3
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693075680; x=1693680480;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4LGSB4AY49EhZ16pPCouOy4WCKWV8/Hrg4MmXPmxHHM=;
        b=skqSVsnjiVN7CTkFYdrXeBjcWCwFha13bsSTsrUAWRpjRWMkMzRxV0a71F0cvooNqz
         RI0qJnTukQqRU2nmyQXr3gPZGb9SUlE4dN0sDb12z+ebCh47LAoDMw088fCdtqqgSLg5
         dtlKKmBq+KQvBFJ17KVZ0WOU0GiDv8Ku6qirpyOyoZdKiwa1eS+vgp97LMfopOpqiyPW
         C+ANfTj6FW3CG1eFe8dqXyQvo6OHsK5Fg8FMYzolujB/m/X6AKT929pDIW9hmKJv1lhq
         oMry4oGjYqP2rBRFJmPPiFhXP4JVnkB5X8y/yjJ8fKChOF8EDNe7YgZcSEQq8GiHM0h6
         88Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693075680; x=1693680480;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LGSB4AY49EhZ16pPCouOy4WCKWV8/Hrg4MmXPmxHHM=;
        b=ilPd0oofa/i42wHJT/iNIh7aINMYHhCZ+yS+XahABHgdEwc783y8P333CuF2nBwyJQ
         6xN2Pdc9AXkGie8tFl51pXoa6BBhCYk6ZkdmmuTg652cAQEexqMk8sOE4VVoW1lL0uIh
         WXDSdzp2TkA9YtB1ad5hY0r21QKN5BhfDxPHONewFPeBhRyvip2WGM5yuyHTWZkbHIEU
         9jaAgzNkkUHEwV2pL9x/Y0U+HpnSwedPkOjb7HBh3X9R3Y5D2vfFQs48Qak+uLuHzWqP
         k+in+xyg4+Kc+esxR+Vf3bn8s6pgYuVnu9nITN/WgFAgW1Do6z9jYaLZLfza6xtECHQR
         swfA==
X-Gm-Message-State: AOJu0YzH2BVv+LjixScEyuURvNUCJf7gQZ2Uly7/0RTcoUVQrQMxe2DA
        GGnoJ0vM41KUBeyjRfQmjkwVPsjuQ555k3xRJbw=
X-Google-Smtp-Source: AGHT+IHMkM+Dt1OGpJMaa4jXlBntp2zhYG9BJBkDPME4c82HKuWPZlm4WJNZX5kT7hWKsygZr1IvMA==
X-Received: by 2002:a17:90b:ecd:b0:26c:f871:e6b1 with SMTP id gz13-20020a17090b0ecd00b0026cf871e6b1mr16079255pjb.22.1693075679696;
        Sat, 26 Aug 2023 11:47:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ne10-20020a17090b374a00b0026b50d9aee6sm3825773pjb.25.2023.08.26.11.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 11:47:59 -0700 (PDT)
Message-ID: <64ea48df.170a0220.91e96.54a3@mx.google.com>
Date:   Sat, 26 Aug 2023 11:47:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.48
Subject: stable-rc/linux-6.1.y baseline: 126 runs, 10 regressions (v6.1.48)
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

stable-rc/linux-6.1.y baseline: 126 runs, 10 regressions (v6.1.48)

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
el/v6.1.48/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.48
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      cd363bb9548ec3208120bb3f55ff4ded2487d7fb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea125581c82ca5c3286d83

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea125581c82ca5c3286d88
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T14:54:55.270635  + set +x

    2023-08-26T14:54:55.277159  <8>[   10.443457] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362874_1.4.2.3.1>

    2023-08-26T14:54:55.384981  / # #

    2023-08-26T14:54:55.485845  export SHELL=3D/bin/sh

    2023-08-26T14:54:55.486538  #

    2023-08-26T14:54:55.587803  / # export SHELL=3D/bin/sh. /lava-11362874/=
environment

    2023-08-26T14:54:55.588474  =


    2023-08-26T14:54:55.689905  / # . /lava-11362874/environment/lava-11362=
874/bin/lava-test-runner /lava-11362874/1

    2023-08-26T14:54:55.690969  =


    2023-08-26T14:54:55.695497  / # /lava-11362874/bin/lava-test-runner /la=
va-11362874/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1492ab9836f4ca286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1492ab9836f4ca286d71
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T15:04:29.331260  + set<8>[   11.262855] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11362896_1.4.2.3.1>

    2023-08-26T15:04:29.331345   +x

    2023-08-26T15:04:29.435803  / # #

    2023-08-26T15:04:29.536492  export SHELL=3D/bin/sh

    2023-08-26T15:04:29.536750  #

    2023-08-26T15:04:29.637308  / # export SHELL=3D/bin/sh. /lava-11362896/=
environment

    2023-08-26T15:04:29.637533  =


    2023-08-26T15:04:29.738115  / # . /lava-11362896/environment/lava-11362=
896/bin/lava-test-runner /lava-11362896/1

    2023-08-26T15:04:29.738411  =


    2023-08-26T15:04:29.742993  / # /lava-11362896/bin/lava-test-runner /la=
va-11362896/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea123981c82ca5c3286d76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea123981c82ca5c3286d7f
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T14:55:38.245909  <8>[   11.199583] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362885_1.4.2.3.1>

    2023-08-26T14:55:38.249692  + set +x

    2023-08-26T14:55:38.351374  =


    2023-08-26T14:55:38.451930  / # #export SHELL=3D/bin/sh

    2023-08-26T14:55:38.452127  =


    2023-08-26T14:55:38.552673  / # export SHELL=3D/bin/sh. /lava-11362885/=
environment

    2023-08-26T14:55:38.552915  =


    2023-08-26T14:55:38.653480  / # . /lava-11362885/environment/lava-11362=
885/bin/lava-test-runner /lava-11362885/1

    2023-08-26T14:55:38.653845  =


    2023-08-26T14:55:38.658645  / # /lava-11362885/bin/lava-test-runner /la=
va-11362885/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1576d366c9ad8a286d6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ea1576d366c9ad8a286=
d6f
        failing since 79 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea130700131a7060286d79

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea130700131a7060286d7e
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T14:58:01.676250  + <8>[   11.145692] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11362879_1.4.2.3.1>

    2023-08-26T14:58:01.676334  set +x

    2023-08-26T14:58:01.777692  =


    2023-08-26T14:58:01.878331  / # #export SHELL=3D/bin/sh

    2023-08-26T14:58:01.878514  =


    2023-08-26T14:58:01.979008  / # export SHELL=3D/bin/sh. /lava-11362879/=
environment

    2023-08-26T14:58:01.979202  =


    2023-08-26T14:58:02.079731  / # . /lava-11362879/environment/lava-11362=
879/bin/lava-test-runner /lava-11362879/1

    2023-08-26T14:58:02.080136  =


    2023-08-26T14:58:02.085035  / # /lava-11362879/bin/lava-test-runner /la=
va-11362879/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea123fd582ed3745286daf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea123fd582ed3745286db4
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T14:54:35.548443  + set<8>[   11.822633] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11362880_1.4.2.3.1>

    2023-08-26T14:54:35.548529   +x

    2023-08-26T14:54:35.653229  / # #

    2023-08-26T14:54:35.753932  export SHELL=3D/bin/sh

    2023-08-26T14:54:35.754147  #

    2023-08-26T14:54:35.854677  / # export SHELL=3D/bin/sh. /lava-11362880/=
environment

    2023-08-26T14:54:35.854911  =


    2023-08-26T14:54:35.955607  / # . /lava-11362880/environment/lava-11362=
880/bin/lava-test-runner /lava-11362880/1

    2023-08-26T14:54:35.955911  =


    2023-08-26T14:54:35.960539  / # /lava-11362880/bin/lava-test-runner /la=
va-11362880/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea14bbab9836f4ca286da6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea14bcab9836f4ca286dab
        failing since 149 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T15:05:15.084062  + set<8>[   12.544247] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11362873_1.4.2.3.1>

    2023-08-26T15:05:15.084639   +x

    2023-08-26T15:05:15.192745  / # #

    2023-08-26T15:05:15.295767  export SHELL=3D/bin/sh

    2023-08-26T15:05:15.296563  #

    2023-08-26T15:05:15.398343  / # export SHELL=3D/bin/sh. /lava-11362873/=
environment

    2023-08-26T15:05:15.399147  =


    2023-08-26T15:05:15.500800  / # . /lava-11362873/environment/lava-11362=
873/bin/lava-test-runner /lava-11362873/1

    2023-08-26T15:05:15.502081  =


    2023-08-26T15:05:15.507115  / # /lava-11362873/bin/lava-test-runner /la=
va-11362873/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea13a7b921696829286e36

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea13a7b921696829286e3b
        failing since 39 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-26T15:02:17.751354  / # #

    2023-08-26T15:02:17.853466  export SHELL=3D/bin/sh

    2023-08-26T15:02:17.854160  #

    2023-08-26T15:02:17.955258  / # export SHELL=3D/bin/sh. /lava-11362951/=
environment

    2023-08-26T15:02:17.955507  =


    2023-08-26T15:02:18.056129  / # . /lava-11362951/environment/lava-11362=
951/bin/lava-test-runner /lava-11362951/1

    2023-08-26T15:02:18.056491  =


    2023-08-26T15:02:18.060537  / # /lava-11362951/bin/lava-test-runner /la=
va-11362951/1

    2023-08-26T15:02:18.120990  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T15:02:18.121191  + cd /lav<8>[   19.097463] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11362951_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea13b9f87bc80c61286ddc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea13b9f87bc80c61286de1
        failing since 39 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-26T15:01:12.126717  / # #

    2023-08-26T15:01:13.206908  export SHELL=3D/bin/sh

    2023-08-26T15:01:13.208752  #

    2023-08-26T15:01:14.699368  / # export SHELL=3D/bin/sh. /lava-11362954/=
environment

    2023-08-26T15:01:14.701276  =


    2023-08-26T15:01:17.424959  / # . /lava-11362954/environment/lava-11362=
954/bin/lava-test-runner /lava-11362954/1

    2023-08-26T15:01:17.426932  =


    2023-08-26T15:01:17.435368  / # /lava-11362954/bin/lava-test-runner /la=
va-11362954/1

    2023-08-26T15:01:17.494904  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T15:01:17.495369  + cd /lava-113629<8>[   29.481928] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11362954_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea13bcf87bc80c61286e16

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea13bcf87bc80c61286e1b
        failing since 39 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-26T15:02:32.481903  / # #

    2023-08-26T15:02:32.584067  export SHELL=3D/bin/sh

    2023-08-26T15:02:32.584785  #

    2023-08-26T15:02:32.686251  / # export SHELL=3D/bin/sh. /lava-11362959/=
environment

    2023-08-26T15:02:32.686973  =


    2023-08-26T15:02:32.788406  / # . /lava-11362959/environment/lava-11362=
959/bin/lava-test-runner /lava-11362959/1

    2023-08-26T15:02:32.789459  =


    2023-08-26T15:02:32.792384  / # /lava-11362959/bin/lava-test-runner /la=
va-11362959/1

    2023-08-26T15:02:32.872304  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T15:02:32.872836  + cd /lava-1136295<8>[   18.831340] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11362959_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
