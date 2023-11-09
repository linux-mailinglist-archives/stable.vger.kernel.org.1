Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF197E6E27
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 17:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjKIQDz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 11:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjKIPst (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 10:48:49 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E615271
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 07:46:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd73395bceso927526b3a.0
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 07:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699544796; x=1700149596; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RxOnaP6ytRZlduA20D1a/aqnT9MY8j8IsPipxGBfSo0=;
        b=s+iqdaNDvIuK3zLom/QPayLM5wga+ci14vlhYmXOHRHdBemcibX49tFmQ1MsKQbuDM
         s91qIBLblflYrqdk75xsaDpqcJ56Kn7JJ7U5ctT8kixdpwlser+rZ/wBC8F/UVGS2bW5
         gYlTI5ehaCC5KxJB5wcHGSCMA/NXTjkZTSsW0GETXCS+TNdKpgIo/gB7VIRj9rurfG1w
         f25jUgb3PgsLY1EjUwnU8zFpnDlL2uAF6xlVYSNoz5272c+SNYGtxUwZVrqDQSRxFaiI
         3rmqUkBcZPYm5yi69CVr4p/goOaM83r5r7hP1yBG7FM2n6UVwihVGCpWa0S90ZzsH5G/
         P/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699544796; x=1700149596;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxOnaP6ytRZlduA20D1a/aqnT9MY8j8IsPipxGBfSo0=;
        b=cmcj+mgzfkv/9y9tFBCbVrxlPGTsA33S9wUKlJg5/zeUDSUSAezjZtdrPrZfzGNGzn
         +AaHys/d1NTYQzlCNOCGqZZ3rfqYGRfueiLG0Ix66F4IsmIpehAzfnjgY9vzuidfxRy6
         MnfyUJ9EsBTR2+087L0mMRyZ0ngEviw/xdRcOt8yMTE6RplwbMqTQjNQyxzZ2096/fR1
         lfEDNNOyyMN1h8gw9/XIyxde0AMp1lPTBmwdYTcE0SUNoXKKMeIUKl5qe4hppnw6Mx3s
         uKwnA8gdYlzKqT3ENDVCVe48mJXLyrfKSnvP1FEUi1PI5i8ac9wM8swV2W3Ry7YGI9Uo
         v/yw==
X-Gm-Message-State: AOJu0YzrDBHpQ6ZppbvI53JvpKUNV3gxIW/7uhm8TAXyGoCvEw1a5fTv
        6xls0LWzOxSe5lfUtOfrVfXYa0UPHEmnsNC24YwnvA==
X-Google-Smtp-Source: AGHT+IGAsi31OqfsXPIOIA7Ww1Fw18NEN9kunq9CV2zrepGn+KEL6vHzWoXHbYiL6heqSNbkojwRZA==
X-Received: by 2002:a05:6a00:1d9e:b0:6be:c6f7:f9fd with SMTP id z30-20020a056a001d9e00b006bec6f7f9fdmr9417305pfw.11.1699544795659;
        Thu, 09 Nov 2023 07:46:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gx18-20020a056a001e1200b006933f504111sm11237286pfb.145.2023.11.09.07.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:46:35 -0800 (PST)
Message-ID: <654cfedb.050a0220.6ddc2.c792@mx.google.com>
Date:   Thu, 09 Nov 2023 07:46:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.138
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 116 runs, 1 regressions (v5.15.138)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 116 runs, 1 regressions (v5.15.138)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.138/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.138
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      80529b4968a8052f894d00021a576d8a2d89aa08 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/654ccf7b8c3d5f6b54efcf1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
38/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
38/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/654ccf7b8c3d5f6b54efc=
f1b
        new failure (last pass: v5.15.137-129-gec134bfabca01) =

 =20
