Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65E8702B9B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 13:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbjEOLiJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 07:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbjEOLgI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 07:36:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107311BC5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:35:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1adc913094aso43919285ad.0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684150500; x=1686742500;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NlcGHmvuBT5iXFwBegodUR+bbbLbIHFO9hMh+yuuppw=;
        b=ttaNWA4dgcGTXTLI9qkUmDyzT3Vb6x/k59uyJEL36vYPJtmadtkt6aIVjHex61cYBr
         ehjZxIDAJzcu4OVH+vUX4Ju5Jgi0mOLALZpyGISoJ8y8+ZLGXSGlpvqTbyG4Fwm93AuO
         Rv51S+JK3zDz1DuzO0td667HiWUYHjwcgP4XQ+RLq9/Qw4j1HybmGZpGmn3EHGD3h+d6
         ZsQFinfNM2WSf27IIclTsFCLkTHrzMrRcqXacdtYxQNabFIismTt7N2SUyIZeG3OlkSX
         wxOAJUg3C/6mbwdcD+/AmhIVwib4gLOLI61CDk4dDeuDFugZwD+OYYIYKYzfaLbtDU/j
         37NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684150500; x=1686742500;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlcGHmvuBT5iXFwBegodUR+bbbLbIHFO9hMh+yuuppw=;
        b=HJE75XMR+Fg1SMXV+mCrXctaINOkaRIMb0meww//rUK2bnlvo1FHHirhUncAJDgR/K
         pV/Gpm6+xIYUkuOGEfpkUNX3A0p1DgGfOJcXAO6jFDB8Jp8FmDQ3M6CEWGWhpD9F6rHF
         cW4dsNX8Ue12Aj4AFzA5NiiEEm+h/WVk/MxGLvq8SFbGIPu0qPvhZBVyWZW9EnmK6KJt
         VBm3Yyq+J/YlVR3pvCTc6B3XsFfxy7P4ExqWWNNxWHZya43ZF0CSqPPMvTOtyw0TmwpL
         9L59PYVodGEGYKWYUyoH9DFwbeMJYf9672wy82o/AQlnt5HopAli1RBsodeDWm1Kr0j/
         Le5Q==
X-Gm-Message-State: AC+VfDyJaqF6ypURZ1DK+o3pwOG6xGoPG6xK2aX1Z90H536e/gz/V+l5
        4SN+68oBU5e923ooLJmVFDFxGboHFgUN0xwAbT7vyQ==
X-Google-Smtp-Source: ACHHUZ5L5gCd0v7DHUUQEzyoD0leo/FJHGVZHFwip8IcHC+XudnRpfs1HVpxbxCAEnwJKKyXj/M66A==
X-Received: by 2002:a17:902:bf47:b0:1aa:ebaa:51ce with SMTP id u7-20020a170902bf4700b001aaebaa51cemr29820592pls.14.1684150499977;
        Mon, 15 May 2023 04:34:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b001ac7794a7eesm13297157plg.288.2023.05.15.04.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 04:34:59 -0700 (PDT)
Message-ID: <646218e3.170a0220.16851.9044@mx.google.com>
Date:   Mon, 15 May 2023 04:34:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-232-g939c18872bf4a
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 177 runs,
 10 regressions (v6.1.28-232-g939c18872bf4a)
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

stable-rc/linux-6.1.y baseline: 177 runs, 10 regressions (v6.1.28-232-g939c=
18872bf4a)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.28-232-g939c18872bf4a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.28-232-g939c18872bf4a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      939c18872bf4a491671925762b7b737e912cfc26 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e27de9053d8dd42e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e27de9053d8dd42e8601
        failing since 45 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T07:42:43.777719  <8>[   10.766859] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10318958_1.4.2.3.1>

    2023-05-15T07:42:43.781148  + set +x

    2023-05-15T07:42:43.885598  / # #

    2023-05-15T07:42:43.986147  export SHELL=3D/bin/sh

    2023-05-15T07:42:43.986352  #

    2023-05-15T07:42:44.086873  / # export SHELL=3D/bin/sh. /lava-10318958/=
environment

    2023-05-15T07:42:44.087093  =


    2023-05-15T07:42:44.187617  / # . /lava-10318958/environment/lava-10318=
958/bin/lava-test-runner /lava-10318958/1

    2023-05-15T07:42:44.187899  =


    2023-05-15T07:42:44.193938  / # /lava-10318958/bin/lava-test-runner /la=
va-10318958/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e278e9053d8dd42e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e278e9053d8dd42e85ed
        failing since 45 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T07:42:37.623020  + set<8>[   11.372149] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10318978_1.4.2.3.1>

    2023-05-15T07:42:37.623166   +x

    2023-05-15T07:42:37.727670  / # #

    2023-05-15T07:42:37.828305  export SHELL=3D/bin/sh

    2023-05-15T07:42:37.828522  #

    2023-05-15T07:42:37.929129  / # export SHELL=3D/bin/sh. /lava-10318978/=
environment

    2023-05-15T07:42:37.929393  =


    2023-05-15T07:42:38.029885  / # . /lava-10318978/environment/lava-10318=
978/bin/lava-test-runner /lava-10318978/1

    2023-05-15T07:42:38.030168  =


    2023-05-15T07:42:38.034703  / # /lava-10318978/bin/lava-test-runner /la=
