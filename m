Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD62773913D
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 23:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFUVCh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 17:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFUVCh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 17:02:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B7B10F2
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 14:02:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b52132181aso34051435ad.2
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 14:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687381353; x=1689973353;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E5TbzR1XLPvPhaQHbtO9Q6teJ8F6Ps/c89hzAFBhdeo=;
        b=qD3Dd5OFcYIR88AO+Jfw7ZGEnREzTHwFrZp8O0B0qALOGWobCEdBg5rT8uffbh1dJ9
         zw7HEgvW9SuTTt05p2XpeY+/imCusZQecGBJOoOkILqIxinLdj8YHkV59nI+OP4JKBvC
         JvJgT/cz6zmpbfEYF8ZxoenmEIzAKoOMEgcheXqw476aCjQthJd7/tT2ESG7U4UuM6RY
         n3029bRzLgf9fQYi8aHjE6xLQnknzsAnwVUPvml+BioSufNgR9tm8sB3eptukJck0hKI
         rkJRNFrurSltfP+6+7gIm9b75jn89XyxHkLcqCd8YEKjMGFkI8LbMgmjY5890gAhPP5G
         /khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687381353; x=1689973353;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5TbzR1XLPvPhaQHbtO9Q6teJ8F6Ps/c89hzAFBhdeo=;
        b=QMZHGU+UaSTDHW88RRcFmh6rQmctoC45pvEJNeRz3+PXOPQRHbnn1ncx2Lwgbwoatn
         D5/vPfWmtUAYIUJSzNYIoIXBCpMWmQPZueW3CR12o4TSpMHxq8tmtAL3b41VWTOIBqdK
         5OdIB3jTSeTBol/kyo3Yk9r51dWQf/tU8wSCdXh1XK6OHRy+84dvrg3JYFE7dY1FtDEl
         LuifBRDEAsy7SgzwlhiFMQ+46kRCOYK0pEYXF4dkmSYmpL6iNVGAdjfs6Rl2NOA2PD+R
         5G6skiELUASwPUODCEOQ7fHUxNCa4OTf8EuLjOh6+Y8aMoY3t1ZHD2emrE5YvNuScbYg
         SVhA==
X-Gm-Message-State: AC+VfDzFHuTn2UDNi6YowSGJRJ5rx7h+cvC6zPw7r5GDnpk12MIdencL
        r8yJJ/zTTrUwBK0ZoOWcXmta1Z46IRQ4l4NSJ/sprw==
X-Google-Smtp-Source: ACHHUZ4VdR1U15awZIBlylW+KthyKDFEmYz1cX4xKlToNjsFah1lCR6XQgptIAfz9UYZIVux9UPE1Q==
X-Received: by 2002:a17:902:c944:b0:1b6:9a29:4777 with SMTP id i4-20020a170902c94400b001b69a294777mr2461085pla.51.1687381352411;
        Wed, 21 Jun 2023 14:02:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709027b8e00b001b3d4bb352dsm3909473pll.175.2023.06.21.14.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:02:31 -0700 (PDT)
Message-ID: <64936567.170a0220.d2e09.97c8@mx.google.com>
Date:   Wed, 21 Jun 2023 14:02:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.118
Subject: stable/linux-5.15.y baseline: 173 runs, 17 regressions (v5.15.118)
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

stable/linux-5.15.y baseline: 173 runs, 17 regressions (v5.15.118)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.118/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.118
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      f67653019430833d5003f16817d7fa85272a6a76 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64932c4f7f3abd7ecb306150

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932c4f7f3abd7ecb306159
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T16:58:34.322977  <8>[   10.753272] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10847470_1.4.2.3.1>

    2023-06-21T16:58:34.326808  + set +x

    2023-06-21T16:58:34.433718  =


    2023-06-21T16:58:34.535897  / # #export SHELL=3D/bin/sh

    2023-06-21T16:58:34.536815  =


    2023-06-21T16:58:34.638425  / # export SHELL=3D/bin/sh. /lava-10847470/=
environment

    2023-06-21T16:58:34.639227  =


    2023-06-21T16:58:34.740816  / # . /lava-10847470/environment/lava-10847=
470/bin/lava-test-runner /lava-10847470/1

    2023-06-21T16:58:34.742158  =


    2023-06-21T16:58:34.747029  / # /lava-10847470/bin/lava-test-runner /la=
