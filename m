Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CBB70C497
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjEVRq5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjEVRq5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:46:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91221100
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:46:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d15660784so3502484b3a.0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684777613; x=1687369613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HgbsPD4Fw9Ze5p+CxpE6kIJY6FFJAAyIvD2Fg/dQ5I8=;
        b=AG2//8n3KSm0VBDfhgyxpbPfH5qbc+xbOn0vItGDFUmxUBFTb9SpO2DA/47sQg9ZAG
         2oholiscEGVFVRUeUGwNicJU1AhD4SyElOiDt2uF69To6ZSgwx2tj1I+13kZ2/OowkN7
         Do0JNiOwJEJps3mDkcB2ZNmyf5c7FNA/RFTPNcjuPlT7Y4H7iOhTExMfxZmZi/qVLhxi
         rmcBYrim7re79Kwa0uiUhAup+4pi7HccgHP45aCIVX9MoTxQ1BC1HIZ+92ASO0OiT6Rr
         q+RqpN/paM+3Od5eFv5Ba9hHgsnveuJ5HjZht88YFPyJhASrpDx896X+NThFSBkRO/8r
         VwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777613; x=1687369613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgbsPD4Fw9Ze5p+CxpE6kIJY6FFJAAyIvD2Fg/dQ5I8=;
        b=H8BduKV98XUnYxCZ8rWF3j4NAY9B91odCXk86V7n9FW4M65B5PwHbmG/2Qu3mL4ZFL
         dXeDCrYv7g8ShSyn1hpmAZyIXYJ3/KmA42rkRshonEGfHhAJcQPfmvFCCWdiuDkBew1y
         UX356RJFf4iL8b16hYmhYXd9caYSwAZY18aQft9oL9O6JEzKMPRRIVjleZPnr8//hNZu
         bFZAAF4JAI0bu4vj+iEHU3kvwTr/mKuJ88MGRfRZDp0gS3rEINEZN1L2NZ5LGQdfmUFT
         OG0HmV45O60ZmC1yLmNVdwWxzr5wUoInQcEhf9ceGOyLvxmZG0opAgT70JGpQuu5Rti3
         roHg==
X-Gm-Message-State: AC+VfDz7HRMCRs8bzNHhN04wLe3BmP6JLDfa7taXKXkIu8VkDYV6ni+J
        Dd930Uq560dG3gd4eNEjzyNsVvOOVOu3SdQOs0JvJw==
X-Google-Smtp-Source: ACHHUZ6GQRzpeLtG3IjMqekpBbvYYCI6zKeZRa7VVqx+eDHC/v0vKD87d7PyDILjPPPlBP+Uha590A==
X-Received: by 2002:a05:6a20:12c7:b0:10c:1501:3c22 with SMTP id v7-20020a056a2012c700b0010c15013c22mr2182344pzg.29.1684777613376;
        Mon, 22 May 2023 10:46:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r13-20020a17090a940d00b0025352448ba9sm6164001pjo.0.2023.05.22.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 10:46:52 -0700 (PDT)
Message-ID: <646baa8c.170a0220.5c629.a70c@mx.google.com>
Date:   Mon, 22 May 2023 10:46:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-225-g4495ef5b1a4d
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 169 runs,
 12 regressions (v6.1.29-225-g4495ef5b1a4d)
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

stable-rc/queue/6.1 baseline: 169 runs, 12 regressions (v6.1.29-225-g4495ef=
5b1a4d)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-225-g4495ef5b1a4d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-225-g4495ef5b1a4d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4495ef5b1a4dbe20ba73800766d6d7ec316c9736 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646b73a5acafb5185a2e86b0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b73a5acafb5185a2e86b5
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T13:52:29.597689  <8>[    8.109667] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10411009_1.4.2.3.1>

    2023-05-22T13:52:29.601233  + set +x

    2023-05-22T13:52:29.705999  / # #

    2023-05-22T13:52:29.806605  export SHELL=3D/bin/sh

    2023-05-22T13:52:29.806781  #

    2023-05-22T13:52:29.907445  / # export SHELL=3D/bin/sh. /lava-10411009/=
environment

    2023-05-22T13:52:29.907621  =


    2023-05-22T13:52:30.008244  / # . /lava-10411009/environment/lava-10411=
