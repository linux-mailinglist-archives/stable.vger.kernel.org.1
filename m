Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E8775E50C
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 23:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGWVxs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 17:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGWVxs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 17:53:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3DAE61
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:53:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-66869feb7d1so2124219b3a.3
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690149226; x=1690754026;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1YPobIwz6cImf/IKMbHNtF5aX6x+2W6rvGkBSIYVwmU=;
        b=v8noFaSD3FDRxELjnwxQ34PSG7L7EvUUoWsILICc7SBQVPUluqgAykTIdLq6c1sDZh
         Emb91SU87KbmE4FKG9IX0F5IHH2DDVqsq406p9zr8/wmFco9W5Tq2cGBlxoHDgRMBGv1
         xPMNjjLEqz0NzfPv0BVbIb8kukkxaW07mbj5hsc5SeyIiAMrhq3v5P7gUsLWtL1Lq6Cv
         M536gKFZlbmJH6lXtxGTxgG+p94GPERtzYQplABf0m2fOdvgKLzs+9cwzyWEtpXwyb4P
         FRAveF6pN/9Qie3dGtr1AjOR1+eW9AaEegldA2TN4TPO6KOcrDL8wGxHQBQN0+jYKNl3
         5tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690149226; x=1690754026;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YPobIwz6cImf/IKMbHNtF5aX6x+2W6rvGkBSIYVwmU=;
        b=cdSkieC/L3wIzGK4kws2my26PWQzMS96Cf2QbMTGd/ESZYvdGe2eE8LZyw0vVUwMqc
         IJ2oPzBoSFGC0ph9RYgo2hfrXZ+wo1v5kVx88rNUtdnmJ+YIwBIk7wGnEwWbAQTdmLsr
         uyJRmxUAkZpaJ47kYj8bHqLW6wPC3n1IsOGVnb4Z88kc8AgwzkoSb+y+L1mmBdDEd8iK
         91dl1BYHsE/b8sRKl5ONUamesx2I+tvqziTuTd3fLwQA4avBS4YNrMUustvoljF9b6Jc
         qTUjBEOKJPxRtINw/35VYNSt60Npyap6LqQxzTo3aUonEWINiNo+0V1xoRMdjDL/k+6B
         0p6Q==
X-Gm-Message-State: ABy/qLZOhHFH+kA6ZnayiaasEMDGQbFRLRxcyc0qYSCnzoY2pfuU/m//
        d9cE2/wAcGwLATuYkqFPUSJaBgzhrSTBs16AvWM=
X-Google-Smtp-Source: APBJJlECmjZfc9ICotzZ0yT40YUrAtGaHbCscGG0F7aQ4RLJyyuErED9+k0GmJEjU+NlkN4283w6Vg==
X-Received: by 2002:a05:6a00:1405:b0:668:8596:7524 with SMTP id l5-20020a056a00140500b0066885967524mr7271552pfu.20.1690149225730;
        Sun, 23 Jul 2023 14:53:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79153000000b00682af93093dsm6367050pfi.45.2023.07.23.14.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 14:53:44 -0700 (PDT)
Message-ID: <64bda168.a70a0220.d2a7.acae@mx.google.com>
Date:   Sun, 23 Jul 2023 14:53:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.288-192-g80628ee9a6264
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-4.19.y baseline: 37 runs,
 1 regressions (v4.19.288-192-g80628ee9a6264)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y baseline: 37 runs, 1 regressions (v4.19.288-192-g806=
28ee9a6264)

Regressions Summary
-------------------

platform   | arch | lab          | compiler | defconfig          | regressi=
ons
-----------+------+--------------+----------+--------------------+---------=
---
cubietruck | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.288-192-g80628ee9a6264/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.288-192-g80628ee9a6264
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      80628ee9a62647977364404e68af1133c7089be1 =



Test Regressions
---------------- =



platform   | arch | lab          | compiler | defconfig          | regressi=
ons
-----------+------+--------------+----------+--------------------+---------=
---
cubietruck | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64bd6a4684c718b9e08ace3e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-192-g80628ee9a6264/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
88-192-g80628ee9a6264/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bd6a4684c718b9e08ace43
        failing since 187 days (last pass: v4.19.268-50-gbf741d1d7e6d, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-07-23T17:58:10.633523  <8>[    7.357108] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3724284_1.5.2.4.1>
    2023-07-23T17:58:10.744207  / # #
    2023-07-23T17:58:10.847927  export SHELL=3D/bin/sh
    2023-07-23T17:58:10.848970  #
    2023-07-23T17:58:10.951100  / # export SHELL=3D/bin/sh. /lava-3724284/e=
nvironment
    2023-07-23T17:58:10.952240  =

    2023-07-23T17:58:11.054945  / # . /lava-3724284/environment/lava-372428=
4/bin/lava-test-runner /lava-3724284/1
    2023-07-23T17:58:11.056888  =

    2023-07-23T17:58:11.061889  / # /lava-3724284/bin/lava-test-runner /lav=
a-3724284/1
    2023-07-23T17:58:11.140622  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
