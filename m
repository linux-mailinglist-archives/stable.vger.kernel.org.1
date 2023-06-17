Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F3A73419F
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjFQOXS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjFQOXR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 10:23:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48841BDB
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 07:23:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-54fb1bbc3f2so1369764a12.0
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687011795; x=1689603795;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=95iHl1WT+yIr0rOffsILT+eBHzwX9Gw+u1HBfOGhcfI=;
        b=NXo5sPrLGejyCEISNhLcbIiN6YTYtEz7Ac1aaIPb0moEyAdQ6hNLRVE0pIVUds3kjb
         LwVTuRhXdPuVnpJZ1uEAsmomF6HvoaS/0SFBkWUtqDTCuNc7McqBU+e66U0yCKJW5CS8
         T1iy94lpR0cFLhaBha1cgtdDF2BJOTQx306/juHMf/oz3YyVzVcpIZwCiuarXRhjMf2F
         xMn6q2g3zwjdJQKPfZGD72qYpXjdij4PN0Aap3tfKVbC/yRkWSCXCr2zLR7k8+HpAwg7
         JoVqLIaVVw51bWS4KoihdheonAB1YFtTHpIy45s/28hsJeSqY59VQUHISqk2Fpj0LE6n
         Qp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687011795; x=1689603795;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95iHl1WT+yIr0rOffsILT+eBHzwX9Gw+u1HBfOGhcfI=;
        b=DE95LVEzguGosH2C6v67LQWOsA4rUtkmgbMLx7PXq36ulFEfsoGV+kKNohHLmZEJMR
         fV0CGNDo9RndSE0iZE+Uo2f2FaiYP9QkYgvEQqBW5d7uRfoW191VrtL3hWXtPt5XGhsd
         oYN/nQuZZkOFR3P/2pRoR7SsDJIu5zXUylWTIP7ynI2+n8sVOjVE5DCvX0zX2ASabjDU
         TfxUYmdROlWVCQdrSUBGKsE2FHoY+rG0QGWrEpW7dfek9q9N6Ylg/0/6IPnQiI8aeRgi
         V80lRfpbaZwCMrCfEvipGWpNzhvrXon9tl+l748T2oSB4XItPbxP1PPV1sLg9eZfbcCp
         d6kw==
X-Gm-Message-State: AC+VfDx30n1B06auKiaM9yFckTyfZXPP90bV7757tK0Vn457vwpTpZYg
        hXffiyVJMkYBdMc0Vdv+rtsV4+kkRXPdrhJ2HnNnNw==
X-Google-Smtp-Source: ACHHUZ68gZ39jABICJuNFSvaxbnG7L69GhgqEM5vl5bCtvY/ANwYjJls50cPfdyd1CV34aNgn1O/3A==
X-Received: by 2002:a05:6a21:3288:b0:110:e7bc:b0cb with SMTP id yt8-20020a056a21328800b00110e7bcb0cbmr6857014pzb.39.1687011794873;
        Sat, 17 Jun 2023 07:23:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l13-20020a654c4d000000b005307501cfe4sm14779621pgr.44.2023.06.17.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 07:23:14 -0700 (PDT)
Message-ID: <648dc1d2.650a0220.a8489.cbee@mx.google.com>
Date:   Sat, 17 Jun 2023 07:23:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.8-92-g94e17d55084b
Subject: stable-rc/linux-6.3.y baseline: 173 runs,
 3 regressions (v6.3.8-92-g94e17d55084b)
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

stable-rc/linux-6.3.y baseline: 173 runs, 3 regressions (v6.3.8-92-g94e17d5=
5084b)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =

imx8mn-ddr4-evk              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.8-92-g94e17d55084b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.8-92-g94e17d55084b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      94e17d55084b4682b1fc040fd621da89fa4c4041 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/648d8dcb79fae80345306145

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-9=
2-g94e17d55084b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-9=
2-g94e17d55084b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648d8dcb79fae80345306=
146
        failing since 4 days (last pass: v6.3.7-153-g1fda3156534da, first f=
ail: v6.3.7-161-g718be3905b8f1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx8mn-ddr4-evk              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/648d91e999696cff5430617a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-9=
2-g94e17d55084b/arm64/defconfig/gcc-10/lab-baylibre/baseline-imx8mn-ddr4-ev=
k.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-9=
2-g94e17d55084b/arm64/defconfig/gcc-10/lab-baylibre/baseline-imx8mn-ddr4-ev=
k.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648d91e999696cff54306=
17b
        new failure (last pass: v6.3.7-161-g718be3905b8f1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d8c6d0f87dccd59306138

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-9=
2-g94e17d55084b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-9=
2-g94e17d55084b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
48d8c6d0f87dccd5930613c
        new failure (last pass: v6.3.7-161-g718be3905b8f1)

    2023-06-17T10:35:17.868007  /lava-10777596/1/../bin/lava-test-case
   =

 =20
