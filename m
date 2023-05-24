Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8366970EA56
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 02:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbjEXAh1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 20:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbjEXAh1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 20:37:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A073B5
        for <stable@vger.kernel.org>; Tue, 23 May 2023 17:37:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae4d1d35e6so2480985ad.0
        for <stable@vger.kernel.org>; Tue, 23 May 2023 17:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684888644; x=1687480644;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uUQHps+anBoIVW+/OS/fO9NV8vctfEnAa0/sTDzy/Is=;
        b=bWM3uO0Cl3IaffN3YxPqFs8BNVQwiTAZ6e9rhYK3oh5ECsRtOB19ip9mG00cbIB8yI
         tckxcQt+gJbtPWmrXJt6sB2I8NLJAxncLmnybAWj5ngBWvWptde/nKkzvrfb1BVAGKrA
         ollGuHKYTbYqq79QDoPzHw7qJkcaktwR7LhqAPyaak8P2m7Da5Ck0VHi8JLHnq6hfiNo
         qI5yuj8w99Ij+Nk/j7qlxhzUhHRas9itG/FA4l+l3KX+QYFDx1d7aCgnz7BEOYk0ntaw
         zgPOumvoo1h+rBhdbETTDx+Hrdcg2ahYk5LGlXuAA/Qc0kgt2ZUa1HTfDsUQp8mrn5Pk
         Do+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684888644; x=1687480644;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUQHps+anBoIVW+/OS/fO9NV8vctfEnAa0/sTDzy/Is=;
        b=EnkfXQwAlZBaIL2pQh+KZkTG/hotDmqY9Qkrr5GbNLdgmsl6RDdgIoNlRxyewT+y3z
         d6nop/oCCnP4u25JwwuvTvrm6d97gbl7aaFCAusdmdOzwMzjVc7BhrZUqXOwF/Lbaerq
         IZmrv/FFHvk02ncf7U5xBLegtaMg4HPg4UTV6P5EADKEn+ZLslEWLTXcTnxv51elTMAp
         vgyjTsAHmLgbJ/9opWCIaY5GaVSnr2v6iqODsUudWgr/RBZmC/ZoI23JwbwolwrSbY0F
         jCwEIVvLoGj5anucKSbMgaTF7zbCAzZOFcdznolVXu9VrH7/eSnyUzmFz7Ovp44p1FQE
         IJ0w==
X-Gm-Message-State: AC+VfDw2Dr701sPEtAO1H5BT4zY88/x4ovr/J4y4J5oR9qh3ySKcqW58
        DppgEr3v2JRrlfJ2/onHCk3vbMNxbWZiB/XNUUQ/yQ==
X-Google-Smtp-Source: ACHHUZ49JTx4+CMYXWTT5zhu9sHyJsXsEA9w0iMW69ecngwu3hhOdoT7RRv9Za+JOKGd4otmUZ6Guw==
X-Received: by 2002:a17:902:c94a:b0:1a5:22a:165c with SMTP id i10-20020a170902c94a00b001a5022a165cmr19987790pla.0.1684888643930;
        Tue, 23 May 2023 17:37:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s19-20020a170903201300b001add2ba4459sm7345410pla.32.2023.05.23.17.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:37:23 -0700 (PDT)
Message-ID: <646d5c43.170a0220.eb977.d743@mx.google.com>
Date:   Tue, 23 May 2023 17:37:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-292-gdc336616135a
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 145 runs,
 7 regressions (v6.1.29-292-gdc336616135a)
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

stable-rc/queue/6.1 baseline: 145 runs, 7 regressions (v6.1.29-292-gdc33661=
6135a)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-292-gdc336616135a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-292-gdc336616135a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      dc336616135a6aa683b2468e3dcf8556dd1fb085 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d2804b69dac8aa42e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d2804b69dac8aa42e85ee
        failing since 56 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-23T20:54:16.867788  + set +x

    2023-05-23T20:54:16.873753  <8>[   10.199259] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10430689_1.4.2.3.1>

    2023-05-23T20:54:16.975742  =


    2023-05-23T20:54:17.076296  / # #export SHELL=3D/bin/sh

    2023-05-23T20:54:17.076527  =


    2023-05-23T20:54:17.177059  / # export SHELL=3D/bin/sh. /lava-10430689/=
environment

    2023-05-23T20:54:17.177264  =


    2023-05-23T20:54:17.277750  / # . /lava-10430689/environment/lava-10430=
689/bin/lava-test-runner /lava-10430689/1

    2023-05-23T20:54:17.278120  =


    2023-05-23T20:54:17.283431  / # /lava-10430689/bin/lava-test-runner /la=
va-10430689/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d2b59b7707564c62e8645

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d2b59b7707564c62e864a
        failing since 56 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-23T21:08:26.754176  + set<8>[   11.585947] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10430688_1.4.2.3.1>

    2023-05-23T21:08:26.754291   +x

    2023-05-23T21:08:26.858960  / # #

    2023-05-23T21:08:26.959713  export SHELL=3D/bin/sh

    2023-05-23T21:08:26.959946  #

    2023-05-23T21:08:27.060483  / # export SHELL=3D/bin/sh. /lava-10430688/=
