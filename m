Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9279C054
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379454AbjIKWoQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244203AbjIKTfq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 15:35:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC1012A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 12:35:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c364fb8a4cso44205745ad.1
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694460939; x=1695065739; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l5mO7ibzZOs6PLgxe7sPiVGsfyVnTlDL7WczRlA0SwA=;
        b=xBSAAJkizkwNjQ2BRR3oMCz3O3SwcUi1SDr7n/kHTBnYvs1hB9PfzBBYKt91vaCLzJ
         T6TT2VOGH5DiXKhM+4755i/YKtVLNV+Ju8fOfxU6y5GoD8n8ImCaEyt9oAiYt97O61Cs
         WNtpLXunpVeLHdxVXAhNL8pVt+rduYJYJynZ0a3ZW5IP78zQGRegVY4Hwwnm9OUw+57u
         HMnAtTbfiVPirIfjLb6XhJCuideHEQg8dBgQ6568hStaCA1FPN/lqRiPC0dcvtEQGBVB
         svOAytE9SzjrdmmiSc5kpOO2R8LnUvhyqe5upX6mWijMayfD/V2FbqrB/D1kSB69gqEl
         Uwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694460939; x=1695065739;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5mO7ibzZOs6PLgxe7sPiVGsfyVnTlDL7WczRlA0SwA=;
        b=O01aBSxVtrwQL8JYhTwOzpY0vdOF/IpCkwgZOeHGDD8C4uxXYbAHSdcexr/qomIGWq
         D8+zH2b1G2UO5mSQvgyLJZCzRMpG0oZp1oqkkFS7mKWELjRjWmahoyFnRl1+5t68eW47
         U7RFA/RLKf7d4Uk0Q2oDZxrSmxVeKd41QB30XYrvy/fzmZ2bnKOldiTqAH5YozKkOSL1
         7KQEesWh/jYfNdtdBBWXAklpen+wLLq3zQhVl9NyjkYKCaWqpjr4uLtrhfTsbRzRy7i9
         4s8LmhAStnKpdpG+JNkou3iezYPKENHSB4OUw8kyhWkupLqdoRCYAHcn0JxUqs7J4w3E
         CKsQ==
X-Gm-Message-State: AOJu0Yz+arBJKUUmGq5OcMfjsUL6V9aO96ft2QarzJWr0K2h7oiFDzqx
        PNlm1k6Ql8WLI+xsVjiooYFMdjka+04jP10mWbY=
X-Google-Smtp-Source: AGHT+IHif92sK4gbFbaLbp8rsKWSmJ7YKOivv9/9Y9/dk1cjg3ZYGqfdgZr6a0nPj2Z7YBs7QzbVoA==
X-Received: by 2002:a17:903:1c1:b0:1c3:3451:e332 with SMTP id e1-20020a17090301c100b001c33451e332mr12369286plh.42.1694460939371;
        Mon, 11 Sep 2023 12:35:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902864a00b001b8052d58a0sm6782649plt.305.2023.09.11.12.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:35:38 -0700 (PDT)
Message-ID: <64ff6c0a.170a0220.ed96.2302@mx.google.com>
Date:   Mon, 11 Sep 2023 12:35:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.131-378-g61dc41f49c69
Subject: stable-rc/linux-5.15.y baseline: 119 runs,
 10 regressions (v5.15.131-378-g61dc41f49c69)
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

stable-rc/linux-5.15.y baseline: 119 runs, 10 regressions (v5.15.131-378-g6=
1dc41f49c69)

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

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

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
nel/v5.15.131-378-g61dc41f49c69/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.131-378-g61dc41f49c69
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      61dc41f49c69b390e1136d2a0f725afdada17ecd =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff365b11890681bf286d77

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff365b11890681bf286d80
        failing since 166 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-11T15:46:13.804854  + set +x

    2023-09-11T15:46:13.811287  <8>[   10.436859] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11496456_1.4.2.3.1>

    2023-09-11T15:46:13.918532  #

    2023-09-11T15:46:13.919653  =


    2023-09-11T15:46:14.021337  / # #export SHELL=3D/bin/sh

    2023-09-11T15:46:14.022041  =


    2023-09-11T15:46:14.123507  / # export SHELL=3D/bin/sh. /lava-11496456/=