va-10318978/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e291009a484f402e8610

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e291009a484f402e8615
        failing since 45 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T07:43:03.887759  <8>[   10.504223] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10319016_1.4.2.3.1>

    2023-05-15T07:43:03.891124  + set +x

    2023-05-15T07:43:03.992600  #

    2023-05-15T07:43:03.993818  =


    2023-05-15T07:43:04.095421  / # #export SHELL=3D/bin/sh

    2023-05-15T07:43:04.095589  =


    2023-05-15T07:43:04.196146  / # export SHELL=3D/bin/sh. /lava-10319016/=
environment

    2023-05-15T07:43:04.196379  =


    2023-05-15T07:43:04.296968  / # . /lava-10319016/environment/lava-10319=
016/bin/lava-test-runner /lava-10319016/1

    2023-05-15T07:43:04.297226  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e77a4a58f601252e8610

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e77a4a58f601252e8615
        failing since 45 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T08:03:54.372733  + set +x

    2023-05-15T08:03:54.378959  <8>[   12.382810] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10318988_1.4.2.3.1>

    2023-05-15T08:03:54.484535  / # #

    2023-05-15T08:03:54.586875  export SHELL=3D/bin/sh

    2023-05-15T08:03:54.587107  #

    2023-05-15T08:03:54.687696  / # export SHELL=3D/bin/sh. /lava-10318988/=
environment

    2023-05-15T08:03:54.687933  =


    2023-05-15T08:03:54.788480  / # . /lava-10318988/environment/lava-10318=
988/bin/lava-test-runner /lava-10318988/1

    2023-05-15T08:03:54.788851  =


    2023-05-15T08:03:54.794007  / # /lava-10318988/bin/lava-test-runner /la=
va-10318988/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e26435f106e6bc2e8619

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e26435f106e6bc2e861e
        failing since 45 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T07:42:23.034461  + set +x

    2023-05-15T07:42:23.040945  <8>[   10.297658] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10318963_1.4.2.3.1>

    2023-05-15T07:42:23.142581  #

    2023-05-15T07:42:23.243455  / # #export SHELL=3D/bin/sh

    2023-05-15T07:42:23.243677  =


    2023-05-15T07:42:23.344236  / # export SHELL=3D/bin/sh. /lava-10318963/=
environment

    2023-05-15T07:42:23.344458  =


    2023-05-15T07:42:23.444980  / # . /lava-10318963/environment/lava-10318=
963/bin/lava-test-runner /lava-10318963/1

    2023-05-15T07:42:23.445328  =


    2023-05-15T07:42:23.450622  / # /lava-10318963/bin/lava-test-runner /la=
va-10318963/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e279b633647a122e860b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e279b633647a122e8610
        failing since 45 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T07:42:42.394452  + set<8>[   11.033468] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10319033_1.4.2.3.1>

    2023-05-15T07:42:42.394896   +x

    2023-05-15T07:42:42.503277  / # #

    2023-05-15T07:42:42.605571  export SHELL=3D/bin/sh

    2023-05-15T07:42:42.606310  #

    2023-05-15T07:42:42.707582  / # export SHELL=3D/bin/sh. /lava-10319033/=
environment

    2023-05-15T07:42:42.708280  =


    2023-05-15T07:42:42.809883  / # . /lava-10319033/environment/lava-10319=
033/bin/lava-test-runner /lava-10319033/1

    2023-05-15T07:42:42.811033  =


    2023-05-15T07:42:42.815471  / # /lava-10319033/bin/lava-test-runner /la=
va-10319033/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e25f35f106e6bc2e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e25f35f106e6bc2e85f9
        failing since 45 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-15T07:42:12.479149  <8>[   11.599968] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10318959_1.4.2.3.1>

    2023-05-15T07:42:12.583361  / # #

    2023-05-15T07:42:12.684033  export SHELL=3D/bin/sh

    2023-05-15T07:42:12.684235  #

    2023-05-15T07:42:12.784738  / # export SHELL=3D/bin/sh. /lava-10318959/=
environment

    2023-05-15T07:42:12.784982  =


    2023-05-15T07:42:12.885529  / # . /lava-10318959/environment/lava-10318=
959/bin/lava-test-runner /lava-10318959/1

    2023-05-15T07:42:12.885817  =


    2023-05-15T07:42:12.890696  / # /lava-10318959/bin/lava-test-runner /la=
va-10318959/1

    2023-05-15T07:42:12.897711  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6461e8420fc7e6e0092e8625

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6461e8420fc7e6e0092e8641
        failing since 3 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-15T08:07:02.531596  /lava-10319403/1/../bin/lava-test-case

    2023-05-15T08:07:02.538605  <8>[   22.975942] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e8430fc7e6e0092e86cd
        failing since 3 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-15T08:06:57.034825  + set +x

    2023-05-15T08:06:57.041772  <8>[   17.477407] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10319403_1.5.2.3.1>

    2023-05-15T08:06:57.146082  / # #

    2023-05-15T08:06:57.246597  export SHELL=3D/bin/sh

    2023-05-15T08:06:57.246759  #

    2023-05-15T08:06:57.347215  / # export SHELL=3D/bin/sh. /lava-10319403/=
environment

    2023-05-15T08:06:57.347392  =


    2023-05-15T08:06:57.447856  / # . /lava-10319403/environment/lava-10319=
403/bin/lava-test-runner /lava-10319403/1

    2023-05-15T08:06:57.448157  =


    2023-05-15T08:06:57.453166  / # /lava-10319403/bin/lava-test-runner /la=
va-10319403/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e35e307ba705702e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_=
mips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
232-g939c18872bf4a/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_=
mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6461e35e307ba705702e8=
5e8
        failing since 3 days (last pass: v6.1.27, first fail: v6.1.28) =

 =20
