Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C0C7A69AF
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 19:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjISRgw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 13:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjISRgv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 13:36:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1D6A6
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 10:36:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d25b1dbdso467210b3a.2
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 10:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695145003; x=1695749803; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=udI79XIZgUsB4Sls2DGTzZaqgWAdWRop179bCX/Udq4=;
        b=XJ+wzkfU7+4anp7bSz92w+RBsbGAT29A0A1I0F1+8DaTj6IFLouJbbAYfXgCbHPMkc
         Ib3xZ/sPKq67sybmkYNVDUwLpd88D4nRk2t7V7qJeBBwSltCFb9XE3MZ0+MbVqm0LkID
         JiRbkGeRX7AqQK3XKgctYn1ckDyd/4I/iu+c5tdy9soLZ8WU2HEzrgHXZa2tcZJguZ+n
         oO6LlzReqeg6HSD5+zqP6yeybDOOShibFJuYCTUNjil30oNErpLGxhST9PBh9LPxt7dI
         zWdcWGAEEdrSGoHW8tSFGmI8WW2KukCNb2iQ5Msz7q5DhWdiPtWOVodiMZrH451V52Xj
         bNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695145003; x=1695749803;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udI79XIZgUsB4Sls2DGTzZaqgWAdWRop179bCX/Udq4=;
        b=MOxjRk4d/kyQoi6xz5rGYfI23KW0oXWnJpd+ZeVrPK7P/rBpqd1tkTIkj3WTM/PMEy
         Oxun9jd8OMOCdZ9FZTObUfgU//2iISxseH8Gv8s/dSKqqunUJvRJa1bG4PE+D3QEHMa/
         qP01HHX+sjJmStZqoPfr66XOoWT9DLEplTMoRVVjPYeeEmh/VHurDZ8Z+RsVsd57tDhP
         MkphuNirsX450/161+WDTAcUGZtLYVieaiyfJZyojvoNNfs5VBGPbNj+N2juQ1WhrPdQ
         SeaYdZUCjGbqUAPuKf980Bm5m0zx2OuCDVWEewJQ4xvQXheN+nomh3SfZgVSJ/Pc05Xh
         389g==
X-Gm-Message-State: AOJu0YztgqyiShSGgifKTds5eBa1kjEa5DK1yEtLL6ZqdruM5NVyN9QI
        3+G9oHOYdgFup80/6IrGyeAum0hVuZKM1BG2SdPW/A==
X-Google-Smtp-Source: AGHT+IG0xxTst2mmb7Eq7HhgojXUxeJEPJidwKzqF8fcXuLHsan0VajBYkTrgG5/znIj1Cx6FLIEGw==
X-Received: by 2002:a05:6a20:5649:b0:14c:4e31:97f3 with SMTP id is9-20020a056a20564900b0014c4e3197f3mr162411pzc.59.1695145003387;
        Tue, 19 Sep 2023 10:36:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n3-20020a63b443000000b00578b40a4903sm1176352pgu.22.2023.09.19.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:36:42 -0700 (PDT)
Message-ID: <6509dc2a.630a0220.17e06.358e@mx.google.com>
Date:   Tue, 19 Sep 2023 10:36:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v6.1.54
X-Kernelci-Report-Type: test
Subject: stable/linux-6.1.y baseline: 117 runs, 11 regressions (v6.1.54)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y baseline: 117 runs, 11 regressions (v6.1.54)

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

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.54/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.54
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      a356197db198ad9825ce225f19f2c7448ef9eea0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a9df9e993eddce8a0a58

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a9df9e993eddce8a0a61
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T14:01:49.467503  <8>[   10.263211] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571430_1.4.2.3.1>

    2023-09-19T14:01:49.470957  + set +x

    2023-09-19T14:01:49.576051  /#

    2023-09-19T14:01:49.678958   # #export SHELL=3D/bin/sh

    2023-09-19T14:01:49.679736  =


    2023-09-19T14:01:49.781325  / # export SHELL=3D/bin/sh. /lava-11571430/=
environment

    2023-09-19T14:01:49.782106  =


    2023-09-19T14:01:49.883674  / # . /lava-11571430/environment/lava-11571=
