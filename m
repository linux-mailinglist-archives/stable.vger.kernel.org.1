Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD3F78EE71
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjHaNU7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 09:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjHaNU6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 09:20:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D979BCEB
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 06:20:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso5295055ad.3
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693488054; x=1694092854; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nAGnAGgDsGo+g5kexb7Bt5w2kdbflkEEk5UPFvOLloU=;
        b=rMhT5mXiz614KS1TDy64heUQi1qU+SjdZ4obpGait/lbidPa1aDm9K3cB4nSMK4PLG
         mz4BSUVxd6bvpwfnjLfAWYRWic5UJq+uAyFgFZzEg+47sjdEm8qfMcTeGBS7BLzS4scj
         J7sbF2aHyGlzdYx4Km5SPxpmF41hxGNZbyaLMUnWIpdGvH+uDz5Er4X9F/ATqC9tOMEJ
         WwEWktFi/S8UW0x05CpQMuk9aOfxlh7h9hsPOr30Ri2GvOJXqf29L/dgQkc/I62g1XDS
         m/q33IU6wZPnLmQ242r9O6XlqGBuYnjQz9l3LOz3U6D2tqd8iEgc0DTXh75B8tHh19qM
         pR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693488054; x=1694092854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAGnAGgDsGo+g5kexb7Bt5w2kdbflkEEk5UPFvOLloU=;
        b=CtzS21sfAEYrmGoHJAxdu07q6NrIMlXATM6I5UMTu+QrescG+mJ72SAjUfquWT6VDn
         xbsjEvQUGqXdtSj4M72ECQO3ECHdQfD5/vgEmhE6Dfo3CBooGJxox4SC7EQCnsUzJQKu
         pyFq/IDIoYvde1doKPbrRSjyFVxTCtnlEPjqaxl9gUET+sKnIhMDpdPmcjmF86SrZZXj
         HnzXj3R6yGYV1Qb9jUyHGlu8vN1wRqz2s2BeoJX8/FsBHvTYcg/MA7EAUBjCaUTKdUa0
         hM0Ru0Ff16plHW5s0leiRQ0gn5mQ8OU55cVo9zuTZm+zr2U6Kus6rCP3QAZc8C84i/5K
         u9dQ==
X-Gm-Message-State: AOJu0YyDA4zepHYdXlWe24cqRqiP0D95dvdqwIyfcUHsS0B2GoznaGNh
        EJFHyIvEAbUfnAqBBoh9mXH7HzTd7x3EdO842tk=
X-Google-Smtp-Source: AGHT+IEw0rEPHhqHPk7aIGxIgqd31/b1O8T3YQ/XnKRyoRl5kTCX0T+tQ1H0cg9MuF3L7ff5/eMWiA==
X-Received: by 2002:a17:902:d902:b0:1bd:ba57:5a8f with SMTP id c2-20020a170902d90200b001bdba575a8fmr5077779plz.13.1693488053609;
        Thu, 31 Aug 2023 06:20:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ja19-20020a170902efd300b001b9c960ffeasm1244811plb.47.2023.08.31.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:20:52 -0700 (PDT)
Message-ID: <64f093b4.170a0220.7a215.2409@mx.google.com>
Date:   Thu, 31 Aug 2023 06:20:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.129
Subject: stable-rc/linux-5.15.y baseline: 96 runs, 11 regressions (v5.15.129)
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

stable-rc/linux-5.15.y baseline: 96 runs, 11 regressions (v5.15.129)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.129/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.129
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9e43368a3393dd40002cecb63e13af285be270fc =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f05e59c48b00e89e286da3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f05e59c48b00e89e286dac
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-31T09:32:51.830034  <8>[   10.256854] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11388702_1.4.2.3.1>

    2023-08-31T09:32:51.833922  + set +x

    2023-08-31T09:32:51.943832  / # #

    2023-08-31T09:32:52.045093  export SHELL=3D/bin/sh

    2023-08-31T09:32:52.045945  #

    2023-08-31T09:32:52.147800  / # export SHELL=3D/bin/sh. /lava-11388702/=
environment

    2023-08-31T09:32:52.148705  =


    2023-08-31T09:32:52.250600  / # . /lava-11388702/environment/lava-11388=
702/bin/lava-test-runner /lava-11388702/1

    2023-08-31T09:32:52.250942  =


    2023-08-31T09:32:52.256679  / # /lava-11388702/bin/lava-test-runner /la=
