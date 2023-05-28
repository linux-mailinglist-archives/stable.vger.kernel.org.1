Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8549671396E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjE1M3A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 08:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1M27 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 08:28:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1829B6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 05:28:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-256712e2be3so297367a91.2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685276936; x=1687868936;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ef9y83j5xpBdwM2Bs8HZWUWGnQ9MYXRisQzUfcv97Jc=;
        b=TDF/hqyOPrWmlJmyHP2FaFhVcYxvIc82P1Kpbpo7baqpkYjJelpYom5ImleuVHH+aS
         r27DZRkiC/C4ft2xLlt9PtHjcmYKY2KRX2N5Z673+V1DlbliwQ9zLexyAPv6HEjXzYPY
         +6P5Nj2g2ESO/L+LDpksjGz1nYb5fV2jWhnG36iC7/R3zsFX+MA9WrXVhpVLElaAZ437
         wJChyULAP223OYVOyVL30zzO3zlkc5x0t8sObur5XPQRvaXZhO4xYxiFNWAgHNFghvji
         3JriIcitZpXzEEaFTzjtgM76/17Y7CDeATimeMgyyClt6Yc/uW6063hmpDqlycgmKhVK
         /Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685276936; x=1687868936;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ef9y83j5xpBdwM2Bs8HZWUWGnQ9MYXRisQzUfcv97Jc=;
        b=eQZVrikFeZnncka3I7i+w28QY2cbbkE7nkqz1NfCu4qZd0v3gQXDmD3gQFSaaGd30y
         woiAZUr8xXUXJQFbNs0t9uuyK/vuFR+Yp2MCc1hRn+RxY8Ho2uZ5W4SXrTvkLfFuQHyy
         G1o9u9lf8IpB8z1PUbyeTFgsYLfIbHsVgBSa6mhdYNzrcDoXjK0mohOYhJK+Zo2pcl5R
         fWIcSxHEhinVdgbGqHzKHyBzRuKnNED3sva37STGNBXAcW7G3Uh1PU4L7Or4Uoyi3Ekx
         LSl4WPKVMWBtp0B2g2QpTuit7n0COgh18iLiYDGgtf0f4sIMVqe/9gh6RnjqxbWCm4Dz
         6O2w==
X-Gm-Message-State: AC+VfDyavYQYuMfuDPHV+frpOsJTeWwkRsH6xWnAqVCbklgxEf17Y+VQ
        81dgVAsruTMq5cLdOsDMmvz53Qrnx11biGduzy8=
X-Google-Smtp-Source: ACHHUZ4KXqDHyFU0+sc9O7Ag79mDv6e9Y7cF3ttGscurbrmQyIywg6NcBJXpb+1O+koGKEfbQEvTMg==
X-Received: by 2002:a17:90a:1c02:b0:256:d4a:ea4c with SMTP id s2-20020a17090a1c0200b002560d4aea4cmr7714672pjs.30.1685276936533;
        Sun, 28 May 2023 05:28:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ds23-20020a17090b08d700b0024dfb8271a4sm5521291pjb.21.2023.05.28.05.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 05:28:56 -0700 (PDT)
Message-ID: <64734908.170a0220.8738d.ae53@mx.google.com>
Date:   Sun, 28 May 2023 05:28:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-330-g4ba79a09f3b1
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 173 runs,
 11 regressions (v6.1.29-330-g4ba79a09f3b1)
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

stable-rc/queue/6.1 baseline: 173 runs, 11 regressions (v6.1.29-330-g4ba79a=
09f3b1)

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

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-330-g4ba79a09f3b1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-330-g4ba79a09f3b1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4ba79a09f3b11ba839fe7e2b48c846940c132525 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647312022fbb3b4fbf2e861b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647312022fbb3b4fbf2e8620
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T08:33:45.808889  <8>[   10.494310] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10490825_1.4.2.3.1>

    2023-05-28T08:33:45.812301  + set +x

    2023-05-28T08:33:45.913800  / #

    2023-05-28T08:33:46.014652  # #export SHELL=3D/bin/sh

    2023-05-28T08:33:46.014976  =


    2023-05-28T08:33:46.115610  / # export SHELL=3D/bin/sh. /lava-10490825/=