430/bin/lava-test-runner /lava-11571430/1

    2023-09-19T14:01:49.884856  =


    2023-09-19T14:01:49.927036  / # /lava-11571430/bin/lava-test-runner /la=
va-11571430/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a9d6c6d837dc408a0a60

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a9d6c6d837dc408a0a69
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T14:01:48.358553  + set<8>[   11.550904] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11571461_1.4.2.3.1>

    2023-09-19T14:01:48.359016   +x

    2023-09-19T14:01:48.465408  / # #

    2023-09-19T14:01:48.567566  export SHELL=3D/bin/sh

    2023-09-19T14:01:48.568297  #

    2023-09-19T14:01:48.669701  / # export SHELL=3D/bin/sh. /lava-11571461/=
environment

    2023-09-19T14:01:48.670345  =


    2023-09-19T14:01:48.771770  / # . /lava-11571461/environment/lava-11571=
461/bin/lava-test-runner /lava-11571461/1

    2023-09-19T14:01:48.772896  =


    2023-09-19T14:01:48.778299  / # /lava-11571461/bin/lava-test-runner /la=
va-11571461/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a9e1c6d837dc408a0a6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a9e1c6d837dc408a0a77
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T14:01:43.059486  <8>[    9.790604] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571433_1.4.2.3.1>

    2023-09-19T14:01:43.062871  + set +x

    2023-09-19T14:01:43.168117  #

    2023-09-19T14:01:43.169404  =


    2023-09-19T14:01:43.271427  / # #export SHELL=3D/bin/sh

    2023-09-19T14:01:43.272230  =


    2023-09-19T14:01:43.373916  / # export SHELL=3D/bin/sh. /lava-11571433/=
environment

    2023-09-19T14:01:43.374796  =


    2023-09-19T14:01:43.476532  / # . /lava-11571433/environment/lava-11571=
433/bin/lava-test-runner /lava-11571433/1

    2023-09-19T14:01:43.477742  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509ab9ecf7b22cade8a0a97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509ab9ecf7b22cade8a0=
a98
        failing since 26 days (last pass: v6.1.46, first fail: v6.1.47) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a9b160d807c6708a0a47

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a9b160d807c6708a0a50
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T14:01:12.112782  + set +x

    2023-09-19T14:01:12.119298  <8>[   10.744890] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571422_1.4.2.3.1>

    2023-09-19T14:01:12.224056  / # #

    2023-09-19T14:01:12.324699  export SHELL=3D/bin/sh

    2023-09-19T14:01:12.324937  #

    2023-09-19T14:01:12.425539  / # export SHELL=3D/bin/sh. /lava-11571422/=
environment

    2023-09-19T14:01:12.425725  =


    2023-09-19T14:01:12.526211  / # . /lava-11571422/environment/lava-11571=
422/bin/lava-test-runner /lava-11571422/1

    2023-09-19T14:01:12.526536  =


    2023-09-19T14:01:12.530993  / # /lava-11571422/bin/lava-test-runner /la=
va-11571422/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a9be9e993eddce8a0a44

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a9be9e993eddce8a0a4d
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T14:01:26.285806  <8>[   10.106854] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571421_1.4.2.3.1>

    2023-09-19T14:01:26.289073  + set +x

    2023-09-19T14:01:26.390216  / #

    2023-09-19T14:01:26.491004  # #export SHELL=3D/bin/sh

    2023-09-19T14:01:26.491214  =


    2023-09-19T14:01:26.591696  / # export SHELL=3D/bin/sh. /lava-11571421/=
environment

    2023-09-19T14:01:26.591893  =


    2023-09-19T14:01:26.692403  / # . /lava-11571421/environment/lava-11571=
421/bin/lava-test-runner /lava-11571421/1

    2023-09-19T14:01:26.692667  =


    2023-09-19T14:01:26.698178  / # /lava-11571421/bin/lava-test-runner /la=
va-11571421/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a9d77fd8d59fed8a0a6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a9d77fd8d59fed8a0a76
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T14:01:50.975894  + set<8>[    8.630304] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11571434_1.4.2.3.1>

    2023-09-19T14:01:50.976312   +x

    2023-09-19T14:01:51.083776  / # #

    2023-09-19T14:01:51.186059  export SHELL=3D/bin/sh

    2023-09-19T14:01:51.186802  #

    2023-09-19T14:01:51.288132  / # export SHELL=3D/bin/sh. /lava-11571434/=
