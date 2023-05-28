Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505CF7139B1
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 15:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjE1Nns (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE1Nnr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 09:43:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123DDB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 06:43:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b0160c7512so12747655ad.3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685281424; x=1687873424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZcO6cZlNnYiBDdGJ2W1q9q1M/8cI6IzHKVQJDNgiQk=;
        b=NqylOypkSO6IHPVjN8r6mECWbupPAXOlv5cL7kHZjmc364CmvhxRhPWkgX5wekZCH7
         AC/qDV0dEXS8mtKaFJWV/KJ8AREaaIlLC/XvukjvThC2VbOJzMLuwFEtfaYMluXZkqJ5
         3zqdxrA1ZrEDAmuTIoseoWjTTire3oDacYNYJea4VXxXu6la1M2yYHoGad2d6XwYWVag
         9R0Gk1R5aF6Yn5MmWayyaheD9eo8jCKRmq42onbvQfIrCWzOQumbhUbe7wUobenLuGMH
         J5wmnXzenHbew0wKhvvKO24bwubwMSdYnE4xpeAUieIRoc47RuBffFS+mfN5xphWz9E6
         nseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685281424; x=1687873424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZcO6cZlNnYiBDdGJ2W1q9q1M/8cI6IzHKVQJDNgiQk=;
        b=Zkg45xtQP0vu34xkB7x1BEi0K3jlsQiO4FWHORCymbJB8UYhcn3OXStGQfvCS1PuwN
         R4OAsHcaWzT3a/b8swFuSQp+G67zDD03zXzcCk6Ghg/3vOhIPohciRaW6nxJkl7GeBcK
         iWYJUP34j9ulfOFoX/2HhYC1QNVztisPDeBPLEbKkYJaumIlhHxnpXqfFDil3r7o8DLF
         aw96ldRRE38/6cdXN6rryKmxuFMcjmvaIHSPrn48pHquQsXQoNGOA18QpGW5pRCtBJRD
         2mwL4fGTJe6ZOCRclFBzNMJkghRzq6tfJfDLMkLLXrmDxHRob4D81P3V/F3VXWVPq5AU
         4jyQ==
X-Gm-Message-State: AC+VfDzFWB8YdcoolIJXSbN/yPxLlT2T/6CHiQ6f43xc4t74U3InmzYY
        t1AYIcoEfhvGaLNTcf8la1o1BsYbn6pli9P3BGg=
X-Google-Smtp-Source: ACHHUZ5boHJCkkq0E+A6JZFFmhXiE7ypp0ORL+XdSwXCj52tiweirinoaJrDGZW8p0H0xFI0c30hKA==
X-Received: by 2002:a17:902:b485:b0:1af:f4f5:6fa3 with SMTP id y5-20020a170902b48500b001aff4f56fa3mr7153160plr.55.1685281423816;
        Sun, 28 May 2023 06:43:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090274c100b001acacff3a70sm6297257plt.125.2023.05.28.06.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 06:43:43 -0700 (PDT)
Message-ID: <64735a8f.170a0220.ff975.c491@mx.google.com>
Date:   Sun, 28 May 2023 06:43:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-343-g85e1bffa96f26
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 177 runs,
 11 regressions (v6.1.29-343-g85e1bffa96f26)
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

stable-rc/queue/6.1 baseline: 177 runs, 11 regressions (v6.1.29-343-g85e1bf=
fa96f26)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

meson-gxbb-nanopi-k2         | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-343-g85e1bffa96f26/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-343-g85e1bffa96f26
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      85e1bffa96f26ff0727319e80ba0049d4f34457c =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647325138369e1776e2e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647325138369e1776e2e85fa
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T09:55:14.455920  <8>[   10.923820] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10492127_1.4.2.3.1>

    2023-05-28T09:55:14.459711  + set +x

    2023-05-28T09:55:14.564252  / # #

    2023-05-28T09:55:14.666386  export SHELL=3D/bin/sh

    2023-05-28T09:55:14.667304  #

    2023-05-28T09:55:14.769117  / # export SHELL=3D/bin/sh. /lava-10492127/=
environment

    2023-05-28T09:55:14.769872  =


    2023-05-28T09:55:14.871535  / # . /lava-10492127/environment/lava-10492=
127/bin/lava-test-runner /lava-10492127/1

    2023-05-28T09:55:14.871936  =


    2023-05-28T09:55:14.877762  / # /lava-10492127/bin/lava-test-runner /la=
va-10492127/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647325168369e1776e2e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647325168369e1776e2e8605
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T09:55:15.548265  + set<8>[   11.908439] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10492105_1.4.2.3.1>

    2023-05-28T09:55:15.548818   +x

    2023-05-28T09:55:15.658860  / # #

    2023-05-28T09:55:15.761079  export SHELL=3D/bin/sh

    2023-05-28T09:55:15.761750  #

    2023-05-28T09:55:15.863169  / # export SHELL=3D/bin/sh. /lava-10492105/=
environment

    2023-05-28T09:55:15.863900  =


    2023-05-28T09:55:15.965397  / # . /lava-10492105/environment/lava-10492=
105/bin/lava-test-runner /lava-10492105/1

    2023-05-28T09:55:15.966764  =


    2023-05-28T09:55:15.970728  / # /lava-10492105/bin/lava-test-runner /la=
va-10492105/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647325202c90ffb4052e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647325202c90ffb4052e85ff
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T09:55:21.399884  <8>[   10.631052] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10492141_1.4.2.3.1>

    2023-05-28T09:55:21.402913  + set +x

    2023-05-28T09:55:21.507406  #

    2023-05-28T09:55:21.508489  =


    2023-05-28T09:55:21.610161  / # #export SHELL=3D/bin/sh

    2023-05-28T09:55:21.610842  =


    2023-05-28T09:55:21.712282  / # export SHELL=3D/bin/sh. /lava-10492141/=
environment

    2023-05-28T09:55:21.713052  =


    2023-05-28T09:55:21.814420  / # . /lava-10492141/environment/lava-10492=
141/bin/lava-test-runner /lava-10492141/1

    2023-05-28T09:55:21.815685  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473296cbd550dea2c2e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6473296cbd550dea2c2e8=
5ea
        failing since 37 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473262c96403b91802e8605

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473262c96403b91802e860a
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T09:59:56.912494  + <8>[   11.087358] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10492090_1.4.2.3.1>

    2023-05-28T09:59:56.912587  set +x

    2023-05-28T09:59:57.014611  =


    2023-05-28T09:59:57.115152  / # #export SHELL=3D/bin/sh

    2023-05-28T09:59:57.115365  =


    2023-05-28T09:59:57.215895  / # export SHELL=3D/bin/sh. /lava-10492090/=
environment

    2023-05-28T09:59:57.216095  =


    2023-05-28T09:59:57.316711  / # . /lava-10492090/environment/lava-10492=
090/bin/lava-test-runner /lava-10492090/1

    2023-05-28T09:59:57.317003  =


    2023-05-28T09:59:57.321576  / # /lava-10492090/bin/lava-test-runner /la=
va-10492090/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647325218369e1776e2e864a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647325218369e1776e2e864f
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T09:55:26.045900  <8>[   10.132051] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10492156_1.4.2.3.1>

    2023-05-28T09:55:26.050883  + set +x

    2023-05-28T09:55:26.157632  / # #

    2023-05-28T09:55:26.258319  export SHELL=3D/bin/sh

    2023-05-28T09:55:26.259081  #

    2023-05-28T09:55:26.360361  / # export SHELL=3D/bin/sh. /lava-10492156/=
environment

    2023-05-28T09:55:26.360676  =


    2023-05-28T09:55:26.461557  / # . /lava-10492156/environment/lava-10492=
156/bin/lava-test-runner /lava-10492156/1

    2023-05-28T09:55:26.461943  =


    2023-05-28T09:55:26.466976  / # /lava-10492156/bin/lava-test-runner /la=
va-10492156/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473250ffa6e56fcd42e8669

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473250ffa6e56fcd42e866e
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T09:55:18.053668  + <8>[   10.808424] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10492159_1.4.2.3.1>

    2023-05-28T09:55:18.053755  set +x

    2023-05-28T09:55:18.157894  / # #

    2023-05-28T09:55:18.258654  export SHELL=3D/bin/sh

    2023-05-28T09:55:18.258879  #

    2023-05-28T09:55:18.359428  / # export SHELL=3D/bin/sh. /lava-10492159/=
environment

    2023-05-28T09:55:18.359650  =


    2023-05-28T09:55:18.460255  / # . /lava-10492159/environment/lava-10492=
159/bin/lava-test-runner /lava-10492159/1

    2023-05-28T09:55:18.460626  =


    2023-05-28T09:55:18.465481  / # /lava-10492159/bin/lava-test-runner /la=
va-10492159/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64732731a5ebd126be2e85fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx=
6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx=
6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64732731a5ebd126be2e8603
        new failure (last pass: v6.1.29-330-g4ba79a09f3b1)

    2023-05-28T10:04:09.287130  + set[   14.932082] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 961472_1.5.2.3.1>
    2023-05-28T10:04:09.287300   +x
    2023-05-28T10:04:09.393242  / # #
    2023-05-28T10:04:09.494749  export SHELL=3D/bin/sh
    2023-05-28T10:04:09.495211  #
    2023-05-28T10:04:09.596430  / # export SHELL=3D/bin/sh. /lava-961472/en=
vironment
    2023-05-28T10:04:09.596823  =

    2023-05-28T10:04:09.697977  / # . /lava-961472/environment/lava-961472/=
bin/lava-test-runner /lava-961472/1
    2023-05-28T10:04:09.698472  =

    2023-05-28T10:04:09.701699  / # /lava-961472/bin/lava-test-runner /lava=
-961472/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647324fa6b05a1c3052e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647324fa6b05a1c3052e85eb
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T09:54:54.934495  + set +x<8>[   13.513432] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10492088_1.4.2.3.1>

    2023-05-28T09:54:54.934584  =


    2023-05-28T09:54:55.038640  / # #

    2023-05-28T09:54:55.139346  export SHELL=3D/bin/sh

    2023-05-28T09:54:55.139588  #

    2023-05-28T09:54:55.240101  / # export SHELL=3D/bin/sh. /lava-10492088/=
environment

    2023-05-28T09:54:55.240306  =


    2023-05-28T09:54:55.340864  / # . /lava-10492088/environment/lava-10492=
088/bin/lava-test-runner /lava-10492088/1

    2023-05-28T09:54:55.341162  =


    2023-05-28T09:54:55.345970  / # /lava-10492088/bin/lava-test-runner /la=
va-10492088/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxbb-nanopi-k2         | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6473267d2c719548ca2e869f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-na=
nopi-k2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-na=
nopi-k2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6473267d2c719548ca2e8=
6a0
        new failure (last pass: v6.1.29-330-g4ba79a09f3b1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6473262696403b91802e85f7

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mi=
ps-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-34=
3-g85e1bffa96f26/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mi=
ps-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/mipsel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/6473262696403b9=
1802e85ff
        failing since 1 day (last pass: v6.1.29-305-ga4121db79070f, first f=
ail: v6.1.29-330-g5e3e9f8e6af9)
        1 lines

    2023-05-28T09:59:47.426887  kern  :alert : CPU 0 Unable to handle kerne=
l paging request at virtual address 00000000, epc =3D=3D 00000000, ra =3D=
=3D 8023f99c
    2023-05-28T09:59:47.427206  =


    2023-05-28T09:59:47.476097  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-05-28T09:59:47.476333  =

   =

 =20