009/bin/lava-test-runner /lava-10411009/1

    2023-05-22T13:52:30.008526  =


    2023-05-22T13:52:30.013347  / # /lava-10411009/bin/lava-test-runner /la=
va-10411009/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646b73a1e9b8710aaa2e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b73a1e9b8710aaa2e8606
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T13:52:28.790509  + <8>[   11.585414] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10410995_1.4.2.3.1>

    2023-05-22T13:52:28.790621  set +x

    2023-05-22T13:52:28.894870  / # #

    2023-05-22T13:52:28.995586  export SHELL=3D/bin/sh

    2023-05-22T13:52:28.995751  #

    2023-05-22T13:52:29.096291  / # export SHELL=3D/bin/sh. /lava-10410995/=
environment

    2023-05-22T13:52:29.096503  =


    2023-05-22T13:52:29.197063  / # . /lava-10410995/environment/lava-10410=
995/bin/lava-test-runner /lava-10410995/1

    2023-05-22T13:52:29.197372  =


    2023-05-22T13:52:29.202013  / # /lava-10410995/bin/lava-test-runner /la=
va-10410995/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646b73a3acafb5185a2e869a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b73a3acafb5185a2e869f
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T13:52:27.259039  <8>[   11.023064] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10410980_1.4.2.3.1>

    2023-05-22T13:52:27.262572  + set +x

    2023-05-22T13:52:27.364191  =


    2023-05-22T13:52:27.464809  / # #export SHELL=3D/bin/sh

    2023-05-22T13:52:27.465002  =


    2023-05-22T13:52:27.565519  / # export SHELL=3D/bin/sh. /lava-10410980/=
environment

    2023-05-22T13:52:27.565729  =


    2023-05-22T13:52:27.666244  / # . /lava-10410980/environment/lava-10410=
980/bin/lava-test-runner /lava-10410980/1

    2023-05-22T13:52:27.666553  =


    2023-05-22T13:52:27.671404  / # /lava-10410980/bin/lava-test-runner /la=
va-10410980/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646b741778d84c9add2e8608

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b741778d84c9add2e860d
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T13:54:16.019630  + set +x

    2023-05-22T13:54:16.026633  <8>[   12.703818] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10410970_1.4.2.3.1>

    2023-05-22T13:54:16.130436  / # #

    2023-05-22T13:54:16.230967  export SHELL=3D/bin/sh

    2023-05-22T13:54:16.231134  #

    2023-05-22T13:54:16.331592  / # export SHELL=3D/bin/sh. /lava-10410970/=
environment

    2023-05-22T13:54:16.331757  =


    2023-05-22T13:54:16.432220  / # . /lava-10410970/environment/lava-10410=
970/bin/lava-test-runner /lava-10410970/1

    2023-05-22T13:54:16.432598  =


    2023-05-22T13:54:16.437083  / # /lava-10410970/bin/lava-test-runner /la=
va-10410970/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646b738e0c419ded7f2e8608

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b738e0c419ded7f2e860d
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T13:51:59.285236  <8>[    9.780213] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10410927_1.4.2.3.1>

    2023-05-22T13:51:59.288529  + set +x

    2023-05-22T13:51:59.390550  #

    2023-05-22T13:51:59.390847  =


    2023-05-22T13:51:59.491419  / # #export SHELL=3D/bin/sh

    2023-05-22T13:51:59.491709  =


    2023-05-22T13:51:59.592344  / # export SHELL=3D/bin/sh. /lava-10410927/=
environment

    2023-05-22T13:51:59.592637  =


    2023-05-22T13:51:59.693304  / # . /lava-10410927/environment/lava-10410=
927/bin/lava-test-runner /lava-10410927/1

    2023-05-22T13:51:59.693763  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646b73b8d4d78ebdbe2e8610

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b73b8d4d78ebdbe2e8615
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T13:52:34.377389  + set +x<8>[   11.147113] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10411001_1.4.2.3.1>

    2023-05-22T13:52:34.377957  =


    2023-05-22T13:52:34.485453  / # #

    2023-05-22T13:52:34.588098  export SHELL=3D/bin/sh

    2023-05-22T13:52:34.588893  #

    2023-05-22T13:52:34.690513  / # export SHELL=3D/bin/sh. /lava-10411001/=
