Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A326F1C55
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 18:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjD1QL4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjD1QLz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 12:11:55 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057B844B2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 09:11:54 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a66911f5faso1243115ad.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682698313; x=1685290313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pvOr5rOWNfEA9EYUCKKDWs7EmG14r1uoyZo017BfSaU=;
        b=cYZY/9hF3UqhR8c8od5oyb7JrU80LR+wQNhx9pFLt4MX9TySX2ZcGwq88bsBruoScK
         ZblIKKUMIz8Q9WnoAdG4FYcNVPKh6QJFx6fuKFY5Zj9Cfr2UiDIPOfGBsuCIoGMFKzcJ
         kbsMwlY6KkguTjSg5v6m0zNf6/JOoL+3FMQbxAr4HIO0cTX4ok+eiOGCqD0bqqPnbjhK
         TGFwEj5u7UCcz+yjHLPG6yiRzMRSg0ptIAVHCZGzfb5vz9esxV7ClIz1+bq3Rsf7Lh9M
         7MQGZ6HzDgQTexAJThjl+lINSoPdXCETW2ObviwqMz+iQ1Zqs2FAv7AmjSGJ8j9+EGzn
         tT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682698313; x=1685290313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvOr5rOWNfEA9EYUCKKDWs7EmG14r1uoyZo017BfSaU=;
        b=PL065S2xK8Rbzvgj7lySSnosQi7hc+zdHLk5wFGwe17gK7WizP35e0rK3GdQh/WPDR
         YpbRfrREWxtUDXdNvf0wEBG3BYzev0nVFI0oCrEfEbOCY4PL8AAgMANMs9fpsBn7+Efh
         GWlwE8M8fxNUg18YSrcB4GAPsQoP8NgCM+XgFjSz8SQF4z47L+h2c7DuhYehC9Fo2Ydu
         ay5UuuE8FRh0M6DoOVa9TMIDnx3/MEFq55dEdFjGG1ZhAfsb7tiodB9p+az2NKqQ3ylk
         c2/DYYJ7Bf/LwwKvhk5cpG4tbDlls+W4VR9hTFSixGQZ6eVrBjt1pM5ZQtWtrWFKK5IW
         1oWg==
X-Gm-Message-State: AC+VfDwVpxvMkt/yO2DP8GiHAeA7AOW5Cz3x3yJcNVLV3GiqZQl0zpSF
        4PT5G62kMHjBHSxcxQGStu5vxE90BeUpE371f2k=
X-Google-Smtp-Source: ACHHUZ4LKQDEdE030lDK/ckF0gNe5n0KTJk5JQCWoqd9TS0YcmR9xEA8QS0He5gRWVxZZHL2VUiwLw==
X-Received: by 2002:a17:903:11c9:b0:1a9:bdf8:f551 with SMTP id q9-20020a17090311c900b001a9bdf8f551mr4905076plh.69.1682698313035;
        Fri, 28 Apr 2023 09:11:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902820100b0019ef86c2574sm13405253pln.270.2023.04.28.09.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 09:11:52 -0700 (PDT)
Message-ID: <644bf048.170a0220.3d240.cc6e@mx.google.com>
Date:   Fri, 28 Apr 2023 09:11:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.14
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.311-137-g81a3726fbded
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/4.14 baseline: 100 runs,
 1 regressions (v4.14.311-137-g81a3726fbded)
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

stable-rc/queue/4.14 baseline: 100 runs, 1 regressions (v4.14.311-137-g81a3=
726fbded)

Regressions Summary
-------------------

platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F4.14/ker=
nel/v4.14.311-137-g81a3726fbded/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.14
  Describe: v4.14.311-137-g81a3726fbded
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      81a3726fbdedc7b207ebc347d6e9604d092515ac =



Test Regressions
---------------- =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/644bbc47e9eecf957b2e85f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.14/v4.14.311=
-137-g81a3726fbded/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meso=
n8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.14/v4.14.311=
-137-g81a3726fbded/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meso=
n8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bbc47e9eecf957b2e8=
5f5
        failing since 439 days (last pass: v4.14.266-18-g18b83990eba9, firs=
t fail: v4.14.266-28-g7d44cfe0255d) =

 =20
