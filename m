Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D416F08C5
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbjD0Pwb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244064AbjD0Pwb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 11:52:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3AA40CF
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:52:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so7038859b3a.1
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682610747; x=1685202747;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YcufeqbvquNFCxvr1S7CFFCsXy9oGB7399l92dVhjbk=;
        b=q/jrLfvsm8PTcz+12bAPIMVfz+DLUoRf7QYBm/JLECevS0ovap02JYKsvefKc23dXc
         0UEB9PMzLurOUIP+MQUsTmuJv7mpoDges4q2J+1JLApgma77okiCgYk/1LyRP5QGmvQf
         RUyL1wBuoRGT1zqQ3mdqMCEJsVbENhejLaPl0iBjMX/OAnO02Qh2eJrSgL6zpv9FbCrc
         5gLOB88x5D+qgCFNX3+fRTW9PWMMcZWeFBKWuKvyO84ThaK9zQuXfexRxDnfiME0cWdy
         BFxdatrzmhL9ev5MHEEASO/dSVZoUFPMVH3gKz/qd5OT0SS7BJJJQ8ZaiZ9EBpX/eE0R
         7YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682610747; x=1685202747;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcufeqbvquNFCxvr1S7CFFCsXy9oGB7399l92dVhjbk=;
        b=Yn0ldEID6UG6bpyK9LjovKVZ9Eeltfx2ieHK7EUQLB1lHcQ+bSgIBt3IsOm7gqO0HM
         O6qAGyrThMuNMlgeyxkp8S6rZid/3MaIVsdU61hNTmaprtP2O/9ORDDlnA1cmrjCBKvy
         EBwOYD+POt99STMPu/vurnT+DHSd1pr3FuROvqEHBeVGO736PDD9bHpT4/S3tW3yMqN6
         YoMEtU9Ry6F40co0hgmaCDXZy37bp2knJYxJoCCGzJ50g0qVJFt04h5FKBPvpyP2pOrC
         pY5krAxFu0p4byLGO+JnTzl7iEtppNtKbjkzH3Hl0RFvoT1rwqnHum9+1TyxyERnc9h6
         lHpQ==
X-Gm-Message-State: AC+VfDwHbEOKIYAYqTxwXirJZ6PVsBNJbYAMaQMbvZADxnuMKUqdCnqz
        wrRgO5gYf+U/lyn6b57Kc90X4N1Omdg36zQxuSE=
X-Google-Smtp-Source: ACHHUZ7uEYaBIIYPm9al8m4LAcxopEXnfgjM4Nj/otD6UZYtcvH+L7Qj2M2eZyeVmkAoabVTzsCs+g==
X-Received: by 2002:a05:6a00:2da2:b0:63d:4920:c101 with SMTP id fb34-20020a056a002da200b0063d4920c101mr2518333pfb.30.1682610746834;
        Thu, 27 Apr 2023 08:52:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b0063f0c9eadc7sm12719449pfo.200.2023.04.27.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 08:52:26 -0700 (PDT)
Message-ID: <644a9a3a.a70a0220.53690.a74c@mx.google.com>
Date:   Thu, 27 Apr 2023 08:52:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.14
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.311-136-ga32a901a6dcd
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/4.14 baseline: 98 runs,
 1 regressions (v4.14.311-136-ga32a901a6dcd)
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

stable-rc/queue/4.14 baseline: 98 runs, 1 regressions (v4.14.311-136-ga32a9=
01a6dcd)

Regressions Summary
-------------------

platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F4.14/ker=
nel/v4.14.311-136-ga32a901a6dcd/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.14
  Describe: v4.14.311-136-ga32a901a6dcd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a32a901a6dcd252af0b10c6cf332014ed758fd7e =



Test Regressions
---------------- =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/644a7745eb12ff91b12e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.14/v4.14.311=
-136-ga32a901a6dcd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meso=
n8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.14/v4.14.311=
-136-ga32a901a6dcd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meso=
n8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a7745eb12ff91b12e8=
5f4
        failing since 438 days (last pass: v4.14.266-18-g18b83990eba9, firs=
t fail: v4.14.266-28-g7d44cfe0255d) =

 =20
