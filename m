Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9547274E3
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 04:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjFHCSL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 22:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjFHCSK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 22:18:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B62712
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 19:17:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-65299178ac5so30273b3a.1
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 19:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686190661; x=1688782661;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TjsR+Epq0JwvWw34pAutTch+KK2KqDuLEGUZ0Ts833U=;
        b=cBTlY8GWv6pnpdq5KkXg2KVuPDozYP1W6q3joykCGkqfqkz2vkLZ4lz6pm+g+4lVDs
         QI7PgxUMgyLE0r5nKpI+pKRh6BNezOV83gltdwkp5YNKQbiYbaMW6nJH6rxagpS7Lhe5
         b2INi1Rfcp07Blatl/DzEUWOPC/30/k2+DsPhhHUuvemCkHpcW7QNkPzOV8yiIRt5KeU
         Eha3RJaCET7sSZCSS45+BdBmWiTai/HgaAncT3g/8H+rDAtwgIPnfgyuXHNpor8Pgx6a
         VX1x4Lw4YWllDVDJ2NV8+U999IsalRvB7hemvDBX19TN3rvZKKZCheAar/BCQVDy6eTX
         5I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686190661; x=1688782661;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjsR+Epq0JwvWw34pAutTch+KK2KqDuLEGUZ0Ts833U=;
        b=lbRsOiWHsbr829KwX8RNLAI8dncLA74NVmD0oCnXZn/wIQMMwmjVbni6EyQF7QWU68
         uVsWhd1OrLCGG7c7B/inf1+D03wXsHgGJdgroDOZ6YZsO2KnMs6YnM0hGMId+jptRNDZ
         SrsN8gCeaavdsxgmCICW9ap0D2CdMiBtc5DRtjGnWxcGkKkwEuzKjxc/1dwyuOpDYD9o
         i9fvqXHLX3L4wvZvdvOZlmgwqZoQTDrTOGGzafMIpWssr91OgII5S6nl8W0nUonF0BPG
         x6XC2dD9ZpEfzBoz6hsnKZ4KtHDZ/o8gxrKbuBzQ9xR6tyLZXg2NMF88dJ4C8m9dlen1
         +4jg==
X-Gm-Message-State: AC+VfDw3jweUr+r4cb4ussNp6T9KOV38gOWv6FEJlD6Gfhn47FHnKBMe
        S1X/70LJ8y0g7EmgcUfOkFYutdM7yPdxso5Ik0IYiQ==
X-Google-Smtp-Source: ACHHUZ662UIoVTlboAKJffMhnugim0WMmJTKMf3Cw3O3oKJxmONraI2kGvKwcnwi0Xy1UUNeWzc+Zg==
X-Received: by 2002:aa7:88c3:0:b0:64d:5f1d:3d77 with SMTP id k3-20020aa788c3000000b0064d5f1d3d77mr8554790pff.34.1686190661158;
        Wed, 07 Jun 2023 19:17:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b0064d47cd116esm4989pfh.161.2023.06.07.19.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 19:17:40 -0700 (PDT)
Message-ID: <64813a44.620a0220.2192d.0029@mx.google.com>
Date:   Wed, 07 Jun 2023 19:17:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-266-g8f4f686e321c
Subject: stable-rc/linux-6.1.y baseline: 117 runs,
 8 regressions (v6.1.31-266-g8f4f686e321c)
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

stable-rc/linux-6.1.y baseline: 117 runs, 8 regressions (v6.1.31-266-g8f4f6=
86e321c)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.31-266-g8f4f686e321c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.31-266-g8f4f686e321c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8f4f686e321cfb99dd17774b45f93d96a16c2073 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648102be546223dcf9306156

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648102be546223dcf930615b
        failing since 69 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-07T22:20:37.091239  + set +x

    2023-06-07T22:20:37.098121  <8>[    9.999298] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10631213_1.4.2.3.1>

    2023-06-07T22:20:37.199717  #

    2023-06-07T22:20:37.300604  / # #export SHELL=3D/bin/sh

    2023-06-07T22:20:37.300878  =


    2023-06-07T22:20:37.401462  / # export SHELL=3D/bin/sh. /lava-10631213/=
environment

    2023-06-07T22:20:37.401695  =


    2023-06-07T22:20:37.502252  / # . /lava-10631213/environment/lava-10631=
213/bin/lava-test-runner /lava-10631213/1

    2023-06-07T22:20:37.502500  =


    2023-06-07T22:20:37.508860  / # /lava-10631213/bin/lava-test-runner /la=
va-10631213/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6481024694acb3bb0830616c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6481024694acb3bb08306171
        failing since 69 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-07T22:18:39.609658  + <8>[   11.854995] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10631150_1.4.2.3.1>

    2023-06-07T22:18:39.609813  set +x

    2023-06-07T22:18:39.714033  / # #

    2023-06-07T22:18:39.814619  export SHELL=3D/bin/sh

    2023-06-07T22:18:39.814806  #

    2023-06-07T22:18:39.915306  / # export SHELL=3D/bin/sh. /lava-10631150/=
