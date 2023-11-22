Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90B37F4EDD
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 19:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjKVSBh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 13:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjKVSBg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 13:01:36 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D509E112
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 10:01:30 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cf7a1546c0so310535ad.0
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 10:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700676090; x=1701280890; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ2KCc6+qU/5TGqstbH0sXCz/MBbFzwy2b+pAkL+Cf8=;
        b=jWkLVXwKF2yPDuLyPM6HDf5LrbZHwggVh1jHZzbJp+uHpMwCTang5IFmlxA2dAVkIn
         rwwv5GFpiU+VQyumA/blwmNDUE2w0nogt0nPzogwWkUe19+8+RidZiI52eUtJ9FK0ICy
         fG+kx1FqZ6GeTFnU6U5uh7m1oz0ZxJ+Nf4yRYZwLvDHbxOPfC/7mJ+gz9hwuW98EORFN
         7UvFm5uuUb4etbzFWzBlFZy1my3CEPwtZ73n7xfkrpBHgDQvanNNjPPpP/AIqistV95o
         Y+Xwy0L5aH8zDUsqSjZoWa04joqxI9Ai0OU5ixs7tF1b2r6mTTvThtrfGg2i7jEIVA7x
         Yz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676090; x=1701280890;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ2KCc6+qU/5TGqstbH0sXCz/MBbFzwy2b+pAkL+Cf8=;
        b=nsyqWSG1/JqasD/2qKf+hpVzrHJRNLM1xOTky4gxSi7PK2ftC+Ofv6vEpOQiUPmL32
         QDKhvNXKtVPRzwpDFHZh0Jv/WqA0CYV9F1DkmDHgFuUei1d3wYS++u+EfwHzSAXUKf/j
         VQWomX3zdtuDigo4qYmVXOJ6L55O8p73VxDTAidFzZRwKiZ+7V0ETf5W0RYQqa2wk47C
         gKcwho7Mzlm24T4adwOXmsKyKPwPx/6/JMKe4QV3JZBM7f+oF/gR1Rv3nvrBVVvc08Ue
         z/QSuWePSYmeBjma34Ko+NIVyQ06Ibq+QGqdqAmQUF5xVq19rlsgA5oEJbkpYJuqFf83
         IFvg==
X-Gm-Message-State: AOJu0YynYolB5uFGim/mIcvhFLQl9wTXzfMkvlFgEHs5lVh1+D99zg2a
        TeGxsmYgMOtTgOokoPgbrf2JZ7ggmJ4cuTE9lzQ=
X-Google-Smtp-Source: AGHT+IEBLWXuP1DClD5OnOVNjrDC9UbTtJeOvmr59IsfWyMpAGktM7VOrWL0y8fYyiFnlR0C0dtVfA==
X-Received: by 2002:a17:902:b20a:b0:1cf:6ccf:7599 with SMTP id t10-20020a170902b20a00b001cf6ccf7599mr3052686plr.5.1700676089519;
        Wed, 22 Nov 2023 10:01:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gb2-20020a17090b060200b0028012be0764sm75024pjb.20.2023.11.22.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:01:28 -0800 (PST)
Message-ID: <655e41f8.170a0220.b533a.0821@mx.google.com>
Date:   Wed, 22 Nov 2023 10:01:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-98-g6f84b6dba25c
Subject: stable-rc/queue/5.10 baseline: 118 runs,
 6 regressions (v5.10.201-98-g6f84b6dba25c)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/5.10 baseline: 118 runs, 6 regressions (v5.10.201-98-g6f84b=
6dba25c)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
          | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
          | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
          | 1          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
          | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
          | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.201-98-g6f84b6dba25c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.201-98-g6f84b6dba25c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6f84b6dba25cdaa2c23f55db09033a3a1261d1b3 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/655e11b46fc85ad1b97e4a93

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e11b56fc85ad1b97e4ad3
        new failure (last pass: v5.10.181-18-g1622068b57a4)

    2023-11-22T14:35:06.594101  / # #
    2023-11-22T14:35:06.696976  export SHELL=3D/bin/sh
    2023-11-22T14:35:06.697730  #
    2023-11-22T14:35:06.799793  / # export SHELL=3D/bin/sh. /lava-261272/en=
vironment
    2023-11-22T14:35:06.800624  =

    2023-11-22T14:35:06.902682  / # . /lava-261272/environment/lava-261272/=
bin/lava-test-runner /lava-261272/1
    2023-11-22T14:35:06.904054  =

    2023-11-22T14:35:06.917806  / # /lava-261272/bin/lava-test-runner /lava=
