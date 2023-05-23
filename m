Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BB070D155
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 04:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjEWCh4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 22:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjEWChy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 22:37:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D5E0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:37:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d41763796so2468711b3a.2
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684809469; x=1687401469;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys47S8Yc+BbRc0TaX6kUlFmOKH/0zqAEVN1u0QagiTY=;
        b=EdhB/cA9vLQ6+tAt4U1Xz6LpZc8uqIaTbFrkU7v8VQVXjX9B3Qv1Uzfpb8JGE2jkAw
         Jv33vGoMT0QBJSSayLn2+2iXW4xmvGLg7XeJDULXPcAltKQvLYFwsEuS9N+Njh4H33l6
         Xo/35QjDBy8sloo9ERLuGM7cqhe25ydt0NEwnW5NurspSPRqMsWVh8Y9ea1VN8Tv59fa
         noQfnXmFJxyMc5B4x1vz+0SNMQXUNLUNy09+j5pgW+OURfX6ZFkHqdLIXrA8jXWt0EoC
         GqYCgVKSueEkUCWG2hTeFbbl+4vv4U3I6GlN/ZdYyiCKwlCMr0ni/fElsGQ55BkHv+yf
         WOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684809469; x=1687401469;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ys47S8Yc+BbRc0TaX6kUlFmOKH/0zqAEVN1u0QagiTY=;
        b=WqQnnMbkO/IVEUjI4q6K1/VdZsmDccPnQo+sICzHjxoy6OI5EiBBxriHZ0hkLQp7JD
         7nX9eJN5JNV6On0Bi7xxw5xwJV7ee5N23bCycXsiqE+pkwIZ2iYGqhcUuozxOdQ4h1ul
         Ev/HR6SI18efykh5zF3KwPIH33pDHOEyrCMP6+S1KiJeZQ9y93gdGtrubH9cCMKeO/oG
         NQlwNgMTitjfsKIFvSsk9qQo3s1t+AxMj1j2xZBDIsSr/ZgqoCX8UVqRHpvil7mXmF0u
         mJeB9lNjWIecVLd4WuOyNygVy9F9ot/15ppCiIozNqiOfg7QkYkaL4yQZ6DKGP2TfipW
         W5Sg==
X-Gm-Message-State: AC+VfDwHlynqAfgSQxOwdLbUnI/Yu+K2YcXTw0RAsxwO7uyl7+6tCfdc
        Y25RgHYon9eKom5YceCapCAsaHDfKVjPyV+eipWNPQ==
X-Google-Smtp-Source: ACHHUZ4k/PhqLOii9Yk8b0H8TQViiUcKYvKcNqTxMBgF4sN40elMknN/4Oh4RNsf06etviodLrg5CA==
X-Received: by 2002:a17:902:f549:b0:1a6:ff51:270 with SMTP id h9-20020a170902f54900b001a6ff510270mr15646128plf.29.1684809468861;
        Mon, 22 May 2023 19:37:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902d4d200b001aaf5dcd762sm5430259plg.214.2023.05.22.19.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:37:48 -0700 (PDT)
Message-ID: <646c26fc.170a0220.81da.9a31@mx.google.com>
Date:   Mon, 22 May 2023 19:37:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-293-ge00a3d96f756
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 164 runs,
 9 regressions (v6.1.29-293-ge00a3d96f756)
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

stable-rc/linux-6.1.y baseline: 164 runs, 9 regressions (v6.1.29-293-ge00a3=
d96f756)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.29-293-ge00a3d96f756/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.29-293-ge00a3d96f756
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e00a3d96f756a884ab864ae21c22bc1b86d0844d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bf03138741957be2e860a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bf03138741957be2e860f
        failing since 53 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-22T22:43:45.310080  <8>[   10.189913] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417911_1.4.2.3.1>

    2023-05-22T22:43:45.313635  + set +x

    2023-05-22T22:43:45.417590  / # #

    2023-05-22T22:43:45.518239  export SHELL=3D/bin/sh

    2023-05-22T22:43:45.518468  #

    2023-05-22T22:43:45.618935  / # export SHELL=3D/bin/sh. /lava-10417911/=
environment

    2023-05-22T22:43:45.619130  =


    2023-05-22T22:43:45.719676  / # . /lava-10417911/environment/lava-10417=
911/bin/lava-test-runner /lava-10417911/1

    2023-05-22T22:43:45.719947  =


    2023-05-22T22:43:45.725688  / # /lava-10417911/bin/lava-test-runner /la=
va-10417911/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bf0411747ec2c902e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bf0411747ec2c902e85ef
        failing since 53 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-22T22:43:53.317294  + set<8>[   11.365922] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10417894_1.4.2.3.1>

    2023-05-22T22:43:53.317863   +x

    2023-05-22T22:43:53.425766  / # #

    2023-05-22T22:43:53.528248  export SHELL=3D/bin/sh

    2023-05-22T22:43:53.529041  #

    2023-05-22T22:43:53.630614  / # export SHELL=3D/bin/sh. /lava-10417894/=
environment

    2023-05-22T22:43:53.631395  =


    2023-05-22T22:43:53.732977  / # . /lava-10417894/environment/lava-10417=
894/bin/lava-test-runner /lava-10417894/1

    2023-05-22T22:43:53.734111  =


    2023-05-22T22:43:53.739252  / # /lava-10417894/bin/lava-test-runner /la=
