Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF946728B50
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 00:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbjFHWwX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjFHWwV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 18:52:21 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70822D5F
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 15:52:18 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-39ab96e6aefso171826b6e.1
        for <stable@vger.kernel.org>; Thu, 08 Jun 2023 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686264738; x=1688856738;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hJKZpoFJ1BdUHNR5OKxu0+S8SLEf8hDSMsH+BCPcWys=;
        b=sYoCpkIJEthW0MtDZ5aNp0VRyEXWM9nlE+8LGuQy+uukkldHsCMCLF/HvIeRmSBr9Y
         FZFVn96tTjvJ8jKkRF04Axb0+rDJqBtQS3AVY3aZFq3fvmbLq5PfxGd1Sqwg+/JZ23Zq
         5pSSv5der4eqCHjHOYMnqw80tCSyEILKPYo5tvgPsfQKKXM7nL9L6HD6Z22Q+5+9qrtK
         Q0kttuxtWa7pT2eEK24gFU989+5UgVepp2AwY4C+dAjfuEHD1l84WDoLpT15ipbhtHHq
         ZbYE15Ft8GJusg7N848NERqO36rK6UB+plkR6PktNoNuODAIjHXH2XBu2sa/54lV3b/h
         CvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686264738; x=1688856738;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJKZpoFJ1BdUHNR5OKxu0+S8SLEf8hDSMsH+BCPcWys=;
        b=Bm2AX9PL+Vef51ZfA7+sOlNv4GxWiv7WL+CYj787dbHrNVI7ZhYgj6vyTJFlHRSlDk
         kyyKbnttcw6P/zxxs0uBfHmohxXTpMW22TggDAlQxmhdSH/Cuwuv/UwkEYoVuCBZw7gs
         Pb73KGammi0zbtlkt0E3Bxz+0hEfpqfcY/XF1LkhtErerWLGYHJr4FxPTly17eOoq9Hs
         ac+JLN2CEmR88WuNlH7+r/n7e95jtrne39qgGGm1ryzaUKC+St5jvW7p5CM8ByPrzCtg
         QyBn+8smcm9dL2S2gbOd3Lav0fyCTA/wxiTTRZpD9HkqZdYTuUz0LkdHMqcvIZgApgdp
         OwBw==
X-Gm-Message-State: AC+VfDxP/SdCy8vV8GNhTHg3wO/QPMcS3ipsFYH5uWclNXz7lvnYfBRp
        wCk6xk5tEfozqN/yOwBJLsXluiZ6ZpBqSvklM+njpA==
X-Google-Smtp-Source: ACHHUZ5cneWvXlhiPVx7DzqpUE24yQum8+tPhlSQ/LmtLI3fZTd+KywcBib0BTECgFp3xk9W1VP4hg==
X-Received: by 2002:a54:418f:0:b0:398:342a:f491 with SMTP id 15-20020a54418f000000b00398342af491mr9134034oiy.34.1686264737405;
        Thu, 08 Jun 2023 15:52:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090a728800b0025929bacd98sm1694566pjg.50.2023.06.08.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 15:52:16 -0700 (PDT)
Message-ID: <64825ba0.170a0220.9c310.3956@mx.google.com>
Date:   Thu, 08 Jun 2023 15:52:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-265-g621717027bee
Subject: stable-rc/linux-6.1.y baseline: 171 runs,
 11 regressions (v6.1.31-265-g621717027bee)
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

stable-rc/linux-6.1.y baseline: 171 runs, 11 regressions (v6.1.31-265-g6217=
17027bee)

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_x86_64-uefi             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.31-265-g621717027bee/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.31-265-g621717027bee
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      621717027bee62901033052db34271ebbc0123f1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64822914af5a733b06306134

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64822914af5a733b06306139
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-08T19:16:24.413595  + set +x

    2023-06-08T19:16:24.419950  <8>[   10.447591] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10645825_1.4.2.3.1>

    2023-06-08T19:16:24.522003  =


    2023-06-08T19:16:24.622626  / # #export SHELL=3D/bin/sh

    2023-06-08T19:16:24.622814  =


    2023-06-08T19:16:24.723280  / # export SHELL=3D/bin/sh. /lava-10645825/=
environment

    2023-06-08T19:16:24.723483  =


    2023-06-08T19:16:24.823953  / # . /lava-10645825/environment/lava-10645=
825/bin/lava-test-runner /lava-10645825/1

    2023-06-08T19:16:24.824215  =


    2023-06-08T19:16:24.829243  / # /lava-10645825/bin/lava-test-runner /la=
va-10645825/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648228f435d00cbc063061ae

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648228f435d00cbc063061b3
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-08T19:16:00.991762  + <8>[   11.157624] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10645769_1.4.2.3.1>

    2023-06-08T19:16:00.991848  set +x

    2023-06-08T19:16:01.096330  / # #

    2023-06-08T19:16:01.196999  export SHELL=3D/bin/sh

    2023-06-08T19:16:01.197152  #

    2023-06-08T19:16:01.297677  / # export SHELL=3D/bin/sh. /lava-10645769/=
environment

    2023-06-08T19:16:01.297826  =


    2023-06-08T19:16:01.398367  / # . /lava-10645769/environment/lava-10645=
769/bin/lava-test-runner /lava-10645769/1

    2023-06-08T19:16:01.398692  =


    2023-06-08T19:16:01.402985  / # /lava-10645769/bin/lava-test-runner /la=
