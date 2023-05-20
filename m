Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E077970A618
	for <lists+stable@lfdr.de>; Sat, 20 May 2023 09:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjETHNy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 20 May 2023 03:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjETHNx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 20 May 2023 03:13:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532121A8
        for <stable@vger.kernel.org>; Sat, 20 May 2023 00:13:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d341bdedcso1031041b3a.3
        for <stable@vger.kernel.org>; Sat, 20 May 2023 00:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684566830; x=1687158830;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5tOJHfOpQRtbetdBJOb8j+0uIqpr+CKQz+8TeX/+hL4=;
        b=mSO/8vGe7Spu10nEwH+NYnIAvNwb+0xM9MlUeevSjsp8wOhgGiQ8Rkp1h4emdnCzUr
         Hfn8SJcgoSV/9rs/kAhdxzWf4eXH5LoO3e/98IJNoCB/x47IZnlepjSUT/Hw/2sSwjL6
         A7lcDhoeTjCUBvN65oe7uUiOYn9Bpso8nCbFDMJ7f1ec0s6Hg5poXjx2DJwhhrjzZWFB
         vNS69KIo/+GYP1+To3F60to/oTuEOIP78NpuVDgB2MYa6nRxEpHkJnUsYjzRz7aFQd9w
         +6Dk7pkjl+9fsebAsYhoNYVqQ0vpiHtpvCFQ9wguVo0x1Cu/KKpHDOVzlX6HRMa0QOQN
         5Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684566830; x=1687158830;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tOJHfOpQRtbetdBJOb8j+0uIqpr+CKQz+8TeX/+hL4=;
        b=QZtxOr+1Ad4VWITGcNzpi2mf1qA/79zTAvdrUWa3wgg83IJVRiQRMDWXY1+zdewiw0
         XEh0bUBR7sYR2/dxSNIBDL9ZKlYIq9rhFXUopZARq3iMDWLVuH6R7Kw4JUPevqBRJ21g
         mKVffGrN8Oe0Y87MLH0VV9A7qdtaX787g+1mBg4RBrb6uCvYve4FcyiJ7RVbu2jy0uHf
         0LedSxXMma/TNDthB1b/QvB5ySDB3FrdrZtew9ZcsSOi0544gVLqf8tYUcXl9zhRuBQo
         YIwDEaBZN+/v1JNChgCNPj1YfnnUrTkGxtJoGVVmYtKfmy2sWPLuR61BMPCVlqFVKish
         vbWg==
X-Gm-Message-State: AC+VfDxD/BtTY2jn6uHr5StxnbMgR732z7HBgeqNSZGZpLoZKPxt0WzM
        GHPNJTvH/pOsvztqJczmfl3XDzrP2KPEIxLgOmquSQ==
X-Google-Smtp-Source: ACHHUZ6G5SpMyeNvmBHdud++7JGQU7ZORBFWUj+IPfdH3zcWQL2nLZnUXb+15IW+xhPL1Lsx3HYHNw==
X-Received: by 2002:a05:6a20:7d8c:b0:100:c125:5c93 with SMTP id v12-20020a056a207d8c00b00100c1255c93mr5116517pzj.21.1684566830147;
        Sat, 20 May 2023 00:13:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a24-20020a62e218000000b00642f1e03dc1sm690255pfi.174.2023.05.20.00.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 00:13:49 -0700 (PDT)
Message-ID: <6468732d.620a0220.fb8f3.1512@mx.google.com>
Date:   Sat, 20 May 2023 00:13:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-103-gb58e0a13d14f
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 157 runs,
 10 regressions (v5.15.112-103-gb58e0a13d14f)
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

