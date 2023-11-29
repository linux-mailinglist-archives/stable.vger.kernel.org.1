Return-Path: <stable+bounces-3132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EF57FD25D
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 10:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F911C20FD5
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B914012;
	Wed, 29 Nov 2023 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="19gxKtgO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E818120
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 01:23:01 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d8147d3072so2481055a34.1
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 01:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701249780; x=1701854580; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gf6Ebb1OIfyDbK3accsKldHiq99/8pRjbabVWP74e0M=;
        b=19gxKtgOWg3prSARY6UpdxDwOLoqCNMXYOlDUwfjvxRf/gR+Qy+iIveedWr6jvot/Y
         FiV/SDHKk44jkv2pAPXr+LykNwmaDy89Lxnn6/2W4Ju2dgFQcJ/l7zv5BapqKELDVPy9
         riQ/QEQrkC14lp7jo00Zh4/Pui2hyQgc9dPgNV180Mk7VBYveM+qFjIEkgE7uFStl7gn
         I6IFNjERcWD2xvWwPkSZFgcz+MD66nOmBNyuUTcj0G+Cz+rgDGWC1sreuyItCtn5Vdun
         3qmlbxUXMPXUB0VF4EBQ595tIaYik6nwGLiv6ZL19sSdhXtOBZaxQ1UMf85EG31FCiOk
         5BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249780; x=1701854580;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gf6Ebb1OIfyDbK3accsKldHiq99/8pRjbabVWP74e0M=;
        b=CjyEmBAxYh9OG/HxqB+M5Yv6z2XCXzJ0bixMSLTF5BgN+m3k12UvZMn3a3JsNmLBRv
         1xus8WkFnPf5JOdKErJIYhr/bUh+nyF74ou5MQwpX6EWlLWpgSNKbhP1Uw6/vu3rmi/t
         m6ZN/3azjvz3xVvIEIyH22jgLyFJkwZfjyBm027hBR/MRknSrQ3XEJrnZivyFB5bNJAi
         WnCOXEpU7WLhm8o3ofdR4LlwkBIH19IG5mzlmE9S6aDNgVEcg4MFRw1AxvzKXr7PvrTU
         N70yhFdGrjN8lyd0O62spWwEVWiSgCmtcP4qyj2gi5KMDaS2apgsInAtcEwE1/t9c0Ur
         JsUA==
X-Gm-Message-State: AOJu0YyAkq9DE3Kw6jgcMEue3NCojICiiIXHs9yYLS1om6Pc0qbik4Ph
	h5z/x7X807VqFb3WaKo8hS5PrDHP4/OBe16cmLM=
X-Google-Smtp-Source: AGHT+IFStsJ4HOH41LxnWgaSrx/SonQMGb2DWr+z4zV7e7DDXxZ42mhwPxffByHoWSUmexfGyoRPtg==
X-Received: by 2002:a05:6830:1097:b0:6d8:1137:15 with SMTP id y23-20020a056830109700b006d811370015mr15538082oto.18.1701249780450;
        Wed, 29 Nov 2023 01:23:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c14-20020a9d67ce000000b006d8117bc179sm1303933otn.9.2023.11.29.01.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:22:59 -0800 (PST)
Message-ID: <656702f3.9d0a0220.75fb3.8d88@mx.google.com>
Date: Wed, 29 Nov 2023 01:22:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.300
Subject: stable-rc/linux-4.19.y baseline: 129 runs, 2 regressions (v4.19.300)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 129 runs, 2 regressions (v4.19.300)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig          | reg=
ressions
---------------+-------+--------------+----------+--------------------+----=
--------
at91sam9g20ek  | arm   | lab-broonie  | gcc-10   | multi_v5_defconfig | 1  =
        =

meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig          | 1  =
        =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.300/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.300
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      979b2ade8052a563f9cdd9913e45c2462a7c665a =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig          | reg=
ressions
---------------+-------+--------------+----------+--------------------+----=
--------
at91sam9g20ek  | arm   | lab-broonie  | gcc-10   | multi_v5_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/6566d05fca9d6358ab7e4a89

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566d05fca9d6358ab7e4abd
        failing since 1 day (last pass: v4.19.299-93-g263cae4d5493f, first =
fail: v4.19.299-93-gc66845304b463)

    2023-11-29T05:46:34.823113  + set +x
    2023-11-29T05:46:34.823578  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 285148_1.5.2=
.4.1>
    2023-11-29T05:46:34.936527  / # #
    2023-11-29T05:46:35.039633  export SHELL=3D/bin/sh
    2023-11-29T05:46:35.040425  #
    2023-11-29T05:46:35.142416  / # export SHELL=3D/bin/sh. /lava-285148/en=
vironment
    2023-11-29T05:46:35.143223  =

    2023-11-29T05:46:35.245286  / # . /lava-285148/environment/lava-285148/=
bin/lava-test-runner /lava-285148/1
    2023-11-29T05:46:35.246707  =

    2023-11-29T05:46:35.250270  / # /lava-285148/bin/lava-test-runner /lava=
-285148/1 =

    ... (12 line(s) more)  =

 =



platform       | arch  | lab          | compiler | defconfig          | reg=
ressions
---------------+-------+--------------+----------+--------------------+----=
--------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig          | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/6566d1533a526686cf7e4a71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6566d1533a52668=
6cf7e4a74
        failing since 13 days (last pass: v4.19.298-87-g060b297883f5, first=
 fail: v4.19.298-89-g83d114914749)
        1 lines

    2023-11-29T05:50:48.126732  <4>[   51.158249] ------------[ cut here ]-=
-----------
    2023-11-29T05:50:48.127555  <4>[   51.158342] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-11-29T05:50:48.130624  <4>[   51.166805] Modules linked in: ipv6 r=
ealtek meson_gxl dwmac_generic meson_dw_hdmi meson_drm dw_hdmi drm_kms_help=
er crc32_ce drm meson_rng adc_keys meson_ir rc_core dwmac_meson8b meson_gxb=
b_wdt stmmac_platform crct10dif_ce stmmac rng_core pwm_meson drm_panel_orie=
ntation_quirks nvmem_meson_efuse input_polldev
    2023-11-29T05:50:48.171056  <8>[   51.173006] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-11-29T05:50:48.171585  <4>[   51.194068] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.300 #1   =

 =20