va-10847470/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6493334108a1c1a361306172

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493334108a1c1a36130617b
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T17:28:22.765646  + set +x

    2023-06-21T17:28:22.772747  <8>[   11.704612] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10847957_1.4.2.3.1>

    2023-06-21T17:28:22.881218  / # #

    2023-06-21T17:28:22.983679  export SHELL=3D/bin/sh

    2023-06-21T17:28:22.984498  #

    2023-06-21T17:28:23.086040  / # export SHELL=3D/bin/sh. /lava-10847957/=
environment

    2023-06-21T17:28:23.086850  =


    2023-06-21T17:28:23.188486  / # . /lava-10847957/environment/lava-10847=
957/bin/lava-test-runner /lava-10847957/1

    2023-06-21T17:28:23.189893  =


    2023-06-21T17:28:23.195823  / # /lava-10847957/bin/lava-test-runner /la=
va-10847957/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64932bdfdc8ee343f530618c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932bdfdc8ee343f5306195
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T16:56:46.996327  + set<8>[   11.777571] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10847464_1.4.2.3.1>

    2023-06-21T16:56:46.996759   +x

    2023-06-21T16:56:47.106241  / # #

    2023-06-21T16:56:47.208280  export SHELL=3D/bin/sh

    2023-06-21T16:56:47.208941  #

    2023-06-21T16:56:47.310324  / # export SHELL=3D/bin/sh. /lava-10847464/=
environment

    2023-06-21T16:56:47.310978  =


    2023-06-21T16:56:47.412513  / # . /lava-10847464/environment/lava-10847=
464/bin/lava-test-runner /lava-10847464/1

    2023-06-21T16:56:47.413698  =


    2023-06-21T16:56:47.418423  / # /lava-10847464/bin/lava-test-runner /la=
va-10847464/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6493332c7bba0d8d21306176

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493332c7bba0d8d2130617f
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T17:28:06.621480  + <8>[   12.020649] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10847960_1.4.2.3.1>

    2023-06-21T17:28:06.621567  set +x

    2023-06-21T17:28:06.725602  / # #

    2023-06-21T17:28:06.826230  export SHELL=3D/bin/sh

    2023-06-21T17:28:06.826425  #

    2023-06-21T17:28:06.926927  / # export SHELL=3D/bin/sh. /lava-10847960/=
environment

    2023-06-21T17:28:06.927116  =


    2023-06-21T17:28:07.027595  / # . /lava-10847960/environment/lava-10847=
960/bin/lava-test-runner /lava-10847960/1

    2023-06-21T17:28:07.027865  =


    2023-06-21T17:28:07.032959  / # /lava-10847960/bin/lava-test-runner /la=
va-10847960/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64932bd3401fc62bd1306156

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932bd3401fc62bd130615f
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T16:56:30.497647  <8>[   11.272022] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10847459_1.4.2.3.1>

    2023-06-21T16:56:30.500793  + set +x

    2023-06-21T16:56:30.603458  =


    2023-06-21T16:56:30.705561  / # #export SHELL=3D/bin/sh

    2023-06-21T16:56:30.706308  =


    2023-06-21T16:56:30.807793  / # export SHELL=3D/bin/sh. /lava-10847459/=
environment

    2023-06-21T16:56:30.808549  =


    2023-06-21T16:56:30.910191  / # . /lava-10847459/environment/lava-10847=
459/bin/lava-test-runner /lava-10847459/1

    2023-06-21T16:56:30.911543  =


    2023-06-21T16:56:30.916859  / # /lava-10847459/bin/lava-test-runner /la=
va-10847459/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64933486f718d2e8c530615b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64933486f718d2e8c5306164
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T17:33:43.001072  + set +x

    2023-06-21T17:33:43.007689  <8>[   12.028141] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10847974_1.4.2.3.1>

    2023-06-21T17:33:43.115197  / # #

    2023-06-21T17:33:43.217404  export SHELL=3D/bin/sh

    2023-06-21T17:33:43.217635  #

    2023-06-21T17:33:43.318371  / # export SHELL=3D/bin/sh. /lava-10847974/=
environment

    2023-06-21T17:33:43.319089  =


    2023-06-21T17:33:43.420463  / # . /lava-10847974/environment/lava-10847=
974/bin/lava-test-runner /lava-10847974/1

    2023-06-21T17:33:43.421599  =


    2023-06-21T17:33:43.427306  / # /lava-10847974/bin/lava-test-runner /la=
