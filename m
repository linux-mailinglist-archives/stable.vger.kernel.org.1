Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111A074917E
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 01:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGEXQd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 19:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGEXQd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 19:16:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8303C19A0
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 16:16:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666683eb028so135552b3a.0
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688598986; x=1691190986;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uotU4jD8OFCSYsuSkLee2vEGtkGUaZZYiFEUI35/t0w=;
        b=LRT2RusFQqN8Fu164VDuoy46bZKFp0/XroU18MG0DM+vp8Tz1vdqloG9NJsybS856I
         pPUwrtsc3NCHiqpjUcZrVoKlUKYosPF5vV3S+daQNKq9MzLZfmLKtqVWZVK2bVH2QDWL
         ibRnM2tGOZ/cnY3eHEBTPm0c4hBzcRHkWtjUBXMS1JcCv3MOL6qO4E0udeefTW6uzGGX
         j4TnncFHf8FqOsDI7QS2K3m2sl70RvxOWUIpMyFpFLofDzMYRiSX3xMIvq0xVdcXmdGI
         1sKGh714+spxVkYPNPiuXrqnD2ufPoY1GSaqEYgfA/B6jItfrjwATICDB4rv4RPco7TR
         HH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688598986; x=1691190986;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uotU4jD8OFCSYsuSkLee2vEGtkGUaZZYiFEUI35/t0w=;
        b=Nkk1xnHhJnku605kdqNsyy42GahYwe1Fd1FY0M37BZHeerrEfc4DbXYRyRzmPrE50x
         di6IY6bRdv9fz1d4ZWpe0a4NumO6NEp4u9Xyle1Cn3urmERRbwTyUneUL2OEsKnsksq6
         9FYO5lpBOMoYs9rAVD2VbTBegszh5R/YFHv275GT7RsAQAR5/YkJEeX81xrYa/x2E01G
         2LeT3u5vLL5Z/sv7U6okDWkoXcXat6LpF3yVUe6BqKIORVFhC3ZQWUqX1ggHjoW/y/yl
         dRBvsaYPt6mR+RZOcZBCY1lONZMYAvOFcKf0SNG6FoKxFNdCwU7UMix1zLarpdCl3Tlc
         zVMg==
X-Gm-Message-State: ABy/qLZkXONQpSLTVTeEk7G017EwGHeTE13hTRi9cfITAWTsyIACZEJd
        aTNTNAUfAFTZEaGJBnaEGV1PU9jlctlbiU9/6R99Xw==
X-Google-Smtp-Source: APBJJlH6QU5+oZhTgbInTlnWyZeRq/GzKUFKD6KgCRk6LiI/I4Cbyzh8veCoooVMW5cRM+UX6Gh1JQ==
X-Received: by 2002:a05:6a20:3c8a:b0:12d:3069:69e1 with SMTP id b10-20020a056a203c8a00b0012d306969e1mr155028pzj.60.1688598986298;
        Wed, 05 Jul 2023 16:16:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001b04c2023e3sm9614plf.218.2023.07.05.16.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 16:16:25 -0700 (PDT)
Message-ID: <64a5f9c9.170a0220.9a824.006a@mx.google.com>
Date:   Wed, 05 Jul 2023 16:16:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.38
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
Subject: stable/linux-6.1.y baseline: 160 runs, 9 regressions (v6.1.38)
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

stable/linux-6.1.y baseline: 160 runs, 9 regressions (v6.1.38)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.38/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.38
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      61fd484b2cf6bc8022e8e5ea6f693a9991740ac2 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c6b34d68b83c69bb2a95

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c6b34d68b83c69bb2a9a
        failing since 97 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-05T19:38:08.853359  + set +x

    2023-07-05T19:38:08.859776  <8>[   10.218205] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11022251_1.4.2.3.1>

    2023-07-05T19:38:08.963874  / # #

    2023-07-05T19:38:09.064502  export SHELL=3D/bin/sh

    2023-07-05T19:38:09.064692  #

    2023-07-05T19:38:09.165191  / # export SHELL=3D/bin/sh. /lava-11022251/=
environment

    2023-07-05T19:38:09.165387  =


    2023-07-05T19:38:09.265935  / # . /lava-11022251/environment/lava-11022=
251/bin/lava-test-runner /lava-11022251/1

    2023-07-05T19:38:09.266256  =


    2023-07-05T19:38:09.271778  / # /lava-11022251/bin/lava-test-runner /la=
va-11022251/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c6a592bf9d6c70bb43bf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c6a592bf9d6c70bb43c4
        failing since 97 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-05T19:37:40.898920  + <8>[   15.603350] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11022193_1.4.2.3.1>

    2023-07-05T19:37:40.899326  set +x

    2023-07-05T19:37:41.006157  / # #

    2023-07-05T19:37:41.108146  export SHELL=3D/bin/sh

    2023-07-05T19:37:41.108847  #

    2023-07-05T19:37:41.210086  / # export SHELL=3D/bin/sh. /lava-11022193/=
environment

    2023-07-05T19:37:41.210718  =


    2023-07-05T19:37:41.312065  / # . /lava-11022193/environment/lava-11022=
193/bin/lava-test-runner /lava-11022193/1

    2023-07-05T19:37:41.313238  =


    2023-07-05T19:37:41.317531  / # /lava-11022193/bin/lava-test-runner /la=
