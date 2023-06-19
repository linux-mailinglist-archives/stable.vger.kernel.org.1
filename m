Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC356735A25
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjFSO6K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjFSO6K (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 10:58:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32AD127
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 07:58:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-543ae674f37so1815152a12.1
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687186686; x=1689778686;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0ciElucLMmWvMx/r0wlHY9T94xBD5dG1vuZ/OG4ZZAA=;
        b=bLxbIE15FmzyWXc1mOpO+dGGQZpJNxFzqKOnEnh4jju5drPtmRzImOgdrGoL9hvgrd
         bcYlfgZhB2L56n48hmhVWX24h0BgcbVEzSVJHqeM9f1B6buxxndFeL39SOy0FWKMVQdZ
         3z0hGp+jHeZb5eOp4cfy8Pa83KgRBPMA5H1ol/zGNs8GAaaMUNbChqzRP03efRdaKC9A
         Uj1mi7Fnbf9RF+172uSLJbg288jPK2QY+mP8+d89Mm4sSGDM8cgFkCkr9JGTOtel3ebe
         8h9YvB428m+2AKTot0Bb0FZcHSd2RTN9mWPgDYNNVkZuuNWa32jIi7uymG7NRjLyNr79
         JYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687186686; x=1689778686;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ciElucLMmWvMx/r0wlHY9T94xBD5dG1vuZ/OG4ZZAA=;
        b=VcDjpzx/XogDoQCITVp1uCAZrFx6Ii4UMmMOZBW1DjTUC+y4LVuuj3JWj/uSce9O95
         OSg8eyQC897DLCki2iga5FOeeldnVyGiwIhWeNSxZGPlwb8XH4COxbpq9YMagInTaUZp
         6nHWneKz9veqV/urSVF7dAdFZJRmoUOwdQWI0E6IRhjI2gnERtLK59bbRo95pLWvhxFq
         SraCeIqEl15jAhdbu5GuhiIK/9bSB13puZFNLad/ckO5PDasfDf1xe4FkY3yhnzLIUq/
         tyOP9NDvmMuucGiGLie/m9AayLZNymX4GRZ8zMrBw5q4RjRYsy94rxk6AFn0RQ3SRPjQ
         nyOg==
X-Gm-Message-State: AC+VfDy8Hg/bma4RqyNQZlybFiEpXBFlXPTKzRj6xTYAdGnYMkd5imFM
        NCZ+F79XpvkiDIB71psjZRUma0kuaE0U+Rwh04v5xGkC
X-Google-Smtp-Source: ACHHUZ7ziVqkGC3thcWQYu1gzrBkQVKdovAUixMZCF7Hj0yZf4kDJgcDHtSkO+PLeFQ4AdCxNldWrw==
X-Received: by 2002:a17:903:11cd:b0:1b3:815b:cf02 with SMTP id q13-20020a17090311cd00b001b3815bcf02mr9549774plh.19.1687186686460;
        Mon, 19 Jun 2023 07:58:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b001ae6fe84244sm20561191plh.243.2023.06.19.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:58:06 -0700 (PDT)
Message-ID: <64906cfe.170a0220.337b4.84ae@mx.google.com>
Date:   Mon, 19 Jun 2023 07:58:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-90-g8ce687c6d277
Subject: stable-rc/linux-5.10.y baseline: 173 runs,
 8 regressions (v5.10.184-90-g8ce687c6d277)
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

stable-rc/linux-5.10.y baseline: 173 runs, 8 regressions (v5.10.184-90-g8ce=
687c6d277)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.184-90-g8ce687c6d277/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.184-90-g8ce687c6d277
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8ce687c6d277beb9d0c0c1109a3336ae63976ee2 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649039befec41834fb3061e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649039befec41834fb306=
1e6
        new failure (last pass: v5.10.184-82-g8b1aaf75a5ea) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64903d090c8b4ac77c30613b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903d090c8b4ac77c306140
        failing since 152 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-19T11:33:16.351948  <8>[   11.062712] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3677572_1.5.2.4.1>
    2023-06-19T11:33:16.458073  / # #
    2023-06-19T11:33:16.559513  export SHELL=3D/bin/sh
    2023-06-19T11:33:16.559963  #
    2023-06-19T11:33:16.661152  / # export SHELL=3D/bin/sh. /lava-3677572/e=
nvironment
    2023-06-19T11:33:16.661530  =

    2023-06-19T11:33:16.762758  / # . /lava-3677572/environment/lava-367757=
2/bin/lava-test-runner /lava-3677572/1
    2023-06-19T11:33:16.763292  =

    2023-06-19T11:33:16.768756  / # /lava-3677572/bin/lava-test-runner /lav=
a-3677572/1
    2023-06-19T11:33:16.858668  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649039403063e7d9c4306195

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649039403063e7d9c430619a
        failing since 82 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-19T11:17:04.355407  + set +x

    2023-06-19T11:17:04.362166  <8>[   10.896509] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10812726_1.4.2.3.1>

    2023-06-19T11:17:04.466119  / # #

    2023-06-19T11:17:04.566698  export SHELL=3D/bin/sh

    2023-06-19T11:17:04.566867  #

    2023-06-19T11:17:04.667336  / # export SHELL=3D/bin/sh. /lava-10812726/=
environment

    2023-06-19T11:17:04.667574  =


    2023-06-19T11:17:04.768065  / # . /lava-10812726/environment/lava-10812=
726/bin/lava-test-runner /lava-10812726/1

    2023-06-19T11:17:04.768380  =


    2023-06-19T11:17:04.772920  / # /lava-10812726/bin/lava-test-runner /la=
va-10812726/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64903926fbbd7d38e2306170

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903926fbbd7d38e2306175
        failing since 82 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-19T11:16:41.186275  <8>[   13.627901] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10812785_1.4.2.3.1>

    2023-06-19T11:16:41.189394  + set +x

    2023-06-19T11:16:41.294171  #

    2023-06-19T11:16:41.395598  / # #export SHELL=3D/bin/sh

    2023-06-19T11:16:41.396376  =


    2023-06-19T11:16:41.497944  / # export SHELL=3D/bin/sh. /lava-10812785/=
environment

    2023-06-19T11:16:41.498796  =


    2023-06-19T11:16:41.600569  / # . /lava-10812785/environment/lava-10812=
785/bin/lava-test-runner /lava-10812785/1

    2023-06-19T11:16:41.601872  =


    2023-06-19T11:16:41.607051  / # /lava-10812785/bin/lava-test-runner /la=
va-10812785/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64903a1ca3995b6d3c30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-=
iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-=
iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64903a1ca3995b6d3c306=
12f
        failing since 0 day (last pass: v5.10.184-46-gb25b2921d506, first f=
ail: v5.10.184-75-gb03b7f10db06) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64903c0c387e4768ef306186

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903c0c387e4768ef30618b
        failing since 51 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-19T11:28:59.700345  [   15.968066] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3677614_1.5.2.4.1>
    2023-06-19T11:28:59.804747  =

    2023-06-19T11:28:59.804955  / # #[   16.029185] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-06-19T11:28:59.906483  export SHELL=3D/bin/sh
    2023-06-19T11:28:59.906906  =

    2023-06-19T11:29:00.008263  / # export SHELL=3D/bin/sh. /lava-3677614/e=
nvironment
    2023-06-19T11:29:00.008677  =

    2023-06-19T11:29:00.110097  / # . /lava-3677614/environment/lava-367761=
4/bin/lava-test-runner /lava-3677614/1
    2023-06-19T11:29:00.111376  =

    2023-06-19T11:29:00.114628  / # /lava-3677614/bin/lava-test-runner /lav=
a-3677614/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64903e8a883a5cc0a030612f

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903e8a883a5cc0a030615b
        failing since 139 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-19T11:39:34.176199  + set +x
    2023-06-19T11:39:34.180343  <8>[   17.191549] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3677621_1.5.2.4.1>
    2023-06-19T11:39:34.300514  / # #
    2023-06-19T11:39:34.406123  export SHELL=3D/bin/sh
    2023-06-19T11:39:34.407615  #
    2023-06-19T11:39:34.511021  / # export SHELL=3D/bin/sh. /lava-3677621/e=
nvironment
    2023-06-19T11:39:34.512583  =

    2023-06-19T11:39:34.616020  / # . /lava-3677621/environment/lava-367762=
1/bin/lava-test-runner /lava-3677621/1
    2023-06-19T11:39:34.618738  =

    2023-06-19T11:39:34.622044  / # /lava-3677621/bin/lava-test-runner /lav=
a-3677621/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64903d1c0c8b4ac77c306148

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-90-g8ce687c6d277/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903d1c0c8b4ac77c306174
        failing since 139 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-19T11:33:16.514518  + set +x
    2023-06-19T11:33:16.518560  <8>[   17.008622] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 631720_1.5.2.4.1>
    2023-06-19T11:33:16.628909  / # #
    2023-06-19T11:33:16.730728  export SHELL=3D/bin/sh
    2023-06-19T11:33:16.731269  #
    2023-06-19T11:33:16.833254  / # export SHELL=3D/bin/sh. /lava-631720/en=
vironment
    2023-06-19T11:33:16.833726  =

    2023-06-19T11:33:16.935543  / # . /lava-631720/environment/lava-631720/=
bin/lava-test-runner /lava-631720/1
    2023-06-19T11:33:16.936563  =

    2023-06-19T11:33:16.940824  / # /lava-631720/bin/lava-test-runner /lava=
-631720/1 =

    ... (12 line(s) more)  =

 =20