va-10847974/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6493305dcd91baaf8030618c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6493305dcd91baaf80306=
18d
        failing since 77 days (last pass: v5.15.105, first fail: v5.15.106) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64932ea39643ce9e74306131

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932ea39643ce9e7430613a
        failing since 153 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-06-21T17:08:37.629555  <8>[   10.119656] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-06-21T17:08:37.629929  + set +x
    2023-06-21T17:08:37.630835  <8>[   10.130154] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3684125_1.5.2.4.1>
    2023-06-21T17:08:37.753467  =

    2023-06-21T17:08:37.860468  / # #export SHELL=3D/bin/sh
    2023-06-21T17:08:37.864121  =

    2023-06-21T17:08:37.972475  / # export SHELL=3D/bin/sh. /lava-3684125/e=
nvironment
    2023-06-21T17:08:37.973004  =

    2023-06-21T17:08:38.076487  / # . /lava-3684125/environment/lava-368412=
5/bin/lava-test-runner /lava-3684125/1
    2023-06-21T17:08:38.077267   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64932c0444dfc1e1f530615d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932c0444dfc1e1f5306166
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T16:57:27.125269  + <8>[   10.468191] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10847516_1.4.2.3.1>

    2023-06-21T16:57:27.125363  set +x

    2023-06-21T16:57:27.226543  #

    2023-06-21T16:57:27.327330  / # #export SHELL=3D/bin/sh

    2023-06-21T16:57:27.327503  =


    2023-06-21T16:57:27.428008  / # export SHELL=3D/bin/sh. /lava-10847516/=
environment

    2023-06-21T16:57:27.428186  =


    2023-06-21T16:57:27.528722  / # . /lava-10847516/environment/lava-10847=
516/bin/lava-test-runner /lava-10847516/1

    2023-06-21T16:57:27.528987  =


    2023-06-21T16:57:27.533368  / # /lava-10847516/bin/lava-test-runner /la=
va-10847516/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649334ac37241c58ff306143

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649334ac37241c58ff30614c
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T17:34:29.018453  + set +x<8>[   12.540970] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10847935_1.4.2.3.1>

    2023-06-21T17:34:29.018539  =


    2023-06-21T17:34:29.122575  / # #

    2023-06-21T17:34:29.223230  export SHELL=3D/bin/sh

    2023-06-21T17:34:29.223419  #

    2023-06-21T17:34:29.323949  / # export SHELL=3D/bin/sh. /lava-10847935/=
environment

    2023-06-21T17:34:29.324147  =


    2023-06-21T17:34:29.424716  / # . /lava-10847935/environment/lava-10847=
935/bin/lava-test-runner /lava-10847935/1

    2023-06-21T17:34:29.425042  =


    2023-06-21T17:34:29.429463  / # /lava-10847935/bin/lava-test-runner /la=
va-10847935/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64932bdddc8ee343f5306181

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932bdddc8ee343f530618a
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T16:56:53.865238  + set +x

    2023-06-21T16:56:53.871434  <8>[   12.971510] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10847504_1.4.2.3.1>

    2023-06-21T16:56:53.980473  / # #

    2023-06-21T16:56:54.082725  export SHELL=3D/bin/sh

    2023-06-21T16:56:54.083471  #

    2023-06-21T16:56:54.184827  / # export SHELL=3D/bin/sh. /lava-10847504/=
environment

    2023-06-21T16:56:54.185505  =


    2023-06-21T16:56:54.286970  / # . /lava-10847504/environment/lava-10847=
504/bin/lava-test-runner /lava-10847504/1

    2023-06-21T16:56:54.288091  =


    2023-06-21T16:56:54.293145  / # /lava-10847504/bin/lava-test-runner /la=
va-10847504/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649333b60548fa4dd6306133

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649333b60548fa4dd630613c
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T17:30:16.690206  + set +x

    2023-06-21T17:30:16.696678  <8>[   11.244270] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10847947_1.4.2.3.1>

    2023-06-21T17:30:16.804132  / # #

    2023-06-21T17:30:16.906380  export SHELL=3D/bin/sh

    2023-06-21T17:30:16.907116  #

    2023-06-21T17:30:17.008592  / # export SHELL=3D/bin/sh. /lava-10847947/=
environment

    2023-06-21T17:30:17.009317  =


    2023-06-21T17:30:17.110726  / # . /lava-10847947/environment/lava-10847=
947/bin/lava-test-runner /lava-10847947/1

    2023-06-21T17:30:17.111924  =


    2023-06-21T17:30:17.117297  / # /lava-10847947/bin/lava-test-runner /la=
