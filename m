Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9037201E9
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 14:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbjFBMUp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 08:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjFBMUi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 08:20:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E7D1B8
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 05:20:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-256422ad25dso916341a91.0
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 05:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685708424; x=1688300424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E3z4yYu5MQKmObl/1RnZjuhuMALza0z7XMPaboPf+Os=;
        b=zDQgr6/5DXcYOmK+yjVn0EH7gfsg5trfeAEgBycU9hKUcIBcsfASFJLKWJ53GDjqVY
         /OYRH7slLn8Qf+PX4mGpdFs3RvMSDwpCuuM0HbHrCtUoDdBufDemIUqt7qAGQetzrMa6
         SPQnFOXbZdTvjxUbtfN3ZmCyd0I6xMVybzlaCY3tli5uDCmxR54bltmmXsybh8212Dhy
         Ei0rZD/1Mr/ygJk/OM7bUXmm1WfQYPRSV8Rvaq+/Yv6OQ94jv2dnKxdOc73Bm7gqeDoC
         5D8MTUXR4uk4P4PqdBR5FEO4lRm52fB355d+UwcFkJ0mT90ozS1gAkNy/gfHLZRnup26
         61hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685708424; x=1688300424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3z4yYu5MQKmObl/1RnZjuhuMALza0z7XMPaboPf+Os=;
        b=CTtwPwLcY61OoHYbfJKE/iNMY/1eGnpd/En+MG4+zJNj6y5Hii3pnEpMCTHtP5kn5K
         gm3d2dDvEpHjIlI2MYnowoWtmf9G6/Fn4U7WsqZairsP6gvyoJnUHXAo/9d2luAOal6V
         Hh7UxLR/HkyjshtFP6e8aQmfj4n/jvomVIj5HKOywAlHDbBxVOkKMcOTTW13pcGb3ATY
         1x17siRRiUq1aEAiv9cwi8w1zut5FEFyAjTUdk5E0DARsZw9zaYtiRDnXrW/3ysHacXL
         WKiT5GW6A54zhrDHT+y5U1FXOTuV5r8uPML47kUzdT7/1QcIKRD8P1+HXAiAAASNqYjc
         h0gQ==
X-Gm-Message-State: AC+VfDz/lWGKQiPNLDxd+RMIKHmkjyk8PJbEx9mHQ6dU9xovuYgiTFVK
        8JyScETBC4c0kmZTesqGpKNBcZMhdLk/ubNxpayMgg==
X-Google-Smtp-Source: ACHHUZ6+I4U2HWxkw0k6olcWxTwQuaT7dj6VCiAhnl2r05zcTb8isQycgdcbvxfeNrYiUbzmxGGgog==
X-Received: by 2002:a17:90b:128f:b0:256:8825:d48f with SMTP id fw15-20020a17090b128f00b002568825d48fmr999970pjb.29.1685708423715;
        Fri, 02 Jun 2023 05:20:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e63-20020a17090a6fc500b0024de5227d1fsm1174134pjk.40.2023.06.02.05.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 05:20:23 -0700 (PDT)
Message-ID: <6479de87.170a0220.aea85.1e76@mx.google.com>
Date:   Fri, 02 Jun 2023 05:20:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.5-46-gb8c049753f7c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.3.y baseline: 176 runs,
 2 regressions (v6.3.5-46-gb8c049753f7c)
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

stable-rc/linux-6.3.y baseline: 176 runs, 2 regressions (v6.3.5-46-gb8c0497=
53f7c)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
imx8mm-innocomm-wb15-evk     | arm64 | lab-pengutronix | gcc-10   | defconf=
ig                  | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora   | gcc-10   | defconf=
ig+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.5-46-gb8c049753f7c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.5-46-gb8c049753f7c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b8c049753f7cf6804abcd8bbd0abf46baf4bff5e =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
imx8mm-innocomm-wb15-evk     | arm64 | lab-pengutronix | gcc-10   | defconf=
ig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6479a6984981e920a6f5de2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5-4=
6-gb8c049753f7c/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-inno=
comm-wb15-evk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5-4=
6-gb8c049753f7c/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-inno=
comm-wb15-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6479a6984981e920a6f5d=
e2d
        new failure (last pass: v6.3.5) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora   | gcc-10   | defconf=
ig+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479add855a19e1f08f5df22

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5-4=
6-gb8c049753f7c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5-4=
6-gb8c049753f7c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
479add855a19e1f08f5df3f
        new failure (last pass: v6.3.5)

    2023-06-02T08:52:21.651652  /lava-10561393/1/../bin/lava-test-case

    2023-06-02T08:52:21.658260  <8>[   28.516314] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-probed RESULT=3Dfail>
   =

 =20
