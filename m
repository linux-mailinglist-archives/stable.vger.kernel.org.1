Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959716FF6F6
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbjEKQSN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjEKQSM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 12:18:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB323C29
        for <stable@vger.kernel.org>; Thu, 11 May 2023 09:17:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaf91ae451so82789375ad.1
        for <stable@vger.kernel.org>; Thu, 11 May 2023 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683821867; x=1686413867;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dQ+Wh0m5+Menr8EgDKeiVKOurn0at6LNGZmnbqM4Pjg=;
        b=JSQOJoYgYetdxtOOQLkP1BtYNf1v2wgJWGnLayf1TZG5+g70Zkw+YMyx/DLoth5pRV
         bseJa1AZkb9vJl09qPKu3djuk19JBXBZGR35NHEpelWE+r5PemX2e0pRzJPN+9/a6YuF
         YGNrgG9y/MlL9StuVb/kjdbSujb1Yq7ZOPN8T4Z6kaGFFPa/GmXIKmpJwlw8px5eECgD
         54KVAVapaWZO2G2I/wqJB4OxcomMvBZiayScX8+Bs+ufkCNy9pbva6vsL5Cjl0LzMNAD
         0mFJQru85kVyJWiC9mQ1h7Y8ae78sY/zsOL/a31wUOmNw/fmMrdN/ChqYF6OSaOZsBC5
         3DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683821867; x=1686413867;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQ+Wh0m5+Menr8EgDKeiVKOurn0at6LNGZmnbqM4Pjg=;
        b=ERtLCovDQIXzGIVRie7TALJXd90vC1cjP1P1rrBSYs4iF4pNDax+GhBFE36eY3dIPK
         NzeFCmVhx5FLF4wD65fNhlmf4sbW16jTE8mu/oYGVaFlPg6PG8YKKFif1bWR+a1UhuRi
         OQTzhibEq5rFOYfqfBYndiiFcdvNboHvnCj+wnnBPoOx8sQAgYahe3jIL8tAgOCcCMEc
         MVMiUuj2U0t2KsC8JaxcdEkYvTrFGlGmdC4rLMTBwn2EoO/me9Vt9n3aFtVOatYWifmh
         9NGd0ylSfVLdt3fXXINMBYF+hgVFCWfz6aLBssvatqs65mfy9fA2MelTMSwnNcuZJqAJ
         FDaQ==
X-Gm-Message-State: AC+VfDzc0gjv1t4N/UP/60Hb7k71UMtrNufWASOlnk98jN+cuEj5zyOj
        z531X++yMQ3xLx7keug6VD71A5fL8JARc+oEfk/41w==
X-Google-Smtp-Source: ACHHUZ5V7X9CibyjqJ0Ye0Aj1qO6ZWfLFNFrzJz4C1iTxp6kY33+t04yffLTPFqCaiLhqa/75kv+mw==
X-Received: by 2002:a17:903:11c5:b0:1ac:7237:c9ef with SMTP id q5-20020a17090311c500b001ac7237c9efmr18361297plh.29.1683821867465;
        Thu, 11 May 2023 09:17:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a898800b0024e268985b1sm17334550pjn.9.2023.05.11.09.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:17:47 -0700 (PDT)
Message-ID: <645d152b.170a0220.39370.22a3@mx.google.com>
Date:   Thu, 11 May 2023 09:17:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.110-371-g8e98e7e5a063
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 172 runs,
 11 regressions (v5.15.110-371-g8e98e7e5a063)
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

stable-rc/queue/5.15 baseline: 172 runs, 11 regressions (v5.15.110-371-g8e9=
8e7e5a063)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx8mn-ddr4-evk              | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.110-371-g8e98e7e5a063/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.110-371-g8e98e7e5a063
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8e98e7e5a06351c910cb2a3d94f5c06ded9c29f5 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce2b27f5a0902322e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645ce2b27f5a0902322e85ed
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T12:42:00.421447  + set<8>[   11.323285] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10281719_1.4.2.3.1>

    2023-05-11T12:42:00.421564   +x

    2023-05-11T12:42:00.526466  / # #

    2023-05-11T12:42:00.627076  export SHELL=3D/bin/sh

    2023-05-11T12:42:00.627286  #

    2023-05-11T12:42:00.727770  / # export SHELL=3D/bin/sh. /lava-10281719/=
