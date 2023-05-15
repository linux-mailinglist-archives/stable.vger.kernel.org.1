Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BED7025A9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 09:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjEOHGB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 03:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjEOHGA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 03:06:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31A7E4F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 00:05:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643a1fed360so7457419b3a.3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 00:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684134358; x=1686726358;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ykhKhWBip5M+Cfuo9bkakNyoPseZlxUom1ccYMhqbo8=;
        b=4b+MqWov3MtAv3jlqQj6gXPSy0O73dJ3NCBtb0pY74/IjZXQdHlE6g8Cfk5XsVx3sO
         jrzQtRSu7wtbXkEMM70gTQJDgtmXUz142rpm5w1n0XHe2A3S9B/Sxu7jzFsYePw3TRoA
         Mamf16jRRm4BF8gcJFh4nyay5o1oPs4Ra9h7RtX+gl4ycmc6nVwj25U7fNDwO7mQxv8+
         UVT/2BPeTAF+b+LqgNV1ZgfKBzu7ipekUN2KlLwiIb75c5jr8LoNKZSRVRWQ92UYXcvr
         mAy7jlZz/71AR/DHv7XRD7ZCWaCs0aRY+z4w+4FqbZLXlvOD5Z5MCdPq4iwX1pGit02W
         Eaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684134358; x=1686726358;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykhKhWBip5M+Cfuo9bkakNyoPseZlxUom1ccYMhqbo8=;
        b=DvKsGzSjIiJUwnkYgp4sOilPVbKVHse2LRPTEgDne7/bBKyO/D3jsHx7xP1apBRzy/
         sQvt10fIOgLpTlsWxGwobJj9a20kcr1u10W2Y++/A9dCnsWsh4Gi8YbmB8wVgwH1Xvf1
         LpcxP7M9me8uFuWEBISsjeghSHs7fVvn9LgclKrFYVYmzW6KEYq8ZEuj6fw6kZ8m6XiZ
         5gcvY0NvJVxJTpspCA1MXuwqMPYTDrgcOqzxvzXvIEBKwFWTPIYKAonka/MWj0SZiAvO
         ByGaMcBnpei8DjIAdiCqCTCpv1ec8SLe0fMpQ8OpvipA3MDz/SevkZoykbJFZ4RhF5qI
         RVPQ==
X-Gm-Message-State: AC+VfDzegahbBSZRH6xvxcPktgq94PtZdav7jBTG58VzrpfSEW9b7i++
        iVjK1wB8CDLYzKNncjcUePz8uIWNo324i1XF0TQCOw==
X-Google-Smtp-Source: ACHHUZ6iff5u2+72/fnVahBxz69aSFHrAg50BiFuNRFbmodNsBP/eqjoLOOkNPprMA9Bt7hIGPGXVQ==
X-Received: by 2002:a05:6a20:4321:b0:105:b75e:9df6 with SMTP id h33-20020a056a20432100b00105b75e9df6mr4597750pzk.26.1684134357816;
        Mon, 15 May 2023 00:05:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0062607d604b2sm11122205pfo.53.2023.05.15.00.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:05:57 -0700 (PDT)
Message-ID: <6461d9d5.a70a0220.c5fd3.6002@mx.google.com>
Date:   Mon, 15 May 2023 00:05:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-219-g40b513d80514
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 161 runs,
 8 regressions (v6.1.28-219-g40b513d80514)
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

stable-rc/queue/6.1 baseline: 161 runs, 8 regressions (v6.1.28-219-g40b513d=
80514)

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

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-219-g40b513d80514/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-219-g40b513d80514
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      40b513d80514d91e140dab4df364b0ab1b45918f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461a51a2b038d59712e8605

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461a51a2b038d59712e860a
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T03:20:43.088608  <8>[   10.193901] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10315918_1.4.2.3.1>

    2023-05-15T03:20:43.091485  + set +x

    2023-05-15T03:20:43.196359  / # #

    2023-05-15T03:20:43.296938  export SHELL=3D/bin/sh

    2023-05-15T03:20:43.297103  #

    2023-05-15T03:20:43.397565  / # export SHELL=3D/bin/sh. /lava-10315918/=
environment

    2023-05-15T03:20:43.397741  =


    2023-05-15T03:20:43.498237  / # . /lava-10315918/environment/lava-10315=
918/bin/lava-test-runner /lava-10315918/1

    2023-05-15T03:20:43.498485  =


    2023-05-15T03:20:43.504117  / # /lava-10315918/bin/lava-test-runner /la=
va-10315918/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461a515c0c36b11822e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461a515c0c36b11822e8630
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T03:20:34.886272  + set<8>[   11.162036] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10315933_1.4.2.3.1>

    2023-05-15T03:20:34.886860   +x

    2023-05-15T03:20:34.994812  / # #

    2023-05-15T03:20:35.097513  export SHELL=3D/bin/sh

    2023-05-15T03:20:35.098329  #

    2023-05-15T03:20:35.199976  / # export SHELL=3D/bin/sh. /lava-10315933/=
