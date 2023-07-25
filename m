Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1B7626BF
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 00:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGYWad (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 18:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjGYW2N (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 18:28:13 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61297AA2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 15:21:39 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bbc87ded50so3725895ad.1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690323556; x=1690928356;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0V2isj0bxas+egfqQlMB26Q/0Z8kZwuTGh6gi5/WIW0=;
        b=LnDWYO7iVQ8IdeyQgwALp3YIajsefdiIDdi3xRaQk+PNxe43scppNPq3Q6ztloMPNd
         1aQj7uBPMHo5ckWfYNm146a3ZqFSzqqxGHPgIFqOEsblMNQg6mmMLAPjjSaPcvWthuDb
         R5JXfHLyqwn9yVffJd8w6vEOxTQgzjBJEPvuND8QoM7awsl6vZm05+6TdOay7vKzGPZ+
         8bVy3EFgwfxfwrLporRj0/2mGK2VWVqXzq4FYAFpoQ28Z2PgHtUGzS8H9HYxKMcin6Rl
         ea8Fcgo2RW8esglUxs3TwH5iuPE9Ce7c68ND9R9Kb1swaN83YBnGPSJDQL5+Uc2XXF2j
         +U8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690323556; x=1690928356;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0V2isj0bxas+egfqQlMB26Q/0Z8kZwuTGh6gi5/WIW0=;
        b=OqEwWmQfyoWe+cCJAjhnm9zmXQA0KYcDHdqp3SCDtlM9qr7xatR1mj56QJaKYLHCwp
         1dUW9th9EDNP6O4JpWXuNGh7PZHwUo/TBCZD6O6ryx727ojHh8/XpH8qD8nUljDyRYEG
         g8ucqwe51Pg58tW3dWdHGj/rnr2peLIJ6gHdzJwoKQNFaFkBd5zEC5XD/a6InenGqFuz
         gyKdIQhALCKwuEfhtoyjkoB4OCUXQNE1Q5ok3nQxbvOVoCT7axPmrYPZk0+jYUkPttK+
         FNmWUdklp2f8CrFKTYu3Zqbjw/C5JeMP+c5TyuisuTBK6DZiwbwiHccFu+EpNEdJo33G
         g2bw==
X-Gm-Message-State: ABy/qLb3oEM/7UedxDCOw0Qute95AOclghVIKflfVupGg7ofJIyGXx86
        vQSh7PjIyDnou7EGVr6JQF7JS0NxOFNxzmVxZLauJg==
X-Google-Smtp-Source: APBJJlFCB3FK8FUzCfKMapWPFz5xnlFsoE6ssLT8iO+FNbO51VmrNfgLMYZ8B1kebZkJKejDx5MjDw==
X-Received: by 2002:a17:902:e88f:b0:1bb:b226:52a0 with SMTP id w15-20020a170902e88f00b001bbb22652a0mr517494plg.44.1690323555883;
        Tue, 25 Jul 2023 15:19:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902b48100b001b86492d724sm11582208plr.223.2023.07.25.15.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:19:15 -0700 (PDT)
Message-ID: <64c04a63.170a0220.f7db0.5d18@mx.google.com>
Date:   Tue, 25 Jul 2023 15:19:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.41-184-gb3f8a9d2b1371
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 126 runs,
 11 regressions (v6.1.41-184-gb3f8a9d2b1371)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 126 runs, 11 regressions (v6.1.41-184-gb3f8=
a9d2b1371)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.41-184-gb3f8a9d2b1371/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.41-184-gb3f8a9d2b1371
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b3f8a9d2b13712777c36667183b782dd7efa5039 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c01791bf8bd496068ace1c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c01792bf8bd496068ace21
        failing since 117 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-25T18:42:10.112426  <8>[    7.959875] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11138314_1.4.2.3.1>

    2023-07-25T18:42:10.115391  + set +x

    2023-07-25T18:42:10.216672  #

    2023-07-25T18:42:10.317569  / # #export SHELL=3D/bin/sh

    2023-07-25T18:42:10.317845  =


    2023-07-25T18:42:10.418380  / # export SHELL=3D/bin/sh. /lava-11138314/=
environment

    2023-07-25T18:42:10.418631  =


    2023-07-25T18:42:10.519148  / # . /lava-11138314/environment/lava-11138=
314/bin/lava-test-runner /lava-11138314/1

    2023-07-25T18:42:10.519546  =


    2023-07-25T18:42:10.525230  / # /lava-11138314/bin/lava-test-runner /la=
va-11138314/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0179deae37487b18ace1e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0179deae37487b18ace23
        failing since 117 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-25T18:42:19.354983  + set<8>[   11.534068] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11138327_1.4.2.3.1>

    2023-07-25T18:42:19.355402   +x

    2023-07-25T18:42:19.461597  / # #

    2023-07-25T18:42:19.563701  export SHELL=3D/bin/sh

    2023-07-25T18:42:19.564318  #

    2023-07-25T18:42:19.665568  / # export SHELL=3D/bin/sh. /lava-11138327/=
environment

    2023-07-25T18:42:19.666193  =


    2023-07-25T18:42:19.767665  / # . /lava-11138327/environment/lava-11138=
327/bin/lava-test-runner /lava-11138327/1

    2023-07-25T18:42:19.768776  =


    2023-07-25T18:42:19.773712  / # /lava-11138327/bin/lava-test-runner /la=
va-11138327/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c017a6bf8bd496068ace47

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c017a6bf8bd496068ace4c
        failing since 117 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-25T18:42:31.441799  <8>[    9.734290] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11138323_1.4.2.3.1>

    2023-07-25T18:42:31.444829  + set +x

    2023-07-25T18:42:31.545899  #

    2023-07-25T18:42:31.646782  / # #export SHELL=3D/bin/sh

    2023-07-25T18:42:31.647036  =


    2023-07-25T18:42:31.747608  / # export SHELL=3D/bin/sh. /lava-11138323/=
environment

    2023-07-25T18:42:31.747821  =


    2023-07-25T18:42:31.848483  / # . /lava-11138323/environment/lava-11138=
323/bin/lava-test-runner /lava-11138323/1

    2023-07-25T18:42:31.849499  =


    2023-07-25T18:42:31.855183  / # /lava-11138323/bin/lava-test-runner /la=
va-11138323/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c016d3c32350a46e8ace2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c016d3c32350a46e8ac=
e2c
        failing since 47 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c017cd76d365bda58ace42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c017cd76d365bda58ace47
        failing since 117 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-25T18:43:19.103236  + <8>[   10.216472] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11138356_1.4.2.3.1>

    2023-07-25T18:43:19.103358  set +x

    2023-07-25T18:43:19.204941  #

    2023-07-25T18:43:19.305928  / # #export SHELL=3D/bin/sh

    2023-07-25T18:43:19.306158  =


    2023-07-25T18:43:19.406676  / # export SHELL=3D/bin/sh. /lava-11138356/=
environment

    2023-07-25T18:43:19.406901  =


    2023-07-25T18:43:19.507511  / # . /lava-11138356/environment/lava-11138=
356/bin/lava-test-runner /lava-11138356/1

    2023-07-25T18:43:19.507856  =


    2023-07-25T18:43:19.512688  / # /lava-11138356/bin/lava-test-runner /la=
va-11138356/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c017f68335a1c7d98ace58

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c017f68335a1c7d98ace5d
        failing since 117 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-25T18:43:47.122678  <8>[   10.543742] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11138334_1.4.2.3.1>

    2023-07-25T18:43:47.126126  + set +x

    2023-07-25T18:43:47.232705  =


    2023-07-25T18:43:47.334433  / # #export SHELL=3D/bin/sh

    2023-07-25T18:43:47.334637  =


    2023-07-25T18:43:47.435290  / # export SHELL=3D/bin/sh. /lava-11138334/=
environment

    2023-07-25T18:43:47.436061  =


    2023-07-25T18:43:47.537527  / # . /lava-11138334/environment/lava-11138=
334/bin/lava-test-runner /lava-11138334/1

    2023-07-25T18:43:47.538844  =


    2023-07-25T18:43:47.544644  / # /lava-11138334/bin/lava-test-runner /la=
va-11138334/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c017a516358c8b308ace1f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c017a516358c8b308ace24
        failing since 117 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-25T18:42:29.304717  + set<8>[   11.372958] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11138331_1.4.2.3.1>

    2023-07-25T18:42:29.304832   +x

    2023-07-25T18:42:29.408959  / # #

    2023-07-25T18:42:29.509687  export SHELL=3D/bin/sh

    2023-07-25T18:42:29.509925  #

    2023-07-25T18:42:29.610486  / # export SHELL=3D/bin/sh. /lava-11138331/=
environment

    2023-07-25T18:42:29.610715  =


    2023-07-25T18:42:29.711287  / # . /lava-11138331/environment/lava-11138=
331/bin/lava-test-runner /lava-11138331/1

    2023-07-25T18:42:29.711575  =


    2023-07-25T18:42:29.716622  / # /lava-11138331/bin/lava-test-runner /la=
va-11138331/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0179eeae37487b18ace29

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0179eeae37487b18ace2e
        failing since 117 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-25T18:42:20.836322  + <8>[   12.036558] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11138317_1.4.2.3.1>

    2023-07-25T18:42:20.836407  set +x

    2023-07-25T18:42:20.940306  / # #

    2023-07-25T18:42:21.040996  export SHELL=3D/bin/sh

    2023-07-25T18:42:21.041222  #

    2023-07-25T18:42:21.141710  / # export SHELL=3D/bin/sh. /lava-11138317/=
environment

    2023-07-25T18:42:21.141934  =


    2023-07-25T18:42:21.242446  / # . /lava-11138317/environment/lava-11138=
317/bin/lava-test-runner /lava-11138317/1

    2023-07-25T18:42:21.242810  =


    2023-07-25T18:42:21.247112  / # /lava-11138317/bin/lava-test-runner /la=
va-11138317/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c01825e2da0a96548acec0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c01826e2da0a96548acec5
        failing since 7 days (last pass: v6.1.38-393-gb6386e7314b4, first f=
ail: v6.1.38-590-gce7ec1011187)

    2023-07-25T18:46:16.689599  / # #

    2023-07-25T18:46:16.791774  export SHELL=3D/bin/sh

    2023-07-25T18:46:16.792514  #

    2023-07-25T18:46:16.894006  / # export SHELL=3D/bin/sh. /lava-11138373/=
environment

    2023-07-25T18:46:16.894740  =


    2023-07-25T18:46:16.996144  / # . /lava-11138373/environment/lava-11138=
373/bin/lava-test-runner /lava-11138373/1

    2023-07-25T18:46:16.997306  =


    2023-07-25T18:46:17.013620  / # /lava-11138373/bin/lava-test-runner /la=
va-11138373/1

    2023-07-25T18:46:17.062607  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T18:46:17.063102  + cd /lav<8>[   19.004475] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11138373_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0183dcc87d808208ace29

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0183dcc87d808208ace2e
        failing since 7 days (last pass: v6.1.38-393-gb6386e7314b4, first f=
ail: v6.1.38-590-gce7ec1011187)

    2023-07-25T18:45:09.822007  / # #

    2023-07-25T18:45:10.897562  export SHELL=3D/bin/sh

    2023-07-25T18:45:10.899530  #

    2023-07-25T18:45:12.390025  / # export SHELL=3D/bin/sh. /lava-11138370/=
environment

    2023-07-25T18:45:12.391922  =


    2023-07-25T18:45:15.114941  / # . /lava-11138370/environment/lava-11138=
370/bin/lava-test-runner /lava-11138370/1

    2023-07-25T18:45:15.117419  =


    2023-07-25T18:45:15.121306  / # /lava-11138370/bin/lava-test-runner /la=
va-11138370/1

    2023-07-25T18:45:15.185090  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T18:45:15.185557  + cd /lava-111383<8>[   28.425165] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11138370_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c01827e2da0a96548acece

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.41-=
184-gb3f8a9d2b1371/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c01827e2da0a96548aced3
        failing since 7 days (last pass: v6.1.38-393-gb6386e7314b4, first f=
ail: v6.1.38-590-gce7ec1011187)

    2023-07-25T18:46:25.757771  / # #

    2023-07-25T18:46:25.858331  export SHELL=3D/bin/sh

    2023-07-25T18:46:25.858456  #

    2023-07-25T18:46:25.959273  / # export SHELL=3D/bin/sh. /lava-11138376/=
environment

    2023-07-25T18:46:25.959976  =


    2023-07-25T18:46:26.061339  / # . /lava-11138376/environment/lava-11138=
376/bin/lava-test-runner /lava-11138376/1

    2023-07-25T18:46:26.062253  =


    2023-07-25T18:46:26.071850  / # /lava-11138376/bin/lava-test-runner /la=
va-11138376/1

    2023-07-25T18:46:26.144589  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T18:46:26.145079  + cd /lava-11138376/1/tests/1_boot<8>[   16=
.982058] <LAVA_SIGNAL_STARTRUN 1_bootrr 11138376_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
