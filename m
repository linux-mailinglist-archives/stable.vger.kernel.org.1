Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6C7140F9
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 00:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjE1W0L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 18:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjE1W0K (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 18:26:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4AB8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 15:26:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64f47448aeaso1949018b3a.0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685312768; x=1687904768;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ynDFu+2py4Cdi8iUoZfqub20D0Ew4g66WsZdurKiXys=;
        b=uBCM7KjWIOl8ztPJOeCpW2rwOs7U4W1u4vE3P/dArWmfRWzfh80zhGF8gR90TnPOlR
         XDJtOUhYb8GvqmldhC5IjxrX15Zet9dPK5bMkvwlNGDrQalPLXbX+YOqatx6CwgFd6sC
         C179Ge7KXHEIxOcCi6yU9eM9iYU+ECKG06kJdigoou0NRXtNmigg7W2r+4f718Dyuwe8
         /SvPaOKmDlfaL1dFO49fsCdH7vH3qptx0OMUQFs0e4L+rXDHBPbjus27+lPvl/CEwxoN
         DAiWCXutSnOv6UN6BTl5PsZLsxWgyTdhtQO9QLmcWrYtNxe6yGzmpsa/KZO+O50sOTGN
         NJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685312768; x=1687904768;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynDFu+2py4Cdi8iUoZfqub20D0Ew4g66WsZdurKiXys=;
        b=TiyLb0t9QRIQf3pAPSvrsYtEGd2V+XsbO6lCA82CeHvOkW5eoWBNDdqeb5Lxw6nGhA
         +cpkbYe9JLc1NwSTH3EicEXHDgPtXk7eOJHyht502Mf3SpF6Q9MJ3y6FwFlQmTa3xKEf
         o1g+gHVgM00Ub9eatYVDiirClRnekXszVZIr54b3fE74MvC5hlLhqQETT/jILemeJpMy
         i9CVI6EDQiWRuaDkkvVUy/w7/132WxeQEINMnZi+xAFhS7PRQC9Ex4r4CE1JRQ2Hq66X
         TdTVYdV2Kpma8tmFbY69DwpEjjhK6/eCXjdLeXTx55e1OdUFpY+SxaMpqHdzUFTlfLrl
         NHIQ==
X-Gm-Message-State: AC+VfDxQN0HA4gJ4Ha8ZkgPIhBQTwBQBlBd2CEaYDq+OFtmphkrKxX1q
        nwKktSrmzsOPyhBAjzJKhuItM4P3nf+noI1tW7UsOA==
X-Google-Smtp-Source: ACHHUZ5fRvkEZoNipm0yPgXJ7a+xXH8T5XYlI5SpqmyoF1LaJ64kSj4CZ+LwDW12eS1suBq7XWiwVg==
X-Received: by 2002:a05:6a20:9384:b0:10e:a93a:3b with SMTP id x4-20020a056a20938400b0010ea93a003bmr9009006pzh.22.1685312767924;
        Sun, 28 May 2023 15:26:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m9-20020aa78a09000000b00639fc7124c2sm5760610pfa.148.2023.05.28.15.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 15:26:07 -0700 (PDT)
Message-ID: <6473d4ff.a70a0220.9edd2.b44f@mx.google.com>
Date:   Sun, 28 May 2023 15:26:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-273-gd9a33ebea341
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 169 runs,
 7 regressions (v5.15.112-273-gd9a33ebea341)
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

stable-rc/queue/5.15 baseline: 169 runs, 7 regressions (v5.15.112-273-gd9a3=
3ebea341)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-273-gd9a33ebea341/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-273-gd9a33ebea341
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d9a33ebea3414fbb4e1eeaae9fa9d2d08a40d263 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64739e88a7555414fd2e85f8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64739e88a7555414fd2e85fd
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T18:33:21.985165  + set<8>[   11.624696] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10497223_1.4.2.3.1>

    2023-05-28T18:33:21.985764   +x

    2023-05-28T18:33:22.094139  / # #

    2023-05-28T18:33:22.196951  export SHELL=3D/bin/sh

    2023-05-28T18:33:22.197752  #

    2023-05-28T18:33:22.299514  / # export SHELL=3D/bin/sh. /lava-10497223/=
environment

    2023-05-28T18:33:22.300314  =


    2023-05-28T18:33:22.401923  / # . /lava-10497223/environment/lava-10497=
223/bin/lava-test-runner /lava-10497223/1

    2023-05-28T18:33:22.403439  =


    2023-05-28T18:33:22.408839  / # /lava-10497223/bin/lava-test-runner /la=
va-10497223/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64739e765f075e0ecd2e860b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64739e765f075e0ecd2e8610
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T18:33:14.226631  <8>[    8.106645] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10497216_1.4.2.3.1>

    2023-05-28T18:33:14.230117  + set +x

    2023-05-28T18:33:14.335126  #

    2023-05-28T18:33:14.437503  / # #export SHELL=3D/bin/sh

    2023-05-28T18:33:14.438238  =


    2023-05-28T18:33:14.539598  / # export SHELL=3D/bin/sh. /lava-10497216/=
environment

    2023-05-28T18:33:14.540252  =


    2023-05-28T18:33:14.641660  / # . /lava-10497216/environment/lava-10497=
216/bin/lava-test-runner /lava-10497216/1

    2023-05-28T18:33:14.642912  =


    2023-05-28T18:33:14.647577  / # /lava-10497216/bin/lava-test-runner /la=
va-10497216/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473a516cdb8d93a402e85fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6473a516cdb8d93a402e8=
5fd
        failing since 114 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473a07bb58c3a67de2e8614

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473a07bb58c3a67de2e8619
        failing since 131 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-28T18:41:41.112453  <8>[    9.988453] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3627445_1.5.2.4.1>
    2023-05-28T18:41:41.221712  / # #
    2023-05-28T18:41:41.324156  export SHELL=3D/bin/sh
    2023-05-28T18:41:41.325089  #
    2023-05-28T18:41:41.426998  / # export SHELL=3D/bin/sh. /lava-3627445/e=
nvironment
    2023-05-28T18:41:41.427863  =

    2023-05-28T18:41:41.428702  / # . /lava-3627445/environment<3>[   10.27=
3167] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-05-28T18:41:41.530569  /lava-3627445/bin/lava-test-runner /lava-36=
27445/1
    2023-05-28T18:41:41.531563  =

    2023-05-28T18:41:41.536742  / # /lava-3627445/bin/lava-test-runner /lav=
