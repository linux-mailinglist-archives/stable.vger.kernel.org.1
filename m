Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C86F6F933A
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 19:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjEFRFB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 13:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFRFA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 13:05:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF31A1D1
        for <stable@vger.kernel.org>; Sat,  6 May 2023 10:04:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6439df6c268so1369327b3a.0
        for <stable@vger.kernel.org>; Sat, 06 May 2023 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683392697; x=1685984697;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v6dNY75wEMsvfFxKtKovPaTvwbeO46p8P8BFDPUt95w=;
        b=G2Pw9nrTro/Y2LTq0m9RR73Z3oIXPdWzs0SZZ4DAQEUjOZS0MKHCFIsbdH7swIPcU4
         DSFH/vnKFb1dudXidd7L3CHzTV/VEQbnfIQGh7O2KkyxfMzwb8/6BwL9DYilSlAP5G3N
         Jiwfu1IPCszsbMTDmNOkH9OljWRf2YS/N4+ID4pwDBEuv37iUTEqGxNjQiQmDFfMEOgQ
         yl/vd+XAd51UVBCU4B0qR6cKYrfThfmGZBlaY7b5TcDZnsGVFSsD4KyJJNmTGajgpTwQ
         pRYiyrIwBImn6kIvhxkd08gD+xhteJ772NqV39GtRr66Gi72fgb3j2Jv1fEd1f3Dxaen
         PLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683392697; x=1685984697;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6dNY75wEMsvfFxKtKovPaTvwbeO46p8P8BFDPUt95w=;
        b=PKNemDo5lFJ8AXm+36shoz/ivBm7DTQwQCKwL1rwOZ5/Cs2z5QPmUFKB88KIeW84Ye
         0BBmdaafS+Po0HZaWlBNDqZbG3oMfjP73DNmPQ7epWfzD6yvnxdgHVzWRORzznvihzSn
         H2rLGpuxG9su90dHb422FW0tTK2RwW8VjDoX2HDFDI5+ts0KvP1bCJvXg/yAR3sbXXKZ
         SJXt764H3r/ylN/WtUJqaav4n6aEmW7CeJz8SuX0OJARDLH8oDMiYKJpILVbZOsPD47L
         5S9wDdJGL0Mq0Oq55pUIHwMvtMgTwNu9PRdxrGyfFjQ2wJFqyg9TpkYg/Jl9zuyS4Xtv
         kRnA==
X-Gm-Message-State: AC+VfDzgTJNQY3feKZCGBcfE9FDOcGg+9BQw7JoBSW4hbn20KZH8DHFK
        v+XhqCJ87zJ6cb4eE46BYkbeO3vKc5HE0dec8Zd+sQ==
X-Google-Smtp-Source: ACHHUZ64Y5ppQjTKf8o7H9YXAVe8nDjiIEt3U30s7MTN0q+4pjH6IGHoW6fJ4BMMzRfF2osXdZ0KGA==
X-Received: by 2002:a05:6a00:2441:b0:643:4d69:efe0 with SMTP id d1-20020a056a00244100b006434d69efe0mr6535785pfj.4.1683392696549;
        Sat, 06 May 2023 10:04:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g5-20020aa78745000000b005aa60d8545esm1930491pfo.61.2023.05.06.10.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 10:04:55 -0700 (PDT)
Message-ID: <645688b7.a70a0220.156ac.3fec@mx.google.com>
Date:   Sat, 06 May 2023 10:04:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-716-g0ba96946e8d1
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 164 runs,
 12 regressions (v5.15.105-716-g0ba96946e8d1)
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

stable-rc/queue/5.15 baseline: 164 runs, 12 regressions (v5.15.105-716-g0ba=
96946e8d1)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-716-g0ba96946e8d1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-716-g0ba96946e8d1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0ba96946e8d1c0dcc8c05330cbe57c8bedae722a =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645656dc87126b00232e8604

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645656dc87126b00232e8609
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T13:31:58.354063  + set +x<8>[   11.445536] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10215755_1.4.2.3.1>

    2023-05-06T13:31:58.354642  =


    2023-05-06T13:31:58.462923  / # #

    2023-05-06T13:31:58.565687  export SHELL=3D/bin/sh

    2023-05-06T13:31:58.566525  #

    2023-05-06T13:31:58.668265  / # export SHELL=3D/bin/sh. /lava-10215755/=
