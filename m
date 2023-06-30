Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D796743C6B
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 15:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjF3NKg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 30 Jun 2023 09:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjF3NKY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Jun 2023 09:10:24 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E503AAB
        for <stable@vger.kernel.org>; Fri, 30 Jun 2023 06:10:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-66767d628e2so1471149b3a.2
        for <stable@vger.kernel.org>; Fri, 30 Jun 2023 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688130621; x=1690722621;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JTinVZ4l/62OGmgbLEdVrVFDe45t1zlPBygq7Z8ozCA=;
        b=OUuOVNGoIPzlBfA08ad+3V2YSsLJz8N0umkLe/JOVYILOOzYzyx7N0/sW+J27qCnSq
         A9Py343hnh5V9/RcUhXE+Nt+m0I2yX1qvEv1/Ss2PN1q2XoSzO9h9ONQkIdn+4GKZrN0
         iDiX5zSX0VbbcTUOi1pHjfFuRbrE31ktb5a9fQwCHYBVJytVbwQlrg4xKXiL/ysD9J33
         10b0qhMP1LjmE9lQAiB4VcNZ52oWwHrAaIQmOjW29OeamsNmh/dc+Qtb6s9ZXZ9bluFe
         3n/nWOg7OBdPU4lYllbjUwxPMGIByA9sE048vg8b6Yj70coHb6B7942tZs4owQQ4G2Np
         /f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688130621; x=1690722621;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTinVZ4l/62OGmgbLEdVrVFDe45t1zlPBygq7Z8ozCA=;
        b=IEGbJN8bXoG3ry2qktIGWJjc1GtNk0YPviSd7r44yF6KSkXBORNlxJ7FzmHtrYrqgf
         kmTNhT7ggh757L41u5cOe0RmnI4Fom7cVjLAlYjDVAzjNAwl2X5SjuHMwbFUkGtY9D/K
         wiu8cJI4EvONpEb2NehWkCDp9H8JRiOpf/y1TXlPv9j1EIR3gDqlPY19G8069RlHeO8f
         d5cuG4z9OBHYheybUzTmRgviiza9MA8Ou6ynSIOuYypoQEWiGAyO/4ZDtVMIn2RaxYsR
         nxqZZtgMxsDaQ/Kb7VQsjo6EOGcz7fMosvW7yUTg9V1JF2O6s2fsdzDSGr67Gpxd0sPV
         9f8Q==
X-Gm-Message-State: ABy/qLai+CkHVT7X5PAdi5rA1075tNOnXjUfSP26MCXRvfNhkdfgdVY6
        rsTn6CJKTAigQ+VPR1aswypB7/+IQKRi5ignHw6LgA==
X-Google-Smtp-Source: APBJJlE1KxNOXGilBPE9YP1qFss402e3KyTlCdFlcmS1i5oo+EaDcA38Gpt3UICmr77qPeNbcGAQjg==
X-Received: by 2002:a05:6a00:1402:b0:681:6169:e403 with SMTP id l2-20020a056a00140200b006816169e403mr2443601pfu.8.1688130621427;
        Fri, 30 Jun 2023 06:10:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 205-20020a6218d6000000b0063d44634d8csm314124pfy.71.2023.06.30.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 06:10:20 -0700 (PDT)
Message-ID: <649ed43c.620a0220.ecff5.064f@mx.google.com>
Date:   Fri, 30 Jun 2023 06:10:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.10-33-g45e606c9f23d
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
Subject: stable-rc/linux-6.3.y baseline: 114 runs,
 1 regressions (v6.3.10-33-g45e606c9f23d)
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

stable-rc/linux-6.3.y baseline: 114 runs, 1 regressions (v6.3.10-33-g45e606=
c9f23d)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.10-33-g45e606c9f23d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.10-33-g45e606c9f23d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      45e606c9f23d18a36b9c799e8b7d2cf5bf750021 =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/649e9b60ff2afa93d0bb2a7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.10-=
33-g45e606c9f23d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.10-=
33-g45e606c9f23d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649e9b60ff2afa93d0bb2=
a7e
        new failure (last pass: v6.3.10-31-ge236789dc329) =

 =20
