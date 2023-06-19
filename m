Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B3735ABD
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 17:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjFSPGN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjFSPFu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 11:05:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E8C19A2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 08:05:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-54f73f09765so1519787a12.1
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687187126; x=1689779126;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1SbdD4D7eHoDGdUDLvySeCtmEKEdoc5yQzYuBPTUnM=;
        b=O/iKOCiCcUVL54qTh75Jx3BTe51LHMb4pA6BqNvJKAxnrdJyoM2LCF9qDr0qGqcjoo
         paRxcAWn6GwicSbF4lSLsttH+VCh1/zmcpprySVwWHKoq+apvjtxc4msMhj3TP3y5BLq
         81clpSvo6pUkx2wtEUsVMAjAMDt7+yIk8eah70OadiGJnL8cnD/1ydbaWlBBddoIHmp8
         R/Xx+yd1vqitwvulHGiQrL5QL0WlwenxuUK0k7RVRZEPTasnly5gsIzxD3MCk8WxU+YY
         IZPDVdkfkygm6KM2/9vzrbnIeXw9C+UvXX0NJzMS9E3kx7QgY0yn+/E3Gm1TbUVPSrFS
         7RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187126; x=1689779126;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1SbdD4D7eHoDGdUDLvySeCtmEKEdoc5yQzYuBPTUnM=;
        b=FuM4e7H/U38BfrNirhaYxAJ3SbdQUAuwXnL+Zb7+MhBVTPHpreiN4JC07jwDWTjRSR
         Yh6TFu23A4vWom06++1bW1t+lR+Y2RclE78RLz3R89oZgamVcmJelPjJ6A7fOUu3qSre
         nE7vRr0GIZIhA9vf3LCMoIHwzrfGLXh7EHXtjUgOLsVPUjDP3VnwLSskGt0/nWWDpodQ
         UWkoZPJi4rb0fK905teKQ16kSpA1dzIroAfrytH6c48ZSUg1X/4SvbXvkQFyqlVytDOs
         0RV3cqAQF9EQBYSvTPZPvFOPaQQj9h5rt9p17lxqrM86Q6nCmwP23bIsntXVsl6vSw4A
         Zt9Q==
X-Gm-Message-State: AC+VfDygJIByUt7AT1kRH37dBeGXzj2Sg7ez097BZOOpTFFGXW+iE3v9
        R0qzx5yNxCdj3aeewg5opee2nocMxooK2tSLcVbquo2A
X-Google-Smtp-Source: ACHHUZ7dtVeN7POixZ1yzzsF5NoGSt3xH1ijB+qH/7iR6E0X1V+KFxnlS7351qyWNmGPyFxXletCPA==
X-Received: by 2002:a17:902:eacb:b0:1b3:fb76:215b with SMTP id p11-20020a170902eacb00b001b3fb76215bmr6486430pld.48.1687187125762;
        Mon, 19 Jun 2023 08:05:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e80f00b001b6771ad27bsm479273plg.265.2023.06.19.08.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:05:24 -0700 (PDT)
Message-ID: <64906eb4.170a0220.3041e.0bb2@mx.google.com>
Date:   Mon, 19 Jun 2023 08:05:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.8-188-gc4f2a2d855d4a
Subject: stable-rc/linux-6.3.y baseline: 135 runs,
 2 regressions (v6.3.8-188-gc4f2a2d855d4a)
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

stable-rc/linux-6.3.y baseline: 135 runs, 2 regressions (v6.3.8-188-gc4f2a2=
d855d4a)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =

odroid-xu3                   | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.8-188-gc4f2a2d855d4a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.8-188-gc4f2a2d855d4a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c4f2a2d855d4abab5f904b8deec55ff390f954e0 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64903aeb8d3ae18aef306134

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
88-gc4f2a2d855d4a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
88-gc4f2a2d855d4a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
4903aeb8d3ae18aef30614d
        failing since 0 day (last pass: v6.3.8-183-g3a50d9e7217ca, first fa=
il: v6.3.8-187-g6b902997c5c2b)

    2023-06-19T11:24:02.841616  /lava-10812908/1/../bin/lava-test-case

    2023-06-19T11:24:02.851552  <8>[   28.608877] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
odroid-xu3                   | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/649037a8b2d7a523fb30615c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
88-gc4f2a2d855d4a/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odro=
id-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.8-1=
88-gc4f2a2d855d4a/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odro=
id-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649037a8b2d7a523fb306=
15d
        new failure (last pass: v6.3.8-187-g6b902997c5c2b) =

 =20
