Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61F71403F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 22:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjE1UjX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 16:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE1UjW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 16:39:22 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBAEB8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 13:39:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d341bdedcso1897501b3a.3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685306358; x=1687898358;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VMXtwQOvxUbRLwJJRL1iiRcgdrZXzFHnOE6Tr5cSbag=;
        b=zFBAfED+qWgHeg4Ixkxx3z7I/nqJEAUWv4/YQC0Q62kLApH361iV2VdtV5N1zdwk3B
         djcdLlA4H7J9Dvpb7mnV16a3UWf+mO1POZQaBUj7PdW4xTJPjX874b6jDWCOfQLwXZVP
         osw7prhHJeyk+V54JsVUbJuFNeUIHWIDqbapoAhQ1H4S1e/+ABAyPev/lqAhrwD62zsB
         26wZ88n6hBsTEhidoYHNFoRVRt1V7EPhlZkF1F1S7e8nGHbZZPGaiCBvJ7jc7l5ZGLPm
         idez267TBrlU0ecoxDPpbZ/MArFqR5y+28/2pIzBcPLkDA5FwVAWh4eAVxoRw2D2f8EX
         C5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685306358; x=1687898358;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMXtwQOvxUbRLwJJRL1iiRcgdrZXzFHnOE6Tr5cSbag=;
        b=DZL6tJXLmUyjxbRd4knLDaMhht6Z34HfhYRDM2ohhLhjL9Kou9WAWes+uKAoRNPWrl
         CRc+6zfiADOnA5o6+5+eUuIyIGTGPWwwxwJ4qL/cBeADtyR66oRmobAFxEjATsuoxKuO
         ccMndMcChtZugmG7muW/UX8B9iIm5y0doas75pj7KgEurJkaUyhsgizmXiOL7LrYPu9k
         yIiHw/nGIz94VUVn2vfIcggtfr08/WLvd7gQ8Sb4M0iJErW3/u6oNZWcJsJsmSjU5SoN
         nf4fcWoMxI6ZurkncMkDoeWwGNbYvneygDnCs/YHPeJDnqZyXK/x7uzGX2bBxPc+C7OK
         rAew==
X-Gm-Message-State: AC+VfDxSknvNXhC6uittI2r82NOYG/jvkrALLE8dZ3Wg7KGq8OqQqeCu
        vbjR4f7J3oYPt0fAcquTb4/gcsSeafTYVL5rqKwMjw==
X-Google-Smtp-Source: ACHHUZ4J6MFumpmDHCml8ztsSrxnzo58qQpGkgwGMxR6RSfeCvVqoo40jKV2/x0QF76eyWGCcHS0QA==
X-Received: by 2002:a05:6a20:8f28:b0:105:fd78:cb41 with SMTP id b40-20020a056a208f2800b00105fd78cb41mr7734813pzk.54.1685306358235;
        Sun, 28 May 2023 13:39:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b0064d4d306af9sm4215193pfd.79.2023.05.28.13.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 13:39:17 -0700 (PDT)
Message-ID: <6473bbf5.a70a0220.a44ca.84a9@mx.google.com>
Date:   Sun, 28 May 2023 13:39:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-348-gee55487329644
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 122 runs,
 10 regressions (v6.1.29-348-gee55487329644)
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

stable-rc/queue/6.1 baseline: 122 runs, 10 regressions (v6.1.29-348-gee5548=
7329644)

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

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-348-gee55487329644/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-348-gee55487329644
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ee55487329644ed5b466f9522635074680c15625 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647385e42f0b79f64b2e8625

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647385e42f0b79f64b2e862a
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T16:48:13.005367  <8>[   12.124313] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10496277_1.4.2.3.1>

    2023-05-28T16:48:13.008030  + set +x

    2023-05-28T16:48:13.109329  #

    2023-05-28T16:48:13.109704  =


    2023-05-28T16:48:13.210415  / # #export SHELL=3D/bin/sh

    2023-05-28T16:48:13.210573  =


    2023-05-28T16:48:13.311088  / # export SHELL=3D/bin/sh. /lava-10496277/=
environment

    2023-05-28T16:48:13.311285  =


    2023-05-28T16:48:13.411799  / # . /lava-10496277/environment/lava-10496=
277/bin/lava-test-runner /lava-10496277/1

    2023-05-28T16:48:13.412096  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647385aef7c7a998f72e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647385aef7c7a998f72e85fc
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T16:47:18.731723  + set<8>[   11.138414] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10496284_1.4.2.3.1>

    2023-05-28T16:47:18.732199   +x

    2023-05-28T16:47:18.839666  / # #

    2023-05-28T16:47:18.941896  export SHELL=3D/bin/sh

    2023-05-28T16:47:18.942900  #

    2023-05-28T16:47:19.044451  / # export SHELL=3D/bin/sh. /lava-10496284/=
environment

    2023-05-28T16:47:19.045233  =


    2023-05-28T16:47:19.146801  / # . /lava-10496284/environment/lava-10496=
284/bin/lava-test-runner /lava-10496284/1

    2023-05-28T16:47:19.148233  =


    2023-05-28T16:47:19.153401  / # /lava-10496284/bin/lava-test-runner /la=
va-10496284/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473859878f7d1a6422e8633

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473859878f7d1a6422e8638
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T16:47:00.009632  <8>[   11.415735] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10496250_1.4.2.3.1>

    2023-05-28T16:47:00.012845  + set +x

    2023-05-28T16:47:00.117640  #

    2023-05-28T16:47:00.118958  =


    2023-05-28T16:47:00.220632  / # #export SHELL=3D/bin/sh

    2023-05-28T16:47:00.221296  =


    2023-05-28T16:47:00.322590  / # export SHELL=3D/bin/sh. /lava-10496250/=
