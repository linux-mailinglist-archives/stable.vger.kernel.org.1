Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BDE74FB13
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 00:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGKWlg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 18:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGKWlg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 18:41:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47755E49
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:41:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso3682398b3a.3
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689115294; x=1691707294;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zsi+3MSu8PzmDiPi1sG6X6/NWSKZPl4fsGNFlTPIAZ8=;
        b=uKGEZ1lPB9YDodc1nQKWewugM9RBhsvWZNF3sXOOzx2IyjEaP6KNUfA47bbSEwxmtj
         a1m62eRDT/tJtzm5YhIpHNnV34zwIibW3y4jp15HEv30iYrUOZQPTs1YO0tAtwTDsqED
         pIbFv6usiVUKVwO+B7oXJren/mTlU60S0aJPSDQrj6q6PdzYkWMURNQ4VddxKe/ZPvzP
         3snDFUDVJsxSTMVT651RBeevTpZ5gLaKkwM5AydT1BY3Oo2pxm2T0fOmZh7TYGZbgq95
         /pd8g5RBrGju5pRWt+PFDTzDxWyJ45MnzOg3w1BzRUy02BnsO/DjZoT1h15d9FXUAzuC
         M7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689115294; x=1691707294;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsi+3MSu8PzmDiPi1sG6X6/NWSKZPl4fsGNFlTPIAZ8=;
        b=QS08u1mDOU8PDmctnrp0hfwDYqZOONBS7oYK/YE/fYHOac0p0Nie7oBpER6JeeCYEE
         fm5Jky+arGxMolTxxC+3KjObYY09TdfGOhouF3Y0bAt+PocjYd1K19G3uQ6buwK+l2xA
         /k26u14TLQ0uN8PwcdSmqyy+fdot/Dx7iq9COzIM6gytF/OrqL8NhpGtjhs45Yu7i6cR
         CG6pWZis1rUxGCPb/aqxpFsC91z3+m+4MKttThLMnXILbcsPW2p4P+oc+ZPiH2jo2pK0
         OSsNmiYPUxu+zleBdbXA6WXYaww+OMhZV+UHOUYykXczEgB4eAiOJ8Z9Kw79LbbuOWst
         ddJw==
X-Gm-Message-State: ABy/qLZKGSBzKwZJCUL6KBTunk+1Z7Fqd0ZwiyuTO1t1vVQ9/x6OL4iD
        eUTRWMmoXIS0ldsZCm22SGNkEQ77xPR1g/4mSz6DtQ==
X-Google-Smtp-Source: APBJJlGlUk7G8O1CSR9idMOiNvgatqGStYSVQlRqz8pZ8an4tel9bNNyExRWX0TSVMtRDPVr8N7myA==
X-Received: by 2002:a05:6a20:1448:b0:130:a4aa:9fec with SMTP id a8-20020a056a20144800b00130a4aa9fecmr13490667pzi.49.1689115294361;
        Tue, 11 Jul 2023 15:41:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a4-20020aa780c4000000b006589cf6d88bsm2259052pfn.145.2023.07.11.15.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:41:33 -0700 (PDT)
Message-ID: <64adda9d.a70a0220.155a1.563b@mx.google.com>
Date:   Tue, 11 Jul 2023 15:41:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.13
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
Subject: stable/linux-6.3.y baseline: 164 runs, 3 regressions (v6.3.13)
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

stable/linux-6.3.y baseline: 164 runs, 3 regressions (v6.3.13)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

meson-gxbb-p200          | arm64  | lab-baylibre  | gcc-10   | defconfig   =
                 | 1          =

meson-gxl-s905d-p230     | arm64  | lab-baylibre  | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.3.y/kernel/=
v6.3.13/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.3.y
  Describe: v6.3.13
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      d1047d75f77afefd19b19ae33cde7ad67f3628c9 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ada51c896f785d4abb2ab0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.13/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.13/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ada51c896f785d4abb2=
ab1
        failing since 5 days (last pass: v6.3.11, first fail: v6.3.12) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
meson-gxbb-p200          | arm64  | lab-baylibre  | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64ada950295172457abb2cf5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.13/arm=
64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.13/arm=
64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ada950295172457abb2=
cf6
        new failure (last pass: v6.3.7) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
meson-gxl-s905d-p230     | arm64  | lab-baylibre  | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64ada9dc7cea34a668bb2a84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.13/arm=
64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.13/arm=
64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ada9dc7cea34a668bb2=
a85
        new failure (last pass: v6.3.7) =

 =20
