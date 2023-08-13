Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468477A447
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 02:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjHMAFO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 20:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHMAFO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 20:05:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ABE12E
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:05:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686b91c2744so2170554b3a.0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691885115; x=1692489915;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pmdESHHhhN69K82I0uEzkBEdEWK7JZ/yHphxW4nSAck=;
        b=FgnBCfjaNEumgUuD/UPyKn0wKxaxnD7F9r1DONqgEW79QmuwOE4VvEz+3ZwfnW3ATq
         cUz0CS9+ZWORTwL9jOZkZ5mnQ/7MWp6c+RvUrlwHA6Su0Q56l3eluxuPm7sYo/FzhHYo
         T7d7ZFeXVUfJIgSG4jGTIS3WQSpK6TAbB6dkcb/8XQzUgUWp9aYYjuxu2xPbOFI5S7Z9
         UPqJDXTQLaYGf5qP5tx3+3EgdbS6YAI6K7aTc2+XXHfP3IP7BXF1/9BSiK/UdEnZlMFx
         znvUwwd4ELJx4qhIB0FFPuZf3fWXZ7xEk5QZiL41bVM7QdLJ3SUWvQhn/ZnysFwFPjg7
         chdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691885115; x=1692489915;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmdESHHhhN69K82I0uEzkBEdEWK7JZ/yHphxW4nSAck=;
        b=A8lnoZSVXDIbnt7Clm3YPTKehEygq1dkkQedZBrXk5ZsbeisYoXT4Wqx/DjBLMmXAk
         B4mMyQ6TfbWtRf8IJE5Spnn/1XrkDqcmYtAyX8hWkPpI1fQbe9f61m/8ZlxuJDJ3V/CT
         Om8D/PhOnQrIFTNWtroR1wG1jmXfBf2PoJmDeC6Be6wK9Ag57kZ1K7vPoebav/B8FKx5
         GnxJQ7ej73kx0a72jozlh7/mO8NqZ8HT2f9aecvzpKxXraYnA2GTFE4cOp42OAmlHEpy
         vtVoFQd+ytqn+tNB4UomaxX8oC8KE+SxHgYujYsqzicGvk5D11xADIra5IKzCQstlfXC
         BN0Q==
X-Gm-Message-State: AOJu0YwciycnoSSdi7au10Ylxhoa+tD/KGjpIGO0TG0+798DehmlTA/Y
        2LRAL5IcT6rycBEL5EFsUrVu/3msW/A3rfk4InH7EA==
X-Google-Smtp-Source: AGHT+IEhLVxa66ewJNyBpOHNMjjQIEYbFNJGnFzXXk9MF0vMJVWxHr1HPYOcQerU3DPPQtIv0Sf4wg==
X-Received: by 2002:a17:90a:a6e:b0:262:ff1c:bc33 with SMTP id o101-20020a17090a0a6e00b00262ff1cbc33mr3811163pjo.13.1691885114821;
        Sat, 12 Aug 2023 17:05:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id cx3-20020a17090afd8300b00268238583acsm7265527pjb.32.2023.08.12.17.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 17:05:14 -0700 (PDT)
Message-ID: <64d81e3a.170a0220.d64b2.d15e@mx.google.com>
Date:   Sat, 12 Aug 2023 17:05:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.45-128-ge73191cf0a0b2
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 126 runs,
 10 regressions (v6.1.45-128-ge73191cf0a0b2)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 126 runs, 10 regressions (v6.1.45-128-ge731=
91cf0a0b2)

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
el/v6.1.45-128-ge73191cf0a0b2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.45-128-ge73191cf0a0b2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e73191cf0a0b2f27f3231b9893bf4a457e46f34d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7ebb255d4df0f4935b206

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7ebb255d4df0f4935b20b
        failing since 135 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-12T20:29:21.540168  + set +x

    2023-08-12T20:29:21.546842  <8>[   10.659374] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11273845_1.4.2.3.1>

    2023-08-12T20:29:21.654382  / # #

    2023-08-12T20:29:21.755266  export SHELL=3D/bin/sh

    2023-08-12T20:29:21.756060  #

    2023-08-12T20:29:21.857495  / # export SHELL=3D/bin/sh. /lava-11273845/=
