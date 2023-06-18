Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED717347D3
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 20:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjFRSyN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 14:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFRSyM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 14:54:12 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8308BBB
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:54:11 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1a49716e9c5so2846057fac.1
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687114450; x=1689706450;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez5WtyZ33JFMGax8USPfM/bo9SA6L1luok/GasG/hZI=;
        b=aCa8vG/0e0nfeikbcANuZ7rWN+etHYUDT3D4O+T7mY0gaeFkWYTZBZVDp1lnYqUtRG
         0VgBXK3ArGeRFMuzL7WQjMg148KYB1Gwg42Ql96h+fbM6w7fNJw/xVezG9zWOfD3O+HE
         K7Zb9NfGnoPlD1PF25YvOpP2DTDtXfTaM6kVL+aUsD86fQ5B0fIdOu2TnkkYOz5PRrnz
         WBLzdJ0a4BhGVCCBgbJJLgrOzt9qF5kNMMypGkZcm4EovbD0Wnc+JNGDr/8kOrz7sxxG
         pA8VXRi49Ku2sqKDKCFUKf0Ma3y4smzwOnHGC3xnoHcOsEm3fcCQz5ncC7wVJ6zgcIf4
         6V6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687114450; x=1689706450;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ez5WtyZ33JFMGax8USPfM/bo9SA6L1luok/GasG/hZI=;
        b=luECqjUMEV0sVEdpE7ttmRcCLFRd8G87Gjn2IHPHSmUGmy8f+tP+P3KOqqfZhQrdBE
         1FTuBiVHyTrAIfGgltCAue7dFIO2I8I/g6gEpfoKvk1ezEiV1xtqAbRIjhmwEu3sAPwP
         HdekoMTjgNg3fi5rGW1GXnEe6jekIi3jvUh9zzza6+MMTgxoby6BrZU+9YjbMxb8Nye/
         xVxQGh+ZdZk5SFkmKofu98zFgqb7I50lqtY1slPBLi4nEyI72eps+ho8pbz6RH8PlVCH
         ZkCrbdujbRWzh1edp0RJrt76XmLaH2zzzp5F88iPnsvem+uMKa3fiG4ySxrtqfBFXvHE
         hsEA==
X-Gm-Message-State: AC+VfDxghStL0Sx0ftkahIsF5GcTDT2p/e7sQp0nJrF4oIUTdQkD93bX
        UuswaI6a4L2HDWiZ0umALRJ5HfX5maXPWwvPDEVHCm/r
X-Google-Smtp-Source: ACHHUZ4paXXzC8T9yNPM47o9sISXEHfld6HtVm7q7HTk2boPCk8OtD4rGpaD4B1BktW9qLJZ+nUceA==
X-Received: by 2002:a54:4118:0:b0:39a:c202:b2d with SMTP id l24-20020a544118000000b0039ac2020b2dmr8671924oic.44.1687114450322;
        Sun, 18 Jun 2023 11:54:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090aea0500b002562cfb81dfsm4358692pjy.28.2023.06.18.11.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 11:54:09 -0700 (PDT)
Message-ID: <648f52d1.170a0220.e34c8.770b@mx.google.com>
Date:   Sun, 18 Jun 2023 11:54:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.8-108-g5989628de14d
Subject: stable-rc/linux-6.3.y baseline: 136 runs,
 2 regressions (v6.3.8-108-g5989628de14d)
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

stable-rc/linux-6.3.y baseline: 136 runs, 2 regressions (v6.3.8-108-g598962=
8de14d)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.8-108-g5989628de14d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.8-108-g5989628de14d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5989628de14dadd638d86fe577bc0f6a1c3e3840 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1aaed35aefed9530612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
08-g5989628de14d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
08-g5989628de14d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f1aaed35aefed95306=
12f
        failing since 6 days (last pass: v6.3.7-153-g1fda3156534da, first f=
ail: v6.3.7-161-g718be3905b8f1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f1d1c3a10bca175306130

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
08-g5989628de14d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
08-g5989628de14d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
48f1d1c3a10bca175306149
        failing since 1 day (last pass: v6.3.7-161-g718be3905b8f1, first fa=
il: v6.3.8-92-g94e17d55084b)

    2023-06-18T15:04:54.762356  <8>[   27.592625] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-driver-present RESULT=3Dpass>

    2023-06-18T15:04:55.778343  /lava-10794684/1/../bin/lava-test-case

    2023-06-18T15:04:55.788444  <8>[   28.620025] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-probed RESULT=3Dfail>
   =

 =20
