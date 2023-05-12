Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093CA700781
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 14:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbjELMPV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 08:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbjELMPU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 08:15:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832183C39
        for <stable@vger.kernel.org>; Fri, 12 May 2023 05:15:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64ab2a37812so4283911b3a.1
        for <stable@vger.kernel.org>; Fri, 12 May 2023 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683893716; x=1686485716;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XbCNXZ12jh2oEWRUWlk2ltbeIOaqHJGDraUwfF3mMhQ=;
        b=YChc/JnSmD+0fW8Uk3uuGTUkPz5cxYCrO7Oatm00O8u5SQuNH2BwTLxS3PZUQcaZ8M
         rfQqW2DoO+JsWlDIxs5grZzlKGWal6GguEMCGSGD1j3mNBUmlMl2LeYuII9rt8dMCUfm
         nlNALLV17VD8igdrtyj/jMbv0+wyc3R286Qi/75L6AgyVRgKC5wrGYjalUN7SCchIOn+
         dGNN4Jp6Zws2a6UIYdn1jk8Ej7VZt3rXtT/e+9J4qQAfIGM7361+CTgKEm38z9gKIAdg
         ta+xiiJIi643UGRnuzfWigg4l2LSUN6of+onamHyr4IADflxBTfkSJqhChTkVSObjIJI
         ZOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683893716; x=1686485716;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbCNXZ12jh2oEWRUWlk2ltbeIOaqHJGDraUwfF3mMhQ=;
        b=fWW3pYG3Tw45BDa52XJNZwCKveEJjGJvknpyss1dgqWQPnEGJVXUz/kBbhp//NGelB
         4pdzYjgWEyA7+vfhgDeHnH+So3J30XtLyiRKgXHZjZtp4h2hKRshlMXMr/H5ng0yDOvj
         6dW6CDP5jEz1WMciUgnQml+PDqzc7yVdcpkyxaGZeDK8bPRipwFQuK97+dcGjbKGwgML
         ErX3Ka038tj6pNv8DrZGYnmPVlxFmIfTtQ5STdqN6Uapr1AvdB1dJfWc/QxQKmvSyBwP
         ZLdZL6RSR5Wx4RmxGlJu6Wy2tK6NAYtUm1PTIGrRaBcIz9z14/wy7Zb4ulOQFwtQY39W
         tJ8A==
X-Gm-Message-State: AC+VfDw074RcMkl9bHTH+PaSc3kWO01uLVWfUn4SroOJDTvCQ/76XgQo
        HAq3gQcHCJGvqlEcFtq5LgICbzXwSQ7i80duv05Kbw==
X-Google-Smtp-Source: ACHHUZ5Zy2jiQdT7zhroXMXdUVcWauwiTUhtxpGhrr1hJHK8sgTAs6rj+2LioXsSD3rVTJsFoWMj0Q==
X-Received: by 2002:a05:6a20:441c:b0:101:6908:2b03 with SMTP id ce28-20020a056a20441c00b0010169082b03mr14709222pzb.25.1683893716166;
        Fri, 12 May 2023 05:15:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b0063799398eaesm6917403pfi.51.2023.05.12.05.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 05:15:15 -0700 (PDT)
Message-ID: <645e2dd3.a70a0220.153a0.f537@mx.google.com>
Date:   Fri, 12 May 2023 05:15:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-105-gb0c6a42a9d3b
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 184 runs,
 11 regressions (v6.1.28-105-gb0c6a42a9d3b)
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

stable-rc/queue/6.1 baseline: 184 runs, 11 regressions (v6.1.28-105-gb0c6a4=
2a9d3b)

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

at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-105-gb0c6a42a9d3b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-105-gb0c6a42a9d3b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b0c6a42a9d3b3677d80e8d62fccc60c228515431 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645df7af0792c59dc02e85ff

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645df7af0792c59dc02e8604
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T08:23:54.514051  + set +x

    2023-05-12T08:23:54.520599  <8>[   10.286332] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10294421_1.4.2.3.1>

    2023-05-12T08:23:54.622363  =


    2023-05-12T08:23:54.722870  / # #export SHELL=3D/bin/sh

    2023-05-12T08:23:54.723021  =


    2023-05-12T08:23:54.823486  / # export SHELL=3D/bin/sh. /lava-10294421/=
environment

    2023-05-12T08:23:54.823693  =


    2023-05-12T08:23:54.924208  / # . /lava-10294421/environment/lava-10294=
421/bin/lava-test-runner /lava-10294421/1

    2023-05-12T08:23:54.924492  =


    2023-05-12T08:23:54.930376  / # /lava-10294421/bin/lava-test-runner /la=
va-10294421/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645df7ae0792c59dc02e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645df7ae0792c59dc02e85ee
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T08:23:53.073846  + set<8>[   11.691948] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10294456_1.4.2.3.1>

    2023-05-12T08:23:53.074003   +x

    2023-05-12T08:23:53.179253  / # #

    2023-05-12T08:23:53.280194  export SHELL=3D/bin/sh

    2023-05-12T08:23:53.280524  #

    2023-05-12T08:23:53.381202  / # export SHELL=3D/bin/sh. /lava-10294456/=
environment

    2023-05-12T08:23:53.381544  =


    2023-05-12T08:23:53.482232  / # . /lava-10294456/environment/lava-10294=
456/bin/lava-test-runner /lava-10294456/1

    2023-05-12T08:23:53.482718  =


    2023-05-12T08:23:53.487030  / # /lava-10294456/bin/lava-test-runner /la=
