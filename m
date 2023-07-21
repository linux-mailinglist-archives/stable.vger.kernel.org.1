Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E675CD24
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjGUQHE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjGUQHD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:07:03 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCFA2D77
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:07:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b66ca1c80so1139881a12.0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689955621; x=1690560421;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KLLbbzq7bpPUMQ0D3+nPymMdf1jFSJupphQOBsluj/g=;
        b=KaouR+290HGOSevBXT9IXTB3rqb4z2uzNvRXCGIi0OHSaNi1gfM5QPmKXcX571LNx7
         7u/JNhV0jOp7Jritxk7XRa2AMy4nBpv8T6GuQVXIJtyJkzle6a/UUbumnhxuR/x+j7X4
         4+jSkmKh6JgZ+48E+hekjASB9X62bsGpyv+OG9n+KX9q2D9zdj+3DzZuBKiv1H3mfxgg
         0gp/DLbEam+NXbAaKshqTlrcrdNRjESuOsOAuoOyEK72c/d/IbQAQTV7VhLqZbq6UY2c
         QU50fBshlbq24Dd5vQh5aD7eMcfq9UHqLyRCuCH/6yTXHqrJq6BrW+GKsFeiAcfmPMU3
         c/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955621; x=1690560421;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLLbbzq7bpPUMQ0D3+nPymMdf1jFSJupphQOBsluj/g=;
        b=gxPNlXtsjjNlO7oKWcPdXCrNpGYVC9ErUCrn+AwvQJp8QU9c+dHxd6rbs5ZXDvRS15
         GQtOjjuaf5yM9YY6uOBGECXJ2ganvl2hYdnLgzxvF0auuXX7vg9cwyMzuf92ebCxw1z3
         mqvixXU7KtqKDfXEhm5pmu1UuFlak+iTsRTEn8N1DFVGEy4Uv9Oen8lDh+erwHU9LWf3
         63vFfpoo/qbweWfc+05dFdYyLLpG/StU8nJ6mwlnQoJlKPhfSdFz48tY5tRCRXqoUK76
         /3xP0FbaMxDNmzRPLyIuwrtCdXvEfZIk8MVvU1eBrpUIdBO3nvwVBsEJdz7td/jPtPVP
         vt3g==
X-Gm-Message-State: ABy/qLbtjHqcOT4A8tNkTegzUAKLfeABNdmVbfElcESaTGjmKPf4COXb
        JeY06CQwPiWsRP2K8JlB7lhGPnZ7Ag2mtTj20OcJEA==
X-Google-Smtp-Source: APBJJlGCcLhhIkFcUGdP8rnc+/XKviE1CAPVhf3BVifwXguKOoiICfUH2L6SWweyEp7ArrmrgFcWHw==
X-Received: by 2002:a17:90a:c253:b0:24e:2e86:5465 with SMTP id d19-20020a17090ac25300b0024e2e865465mr1771841pjx.31.1689955620907;
        Fri, 21 Jul 2023 09:07:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a0e4200b0025bdc3454c6sm4691164pja.8.2023.07.21.09.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:07:00 -0700 (PDT)
Message-ID: <64baad24.170a0220.b1bb.936f@mx.google.com>
Date:   Fri, 21 Jul 2023 09:07:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.288-158-g5299d5c89ca8
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-4.19.y baseline: 10 runs,
 1 regressions (v4.19.288-158-g5299d5c89ca8)
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

stable-rc/linux-4.19.y baseline: 10 runs, 1 regressions (v4.19.288-158-g529=
9d5c89ca8)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.288-158-g5299d5c89ca8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.288-158-g5299d5c89ca8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5299d5c89ca823714738cf2e26456fdfde8bda91 =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/64ba7a2bff38d7920a8ace3f

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-158-g5299d5c89ca8/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-158-g5299d5c89ca8/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ba7a2bff38d7920a8ace71
        failing since 21 days (last pass: v4.19.287, first fail: v4.19.288-=
6-g9430a6475aa0)

    2023-07-21T12:28:51.580685  + set +x
    2023-07-21T12:28:51.585710  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 4597_1.5.2.4=
.1>
    2023-07-21T12:28:51.699601  / # #
    2023-07-21T12:28:51.802624  export SHELL=3D/bin/sh
    2023-07-21T12:28:51.803429  #
    2023-07-21T12:28:51.905381  / # export SHELL=3D/bin/sh. /lava-4597/envi=
ronment
    2023-07-21T12:28:51.906191  =

    2023-07-21T12:28:52.008212  / # . /lava-4597/environment/lava-4597/bin/=
lava-test-runner /lava-4597/1
    2023-07-21T12:28:52.009566  =

    2023-07-21T12:28:52.015916  / # /lava-4597/bin/lava-test-runner /lava-4=
597/1 =

    ... (12 line(s) more)  =

 =20