environment

    2023-05-28T08:33:46.116011  =


    2023-05-28T08:33:46.216696  / # . /lava-10490825/environment/lava-10490=
825/bin/lava-test-runner /lava-10490825/1

    2023-05-28T08:33:46.217024  =


    2023-05-28T08:33:46.222247  / # /lava-10490825/bin/lava-test-runner /la=
va-10490825/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647311f996bb7d05302e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647311f996bb7d05302e8630
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T08:33:42.492786  + set<8>[   11.347555] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10490799_1.4.2.3.1>

    2023-05-28T08:33:42.492940   +x

    2023-05-28T08:33:42.598109  / # #

    2023-05-28T08:33:42.698936  export SHELL=3D/bin/sh

    2023-05-28T08:33:42.699199  #

    2023-05-28T08:33:42.799835  / # export SHELL=3D/bin/sh. /lava-10490799/=
environment

    2023-05-28T08:33:42.800089  =


    2023-05-28T08:33:42.900742  / # . /lava-10490799/environment/lava-10490=
799/bin/lava-test-runner /lava-10490799/1

    2023-05-28T08:33:42.901163  =


    2023-05-28T08:33:42.905617  / # /lava-10490799/bin/lava-test-runner /la=
va-10490799/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647311fa42ced55d872e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647311fa42ced55d872e85f8
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T08:33:39.065720  <8>[    7.767848] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10490754_1.4.2.3.1>

    2023-05-28T08:33:39.069070  + set +x

    2023-05-28T08:33:39.170262  #

    2023-05-28T08:33:39.170547  =


    2023-05-28T08:33:39.271173  / # #export SHELL=3D/bin/sh

    2023-05-28T08:33:39.271397  =


    2023-05-28T08:33:39.371990  / # export SHELL=3D/bin/sh. /lava-10490754/=
environment

    2023-05-28T08:33:39.372876  =


    2023-05-28T08:33:39.474316  / # . /lava-10490754/environment/lava-10490=
754/bin/lava-test-runner /lava-10490754/1

    2023-05-28T08:33:39.475611  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647318d37aa5dcd5882e8604

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647318d37aa5dcd5882e8=
605
        failing since 37 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647311ecefee5516da2e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647311ecefee5516da2e860c
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T08:33:36.587889  + set +x

    2023-05-28T08:33:36.594560  <8>[   10.289805] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10490770_1.4.2.3.1>

    2023-05-28T08:33:36.698730  / # #

    2023-05-28T08:33:36.799440  export SHELL=3D/bin/sh

    2023-05-28T08:33:36.799686  #

    2023-05-28T08:33:36.900170  / # export SHELL=3D/bin/sh. /lava-10490770/=
environment

    2023-05-28T08:33:36.900383  =


    2023-05-28T08:33:37.000913  / # . /lava-10490770/environment/lava-10490=
770/bin/lava-test-runner /lava-10490770/1

    2023-05-28T08:33:37.001157  =


    2023-05-28T08:33:37.006301  / # /lava-10490770/bin/lava-test-runner /la=
va-10490770/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647311ea8621a284362e8639

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647311ea8621a284362e863e
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T08:33:27.800648  <8>[    7.770580] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10490803_1.4.2.3.1>

    2023-05-28T08:33:27.804390  + set +x

    2023-05-28T08:33:27.906111  #

    2023-05-28T08:33:28.006989  / # #export SHELL=3D/bin/sh

    2023-05-28T08:33:28.007214  =


    2023-05-28T08:33:28.107769  / # export SHELL=3D/bin/sh. /lava-10490803/=
environment

    2023-05-28T08:33:28.107989  =


    2023-05-28T08:33:28.208547  / # . /lava-10490803/environment/lava-10490=