environment

    2023-05-22T13:52:34.691372  =


    2023-05-22T13:52:34.793170  / # . /lava-10411001/environment/lava-10411=
001/bin/lava-test-runner /lava-10411001/1

    2023-05-22T13:52:34.794506  =


    2023-05-22T13:52:34.800047  / # /lava-10411001/bin/lava-test-runner /la=
va-10411001/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646b74f79e78f724132e8613

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b74f79e78f724132e8618
        new failure (last pass: v6.1.29-150-g25825cbc65ca)

    2023-05-22T13:57:51.307893  + set[   14.956216] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 956232_1.5.2.3.1>
    2023-05-22T13:57:51.308040   +x
    2023-05-22T13:57:51.413716  / # #
    2023-05-22T13:57:51.515241  export SHELL=3D/bin/sh
    2023-05-22T13:57:51.515640  #
    2023-05-22T13:57:51.616832  / # export SHELL=3D/bin/sh. /lava-956232/en=
vironment
    2023-05-22T13:57:51.617295  =

    2023-05-22T13:57:51.718584  / # . /lava-956232/environment/lava-956232/=
bin/lava-test-runner /lava-956232/1
    2023-05-22T13:57:51.719151  =

    2023-05-22T13:57:51.722047  / # /lava-956232/bin/lava-test-runner /lava=
-956232/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646b7746b57e298f942e85fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646b7746b57e298f942e8=
5fc
        new failure (last pass: v6.1.29-150-g25825cbc65ca) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646b73a4acafb5185a2e86a5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b73a4acafb5185a2e86aa
        failing since 54 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-22T13:52:16.413070  <8>[   11.095067] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10410979_1.4.2.3.1>

    2023-05-22T13:52:16.517985  / # #

    2023-05-22T13:52:16.618645  export SHELL=3D/bin/sh

    2023-05-22T13:52:16.618849  #

    2023-05-22T13:52:16.719389  / # export SHELL=3D/bin/sh. /lava-10410979/=
environment

    2023-05-22T13:52:16.719614  =


    2023-05-22T13:52:16.820180  / # . /lava-10410979/environment/lava-10410=
979/bin/lava-test-runner /lava-10410979/1

    2023-05-22T13:52:16.820496  =


    2023-05-22T13:52:16.825287  / # /lava-10410979/bin/lava-test-runner /la=
va-10410979/1

    2023-05-22T13:52:16.832027  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646b79d0a610ccb4ef2e85f8

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/646b79d0a610ccb4ef2e8614
        failing since 15 days (last pass: v6.1.22-704-ga3dcd1f09de2, first =
fail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-22T14:18:31.381680  <8>[   22.113614] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-driver-present RESULT=3Dpass>

    2023-05-22T14:18:32.395798  /lava-10411285/1/../bin/lava-test-case

    2023-05-22T14:18:32.405445  <8>[   23.139060] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646b79d0a610ccb4ef2e86a0
        failing since 15 days (last pass: v6.1.22-704-ga3dcd1f09de2, first =
fail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-22T14:18:26.897176  + <8>[   17.634122] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10411285_1.5.2.3.1>

    2023-05-22T14:18:26.900055  set +x

    2023-05-22T14:18:27.005374  / # #

    2023-05-22T14:18:27.106236  export SHELL=3D/bin/sh

    2023-05-22T14:18:27.106498  #

    2023-05-22T14:18:27.207120  / # export SHELL=3D/bin/sh. /lava-10411285/=
environment

    2023-05-22T14:18:27.207373  =


    2023-05-22T14:18:27.308006  / # . /lava-10411285/environment/lava-10411=
285/bin/lava-test-runner /lava-10411285/1

    2023-05-22T14:18:27.308425  =


    2023-05-22T14:18:27.313835  / # /lava-10411285/bin/lava-test-runner /la=
va-10411285/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/646b729e763f3d3b712e860c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-22=
5-g4495ef5b1a4d/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646b729e763f3d3b712e8=
60d
        new failure (last pass: v6.1.29-150-g25825cbc65ca) =

 =20
