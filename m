Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB77466C0
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 03:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGDBIH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 21:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDBIG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 21:08:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC7D185
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:08:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8918dadbdso9179065ad.1
        for <stable@vger.kernel.org>; Mon, 03 Jul 2023 18:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688432884; x=1691024884;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wgD4SR+gRpX3jFDv885tXalu630WPjQvW2agB0CI7vY=;
        b=gaJRHP3ZGUDHcTUYSf7LuaQjzUaFc/D7bTj4cmrh2ANcTzbzNX7IoOqIrIEFS35fML
         U839efsHgVGIrRDucuW75fJjNAOydFHiS6oeaUf2RAMQn55KQ+2Q4ZB+yORXsZWGgunl
         YoMJlRBIJgt3JfrPsrHOt1KSW0fKrLI3DW4cs4mpStiw2R7EgLa8FYD0qLRtiD59R47K
         qxTFD91MXb2x2aiUxsK0I4RwcGG871kHXj45h+kZfAByyReR467NZ3XSn5ZLW7CIkdqH
         JI6/9jfi7qArFX1U4iB5bfL06YFgArB8Ek/3+ziTxY6LqgPNvhuDCJ5SPJ2R7ssROrs9
         HPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688432884; x=1691024884;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgD4SR+gRpX3jFDv885tXalu630WPjQvW2agB0CI7vY=;
        b=hrsMKlZU6LwV0TRp+oLZZBYWT9587hbuUDKSzyxoF0YtS/QIaHqqOxqxeB2rb7SuPB
         Ns4b5cgg0ZM1O8wQjHu+xVNkOK9HNWKRY/qEzSAABjvJZCCqITBtvW/QI2HShvvoAC0E
         R9ouF8UCjYPooZRoaanhNNJG40HMJWY6WBELLPHTfFOK5+JB3lOJM022rvRUtxnWVXq9
         PuIhVimLgAzMyca9fqneyj/M5LItVT78MbG6nMHoXDzuxVwXLSxmqxZRHkRzp2LcApZ1
         MBmdM8GH7jQ+3TawJnUjlFfhRld9sC9r2Fo10AYa1CiFdloL9dPY8piDBina7lR0XUAE
         qMvQ==
X-Gm-Message-State: ABy/qLbzSEERPs0TDFAeJk/iC9yxvIlKsApvB2yTueOUq9pjz7akm2As
        HDI8R5Ab86Vmgq5aq5755dDXglcV62fViRfj25bLQg==
X-Google-Smtp-Source: APBJJlH+l+NpvR4vq65onjce92GRZhviQhxjJLBs1hlpXl7czUL21fvnkOqrfpCUT7C/YpCT8p++Cg==
X-Received: by 2002:a17:903:11c6:b0:1ac:8475:87c5 with SMTP id q6-20020a17090311c600b001ac847587c5mr11472835plh.56.1688432884520;
        Mon, 03 Jul 2023 18:08:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001b3d4d74749sm15917487plq.7.2023.07.03.18.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 18:08:03 -0700 (PDT)
Message-ID: <64a370f3.170a0220.24e4c.eaa9@mx.google.com>
Date:   Mon, 03 Jul 2023 18:08:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.186-12-ga5e7c39a80ad
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 114 runs,
 4 regressions (v5.10.186-12-ga5e7c39a80ad)
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

stable-rc/linux-5.10.y baseline: 114 runs, 4 regressions (v5.10.186-12-ga5e=
7c39a80ad)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.186-12-ga5e7c39a80ad/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.186-12-ga5e7c39a80ad
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a5e7c39a80ad721c67b797ff18634bcaea0bf5e7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33cb6fd449919e5bb2ac1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-ga5e7c39a80ad/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-ga5e7c39a80ad/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33cb6fd449919e5bb2ac6
        failing since 166 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-07-03T21:24:45.843608  + set +x<8>[   11.124479] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3708671_1.5.2.4.1>
    2023-07-03T21:24:45.844001  =

    2023-07-03T21:24:45.951741  / # #
    2023-07-03T21:24:46.055164  export SHELL=3D/bin/sh
    2023-07-03T21:24:46.056318  #
    2023-07-03T21:24:46.056937  / # <3>[   11.292577] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-07-03T21:24:46.159088  export SHELL=3D/bin/sh. /lava-3708671/envir=
onment
    2023-07-03T21:24:46.160248  =

    2023-07-03T21:24:46.262471  / # . /lava-3708671/environment/lava-370867=
1/bin/lava-test-runner /lava-3708671/1
    2023-07-03T21:24:46.263033   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a338b7fd2b922066bb2aaf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-ga5e7c39a80ad/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-ga5e7c39a80ad/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a338b7fd2b922066bb2ab4
        failing since 97 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-07-03T21:07:48.936277  + set +x

    2023-07-03T21:07:48.942862  <8>[   10.394085] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10998434_1.4.2.3.1>

    2023-07-03T21:07:49.047439  / # #

    2023-07-03T21:07:49.148028  export SHELL=3D/bin/sh

    2023-07-03T21:07:49.148194  #

    2023-07-03T21:07:49.248765  / # export SHELL=3D/bin/sh. /lava-10998434/=
environment

    2023-07-03T21:07:49.248953  =


    2023-07-03T21:07:49.349527  / # . /lava-10998434/environment/lava-10998=
434/bin/lava-test-runner /lava-10998434/1

    2023-07-03T21:07:49.349794  =


    2023-07-03T21:07:49.354593  / # /lava-10998434/bin/lava-test-runner /la=
va-10998434/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33a63c7f78d2a35bb2ab9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-ga5e7c39a80ad/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-=
iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-ga5e7c39a80ad/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-=
iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a33a63c7f78d2a35bb2=
aba
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a33d320ff7c93280bb2ac9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-ga5e7c39a80ad/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm=
32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-12-ga5e7c39a80ad/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm=
32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a33d320ff7c93280bb2ace
        failing since 150 days (last pass: v5.10.147, first fail: v5.10.166=
-10-g6278b8c9832e)

    2023-07-03T21:26:58.173624  <8>[  211.906046] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3708673_1.5.2.4.1>
    2023-07-03T21:26:58.279430  / # #
    2023-07-03T21:26:58.381056  export SHELL=3D/bin/sh
    2023-07-03T21:26:58.381451  #
    2023-07-03T21:26:58.482667  / # export SHELL=3D/bin/sh. /lava-3708673/e=
nvironment
    2023-07-03T21:26:58.483073  =

    2023-07-03T21:26:58.584330  / # . /lava-3708673/environment/lava-370867=
3/bin/lava-test-runner /lava-3708673/1
    2023-07-03T21:26:58.585008  =

    2023-07-03T21:26:58.588651  / # /lava-3708673/bin/lava-test-runner /lav=
a-3708673/1
    2023-07-03T21:26:58.654569  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