environment

    2023-05-28T16:47:00.323497  =


    2023-05-28T16:47:00.425123  / # . /lava-10496250/environment/lava-10496=
250/bin/lava-test-runner /lava-10496250/1

    2023-05-28T16:47:00.426393  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647384f3cef855b9b22e8623

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647384f3cef855b9b22e8=
624
        failing since 38 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647385c963c9c036d12e85ff

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647385c963c9c036d12e8604
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T16:47:52.250258  + set +x

    2023-05-28T16:47:52.256824  <8>[   10.974801] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10496241_1.4.2.3.1>

    2023-05-28T16:47:52.361246  / # #

    2023-05-28T16:47:52.461741  export SHELL=3D/bin/sh

    2023-05-28T16:47:52.461906  #

    2023-05-28T16:47:52.562449  / # export SHELL=3D/bin/sh. /lava-10496241/=
environment

    2023-05-28T16:47:52.562611  =


    2023-05-28T16:47:52.663140  / # . /lava-10496241/environment/lava-10496=
241/bin/lava-test-runner /lava-10496241/1

    2023-05-28T16:47:52.663379  =


    2023-05-28T16:47:52.668219  / # /lava-10496241/bin/lava-test-runner /la=
va-10496241/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473859f19958b73742e8621

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473859f19958b73742e8626
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T16:46:57.994420  <8>[    9.927250] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10496311_1.4.2.3.1>

    2023-05-28T16:46:57.998121  + set +x

    2023-05-28T16:46:58.099327  #

    2023-05-28T16:46:58.099590  =


    2023-05-28T16:46:58.200178  / # #export SHELL=3D/bin/sh

    2023-05-28T16:46:58.200368  =


    2023-05-28T16:46:58.300859  / # export SHELL=3D/bin/sh. /lava-10496311/=
environment

    2023-05-28T16:46:58.301058  =


    2023-05-28T16:46:58.401562  / # . /lava-10496311/environment/lava-10496=
311/bin/lava-test-runner /lava-10496311/1

    2023-05-28T16:46:58.401864  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647385aff7c7a998f72e860d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647385aff7c7a998f72e8612
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T16:47:16.587755  + set<8>[   11.242546] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10496289_1.4.2.3.1>

    2023-05-28T16:47:16.588201   +x

    2023-05-28T16:47:16.696479  / # #

    2023-05-28T16:47:16.798763  export SHELL=3D/bin/sh

    2023-05-28T16:47:16.799604  #

    2023-05-28T16:47:16.901191  / # export SHELL=3D/bin/sh. /lava-10496289/=
environment

    2023-05-28T16:47:16.901951  =


    2023-05-28T16:47:17.003742  / # . /lava-10496289/environment/lava-10496=
289/bin/lava-test-runner /lava-10496289/1

    2023-05-28T16:47:17.004842  =


    2023-05-28T16:47:17.009553  / # /lava-10496289/bin/lava-test-runner /la=
va-10496289/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/647387dba569c728df2e85ea

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-i=
mx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-i=
mx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647387dba569c728df2e85ed
        failing since 0 day (last pass: v6.1.29-330-g5e3e9f8e6af9, first fa=
il: v6.1.29-330-g4ba79a09f3b1)

    2023-05-28T16:56:51.269193  / # #
    2023-05-28T16:56:51.370655  export SHELL=3D/bin/sh
    2023-05-28T16:56:51.371408  #
    2023-05-28T16:56:51.473343  / # export SHELL=3D/bin/sh. /lava-345959/en=
vironment
    2023-05-28T16:56:51.474119  =

    2023-05-28T16:56:51.575925  / # . /lava-345959/environment/lava-345959/=
bin/lava-test-runner /lava-345959/1
    2023-05-28T16:56:51.577191  =

    2023-05-28T16:56:51.596350  / # /lava-345959/bin/lava-test-runner /lava=
-345959/1
    2023-05-28T16:56:51.612500  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-28T16:56:51.646261  + cd /l<8>[   14.500608] <LAVA_SIGNAL_START=
RUN 1_bootrr 345959_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/647=
387dba569c728df2e85fd
        failing since 0 day (last pass: v6.1.29-330-g5e3e9f8e6af9, first fa=
il: v6.1.29-330-g4ba79a09f3b1)

    2023-05-28T16:56:54.002255  /lava-345959/1/../bin/lava-test-case
    2023-05-28T16:56:54.002741  <8>[   16.949822] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-05-28T16:56:54.003166  /lava-345959/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473859b19958b73742e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
8-gee55487329644/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473859b19958b73742e8605
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T16:47:01.674922  <8>[   12.599845] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10496261_1.4.2.3.1>

    2023-05-28T16:47:01.779152  / # #

    2023-05-28T16:47:01.879784  export SHELL=3D/bin/sh

    2023-05-28T16:47:01.879965  #

    2023-05-28T16:47:01.980513  / # export SHELL=3D/bin/sh. /lava-10496261/=
environment

    2023-05-28T16:47:01.981300  =


    2023-05-28T16:47:02.082835  / # . /lava-10496261/environment/lava-10496=
261/bin/lava-test-runner /lava-10496261/1

    2023-05-28T16:47:02.083377  =


    2023-05-28T16:47:02.088443  / # /lava-10496261/bin/lava-test-runner /la=
va-10496261/1

    2023-05-28T16:47:02.095729  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20