a-3627445/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64739e758c043556a32e8603

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64739e758c043556a32e8608
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T18:33:13.513041  + set +x

    2023-05-28T18:33:13.519395  <8>[   10.693556] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10497219_1.4.2.3.1>

    2023-05-28T18:33:13.624103  / # #

    2023-05-28T18:33:13.724727  export SHELL=3D/bin/sh

    2023-05-28T18:33:13.724896  #

    2023-05-28T18:33:13.825380  / # export SHELL=3D/bin/sh. /lava-10497219/=
environment

    2023-05-28T18:33:13.825573  =


    2023-05-28T18:33:13.926079  / # . /lava-10497219/environment/lava-10497=
219/bin/lava-test-runner /lava-10497219/1

    2023-05-28T18:33:13.926397  =


    2023-05-28T18:33:13.930827  / # /lava-10497219/bin/lava-test-runner /la=
va-10497219/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64739e775f075e0ecd2e8616

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64739e775f075e0ecd2e861b
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T18:33:09.193830  + set<8>[   10.831395] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10497235_1.4.2.3.1>

    2023-05-28T18:33:09.193913   +x

    2023-05-28T18:33:09.295414  #

    2023-05-28T18:33:09.396157  / # #export SHELL=3D/bin/sh

    2023-05-28T18:33:09.396315  =


    2023-05-28T18:33:09.496879  / # export SHELL=3D/bin/sh. /lava-10497235/=
environment

    2023-05-28T18:33:09.497057  =


    2023-05-28T18:33:09.597582  / # . /lava-10497235/environment/lava-10497=
235/bin/lava-test-runner /lava-10497235/1

    2023-05-28T18:33:09.597822  =


    2023-05-28T18:33:09.602724  / # /lava-10497235/bin/lava-test-runner /la=
va-10497235/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64739e768c043556a32e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-gd9a33ebea341/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64739e768c043556a32e8613
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T18:33:17.982526  + set<8>[   11.245636] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10497253_1.4.2.3.1>

    2023-05-28T18:33:17.982605   +x

    2023-05-28T18:33:18.087094  / # #

    2023-05-28T18:33:18.187665  export SHELL=3D/bin/sh

    2023-05-28T18:33:18.187883  #

    2023-05-28T18:33:18.288402  / # export SHELL=3D/bin/sh. /lava-10497253/=
environment

    2023-05-28T18:33:18.288589  =


    2023-05-28T18:33:18.389123  / # . /lava-10497253/environment/lava-10497=
253/bin/lava-test-runner /lava-10497253/1

    2023-05-28T18:33:18.389432  =


    2023-05-28T18:33:18.394389  / # /lava-10497253/bin/lava-test-runner /la=
va-10497253/1
 =

    ... (12 line(s) more)  =

 =20