va-10294456/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645df7a774583185a72e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645df7a774583185a72e8613
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T08:23:46.406544  <8>[   10.295593] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10294498_1.4.2.3.1>

    2023-05-12T08:23:46.409720  + set +x

    2023-05-12T08:23:46.515130  =


    2023-05-12T08:23:46.616853  / # #export SHELL=3D/bin/sh

    2023-05-12T08:23:46.617681  =


    2023-05-12T08:23:46.719144  / # export SHELL=3D/bin/sh. /lava-10294498/=
environment

    2023-05-12T08:23:46.719910  =


    2023-05-12T08:23:46.821364  / # . /lava-10294498/environment/lava-10294=
498/bin/lava-test-runner /lava-10294498/1

    2023-05-12T08:23:46.822471  =


    2023-05-12T08:23:46.828027  / # /lava-10294498/bin/lava-test-runner /la=
va-10294498/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645df9b361dfd9a82b2e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sa=
ma5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sa=
ma5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645df9b361dfd9a82b2e8=
5ef
        new failure (last pass: v6.1.28-24-g46eeeec704ee) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645dfafbe65cd9fb512e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645dfafbe65cd9fb512e8=
5e7
        failing since 21 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645df8110ec020ae0c2e863d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645df8110ec020ae0c2e8642
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T08:25:37.992226  + set +x

    2023-05-12T08:25:37.998864  <8>[   10.287302] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10294463_1.4.2.3.1>

    2023-05-12T08:25:38.106266  / # #

    2023-05-12T08:25:38.208924  export SHELL=3D/bin/sh

    2023-05-12T08:25:38.209674  #

    2023-05-12T08:25:38.311213  / # export SHELL=3D/bin/sh. /lava-10294463/=
environment

    2023-05-12T08:25:38.311993  =


    2023-05-12T08:25:38.413492  / # . /lava-10294463/environment/lava-10294=
463/bin/lava-test-runner /lava-10294463/1

    2023-05-12T08:25:38.414583  =


    2023-05-12T08:25:38.419133  / # /lava-10294463/bin/lava-test-runner /la=
va-10294463/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645df7979842eaba0a2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645df7979842eaba0a2e85eb
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T08:23:34.413328  + set +x

    2023-05-12T08:23:34.419757  <8>[    9.974402] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10294419_1.4.2.3.1>

    2023-05-12T08:23:34.524240  / # #

    2023-05-12T08:23:34.624879  export SHELL=3D/bin/sh

    2023-05-12T08:23:34.625114  #

    2023-05-12T08:23:34.725683  / # export SHELL=3D/bin/sh. /lava-10294419/=
environment

    2023-05-12T08:23:34.725921  =


    2023-05-12T08:23:34.826477  / # . /lava-10294419/environment/lava-10294=
419/bin/lava-test-runner /lava-10294419/1

    2023-05-12T08:23:34.826757  =


    2023-05-12T08:23:34.831432  / # /lava-10294419/bin/lava-test-runner /la=
va-10294419/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645df7b201860efede2e860b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645df7b201860efede2e8610
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T08:23:59.020230  + set<8>[   10.655805] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10294490_1.4.2.3.1>

    2023-05-12T08:23:59.020322   +x

    2023-05-12T08:23:59.124919  / # #

    2023-05-12T08:23:59.225569  export SHELL=3D/bin/sh

    2023-05-12T08:23:59.225775  #

    2023-05-12T08:23:59.326324  / # export SHELL=3D/bin/sh. /lava-10294490/=
environment

    2023-05-12T08:23:59.326518  =


    2023-05-12T08:23:59.426983  / # . /lava-10294490/environment/lava-10294=
490/bin/lava-test-runner /lava-10294490/1

    2023-05-12T08:23:59.427231  =


    2023-05-12T08:23:59.431976  / # /lava-10294490/bin/lava-test-runner /la=
va-10294490/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645df7b2ec83211cbc2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645df7b2ec83211cbc2e85ec
        failing since 44 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-12T08:23:58.203856  + <8>[   12.016869] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10294472_1.4.2.3.1>

    2023-05-12T08:23:58.203946  set +x

    2023-05-12T08:23:58.307920  / # #

    2023-05-12T08:23:58.408538  export SHELL=3D/bin/sh

    2023-05-12T08:23:58.408734  #

    2023-05-12T08:23:58.509323  / # export SHELL=3D/bin/sh. /lava-10294472/=
environment

    2023-05-12T08:23:58.509557  =


    2023-05-12T08:23:58.610137  / # . /lava-10294472/environment/lava-10294=
472/bin/lava-test-runner /lava-10294472/1

    2023-05-12T08:23:58.610443  =


    2023-05-12T08:23:58.615396  / # /lava-10294472/bin/lava-test-runner /la=
va-10294472/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645dfc9e44a9bf4a632e85f4

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-10=
5-gb0c6a42a9d3b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645dfc9f44a9bf4a632e8610
        failing since 5 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-12T08:44:52.503371  /lava-10295238/1/../bin/lava-test-case

    2023-05-12T08:44:52.513281  <8>[   23.027371] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645dfc9f44a9bf4a632e869c
        failing since 5 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-12T08:44:47.046668  + set +x<8>[   17.565508] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10295238_1.5.2.3.1>

    2023-05-12T08:44:47.050052  =


    2023-05-12T08:44:47.155822  / # #

    2023-05-12T08:44:47.256880  export SHELL=3D/bin/sh

    2023-05-12T08:44:47.257219  #

    2023-05-12T08:44:47.358073  / # export SHELL=3D/bin/sh. /lava-10295238/=
environment

    2023-05-12T08:44:47.358304  =


    2023-05-12T08:44:47.458885  / # . /lava-10295238/environment/lava-10295=
238/bin/lava-test-runner /lava-10295238/1

    2023-05-12T08:44:47.459224  =


    2023-05-12T08:44:47.464037  / # /lava-10295238/bin/lava-test-runner /la=
va-10295238/1
 =

    ... (13 line(s) more)  =

 =20