va-10645769/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648228f4c73886632830616e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648228f4c738866328306173
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-08T19:15:57.962024  <8>[   10.957181] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10645779_1.4.2.3.1>

    2023-06-08T19:15:57.965735  + set +x

    2023-06-08T19:15:58.070286  #

    2023-06-08T19:15:58.171791  / # #export SHELL=3D/bin/sh

    2023-06-08T19:15:58.172371  =


    2023-06-08T19:15:58.273446  / # export SHELL=3D/bin/sh. /lava-10645779/=
environment

    2023-06-08T19:15:58.274087  =


    2023-06-08T19:15:58.375527  / # . /lava-10645779/environment/lava-10645=
779/bin/lava-test-runner /lava-10645779/1

    2023-06-08T19:15:58.376626  =


    2023-06-08T19:15:58.381889  / # /lava-10645779/bin/lava-test-runner /la=
va-10645779/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64822a776124bf50af306182

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64822a776124bf50af306=
183
        failing since 0 day (last pass: v6.1.31-40-g7d0a9678d276, first fai=
l: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648228f5a6e7adbe22306178

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648228f5a6e7adbe2230617d
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-08T19:15:51.141972  + set +x

    2023-06-08T19:15:51.148406  <8>[   11.146531] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10645801_1.4.2.3.1>

    2023-06-08T19:15:51.252984  / # #

    2023-06-08T19:15:51.353634  export SHELL=3D/bin/sh

    2023-06-08T19:15:51.353802  #

    2023-06-08T19:15:51.454287  / # export SHELL=3D/bin/sh. /lava-10645801/=
environment

    2023-06-08T19:15:51.454473  =


    2023-06-08T19:15:51.554938  / # . /lava-10645801/environment/lava-10645=
801/bin/lava-test-runner /lava-10645801/1

    2023-06-08T19:15:51.555222  =


    2023-06-08T19:15:51.559565  / # /lava-10645801/bin/lava-test-runner /la=
va-10645801/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648228fe8fbb58325e30614a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648228fe8fbb58325e30614f
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-08T19:15:52.740696  <8>[   10.600428] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10645796_1.4.2.3.1>

    2023-06-08T19:15:52.744234  + set +x

    2023-06-08T19:15:52.849273  #

    2023-06-08T19:15:52.850362  =


    2023-06-08T19:15:52.952518  / # #export SHELL=3D/bin/sh

    2023-06-08T19:15:52.953297  =


    2023-06-08T19:15:53.054661  / # export SHELL=3D/bin/sh. /lava-10645796/=
environment

    2023-06-08T19:15:53.055475  =


    2023-06-08T19:15:53.157054  / # . /lava-10645796/environment/lava-10645=
796/bin/lava-test-runner /lava-10645796/1

    2023-06-08T19:15:53.158175  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64822919461986ba573061ae

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64822919461986ba573061b3
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-08T19:16:15.796634  + set<8>[    8.593668] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10645804_1.4.2.3.1>

    2023-06-08T19:16:15.797211   +x

    2023-06-08T19:16:15.904834  / # #

    2023-06-08T19:16:16.007416  export SHELL=3D/bin/sh

    2023-06-08T19:16:16.008206  #

    2023-06-08T19:16:16.109756  / # export SHELL=3D/bin/sh. /lava-10645804/=
environment

    2023-06-08T19:16:16.110551  =


    2023-06-08T19:16:16.212233  / # . /lava-10645804/environment/lava-10645=
804/bin/lava-test-runner /lava-10645804/1

    2023-06-08T19:16:16.213541  =


    2023-06-08T19:16:16.219020  / # /lava-10645804/bin/lava-test-runner /la=
va-10645804/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648228e09837b30777306145

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648228e09837b3077730614a
        failing since 70 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-08T19:15:37.491956  + set<8>[   11.805794] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10645746_1.4.2.3.1>

    2023-06-08T19:15:37.492040   +x

    2023-06-08T19:15:37.596520  / # #

    2023-06-08T19:15:37.697137  export SHELL=3D/bin/sh

    2023-06-08T19:15:37.697321  #

    2023-06-08T19:15:37.797864  / # export SHELL=3D/bin/sh. /lava-10645746/=
environment

    2023-06-08T19:15:37.798086  =


    2023-06-08T19:15:37.898637  / # . /lava-10645746/environment/lava-10645=
746/bin/lava-test-runner /lava-10645746/1

    2023-06-08T19:15:37.898955  =


    2023-06-08T19:15:37.903377  / # /lava-10645746/bin/lava-test-runner /la=
va-10645746/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/648225a112d5daa19b306160

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/648225a112d5daa19b30617c
        failing since 28 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-08T19:01:53.563218  /lava-10645635/1/../bin/lava-test-case

    2023-06-08T19:01:53.573420  <8>[   22.938460] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648225a212d5daa19b306208
        failing since 28 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-08T19:01:48.152751  + <8>[   17.521744] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10645635_1.5.2.3.1>

    2023-06-08T19:01:48.155822  set +x

    2023-06-08T19:01:48.261553  / # #

    2023-06-08T19:01:48.363927  export SHELL=3D/bin/sh

    2023-06-08T19:01:48.364437  #

    2023-06-08T19:01:48.465629  / # export SHELL=3D/bin/sh. /lava-10645635/=
environment

    2023-06-08T19:01:48.466499  =


    2023-06-08T19:01:48.568020  / # . /lava-10645635/environment/lava-10645=
635/bin/lava-test-runner /lava-10645635/1

    2023-06-08T19:01:48.568288  =


    2023-06-08T19:01:48.573088  / # /lava-10645635/bin/lava-test-runner /la=
va-10645635/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64822463107a05620530614a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qem=
u_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
265-g621717027bee/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qem=
u_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64822463107a056205306=
14b
        new failure (last pass: v6.1.31-266-g8f4f686e321c) =

 =20
