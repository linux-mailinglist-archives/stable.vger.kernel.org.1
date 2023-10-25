Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B067D77D3
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 00:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjJYW2G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 18:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJYW2E (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 18:28:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C063891
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 15:28:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27d104fa285so169802a91.2
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698272882; x=1698877682; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eq7lVsLzSLFgeYP3v5HSVKMCuiekGWAVH37KV0kh+fU=;
        b=JU2AZq0TJXyP6rKypu/1U1PmhVY1+UAjRtgf3FXhHTMuMTUfFHKIMjd4OlJl2sutuh
         u7bh/Gee351D/C+ea5F1THPkshiCR8C+VgbR8fOwF8w3LJ88hxaguPri6lkkRtso0HgI
         0WL1wDAuxppisiqdQN6RjVpocOkQ429rcV/u+dPlnM/KdKg7efYfB16dTHECm3NxB2rZ
         D823t1uY90VLbVqKxwzsIaRisptaQXbkeojViacgXruxQhxDN7e9HMwCVdolZgouMx3t
         1qmHP4LgqmedUTLojokrX4qsyieCIaHaTM3nVxotJUDQDFmBlw6k5ImUz1pYVd/83Frl
         pjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698272882; x=1698877682;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq7lVsLzSLFgeYP3v5HSVKMCuiekGWAVH37KV0kh+fU=;
        b=c2aoPpOyn40M96EDDD4Ig1CQjtDu/WZvknd5ruzf8vVrYkjmIyTcerjcHpRVpbBpwE
         WZPL2+vn9GVWBpuPHj8ePdapvY/SlQTPvWFfAPC1UiPYhQ37PnfpBK33CPYXo0F1Ckp+
         ap6cwZqHxyQTKWS10L9PkeoH1QPKFmbAsJMx+GnvWR8SKbRldArANvOGMs0KlHzPDcKs
         ntPmqOotOnAs94xKsreFNzMcPaHYC6sRBwRqa9gTkuUdmh7l9OIW7Q6x/nnNux9QQ7kf
         luiINPx8lCzUByg2vHdGnkLguBDxKGzSREnqbU2YnFjihTkjLv+28RwUK9DuvvmYVBMr
         CXZA==
X-Gm-Message-State: AOJu0YzZK+uQSnyovrhCwp65yjr7u57/qOVpYLUcBk+dmCqvaOshdTyu
        fzva3whZoEyiepFbP3adQs6cBSAPD48+sPfDsMM=
X-Google-Smtp-Source: AGHT+IH0EY4ZQQ3IuOWR0FLu3gO5qWv28OkOItb2Y/GQUX98xcnyeFrIlzyO0jLvWbQ7sEHxLtgs+w==
X-Received: by 2002:a17:90a:1dd:b0:27d:5d9:a887 with SMTP id 29-20020a17090a01dd00b0027d05d9a887mr15619848pjd.44.1698272881832;
        Wed, 25 Oct 2023 15:28:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090a5d8500b00277832fbf4esm367360pji.16.2023.10.25.15.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 15:28:01 -0700 (PDT)
Message-ID: <65399671.170a0220.bdd20.26a5@mx.google.com>
Date:   Wed, 25 Oct 2023 15:28:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.199
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 168 runs, 1 regressions (v5.10.199)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 168 runs, 1 regressions (v5.10.199)

Regressions Summary
-------------------

platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.199/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.199
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      cb49f0e441ce7db63ef67ccfa9d9562c22f5d6c3 =



Test Regressions
---------------- =



platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/653966117a9004113aefcefe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653966117a9004113aefcf07
        failing since 0 day (last pass: v5.10.148-5-gac0fb49345ee, first fa=
il: v5.10.198-200-ge31b6513c43d)

    2023-10-25T19:01:21.459095  <8>[   24.783966] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3814643_1.5.2.4.1>
    2023-10-25T19:01:21.565768  / # #
    2023-10-25T19:01:21.666861  export SHELL=3D/bin/sh
    2023-10-25T19:01:21.667200  #
    2023-10-25T19:01:21.767958  / # export SHELL=3D/bin/sh. /lava-3814643/e=
nvironment
    2023-10-25T19:01:21.768318  =

    2023-10-25T19:01:21.869091  / # . /lava-3814643/environment/lava-381464=
3/bin/lava-test-runner /lava-3814643/1
    2023-10-25T19:01:21.869654  =

    2023-10-25T19:01:21.874614  / # /lava-3814643/bin/lava-test-runner /lav=
a-3814643/1
    2023-10-25T19:01:21.932745  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
