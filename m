Return-Path: <stable+bounces-3201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868C7FE78D
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 04:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CEF1C20B9B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 03:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524B711707;
	Thu, 30 Nov 2023 03:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="b8a4FvOk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0351A6
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 19:11:36 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d8029dae41so309799a34.0
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 19:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701313895; x=1701918695; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CSvFGceKGcV4tcUmBetBvXdoXtVYe+dmjaqffb/EekA=;
        b=b8a4FvOkygrFvDCyhVvDB/5PM3w0HKwKvzd6nWsMpxn/x3pqbYTcs2QABZAnGZqfU+
         n/JH/aa0FrQ/iIe9cZuYuQeXqfjLTPIZcGtcFqIR6l7qOiBzNyZOXvYEIadpvXb/SMRq
         7Dzf4N0XNGr/MiSNyCx36EynNC69+rVoXkUBwpbsYBg6oozlFJED9ii64wnzso1bLofU
         n9BCNEx5RCmAEW0qJ2jeCzdSRzQAujX7kuD6pbVzOV97kFN0VKICtTvj82k0inOSy0BT
         V9R8fLoPeivmz+8+Hs/koiw8nbCTxeb8oX2Uqa345H3BrId6C2Vzf+wA7oyyRmLriAZx
         qI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701313895; x=1701918695;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSvFGceKGcV4tcUmBetBvXdoXtVYe+dmjaqffb/EekA=;
        b=NQ67jLrNEsYSWcRNc051OfP0FcwIPK3X4j6HTFxTVqO0oByCUwxsXWRkwB9aDj2Izr
         MC2q5EH+FRcmt3Mtu0SxEpWmHRYf5bf9kOCb2wI+ByUNUv6AyKMoxtSY5pqoL5WeGT92
         JWS+P1gOMOn7tryTDwvb9+tM+mQxnWfhs0cYal0NgWzlyux3IHKbQ4cFhjtXMMPQGyqH
         YPReSstT8eD80zMZrMSY6KDDQiCl4xnYjPLMeHt7pkBpx8Q4MPXloUpaDnfFwkp8jxki
         rc8pLhU+HZZGE5CFp3ShBME6InkMCgySSuNYBS9E5yrKyeaN+2IqSqVXydvfBhkkg14i
         4kjw==
X-Gm-Message-State: AOJu0Yy/TOHbPEkoL8Sv4G07M08DReZGj+LoJriPdOt1aAtg0yhC8Ppq
	WtbONKw/SNAVcxVIVT/W+lQyaT9k0/LMxruFuLeemQ==
X-Google-Smtp-Source: AGHT+IFBywmid6FrtyT956EW2uGDg+HtQ+VMm4+zQrTHirEYVKYiQAu4pcwhkcdjqingZncBPiddPg==
X-Received: by 2002:a05:6870:e0ca:b0:1fa:319d:8b with SMTP id a10-20020a056870e0ca00b001fa319d008bmr18804543oab.25.1701313894984;
        Wed, 29 Nov 2023 19:11:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00084d00b006cdc0181de2sm124852pfk.128.2023.11.29.19.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 19:11:34 -0800 (PST)
Message-ID: <6567fd66.050a0220.496c9.07d8@mx.google.com>
Date: Wed, 29 Nov 2023 19:11:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.300-13-g2c5f18dce7e41
Subject: stable-rc/queue/4.19 baseline: 125 runs,
 29 regressions (v4.19.300-13-g2c5f18dce7e41)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 baseline: 125 runs, 29 regressions (v4.19.300-13-g2c5f=
18dce7e41)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
at91sam9g20ek              | arm    | lab-broonie   | gcc-10   | multi_v5_d=
efconfig         | 1          =

hp-11A-G6-EE-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_def=
config+x86-board | 1          =

meson-gxm-khadas-vim2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                 | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =

rk3399-gru-kevin           | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F4.19/ker=
nel/v4.19.300-13-g2c5f18dce7e41/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.19
  Describe: v4.19.300-13-g2c5f18dce7e41
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2c5f18dce7e4163f7994f8b28410fdf5c4897abf =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
at91sam9g20ek              | arm    | lab-broonie   | gcc-10   | multi_v5_d=
efconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cac3f0b08300aa7e4a79

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6567cac3f0b08300aa7e4aaf
        failing since 7 days (last pass: v4.19.284-5-gd33af5806015, first f=
ail: v4.19.299-50-gaa3fbf0e1c59)

    2023-11-29T23:34:52.288996  + set +x
    2023-11-29T23:34:52.289510  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 288748_1.5.2=
.4.1>
    2023-11-29T23:34:52.402634  / # #
    2023-11-29T23:34:52.505744  export SHELL=3D/bin/sh
    2023-11-29T23:34:52.506576  #
    2023-11-29T23:34:52.608544  / # export SHELL=3D/bin/sh. /lava-288748/en=
vironment
    2023-11-29T23:34:52.609347  =

    2023-11-29T23:34:52.711406  / # . /lava-288748/environment/lava-288748/=
