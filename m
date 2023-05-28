Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2979714139
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 01:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjE1XdQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 19:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1XdQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 19:33:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D499E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:33:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d2467d640so3267401b3a.1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685316792; x=1687908792;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qdt2p9bO5bVT06gGqt1DnRSwmKZhxnePoWRlpexgky8=;
        b=nWVHFrJeJogUpVr46k6MAUwF89iDowWgfTz+ixIEQI8Q1CPjORCd1douVfQwisVtFn
         oaLveRFAPopvdY42fds2Nb7dvo3lsLuCYMdMhvNigeS+rh2wsGf3cSI1IdxyM++3MdCe
         MGVqcysLaRswrVqV7UiK20AGdrIrQn3w7ztJEyOrI7yNx27TGJnFSpbcC7R1vhlc34m2
         pAX7zJCekqtVbsOcUn9Tghx15WJuNLz7alJF5ke+ghf6wYoZvl4Ulnpzof/fy8IBsHCW
         6nx6ZTGDZ7LiZPhJSr47rUJMJeFnCFmQVUg9MKrA8HowA3QEZnd1OSifQlkc6Sa52D4J
         Thsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685316792; x=1687908792;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdt2p9bO5bVT06gGqt1DnRSwmKZhxnePoWRlpexgky8=;
        b=WFAN+YqmIXQ56mt3thHJn2xkZXtq/NL5PbWFb1w7HQ3mRfHDvM7690iGKUWDRHAxUr
         dwjqR/2SCOFuzXr4Of97a50E0u6NdWiRl9ggdCp2YrkaccTaQYweT8O0FsoQ0T9cMWy4
         PE2oxFAIvoEgg7ljkWjziEwIEJYpAMbzCLIHlnV38LLmfoAp0axg5gVL0N9G9gd2XdwM
         rE8VgmOpVuvex81KYIHKYc7wGh0R1bYRZU+Lcyz5HKKWZCJf3yCqkMzp5Lr78GyVFmz6
         4lbR3zySPWzdtRXiw42NCaxUjb4CqZ19V/pyK6hpwbGzIsAb/81kKgT01n8dYpL/vg0t
         Qxqg==
X-Gm-Message-State: AC+VfDwk3FEiKD2PCQ/umG1EYznuGaMrRO42LKep+PV7WXDiMt2kozrT
        2pLdtILfFhdBKcXoKqtEsdNWXJjNnSBIHgAyVCUXXw==
X-Google-Smtp-Source: ACHHUZ5LwXY3FN6TZ2OEY1BtuZDgdNdm5H4BjNmdTSbw/3o5YwngmCKnHg8HfYjTiGbOZCad4BZbug==
X-Received: by 2002:a05:6a00:1825:b0:623:8592:75c4 with SMTP id y37-20020a056a00182500b00623859275c4mr13416827pfa.29.1685316791980;
        Sun, 28 May 2023 16:33:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r14-20020a62e40e000000b0064cb6206463sm5586566pfh.85.2023.05.28.16.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 16:33:11 -0700 (PDT)
Message-ID: <6473e4b7.620a0220.12d60.ab5b@mx.google.com>
Date:   Sun, 28 May 2023 16:33:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-274-gb5766b96f7b27
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 169 runs,
 13 regressions (v5.15.112-274-gb5766b96f7b27)
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

stable-rc/linux-5.15.y baseline: 169 runs, 13 regressions (v5.15.112-274-gb=
5766b96f7b27)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-g12a-sei510            | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.112-274-gb5766b96f7b27/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.112-274-gb5766b96f7b27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b5766b96f7b270c00ff531882e0b071ecb1a2f4c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473b00a65e6858dd82e8624

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473b00a65e6858dd82e8629
        failing since 60 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T19:48:08.038840  <8>[   10.566866] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498039_1.4.2.3.1>

    2023-05-28T19:48:08.042251  + set +x

    2023-05-28T19:48:08.147154  / # #

    2023-05-28T19:48:08.247763  export SHELL=3D/bin/sh

    2023-05-28T19:48:08.247966  #

    2023-05-28T19:48:08.348555  / # export SHELL=3D/bin/sh. /lava-10498039/=
environment

    2023-05-28T19:48:08.348729  =


    2023-05-28T19:48:08.449252  / # . /lava-10498039/environment/lava-10498=
