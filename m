Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F145734889
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 23:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFRVPv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 17:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjFRVPt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 17:15:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912A2E62
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 14:15:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-543b17343baso1203529a12.0
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687122946; x=1689714946;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BeHiHFMQGIhronHrDT51w13MUgo5uWPREJzA9T2H9dY=;
        b=FPWViEBrdqhLCQzLZWpoG2CnDYgX2Joke9NL+SQN//6F6abLGVw0yROR2vrjVmNvXf
         0bAi49ffObf1eQs5W+EUuLVlO0BQ47FxKZxp+nQpiNehFV2c6/36ADdNsLMDUi/3j2Uc
         tlgPu/RgpbegeyouPUzXadjqqawUBvCaxynh+Q2zBVHqJgcTu8NOzFdOia/ZlmmoR/lb
         Fejl0t6kPVZpfzQYSTNhzy2snnrYW52ACwp5JhszwbynwMHRvc62BFaWtLPENMJTDs+8
         2D6XAKmDzb/P/TIfBsZcCSjo9IdOQ+e8SSzQUZ9mx9PRHnijnCkzGpTnL1lH3swxlOr+
         7pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687122946; x=1689714946;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeHiHFMQGIhronHrDT51w13MUgo5uWPREJzA9T2H9dY=;
        b=hrBQSdOonLVLlktwVCdVwJSsbGQYWlbFvqLWBi+xzimdJbuHFnlYxnq/uwMOrmn6OP
         wxqfMnyblaS5EDQSxdegk1jy4x2jgvIVU59MzN+ZddPMAFMtFFXXrh75n5iiqJ54442q
         SQOHTTWLQvYlOSZdSmOmTDMq3ZWr6hzhXrgy747EJfwumHAbTNTcy01lCXVnK51cgpI/
         CUkrg+iPSgzTf6f6PddKcvDyE4E2NjDFSEwxeSP1VhS8dZQjLxQwnMA5Rvt2Lg7qpUkc
         M3zz5mn7tAJZPk4Uieg5alQ0vx5j9/HXFGpwLJHYhFdhk6kI4ethQLsTBcf8g4Xpq/YQ
         rS2Q==
X-Gm-Message-State: AC+VfDyrWe5G04Wy05KUUh2ArDjpKqwxim+vr7EhoI5QNdPg7vPQneji
        02ciDP0T4Wd0mc/XXSBVStxJhvx+J6dv8YEmtH/cdNpk
X-Google-Smtp-Source: ACHHUZ4eRCY7brXZbowKT/w1LHxYwUmKXp3hee7yMSSRmGTXUm2qzgnPfwwfVkU+yVrF6gs0CmNfkg==
X-Received: by 2002:a05:6a20:6a26:b0:121:ea6f:a506 with SMTP id p38-20020a056a206a2600b00121ea6fa506mr71069pzk.52.1687122946541;
        Sun, 18 Jun 2023 14:15:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709029a8100b001ac444fd07fsm19064663plp.100.2023.06.18.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 14:15:45 -0700 (PDT)
Message-ID: <648f7401.170a0220.9f57f.5f09@mx.google.com>
Date:   Sun, 18 Jun 2023 14:15:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.8-183-g3a50d9e7217ca
Subject: stable-rc/linux-6.3.y baseline: 174 runs,
 3 regressions (v6.3.8-183-g3a50d9e7217ca)
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

stable-rc/linux-6.3.y baseline: 174 runs, 3 regressions (v6.3.8-183-g3a50d9=
e7217ca)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
beagle-xm                    | arm   | lab-baylibre    | gcc-10   | omap2pl=
us_defconfig        | 1          =

imx8mm-innocomm-wb15-evk     | arm64 | lab-pengutronix | gcc-10   | defconf=
ig                  | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora   | gcc-10   | defconf=
ig+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.8-183-g3a50d9e7217ca/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.8-183-g3a50d9e7217ca
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3a50d9e7217ca196b387229f7ef385f195fcf465 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
beagle-xm                    | arm   | lab-baylibre    | gcc-10   | omap2pl=
us_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/648f4055897d3c1e6330613e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
83-g3a50d9e7217ca/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
83-g3a50d9e7217ca/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f4055897d3c1e63306=
13f
        failing since 6 days (last pass: v6.3.7-153-g1fda3156534da, first f=
ail: v6.3.7-161-g718be3905b8f1) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
imx8mm-innocomm-wb15-evk     | arm64 | lab-pengutronix | gcc-10   | defconf=
ig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3e92ca89c55f51306141

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
83-g3a50d9e7217ca/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-in=
nocomm-wb15-evk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
83-g3a50d9e7217ca/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-in=
nocomm-wb15-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f3e92ca89c55f51306=
142
        new failure (last pass: v6.3.8-92-g94e17d55084b) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora   | gcc-10   | defconf=
ig+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f3f8627080e8fab30618a

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
83-g3a50d9e7217ca/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
83-g3a50d9e7217ca/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/648f3f8627080e8fab3061a7
        new failure (last pass: v6.3.8-108-g5989628de14d)

    2023-06-18T17:31:30.435736  /lava-10796446/1/../bin/lava-test-case

    2023-06-18T17:31:30.445743  <8>[   26.543171] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =

 =20