environment

    2023-05-11T12:42:00.727984  =


    2023-05-11T12:42:00.828533  / # . /lava-10281719/environment/lava-10281=
719/bin/lava-test-runner /lava-10281719/1

    2023-05-11T12:42:00.828874  =


    2023-05-11T12:42:00.833185  / # /lava-10281719/bin/lava-test-runner /la=
va-10281719/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce2b5ab568f56ce2e85ef

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645ce2b5ab568f56ce2e85f4
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T12:42:20.208655  <8>[   11.876354] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10281742_1.4.2.3.1>

    2023-05-11T12:42:20.212078  + set +x

    2023-05-11T12:42:20.314283  =


    2023-05-11T12:42:20.415039  / # #export SHELL=3D/bin/sh

    2023-05-11T12:42:20.415280  =


    2023-05-11T12:42:20.515903  / # export SHELL=3D/bin/sh. /lava-10281742/=
environment

    2023-05-11T12:42:20.516141  =


    2023-05-11T12:42:20.616778  / # . /lava-10281742/environment/lava-10281=
742/bin/lava-test-runner /lava-10281742/1

    2023-05-11T12:42:20.617183  =


    2023-05-11T12:42:20.622740  / # /lava-10281742/bin/lava-test-runner /la=
va-10281742/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce298daf1db14ad2e8616

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645ce298daf1db14ad2e861b
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T12:41:48.055586  + <8>[   10.191184] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10281706_1.4.2.3.1>

    2023-05-11T12:41:48.055697  set +x

    2023-05-11T12:41:48.156907  #

    2023-05-11T12:41:48.157245  =


    2023-05-11T12:41:48.257890  / # #export SHELL=3D/bin/sh

    2023-05-11T12:41:48.258067  =


    2023-05-11T12:41:48.358611  / # export SHELL=3D/bin/sh. /lava-10281706/=
environment

    2023-05-11T12:41:48.358792  =


    2023-05-11T12:41:48.459363  / # . /lava-10281706/environment/lava-10281=
706/bin/lava-test-runner /lava-10281706/1

    2023-05-11T12:41:48.459713  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce29e9ed8ca5e442e8631

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645ce29e9ed8ca5e442e8636
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T12:41:49.168596  + set<8>[   10.807018] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10281694_1.4.2.3.1>

    2023-05-11T12:41:49.168680   +x

    2023-05-11T12:41:49.270210  #

    2023-05-11T12:41:49.371016  / # #export SHELL=3D/bin/sh

    2023-05-11T12:41:49.371296  =


    2023-05-11T12:41:49.471862  / # export SHELL=3D/bin/sh. /lava-10281694/=
environment

    2023-05-11T12:41:49.472018  =


    2023-05-11T12:41:49.572564  / # . /lava-10281694/environment/lava-10281=
694/bin/lava-test-runner /lava-10281694/1

    2023-05-11T12:41:49.572843  =


    2023-05-11T12:41:49.578339  / # /lava-10281694/bin/lava-test-runner /la=
va-10281694/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce2a6193fbad8852e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645ce2a6193fbad8852e860b
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T12:41:55.903563  + set<8>[   11.288930] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10281714_1.4.2.3.1>

    2023-05-11T12:41:55.903649   +x

    2023-05-11T12:41:56.008450  / # #

    2023-05-11T12:41:56.109052  export SHELL=3D/bin/sh

    2023-05-11T12:41:56.109249  #

    2023-05-11T12:41:56.209765  / # export SHELL=3D/bin/sh. /lava-10281714/=
environment

    2023-05-11T12:41:56.209960  =


    2023-05-11T12:41:56.310476  / # . /lava-10281714/environment/lava-10281=
714/bin/lava-test-runner /lava-10281714/1

    2023-05-11T12:41:56.310766  =


    2023-05-11T12:41:56.316189  / # /lava-10281714/bin/lava-test-runner /la=
va-10281714/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce41181ab3079282e8609

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645ce41181ab3079282e860e
        failing since 104 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-11T12:48:11.649504  + set +x
    2023-05-11T12:48:11.649708  [    9.462730] <LAVA_SIGNAL_ENDRUN 0_dmesg =