803/bin/lava-test-runner /lava-10490803/1

    2023-05-28T08:33:28.208882  =


    2023-05-28T08:33:28.214134  / # /lava-10490803/bin/lava-test-runner /la=
va-10490803/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647311fb42ced55d872e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647311fb42ced55d872e8603
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T08:33:41.769555  + set +x<8>[   10.837932] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10490815_1.4.2.3.1>

    2023-05-28T08:33:41.769642  =


    2023-05-28T08:33:41.874253  / # #

    2023-05-28T08:33:41.975110  export SHELL=3D/bin/sh

    2023-05-28T08:33:41.975871  #

    2023-05-28T08:33:42.077119  / # export SHELL=3D/bin/sh. /lava-10490815/=
environment

    2023-05-28T08:33:42.077303  =


    2023-05-28T08:33:42.177843  / # . /lava-10490815/environment/lava-10490=
815/bin/lava-test-runner /lava-10490815/1

    2023-05-28T08:33:42.178068  =


    2023-05-28T08:33:42.182957  / # /lava-10490815/bin/lava-test-runner /la=
va-10490815/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/647313e06be457f8ea2e8602

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647313e06be457f8ea2e8605
        new failure (last pass: v6.1.29-330-g5e3e9f8e6af9)

    2023-05-28T08:41:41.523982  / # #
    2023-05-28T08:41:41.626180  export SHELL=3D/bin/sh
    2023-05-28T08:41:41.626466  #
    2023-05-28T08:41:41.727579  / # export SHELL=3D/bin/sh. /lava-345777/en=
vironment
    2023-05-28T08:41:41.728175  =

    2023-05-28T08:41:41.829720  / # . /lava-345777/environment/lava-345777/=
bin/lava-test-runner /lava-345777/1
    2023-05-28T08:41:41.830771  =

    2023-05-28T08:41:41.849679  / # /lava-345777/bin/lava-test-runner /lava=
-345777/1
    2023-05-28T08:41:41.865586  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-28T08:41:41.899634  + cd /l<8>[   14.476737] <LAVA_SIGNAL_START=
RUN 1_bootrr 345777_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/647=
313e06be457f8ea2e8615
        new failure (last pass: v6.1.29-330-g5e3e9f8e6af9)

    2023-05-28T08:41:44.253774  /lava-345777/1/../bin/lava-test-case
    2023-05-28T08:41:44.254493  <8>[   16.925016] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-05-28T08:41:44.254832  /lava-345777/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647312012fbb3b4fbf2e8610

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647312012fbb3b4fbf2e8615
        failing since 60 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-28T08:33:47.636230  <8>[   11.541973] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10490777_1.4.2.3.1>

    2023-05-28T08:33:47.741134  / # #

    2023-05-28T08:33:47.841756  export SHELL=3D/bin/sh

    2023-05-28T08:33:47.841955  #

    2023-05-28T08:33:47.942464  / # export SHELL=3D/bin/sh. /lava-10490777/=
environment

    2023-05-28T08:33:47.942663  =


    2023-05-28T08:33:48.043216  / # . /lava-10490777/environment/lava-10490=
777/bin/lava-test-runner /lava-10490777/1

    2023-05-28T08:33:48.043498  =


    2023-05-28T08:33:48.048034  / # /lava-10490777/bin/lava-test-runner /la=
va-10490777/1

    2023-05-28T08:33:48.054826  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/647312c345975aaa092e861e

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g4ba79a09f3b1/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/mipsel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/647312c345975aa=
a092e8626
        failing since 1 day (last pass: v6.1.29-305-ga4121db79070f, first f=
ail: v6.1.29-330-g5e3e9f8e6af9)
        1 lines

    2023-05-28T08:37:04.937838  kern  :alert : CPU 0 Unable to handle kerne=
l paging request at virtual address 00000000, epc =3D=3D 00000000, ra =3D=
=3D 8023f99c
    2023-05-28T08:37:04.938091  =


    2023-05-28T08:37:04.994333  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-05-28T08:37:04.994681  =

   =

 =20
