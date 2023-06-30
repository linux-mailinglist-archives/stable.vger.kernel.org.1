Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4953B74325B
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 03:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjF3BqA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 21:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjF3Bp7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 21:45:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C352D55
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:45:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666edfc50deso855094b3a.0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688089558; x=1690681558;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a9aKHaX0DYd/Rr4g8S2eap9KFaqo/27WrjnAWA/hM5c=;
        b=5IpA0Ga9ZZJqJasoI+uAjoiljAWruDc3rF3B4mPLngpVZpbPBLnrdncmePWBig/vii
         rYSspZ4vfLahHNZARm1RcUuUuJLLfUW5PM8gIXUbMPPsdnX/16nxwRUzmT8KBIFamr2a
         9N+Nt1uEjc/3WNf+LBdqQEuegNiY4bLod4uv6btJ0wAzFQomHsCB1Lv/yBnF5mzvI3XF
         Lf79pMEIDk/bEtgsMfImpc2aa+haD26yDPZeUR1KhsNwiG4ChkOxEsXAgtNG/I8RTfJl
         4JHrscpFwcfbh0sKR1AUjFGa5hsFPQ+RLeNJyXbTGk7aMw/4gVT8LwO63mvlYm1gbfxI
         5zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688089558; x=1690681558;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9aKHaX0DYd/Rr4g8S2eap9KFaqo/27WrjnAWA/hM5c=;
        b=YaIDXmbReYVdTZaO4B/WRHHA6GNxMlPnNrKiZSY+RHmbVog10P7neiPv6OfuGuPjGz
         kDm8FDCJgmKvQ/46AtSujMH1bVhJcP2e9tL6ZkqSbS7qd/Ta/pgq9H1bTAKF/2vzBbnk
         TppemyUUyeAryNSSNMFD3kxOImmL1mgluaNXVBbvqlg3WNbmDpkjcy2bTWbuCXJrB49i
         YhcrvjEi0+3Vce7wJcpgiaeFSSG5y7TJvSzkdKaXXPAm2By5QMaHDB2bRJSCRZi52iZ/
         8jYED4MfPv8O0CniYWKHLxF76dAMV2gaXn2q4cKZeJGJBJBluJd9AeVgshy3el+HW7mA
         oeSQ==
X-Gm-Message-State: ABy/qLZatIude83GYXAb99CgnX2c+TaaibB9nZDz9MFf43JZdcyFWask
        ZOMKOOgiAnZMex2AxslvdoFUqaB5mYIdwFtVh0J8Tg==
X-Google-Smtp-Source: APBJJlGvduZm3eXboeotJ67d6JYwGduNsOCL2MxYOaZAEmiTYG0lmtOYPKTZe9ReT3rYn3J0FJWlqA==
X-Received: by 2002:a05:6a00:2d11:b0:67f:830f:b809 with SMTP id fa17-20020a056a002d1100b0067f830fb809mr1972161pfb.3.1688089557964;
        Thu, 29 Jun 2023 18:45:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u1-20020aa78381000000b00662c4ca18ebsm8961867pfm.128.2023.06.29.18.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 18:45:57 -0700 (PDT)
Message-ID: <649e33d5.a70a0220.19b8a.1f2e@mx.google.com>
Date:   Thu, 29 Jun 2023 18:45:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.10-30-g4dedefb62ff0d
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
Subject: stable-rc/linux-6.3.y baseline: 84 runs,
 1 regressions (v6.3.10-30-g4dedefb62ff0d)
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

stable-rc/linux-6.3.y baseline: 84 runs, 1 regressions (v6.3.10-30-g4dedefb=
62ff0d)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.10-30-g4dedefb62ff0d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.10-30-g4dedefb62ff0d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4dedefb62ff0dfcb226b176d92939fcf71bcd733 =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/649e1cb71c51939cd2bb2a7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.10-=
30-g4dedefb62ff0d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.10-=
30-g4dedefb62ff0d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649e1cb71c51939cd2bb2=
a7b
        new failure (last pass: v6.3.9-51-g75add2038dd3) =

 =20