environment

    2023-05-23T21:08:27.060705  =


    2023-05-23T21:08:27.161259  / # . /lava-10430688/environment/lava-10430=
688/bin/lava-test-runner /lava-10430688/1

    2023-05-23T21:08:27.161570  =


    2023-05-23T21:08:27.165873  / # /lava-10430688/bin/lava-test-runner /la=
va-10430688/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d28f129df53a1932e86a2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d28f129df53a1932e86a7
        failing since 56 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-23T20:57:57.799159  <8>[   11.245657] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10430697_1.4.2.3.1>

    2023-05-23T20:57:57.802199  + set +x

    2023-05-23T20:57:57.909549  / # #

    2023-05-23T20:57:58.010371  export SHELL=3D/bin/sh

    2023-05-23T20:57:58.011081  #

    2023-05-23T20:57:58.112632  / # export SHELL=3D/bin/sh. /lava-10430697/=
environment

    2023-05-23T20:57:58.113480  =


    2023-05-23T20:57:58.215119  / # . /lava-10430697/environment/lava-10430=
697/bin/lava-test-runner /lava-10430697/1

    2023-05-23T20:57:58.216172  =


    2023-05-23T20:57:58.220925  / # /lava-10430697/bin/lava-test-runner /la=
va-10430697/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d2d7d97256f71672e85f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d2d7d97256f71672e85fe
        failing since 56 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-23T21:17:34.970671  + set +x

    2023-05-23T21:17:34.977675  <8>[   11.456908] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10430693_1.4.2.3.1>

    2023-05-23T21:17:35.081899  / # #

    2023-05-23T21:17:35.182510  export SHELL=3D/bin/sh

    2023-05-23T21:17:35.182713  #

    2023-05-23T21:17:35.283279  / # export SHELL=3D/bin/sh. /lava-10430693/=
environment

    2023-05-23T21:17:35.283492  =


    2023-05-23T21:17:35.384061  / # . /lava-10430693/environment/lava-10430=
693/bin/lava-test-runner /lava-10430693/1

    2023-05-23T21:17:35.384360  =


    2023-05-23T21:17:35.389542  / # /lava-10430693/bin/lava-test-runner /la=
va-10430693/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d2da510a37a1a2e2e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d2da510a37a1a2e2e85f6
        failing since 56 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-23T21:18:09.275296  + set +x

    2023-05-23T21:18:09.282030  <8>[   10.589928] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10430750_1.4.2.3.1>

    2023-05-23T21:18:09.388556  / # #

    2023-05-23T21:18:09.490745  export SHELL=3D/bin/sh

    2023-05-23T21:18:09.491467  #

    2023-05-23T21:18:09.592794  / # export SHELL=3D/bin/sh. /lava-10430750/=
environment

    2023-05-23T21:18:09.593325  =


    2023-05-23T21:18:09.694581  / # . /lava-10430750/environment/lava-10430=
750/bin/lava-test-runner /lava-10430750/1

    2023-05-23T21:18:09.695677  =


    2023-05-23T21:18:09.700989  / # /lava-10430750/bin/lava-test-runner /la=
va-10430750/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d28025b790fab442e8736

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d28025b790fab442e873b
        failing since 56 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-23T20:54:05.340846  + set<8>[    8.625422] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10430706_1.4.2.3.1>

    2023-05-23T20:54:05.340936   +x

    2023-05-23T20:54:05.445213  / # #

    2023-05-23T20:54:05.545827  export SHELL=3D/bin/sh

    2023-05-23T20:54:05.546029  #

    2023-05-23T20:54:05.646578  / # export SHELL=3D/bin/sh. /lava-10430706/=
environment

    2023-05-23T20:54:05.646804  =


    2023-05-23T20:54:05.747359  / # . /lava-10430706/environment/lava-10430=
706/bin/lava-test-runner /lava-10430706/1

    2023-05-23T20:54:05.747696  =


    2023-05-23T20:54:05.752308  / # /lava-10430706/bin/lava-test-runner /la=
va-10430706/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d2856bf83f0d56a2e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-29=
2-gdc336616135a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d2856bf83f0d56a2e85fb
        failing since 56 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-23T20:55:32.983440  + set +x<8>[   11.840815] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10430690_1.4.2.3.1>

    2023-05-23T20:55:32.983537  =


    2023-05-23T20:55:33.088219  / # #

    2023-05-23T20:55:33.188905  export SHELL=3D/bin/sh

    2023-05-23T20:55:33.189129  #

    2023-05-23T20:55:33.289649  / # export SHELL=3D/bin/sh. /lava-10430690/=
environment

    2023-05-23T20:55:33.289876  =


    2023-05-23T20:55:33.390426  / # . /lava-10430690/environment/lava-10430=
690/bin/lava-test-runner /lava-10430690/1

    2023-05-23T20:55:33.390740  =


    2023-05-23T20:55:33.395262  / # /lava-10430690/bin/lava-test-runner /la=
va-10430690/1
 =

    ... (12 line(s) more)  =

 =20
