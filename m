Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77B9716F8D
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 23:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjE3VSU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjE3VSU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 17:18:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441CC9
        for <stable@vger.kernel.org>; Tue, 30 May 2023 14:18:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-256c8bed212so730328a91.3
        for <stable@vger.kernel.org>; Tue, 30 May 2023 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685481498; x=1688073498;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6f85UGWaITtsnGA7nWJFTjDLK2ByydYOfBigNyjV5Os=;
        b=X4+rkgwyHlki6nNqsurzLvF5tC4DKaiwfA/xVvEl/xtXIvYJKiLDYOw4VAQuGXcpud
         uKMucLmQXDDRgJTwIEtCmRBabmo1jjfvB9aGHSg3pO4cPQqMYFVSnJ1OwgpQpsl8Mkv2
         8wo3YRQCCwHBdtQ9UNrWKP4VbSf7TKrYjktjjQJcY8rQWHOlA5uBhGF1UNIQh3WIPRyP
         PtZV9CSt42W5yO3xwogqemcwgkI5+K3mL6it6Qx1VcomyvDBfRaoLCMmgLkU0QuFPR39
         EWQkYY477ZhfF2dmz7rfq5Ygy1nbRg5J3Rw3n9QBO0zW77vN5sUehDtz9kBzqJZlZnWb
         a8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685481498; x=1688073498;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6f85UGWaITtsnGA7nWJFTjDLK2ByydYOfBigNyjV5Os=;
        b=PYvDHuYmwxACDIESWiBb064CDgU3m620ZSRZBPmpHVpJqgnWtyIQTMYUSBJpHpHMU3
         zi1CMg+X660Z3islcS04knDXKNi+HDu05eDRilcSBtcKwNYIoMNE1BJJG6CkPsLbnCdo
         lttDyXPN2Rf6uXpXh7tITJKAqc/HiQNqtsZZW2WI38d9fkfmapYgRRyXErsU5G+pSqqr
         Jn9toT9XPN4ii/ZAZ2qanql7HVLTSl//Y7+3eB6PY88NX6L8l48NAPHyK48coYbb+ZZ3
         gFxrXGskv2RsXyeQahrJrN1UfdN0vUsNSCgfGSTwWr6rFNIgT6CtsBpUSePE5Hh923NZ
         5jbA==
X-Gm-Message-State: AC+VfDyWhEAPXi1u6I7nc3yGYr0Xtt8HsIU8dhNnedukp5ksdb7tbeby
        7dalSJyav/cdzf+ZZx7ZpS+UOdykPibOYwGo7a3goQ==
X-Google-Smtp-Source: ACHHUZ4VQLoPdqb4WoXoRZejeLLGq3XG2NeaCEBnqE4y3JYpttE2bHQBFAXtOzR8n4+5iZWcw7Z0zg==
X-Received: by 2002:a17:90b:3145:b0:256:c324:7ae4 with SMTP id ip5-20020a17090b314500b00256c3247ae4mr3163022pjb.16.1685481498211;
        Tue, 30 May 2023 14:18:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090ae68600b0024e07ae2cfesm9177626pjy.38.2023.05.30.14.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:18:17 -0700 (PDT)
Message-ID: <64766819.170a0220.7d8a0.104d@mx.google.com>
Date:   Tue, 30 May 2023 14:18:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.3
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.3.5-41-g8b53689a0fb0
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.3 baseline: 166 runs,
 2 regressions (v6.3.5-41-g8b53689a0fb0)
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

stable-rc/queue/6.3 baseline: 166 runs, 2 regressions (v6.3.5-41-g8b53689a0=
fb0)

Regressions Summary
-------------------

platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
at91sam9g20ek                | arm  | lab-broonie  | gcc-10   | multi_v5_de=
fconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre | gcc-10   | sunxi_defco=
nfig    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.3/kern=
el/v6.3.5-41-g8b53689a0fb0/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.3
  Describe: v6.3.5-41-g8b53689a0fb0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8b53689a0fb0a0ab0181a879c52c3577f6585ee8 =



Test Regressions
---------------- =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
at91sam9g20ek                | arm  | lab-broonie  | gcc-10   | multi_v5_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/647634d04a45a7a0ce2e8627

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
g8b53689a0fb0/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g2=
0ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
g8b53689a0fb0/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g2=
0ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647634d04a45a7a0ce2e8=
628
        new failure (last pass: v6.3.3-491-gda6d197f2db4) =

 =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre | gcc-10   | sunxi_defco=
nfig    | 1          =


  Details:     https://kernelci.org/test/plan/id/647633cac3316a7bc52e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
g8b53689a0fb0/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-lib=
retech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
g8b53689a0fb0/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-lib=
retech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647633cac3316a7bc52e85eb
        new failure (last pass: v6.3.3-491-gda6d197f2db4)

    2023-05-30T17:34:44.818924  <8>[   10.029051] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3631939_1.5.2.4.1>
    2023-05-30T17:34:44.924515  / # #
    2023-05-30T17:34:45.026526  export SHELL=3D/bin/sh
    2023-05-30T17:34:45.027055  #
    2023-05-30T17:34:45.128480  / # export SHELL=3D/bin/sh. /lava-3631939/e=
nvironment
    2023-05-30T17:34:45.129031  =

    2023-05-30T17:34:45.230448  / # . /lava-3631939/environment/lava-363193=
9/bin/lava-test-runner /lava-3631939/1
    2023-05-30T17:34:45.231255  =

    2023-05-30T17:34:45.235092  / # /lava-3631939/bin/lava-test-runner /lav=
a-3631939/1
    2023-05-30T17:34:45.380948  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
