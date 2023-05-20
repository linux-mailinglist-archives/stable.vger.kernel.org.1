Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19CD70A634
	for <lists+stable@lfdr.de>; Sat, 20 May 2023 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjETHvY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 20 May 2023 03:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjETHvX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 20 May 2023 03:51:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7843C1A6
        for <stable@vger.kernel.org>; Sat, 20 May 2023 00:51:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d247a023aso1822885b3a.2
        for <stable@vger.kernel.org>; Sat, 20 May 2023 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684569080; x=1687161080;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GwfNpjcUjSq26hiuBDXD3gGYtRTYehCkOqfW9bI6HY4=;
        b=zNQ/2OO5AMlnj4Xt2wYADjsCpHNwGqbf0FqlUFNxn0++4iBzFPcFkd1T6pl20XlHJm
         EbCOj+sXx0bRMkBdpK8gSUPyJDN/Y/an6oLSwJWFmltlpY9fDGeRkTfTl6CVU5URulkX
         5OdjaVpiqVb2yZkV+r+ZdqTmL4xAtFXwCNnhMCAByM+ePER6ci1b6qxKbbJgywVVFejc
         7Ds+96NZTypN1TUeqBIP1O/k6cwdd+cr9RVjDJpN6EUBTT2TpneNwGqDEI51G+9W49+P
         7RE5OApx/PCRyLjTOpBEVLapxhpmMZgwS7E+5decZIP2n3buEhEfTFQFFdaLgUVS+yia
         3Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684569080; x=1687161080;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwfNpjcUjSq26hiuBDXD3gGYtRTYehCkOqfW9bI6HY4=;
        b=h10RAERcNWCiCZJS7NYqmumm/+6noi8+Y31E5+3PL4flKkto07kHiKoBUyrJ00MqXb
         AFcOHIaSo3tZODAeMn9Tli9ocZPA8hF7MdpShuIsWSGtntklcptgT646Nf9GCzYGLrlQ
         HBy9OqZJ0kSZcc2L9DodtbaEeAjxHRlL8IbDrEELpUcuayqjtZ1udlX/f9r+csPinHFP
         TE0n7K5QUk4AM8DCNWTquez0DFtFv1mlJm2oE5hD2v0an4Gh1bVz4O4PTrKO6U60nqt9
         kr5wFHXJtkxQ9C2U7WoceiFNwAm1k+GnF33/G5FkYXiRa792EzRuTkZTq6F/1ouFL9tb
         0uzw==
X-Gm-Message-State: AC+VfDw61QasMPU02y/V/x3k8tZnzSsgJvjsp+BueQvWMwH3UO9HnKim
        DAXVhp73BFKEap5iY1AGBFiCMsUQMQPo+2JnZ9WOJA==
X-Google-Smtp-Source: ACHHUZ7AsDzqX+W+xqSrYW/37Wl+V9B5gEDbY8r2OdxnP2cWy5mn4mC7ndmvKTcdj3Rr9zeBrsTPPw==
X-Received: by 2002:a05:6a00:238d:b0:647:b6c9:179d with SMTP id f13-20020a056a00238d00b00647b6c9179dmr6273634pfc.21.1684569080206;
        Sat, 20 May 2023 00:51:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k4-20020aa78204000000b0063b6fb4522esm760883pfi.20.2023.05.20.00.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 00:51:19 -0700 (PDT)
Message-ID: <64687bf7.a70a0220.5b04c.1814@mx.google.com>
Date:   Sat, 20 May 2023 00:51:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-147-gb075a7da56db
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 141 runs,
 7 regressions (v6.1.29-147-gb075a7da56db)
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

stable-rc/queue/6.1 baseline: 141 runs, 7 regressions (v6.1.29-147-gb075a7d=
a56db)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-147-gb075a7da56db/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-147-gb075a7da56db
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b075a7da56dbf9eb98f72eb096ea9a8290a66473 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64684617343f51d3ae2e8658

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64684617343f51d3ae2e865d
        failing since 52 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-20T04:01:13.793197  + set +x

    2023-05-20T04:01:13.800054  <8>[   10.972256] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10395311_1.4.2.3.1>

    2023-05-20T04:01:13.908062  / # #

    2023-05-20T04:01:14.010568  export SHELL=3D/bin/sh

    2023-05-20T04:01:14.011359  #

    2023-05-20T04:01:14.112978  / # export SHELL=3D/bin/sh. /lava-10395311/=
environment

    2023-05-20T04:01:14.113807  =


    2023-05-20T04:01:14.215480  / # . /lava-10395311/environment/lava-10395=
311/bin/lava-test-runner /lava-10395311/1

    2023-05-20T04:01:14.216728  =


    2023-05-20T04:01:14.223289  / # /lava-10395311/bin/lava-test-runner /la=
va-10395311/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646845efbf645913242e85fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646845efbf645913242e8600
        failing since 52 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-20T04:00:30.701037  + set +x<8>[   11.394053] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10395286_1.4.2.3.1>

    2023-05-20T04:00:30.701467  =


    2023-05-20T04:00:30.808813  / # #

    2023-05-20T04:00:30.911264  export SHELL=3D/bin/sh

    2023-05-20T04:00:30.912031  #

    2023-05-20T04:00:31.013529  / # export SHELL=3D/bin/sh. /lava-10395286/=
