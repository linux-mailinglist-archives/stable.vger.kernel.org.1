Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D4675D770
	for <lists+stable@lfdr.de>; Sat, 22 Jul 2023 00:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGUWYg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 18:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGUWYf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 18:24:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3B830C8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 15:24:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bb775625e2so3385225ad.1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689978271; x=1690583071;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+AkKpM1esyNbEXPt8OWwqwidN6QwEHr4CrAuocNo1Q=;
        b=ys8cpDHVgvOFxhiaXvHSsAkOfeEk7MvHWCNOt8XP90hzoYMakeEeC3yGzh4y7hodmV
         2Gr5eaY7WNRpFBzkEAB4a6iHFHOmNT343HYG1HrNayt1ZdAeBrrl2qZl7+r8V4egNc2w
         pkbfvE7FXWJOGmHBc8u64PnPbGULquvek1lK6E/Mg1xEm6yNgr+2W6drsp4R+CY3oOct
         933zlYsCMmDKM2tQrwGrgwq+I61qkjiSKGD1jMPXtbzafacDwNRmOc6NH3q1FoHc62px
         8tXc88bB+LyqliKFBoFXrVuoJ5Xsu8Ocups3p+fNXQ1McJioWxbq4duRAt5HB1KVam7s
         13Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689978271; x=1690583071;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+AkKpM1esyNbEXPt8OWwqwidN6QwEHr4CrAuocNo1Q=;
        b=X1OcMtw7yZbfdBzp/3TmkAjihDBpS5twjHPO0Wwv4aldkEquhTISWcOtRDHoZZOPUT
         Fv39tP2Sgcote56/J2VqTIciqhvqGtnJCzUlV5hzXZb1pLIGSVRZc1bL+KPTLyVnKWkh
         utHJ7cYfXgYk8ymjzey2l+ErHByz0GKKyP1t4o7Qr49tLbWaUbDjS+4ZvwuQOJJVXvtq
         2SlKbm97mX0cftANnu0vuj66ns5uTSlci2YTloyuYG4fKGIooaqQ5Tlzyr8BZp3+jcTw
         9F+rZciZV2QdSjIrqvTbgtiiBVvT76eT4SmCmT52Mr8udOMiycTiGYfHLEHvFiLsoYoq
         fqGw==
X-Gm-Message-State: ABy/qLYL0ueXkJUZBAPqnwPkxM+MKUz+zHTV7b6BNvXS8e3DpOj2WVdR
        NciPjSSe0e3Av+Bvd7+8ae8W7k+iN7aaF6WbSic=
X-Google-Smtp-Source: APBJJlF8nC0hmISzkU5FNGSn/CzZFXwG4aDOS/tGoFrhbiDqW+Ke6ATqx0tt84C7hf/1KdbWAKCBFA==
X-Received: by 2002:a17:903:1cb:b0:1bb:3d05:764 with SMTP id e11-20020a17090301cb00b001bb3d050764mr5065034plh.32.1689978271589;
        Fri, 21 Jul 2023 15:24:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y3-20020a1709029b8300b001b895336435sm3997815plp.21.2023.07.21.15.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:24:30 -0700 (PDT)
Message-ID: <64bb059e.170a0220.131d1.7bbf@mx.google.com>
Date:   Fri, 21 Jul 2023 15:24:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.320-125-g5cffa7b2aa8b
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-4.14.y baseline: 54 runs,
 1 regressions (v4.14.320-125-g5cffa7b2aa8b)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.14.y baseline: 54 runs, 1 regressions (v4.14.320-125-g5cf=
fa7b2aa8b)

Regressions Summary
-------------------

platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.14.y/ker=
nel/v4.14.320-125-g5cffa7b2aa8b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.14.y
  Describe: v4.14.320-125-g5cffa7b2aa8b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5cffa7b2aa8b04d9314eff634a714e0c6fc2b754 =



Test Regressions
---------------- =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64bad33d79bc67dcd68ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
20-125-g5cffa7b2aa8b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-me=
son8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
20-125-g5cffa7b2aa8b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-me=
son8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64bad33d79bc67dcd68ac=
e1d
        failing since 522 days (last pass: v4.14.266, first fail: v4.14.266=
-45-gce409501ca5f) =

 =20
