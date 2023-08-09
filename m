Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3377750A4
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 04:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjHICFR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 22:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHICFQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 22:05:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F3FF3
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 19:05:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc6535027aso27321995ad.2
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 19:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691546714; x=1692151514;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=44btZSYCPs4h2ysQ8xXOmHBq+26ECMEgYNrirHXxvAQ=;
        b=FpnIwr33wFHJM9SRqFjL9Ix9LS+A62neauHOgolZS61Gix3/59aTeoXkumVCXydNwT
         AbfO3K4WUwqIANOzaMpPlKOIMo85pYhGLZmTu8vmCOM0K5OUOiDuUiC/cLaThS1XkksM
         G3qp11hK+faNRFFY1mAECJlTtIP5iCW9yp7jHWXKZmgMsEo5OKKdPJ8/0Un6PiOo8OcD
         67OxfZqJY3IaACrYDSHZwVDS8dknzcYs4TIIMHL2/G3tZuYuYI8YpM1UcDaPjl/eKfTN
         l3PY0j8mdK2jK9s6pIkmO7UX7nSC6CHy+3BivbHIVlJrNGf8wz9Q+UpD+UbhrAD7dYDq
         oEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691546714; x=1692151514;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44btZSYCPs4h2ysQ8xXOmHBq+26ECMEgYNrirHXxvAQ=;
        b=UUNyxHL/5KaJNI3kL/ivqUfj0zXcjw1LymPi/iHykRQFfdJfQbLo0Bs48wAZNqz4Io
         pJ6L9LTLOXDsnwyFU5u1zikAugaKyJ4VqxDQqNybt/XeKZRHjrH+hS+prE8ikm6dkOQx
         iui+Itc2A8YEzKSWzSiYeXc9wArrr4PTtyVk/QxPxYI9uNL9Tf708RzfNPO4+64sdzEo
         cKcO87p3TSfhXqdNoHCnz5dBNBUqVAml+/d+nk7dTm4mk+9lNCjqTLXSaQ4cBqx6Q379
         LMSWl78/buGWHjjXH9MySKytZ7pm0b0BAhRn0B2nUgkdxG589qe5QlOg+7gM3eMEBOoz
         7eBA==
X-Gm-Message-State: AOJu0Yyr+nRQ/C6hyr/Z6XL444qJ5rUT1h3NGNvPsfus+39KDowZAEEf
        1lkTBlD8xCQCWXkMLK5BsKpVnIXSJmOHJ/8KNpUZVA==
X-Google-Smtp-Source: AGHT+IGHwHIflQGenLrQwM+rRfI8hNsJ0MYOPSxu3pwqeIQ7C+a2k8FFSSHVRi/Hh6lZNxplW+shZg==
X-Received: by 2002:a17:903:1104:b0:1b8:b29e:b47b with SMTP id n4-20020a170903110400b001b8b29eb47bmr1865991plh.44.1691546714056;
        Tue, 08 Aug 2023 19:05:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y5-20020a1709029b8500b001b8943b37a5sm9729379plp.24.2023.08.08.19.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:05:13 -0700 (PDT)
Message-ID: <64d2f459.170a0220.25a93.2d86@mx.google.com>
Date:   Tue, 08 Aug 2023 19:05:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.44-117-g74848b090997c
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 119 runs,
 10 regressions (v6.1.44-117-g74848b090997c)
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

stable-rc/linux-6.1.y baseline: 119 runs, 10 regressions (v6.1.44-117-g7484=
8b090997c)

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
el/v6.1.44-117-g74848b090997c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.44-117-g74848b090997c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      74848b090997cf1d1fe260074d635c188a93e180 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c0b43b3fd1e76935b1f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c0b43b3fd1e76935b1f8
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T22:24:40.585169  <8>[   10.989179] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11237377_1.4.2.3.1>

    2023-08-08T22:24:40.588667  + set +x

    2023-08-08T22:24:40.690071  =


    2023-08-08T22:24:40.790608  / # #export SHELL=3D/bin/sh

    2023-08-08T22:24:40.790841  =


    2023-08-08T22:24:40.891371  / # export SHELL=3D/bin/sh. /lava-11237377/=
