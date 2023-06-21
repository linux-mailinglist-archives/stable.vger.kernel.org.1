Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DF3739145
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjFUVHi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 17:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjFUVHg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 17:07:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D0B19AF
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 14:07:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b5251e5774so31975505ad.1
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687381653; x=1689973653;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RFBzuT/oZJ1HDt89LLzZwPe3/xhUu3RJZ70aI3ZkRPA=;
        b=Tr1a4yX5Y2DtHemSNOLWPGxcaf/yL/hsBFZA1jkbtoAqnNgOsQFTx49gNYfcyLsNVY
         yGs/e/aA1JasVr1ZFgEGYiN/y/XMJigEa7qe9R5AfsPDIOkx5Sl5yrEQ0d/gLOZ+iS1t
         i+anArQdME2AaeeDtpaDQKAB5QxjKmQVQ2rYG9o69NabEC95miG4/se24RDtWZa1J4vs
         yWK795fSWsS2SsSISLhSNtAkUlTQ2wd1QCcpn6i9vwvMCFiHnPsZ1N35U4loIJEBO5Jh
         FFKYv2z+rdTMdPUlCpNdNIA8jAo45rrvyfYRu7HJZVdqU9UArZLUXsByzxpK6q+t/NQl
         Ibuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687381653; x=1689973653;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFBzuT/oZJ1HDt89LLzZwPe3/xhUu3RJZ70aI3ZkRPA=;
        b=I/BoqhhQg+DVr4EWIMQ95Kzc16jxVjdAkHkqiUAeeBNfsfp3lSsXq+PSxzoRkIZUot
         s352ChzvWUOTGs8mVYixK4Og4xJUGLszYi/saDLrTzWbGhhK9xLjf3bhF8fBrAH/Pk6J
         N2Xw2rAQbzVVbNqGHDKbAjk0u8YtrZVmu6u2B+6er4uGt9fo8wj7zmgA6UYtlc6LNTJM
         RoyPCXFy8Q0+1ojK3QEeEhnX1bgQMvVr9RfIaO/j4oGbuYEe9483HGlz4e6L1mbj87B4
         Du2pRuM9vX3ztkeHdY+E9J7dnr2VrDvXYFz02UqnKcfaK0jzt8XSqBc6oIIYdRX94z+W
         oHwg==
X-Gm-Message-State: AC+VfDwzn7ik3TWyEKUE8jF8RNg0zUjxm+Q/+Y7+lLfZbVkquBtS43Pu
        jXayNex9VTaw0i8D9zCQHN922mfgLxq+oeq+aGndyw==
X-Google-Smtp-Source: ACHHUZ6dhzqcxlkukRFYMdl2Urgid00ZE68FY/WlwD2gsE8AKwOpTcqFat5yiNEIOHg7X5ZpIgsOHw==
X-Received: by 2002:a17:903:11c8:b0:1a2:9ce6:6483 with SMTP id q8-20020a17090311c800b001a29ce66483mr7288876plh.64.1687381653385;
        Wed, 21 Jun 2023 14:07:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709027c0500b001b246dcffb7sm3872871pll.300.2023.06.21.14.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:07:32 -0700 (PDT)
Message-ID: <64936694.170a0220.f2cb1.95c6@mx.google.com>
Date:   Wed, 21 Jun 2023 14:07:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.9
Subject: stable-rc/linux-6.3.y baseline: 164 runs, 2 regressions (v6.3.9)
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

stable-rc/linux-6.3.y baseline: 164 runs, 2 regressions (v6.3.9)

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
el/v6.3.9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      00d3ac724541a0661b148b16cf34fac135a4fd53 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/649331c9d1a0144e8f30613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.9/a=
rm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.9/a=
rm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649331c9d1a0144e8f306=
13c
        new failure (last pass: v6.3.8-188-gc4f2a2d855d4a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649335e77abeaeeac7306137

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.9/a=
rm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-=
jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.9/a=
rm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-=
jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
49335e77abeaeeac730613f
        failing since 2 days (last pass: v6.3.8-183-g3a50d9e7217ca, first f=
ail: v6.3.8-187-g6b902997c5c2b)

    2023-06-21T17:39:39.760274  /lava-10848102/1/../bin/lava-test-case

    2023-06-21T17:39:39.770775  <8>[   28.648042] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-probed RESULT=3Dfail>
   =

 =20
