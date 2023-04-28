Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0227B6F1A34
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjD1OHz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346077AbjD1OHs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 10:07:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133F246BB
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:07:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b50a02bffso6721b3a.2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682690854; x=1685282854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nWIxKyzPhnerunAWJppve9ldFh7jc36NPnD5UlMekis=;
        b=cYnR1DpLKcWsSrUwUxlhNUg0YJSUilnRWA24KA3olLC/6uFs27d3S4VHscBbD5EGIa
         HO9UtXZ6Lq05eqfpuf5yzGq1USnV/Zj8K2JxWXUNwHrw300U7EwKyZWmE3/OAljrkt1i
         wRDlIutuN840txgqEwZcYyeNJuM5CWTc+dPGHvk7Pl9DxEFNGdNcnWrEeLxuHMkWkVOk
         90XHMY1cqWUjDZ8oxfsDo1XQVQfgggv+IUXPFwuO2brAuZXenbEj0ctNaLWof0alNmZp
         KMtN3/l53hJuwsuxOX+JzrD6Anrnx/ke/vNZGfkb3PFzzQF73gymrS7pGEwtKa5C7nzk
         +GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682690854; x=1685282854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWIxKyzPhnerunAWJppve9ldFh7jc36NPnD5UlMekis=;
        b=CnXHifmzSuAQ7h31ESUwS0Nrq99rYO8DzXb6fxHpKXzYhvzUWZWj5N3pNfqLq92ts9
         rTAb+wAgXbfLa6g4KHCMoqkhSZbpFSWI+E0iyfW1lp+tb0nxphYsitl0aAxepDqSNri+
         OFx9CRTCJnbAoypFO0hI3CpPkfWKz7cxHhhhbcBLD04ykZdXBgF2SvzRSZ0Do+LEDGdO
         Pv2CyZzvhP9bxCRZwUVGmyS/tio70oNZyg1kQp7qFXpawDXfHfe2gcMYuaKsjne/NPXp
         RA/aZfKJA0jeSeNeVbSOL5cBryox+zQl7jyjOPcSebhyQUAzI5U+V1/L9QfMfvzMaPpD
         uB3g==
X-Gm-Message-State: AC+VfDxXkfFLtj6Ebpyix04i2bMer/iOmZZ3uu1AeZ+dfLavRntTJlvd
        wsGKUCecQd98DZyWWwv/RxipYzQqAKTSPxUVSV4=
X-Google-Smtp-Source: ACHHUZ66OL9L53ybKIDQk5TIUQuA7C9O7UuhzPPXN4remJaVKDiSmiS9MGCmZ0sncRgaw67E8G2J2g==
X-Received: by 2002:a05:6a00:1905:b0:63d:408a:e14 with SMTP id y5-20020a056a00190500b0063d408a0e14mr8265894pfi.4.1682690853581;
        Fri, 28 Apr 2023 07:07:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t40-20020a056a0013a800b0063d29df1589sm15288855pfg.136.2023.04.28.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:07:33 -0700 (PDT)
Message-ID: <644bd325.050a0220.5d8a2.f7e6@mx.google.com>
Date:   Fri, 28 Apr 2023 07:07:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-356-gaada006b099b
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 158 runs,
 10 regressions (v5.15.105-356-gaada006b099b)
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

stable-rc/queue/5.15 baseline: 158 runs, 10 regressions (v5.15.105-356-gaad=
a006b099b)

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

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-356-gaada006b099b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-356-gaada006b099b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      aada006b099b75deaa42ce79b523cde10a023a7b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9ecede7c127e252e8617

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9ecede7c127e252e861c
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T10:23:55.081459  <8>[   10.698793] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10149933_1.4.2.3.1>

    2023-04-28T10:23:55.084946  + set +x

    2023-04-28T10:23:55.186149  #

    2023-04-28T10:23:55.286872  / # #export SHELL=3D/bin/sh

    2023-04-28T10:23:55.287040  =


    2023-04-28T10:23:55.387497  / # export SHELL=3D/bin/sh. /lava-10149933/=