environment

    2023-05-06T13:31:58.669072  =


    2023-05-06T13:31:58.770950  / # . /lava-10215755/environment/lava-10215=
755/bin/lava-test-runner /lava-10215755/1

    2023-05-06T13:31:58.772210  =


    2023-05-06T13:31:58.777087  / # /lava-10215755/bin/lava-test-runner /la=
va-10215755/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645656d6449f6afeb32e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645656d6449f6afeb32e860b
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T13:31:43.340500  <8>[   10.945404] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10215732_1.4.2.3.1>

    2023-05-06T13:31:43.344090  + set +x

    2023-05-06T13:31:43.445745  #

    2023-05-06T13:31:43.446096  =


    2023-05-06T13:31:43.546635  / # #export SHELL=3D/bin/sh

    2023-05-06T13:31:43.546841  =


    2023-05-06T13:31:43.647429  / # export SHELL=3D/bin/sh. /lava-10215732/=
environment

    2023-05-06T13:31:43.647650  =


    2023-05-06T13:31:43.748216  / # . /lava-10215732/environment/lava-10215=
732/bin/lava-test-runner /lava-10215732/1

    2023-05-06T13:31:43.748492  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645656cc5d21800a972e8651

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645656cc5d21800a972e8656
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T13:31:45.189178  + set +x

    2023-05-06T13:31:45.195990  <8>[   10.519174] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10215713_1.4.2.3.1>

    2023-05-06T13:31:45.300319  / # #

    2023-05-06T13:31:45.400966  export SHELL=3D/bin/sh

    2023-05-06T13:31:45.401146  #

    2023-05-06T13:31:45.501673  / # export SHELL=3D/bin/sh. /lava-10215713/=
environment

    2023-05-06T13:31:45.501872  =


    2023-05-06T13:31:45.602353  / # . /lava-10215713/environment/lava-10215=
713/bin/lava-test-runner /lava-10215713/1

    2023-05-06T13:31:45.602608  =


    2023-05-06T13:31:45.606708  / # /lava-10215713/bin/lava-test-runner /la=
va-10215713/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645656bdd27774ebb22e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645656bdd27774ebb22e85f8
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T13:31:25.827858  + set +x

    2023-05-06T13:31:25.834131  <8>[   10.399554] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10215722_1.4.2.3.1>

    2023-05-06T13:31:25.936564  =


    2023-05-06T13:31:26.037213  / # #export SHELL=3D/bin/sh

    2023-05-06T13:31:26.037430  =


    2023-05-06T13:31:26.137932  / # export SHELL=3D/bin/sh. /lava-10215722/=
environment

    2023-05-06T13:31:26.138154  =


    2023-05-06T13:31:26.238713  / # . /lava-10215722/environment/lava-10215=
722/bin/lava-test-runner /lava-10215722/1

    2023-05-06T13:31:26.239065  =


    2023-05-06T13:31:26.244080  / # /lava-10215722/bin/lava-test-runner /la=
va-10215722/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645656da449f6afeb32e863f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645656da449f6afeb32e8644
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T13:31:43.143603  + <8>[   11.260496] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10215746_1.4.2.3.1>

    2023-05-06T13:31:43.143706  set +x

    2023-05-06T13:31:43.247585  / # #

    2023-05-06T13:31:43.348164  export SHELL=3D/bin/sh

    2023-05-06T13:31:43.348349  #

    2023-05-06T13:31:43.448913  / # export SHELL=3D/bin/sh. /lava-10215746/=
environment

    2023-05-06T13:31:43.449168  =


    2023-05-06T13:31:43.549698  / # . /lava-10215746/environment/lava-10215=
746/bin/lava-test-runner /lava-10215746/1

    2023-05-06T13:31:43.550051  =


    2023-05-06T13:31:43.554785  / # /lava-10215746/bin/lava-test-runner /la=
va-10215746/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645657a1070909b8232e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645657a1070909b8232e85eb
        failing since 99 days (last pass: v5.15.81-121-gcb14018a85f6, first=
 fail: v5.15.90-146-gbf7101723cc0)

    2023-05-06T13:35:07.219488  + set +x
    2023-05-06T13:35:07.219793  [    9.428888] <LAVA_SIGNAL_ENDRUN 0_dmesg =