environment

    2023-09-11T15:46:14.124227  =


    2023-09-11T15:46:14.225658  / # . /lava-11496456/environment/lava-11496=
456/bin/lava-test-runner /lava-11496456/1

    2023-09-11T15:46:14.226815  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff34c7be172dcdf1286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff34c7be172dcdf1286d75
        failing since 166 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-11T15:39:40.111006  <8>[    9.891223] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11496433_1.4.2.3.1>

    2023-09-11T15:39:40.114431  + set +x

    2023-09-11T15:39:40.215737  #

    2023-09-11T15:39:40.216048  =


    2023-09-11T15:39:40.316615  / # #export SHELL=3D/bin/sh

    2023-09-11T15:39:40.316839  =


    2023-09-11T15:39:40.417385  / # export SHELL=3D/bin/sh. /lava-11496433/=
environment

    2023-09-11T15:39:40.417585  =


    2023-09-11T15:39:40.518133  / # . /lava-11496433/environment/lava-11496=
433/bin/lava-test-runner /lava-11496433/1

    2023-09-11T15:39:40.518424  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff6057ce2c4eefe4286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ff6057ce2c4eefe4286=
d6d
        failing since 48 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff52e40df0b5b71f286d7e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff52e40df0b5b71f286d87
        failing since 237 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-09-11T17:48:10.914358  + set +x<8>[   10.070992] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3770470_1.5.2.4.1>
    2023-09-11T17:48:10.914642  =

    2023-09-11T17:48:11.025654  / # #
    2023-09-11T17:48:11.128402  export SHELL=3D/bin/sh
    2023-09-11T17:48:11.129022  #
    2023-09-11T17:48:11.129320  / # <3>[   10.196052] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-09-11T17:48:11.230843  export SHELL=3D/bin/sh. /lava-3770470/envir=
onment
    2023-09-11T17:48:11.231454  =

    2023-09-11T17:48:11.336174  / # . /lava-3770470/environment/lava-377047=
0/bin/lava-test-runner /lava-3770470/1
    2023-09-11T17:48:11.336918   =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff34ddd60049426a286d6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff34ddd60049426a286d76
        failing since 166 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-11T15:40:01.795980  <8>[   10.548096] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11496458_1.4.2.3.1>

    2023-09-11T15:40:01.799326  + set +x

    2023-09-11T15:40:01.904976  =


    2023-09-11T15:40:02.006712  / # #export SHELL=3D/bin/sh

    2023-09-11T15:40:02.007439  =


    2023-09-11T15:40:02.108877  / # export SHELL=3D/bin/sh. /lava-11496458/=
environment

    2023-09-11T15:40:02.109559  =


    2023-09-11T15:40:02.210968  / # . /lava-11496458/environment/lava-11496=
458/bin/lava-test-runner /lava-11496458/1

    2023-09-11T15:40:02.212067  =


    2023-09-11T15:40:02.217080  / # /lava-11496458/bin/lava-test-runner /la=
va-11496458/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff34f770ad2d9f46286d94

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff34f770ad2d9f46286d9d
        failing since 166 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-11T15:40:16.608853  + <8>[   11.291288] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11496420_1.4.2.3.1>

    2023-09-11T15:40:16.608954  set +x

    2023-09-11T15:40:16.713679  / # #

    2023-09-11T15:40:16.814319  export SHELL=3D/bin/sh

    2023-09-11T15:40:16.814520  #

    2023-09-11T15:40:16.915027  / # export SHELL=3D/bin/sh. /lava-11496420/=
