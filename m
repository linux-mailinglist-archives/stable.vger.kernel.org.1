Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF47140A0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 23:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjE1Vxw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1Vxv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 17:53:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B827B1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 14:53:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-530638a60e1so2377906a12.2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 14:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685310829; x=1687902829;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=maE+IfELSKvdSuGYXtpqcukX9BoGg4qFG4GN+rN0UDU=;
        b=OmRrAc1CvSWCqTHhV0ASJ5w3AGCrF13ltrl5DIaTew/wlq9EVKbjqJgTcQyqouMEgi
         okS0V0Z15TbKTf2vuTqDEFhNqePwIwt2Ni3nUMCdQdicIlnxM6ljxNO+ayEwl8h7D01d
         b7zUM96HXE3nLUqkyzFfoUvzbHtxTFqSG2PvR3NpkWHvbsy13q6kPqkwOEw6/18BsB2V
         j/xdzGd1sNJy8h/O2L2mTQH++qvmEQZCmHOT0KzuuH2zkWZ7gcxoShHyUK+rtWnE5jyL
         Ocu5labg0iZ86OYMTUiG+G82hy+tYq4y+d64mLJuvXIViQqIdyvY/64ViTKmqnzg42HE
         JuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685310829; x=1687902829;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maE+IfELSKvdSuGYXtpqcukX9BoGg4qFG4GN+rN0UDU=;
        b=jKbTnhKttQUJw7gwDJN2nDEScdPhGZfzVNl1RO9NDeeIeLLGComI+VG4HzM5QTZxBz
         WKbBPweHttWpSg2gDFfMmhGSxP6a3GlYe2j3Yx14wBYnD6pUsCVE3dwnNEP3n2myoBZu
         iHKC45t/1c+SdgSdrSZYZ3RUNpdhFK3pWfOxKoDnuk4rC+v1a0+ip4Xy6EXDDAquEm2f
         xMvYDftzXOqBThPuK9HStCTCAO23Beo/FvYEU+9pNHkT9hz1aJi/QKZ1gBbentLqqw3r
         WVGhxkk4rr3bjrW55OMoMAALz7e90EmfTXJI+NMAjs0bioYmaWuXvc5oOxuRYtqMEPDT
         Nb2g==
X-Gm-Message-State: AC+VfDwSRMRVo61gVJgo3qF2rmF7kUdwIMaGdztmEy4Zqz25/MuQAp7n
        RMygGN4L6T+dZXYV2yH4/yNolzMuIPL98Ohjw7jLpw==
X-Google-Smtp-Source: ACHHUZ7bHZs9EuD0MiW4ZAO0fAn7uM95ISyp7l9WxVrIDACP1+lMrFv2MF5i2afOwaS59Khv1xbI4g==
X-Received: by 2002:a05:6a20:12c6:b0:10f:3fa0:fd78 with SMTP id v6-20020a056a2012c600b0010f3fa0fd78mr6781084pzg.24.1685310829161;
        Sun, 28 May 2023 14:53:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k8-20020a635a48000000b0052cbd854927sm5705779pgm.18.2023.05.28.14.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 14:53:48 -0700 (PDT)
Message-ID: <6473cd6c.630a0220.d78ae.b313@mx.google.com>
Date:   Sun, 28 May 2023 14:53:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-212-g5bb979836617c
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 174 runs,
 5 regressions (v5.10.180-212-g5bb979836617c)
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

stable-rc/linux-5.10.y baseline: 174 runs, 5 regressions (v5.10.180-212-g5b=
b979836617c)

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

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.180-212-g5bb979836617c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.180-212-g5bb979836617c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5bb979836617cfb715ff0416b8210f6648fd9f73 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647398902b18e1624b2e85ee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g5bb979836617c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g5bb979836617c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647398902b18e1624b2e85f3
        failing since 130 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-05-28T18:08:02.906502  <8>[   11.041460] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3627219_1.5.2.4.1>
    2023-05-28T18:08:03.013454  / # #
    2023-05-28T18:08:03.115063  export SHELL=3D/bin/sh
    2023-05-28T18:08:03.115480  #<3>[   11.131769] Bluetooth: hci0: command=
 0xfc18 tx timeout
    2023-05-28T18:08:03.115688  =

    2023-05-28T18:08:03.216865  / # export SHELL=3D/bin/sh. /lava-3627219/e=
nvironment
    2023-05-28T18:08:03.217235  =

    2023-05-28T18:08:03.318393  / # . /lava-3627219/environment/lava-362721=
9/bin/lava-test-runner /lava-3627219/1
    2023-05-28T18:08:03.318916  =

    2023-05-28T18:08:03.323755  / # /lava-3627219/bin/lava-test-runner /lav=
a-3627219/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64739758950b73192a2e85ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g5bb979836617c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g5bb979836617c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64739758950b73192a2e85f3
        failing since 60 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-28T18:02:46.970425  + set +x

    2023-05-28T18:02:46.977090  <8>[   10.274515] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10496787_1.4.2.3.1>

    2023-05-28T18:02:47.081182  / # #

    2023-05-28T18:02:47.181825  export SHELL=3D/bin/sh

    2023-05-28T18:02:47.182022  #

    2023-05-28T18:02:47.282510  / # export SHELL=3D/bin/sh. /lava-10496787/=
environment

    2023-05-28T18:02:47.282694  =


    2023-05-28T18:02:47.383192  / # . /lava-10496787/environment/lava-10496=
787/bin/lava-test-runner /lava-10496787/1

    2023-05-28T18:02:47.383457  =


    2023-05-28T18:02:47.387721  / # /lava-10496787/bin/lava-test-runner /la=
va-10496787/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64739752fa98836e792e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g5bb979836617c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g5bb979836617c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64739752fa98836e792e85ee
        failing since 60 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-28T18:02:43.188378  + set +x

    2023-05-28T18:02:43.194994  <8>[   11.904070] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10496836_1.4.2.3.1>

    2023-05-28T18:02:43.302461  / # #

    2023-05-28T18:02:43.404560  export SHELL=3D/bin/sh

    2023-05-28T18:02:43.405285  #

    2023-05-28T18:02:43.506616  / # export SHELL=3D/bin/sh. /lava-10496836/=
environment

    2023-05-28T18:02:43.507320  =


    2023-05-28T18:02:43.608704  / # . /lava-10496836/environment/lava-10496=
836/bin/lava-test-runner /lava-10496836/1

    2023-05-28T18:02:43.609392  =


    2023-05-28T18:02:43.614510  / # /lava-10496836/bin/lava-test-runner /la=
va-10496836/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64739b5d9d53a459692e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g5bb979836617c/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a774=
3-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g5bb979836617c/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a774=
3-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64739b5d9d53a459692e8=
5e7
        new failure (last pass: v5.10.180-154-gfd59dd82642d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64739d208dedadc64c2e8608

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g5bb979836617c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-212-g5bb979836617c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/64739d208dedadc=
64c2e860f
        new failure (last pass: v5.10.180-154-gfd59dd82642d)
        1 lines

    2023-05-28T18:27:31.264487  kern  :emerg : Disabling IRQ #114

    2023-05-28T18:27:31.264564  <8>[  171.405754] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>

    2023-05-28T18:27:31.264617  + set +x

    2023-05-28T18:27:31.264665  <8>[  171.415517] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10497038_1.5.2.4.1>
   =

 =20