environment

    2023-06-07T22:18:39.915575  =


    2023-06-07T22:18:40.016113  / # . /lava-10631150/environment/lava-10631=
150/bin/lava-test-runner /lava-10631150/1

    2023-06-07T22:18:40.016397  =


    2023-06-07T22:18:40.021272  / # /lava-10631150/bin/lava-test-runner /la=
va-10631150/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6481025052821cfe4a30612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6481025052821cfe4a306133
        failing since 69 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-07T22:18:32.449708  <8>[    8.720263] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10631183_1.4.2.3.1>

    2023-06-07T22:18:32.453067  + set +x

    2023-06-07T22:18:32.554444  =


    2023-06-07T22:18:32.655077  / # #export SHELL=3D/bin/sh

    2023-06-07T22:18:32.655300  =


    2023-06-07T22:18:32.755804  / # export SHELL=3D/bin/sh. /lava-10631183/=
environment

    2023-06-07T22:18:32.755995  =


    2023-06-07T22:18:32.856508  / # . /lava-10631183/environment/lava-10631=
183/bin/lava-test-runner /lava-10631183/1

    2023-06-07T22:18:32.856863  =


    2023-06-07T22:18:32.861958  / # /lava-10631183/bin/lava-test-runner /la=
va-10631183/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648104bbebd46072d6306177

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648104bbebd46072d6306=
178
        new failure (last pass: v6.1.31-40-g7d0a9678d276) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64810234256aa69885306161

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64810234256aa69885306166
        failing since 69 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-07T22:18:26.839353  + set +x

    2023-06-07T22:18:26.846540  <8>[    8.588010] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10631170_1.4.2.3.1>

    2023-06-07T22:18:26.950793  / # #

    2023-06-07T22:18:27.051386  export SHELL=3D/bin/sh

    2023-06-07T22:18:27.051583  #

    2023-06-07T22:18:27.152090  / # export SHELL=3D/bin/sh. /lava-10631170/=
environment

    2023-06-07T22:18:27.152342  =


    2023-06-07T22:18:27.252909  / # . /lava-10631170/environment/lava-10631=
170/bin/lava-test-runner /lava-10631170/1

    2023-06-07T22:18:27.253206  =


    2023-06-07T22:18:27.257682  / # /lava-10631170/bin/lava-test-runner /la=
va-10631170/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6481023a94acb3bb0830613c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6481023a94acb3bb08306141
        failing since 69 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-07T22:18:21.082483  + set +x

    2023-06-07T22:18:21.089215  <8>[   11.029109] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10631198_1.4.2.3.1>

    2023-06-07T22:18:21.192185  =


    2023-06-07T22:18:21.293159  / # #export SHELL=3D/bin/sh

    2023-06-07T22:18:21.293444  =


    2023-06-07T22:18:21.394267  / # export SHELL=3D/bin/sh. /lava-10631198/=
environment

    2023-06-07T22:18:21.394485  =


    2023-06-07T22:18:21.495180  / # . /lava-10631198/environment/lava-10631=
198/bin/lava-test-runner /lava-10631198/1

    2023-06-07T22:18:21.496313  =


    2023-06-07T22:18:21.502002  / # /lava-10631198/bin/lava-test-runner /la=
va-10631198/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6481024fa92d668520306151

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6481024fa92d668520306156
        failing since 69 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-07T22:18:33.945686  + set<8>[   11.298369] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10631142_1.4.2.3.1>

    2023-06-07T22:18:33.945771   +x

    2023-06-07T22:18:34.050575  / # #

    2023-06-07T22:18:34.151137  export SHELL=3D/bin/sh

    2023-06-07T22:18:34.151319  #

    2023-06-07T22:18:34.251815  / # export SHELL=3D/bin/sh. /lava-10631142/=
environment

    2023-06-07T22:18:34.252010  =


    2023-06-07T22:18:34.352491  / # . /lava-10631142/environment/lava-10631=
142/bin/lava-test-runner /lava-10631142/1

    2023-06-07T22:18:34.352818  =


    2023-06-07T22:18:34.357383  / # /lava-10631142/bin/lava-test-runner /la=
va-10631142/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648102420840014aac306140

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
266-g8f4f686e321c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648102420840014aac306145
        failing since 69 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-07T22:18:35.726931  + set<8>[   11.863455] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10631208_1.4.2.3.1>

    2023-06-07T22:18:35.727021   +x

    2023-06-07T22:18:35.831687  / # #

    2023-06-07T22:18:35.932309  export SHELL=3D/bin/sh

    2023-06-07T22:18:35.932534  #

    2023-06-07T22:18:36.033043  / # export SHELL=3D/bin/sh. /lava-10631208/=
environment

    2023-06-07T22:18:36.033251  =


    2023-06-07T22:18:36.133811  / # . /lava-10631208/environment/lava-10631=
208/bin/lava-test-runner /lava-10631208/1

    2023-06-07T22:18:36.134149  =


    2023-06-07T22:18:36.138930  / # /lava-10631208/bin/lava-test-runner /la=
va-10631208/1
 =

    ... (12 line(s) more)  =

 =20