environment

    2023-09-11T15:40:16.915232  =


    2023-09-11T15:40:17.015775  / # . /lava-11496420/environment/lava-11496=
420/bin/lava-test-runner /lava-11496420/1

    2023-09-11T15:40:17.016093  =


    2023-09-11T15:40:17.021073  / # /lava-11496420/bin/lava-test-runner /la=
va-11496420/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff34c6b5f2ab42b0286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff34c6b5f2ab42b0286d75
        failing since 166 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-11T15:39:29.141329  <8>[   11.818851] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11496432_1.4.2.3.1>

    2023-09-11T15:39:29.245600  / # #

    2023-09-11T15:39:29.346285  export SHELL=3D/bin/sh

    2023-09-11T15:39:29.346503  #

    2023-09-11T15:39:29.447049  / # export SHELL=3D/bin/sh. /lava-11496432/=
environment

    2023-09-11T15:39:29.447274  =


    2023-09-11T15:39:29.547818  / # . /lava-11496432/environment/lava-11496=
432/bin/lava-test-runner /lava-11496432/1

    2023-09-11T15:39:29.548120  =


    2023-09-11T15:39:29.553022  / # /lava-11496432/bin/lava-test-runner /la=
va-11496432/1

    2023-09-11T15:39:29.558248  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff369418766a368b286da6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff369418766a368b286daf
        failing since 53 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-11T15:51:47.701486  / # #

    2023-09-11T15:51:47.802233  export SHELL=3D/bin/sh

    2023-09-11T15:51:47.802500  #

    2023-09-11T15:51:47.903281  / # export SHELL=3D/bin/sh. /lava-11496547/=
environment

    2023-09-11T15:51:47.904044  =


    2023-09-11T15:51:48.005524  / # . /lava-11496547/environment/lava-11496=
547/bin/lava-test-runner /lava-11496547/1

    2023-09-11T15:51:48.006648  =


    2023-09-11T15:51:48.012179  / # /lava-11496547/bin/lava-test-runner /la=
va-11496547/1

    2023-09-11T15:51:48.072263  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T15:51:48.072783  + cd /lav<8>[   15.948585] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11496547_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff36dc3eb23208b2286d7c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff36dc3eb23208b2286d85
        failing since 53 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-11T15:50:10.850596  / # #

    2023-09-11T15:50:11.930899  export SHELL=3D/bin/sh

    2023-09-11T15:50:11.932803  #

    2023-09-11T15:50:13.424262  / # export SHELL=3D/bin/sh. /lava-11496552/=
environment

    2023-09-11T15:50:13.426055  =


    2023-09-11T15:50:16.151600  / # . /lava-11496552/environment/lava-11496=
552/bin/lava-test-runner /lava-11496552/1

    2023-09-11T15:50:16.153883  =


    2023-09-11T15:50:16.158590  / # /lava-11496552/bin/lava-test-runner /la=
va-11496552/1

    2023-09-11T15:50:16.225440  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T15:50:16.225946  + cd /lav<8>[   25.571391] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11496552_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff36ab18766a368b286e86

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-378-g61dc41f49c69/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff36ab18766a368b286e8f
        failing since 53 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-11T15:52:01.313550  / # #

    2023-09-11T15:52:01.415558  export SHELL=3D/bin/sh

    2023-09-11T15:52:01.415762  #

    2023-09-11T15:52:01.516412  / # export SHELL=3D/bin/sh. /lava-11496542/=
environment

    2023-09-11T15:52:01.516566  =


    2023-09-11T15:52:01.617173  / # . /lava-11496542/environment/lava-11496=
542/bin/lava-test-runner /lava-11496542/1

    2023-09-11T15:52:01.617369  =


    2023-09-11T15:52:01.621817  / # /lava-11496542/bin/lava-test-runner /la=
va-11496542/1

    2023-09-11T15:52:01.690068  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T15:52:01.690327  + cd /lava-1149654<8>[   16.853824] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11496542_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
