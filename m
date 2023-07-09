Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F8774C653
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 17:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGIPsK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 11:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGIPsJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 11:48:09 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F85DD
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 08:48:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso2888276a12.1
        for <stable@vger.kernel.org>; Sun, 09 Jul 2023 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688917687; x=1691509687;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6q87vb8lIrKhBgDLEmwfxTzOMgjjS5W8xTixvgWCO5I=;
        b=XXavGYZ0WY3Bjg2dZ5J8eZ4oM19a4biWH/ujlXuNbpgRv3X85zzeM85AgfXkIw/UgX
         OCLNlSMonFg19JIhH82W+5wRa82BT9X2EL3rza6d9Mig3T9YT6zX+Uj7Mv2MJQJevVDy
         Mt+Ehf33AifAWTwoCD/zhv6JxmpAu21aGw0CLK37eYxR2SIU9LagnzeCCm+23USUmnSK
         50vfSfMicQrXp3lYF//oUHfSB57uKNkZdGNubiCwIAl2PZaqq5/QnIFWGOpXfK+LupCJ
         O1HlOFI/7S3KYam9fGSMA5nqJezIbUQH6pjrVc6i6YCviqnVzUnzxJSLZHFzSJVJRSLv
         oOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688917687; x=1691509687;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q87vb8lIrKhBgDLEmwfxTzOMgjjS5W8xTixvgWCO5I=;
        b=IZbS21hjllZbm0MKbJ7Sq3VZo4E8q6P+zfkEx1axZKUGcAlJIYlgAmkgkLncc3jllt
         H9kpf8MI/9Y5k1fYUFL8vDde0y5qaArgwy3tOZe055sOVnZfeiwabAupuB/7PqQl7CI4
         QtlCGPmbitJAnYxKKY/w9CsB9hWveQ2CyJszZ5c2I9IUtYZYZg3eB/pdo2HAGUDJJWVu
         l2nVhY7zxQ5r4SM5q1RDfzY/zHVfsz6vFWNiR5FMV9Pf0dn3uSSPSGuJhf0VksTbLxoL
         GImpCN4a1K6ISReXBDfca+cSxWj5zrTOuEXKrXVzQWMUWajMFMeLzU3H8g8g3iFTzwlv
         lJCg==
X-Gm-Message-State: ABy/qLZEjqXFtCJk30HVsf6Ky1wAK6FXEzW0TK2zlGLfIoW/JTAMmjjG
        H8Yj59vKEwtKnsxgpZ/ZvpS7eFey06d4URpJ4nA=
X-Google-Smtp-Source: APBJJlHFeEYoRiblUlCN10FTkX3q5XZOc2plwI9lzqhmC4F4puGeoxQ8s9vQYVwD90/khsUinAHzAg==
X-Received: by 2002:a17:902:db10:b0:1b8:a39a:2833 with SMTP id m16-20020a170902db1000b001b8a39a2833mr13774926plx.15.1688917687399;
        Sun, 09 Jul 2023 08:48:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bg5-20020a1709028e8500b001b9dab0397bsm1172838plb.29.2023.07.09.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 08:48:06 -0700 (PDT)
Message-ID: <64aad6b6.170a0220.af25a.1b93@mx.google.com>
Date:   Sun, 09 Jul 2023 08:48:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.11-446-gc36188cdbe80
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
Subject: stable-rc/linux-6.3.y baseline: 142 runs,
 1 regressions (v6.3.11-446-gc36188cdbe80)
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

stable-rc/linux-6.3.y baseline: 142 runs, 1 regressions (v6.3.11-446-gc3618=
8cdbe80)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.11-446-gc36188cdbe80/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.11-446-gc36188cdbe80
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c36188cdbe803adfeea94f8b4b1d2c5ebf1f0793 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/64aaa6c30dfd1cc1cbbb2a7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11-=
446-gc36188cdbe80/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s9=
05d-p230.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11-=
446-gc36188cdbe80/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s9=
05d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64aaa6c30dfd1cc1cbbb2=
a7c
        new failure (last pass: v6.3.9) =

 =20