va-11022193/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c6a024c491f54cbb2aa6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c6a024c491f54cbb2aab
        failing since 97 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-05T19:37:47.751860  <8>[   10.656163] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11022182_1.4.2.3.1>

    2023-07-05T19:37:47.754981  + set +x

    2023-07-05T19:37:47.856922  #

    2023-07-05T19:37:47.957709  / # #export SHELL=3D/bin/sh

    2023-07-05T19:37:47.957910  =


    2023-07-05T19:37:48.058487  / # export SHELL=3D/bin/sh. /lava-11022182/=
environment

    2023-07-05T19:37:48.059174  =


    2023-07-05T19:37:48.160565  / # . /lava-11022182/environment/lava-11022=
182/bin/lava-test-runner /lava-11022182/1

    2023-07-05T19:37:48.161742  =


    2023-07-05T19:37:48.166932  / # /lava-11022182/bin/lava-test-runner /la=
va-11022182/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c791c542c420acbb2a88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-14-db0=
003na-grunt.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-14-db0=
003na-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a5c791c542c420acbb2=
a89
        new failure (last pass: v6.1.37) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c8c6a9e8c817f2bb2a82

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c8c6a9e8c817f2bb2a87
        failing since 97 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-05T19:47:10.662998  + set +x

    2023-07-05T19:47:10.669534  <8>[   10.223610] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11022189_1.4.2.3.1>

    2023-07-05T19:47:10.779082  / # #

    2023-07-05T19:47:10.881668  export SHELL=3D/bin/sh

    2023-07-05T19:47:10.882533  #

    2023-07-05T19:47:10.984057  / # export SHELL=3D/bin/sh. /lava-11022189/=
environment

    2023-07-05T19:47:10.984964  =


    2023-07-05T19:47:11.086508  / # . /lava-11022189/environment/lava-11022=
189/bin/lava-test-runner /lava-11022189/1

    2023-07-05T19:47:11.087736  =


    2023-07-05T19:47:11.093182  / # /lava-11022189/bin/lava-test-runner /la=
va-11022189/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c7f55091aef474bb2a89

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c7f55091aef474bb2a8e
        failing since 97 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-05T19:43:30.213624  + set<8>[   10.746647] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11022253_1.4.2.3.1>

    2023-07-05T19:43:30.213715   +x

    2023-07-05T19:43:30.315937  #

    2023-07-05T19:43:30.416842  / # #export SHELL=3D/bin/sh

    2023-07-05T19:43:30.417069  =


    2023-07-05T19:43:30.517636  / # export SHELL=3D/bin/sh. /lava-11022253/=
environment

    2023-07-05T19:43:30.517868  =


    2023-07-05T19:43:30.618718  / # . /lava-11022253/environment/lava-11022=
253/bin/lava-test-runner /lava-11022253/1

    2023-07-05T19:43:30.620192  =


    2023-07-05T19:43:30.625483  / # /lava-11022253/bin/lava-test-runner /la=
va-11022253/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c6a124c491f54cbb2ab1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c6a124c491f54cbb2ab6
        failing since 97 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-05T19:37:49.534825  + <8>[   11.268852] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11022227_1.4.2.3.1>

    2023-07-05T19:37:49.534909  set +x

    2023-07-05T19:37:49.639220  / # #

    2023-07-05T19:37:49.739887  export SHELL=3D/bin/sh

    2023-07-05T19:37:49.740168  #

    2023-07-05T19:37:49.840693  / # export SHELL=3D/bin/sh. /lava-11022227/=
environment

    2023-07-05T19:37:49.840888  =


    2023-07-05T19:37:49.941430  / # . /lava-11022227/environment/lava-11022=
227/bin/lava-test-runner /lava-11022227/1

    2023-07-05T19:37:49.941741  =


    2023-07-05T19:37:49.946344  / # /lava-11022227/bin/lava-test-runner /la=
va-11022227/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c7a1c542c420acbb2a9c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c7a1c542c420acbb2aa1
        failing since 97 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-05T19:42:21.246074  <8>[   11.551417] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11022180_1.4.2.3.1>

    2023-07-05T19:42:21.350625  / # #

    2023-07-05T19:42:21.451437  export SHELL=3D/bin/sh

    2023-07-05T19:42:21.451630  #

    2023-07-05T19:42:21.552135  / # export SHELL=3D/bin/sh. /lava-11022180/=
environment

    2023-07-05T19:42:21.552384  =


    2023-07-05T19:42:21.652929  / # . /lava-11022180/environment/lava-11022=
180/bin/lava-test-runner /lava-11022180/1

    2023-07-05T19:42:21.653256  =


    2023-07-05T19:42:21.658545  / # /lava-11022180/bin/lava-test-runner /la=
va-11022180/1

    2023-07-05T19:42:21.665379  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5bf67bef45463fcbb2a75

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/arm=
/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.38/arm=
/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5bf67bef45463fcbb2a78
        failing since 4 days (last pass: v6.1.34, first fail: v6.1.37)

    2023-07-05T19:07:08.662460  <8>[    8.333263] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3712773_1.5.2.4.1>
    2023-07-05T19:07:08.784530  / # #
    2023-07-05T19:07:08.890484  export SHELL=3D/bin/sh
    2023-07-05T19:07:08.892134  #
    2023-07-05T19:07:08.995641  / # export SHELL=3D/bin/sh. /lava-3712773/e=
nvironment
    2023-07-05T19:07:08.997285  =

    2023-07-05T19:07:09.101011  / # . /lava-3712773/environment/lava-371277=
3/bin/lava-test-runner /lava-3712773/1
    2023-07-05T19:07:09.104041  =

    2023-07-05T19:07:09.112481  / # /lava-3712773/bin/lava-test-runner /lav=
a-3712773/1
    2023-07-05T19:07:09.250927  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