039/bin/lava-test-runner /lava-10498039/1

    2023-05-28T19:48:08.449592  =


    2023-05-28T19:48:08.455056  / # /lava-10498039/bin/lava-test-runner /la=
va-10498039/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473b00d65e6858dd82e864c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473b00d65e6858dd82e8651
        failing since 60 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T19:48:06.597690  <8>[   11.025707] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498043_1.4.2.3.1>

    2023-05-28T19:48:06.601298  + set +x

    2023-05-28T19:48:06.703235  #

    2023-05-28T19:48:06.703615  =


    2023-05-28T19:48:06.804373  / # #export SHELL=3D/bin/sh

    2023-05-28T19:48:06.804634  =


    2023-05-28T19:48:06.905301  / # export SHELL=3D/bin/sh. /lava-10498043/=
environment

    2023-05-28T19:48:06.905479  =


    2023-05-28T19:48:07.005984  / # . /lava-10498043/environment/lava-10498=
043/bin/lava-test-runner /lava-10498043/1

    2023-05-28T19:48:07.006415  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473b1d114c5ff0f492e866c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6473b1d114c5ff0f492e8=
66d
        failing since 381 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473afa2a2abfc216b2e8671

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473afa2a2abfc216b2e8676
        failing since 131 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-05-28T19:46:27.433835  <8>[    9.871213] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3627684_1.5.2.4.1>
    2023-05-28T19:46:27.541498  / # #
    2023-05-28T19:46:27.643869  export SHELL=3D/bin/sh
    2023-05-28T19:46:27.645001  #
    2023-05-28T19:46:27.747010  / # export SHELL=3D/bin/sh. /lava-3627684/e=
nvironment
    2023-05-28T19:46:27.747468  =

    2023-05-28T19:46:27.848912  / # . /lava-3627684/environment/lava-362768=
4/bin/lava-test-runner /lava-3627684/1
    2023-05-28T19:46:27.849553  <3>[   10.193297] Bluetooth: hci0: command =
0xfc18 tx timeout
    2023-05-28T19:46:27.849708  =

    2023-05-28T19:46:27.854519  / # /lava-3627684/bin/lava-test-runner /lav=
a-3627684/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473b0002250b49fec2e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473b0002250b49fec2e860c
        failing since 60 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T19:48:03.195236  + set +x

    2023-05-28T19:48:03.201771  <8>[   10.928750] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498073_1.4.2.3.1>

    2023-05-28T19:48:03.306214  / # #

    2023-05-28T19:48:03.406974  export SHELL=3D/bin/sh

    2023-05-28T19:48:03.407149  #

    2023-05-28T19:48:03.507690  / # export SHELL=3D/bin/sh. /lava-10498073/=
environment

    2023-05-28T19:48:03.507849  =


    2023-05-28T19:48:03.608409  / # . /lava-10498073/environment/lava-10498=
073/bin/lava-test-runner /lava-10498073/1

    2023-05-28T19:48:03.608676  =


    2023-05-28T19:48:03.613236  / # /lava-10498073/bin/lava-test-runner /la=
va-10498073/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473aff2ea5bafe2aa2e8686

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473aff2ea5bafe2aa2e868b
        failing since 60 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T19:47:49.499969  <8>[   10.260396] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498061_1.4.2.3.1>

    2023-05-28T19:47:49.503088  + set +x

    2023-05-28T19:47:49.607637  / # #

    2023-05-28T19:47:49.708300  export SHELL=3D/bin/sh

    2023-05-28T19:47:49.708489  #

    2023-05-28T19:47:49.808981  / # export SHELL=3D/bin/sh. /lava-10498061/=
environment

    2023-05-28T19:47:49.809180  =


    2023-05-28T19:47:49.909721  / # . /lava-10498061/environment/lava-10498=
061/bin/lava-test-runner /lava-10498061/1

    2023-05-28T19:47:49.910049  =


    2023-05-28T19:47:49.914544  / # /lava-10498061/bin/lava-test-runner /la=