environment

    2023-08-12T20:29:21.858202  =


    2023-08-12T20:29:21.959564  / # . /lava-11273845/environment/lava-11273=
845/bin/lava-test-runner /lava-11273845/1

    2023-08-12T20:29:21.959892  =


    2023-08-12T20:29:21.966415  / # /lava-11273845/bin/lava-test-runner /la=
va-11273845/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7ebb259d5af3c0135b201

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7ebb259d5af3c0135b206
        failing since 135 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-12T20:29:22.006639  + <8>[   11.328559] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11273858_1.4.2.3.1>

    2023-08-12T20:29:22.006910  set +x

    2023-08-12T20:29:22.113049  / # #

    2023-08-12T20:29:22.215386  export SHELL=3D/bin/sh

    2023-08-12T20:29:22.215649  #

    2023-08-12T20:29:22.316546  / # export SHELL=3D/bin/sh. /lava-11273858/=
environment

    2023-08-12T20:29:22.317352  =


    2023-08-12T20:29:22.419027  / # . /lava-11273858/environment/lava-11273=
858/bin/lava-test-runner /lava-11273858/1

    2023-08-12T20:29:22.420560  =


    2023-08-12T20:29:22.425365  / # /lava-11273858/bin/lava-test-runner /la=
va-11273858/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7ebb755d4df0f4935b235

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7ebb755d4df0f4935b23a
        failing since 135 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-12T20:29:24.920085  <8>[   10.281260] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11273874_1.4.2.3.1>

    2023-08-12T20:29:24.924605  + set +x

    2023-08-12T20:29:25.032105  #

    2023-08-12T20:29:25.033136  =


    2023-08-12T20:29:25.134695  / # #export SHELL=3D/bin/sh

    2023-08-12T20:29:25.134909  =


    2023-08-12T20:29:25.235404  / # export SHELL=3D/bin/sh. /lava-11273874/=
environment

    2023-08-12T20:29:25.235601  =


    2023-08-12T20:29:25.336110  / # . /lava-11273874/environment/lava-11273=
874/bin/lava-test-runner /lava-11273874/1

    2023-08-12T20:29:25.336416  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7ef0c41221ee03635b1de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d7ef0c41221ee03635b=
1df
        failing since 65 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7ecf6b9c7141e9735b1ff

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7ecf6b9c7141e9735b204
        failing since 135 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-12T20:34:57.178970  + set +x

    2023-08-12T20:34:57.186008  <8>[   10.565180] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11273865_1.4.2.3.1>

    2023-08-12T20:34:57.290384  / # #

    2023-08-12T20:34:57.391069  export SHELL=3D/bin/sh

    2023-08-12T20:34:57.391291  #

    2023-08-12T20:34:57.491835  / # export SHELL=3D/bin/sh. /lava-11273865/=
environment

    2023-08-12T20:34:57.492014  =


    2023-08-12T20:34:57.592533  / # . /lava-11273865/environment/lava-11273=
865/bin/lava-test-runner /lava-11273865/1

    2023-08-12T20:34:57.592849  =


    2023-08-12T20:34:57.597514  / # /lava-11273865/bin/lava-test-runner /la=
va-11273865/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7ebb155d4df0f4935b1fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7ebb155d4df0f4935b200
        failing since 135 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-12T20:29:23.128679  + set<8>[   11.086575] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11273873_1.4.2.3.1>

    2023-08-12T20:29:23.128802   +x

    2023-08-12T20:29:23.233335  / # #

    2023-08-12T20:29:23.333963  export SHELL=3D/bin/sh

    2023-08-12T20:29:23.334161  #

    2023-08-12T20:29:23.434671  / # export SHELL=3D/bin/sh. /lava-11273873/=
environment

    2023-08-12T20:29:23.434891  =


    2023-08-12T20:29:23.535447  / # . /lava-11273873/environment/lava-11273=
