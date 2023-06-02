Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163427200A4
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 13:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjFBLsd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 07:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjFBLs3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 07:48:29 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3EE5C
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 04:48:21 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6af6f5fc42aso1927876a34.1
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 04:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685706500; x=1688298500;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0lfCUhXt8i4sqyCn4Votl2AktLPixvT9hyxo2q0c50s=;
        b=PaHNxHxx3+a/hQlbBnR3IIJq+Wcxxh0u9DoP2LUV6/zFNdxzkJhvwF/Yr1v0N8NvlT
         yzwkQmPHXIBM13FavPa80aRheKd3JhlMrgMAfPxxgTU5Hk/I4Qo351+RHeo0sRnShw5t
         yIha2Vy5kznaR3LtlwfF5RkPlCha5hgKoKpmnyafagOGNi7AqpebmxGzWP8jPuy0/pf4
         +X1FpVMPvY/tPC5+n61N1uGw7LaJ3jB+8CDDQe1jzJ3aKf7eyJgcAgtN/pWqN6SeBAlg
         /raHZPJcaas048eL/OTr8KnDiZQept/YpLojysovIqUWY698V76iJ8T7RZYFURjheBTz
         8DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706500; x=1688298500;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lfCUhXt8i4sqyCn4Votl2AktLPixvT9hyxo2q0c50s=;
        b=AunH6vhTqyMA08AWze0QAygmbs5GkfVZszff7jDyxkebUE064N5cneVLSJ/7VF2h4T
         LY7zHjNs5uXwr73uEHZSbHEUWLYyKF0/HSiuFlorQwe4NQintSiK9iHtY8oJ7MOZPprh
         b97s5LtqSKkKPyBzMocMaU6Kz7LkuX4qaIa+VTOssvAtaSW2L+2pPhmXHK2qTYWkjJ4b
         WP9a+Sr9QXjAdvEMkWxKaMvo8h6myUJc4UvjUbef33B+Hl4D5EfVOF+6DSMPyaf8vBwr
         sqatpZBsMwRaS/32ntMzRAqYVN2mIaegIN7nraT6QzL2wCPyvl+E6d3TqACKATiImEna
         V8aA==
X-Gm-Message-State: AC+VfDzbJwRt1UR8mMTeZpzxYTgwRLvoOxPR1Wa/FWlIWKttNPRspbrg
        DTkqK6eLCl317v5bzAhPr7httySxYhwM6wI2yKk6WQ==
X-Google-Smtp-Source: ACHHUZ6RxwRjhVT1jWPTqPLOssJ+Sv0yYtXL8St3r16br5rvZPanYlxafPPy/Shr7pVoiyYUwAHeCw==
X-Received: by 2002:a9d:6246:0:b0:6ab:1338:fed5 with SMTP id i6-20020a9d6246000000b006ab1338fed5mr2357487otk.11.1685706500587;
        Fri, 02 Jun 2023 04:48:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a62e30b000000b0064afdc88465sm834993pfh.213.2023.06.02.04.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:20 -0700 (PDT)
Message-ID: <6479d704.620a0220.8a0fa.1151@mx.google.com>
Date:   Fri, 02 Jun 2023 04:48:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.181-23-gf2a19702506cf
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 178 runs,
 4 regressions (v5.10.181-23-gf2a19702506cf)
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

stable-rc/linux-5.10.y baseline: 178 runs, 4 regressions (v5.10.181-23-gf2a=
19702506cf)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.181-23-gf2a19702506cf/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.181-23-gf2a19702506cf
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f2a19702506cf5aee6bf44c1a1c48520b2455d75 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a34ea35a2800ccf5de3b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-23-gf2a19702506cf/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-23-gf2a19702506cf/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a34ea35a2800ccf5de44
        failing since 135 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-02T08:07:31.695301  + set +x<8>[   11.075216] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3636326_1.5.2.4.1>
    2023-06-02T08:07:31.696133  =

    2023-06-02T08:07:31.806918  / # #
    2023-06-02T08:07:31.910749  export SHELL=3D/bin/sh
    2023-06-02T08:07:31.911927  #
    2023-06-02T08:07:32.014471  / # export SHELL=3D/bin/sh. /lava-3636326/e=
nvironment
    2023-06-02T08:07:32.015670  =

    2023-06-02T08:07:32.016248  / # . /lava-3636326/environment<3>[   11.37=
1272] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-06-02T08:07:32.118815  /lava-3636326/bin/lava-test-runner /lava-36=
36326/1
    2023-06-02T08:07:32.120784   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a33637a2687b83f5de33

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-23-gf2a19702506cf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-23-gf2a19702506cf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a33637a2687b83f5de3c
        failing since 65 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-02T08:07:02.521046  + set +x

    2023-06-02T08:07:02.527987  <8>[   11.051300] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10560367_1.4.2.3.1>

    2023-06-02T08:07:02.632351  / # #

    2023-06-02T08:07:02.733067  export SHELL=3D/bin/sh

    2023-06-02T08:07:02.733302  #

    2023-06-02T08:07:02.833883  / # export SHELL=3D/bin/sh. /lava-10560367/=
environment

    2023-06-02T08:07:02.834106  =


    2023-06-02T08:07:02.934683  / # . /lava-10560367/environment/lava-10560=
367/bin/lava-test-runner /lava-10560367/1

    2023-06-02T08:07:02.935001  =


    2023-06-02T08:07:02.940258  / # /lava-10560367/bin/lava-test-runner /la=
va-10560367/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a24633c9f76c7ff5de36

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-23-gf2a19702506cf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-23-gf2a19702506cf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479a24633c9f76c7ff5de3f
        failing since 65 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-02T08:02:56.983309  + set +x<8>[   12.924698] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10560326_1.4.2.3.1>

    2023-06-02T08:02:56.983842  =


    2023-06-02T08:02:57.090949  #

    2023-06-02T08:02:57.193659  / # #export SHELL=3D/bin/sh

    2023-06-02T08:02:57.194408  =


    2023-06-02T08:02:57.295838  / # export SHELL=3D/bin/sh. /lava-10560326/=
environment

    2023-06-02T08:02:57.296559  =


    2023-06-02T08:02:57.397938  / # . /lava-10560326/environment/lava-10560=
326/bin/lava-test-runner /lava-10560326/1

    2023-06-02T08:02:57.399219  =


    2023-06-02T08:02:57.404649  / # /lava-10560326/bin/lava-test-runner /la=
va-10560326/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a0406ebda74265f5de39

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-23-gf2a19702506cf/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743=
-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
81-23-gf2a19702506cf/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743=
-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6479a0406ebda74265f5d=
e3a
        failing since 4 days (last pass: v5.10.180-154-gfd59dd82642d, first=
 fail: v5.10.180-212-g5bb979836617c) =

 =20