va-11388702/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f05e4f7eb97eba84286d8c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f05e4f7eb97eba84286d95
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-31T09:32:42.214235  <8>[   10.852529] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11388711_1.4.2.3.1>

    2023-08-31T09:32:42.217573  + set +x

    2023-08-31T09:32:42.319206  =


    2023-08-31T09:32:42.419805  / # #export SHELL=3D/bin/sh

    2023-08-31T09:32:42.419988  =


    2023-08-31T09:32:42.520515  / # export SHELL=3D/bin/sh. /lava-11388711/=
environment

    2023-08-31T09:32:42.520716  =


    2023-08-31T09:32:42.621246  / # . /lava-11388711/environment/lava-11388=
711/bin/lava-test-runner /lava-11388711/1

    2023-08-31T09:32:42.621548  =


    2023-08-31T09:32:42.626355  / # /lava-11388711/bin/lava-test-runner /la=
va-11388711/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f05fe109d741bdfb286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f05fe109d741bdfb286d76
        failing since 226 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-31T09:39:31.793964  <8>[    9.989070] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3757254_1.5.2.4.1>
    2023-08-31T09:39:31.904247  / # #
    2023-08-31T09:39:32.007788  export SHELL=3D/bin/sh
    2023-08-31T09:39:32.008966  #
    2023-08-31T09:39:32.111391  / # export SHELL=3D/bin/sh. /lava-3757254/e=
nvironment
    2023-08-31T09:39:32.112530  =

    2023-08-31T09:39:32.214983  / # . /lava-3757254/environment/lava-375725=
4/bin/lava-test-runner /lava-3757254/1
    2023-08-31T09:39:32.216971  =

    2023-08-31T09:39:32.221443  / # /lava-3757254/bin/lava-test-runner /lav=
a-3757254/1
    2023-08-31T09:39:32.301784  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f05bf5474b1c7171286e68

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f05bf5474b1c7171286e6b
        failing since 48 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-31T09:22:50.715524  + [   16.371899] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1248211_1.5.2.4.1>
    2023-08-31T09:22:50.715821  set +x
    2023-08-31T09:22:50.821059  =

    2023-08-31T09:22:50.922330  / # #export SHELL=3D/bin/sh
    2023-08-31T09:22:50.922757  =

    2023-08-31T09:22:51.023732  / # export SHELL=3D/bin/sh. /lava-1248211/e=
nvironment
    2023-08-31T09:22:51.024151  =

    2023-08-31T09:22:51.125134  / # . /lava-1248211/environment/lava-124821=
1/bin/lava-test-runner /lava-1248211/1
    2023-08-31T09:22:51.125945  =

    2023-08-31T09:22:51.128717  / # /lava-1248211/bin/lava-test-runner /lav=
a-1248211/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f05c0a2324bb1103286da0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f05c0a2324bb1103286da3
        failing since 180 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-31T09:22:59.243595  [   16.357797] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1248213_1.5.2.4.1>
    2023-08-31T09:22:59.349024  =

    2023-08-31T09:22:59.450160  / # #export SHELL=3D/bin/sh
    2023-08-31T09:22:59.450608  =

    2023-08-31T09:22:59.551568  / # export SHELL=3D/bin/sh. /lava-1248213/e=
nvironment
    2023-08-31T09:22:59.552135  =

    2023-08-31T09:22:59.653316  / # . /lava-1248213/environment/lava-124821=
3/bin/lava-test-runner /lava-1248213/1
    2023-08-31T09:22:59.654238  =

    2023-08-31T09:22:59.658011  / # /lava-1248213/bin/lava-test-runner /lav=
a-1248213/1
    2023-08-31T09:22:59.674038  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f05e375b945bc279286d6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f05e375b945bc279286d77
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-31T09:32:28.926128  + set +x<8>[   10.310783] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11388691_1.4.2.3.1>

    2023-08-31T09:32:28.926214  =


    2023-08-31T09:32:29.027748  / #

    2023-08-31T09:32:29.128434  # #export SHELL=3D/bin/sh

    2023-08-31T09:32:29.128649  =


    2023-08-31T09:32:29.229281  / # export SHELL=3D/bin/sh. /lava-11388691/=
environment

    2023-08-31T09:32:29.229433  =


    2023-08-31T09:32:29.329971  / # . /lava-11388691/environment/lava-11388=
691/bin/lava-test-runner /lava-11388691/1

    2023-08-31T09:32:29.330182  =


    2023-08-31T09:32:29.335059  / # /lava-11388691/bin/lava-test-runner /la=