-261272/1
    2023-11-22T14:35:06.977622  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-22T14:35:06.978179  + cd /lava-261272/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/655e10f8b5c78823257e4ab6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e10f8b5c78823257e4abf
        new failure (last pass: v5.10.181-18-g1622068b57a4)

    2023-11-22T14:38:43.786809  / # #

    2023-11-22T14:38:43.888978  export SHELL=3D/bin/sh

    2023-11-22T14:38:43.889773  #

    2023-11-22T14:38:43.991168  / # export SHELL=3D/bin/sh. /lava-12059596/=
environment

    2023-11-22T14:38:43.991868  =


    2023-11-22T14:38:44.093262  / # . /lava-12059596/environment/lava-12059=
596/bin/lava-test-runner /lava-12059596/1

    2023-11-22T14:38:44.094360  =


    2023-11-22T14:38:44.111042  / # /lava-12059596/bin/lava-test-runner /la=
va-12059596/1

    2023-11-22T14:38:44.159947  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T14:38:44.160453  + cd /lav<8>[   16.479592] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12059596_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/655e115093caf3b14f7e4a84

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock=
-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock=
-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e115093caf3b14f7e4a8d
        new failure (last pass: v5.10.181-18-g1622068b57a4)

    2023-11-22T14:33:35.283487  / # #

    2023-11-22T14:33:36.538270  export SHELL=3D/bin/sh

    2023-11-22T14:33:36.548555  #

    2023-11-22T14:33:36.548636  / # export SHELL=3D/bin/sh

    2023-11-22T14:33:38.288551  . /lava-12059599/environment

    2023-11-22T14:33:38.298818  / # . /lava-12059599/environment

    2023-11-22T14:33:41.487639  / # /lava-12059599/bin/lava-test-runner /la=
va-12059599/1

    2023-11-22T14:33:41.497996  /lava-12059599/bin/lava-test-runner /lava-1=
2059599/1

    2023-11-22T14:33:41.553719  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T14:33:41.553795  + cd /lava-12059599/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/655e10f49c79c45fcd7e4a9f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e10f49c79c45fcd7e4aa8
        new failure (last pass: v5.10.176-241-ga0049fd9c865)

    2023-11-22T14:32:11.267634  + set<8>[   16.971432] <LAVA_SIGNAL_ENDRUN =
0_dmesg 444852_1.5.2.4.1>
    2023-11-22T14:32:11.267871   +x
    2023-11-22T14:32:11.372217  / # #
    2023-11-22T14:32:11.473851  export SHELL=3D/bin/sh
    2023-11-22T14:32:11.474425  #
    2023-11-22T14:32:11.575335  / # export SHELL=3D/bin/sh. /lava-444852/en=
vironment
    2023-11-22T14:32:11.575922  =

    2023-11-22T14:32:11.676841  / # . /lava-444852/environment/lava-444852/=
bin/lava-test-runner /lava-444852/1
    2023-11-22T14:32:11.677684  =

    2023-11-22T14:32:11.683440  / # /lava-444852/bin/lava-test-runner /lava=
-444852/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/655e110af47db920297e4a7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e110af47db920297e4a84
        new failure (last pass: v5.10.176-241-ga0049fd9c865)

    2023-11-22T14:38:58.058948  / # #

    2023-11-22T14:38:58.160961  export SHELL=3D/bin/sh

    2023-11-22T14:38:58.161639  #

    2023-11-22T14:38:58.262914  / # export SHELL=3D/bin/sh. /lava-12059600/=
environment

    2023-11-22T14:38:58.263591  =


    2023-11-22T14:38:58.364888  / # . /lava-12059600/environment/lava-12059=
600/bin/lava-test-runner /lava-12059600/1

    2023-11-22T14:38:58.365959  =


    2023-11-22T14:38:58.367190  / # /lava-12059600/bin/lava-test-runner /la=
va-12059600/1

    2023-11-22T14:38:58.409565  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T14:38:58.442486  + cd /lava-1205960<8>[   18.165866] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12059600_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655e1000c2118e2c777e4a70

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-98-g6f84b6dba25c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e1000c2118e2c777e4a79
        new failure (last pass: v5.10.165-77-g4600242c13ed)

    2023-11-22T14:27:45.991313  / # #
    2023-11-22T14:27:46.092449  export SHELL=3D/bin/sh
    2023-11-22T14:27:46.092867  #
    2023-11-22T14:27:46.193637  / # export SHELL=3D/bin/sh. /lava-3842463/e=
nvironment
    2023-11-22T14:27:46.194009  =

    2023-11-22T14:27:46.294841  / # . /lava-3842463/environment/lava-384246=
3/bin/lava-test-runner /lava-3842463/1
    2023-11-22T14:27:46.295569  =

    2023-11-22T14:27:46.304530  / # /lava-3842463/bin/lava-test-runner /lav=
a-3842463/1
    2023-11-22T14:27:46.400597  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-22T14:27:46.400833  + cd /lava-3842463/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