942031_1.5.2.3.1>
    2023-05-06T13:35:07.327699  / # #
    2023-05-06T13:35:07.429496  export SHELL=3D/bin/sh
    2023-05-06T13:35:07.430001  #
    2023-05-06T13:35:07.531276  / # export SHELL=3D/bin/sh. /lava-942031/en=
vironment
    2023-05-06T13:35:07.531813  =

    2023-05-06T13:35:07.633258  / # . /lava-942031/environment/lava-942031/=
bin/lava-test-runner /lava-942031/1
    2023-05-06T13:35:07.633947  =

    2023-05-06T13:35:07.636252  / # /lava-942031/bin/lava-test-runner /lava=
-942031/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645656ce449f6afeb32e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645656ce449f6afeb32e85eb
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-06T13:31:42.662977  <8>[   11.740749] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10215737_1.4.2.3.1>

    2023-05-06T13:31:42.767964  / # #

    2023-05-06T13:31:42.868874  export SHELL=3D/bin/sh

    2023-05-06T13:31:42.869215  #

    2023-05-06T13:31:42.969858  / # export SHELL=3D/bin/sh. /lava-10215737/=
environment

    2023-05-06T13:31:42.970053  =


    2023-05-06T13:31:43.070588  / # . /lava-10215737/environment/lava-10215=
737/bin/lava-test-runner /lava-10215737/1

    2023-05-06T13:31:43.070845  =


    2023-05-06T13:31:43.075799  / # /lava-10215737/bin/lava-test-runner /la=
va-10215737/1

    2023-05-06T13:31:43.080989  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6456550ee58e8e3ab12e8729

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6456550ee58e8e3ab12e8743
        new failure (last pass: v5.15.105-406-g93046c7116de)

    2023-05-06T13:24:11.317549  /lava-10215612/1/../bin/lava-test-case

    2023-05-06T13:24:11.323736  <8>[   61.572559] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6456550ee58e8e3ab12e8743
        new failure (last pass: v5.15.105-406-g93046c7116de)

    2023-05-06T13:24:11.317549  /lava-10215612/1/../bin/lava-test-case

    2023-05-06T13:24:11.323736  <8>[   61.572559] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6456550ee58e8e3ab12e8745
        new failure (last pass: v5.15.105-406-g93046c7116de)

    2023-05-06T13:24:10.276762  /lava-10215612/1/../bin/lava-test-case

    2023-05-06T13:24:10.283429  <8>[   60.531959] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6456550ee58e8e3ab12e87cd
        new failure (last pass: v5.15.105-406-g93046c7116de)

    2023-05-06T13:23:56.117566  <8>[   46.369964] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10215612_1.5.2.3.1>

    2023-05-06T13:23:56.120661  + set +x

    2023-05-06T13:23:56.224967  / # #

    2023-05-06T13:23:56.325540  export SHELL=3D/bin/sh

    2023-05-06T13:23:56.325702  #

    2023-05-06T13:23:56.426190  / # export SHELL=3D/bin/sh. /lava-10215612/=
environment

    2023-05-06T13:23:56.426346  =


    2023-05-06T13:23:56.526869  / # . /lava-10215612/environment/lava-10215=
612/bin/lava-test-runner /lava-10215612/1

    2023-05-06T13:23:56.527101  =


    2023-05-06T13:23:56.531504  / # /lava-10215612/bin/lava-test-runner /la=
va-10215612/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64565559b373de46422e85e6

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-716-g0ba96946e8d1/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64565559b373de46422e860f
        failing since 108 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-06T13:24:26.323183  + set +x
    2023-05-06T13:24:26.327308  <8>[   15.994584] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3556013_1.5.2.4.1>
    2023-05-06T13:24:26.448984  / # #
    2023-05-06T13:24:26.554657  export SHELL=3D/bin/sh
    2023-05-06T13:24:26.556386  #
    2023-05-06T13:24:26.659958  / # export SHELL=3D/bin/sh. /lava-3556013/e=
nvironment
    2023-05-06T13:24:26.662006  =

    2023-05-06T13:24:26.765807  / # . /lava-3556013/environment/lava-355601=
3/bin/lava-test-runner /lava-3556013/1
    2023-05-06T13:24:26.768664  =

    2023-05-06T13:24:26.771886  / # /lava-3556013/bin/lava-test-runner /lav=
a-3556013/1 =

    ... (12 line(s) more)  =

 =20
