Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075826F1ECB
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjD1TnI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 15:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjD1TnH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 15:43:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B34C0A
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 12:43:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso329771b3a.3
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682710984; x=1685302984;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oYHrp+VYxvApAnuhiiSdE9J/JYgoCYAY+dpcNnD/vsQ=;
        b=C+j83TZ6fRqzbOYaMNOGl/CWsiz4CY75sOPTjsv6xVr6/Je37lF3e2azHEKdUsGO+w
         JZuups1lykIkXFy5Krct0mbJZuN1pIfTdn3Q9PsAL3dx2yqkypyJ3FOQO+kdbBY0H2qI
         o0qiLW4BkloUkQX2jn1U6PfBFbM34EtKJqFkqJigMD8k65OTSs8KcAhp+2TyobgSsjUV
         L1Qd/32TsxgS7o5IFmDxD9RxKaufkqrZcvf1ENtDSGK463nV41mSQ5FXDtGaq1yaFQgZ
         vUY9Ha55S4YAvkgBiConB4n7GLrJO80KgG0PQ7hNgyNVntMdP1Yp8rT2rvD3IRCe/lOJ
         5xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682710984; x=1685302984;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYHrp+VYxvApAnuhiiSdE9J/JYgoCYAY+dpcNnD/vsQ=;
        b=QYdEawWVu0Ho3tS2BBEj3G+nU7TM8hRwv/dnZ5EJuiMHey4vyYa2gvsYrRN2TByUih
         tsie7O2NT/BPPel8SQUZgg1gRgyF2rJHVS5/l8L4JcR6qiu2/L5FWPz0mv5GtGaXIper
         iMDdZt4W2rn+CqJm4GNNpEyZGKt1lLg5pSsQVM+lDwYHwfHf2y1uspEqnwPcC7g38B2I
         gnwlDnbn9YlA+fXVzY9/MLzFJriGD5nw1Q99yHqfdO8vfjCny9iRlbAnKOQe7eGCWzEv
         xr+wiWU9QuGOHe/nmTUvVEMCiSZ8RyeoZeLg4t7TY3pHCObhskYpcaGuNziyHwsxnaUB
         +z6w==
X-Gm-Message-State: AC+VfDzm+wAZPjOG/aSvaMbML0/z1+V/NdEITYXc/bKv7x+SzzYgky2b
        wu2yA3wBjz784Z+MKgJqmbKNiaqOsJ5wa2L2bI0=
X-Google-Smtp-Source: ACHHUZ73BSLhAH5vxdVyoxTkUnS6oq8dLboJNonvpMbrnNkxe/fWpjBy3HIpNg8javDVqQtMl+70Kg==
X-Received: by 2002:a05:6a00:9a9:b0:63d:641f:5048 with SMTP id u41-20020a056a0009a900b0063d641f5048mr10172846pfg.16.1682710984678;
        Fri, 28 Apr 2023 12:43:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b9-20020aa79509000000b00627df889420sm16044507pfp.173.2023.04.28.12.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:43:04 -0700 (PDT)
Message-ID: <644c21c8.a70a0220.6140c.21cb@mx.google.com>
Date:   Fri, 28 Apr 2023 12:43:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.14
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.311-137-gda2bb75ba0fe
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/4.14 baseline: 101 runs,
 1 regressions (v4.14.311-137-gda2bb75ba0fe)
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

stable-rc/queue/4.14 baseline: 101 runs, 1 regressions (v4.14.311-137-gda2b=
b75ba0fe)

Regressions Summary
-------------------

platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F4.14/ker=
nel/v4.14.311-137-gda2bb75ba0fe/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.14
  Describe: v4.14.311-137-gda2bb75ba0fe
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      da2bb75ba0fe2eb46bb14e1a8e3beb650609320a =



Test Regressions
---------------- =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/644be823a314bc8a832e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.14/v4.14.311=
-137-gda2bb75ba0fe/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meso=
n8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.14/v4.14.311=
-137-gda2bb75ba0fe/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meso=
n8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644be823a314bc8a832e8=
5e7
        failing since 439 days (last pass: v4.14.266-18-g18b83990eba9, firs=
t fail: v4.14.266-28-g7d44cfe0255d) =

 =20