environment

    2023-04-28T10:23:55.387698  =


    2023-04-28T10:23:55.488182  / # . /lava-10149933/environment/lava-10149=
933/bin/lava-test-runner /lava-10149933/1

    2023-04-28T10:23:55.488431  =


    2023-04-28T10:23:55.493771  / # /lava-10149933/bin/lava-test-runner /la=
va-10149933/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9ebb4fb81a829c2e862a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9ebb4fb81a829c2e862f
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T10:23:31.188067  + set<8>[   10.891778] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10149986_1.4.2.3.1>

    2023-04-28T10:23:31.188147   +x

    2023-04-28T10:23:31.292749  / # #

    2023-04-28T10:23:31.393410  export SHELL=3D/bin/sh

    2023-04-28T10:23:31.393581  #

    2023-04-28T10:23:31.494081  / # export SHELL=3D/bin/sh. /lava-10149986/=
environment

    2023-04-28T10:23:31.494245  =


    2023-04-28T10:23:31.594706  / # . /lava-10149986/environment/lava-10149=
986/bin/lava-test-runner /lava-10149986/1

    2023-04-28T10:23:31.594952  =


    2023-04-28T10:23:31.599884  / # /lava-10149986/bin/lava-test-runner /la=
va-10149986/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9ecc97cbe361cc2e8619

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9ecc97cbe361cc2e861e
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T10:23:48.822803  <8>[   11.404636] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10150002_1.4.2.3.1>

    2023-04-28T10:23:48.826467  + set +x

    2023-04-28T10:23:48.931299  #

    2023-04-28T10:23:48.932482  =


    2023-04-28T10:23:49.034182  / # #export SHELL=3D/bin/sh

    2023-04-28T10:23:49.034923  =


    2023-04-28T10:23:49.136333  / # export SHELL=3D/bin/sh. /lava-10150002/=
environment

    2023-04-28T10:23:49.137027  =


    2023-04-28T10:23:49.238545  / # . /lava-10150002/environment/lava-10150=
002/bin/lava-test-runner /lava-10150002/1

    2023-04-28T10:23:49.239750  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644b99d3ada19a6ac12e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b99d3ada19a6ac12e8=
5f4
        failing since 83 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9b1a19a11ffcd12e85f7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9b1a19a11ffcd12e85fc
        failing since 101 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-04-28T10:08:11.657554  <8>[    9.994011] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540292_1.5.2.4.1>
    2023-04-28T10:08:11.769191  / # #
    2023-04-28T10:08:11.872983  export SHELL=3D/bin/sh
    2023-04-28T10:08:11.874107  #
    2023-04-28T10:08:11.976283  / # export SHELL=3D/bin/sh. /lava-3540292/e=
nvironment
    2023-04-28T10:08:11.977505  =

    2023-04-28T10:08:12.079895  / # . /lava-3540292/environment/lava-354029=
2/bin/lava-test-runner /lava-3540292/1
    2023-04-28T10:08:12.082003  =

    2023-04-28T10:08:12.082763  / # <3>[   10.352917] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-04-28T10:08:12.086168  /lava-3540292/bin/lava-test-runner /lava-35=
40292/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9e9c355ea026882e861b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9e9c355ea026882e8620
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T10:23:10.504214  + set +x

    2023-04-28T10:23:10.510742  <8>[   10.104079] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10149956_1.4.2.3.1>

    2023-04-28T10:23:10.615007  / # #

    2023-04-28T10:23:10.715667  export SHELL=3D/bin/sh

    2023-04-28T10:23:10.715889  #

    2023-04-28T10:23:10.816437  / # export SHELL=3D/bin/sh. /lava-10149956/=
environment

    2023-04-28T10:23:10.816641  =


    2023-04-28T10:23:10.917183  / # . /lava-10149956/environment/lava-10149=
