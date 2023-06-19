Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0859473580A
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 15:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjFSNIS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 09:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjFSNHx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 09:07:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9023ABC
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 06:06:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b52bf6e669so28401015ad.2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687179971; x=1689771971;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=isZ5sKUQDfdS5hFa3o0mR7MmzFqMUxHsQUn922nwlxM=;
        b=x13R79nvFdwU2E0suTss7Jtrc7/M9ONnRwsJb4feiSNnvvhPeIv0ikezdU3to01p+n
         dGXzYfR1gXjv0ezh7jyrEyV3YbvmTnK/e+PIBIjuxS7NzZSRANGlluZAOEbkt/w70phW
         IH0wdtFnCMZrDZ8QlANpylDyjZhJk03K1cy3saLZw+bxtiGOySHamcEz94Ecgc+w+GbM
         H0VQJuztIdqHKFf9cB5GgIbpni+bkdDHTT632YFBZucLJVvP5B1V48Mb1i3wM5/bK++P
         j+LSk9c1wdFJK7bni4UTSK2PjjkJcrKGetoFW5UIWhXKE0RmlA5IbNQZ/HE8mHAq4Q7R
         s4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179971; x=1689771971;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isZ5sKUQDfdS5hFa3o0mR7MmzFqMUxHsQUn922nwlxM=;
        b=BSmCv/6CMWknpFQ8LDDoMKPjR3aKKW4rcZTDonjkSRpuCaIvWSIylYVAytgSRvg+Xs
         +FNcp8/uKN6SRkEyXyVzU7FndqTUFRlHI8CDUoAT/ULU4HB5UdosjmUjrJjNfJbesQty
         xIveV2S93owIk9aeCvstg+SL3otMMtlXFDSP97SMonY6R480Z+CzCRkjMoTdkiSSJzK8
         q+fKw+wyNTmwKEllNoe83CoSpreZ1ntdE/0ocjo1WWUqjY/5Mx/NvAwhHl/jHsSpEYOg
         F2eEfKb3vNmxLVyz8VJ8+FX6X6i2x1XdcRF1dOvj45Vr4wQIg52+SNgqNLUvLKCh39SK
         7eJg==
X-Gm-Message-State: AC+VfDx9lR7foyYa25vC3Vr8x+c2VJbX8GTHfcqAJcTs6E1rVHIh7CNa
        V67wljy6rlipYiRaYC59ACdfQEl6aWl9Bbx2lMsKqGuh
X-Google-Smtp-Source: ACHHUZ5pkJ5my7NxGP+kbiSnLPdfnz6ZOM8x7AcqrnoO8+i7grjvAlbX0EkFLMAVlCdon1fyWdhzFQ==
X-Received: by 2002:a17:902:6b8b:b0:1b2:1a79:147d with SMTP id p11-20020a1709026b8b00b001b21a79147dmr8531744plk.2.1687179971164;
        Mon, 19 Jun 2023 06:06:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001aad4be4503sm2520882plg.2.2023.06.19.06.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:06:10 -0700 (PDT)
Message-ID: <649052c2.170a0220.826bb.3c14@mx.google.com>
Date:   Mon, 19 Jun 2023 06:06:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.8-187-g6b902997c5c2b
Subject: stable-rc/linux-6.3.y baseline: 165 runs,
 3 regressions (v6.3.8-187-g6b902997c5c2b)
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

stable-rc/linux-6.3.y baseline: 165 runs, 3 regressions (v6.3.8-187-g6b9029=
97c5c2b)

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
el/v6.3.8-187-g6b902997c5c2b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.8-187-g6b902997c5c2b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6b902997c5c2b97cfd513d81cec7d0f0e3dd9b91 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64901e54c06b47778b30612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
87-g6b902997c5c2b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
87-g6b902997c5c2b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64901e54c06b47778b306=
130
        failing since 6 days (last pass: v6.3.7-153-g1fda3156534da, first f=
ail: v6.3.7-161-g718be3905b8f1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx8mn-ddr4-evk              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6490227a59e13bf4ca306135

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
87-g6b902997c5c2b/arm64/defconfig/gcc-10/lab-baylibre/baseline-imx8mn-ddr4-=
evk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
87-g6b902997c5c2b/arm64/defconfig/gcc-10/lab-baylibre/baseline-imx8mn-ddr4-=
evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6490227a59e13bf4ca306=
136
        new failure (last pass: v6.3.8-183-g3a50d9e7217ca) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649022b88c120e4d4830624e

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
87-g6b902997c5c2b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
87-g6b902997c5c2b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
49022b88c120e4d4830625f
        new failure (last pass: v6.3.8-183-g3a50d9e7217ca)

    2023-06-19T09:41:22.218693  /lava-10810189/1/../bin/lava-test-case

    2023-06-19T09:41:22.228329  <8>[   28.588978] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-probed RESULT=3Dfail>
   =

 =20