environment

    2023-08-08T22:24:40.891557  =


    2023-08-08T22:24:40.992085  / # . /lava-11237377/environment/lava-11237=
377/bin/lava-test-runner /lava-11237377/1

    2023-08-08T22:24:40.992416  =


    2023-08-08T22:24:40.997722  / # /lava-11237377/bin/lava-test-runner /la=
va-11237377/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c0c8470e50513435b1fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c0c8470e50513435b200
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T22:24:54.574588  + set<8>[   12.035535] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11237410_1.4.2.3.1>

    2023-08-08T22:24:54.574675   +x

    2023-08-08T22:24:54.678827  / # #

    2023-08-08T22:24:54.779491  export SHELL=3D/bin/sh

    2023-08-08T22:24:54.779714  #

    2023-08-08T22:24:54.880256  / # export SHELL=3D/bin/sh. /lava-11237410/=
environment

    2023-08-08T22:24:54.880450  =


    2023-08-08T22:24:54.980959  / # . /lava-11237410/environment/lava-11237=
410/bin/lava-test-runner /lava-11237410/1

    2023-08-08T22:24:54.981260  =


    2023-08-08T22:24:54.985930  / # /lava-11237410/bin/lava-test-runner /la=
va-11237410/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c0b5470e50513435b1dc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c0b5470e50513435b1e1
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T22:24:50.234572  <8>[    9.678377] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11237407_1.4.2.3.1>

    2023-08-08T22:24:50.238037  + set +x

    2023-08-08T22:24:50.339229  #

    2023-08-08T22:24:50.339473  =


    2023-08-08T22:24:50.440049  / # #export SHELL=3D/bin/sh

    2023-08-08T22:24:50.440205  =


    2023-08-08T22:24:50.540702  / # export SHELL=3D/bin/sh. /lava-11237407/=
environment

    2023-08-08T22:24:50.540908  =


    2023-08-08T22:24:50.641393  / # . /lava-11237407/environment/lava-11237=
407/bin/lava-test-runner /lava-11237407/1

    2023-08-08T22:24:50.641805  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c36dee17286c6c35b261

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2c36dee17286c6c35b=
262
        failing since 62 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c1061c4874812735b202

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c1061c4874812735b207
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T22:26:10.864200  + set +x

    2023-08-08T22:26:10.870280  <8>[   10.917185] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11237405_1.4.2.3.1>

    2023-08-08T22:26:10.977865  / # #

    2023-08-08T22:26:11.080398  export SHELL=3D/bin/sh

    2023-08-08T22:26:11.081287  #

    2023-08-08T22:26:11.183072  / # export SHELL=3D/bin/sh. /lava-11237405/=
environment

    2023-08-08T22:26:11.183869  =


    2023-08-08T22:26:11.285478  / # . /lava-11237405/environment/lava-11237=
405/bin/lava-test-runner /lava-11237405/1

    2023-08-08T22:26:11.286621  =


    2023-08-08T22:26:11.291611  / # /lava-11237405/bin/lava-test-runner /la=
va-11237405/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c0b32a198cb01f35b1db

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c0b32a198cb01f35b1e0
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T22:24:36.389122  + set<8>[   11.435989] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11237375_1.4.2.3.1>

    2023-08-08T22:24:36.389736   +x

    2023-08-08T22:24:36.497668  / # #

    2023-08-08T22:24:36.600159  export SHELL=3D/bin/sh

    2023-08-08T22:24:36.600930  #

    2023-08-08T22:24:36.702722  / # export SHELL=3D/bin/sh. /lava-11237375/=
environment

    2023-08-08T22:24:36.703502  =


    2023-08-08T22:24:36.805412  / # . /lava-11237375/environment/lava-11237=