environment

    2023-05-20T04:00:31.014369  =


    2023-05-20T04:00:31.116190  / # . /lava-10395286/environment/lava-10395=
286/bin/lava-test-runner /lava-10395286/1

    2023-05-20T04:00:31.117434  =


    2023-05-20T04:00:31.122415  / # /lava-10395286/bin/lava-test-runner /la=
va-10395286/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646845f1ec7c9a31752e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646845f1ec7c9a31752e8606
        failing since 52 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-20T04:00:28.278272  <8>[   10.149693] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10395332_1.4.2.3.1>

    2023-05-20T04:00:28.281766  + set +x

    2023-05-20T04:00:28.383486  =


    2023-05-20T04:00:28.484382  / # #export SHELL=3D/bin/sh

    2023-05-20T04:00:28.485162  =


    2023-05-20T04:00:28.586694  / # export SHELL=3D/bin/sh. /lava-10395332/=
environment

    2023-05-20T04:00:28.587432  =


    2023-05-20T04:00:28.688913  / # . /lava-10395332/environment/lava-10395=
332/bin/lava-test-runner /lava-10395332/1

    2023-05-20T04:00:28.690101  =


    2023-05-20T04:00:28.695724  / # /lava-10395332/bin/lava-test-runner /la=
va-10395332/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646845ef2d4bafe9f72e862e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646845ef2d4bafe9f72e8633
        failing since 52 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-20T04:00:41.600836  + set +x

    2023-05-20T04:00:41.607522  <8>[    9.936795] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10395272_1.4.2.3.1>

    2023-05-20T04:00:41.712160  / # #

    2023-05-20T04:00:41.812861  export SHELL=3D/bin/sh

    2023-05-20T04:00:41.813087  #

    2023-05-20T04:00:41.913624  / # export SHELL=3D/bin/sh. /lava-10395272/=
environment

    2023-05-20T04:00:41.913814  =


    2023-05-20T04:00:42.014315  / # . /lava-10395272/environment/lava-10395=
272/bin/lava-test-runner /lava-10395272/1

    2023-05-20T04:00:42.014618  =


    2023-05-20T04:00:42.019288  / # /lava-10395272/bin/lava-test-runner /la=
va-10395272/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646845ff0f57c04cc82e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646845ff0f57c04cc82e8613
        failing since 52 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-20T04:00:39.577414  + set<8>[   10.311341] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10395304_1.4.2.3.1>

    2023-05-20T04:00:39.577984   +x

    2023-05-20T04:00:39.687257  #

    2023-05-20T04:00:39.789706  / # #export SHELL=3D/bin/sh

    2023-05-20T04:00:39.790403  =


    2023-05-20T04:00:39.891875  / # export SHELL=3D/bin/sh. /lava-10395304/=
environment

    2023-05-20T04:00:39.892645  =


    2023-05-20T04:00:39.993995  / # . /lava-10395304/environment/lava-10395=
304/bin/lava-test-runner /lava-10395304/1

    2023-05-20T04:00:39.995371  =


    2023-05-20T04:00:40.000440  / # /lava-10395304/bin/lava-test-runner /la=
va-10395304/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64684610343f51d3ae2e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64684610343f51d3ae2e85ff
        failing since 52 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-20T04:00:56.140980  + set<8>[   10.861445] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10395293_1.4.2.3.1>

    2023-05-20T04:00:56.141460   +x

    2023-05-20T04:00:56.249296  / # #

    2023-05-20T04:00:56.351818  export SHELL=3D/bin/sh

    2023-05-20T04:00:56.352676  #

    2023-05-20T04:00:56.454200  / # export SHELL=3D/bin/sh. /lava-10395293/=
environment

    2023-05-20T04:00:56.454975  =


    2023-05-20T04:00:56.556615  / # . /lava-10395293/environment/lava-10395=
293/bin/lava-test-runner /lava-10395293/1

    2023-05-20T04:00:56.557747  =


    2023-05-20T04:00:56.562308  / # /lava-10395293/bin/lava-test-runner /la=
va-10395293/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646845fe0c973a3bd82e8692

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-14=
7-gb075a7da56db/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646845fe0c973a3bd82e8697
        failing since 52 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-20T04:00:38.491017  <8>[    9.329875] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10395295_1.4.2.3.1>

    2023-05-20T04:00:38.598898  / # #

    2023-05-20T04:00:38.700952  export SHELL=3D/bin/sh

    2023-05-20T04:00:38.701591  #

    2023-05-20T04:00:38.802929  / # export SHELL=3D/bin/sh. /lava-10395295/=
environment

    2023-05-20T04:00:38.803562  =


    2023-05-20T04:00:38.904872  / # . /lava-10395295/environment/lava-10395=
295/bin/lava-test-runner /lava-10395295/1

    2023-05-20T04:00:38.906030  =


    2023-05-20T04:00:38.910879  / # /lava-10395295/bin/lava-test-runner /la=
va-10395295/1

    2023-05-20T04:00:38.917324  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20
