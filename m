Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D46786383
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 00:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbjHWWky (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 18:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbjHWWk2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 18:40:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA6710D3
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 15:40:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a410316a2so2879323b3a.0
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692830424; x=1693435224;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=16nit7UmxCo0cLgdUcY4GBaCMx+IU1j5DPMOompYAd4=;
        b=H2Eg3516RDGVQm/dxLHKEOlsf8+Q4f3MkIMBSZhma6Es5Lt8l4/dmDCgiGWZzvzxAX
         Auv20rPnH8cd3XeSh3cizDqq9JPoAwhnABSlLwc6FlTsa0fX1J177mcsFKXgyHrKvA0o
         eiLVQW3T120x7iqQyJQ4rTkUcEcYDZexk8Vpqp0Kd6aJ4BwzWW460oz4itGeTVs3NTxE
         D6Fi3J2MIVoYrG1Il5sayjjyvJh+HMdCDGHNE48eCnxAWC67wABCa49Ul6JRm/xoQcID
         23ikrmXY1pLkQELh83qfUYmfZ61aSKPAj5nBPr7t0L/mdVLlK+/4GuYgtNumCWZksi6L
         6bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830424; x=1693435224;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16nit7UmxCo0cLgdUcY4GBaCMx+IU1j5DPMOompYAd4=;
        b=h51BSgOHEmq54hX/Sf7G3si1SR1dAy6NYfVqDZt84rLigvFE8Igrq4UalPxxtWbjUe
         /l4a+MIJgJOLxVPpXq7iOc0+cTsn5Jyy52fh4NE0XN4civJm8d1iHsaal6wATghRMp8t
         DrFxtK19295fnJsb5KRVRvO7DlsmhPpLPPUUwnn6VtxmT7fxcY0JJ17G0k0XmHn6BXrd
         NoYD/LkY1vYFS3DGB/sQjF5zI5A0BWuDc7yaqPL/JGFibTGNkT8lwn5Sbg50M2iux4tZ
         RAjx7zjLJTtLcojMz+WtCJTFDRcaJnanBjCaxw12LlB2ZkGgTmM0mN784Fu9qQFhmz0V
         MnFQ==
X-Gm-Message-State: AOJu0YwBNrUQhx0j995aUJ+S4DoagTBcJ8pBNcL0d9LdycFGUxMV6qN9
        VGCoqyhX/yiNUkLwTQCrZGooTZH+dj/P5UOx4tw=
X-Google-Smtp-Source: AGHT+IGqOsYNdXXAQym2NBEQZoyT9HCTQAg9w3bqMdUzbLndObULrtj7AqOKKFUGuM06YDEGnpfl7w==
X-Received: by 2002:a05:6a21:3d86:b0:147:c29e:4c31 with SMTP id bj6-20020a056a213d8600b00147c29e4c31mr11296221pzc.55.1692830424299;
        Wed, 23 Aug 2023 15:40:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001bf8779e051sm6680344plc.289.2023.08.23.15.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 15:40:23 -0700 (PDT)
Message-ID: <64e68ad7.170a0220.3f704.ee18@mx.google.com>
Date:   Wed, 23 Aug 2023 15:40:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.47
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-6.1.y
Subject: stable/linux-6.1.y baseline: 125 runs, 12 regressions (v6.1.47)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y baseline: 125 runs, 12 regressions (v6.1.47)

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

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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
v6.1.47/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.47
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      802aacbbffe2512dce9f8f33ad99d01cfec435de =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654f27bac0b774ab1e408

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e654f27bac0b774ab1e40d
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T18:51:19.015573  <8>[   10.094246] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11338559_1.4.2.3.1>

    2023-08-23T18:51:19.018608  + set +x

    2023-08-23T18:51:19.120029  =


    2023-08-23T18:51:19.220678  / # #export SHELL=3D/bin/sh

    2023-08-23T18:51:19.220905  =


    2023-08-23T18:51:19.321479  / # export SHELL=3D/bin/sh. /lava-11338559/=
environment

    2023-08-23T18:51:19.321700  =


    2023-08-23T18:51:19.422262  / # . /lava-11338559/environment/lava-11338=
559/bin/lava-test-runner /lava-11338559/1

    2023-08-23T18:51:19.422537  =


    2023-08-23T18:51:19.428306  / # /lava-11338559/bin/lava-test-runner /la=
va-11338559/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654e76759f3e19db1e3ce

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e654e76759f3e19db1e3d3
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T18:50:01.519955  + set<8>[   10.997303] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11338591_1.4.2.3.1>

    2023-08-23T18:50:01.520041   +x

    2023-08-23T18:50:01.624475  / # #

    2023-08-23T18:50:01.725226  export SHELL=3D/bin/sh

    2023-08-23T18:50:01.725442  #

    2023-08-23T18:50:01.826029  / # export SHELL=3D/bin/sh. /lava-11338591/=
environment

    2023-08-23T18:50:01.826382  =


    2023-08-23T18:50:01.927159  / # . /lava-11338591/environment/lava-11338=
591/bin/lava-test-runner /lava-11338591/1

    2023-08-23T18:50:01.928310  =


    2023-08-23T18:50:01.933565  / # /lava-11338591/bin/lava-test-runner /la=
va-11338591/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654e4f844d015dfb1e3b5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e654e4f844d015dfb1e3ba
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T18:49:58.267352  <8>[   10.075123] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11338551_1.4.2.3.1>

    2023-08-23T18:49:58.270610  + set +x

    2023-08-23T18:49:58.372059  /#

    2023-08-23T18:49:58.472980   # #export SHELL=3D/bin/sh

    2023-08-23T18:49:58.473136  =


    2023-08-23T18:49:58.573588  / # export SHELL=3D/bin/sh. /lava-11338551/=
environment

    2023-08-23T18:49:58.573847  =


    2023-08-23T18:49:58.674446  / # . /lava-11338551/environment/lava-11338=
551/bin/lava-test-runner /lava-11338551/1

    2023-08-23T18:49:58.674808  =


    2023-08-23T18:49:58.680137  / # /lava-11338551/bin/lava-test-runner /la=
va-11338551/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e6573fa918d52819b1e3b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e6573fa918d52819b1e=
3b2
        new failure (last pass: v6.1.46) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654d7e82ba8f499b1e48b

  Results:     18 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-11A-G6=
-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-11A-G6=
-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.tpm-chip-is-online: https://kernelci.org/test/case/id/6=
4e654d7e82ba8f499b1e49a
        new failure (last pass: v6.1.46)

    2023-08-23T18:49:42.195443  /usr/bin/tpm2_getcap

    2023-08-23T18:49:52.414334  /lava-11338571/1/../bin/lava-test-case

    2023-08-23T18:49:52.419810  <8>[   20.860364] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654f4f844d015dfb1e426

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e654f4f844d015dfb1e42b
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T18:50:10.902398  + set +x

    2023-08-23T18:50:10.908499  <8>[   10.237729] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11338596_1.4.2.3.1>

    2023-08-23T18:50:11.013133  / # #

    2023-08-23T18:50:11.113776  export SHELL=3D/bin/sh

    2023-08-23T18:50:11.113967  #

    2023-08-23T18:50:11.214454  / # export SHELL=3D/bin/sh. /lava-11338596/=
environment

    2023-08-23T18:50:11.214658  =


    2023-08-23T18:50:11.315228  / # . /lava-11338596/environment/lava-11338=
596/bin/lava-test-runner /lava-11338596/1

    2023-08-23T18:50:11.315498  =


    2023-08-23T18:50:11.320375  / # /lava-11338596/bin/lava-test-runner /la=
va-11338596/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654cfd5039a8819b1e3b3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e654cfd5039a8819b1e3b8
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T18:49:35.239672  <8>[    7.701485] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11338590_1.4.2.3.1>

    2023-08-23T18:49:35.243236  + set +x

    2023-08-23T18:49:35.350850  / # #

    2023-08-23T18:49:35.453082  export SHELL=3D/bin/sh

    2023-08-23T18:49:35.453802  #

    2023-08-23T18:49:35.555252  / # export SHELL=3D/bin/sh. /lava-11338590/=
environment

    2023-08-23T18:49:35.556324  =


    2023-08-23T18:49:35.657955  / # . /lava-11338590/environment/lava-11338=
590/bin/lava-test-runner /lava-11338590/1

    2023-08-23T18:49:35.659133  =


    2023-08-23T18:49:35.664450  / # /lava-11338590/bin/lava-test-runner /la=
va-11338590/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654f223df3aa1b4b1e3b2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e654f223df3aa1b4b1e3b7
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T18:50:06.648405  + <8>[   11.509880] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11338557_1.4.2.3.1>

    2023-08-23T18:50:06.648491  set +x

    2023-08-23T18:50:06.752646  / # #

    2023-08-23T18:50:06.853277  export SHELL=3D/bin/sh

    2023-08-23T18:50:06.853474  #

    2023-08-23T18:50:06.954048  / # export SHELL=3D/bin/sh. /lava-11338557/=
environment

    2023-08-23T18:50:06.954237  =


    2023-08-23T18:50:07.054786  / # . /lava-11338557/environment/lava-11338=
557/bin/lava-test-runner /lava-11338557/1

    2023-08-23T18:50:07.055065  =


    2023-08-23T18:50:07.059731  / # /lava-11338557/bin/lava-test-runner /la=
va-11338557/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654d1303587fb07b1e3db

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e654d1303587fb07b1e3e0
        failing since 146 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-23T18:49:41.471877  + set<8>[   12.466497] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11338569_1.4.2.3.1>

    2023-08-23T18:49:41.472444   +x

    2023-08-23T18:49:41.580893  / # #

    2023-08-23T18:49:41.683845  export SHELL=3D/bin/sh

    2023-08-23T18:49:41.684662  #

    2023-08-23T18:49:41.786386  / # export SHELL=3D/bin/sh. /lava-11338569/=
environment

    2023-08-23T18:49:41.787214  =


    2023-08-23T18:49:41.888856  / # . /lava-11338569/environment/lava-11338=
569/bin/lava-test-runner /lava-11338569/1

    2023-08-23T18:49:41.890200  =


    2023-08-23T18:49:41.894838  / # /lava-11338569/bin/lava-test-runner /la=
va-11338569/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654b3f19f095554b1e3ba

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e654b3f19f095554b1e3bf
        failing since 35 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-23T18:50:51.053271  / # #

    2023-08-23T18:50:51.155402  export SHELL=3D/bin/sh

    2023-08-23T18:50:51.156112  #

    2023-08-23T18:50:51.257596  / # export SHELL=3D/bin/sh. /lava-11338549/=
environment

    2023-08-23T18:50:51.258311  =


    2023-08-23T18:50:51.359803  / # . /lava-11338549/environment/lava-11338=
549/bin/lava-test-runner /lava-11338549/1

    2023-08-23T18:50:51.360938  =


    2023-08-23T18:50:51.377520  / # /lava-11338549/bin/lava-test-runner /la=
va-11338549/1

    2023-08-23T18:50:51.425317  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T18:50:51.425811  + cd /lav<8>[   19.116806] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11338549_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654d6d5039a8819b1e40c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e654d6d5039a8819b1e411
        failing since 35 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-23T18:50:37.996101  / # #

    2023-08-23T18:50:39.070754  export SHELL=3D/bin/sh

    2023-08-23T18:50:39.072015  #

    2023-08-23T18:50:40.560463  / # export SHELL=3D/bin/sh. /lava-11338547/=
environment

    2023-08-23T18:50:40.562317  =


    2023-08-23T18:50:43.275893  / # . /lava-11338547/environment/lava-11338=
547/bin/lava-test-runner /lava-11338547/1

    2023-08-23T18:50:43.277343  =


    2023-08-23T18:50:43.279235  / # /lava-11338547/bin/lava-test-runner /la=
va-11338547/1

    2023-08-23T18:50:43.344750  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T18:50:43.344826  + cd /lava-113385<8>[   28.448560] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11338547_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e654c7f19f095554b1e3c9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.47/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e654c7f19f095554b1e3ce
        failing since 35 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-23T18:51:01.065880  / # #

    2023-08-23T18:51:01.167996  export SHELL=3D/bin/sh

    2023-08-23T18:51:01.168706  #

    2023-08-23T18:51:01.270135  / # export SHELL=3D/bin/sh. /lava-11338548/=
environment

    2023-08-23T18:51:01.270843  =


    2023-08-23T18:51:01.372235  / # . /lava-11338548/environment/lava-11338=
548/bin/lava-test-runner /lava-11338548/1

    2023-08-23T18:51:01.373260  =


    2023-08-23T18:51:01.390061  / # /lava-11338548/bin/lava-test-runner /la=
va-11338548/1

    2023-08-23T18:51:01.454318  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T18:51:01.454840  + cd /lava-1133854<8>[   18.678661] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11338548_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
