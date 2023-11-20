Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541EA7F1DC6
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 21:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjKTUIO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 15:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTUIN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 15:08:13 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59AA83
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 12:08:09 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so4907853b3a.2
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 12:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700510889; x=1701115689; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s4H9Ny3lqUV6gXLdrGdmSLD/MORf9/qrK4D8/ShsWHI=;
        b=lXAT/wgnrF7tQUMawCGBxvr7hQcaay3S+QUGW0jjfT1NJ6bjRry9wlK51vun2ce7Oz
         cTZbpamZNAGljdI4nPKYMotDNNFuWgl1aNdCdkfTeiy4E2GPSbHFiy0jN12Ii1jR/hz2
         dTe2IQDwNdZC/YghWBSuQtM4SpiGXPSE2iWuOmQiw1swHFsM0iT17nPbLIbaDG6avl9v
         iCdfgqT4/URo4mFUOj6n5MwQyV33N8DD9M7yvdpMkuRFE35A6AxwfM2genIyvnjum1tF
         IiYSyuf8IivUAx+nmc3ZdDc6sumJ/bD8p4GO3llJ1lS+TGgd204SzjQl/hlDatw8BT5I
         E1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700510889; x=1701115689;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4H9Ny3lqUV6gXLdrGdmSLD/MORf9/qrK4D8/ShsWHI=;
        b=NB93evfEwvEMYPlwfiRG47CSp6Vb9q3zi33atoPMc1XnuU+gCY7S6/AiF3TN8Hynfs
         i7jC/C72rlbEsPOoRGrzF16AkyCg/J/Obz/Pa1cav3J8GZavoPXdyvnzPJe8fCLHpt27
         BSLSiG4KTiLkiqlgpEcix6kZ9VWG4jCnElYJuYWaRBhfO50si0OVPy59iN5fwwQqA+FR
         eviSBNieh6kvwRLl7p3T7pirsj1j0xZwBofEms2+DTILC/96wjttCl/Fo6mHCvDY5irn
         bIKCrT2u2Zhaaow57lO0+rqTdraUjxgMXeZTRpuepxXcRxBq2XFM5RYgIcxP4+ofFDPY
         Sl2w==
X-Gm-Message-State: AOJu0Yw9KGd3KkH6dL0nkq+7etxWSLoZK0dTo/0U4I3FsA1GuTGZGpqQ
        Yz34NGIKwpnj7iH086MP327oZPhWPrA72UtLhB0=
X-Google-Smtp-Source: AGHT+IHKyUdBJcTTPJ9t6FN2RLZrV0oR95D0rQAC07J6P0BI534Jzu83NtDN8Oppn8ZCm70VY5vZfQ==
X-Received: by 2002:a05:6a20:6a0f:b0:17e:2afd:407b with SMTP id p15-20020a056a206a0f00b0017e2afd407bmr12453854pzk.9.1700510888917;
        Mon, 20 Nov 2023 12:08:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id du21-20020a056a002b5500b006bd26bdc909sm6518915pfb.72.2023.11.20.12.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:08:08 -0800 (PST)
Message-ID: <655bbca8.050a0220.5e00b.1a94@mx.google.com>
Date:   Mon, 20 Nov 2023 12:08:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.299
Subject: stable-rc/linux-4.19.y baseline: 86 runs, 1 regressions (v4.19.299)
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

stable-rc/linux-4.19.y baseline: 86 runs, 1 regressions (v4.19.299)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.299/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.299
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8dd1c3f9bd6a34c2b5c88320b4bade4212d4ec49 =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655b8ae76bb8b24d067e4a92

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/655b8ae76bb8b24=
d067e4a95
        failing since 4 days (last pass: v4.19.298-87-g060b297883f5, first =
fail: v4.19.298-89-g83d114914749)
        1 lines

    2023-11-20T16:35:30.402292  <4>[   46.455537] ------------[ cut here ]-=
-----------
    2023-11-20T16:35:30.403050  <4>[   46.455632] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-11-20T16:35:30.404010  <4>[   46.464099] Modules linked in: ipv6 r=
ealtek meson_gxl dwmac_generic meson_dw_hdmi dw_hdmi meson_drm drm_kms_help=
er drm dwmac_meson8b stmmac_platform meson_rng meson_ir rng_core adc_keys r=
c_core crc32_ce crct10dif_ce pwm_meson meson_gxbb_wdt stmmac drm_panel_orie=
ntation_quirks nvmem_meson_efuse input_polldev
    2023-11-20T16:35:30.445041  <4>[   46.491359] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.299 #1
    2023-11-20T16:35:30.445620  <8>[   46.497458] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>   =

 =20
