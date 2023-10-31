Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B547DD6C2
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjJaTsE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjJaTsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 15:48:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6299C9
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 12:48:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c434c33ec0so47409345ad.3
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698781681; x=1699386481; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ryX4MSmWeDO24PD4TS0ZS1//lGhC214FqJwUFUJ0HsA=;
        b=iWmkJntwHQqQLt/Gr8aKgd0iyg6auXNXZR6GgICjRafuPDqXiEMcjsiDXmCWd7jX+q
         wFgm6NPYxjcQV4MktdZEDAdSRoZL259CcTVT7XjD8qPAli5260kcvpeH35q0Jc0rxlkI
         1PJI5ykPRc7e8MqsAmjiNNk+psdzHO/aNlbu9vswYtNmw1ynfpqOqX88GZfLCh9Yj1y4
         Emvb5Xb7lIIo1oXACQumS5Zl/6Hw1unWicZjFYgZboG36dDWZM/6+AMR5FTsgZdQ/P9/
         wHUC+3AESEMIxQFkt70vy72DW6pjdcDlIz4hCSJl2975CYCeBwh5GxrqEwXtzpR3kTxb
         hsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698781681; x=1699386481;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryX4MSmWeDO24PD4TS0ZS1//lGhC214FqJwUFUJ0HsA=;
        b=lZxaQhKM0AFPYT6EV0lGWspeYqTOk9UTw5QWAuVvPfrfwdDk0093qEP6NCCqicPTu2
         rSWApstKWHcR8AlO7L0EXU8oF0Lx8oQtE1BHuWqSlvw0bXTVGnBKrzBfUD0XwGsfB0gh
         b/tDNewrsVzV7js05d+HW0W1FfvNAoY6d43+6aL1B2EzbdrscLxAvmlfaONI0B3Yfelv
         2Qi+5Q+sa+WKeVsGsy67jnI88ne2sSeMEUVWVuTZBsdVLkQnQmngW5au3XG3tNvhBXnH
         Y1QhgYEcd4NjywBrn/wiG/A7TqECnAxOxOyDUMi0OohQ2LmWgBfXVH/IlwHQ5H6e4Yyx
         cNLA==
X-Gm-Message-State: AOJu0YyI0c8z8axB9RBAIt2xICxZ5YCX+kJlJ2RTknKRVowChYp5i4EY
        P07nM48dIfV+5owcFKqP0R6cXDJGD4EOH1QXb7e88g==
X-Google-Smtp-Source: AGHT+IEGoSpcMGL1NmWp5/K/YvmSd7SJNM8jQXJ4768WUHtYM/SupxTyODbrAT7ir3JJPKpkZePPcA==
X-Received: by 2002:a17:902:d4c3:b0:1cc:6ab6:df26 with SMTP id o3-20020a170902d4c300b001cc6ab6df26mr2654816plg.49.1698781680772;
        Tue, 31 Oct 2023 12:48:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001c88f77a156sm1670629plg.153.2023.10.31.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:48:00 -0700 (PDT)
Message-ID: <654159f0.170a0220.a9735.4a14@mx.google.com>
Date:   Tue, 31 Oct 2023 12:48:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.328-28-g951b0fedfe39
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.14.y baseline: 116 runs,
 1 regressions (v4.14.328-28-g951b0fedfe39)
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

stable-rc/linux-4.14.y baseline: 116 runs, 1 regressions (v4.14.328-28-g951=
b0fedfe39)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.14.y/ker=
nel/v4.14.328-28-g951b0fedfe39/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.14.y
  Describe: v4.14.328-28-g951b0fedfe39
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      951b0fedfe3934a73709d5a01d3f57d23e879f11 =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/65412a2eac0ac2dc9aefcf23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
28-28-g951b0fedfe39/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
28-28-g951b0fedfe39/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65412a2eac0ac2dc9aefc=
f24
        new failure (last pass: v4.14.328) =

 =20