375/bin/lava-test-runner /lava-11237375/1

    2023-08-08T22:24:36.806785  =


    2023-08-08T22:24:36.811317  / # /lava-11237375/bin/lava-test-runner /la=
va-11237375/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c0b42a198cb01f35b1ff

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c0b42a198cb01f35b204
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T22:24:40.611570  + set<8>[   12.571031] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11237396_1.4.2.3.1>

    2023-08-08T22:24:40.611674   +x

    2023-08-08T22:24:40.715873  / # #

    2023-08-08T22:24:40.816409  export SHELL=3D/bin/sh

    2023-08-08T22:24:40.816641  #

    2023-08-08T22:24:40.917151  / # export SHELL=3D/bin/sh. /lava-11237396/=
environment

    2023-08-08T22:24:40.917338  =


    2023-08-08T22:24:41.017835  / # . /lava-11237396/environment/lava-11237=
396/bin/lava-test-runner /lava-11237396/1

    2023-08-08T22:24:41.018087  =


    2023-08-08T22:24:41.023015  / # /lava-11237396/bin/lava-test-runner /la=
va-11237396/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c3867b4d6a7e6535b1da

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c3867b4d6a7e6535b1df
        failing since 22 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-08T22:38:24.161563  / # #

    2023-08-08T22:38:24.263696  export SHELL=3D/bin/sh

    2023-08-08T22:38:24.264400  #

    2023-08-08T22:38:24.365711  / # export SHELL=3D/bin/sh. /lava-11237589/=
environment

    2023-08-08T22:38:24.366409  =


    2023-08-08T22:38:24.467697  / # . /lava-11237589/environment/lava-11237=
589/bin/lava-test-runner /lava-11237589/1

    2023-08-08T22:38:24.468783  =


    2023-08-08T22:38:24.485620  / # /lava-11237589/bin/lava-test-runner /la=
va-11237589/1

    2023-08-08T22:38:24.533718  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T22:38:24.534220  + cd /lav<8>[   19.102456] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11237589_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c39c7b4d6a7e6535b1f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c39c7b4d6a7e6535b1f7
        failing since 22 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-08T22:37:33.040621  / # #

    2023-08-08T22:37:34.120403  export SHELL=3D/bin/sh

    2023-08-08T22:37:34.122190  #

    2023-08-08T22:37:35.612569  / # export SHELL=3D/bin/sh. /lava-11237587/=
environment

    2023-08-08T22:37:35.614471  =


    2023-08-08T22:37:38.339483  / # . /lava-11237587/environment/lava-11237=
587/bin/lava-test-runner /lava-11237587/1

    2023-08-08T22:37:38.341639  =


    2023-08-08T22:37:38.346607  / # /lava-11237587/bin/lava-test-runner /la=
va-11237587/1

    2023-08-08T22:37:38.409848  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T22:37:38.410388  + cd /lava-112375<8>[   28.431159] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11237587_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2c39c7b4d6a7e6535b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.44-=
117-g74848b090997c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2c39c7b4d6a7e6535b1ec
        failing since 22 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-08T22:38:30.164336  / # #

    2023-08-08T22:38:30.266552  export SHELL=3D/bin/sh

    2023-08-08T22:38:30.267277  #

    2023-08-08T22:38:30.368670  / # export SHELL=3D/bin/sh. /lava-11237594/=
environment

    2023-08-08T22:38:30.369435  =


    2023-08-08T22:38:30.470863  / # . /lava-11237594/environment/lava-11237=
594/bin/lava-test-runner /lava-11237594/1

    2023-08-08T22:38:30.471994  =


    2023-08-08T22:38:30.488505  / # /lava-11237594/bin/lava-test-runner /la=
va-11237594/1

    2023-08-08T22:38:30.554595  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T22:38:30.555107  + cd /lava-11237594/1/tests/1_boot<8>[   16=
.974717] <LAVA_SIGNAL_STARTRUN 1_bootrr 11237594_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