va-10417894/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bf01e326acda09a2e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bf01e326acda09a2e861f
        failing since 53 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-22T22:43:28.486409  <8>[   10.909173] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417850_1.4.2.3.1>

    2023-05-22T22:43:28.490184  + set +x

    2023-05-22T22:43:28.596207  =


    2023-05-22T22:43:28.698123  / # #export SHELL=3D/bin/sh

    2023-05-22T22:43:28.698820  =


    2023-05-22T22:43:28.800310  / # export SHELL=3D/bin/sh. /lava-10417850/=
environment

    2023-05-22T22:43:28.800964  =


    2023-05-22T22:43:28.902392  / # . /lava-10417850/environment/lava-10417=
850/bin/lava-test-runner /lava-10417850/1

    2023-05-22T22:43:28.904010  =


    2023-05-22T22:43:28.909173  / # /lava-10417850/bin/lava-test-runner /la=
va-10417850/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bf01a326acda09a2e860d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bf01a326acda09a2e8612
        failing since 53 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-22T22:43:25.320769  + set +x

    2023-05-22T22:43:25.327913  <8>[   14.265551] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417889_1.4.2.3.1>

    2023-05-22T22:43:25.432453  / # #

    2023-05-22T22:43:25.533176  export SHELL=3D/bin/sh

    2023-05-22T22:43:25.533361  #

    2023-05-22T22:43:25.633858  / # export SHELL=3D/bin/sh. /lava-10417889/=
environment

    2023-05-22T22:43:25.634049  =


    2023-05-22T22:43:25.734633  / # . /lava-10417889/environment/lava-10417=
889/bin/lava-test-runner /lava-10417889/1

    2023-05-22T22:43:25.734996  =


    2023-05-22T22:43:25.739531  / # /lava-10417889/bin/lava-test-runner /la=
va-10417889/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bf01896d9d036722e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bf01896d9d036722e85f6
        failing since 53 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-22T22:43:21.348416  <8>[   10.666944] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417873_1.4.2.3.1>

    2023-05-22T22:43:21.348539  + set +x

    2023-05-22T22:43:21.452776  / # #

    2023-05-22T22:43:21.553505  export SHELL=3D/bin/sh

    2023-05-22T22:43:21.553794  #

    2023-05-22T22:43:21.654436  / # export SHELL=3D/bin/sh. /lava-10417873/=
environment

    2023-05-22T22:43:21.654722  =


    2023-05-22T22:43:21.755393  / # . /lava-10417873/environment/lava-10417=
873/bin/lava-test-runner /lava-10417873/1

    2023-05-22T22:43:21.755687  =


    2023-05-22T22:43:21.760598  / # /lava-10417873/bin/lava-test-runner /la=
va-10417873/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bf02c2ffdc88c6e2e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bf02c2ffdc88c6e2e85f6
        failing since 53 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-22T22:43:33.930712  + set<8>[   11.129973] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10417848_1.4.2.3.1>

    2023-05-22T22:43:33.930826   +x

    2023-05-22T22:43:34.035064  / # #

    2023-05-22T22:43:34.135771  export SHELL=3D/bin/sh

    2023-05-22T22:43:34.135998  #

    2023-05-22T22:43:34.236555  / # export SHELL=3D/bin/sh. /lava-10417848/=
environment

    2023-05-22T22:43:34.236788  =


    2023-05-22T22:43:34.337345  / # . /lava-10417848/environment/lava-10417=
848/bin/lava-test-runner /lava-10417848/1

    2023-05-22T22:43:34.337659  =


    2023-05-22T22:43:34.342255  / # /lava-10417848/bin/lava-test-runner /la=
va-10417848/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bf01b6b4e9093542e8628

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bf01b6b4e9093542e862d
        failing since 53 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-22T22:43:28.195144  + set +x<8>[   11.422927] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10417905_1.4.2.3.1>

    2023-05-22T22:43:28.195264  =


    2023-05-22T22:43:28.300004  / # #

    2023-05-22T22:43:28.400590  export SHELL=3D/bin/sh

    2023-05-22T22:43:28.400823  #

    2023-05-22T22:43:28.501371  / # export SHELL=3D/bin/sh. /lava-10417905/=
environment

    2023-05-22T22:43:28.501609  =


    2023-05-22T22:43:28.602156  / # . /lava-10417905/environment/lava-10417=
905/bin/lava-test-runner /lava-10417905/1

    2023-05-22T22:43:28.602449  =


    2023-05-22T22:43:28.607253  / # /lava-10417905/bin/lava-test-runner /la=
va-10417905/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646bf09214b8ad93712e8608

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
293-ge00a3d96f756/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/646bf09214b8ad93712e8624
        failing since 11 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-22T22:45:10.523308  /lava-10417962/1/../bin/lava-test-case

    2023-05-22T22:45:10.530260  <8>[   22.904407] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bf09214b8ad93712e86b0
        failing since 11 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-22T22:45:05.052611  + set +x

    2023-05-22T22:45:05.059127  <8>[   17.431477] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10417962_1.5.2.3.1>

    2023-05-22T22:45:05.164411  / # #

    2023-05-22T22:45:05.265170  export SHELL=3D/bin/sh

    2023-05-22T22:45:05.265400  #

    2023-05-22T22:45:05.365966  / # export SHELL=3D/bin/sh. /lava-10417962/=
environment

    2023-05-22T22:45:05.366184  =


    2023-05-22T22:45:05.466764  / # . /lava-10417962/environment/lava-10417=
962/bin/lava-test-runner /lava-10417962/1

    2023-05-22T22:45:05.467131  =


    2023-05-22T22:45:05.472143  / # /lava-10417962/bin/lava-test-runner /la=
va-10417962/1
 =

    ... (12 line(s) more)  =

 =20
