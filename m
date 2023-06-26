Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FD573DE5E
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFZMCT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 08:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFZMCS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 08:02:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE61B7
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 05:02:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so1507780b3a.3
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687780934; x=1690372934;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NQpVO/ddypwd4jHJKv9wievVNpTvN3rMSNx5zimN6TI=;
        b=wT+7BUJkaWdaJ7xccLF+Ao1nLNLIWtj/jXtyDXnyFeyh1Z2q5h4JUm7qMoaHwiH+0o
         UmZ5qYyFABugwWhCp1KOMFvHJ/zw+SjrRHGgy5rxp0qyi1xg6QwfTMWHtXrkwx3Rq/tx
         ClkKWkai21k0udJki+n7Hmy+ctPrKASIEyFheo2GuzVhyZ7UQxbmAbnD7KvDsipPBqPE
         D1vjpne3MFKgFVCfc1YPd3hLAcqGJKA87MbpPvqHlRRIuSR2MzcSlAcmHyIBF+qegCLH
         dhbByvbiNDicuO91E6FK2VHjSlFAoXN23dFKbfsIwTF+RWIUptJQTVc6i3QkS6Q8is5p
         yohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687780934; x=1690372934;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQpVO/ddypwd4jHJKv9wievVNpTvN3rMSNx5zimN6TI=;
        b=PNYeUrVKW/VncUXCxK46MRBw9gHQYVOLyYPHpIWGalkWiHO/9mkoXfrHt/UPCI0jIg
         6kD0Lj/81NYA93DjUNCeQCEgZN+f1V5ZWvzAf0TpaVmpC3rRLU8Y8KAFW1zKsg3k/ftr
         gbyEHIrsaY7o6CSd8Rtj5zjOkWspQ5uQdLKJ9OccIaulRcUK06nHu8i71bIXZdjWyWb5
         C4F0uJg1EKfxHQP1TpQiSQ4pW5QerjG0Nihmi9uPMvmZ7xcjsSxKLQ8F3zP3T7NEeyL6
         gIISmGluZ216mWglKbAer/mq6+O+ekLgG3VKwdwRB+UK+66dldVZ8k+gSg1r86iPpbFO
         gsdw==
X-Gm-Message-State: AC+VfDwPvycKz7S3Asn90InNUjOTsBp0R1boFIn5nuTJmasfXKxRyRiR
        gTXxZAdVYVG9RXTGAFU6ohKG0NNCzuyXt3mtXWE=
X-Google-Smtp-Source: ACHHUZ4dKh1/nZMr4CM6vafdtRQF62k9cH7/rPV0HUoMkz9aSEr+ngAhPq1r2K/w8/RWdh1pY7Hu3A==
X-Received: by 2002:a05:6a21:9989:b0:125:7efd:4dbc with SMTP id ve9-20020a056a21998900b001257efd4dbcmr8157136pzb.17.1687780934100;
        Mon, 26 Jun 2023 05:02:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b0063d2dae6247sm1783354pfo.77.2023.06.26.05.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:02:13 -0700 (PDT)
Message-ID: <64997e45.a70a0220.33d92.2e7f@mx.google.com>
Date:   Mon, 26 Jun 2023 05:02:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.9
Subject: stable-rc/linux-6.3.y baseline: 170 runs, 2 regressions (v6.3.9)
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

stable-rc/linux-6.3.y baseline: 170 runs, 2 regressions (v6.3.9)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      00d3ac724541a0661b148b16cf34fac135a4fd53 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/649331c9d1a0144e8f30613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.9/a=
rm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.9/a=
rm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649331c9d1a0144e8f306=
13c
        new failure (last pass: v6.3.8-188-gc4f2a2d855d4a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649335e77abeaeeac7306137

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.9/a=
rm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-=
jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.9/a=
rm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-=
jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
49335e77abeaeeac730613f
        failing since 2 days (last pass: v6.3.8-183-g3a50d9e7217ca, first f=
ail: v6.3.8-187-g6b902997c5c2b)

    2023-06-21T17:39:39.760274  /lava-10848102/1/../bin/lava-test-case

    2023-06-21T17:39:39.770775  <8>[   28.648042] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-probed RESULT=3Dfail>
   =

 =20