environment

    2023-05-15T03:20:35.200769  =


    2023-05-15T03:20:35.302447  / # . /lava-10315933/environment/lava-10315=
933/bin/lava-test-runner /lava-10315933/1

    2023-05-15T03:20:35.303836  =


    2023-05-15T03:20:35.309020  / # /lava-10315933/bin/lava-test-runner /la=
va-10315933/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461a5192b038d59712e85f8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461a5192b038d59712e85fd
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T03:20:37.531060  <8>[   10.455217] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10315958_1.4.2.3.1>

    2023-05-15T03:20:37.534600  + set +x

    2023-05-15T03:20:37.635807  /#

    2023-05-15T03:20:37.736544   # #export SHELL=3D/bin/sh

    2023-05-15T03:20:37.736689  =


    2023-05-15T03:20:37.837240  / # export SHELL=3D/bin/sh. /lava-10315958/=
environment

    2023-05-15T03:20:37.837416  =


    2023-05-15T03:20:37.937970  / # . /lava-10315958/environment/lava-10315=
958/bin/lava-test-runner /lava-10315958/1

    2023-05-15T03:20:37.938212  =


    2023-05-15T03:20:37.943186  / # /lava-10315958/bin/lava-test-runner /la=
va-10315958/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6461a523789616ed2f2e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6461a523789616ed2f2e8=
5e9
        failing since 24 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461a506e943f7b1652e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461a506e943f7b1652e8603
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T03:20:30.192520  + set +x

    2023-05-15T03:20:30.199450  <8>[   10.849342] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10315879_1.4.2.3.1>

    2023-05-15T03:20:30.303864  / # #

    2023-05-15T03:20:30.404587  export SHELL=3D/bin/sh

    2023-05-15T03:20:30.404846  #

    2023-05-15T03:20:30.505416  / # export SHELL=3D/bin/sh. /lava-10315879/=
environment

    2023-05-15T03:20:30.505641  =


    2023-05-15T03:20:30.606175  / # . /lava-10315879/environment/lava-10315=
879/bin/lava-test-runner /lava-10315879/1

    2023-05-15T03:20:30.606486  =


    2023-05-15T03:20:30.611540  / # /lava-10315879/bin/lava-test-runner /la=
va-10315879/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461a507559cdf9c112e861d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461a507559cdf9c112e8622
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T03:20:25.302499  <8>[   10.040361] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10315937_1.4.2.3.1>

    2023-05-15T03:20:25.305781  + set +x

    2023-05-15T03:20:25.407230  #

    2023-05-15T03:20:25.508050  / # #export SHELL=3D/bin/sh

    2023-05-15T03:20:25.508261  =


    2023-05-15T03:20:25.608799  / # export SHELL=3D/bin/sh. /lava-10315937/=
environment

    2023-05-15T03:20:25.609005  =


    2023-05-15T03:20:25.709552  / # . /lava-10315937/environment/lava-10315=
937/bin/lava-test-runner /lava-10315937/1

    2023-05-15T03:20:25.709893  =


    2023-05-15T03:20:25.715741  / # /lava-10315937/bin/lava-test-runner /la=
va-10315937/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461a51b3a774184292e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461a51b3a774184292e85ed
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T03:20:38.858329  + <8>[   11.662661] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10315952_1.4.2.3.1>

    2023-05-15T03:20:38.858459  set +x

    2023-05-15T03:20:38.962553  / # #

    2023-05-15T03:20:39.063169  export SHELL=3D/bin/sh

    2023-05-15T03:20:39.063376  #

    2023-05-15T03:20:39.163950  / # export SHELL=3D/bin/sh. /lava-10315952/=
environment

    2023-05-15T03:20:39.164160  =


    2023-05-15T03:20:39.264715  / # . /lava-10315952/environment/lava-10315=
952/bin/lava-test-runner /lava-10315952/1

    2023-05-15T03:20:39.265041  =


    2023-05-15T03:20:39.269679  / # /lava-10315952/bin/lava-test-runner /la=
va-10315952/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461a5079157dfb6c42e8615

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-21=
9-g40b513d80514/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461a5079157dfb6c42e861a
        failing since 47 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-15T03:20:26.603778  + set +x<8>[   12.437012] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10315957_1.4.2.3.1>

    2023-05-15T03:20:26.603863  =


    2023-05-15T03:20:26.708216  / # #

    2023-05-15T03:20:26.808760  export SHELL=3D/bin/sh

    2023-05-15T03:20:26.808923  #

    2023-05-15T03:20:26.909395  / # export SHELL=3D/bin/sh. /lava-10315957/=
environment

    2023-05-15T03:20:26.909568  =


    2023-05-15T03:20:27.010140  / # . /lava-10315957/environment/lava-10315=
957/bin/lava-test-runner /lava-10315957/1

    2023-05-15T03:20:27.010456  =


    2023-05-15T03:20:27.014839  / # /lava-10315957/bin/lava-test-runner /la=
va-10315957/1
 =

    ... (12 line(s) more)  =

 =20