873/bin/lava-test-runner /lava-11273873/1

    2023-08-12T20:29:23.535792  =


    2023-08-12T20:29:23.540861  / # /lava-11273873/bin/lava-test-runner /la=
va-11273873/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7ebab55d4df0f4935b1f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7ebab55d4df0f4935b1f5
        failing since 135 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-12T20:29:15.252542  + <8>[    9.593139] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11273868_1.4.2.3.1>

    2023-08-12T20:29:15.253060  set +x

    2023-08-12T20:29:15.360234  / # #

    2023-08-12T20:29:15.461888  export SHELL=3D/bin/sh

    2023-08-12T20:29:15.462100  #

    2023-08-12T20:29:15.562641  / # export SHELL=3D/bin/sh. /lava-11273868/=
environment

    2023-08-12T20:29:15.562856  =


    2023-08-12T20:29:15.663433  / # . /lava-11273868/environment/lava-11273=
868/bin/lava-test-runner /lava-11273868/1

    2023-08-12T20:29:15.663762  =


    2023-08-12T20:29:15.668348  / # /lava-11273868/bin/lava-test-runner /la=
va-11273868/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7ed35bfa585a2fa35b212

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7ed35bfa585a2fa35b217
        failing since 25 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-12T20:37:22.254915  / # #

    2023-08-12T20:37:22.356697  export SHELL=3D/bin/sh

    2023-08-12T20:37:22.357380  #

    2023-08-12T20:37:22.458579  / # export SHELL=3D/bin/sh. /lava-11273915/=
environment

    2023-08-12T20:37:22.459304  =


    2023-08-12T20:37:22.560699  / # . /lava-11273915/environment/lava-11273=
915/bin/lava-test-runner /lava-11273915/1

    2023-08-12T20:37:22.561681  =


    2023-08-12T20:37:22.564464  / # /lava-11273915/bin/lava-test-runner /la=
va-11273915/1

    2023-08-12T20:37:22.626292  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-12T20:37:22.626767  + cd /lav<8>[   19.131157] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11273915_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7ed4cbfa585a2fa35b25c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7ed4cbfa585a2fa35b261
        failing since 25 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-12T20:36:56.747715  / # #

    2023-08-12T20:36:57.828041  export SHELL=3D/bin/sh

    2023-08-12T20:36:57.829942  #

    2023-08-12T20:36:59.320718  / # export SHELL=3D/bin/sh. /lava-11273923/=
environment

    2023-08-12T20:36:59.322492  =


    2023-08-12T20:37:02.044459  / # . /lava-11273923/environment/lava-11273=
923/bin/lava-test-runner /lava-11273923/1

    2023-08-12T20:37:02.046965  =


    2023-08-12T20:37:02.056596  / # /lava-11273923/bin/lava-test-runner /la=
va-11273923/1

    2023-08-12T20:37:02.108996  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-12T20:37:02.109500  + cd /lav<8>[   28.454155] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11273923_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d7ed38bfa585a2fa35b22c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
128-ge73191cf0a0b2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d7ed38bfa585a2fa35b231
        failing since 25 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-12T20:37:35.384679  / # #

    2023-08-12T20:37:35.486856  export SHELL=3D/bin/sh

    2023-08-12T20:37:35.487582  #

    2023-08-12T20:37:35.589031  / # export SHELL=3D/bin/sh. /lava-11273924/=
environment

    2023-08-12T20:37:35.589750  =


    2023-08-12T20:37:35.691199  / # . /lava-11273924/environment/lava-11273=
924/bin/lava-test-runner /lava-11273924/1

    2023-08-12T20:37:35.692211  =


    2023-08-12T20:37:35.708902  / # /lava-11273924/bin/lava-test-runner /la=
va-11273924/1

    2023-08-12T20:37:35.775776  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-12T20:37:35.776292  + cd /lava-11273924/1/tests/1_boot<8>[   17=
.010615] <LAVA_SIGNAL_STARTRUN 1_bootrr 11273924_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