va-11388691/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f05e515b945bc279286d7c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f05e515b945bc279286d85
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-31T09:32:58.067521  + <8>[   11.497362] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11388699_1.4.2.3.1>

    2023-08-31T09:32:58.067604  set +x

    2023-08-31T09:32:58.171922  / # #

    2023-08-31T09:32:58.272519  export SHELL=3D/bin/sh

    2023-08-31T09:32:58.272704  #

    2023-08-31T09:32:58.373250  / # export SHELL=3D/bin/sh. /lava-11388699/=
environment

    2023-08-31T09:32:58.373425  =


    2023-08-31T09:32:58.473917  / # . /lava-11388699/environment/lava-11388=
699/bin/lava-test-runner /lava-11388699/1

    2023-08-31T09:32:58.474222  =


    2023-08-31T09:32:58.478397  / # /lava-11388699/bin/lava-test-runner /la=
va-11388699/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f05e5a7eb97eba84286d99

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f05e5a7eb97eba84286da2
        failing since 155 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-31T09:32:50.043680  <8>[   11.823515] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11388708_1.4.2.3.1>

    2023-08-31T09:32:50.148013  / # #

    2023-08-31T09:32:50.248656  export SHELL=3D/bin/sh

    2023-08-31T09:32:50.248875  #

    2023-08-31T09:32:50.349391  / # export SHELL=3D/bin/sh. /lava-11388708/=
environment

    2023-08-31T09:32:50.349578  =


    2023-08-31T09:32:50.450128  / # . /lava-11388708/environment/lava-11388=
708/bin/lava-test-runner /lava-11388708/1

    2023-08-31T09:32:50.450480  =


    2023-08-31T09:32:50.455339  / # /lava-11388708/bin/lava-test-runner /la=
va-11388708/1

    2023-08-31T09:32:50.460991  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f0914490ec931cab286dad

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f0914490ec931cab286db6
        failing since 42 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-31T13:11:44.363874  / # #

    2023-08-31T13:11:44.466156  export SHELL=3D/bin/sh

    2023-08-31T13:11:44.466902  #

    2023-08-31T13:11:44.568286  / # export SHELL=3D/bin/sh. /lava-11388664/=
environment

    2023-08-31T13:11:44.569081  =


    2023-08-31T13:11:44.670553  / # . /lava-11388664/environment/lava-11388=
664/bin/lava-test-runner /lava-11388664/1

    2023-08-31T13:11:44.671743  =


    2023-08-31T13:11:44.686722  / # /lava-11388664/bin/lava-test-runner /la=
va-11388664/1

    2023-08-31T13:11:44.737290  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T13:11:44.737803  + cd /lav<8>[   15.976489] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11388664_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f05b8c05b8f0a713286db6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f05b8c05b8f0a713286dbf
        failing since 42 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-31T09:22:26.898995  / # #

    2023-08-31T09:22:27.978727  export SHELL=3D/bin/sh

    2023-08-31T09:22:27.980509  #

    2023-08-31T09:22:29.470093  / # export SHELL=3D/bin/sh. /lava-11388670/=
environment

    2023-08-31T09:22:29.471906  =


    2023-08-31T09:22:32.195204  / # . /lava-11388670/environment/lava-11388=
670/bin/lava-test-runner /lava-11388670/1

    2023-08-31T09:22:32.197484  =


    2023-08-31T09:22:32.206792  / # /lava-11388670/bin/lava-test-runner /la=
va-11388670/1

    2023-08-31T09:22:32.268331  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T09:22:32.268821  + cd /lava-113886<8>[   25.517006] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11388670_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f05b8369822442bf286dd5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
29/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f05b8369822442bf286dde
        failing since 42 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-31T09:22:31.676656  / # #

    2023-08-31T09:22:31.777378  export SHELL=3D/bin/sh

    2023-08-31T09:22:31.777655  #

    2023-08-31T09:22:31.878442  / # export SHELL=3D/bin/sh. /lava-11388656/=
environment

    2023-08-31T09:22:31.879212  =


    2023-08-31T09:22:31.980701  / # . /lava-11388656/environment/lava-11388=
656/bin/lava-test-runner /lava-11388656/1

    2023-08-31T09:22:31.981990  =


    2023-08-31T09:22:31.990147  / # /lava-11388656/bin/lava-test-runner /la=
va-11388656/1

    2023-08-31T09:22:32.054163  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T09:22:32.054670  + cd /lava-1138865<8>[   16.820313] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11388656_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