947624_1.5.2.3.1>
    2023-05-11T12:48:11.756877  / # #
    2023-05-11T12:48:11.858445  export SHELL=3D/bin/sh
    2023-05-11T12:48:11.858840  #
    2023-05-11T12:48:11.960017  / # export SHELL=3D/bin/sh. /lava-947624/en=
vironment
    2023-05-11T12:48:11.960532  =

    2023-05-11T12:48:12.062009  / # . /lava-947624/environment/lava-947624/=
bin/lava-test-runner /lava-947624/1
    2023-05-11T12:48:12.062626  =

    2023-05-11T12:48:12.065387  / # /lava-947624/bin/lava-test-runner /lava=
-947624/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx8mn-ddr4-evk              | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce617dca8ebd0882e860e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/arm64/defconfig/gcc-10/lab-baylibre/baseline-imx8mn-ddr4=
-evk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/arm64/defconfig/gcc-10/lab-baylibre/baseline-imx8mn-ddr4=
-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645ce617dca8ebd0882e8=
60f
        new failure (last pass: v5.15.105-732-g51751fee1428) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce47d48ec84e9ce2e85fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645ce47d48ec84e9ce2e8=
5fb
        new failure (last pass: v5.15.105-732-g51751fee1428) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce2a8193fbad8852e862c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645ce2a8193fbad8852e8631
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T12:42:03.423327  + set<8>[   10.899936] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10281749_1.4.2.3.1>

    2023-05-11T12:42:03.423447   +x

    2023-05-11T12:42:03.527715  / # #

    2023-05-11T12:42:03.628515  export SHELL=3D/bin/sh

    2023-05-11T12:42:03.628762  #

    2023-05-11T12:42:03.729297  / # export SHELL=3D/bin/sh. /lava-10281749/=
environment

    2023-05-11T12:42:03.729510  =


    2023-05-11T12:42:03.830073  / # . /lava-10281749/environment/lava-10281=
749/bin/lava-test-runner /lava-10281749/1

    2023-05-11T12:42:03.830397  =


    2023-05-11T12:42:03.834915  / # /lava-10281749/bin/lava-test-runner /la=
va-10281749/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce7b0f51a96b2852e85fa

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645ce7b0f51a96b2852e8625
        failing since 113 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-11T13:03:22.715728  <8>[   16.029322] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3575444_1.5.2.4.1>
    2023-05-11T13:03:22.837964  / # #
    2023-05-11T13:03:22.944119  export SHELL=3D/bin/sh
    2023-05-11T13:03:22.945753  #
    2023-05-11T13:03:23.049513  / # export SHELL=3D/bin/sh. /lava-3575444/e=
nvironment
    2023-05-11T13:03:23.051251  =

    2023-05-11T13:03:23.155315  / # . /lava-3575444/environment/lava-357544=
4/bin/lava-test-runner /lava-3575444/1
    2023-05-11T13:03:23.161410  =

    2023-05-11T13:03:23.164744  / # /lava-3575444/bin/lava-test-runner /lav=
a-3575444/1
    2023-05-11T13:03:23.211428  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645ce29b9ed8ca5e442e85ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.110=
-371-g8e98e7e5a063/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645ce29b9ed8ca5e442e8604
        failing since 99 days (last pass: v5.15.82-123-gd03dbdba21ef, first=
 fail: v5.15.90-203-gea2e94bef77e)

    2023-05-11T12:41:39.826681  <8>[    5.786962] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3575401_1.5.2.4.1>
    2023-05-11T12:41:39.949392  / # #
    2023-05-11T12:41:40.057605  export SHELL=3D/bin/sh
    2023-05-11T12:41:40.059937  #
    2023-05-11T12:41:40.163930  / # export SHELL=3D/bin/sh. /lava-3575401/e=
nvironment
    2023-05-11T12:41:40.166322  =

    2023-05-11T12:41:40.269987  / # . /lava-3575401/environment/lava-357540=
1/bin/lava-test-runner /lava-3575401/1
    2023-05-11T12:41:40.273048  =

    2023-05-11T12:41:40.284164  / # /lava-3575401/bin/lava-test-runner /lav=
a-3575401/1
    2023-05-11T12:41:40.403961  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
