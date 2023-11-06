Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A737E2E43
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 21:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjKFUhM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 15:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjKFUhL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 15:37:11 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C447ED51
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 12:37:08 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6be0277c05bso4202098b3a.0
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 12:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699303028; x=1699907828; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WlPZzLwO4jUdz+br6OnVrDHNGe33UAORrfyJfPpPXg8=;
        b=WfxWhPakhzUoGAyo1TuQrnVsY8VYumjWnj7fD3BSwN50vFZXFdC/6XWJ6m+SUYxPU9
         PZQbVwAfaIbgq0u4FfwkzlAo14AF8O+nRkekA+zZS80M3UH89lV7GIxvhE54/vU9+Gog
         anFFg5MGQ2AKPtauD+j+lA0g3Df0ebi4O7TXa1K3EEG8/mx2FrM0KIMuSbg/8bwcx14W
         2xqyXKmHnaOhXNUm/SIFWQEmILYlyDufY/KcpbZr33JbpQtEvIljBkKYSf7gIhZYY80X
         t3Uyr6BC3Yqy753MZKoKco7t2Z2KRfI94vDDIsfEbv2qVS4yCioUpT4N5owophMwiFHe
         9uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699303028; x=1699907828;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlPZzLwO4jUdz+br6OnVrDHNGe33UAORrfyJfPpPXg8=;
        b=rFFfrzoZQAbV0Y/CWjZgQPBXXETs+DjgwprdyFmbb5uxkdNzXSABvLaxf/2lt1Alt5
         QGL8LvgcbwWl4FHI5+OVchJtVOUu/Qhefuie8BT9MuqYAP9jIhJYr1OXvOfilBkFQ9jf
         +tiI8LwaZK7co9DibfaVvlUu4UuSjGuMJfOorzJSsyKI04WsVkmS5XUK+txagIr01N8w
         NFO1HyF3U2KJnJs+Z7/oydkSk4x1sdOlZyTbfI+ISVl9cgbGbepagrUCflzqWzKUqmun
         SrPQqLmsEkQ6frZ5MxJsKwFVUM23c7oKgigrtxkrBYYoL0C5K2FAzW5pkQ4Xo2SlWxhn
         gIyw==
X-Gm-Message-State: AOJu0YyqujaX9/t+79QJ65/8OiQSh8WgDXyzBAW/N6Lu9sE47b5nWner
        ifNJLatqQrpYp/ZdpHsbAEbDiR7fWxRR5IPZ4xF2CA==
X-Google-Smtp-Source: AGHT+IGVkEUn2B+Am+OKo6QjCk4oNFNxjU3Htf0JdaPdH2H7fPY/7ZqQ1EFo31WoQxY1AXVi/D3NfQ==
X-Received: by 2002:a05:6a00:c8d:b0:6b2:baa0:6d4c with SMTP id a13-20020a056a000c8d00b006b2baa06d4cmr27812456pfv.33.1699303027559;
        Mon, 06 Nov 2023 12:37:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a3-20020a62d403000000b006c3328c990csm6241158pfh.163.2023.11.06.12.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:37:06 -0800 (PST)
Message-ID: <65494e72.620a0220.dd112.e62d@mx.google.com>
Date:   Mon, 06 Nov 2023 12:37:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.297-62-gcf4a4e22ca8be
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.19.y baseline: 134 runs,
 1 regressions (v4.19.297-62-gcf4a4e22ca8be)
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

stable-rc/linux-4.19.y baseline: 134 runs, 1 regressions (v4.19.297-62-gcf4=
a4e22ca8be)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.297-62-gcf4a4e22ca8be/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.297-62-gcf4a4e22ca8be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      cf4a4e22ca8be35b01101e3d8d6d1dc62d7d2412 =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65491d03cfe90f371eefcf82

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-62-gcf4a4e22ca8be/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-62-gcf4a4e22ca8be/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/65491d03cfe90f3=
71eefcf85
        failing since 21 days (last pass: v4.19.288, first fail: v4.19.296-=
42-gb3c2ae79aa73)
        1 lines

    2023-11-06T17:05:42.719045  kern  :emerg : Disabling IRQ #18
    2023-11-06T17:05:42.719789  <4>[   51.397517] ------------[ cut here ]-=
-----------
    2023-11-06T17:05:42.720449  <4>[   51.397612] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-11-06T17:05:42.721064  <8>[   51.400529] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>   =

 =20