956/bin/lava-test-runner /lava-10149956/1

    2023-04-28T10:23:10.917507  =


    2023-04-28T10:23:10.922010  / # /lava-10149956/bin/lava-test-runner /la=
va-10149956/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9eb2ab9c3d60522e863b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9eb2ab9c3d60522e8640
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T10:23:31.758922  + set +x

    2023-04-28T10:23:31.765922  <8>[   10.042327] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10149977_1.4.2.3.1>

    2023-04-28T10:23:31.869709  / # #

    2023-04-28T10:23:31.970334  export SHELL=3D/bin/sh

    2023-04-28T10:23:31.970596  #

    2023-04-28T10:23:32.071229  / # export SHELL=3D/bin/sh. /lava-10149977/=
environment

    2023-04-28T10:23:32.071594  =


    2023-04-28T10:23:32.172382  / # . /lava-10149977/environment/lava-10149=
977/bin/lava-test-runner /lava-10149977/1

    2023-04-28T10:23:32.172693  =


    2023-04-28T10:23:32.178733  / # /lava-10149977/bin/lava-test-runner /la=
va-10149977/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9eb84fb81a829c2e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9eb84fb81a829c2e85fc
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T10:23:30.858221  + <8>[   10.829577] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10149934_1.4.2.3.1>

    2023-04-28T10:23:30.858315  set +x

    2023-04-28T10:23:30.962711  / # #

    2023-04-28T10:23:31.063359  export SHELL=3D/bin/sh

    2023-04-28T10:23:31.063604  #

    2023-04-28T10:23:31.164132  / # export SHELL=3D/bin/sh. /lava-10149934/=
environment

    2023-04-28T10:23:31.164313  =


    2023-04-28T10:23:31.264900  / # . /lava-10149934/environment/lava-10149=
934/bin/lava-test-runner /lava-10149934/1

    2023-04-28T10:23:31.265180  =


    2023-04-28T10:23:31.270133  / # /lava-10149934/bin/lava-test-runner /la=
va-10149934/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b9ea5355ea026882e863c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b9ea5355ea026882e8641
        failing since 30 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-04-28T10:23:18.513205  <8>[   11.425436] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10149936_1.4.2.3.1>

    2023-04-28T10:23:18.618057  / # #

    2023-04-28T10:23:18.718783  export SHELL=3D/bin/sh

    2023-04-28T10:23:18.719013  #

    2023-04-28T10:23:18.819582  / # export SHELL=3D/bin/sh. /lava-10149936/=
environment

    2023-04-28T10:23:18.819806  =


    2023-04-28T10:23:18.920338  / # . /lava-10149936/environment/lava-10149=
936/bin/lava-test-runner /lava-10149936/1

    2023-04-28T10:23:18.920678  =


    2023-04-28T10:23:18.925407  / # /lava-10149936/bin/lava-test-runner /la=
va-10149936/1

    2023-04-28T10:23:18.931469  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644b994f3066026d3a2e8627

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-356-gaada006b099b/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b994f3066026d3a2e862c
        failing since 85 days (last pass: v5.15.72-36-g40cafafcdb983, first=
 fail: v5.15.90-215-gdf99871482a0)

    2023-04-28T10:00:22.623344  [   16.039430] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3540230_1.5.2.4.1>
    2023-04-28T10:00:22.727977  =

    2023-04-28T10:00:22.829575  / # #export SHELL=3D/bin/sh
    2023-04-28T10:00:22.830127  =

    2023-04-28T10:00:22.830520  / # [   16.161083] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-04-28T10:00:22.932187  export SHELL=3D/bin/sh. /lava-3540230/envir=
onment
    2023-04-28T10:00:22.932835  =

    2023-04-28T10:00:23.034603  / # . /lava-3540230/environment/lava-354023=
0/bin/lava-test-runner /lava-3540230/1
    2023-04-28T10:00:23.035342  =

    2023-04-28T10:00:23.038726  / # /lava-3540230/bin/lava-test-runner /lav=
a-3540230/1 =

    ... (13 line(s) more)  =

 =20
