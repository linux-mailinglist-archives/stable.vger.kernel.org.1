Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685A2711968
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 23:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbjEYVog (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 17:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbjEYVoX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 17:44:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E901734
        for <stable@vger.kernel.org>; Thu, 25 May 2023 14:44:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae6b4c5a53so418355ad.2
        for <stable@vger.kernel.org>; Thu, 25 May 2023 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685051039; x=1687643039;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6BKpTs6F3bGbzVM6LeJII+sZ2bj14xm5IQNP6tde05A=;
        b=iq8TSDk1uWADyC90mgka0XjapAhRyFECfeX64ceXvEOj1AiAFymhY8xBecPx+TOVVF
         bmi5YbNrhCsGd8pka0wZE+JEs7uQMmWlmwFJ1SqwrdQM0odQ43gFYcPC7YhlMC1l5EIk
         SYnEvdPcCObTKDFtYXq1cySSF37LnYLRprXByj693ibwRR52C9NWTJr8Trd0RFW1VVsQ
         rlkddRZcs7t8zIsNk+wD4ZOVch2Z8fDxGuyEPIaUCnx+V02h3BCtqDDQr2rMRWq1zheQ
         fKiFHHtu0xpWpQABPaeradISuXer8F9OqHSuReVLstvL1b6U67mpmWWHBNR1o5gU4cAL
         A+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685051039; x=1687643039;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BKpTs6F3bGbzVM6LeJII+sZ2bj14xm5IQNP6tde05A=;
        b=MnGTa7x/oJx8ym9ROG99Puuj7i4EaCoNHrsEOGIeXbsRYgyPGRuhidemPNa/BzIjXJ
         Z8CMa2zlHSmO33hKsBh8sAhZZA3psIrWwF9l8xRqF6Vq2QvI/nBxGtDjafioVEDZsGgg
         iKVxLz4JbptJ+ZC0ChNyGfmdv94fStu9DkOrPBQHNClrNYQGTZJox0nzDdDxK4dG/2PU
         s5Zwy4/ou47aTFTCvQ07NXGwJiokUmcjgRjrewTB36k4Ub7nhh2XkQ6gjmK5dj0FHSiZ
         pS8O9ZiiwZnc2VRnjASRamUSQzch1ys5cAFdTfCKYgUOySWX+lNphNTsYHdjd1xFoQ6z
         Yj+w==
X-Gm-Message-State: AC+VfDzybjSJamas+VpibE46dGMT8RJNUvH0yp2FCdgYnN/CPXHF54qu
        I08nDhRkjEaSn63oBOpLXZ4HBNxaYqo2/hFHHd6uvg==
X-Google-Smtp-Source: ACHHUZ6IGp0iRLnqP9LZkIzAcToZ/NFx0ZDOdCFJolNwk7W7SMPkAHZKy+BJKg27K2r0e3f7KQLJhA==
X-Received: by 2002:a17:902:ea06:b0:1ad:7bc5:b9ea with SMTP id s6-20020a170902ea0600b001ad7bc5b9eamr30841plg.60.1685051038836;
        Thu, 25 May 2023 14:43:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jd21-20020a170903261500b001ae78ad48c3sm1818402plb.309.2023.05.25.14.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:43:58 -0700 (PDT)
Message-ID: <646fd69e.170a0220.9dadd.3db8@mx.google.com>
Date:   Thu, 25 May 2023 14:43:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.14
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.315-53-g2d436bf415b3
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/4.14 baseline: 101 runs,
 2 regressions (v4.14.315-53-g2d436bf415b3)
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

stable-rc/queue/4.14 baseline: 101 runs, 2 regressions (v4.14.315-53-g2d436=
bf415b3)

Regressions Summary
-------------------

platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie  | gcc-10   | multi_v5_defconfig | 1 =
         =

meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F4.14/ker=
nel/v4.14.315-53-g2d436bf415b3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.14
  Describe: v4.14.315-53-g2d436bf415b3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2d436bf415b3a63c81048913b1c9f78016397c52 =



Test Regressions
---------------- =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie  | gcc-10   | multi_v5_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/646f9b15f6b8658d8b2e861e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.14/v4.14.315=
-53-g2d436bf415b3/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sa=
m9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.14/v4.14.315=
-53-g2d436bf415b3/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sa=
m9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646f9b15f6b8658d8b2e8=
61f
        failing since 3 days (last pass: v4.14.311-138-gfbf01f9cd097, first=
 fail: v4.14.315-37-g7cbdd14e6c16) =

 =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/646f9e86d37bf8e3312e8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.14/v4.14.315=
-53-g2d436bf415b3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meson=
8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.14/v4.14.315=
-53-g2d436bf415b3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meson=
8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646f9e86d37bf8e3312e8=
636
        failing since 466 days (last pass: v4.14.266-18-g18b83990eba9, firs=
t fail: v4.14.266-28-g7d44cfe0255d) =

 =20