stable-rc/queue/5.15 baseline: 157 runs, 10 regressions (v5.15.112-103-gb58=
e0a13d14f)

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

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-g12a-sei510            | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-103-gb58e0a13d14f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-103-gb58e0a13d14f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b58e0a13d14fe72d8fd39e550e922a2773cd66ba =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64683d2c12618671a42e8613

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64683d2c12618671a42e8=
614
        new failure (last pass: v5.15.112) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64683c2acbf8bb9e762e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64683c2acbf8bb9e762e8601
        failing since 52 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T03:18:44.376345  + set<8>[   11.082164] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10394716_1.4.2.3.1>

    2023-05-20T03:18:44.376430   +x

    2023-05-20T03:18:44.481446  / # #

    2023-05-20T03:18:44.582070  export SHELL=3D/bin/sh

    2023-05-20T03:18:44.582256  #

    2023-05-20T03:18:44.682728  / # export SHELL=3D/bin/sh. /lava-10394716/=
environment

    2023-05-20T03:18:44.682905  =


    2023-05-20T03:18:44.783471  / # . /lava-10394716/environment/lava-10394=
716/bin/lava-test-runner /lava-10394716/1

    2023-05-20T03:18:44.783928  =


    2023-05-20T03:18:44.789084  / # /lava-10394716/bin/lava-test-runner /la=
va-10394716/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64683c3aba48e565c12e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64683c3aba48e565c12e85eb
        failing since 52 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T03:18:58.436291  <8>[   11.504537] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10394710_1.4.2.3.1>

    2023-05-20T03:18:58.439541  + set +x

    2023-05-20T03:18:58.541566  #

    2023-05-20T03:18:58.542013  =


    2023-05-20T03:18:58.642802  / # #export SHELL=3D/bin/sh

    2023-05-20T03:18:58.643105  =


    2023-05-20T03:18:58.743746  / # export SHELL=3D/bin/sh. /lava-10394710/=
environment

    2023-05-20T03:18:58.744036  =


    2023-05-20T03:18:58.844706  / # . /lava-10394710/environment/lava-10394=
710/bin/lava-test-runner /lava-10394710/1

    2023-05-20T03:18:58.845138  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64683c17ff68c5d0ed2e85f8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64683c17ff68c5d0ed2e85fd
        failing since 52 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T03:18:34.743173  + <8>[   10.215816] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10394690_1.4.2.3.1>

    2023-05-20T03:18:34.743259  set +x

    2023-05-20T03:18:34.844664  #

    2023-05-20T03:18:34.945535  / # #export SHELL=3D/bin/sh

    2023-05-20T03:18:34.945750  =


    2023-05-20T03:18:35.046279  / # export SHELL=3D/bin/sh. /lava-10394690/=
environment

    2023-05-20T03:18:35.046488  =


    2023-05-20T03:18:35.147048  / # . /lava-10394690/environment/lava-10394=
690/bin/lava-test-runner /lava-10394690/1

    2023-05-20T03:18:35.147376  =


    2023-05-20T03:18:35.151731  / # /lava-10394690/bin/lava-test-runner /la=
va-10394690/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64683c1aff68c5d0ed2e8603

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64683c1aff68c5d0ed2e8608
        failing since 52 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T03:18:30.614169  <8>[   10.635354] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10394742_1.4.2.3.1>

    2023-05-20T03:18:30.617342  + set +x

    2023-05-20T03:18:30.724911  / # #

    2023-05-20T03:18:30.827057  export SHELL=3D/bin/sh

    2023-05-20T03:18:30.827744  #

    2023-05-20T03:18:30.929202  / # export SHELL=3D/bin/sh. /lava-10394742/=
environment

    2023-05-20T03:18:30.930037  =


    2023-05-20T03:18:31.031606  / # . /lava-10394742/environment/lava-10394=
742/bin/lava-test-runner /lava-10394742/1

    2023-05-20T03:18:31.032827  =


    2023-05-20T03:18:31.037785  / # /lava-10394742/bin/lava-test-runner /la=
va-10394742/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64683c32cbf8bb9e762e8632

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64683c32cbf8bb9e762e8637
        failing since 52 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T03:18:51.733660  + set<8>[   10.855751] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10394681_1.4.2.3.1>

    2023-05-20T03:18:51.733741   +x

    2023-05-20T03:18:51.838064  / # #

    2023-05-20T03:18:51.938600  export SHELL=3D/bin/sh

    2023-05-20T03:18:51.938734  #

    2023-05-20T03:18:52.039242  / # export SHELL=3D/bin/sh. /lava-10394681/=