bin/lava-test-runner /lava-288748/1
    2023-11-29T23:34:52.712783  =

    2023-11-29T23:34:52.716325  / # /lava-288748/bin/lava-test-runner /lava=
-288748/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
hp-11A-G6-EE-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_def=
config+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cbc745e1ad40077e4aad

  Results:     17 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6567cbc745e1ad4=
0077e4ab0
        new failure (last pass: v4.19.300-13-g218eaa1412efc)
        1 lines

    2023-11-29T23:41:58.593788  kern  :emerg : do_IRQ: 1.55 No irq handler =
for vector
   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
meson-gxm-khadas-vim2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cbadcb3c73dd647e4a88

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-k=
hadas-vim2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-k=
hadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6567cbadcb3c73d=
d647e4a8b
        failing since 7 days (last pass: v4.19.284-5-gd33af5806015, first f=
ail: v4.19.299-50-gaa3fbf0e1c59)
        2 lines

    2023-11-29T23:39:00.798333  kern  :emerg : Disabling IRQ #24
    2023-11-29T23:39:00.798673  kern  :emerg : Disabling IRQ #22
    2023-11-29T23:39:00.799123  <8>[   48.446018] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2023-11-29T23:39:00.799349  + set +x
    2023-11-29T23:39:00.799552  <8>[   48.450217] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3853830_1.5.2.4.1>   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567ccb32ef96025177e4a6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567ccb32ef96025177e4=
a6f
        failing since 492 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cd8c0871f2b96b7e4a7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567cd8d0871f2b96b7e4=
a7b
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d0b9ba95dfc87a7e4a9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567d0b9ba95dfc87a7e4=
a9f
        failing since 492 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d2fd78da46ba3a7e4b23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567d2fd78da46ba3a7e4=
b24
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567ccaccd56e250e57e4ac9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567ccaccd56e250e57e4=
aca
        failing since 492 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cde03b8e84aa047e4a82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567cde03b8e84aa047e4=
a83
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567ccb1cd56e250e57e4ae7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567ccb1cd56e250e57e4=
ae8
        failing since 492 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cd8ed9818728f47e4a76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567cd8ed9818728f47e4=
a77
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d07b8e2c43bacf7e4a83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567d07b8e2c43bacf7e4=
a84
        failing since 492 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d3364e52e119e57e4a7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567d3364e52e119e57e4=
a7b
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cc98cd56e250e57e4a70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567cc98cd56e250e57e4=
a71
        failing since 492 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cdec7322ea854d7e4a85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567cdec7322ea854d7e4=
a86
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567ccb08b310fce5a7e4a7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567ccb08b310fce5a7e4=
a7e
        failing since 492 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cd79616b92745e7e4aae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567cd79616b92745e7e4=
aaf
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d079d0bc60470d7e4a8e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567d079d0bc60470d7e4=
a8f
        failing since 492 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d2a9ac6052e5cb7e4b1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567d2a9ac6052e5cb7e4=
b1f
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cc8cdd43afa5b27e4ab7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567cc8cdd43afa5b27e4=
ab8
        failing since 492 days (last pass: v4.19.230-58-gbd840138c177, firs=
t fail: v4.19.253-43-g91137b502cfbd) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cd9cd9818728f47e4ab8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567cd9cd9818728f47e4=
ab9
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567ccb28b310fce5a7e4a82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-=
virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567ccb28b310fce5a7e4=
a83
        failing since 568 days (last pass: v4.19.241-58-g5e77acf6dbb6, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cd78616b92745e7e4aab

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/bas=
eline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567cd78616b92745e7e4=
aac
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d0c92b61c996fc7e4a7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567d0c92b61c996fc7e4=
a7d
        failing since 568 days (last pass: v4.19.241-58-g5e77acf6dbb6, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567d281ac6052e5cb7e4b15

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567d281ac6052e5cb7e4=
b16
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6567ccb48b310fce5a7e4a94

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567ccb48b310fce5a7e4=
a95
        failing since 568 days (last pass: v4.19.241-58-g5e77acf6dbb6, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6567cd880871f2b96b7e4a74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6567cd880871f2b96b7e4=
a75
        failing since 568 days (last pass: v4.19.241-58-g8b40d487da7e, firs=
t fail: v4.19.241-83-g0ec5709aa1da) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                 | regressions
---------------------------+--------+---------------+----------+-----------=
-----------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6567ccb85dcd1336347e4a70

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.300=
-13-g2c5f18dce7e41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6567ccb85dcd1336347e4a7a
        failing since 260 days (last pass: v4.19.275-252-gcb3c41fc75db9, fi=
rst fail: v4.19.276-34-ge787294ce440f)

    2023-11-29T23:45:42.450563  <8>[   36.385711] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-11-29T23:45:43.465729  /lava-12127121/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6567ccb85dcd1336347e4a7b
        failing since 260 days (last pass: v4.19.275-252-gcb3c41fc75db9, fi=
rst fail: v4.19.276-34-ge787294ce440f)

    2023-11-29T23:45:42.441809  /lava-12127121/1/../bin/lava-test-case
   =

 =20