va-10498061/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473b00d2250b49fec2e8642

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473b00d2250b49fec2e8647
        failing since 60 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T19:48:06.062813  + <8>[   10.760273] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10498022_1.4.2.3.1>

    2023-05-28T19:48:06.062897  set +x

    2023-05-28T19:48:06.167023  / # #

    2023-05-28T19:48:06.267656  export SHELL=3D/bin/sh

    2023-05-28T19:48:06.267879  #

    2023-05-28T19:48:06.368447  / # export SHELL=3D/bin/sh. /lava-10498022/=
environment

    2023-05-28T19:48:06.368639  =


    2023-05-28T19:48:06.469177  / # . /lava-10498022/environment/lava-10498=
022/bin/lava-test-runner /lava-10498022/1

    2023-05-28T19:48:06.469471  =


    2023-05-28T19:48:06.473926  / # /lava-10498022/bin/lava-test-runner /la=
va-10498022/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473aff79ade27941e2e8622

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473aff79ade27941e2e8627
        failing since 60 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-28T19:47:57.175973  <8>[   11.883983] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498002_1.4.2.3.1>

    2023-05-28T19:47:57.280503  / # #

    2023-05-28T19:47:57.381080  export SHELL=3D/bin/sh

    2023-05-28T19:47:57.381225  #

    2023-05-28T19:47:57.481743  / # export SHELL=3D/bin/sh. /lava-10498002/=
environment

    2023-05-28T19:47:57.481893  =


    2023-05-28T19:47:57.582436  / # . /lava-10498002/environment/lava-10498=
002/bin/lava-test-runner /lava-10498002/1

    2023-05-28T19:47:57.582704  =


    2023-05-28T19:47:57.587497  / # /lava-10498002/bin/lava-test-runner /la=
va-10498002/1

    2023-05-28T19:47:57.593045  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12a-sei510            | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6473b3be8f38c9aea12e85f9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g1=
2a-sei510.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g1=
2a-sei510.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473b3be8f38c9aea12e85fe
        new failure (last pass: v5.15.112-204-g30213a86a6fe)

    2023-05-28T20:04:05.358244  / # #
    2023-05-28T20:04:05.460987  export SHELL=3D/bin/sh
    2023-05-28T20:04:05.461697  #
    2023-05-28T20:04:05.563591  / # export SHELL=3D/bin/sh. /lava-3627816/e=
nvironment
    2023-05-28T20:04:05.564338  =

    2023-05-28T20:04:05.666298  / # . /lava-3627816/environment/lava-362781=
6/bin/lava-test-runner /lava-3627816/1
    2023-05-28T20:04:05.667649  =

    2023-05-28T20:04:05.682274  / # /lava-3627816/bin/lava-test-runner /lav=
a-3627816/1
    2023-05-28T20:04:05.747339  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-28T20:04:05.747652  + cd /lava-3627816/1/tests/1_bootrr =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6473b1ab3469a23cbd2e85e6

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-274-gb5766b96f7b27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6473b1ab3469a23cbd2e8600
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-28T19:54:57.883857  /lava-10498121/1/../bin/lava-test-case

    2023-05-28T19:54:57.890367  <8>[   61.577872] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6473b1ab3469a23cbd2e8600
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-28T19:54:57.883857  /lava-10498121/1/../bin/lava-test-case

    2023-05-28T19:54:57.890367  <8>[   61.577872] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6473b1ab3469a23cbd2e8602
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-28T19:54:56.843408  /lava-10498121/1/../bin/lava-test-case

    2023-05-28T19:54:56.849693  <8>[   60.537227] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473b1ab3469a23cbd2e868a
        failing since 13 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-28T19:54:42.712061  <8>[   46.402397] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10498121_1.5.2.3.1>

    2023-05-28T19:54:42.715397  + set +x

    2023-05-28T19:54:42.823047  / # #

    2023-05-28T19:54:42.925580  export SHELL=3D/bin/sh

    2023-05-28T19:54:42.926368  #

    2023-05-28T19:54:43.028051  / # export SHELL=3D/bin/sh. /lava-10498121/=
environment

    2023-05-28T19:54:43.028845  =


    2023-05-28T19:54:43.130394  / # . /lava-10498121/environment/lava-10498=
121/bin/lava-test-runner /lava-10498121/1

    2023-05-28T19:54:43.131705  =


    2023-05-28T19:54:43.137452  / # /lava-10498121/bin/lava-test-runner /la=
va-10498121/1
 =

    ... (13 line(s) more)  =

 =20