environment

    2023-09-19T14:01:51.288810  =


    2023-09-19T14:01:51.390255  / # . /lava-11571434/environment/lava-11571=
434/bin/lava-test-runner /lava-11571434/1

    2023-09-19T14:01:51.391392  =


    2023-09-19T14:01:51.396989  / # /lava-11571434/bin/lava-test-runner /la=
va-11571434/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a9bc188e30824d8a0a4c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a9bc188e30824d8a0a55
        failing since 172 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-19T14:01:27.576514  + <8>[   11.992405] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11571445_1.4.2.3.1>

    2023-09-19T14:01:27.576597  set +x

    2023-09-19T14:01:27.680702  / # #

    2023-09-19T14:01:27.781266  export SHELL=3D/bin/sh

    2023-09-19T14:01:27.781440  #

    2023-09-19T14:01:27.881972  / # export SHELL=3D/bin/sh. /lava-11571445/=
environment

    2023-09-19T14:01:27.882165  =


    2023-09-19T14:01:27.982762  / # . /lava-11571445/environment/lava-11571=
445/bin/lava-test-runner /lava-11571445/1

    2023-09-19T14:01:27.983058  =


    2023-09-19T14:01:27.987645  / # /lava-11571445/bin/lava-test-runner /la=
va-11571445/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509ab0dc88de5a9fc8a0a57

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509ab0dc88de5a9fc8a0a60
        failing since 61 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-09-19T14:11:19.484068  / # #

    2023-09-19T14:11:19.586254  export SHELL=3D/bin/sh

    2023-09-19T14:11:19.586958  #

    2023-09-19T14:11:19.688345  / # export SHELL=3D/bin/sh. /lava-11571495/=
environment

    2023-09-19T14:11:19.689056  =


    2023-09-19T14:11:19.790395  / # . /lava-11571495/environment/lava-11571=
495/bin/lava-test-runner /lava-11571495/1

    2023-09-19T14:11:19.791498  =


    2023-09-19T14:11:19.807913  / # /lava-11571495/bin/lava-test-runner /la=
va-11571495/1

    2023-09-19T14:11:19.856502  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:11:19.857025  + cd /lav<8>[   19.129100] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11571495_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509ab2d66b523f9878a0a43

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509ab2d66b523f9878a0a4c
        failing since 61 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-09-19T14:09:28.794093  / # #

    2023-09-19T14:09:29.869458  export SHELL=3D/bin/sh

    2023-09-19T14:09:29.870715  #

    2023-09-19T14:09:31.356941  / # export SHELL=3D/bin/sh. /lava-11571508/=
environment

    2023-09-19T14:09:31.358199  =


    2023-09-19T14:09:34.076487  / # . /lava-11571508/environment/lava-11571=
508/bin/lava-test-runner /lava-11571508/1

    2023-09-19T14:09:34.078512  =


    2023-09-19T14:09:34.087584  / # /lava-11571508/bin/lava-test-runner /la=
va-11571508/1

    2023-09-19T14:09:34.146608  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:09:34.147154  + cd /lava-115715<8>[   28.489684] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11571508_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509ab2066330814518a0a72

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.54/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509ab2066330814518a0a7b
        failing since 61 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-09-19T14:11:34.360169  / # #

    2023-09-19T14:11:34.462547  export SHELL=3D/bin/sh

    2023-09-19T14:11:34.463248  #

    2023-09-19T14:11:34.564644  / # export SHELL=3D/bin/sh. /lava-11571504/=
environment

    2023-09-19T14:11:34.565349  =


    2023-09-19T14:11:34.666804  / # . /lava-11571504/environment/lava-11571=
504/bin/lava-test-runner /lava-11571504/1

    2023-09-19T14:11:34.667917  =


    2023-09-19T14:11:34.684359  / # /lava-11571504/bin/lava-test-runner /la=
va-11571504/1

    2023-09-19T14:11:34.749394  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:11:34.749897  + cd /lava-1157150<8>[   18.775392] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11571504_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