va-10847947/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64932bf1ecda6cbeaf306143

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932bf1ecda6cbeaf30614c
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T16:57:11.326984  + <8>[   11.069302] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10847522_1.4.2.3.1>

    2023-06-21T16:57:11.327648  set +x

    2023-06-21T16:57:11.435538  / # #

    2023-06-21T16:57:11.538321  export SHELL=3D/bin/sh

    2023-06-21T16:57:11.539118  #

    2023-06-21T16:57:11.640727  / # export SHELL=3D/bin/sh. /lava-10847522/=
environment

    2023-06-21T16:57:11.641551  =


    2023-06-21T16:57:11.743104  / # . /lava-10847522/environment/lava-10847=
522/bin/lava-test-runner /lava-10847522/1

    2023-06-21T16:57:11.744404  =


    2023-06-21T16:57:11.749801  / # /lava-10847522/bin/lava-test-runner /la=
va-10847522/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6493334408a1c1a361306183

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493334408a1c1a36130618c
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T17:28:17.885541  + <8>[   11.990971] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10847927_1.4.2.3.1>

    2023-06-21T17:28:17.885660  set +x

    2023-06-21T17:28:17.989737  / # #

    2023-06-21T17:28:18.090338  export SHELL=3D/bin/sh

    2023-06-21T17:28:18.090534  #

    2023-06-21T17:28:18.191028  / # export SHELL=3D/bin/sh. /lava-10847927/=
environment

    2023-06-21T17:28:18.191257  =


    2023-06-21T17:28:18.291826  / # . /lava-10847927/environment/lava-10847=
927/bin/lava-test-runner /lava-10847927/1

    2023-06-21T17:28:18.292183  =


    2023-06-21T17:28:18.297177  / # /lava-10847927/bin/lava-test-runner /la=
va-10847927/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64932e4e6cd5963321306133

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932e4e6cd596332130613c
        failing since 140 days (last pass: v5.15.81, first fail: v5.15.91)

    2023-06-21T17:07:16.433497  + set +x
    2023-06-21T17:07:16.433670  [    9.486905] <LAVA_SIGNAL_ENDRUN 0_dmesg =
984371_1.5.2.3.1>
    2023-06-21T17:07:16.541651  / # #
    2023-06-21T17:07:16.643169  export SHELL=3D/bin/sh
    2023-06-21T17:07:16.643589  #
    2023-06-21T17:07:16.744870  / # export SHELL=3D/bin/sh. /lava-984371/en=
vironment
    2023-06-21T17:07:16.745339  =

    2023-06-21T17:07:16.846570  / # . /lava-984371/environment/lava-984371/=
bin/lava-test-runner /lava-984371/1
    2023-06-21T17:07:16.847227  =

    2023-06-21T17:07:16.850101  / # /lava-984371/bin/lava-test-runner /lava=
-984371/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64932bc330f1378969306169

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64932bc330f1378969306172
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T16:56:20.819977  <8>[   11.964280] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10847485_1.4.2.3.1>

    2023-06-21T16:56:20.924629  / # #

    2023-06-21T16:56:21.025632  export SHELL=3D/bin/sh

    2023-06-21T16:56:21.026465  #

    2023-06-21T16:56:21.127817  / # export SHELL=3D/bin/sh. /lava-10847485/=
environment

    2023-06-21T16:56:21.128066  =


    2023-06-21T16:56:21.228809  / # . /lava-10847485/environment/lava-10847=
485/bin/lava-test-runner /lava-10847485/1

    2023-06-21T16:56:21.229916  =


    2023-06-21T16:56:21.234634  / # /lava-10847485/bin/lava-test-runner /la=
va-10847485/1

    2023-06-21T16:56:21.240271  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6493333308a1c1a36130612f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.118/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493333308a1c1a361306138
        failing since 83 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-21T17:28:11.469979  + set<8>[   12.436601] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10847962_1.4.2.3.1>

    2023-06-21T17:28:11.470068   +x

    2023-06-21T17:28:11.574211  / # #

    2023-06-21T17:28:11.674853  export SHELL=3D/bin/sh

    2023-06-21T17:28:11.675066  #

    2023-06-21T17:28:11.775571  / # export SHELL=3D/bin/sh. /lava-10847962/=
environment

    2023-06-21T17:28:11.775797  =


    2023-06-21T17:28:11.876354  / # . /lava-10847962/environment/lava-10847=
962/bin/lava-test-runner /lava-10847962/1

    2023-06-21T17:28:11.876693  =


    2023-06-21T17:28:11.882062  / # /lava-10847962/bin/lava-test-runner /la=
va-10847962/1
 =

    ... (12 line(s) more)  =

 =20
