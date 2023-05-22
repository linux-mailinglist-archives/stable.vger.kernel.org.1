Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD470CE90
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 01:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjEVXOS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 19:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjEVXOR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 19:14:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D110C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 16:13:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso2614559b3a.1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 16:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684797238; x=1687389238;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3/y55MaXdTukJQUsuBV9koxo/hY6sHXYgovZKk/TKig=;
        b=E57xb8icouXj11tl8J4kC3wdjrmgF5Uucgm7J0cxgrRfIk7DNW5fhycR1tTbAEBTfp
         3lOaAzrerK5SAtJMxEANIdda6jeEMoWQObaO+q0Jt2pHKGGBAigwtaopD40/QuP4RBti
         rd9U+SikdTj9xcJB2rajv4fX8pwWgyWfQBesg0THlgk2QIj+LRiXdazY93HlL7Zt4SKC
         wvbqoanxYnMIet1a3W616WiBMKn/IwIeO48OQVn67De3d3VVdz2+hiWLfk/rLOCS8w0H
         cuJ1aXaVjnxz6vkOaWcjxTvG/2WuoAH0TxZeJkY/X371csS981lok3DJmKeml5yw/kOg
         VMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684797238; x=1687389238;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/y55MaXdTukJQUsuBV9koxo/hY6sHXYgovZKk/TKig=;
        b=HvlBc5plJXG5ACr2KnuTxiwXWFtba4GZ9n11Mg9rkHWJ29j+a08pHRQth7Jx2gRPqC
         tF17Mp+il1VuCUdcI3cjbDQgHRFTb/6sPNAio4zkfkmAaDwOWqUfD/UiLat38IItLOR/
         UtC1Vz9SGUK82Nu/X3/h7xVaiHpiWB7XIsE6IjhNEAR2elHAjRVnRU10Q+DgtE9D6XFU
         bvITZ74zE/uKKdEBQHH4W9S6fFpD69fIJguKfvtSC2dXi/BW6f0bhZ9oWhHcuDPS2zWy
         MIxKkNKV0VX63dba7bbS/XJFAb4mY98NSkqJoOMNFioL6buQXNuAcoXr8D4Ghc5pbOvc
         WCGA==
X-Gm-Message-State: AC+VfDydfgb4FVkhRB0Y8QnsPftjbMTO8g3UsOkW6gnl1p1q4nhuA7bS
        3adHSgPNm9Q3m7QJ4OFu5SO5blLl9Hsz6eAtniODgg==
X-Google-Smtp-Source: ACHHUZ7WzRDAO4i0pBDmp7i6RrUmN1xyvaIkl+MBsb2wHvAk4vm9yugJTu4znVXudJAEPwEslSEQvw==
X-Received: by 2002:a05:6a20:3c89:b0:10b:6e18:b698 with SMTP id b9-20020a056a203c8900b0010b6e18b698mr6299802pzj.49.1684797238386;
        Mon, 22 May 2023 16:13:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 83-20020a630756000000b0051416609fb7sm4795489pgh.61.2023.05.22.16.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 16:13:57 -0700 (PDT)
Message-ID: <646bf735.630a0220.55e19.8720@mx.google.com>
Date:   Mon, 22 May 2023 16:13:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-150-gf40392d2820f
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 171 runs,
 2 regressions (v5.10.180-150-gf40392d2820f)
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

stable-rc/linux-5.10.y baseline: 171 runs, 2 regressions (v5.10.180-150-gf4=
0392d2820f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.180-150-gf40392d2820f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.180-150-gf40392d2820f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f40392d2820f596c3c14d8d2c456d90eba4c5b99 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bbfa0540050f52c2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-150-gf40392d2820f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-150-gf40392d2820f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bbfa0540050f52c2e85eb
        failing since 54 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-22T19:16:35.038920  + set +x

    2023-05-22T19:16:35.045946  <8>[   15.114906] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10415653_1.4.2.3.1>

    2023-05-22T19:16:35.150626  / # #

    2023-05-22T19:16:35.251331  export SHELL=3D/bin/sh

    2023-05-22T19:16:35.251577  #

    2023-05-22T19:16:35.352157  / # export SHELL=3D/bin/sh. /lava-10415653/=
environment

    2023-05-22T19:16:35.352382  =


    2023-05-22T19:16:35.452969  / # . /lava-10415653/environment/lava-10415=
653/bin/lava-test-runner /lava-10415653/1

    2023-05-22T19:16:35.453274  =


    2023-05-22T19:16:35.458362  / # /lava-10415653/bin/lava-test-runner /la=
va-10415653/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bc3c56dfa575fbf2e8628

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-150-gf40392d2820f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-150-gf40392d2820f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bc3c56dfa575fbf2e862d
        failing since 54 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-22T19:34:11.431617  + set +x

    2023-05-22T19:34:11.438245  <8>[   13.893092] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10415619_1.4.2.3.1>

    2023-05-22T19:34:11.546913  =


    2023-05-22T19:34:11.648762  / # #export SHELL=3D/bin/sh

    2023-05-22T19:34:11.649555  =


    2023-05-22T19:34:11.751066  / # export SHELL=3D/bin/sh. /lava-10415619/=
environment

    2023-05-22T19:34:11.751317  =


    2023-05-22T19:34:11.852170  / # . /lava-10415619/environment/lava-10415=
619/bin/lava-test-runner /lava-10415619/1

    2023-05-22T19:34:11.853435  =


    2023-05-22T19:34:11.858943  / # /lava-10415619/bin/lava-test-runner /la=
va-10415619/1
 =

    ... (12 line(s) more)  =

 =20