environment

    2023-05-20T03:18:52.039370  =


    2023-05-20T03:18:52.139864  / # . /lava-10394681/environment/lava-10394=
681/bin/lava-test-runner /lava-10394681/1

    2023-05-20T03:18:52.140144  =


    2023-05-20T03:18:52.144474  / # /lava-10394681/bin/lava-test-runner /la=
va-10394681/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/64683e84380b3e7bac2e867e

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64683e84380b3e7bac2e8681
        new failure (last pass: v5.15.112)

    2023-05-20T03:28:52.433484  / # #
    2023-05-20T03:28:52.535594  export SHELL=3D/bin/sh
    2023-05-20T03:28:52.536366  #
    2023-05-20T03:28:52.638347  / # export SHELL=3D/bin/sh. /lava-341178/en=
vironment
    2023-05-20T03:28:52.639117  =

    2023-05-20T03:28:52.740926  / # . /lava-341178/environment/lava-341178/=
bin/lava-test-runner /lava-341178/1
    2023-05-20T03:28:52.742223  =

    2023-05-20T03:28:52.760507  / # /lava-341178/bin/lava-test-runner /lava=
-341178/1
    2023-05-20T03:28:52.807373  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-20T03:28:52.807873  + cd /l<8>[   12.193438] <LAVA_SIGNAL_START=
RUN 1_bootrr 341178_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/646=
83e84380b3e7bac2e8691
        new failure (last pass: v5.15.112)

    2023-05-20T03:28:55.125425  /lava-341178/1/../bin/lava-test-case
    2023-05-20T03:28:55.125918  <8>[   14.605441] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-05-20T03:28:55.126253  /lava-341178/1/../bin/lava-test-case
    2023-05-20T03:28:55.126511  <8>[   14.624899] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dimx8mq-usb-phy-driver-present RESULT=3Dpass>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64683c3f0d4518e4b72e85ec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64683c3f0d4518e4b72e85f1
        failing since 52 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-20T03:19:10.252386  + set<8>[   11.469225] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10394731_1.4.2.3.1>

    2023-05-20T03:19:10.252470   +x

    2023-05-20T03:19:10.356496  / # #

    2023-05-20T03:19:10.457063  export SHELL=3D/bin/sh

    2023-05-20T03:19:10.457259  #

    2023-05-20T03:19:10.557744  / # export SHELL=3D/bin/sh. /lava-10394731/=
environment

    2023-05-20T03:19:10.557920  =


    2023-05-20T03:19:10.658448  / # . /lava-10394731/environment/lava-10394=
731/bin/lava-test-runner /lava-10394731/1

    2023-05-20T03:19:10.658712  =


    2023-05-20T03:19:10.663284  / # /lava-10394731/bin/lava-test-runner /la=
va-10394731/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12a-sei510            | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64683e9a2cbab794272e8673

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12a-=
sei510.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-103-gb58e0a13d14f/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12a-=
sei510.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64683e9a2cbab794272e8678
        new failure (last pass: v5.15.112)

    2023-05-20T03:29:21.391563  / # #
    2023-05-20T03:29:21.493366  export SHELL=3D/bin/sh
    2023-05-20T03:29:21.493784  #
    2023-05-20T03:29:21.595189  / # export SHELL=3D/bin/sh. /lava-3602659/e=
nvironment
    2023-05-20T03:29:21.595931  =

    2023-05-20T03:29:21.697847  / # . /lava-3602659/environment/lava-360265=
9/bin/lava-test-runner /lava-3602659/1
    2023-05-20T03:29:21.699173  =

    2023-05-20T03:29:21.704343  / # /lava-3602659/bin/lava-test-runner /lav=
a-3602659/1
    2023-05-20T03:29:21.773082  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-20T03:29:21.773423  + cd /lava-3602659/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =20
