Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1B799A7C
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbjIISxy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 14:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbjIISxx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 14:53:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946C1180
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 11:53:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26d49cf1811so2158699a91.0
        for <stable@vger.kernel.org>; Sat, 09 Sep 2023 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694285625; x=1694890425; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O93B/SdVyFrJt19FlSDcXolOwPbn5w9VauGfVZh70vQ=;
        b=PvgOxcyrUowxQ9KmBDNDeyvTX3vQeVWevuziCN6OmShNf/u404jazl/j9M0LnxELmn
         +Ofk2JRqCzVEWwznhnkzVfgByRgrQCQ+QeaLHFRPFPtyhOkcHSmnQToEObihyqAtCJ+E
         5uG8hL8Tj57QFxWZaxeOaRVrHXk3j71vTMi88DOTtPA8BMnfAV1cHuCvAfrzmr4eDsG4
         T2tLZ2NtwNak3S53eQH/fLDSiPQVmFB5xY1teYVP2/XhvKqb59AB6wA7hVZQhBPjMDfN
         xfvyppJbdLcaroD1RP+tkGTtFCb2anEz/ZCEOcdDyWFAjdzrQea2TRbGR8bWCEgiAT67
         rIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694285625; x=1694890425;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O93B/SdVyFrJt19FlSDcXolOwPbn5w9VauGfVZh70vQ=;
        b=VIq8Hkjy39FF5EC5JnQg5mUh9rMh5NX+Htf689hNhzvzfO0JkDh6opFDA21+eA6t6j
         TuuU/3uQDE/GzCyxeGqq+7VlEcZ20pUR23ITv0KFI1eskkK2L01CquGPc4sWrhiRZ786
         UAemql8+8EyfDEykMMCSkNYec5QBj27lGIr20HSSAmsbSVq93RyzxyEWGYHw74KbM64X
         oeBt135A+Bj8linzqsMBxg88tXMRrLhcbeZIsjBaBi63RUoOhyOjcUJQ36ILqwq+0JhP
         2d1UKsklvPtSTq5qqOW8zvsgaWy+Z/vA2ZHLEH0vBwtVq1CucrmEwelPcHMNmgVZpDjO
         fykw==
X-Gm-Message-State: AOJu0YyoRNr7QhOoikwFpcOO3knHVtsXi0VvGB07+/9N89GmuHvkwuP1
        tlg4FwSTBDm8ucWq1NVHjgbQeyq+G+MxMdNVt+s=
X-Google-Smtp-Source: AGHT+IEgVyB+cJ1/f7H3on1RzGkD1agDAPXf5fl8vEmky9w6Pf78ntMKEkUMlpZS1xSDSmpWFQ6KAg==
X-Received: by 2002:a17:90a:7406:b0:269:5b17:24b6 with SMTP id a6-20020a17090a740600b002695b1724b6mr5012456pjg.9.1694285625362;
        Sat, 09 Sep 2023 11:53:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mi12-20020a17090b4b4c00b00267ee71f463sm7112853pjb.0.2023.09.09.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:53:44 -0700 (PDT)
Message-ID: <64fcbf38.170a0220.7fa2.2774@mx.google.com>
Date:   Sat, 09 Sep 2023 11:53:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.52-547-g2c143bb82ef6
Subject: stable-rc/linux-6.1.y baseline: 111 runs,
 10 regressions (v6.1.52-547-g2c143bb82ef6)
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

stable-rc/linux-6.1.y baseline: 111 runs, 10 regressions (v6.1.52-547-g2c14=
3bb82ef6)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.52-547-g2c143bb82ef6/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.52-547-g2c143bb82ef6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2c143bb82ef604a05e60e974918e8e020b8f6e27 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8b8e1e3d8dc497286d6f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8b8f1e3d8dc497286d78
        failing since 163 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-09T15:13:04.075786  <8>[   10.159393] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11480780_1.4.2.3.1>

    2023-09-09T15:13:04.078803  + set +x

    2023-09-09T15:13:04.182903  / # #

    2023-09-09T15:13:04.283499  export SHELL=3D/bin/sh

    2023-09-09T15:13:04.283731  #

    2023-09-09T15:13:04.384303  / # export SHELL=3D/bin/sh. /lava-11480780/=
environment

    2023-09-09T15:13:04.384524  =


    2023-09-09T15:13:04.485073  / # . /lava-11480780/environment/lava-11480=
780/bin/lava-test-runner /lava-11480780/1

    2023-09-09T15:13:04.485348  =


    2023-09-09T15:13:04.490890  / # /lava-11480780/bin/lava-test-runner /la=
va-11480780/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8b11ad225db016286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8b11ad225db016286d75
        failing since 163 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-09T15:11:02.804096  + set<8>[   11.099831] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11480787_1.4.2.3.1>

    2023-09-09T15:11:02.804229   +x

    2023-09-09T15:11:02.908957  / # #

    2023-09-09T15:11:03.009821  export SHELL=3D/bin/sh

    2023-09-09T15:11:03.010034  #

    2023-09-09T15:11:03.110584  / # export SHELL=3D/bin/sh. /lava-11480787/=
environment

    2023-09-09T15:11:03.110794  =


    2023-09-09T15:11:03.211373  / # . /lava-11480787/environment/lava-11480=
787/bin/lava-test-runner /lava-11480787/1

    2023-09-09T15:11:03.211650  =


    2023-09-09T15:11:03.216338  / # /lava-11480787/bin/lava-test-runner /la=
va-11480787/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8b8be7be5b09ba286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8b8be7be5b09ba286d75
        failing since 163 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-09T15:12:58.229842  <8>[   10.104784] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11480764_1.4.2.3.1>

    2023-09-09T15:12:58.233070  + set +x

    2023-09-09T15:12:58.338456  /#

    2023-09-09T15:12:58.439395   # #export SHELL=3D/bin/sh

    2023-09-09T15:12:58.439627  =


    2023-09-09T15:12:58.540158  / # export SHELL=3D/bin/sh. /lava-11480764/=
environment

    2023-09-09T15:12:58.540352  =


    2023-09-09T15:12:58.640936  / # . /lava-11480764/environment/lava-11480=
764/bin/lava-test-runner /lava-11480764/1

    2023-09-09T15:12:58.641275  =


    2023-09-09T15:12:58.646296  / # /lava-11480764/bin/lava-test-runner /la=
va-11480764/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8b8f59607d9c9e286d7b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8b8f59607d9c9e286d84
        failing since 163 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-09T15:14:12.623983  + set +x

    2023-09-09T15:14:12.630298  <8>[   10.632381] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11480790_1.4.2.3.1>

    2023-09-09T15:14:12.734613  / # #

    2023-09-09T15:14:12.835309  export SHELL=3D/bin/sh

    2023-09-09T15:14:12.835522  #

    2023-09-09T15:14:12.936083  / # export SHELL=3D/bin/sh. /lava-11480790/=
environment

    2023-09-09T15:14:12.936269  =


    2023-09-09T15:14:13.036808  / # . /lava-11480790/environment/lava-11480=
790/bin/lava-test-runner /lava-11480790/1

    2023-09-09T15:14:13.037072  =


    2023-09-09T15:14:13.042309  / # /lava-11480790/bin/lava-test-runner /la=
va-11480790/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8b9fb193dd5c5c286d8b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8b9fb193dd5c5c286d94
        failing since 163 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-09T15:13:22.007565  + set<8>[   10.933635] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11480767_1.4.2.3.1>

    2023-09-09T15:13:22.007680   +x

    2023-09-09T15:13:22.111907  / # #

    2023-09-09T15:13:22.212630  export SHELL=3D/bin/sh

    2023-09-09T15:13:22.212831  #

    2023-09-09T15:13:22.313389  / # export SHELL=3D/bin/sh. /lava-11480767/=
environment

    2023-09-09T15:13:22.313622  =


    2023-09-09T15:13:22.414214  / # . /lava-11480767/environment/lava-11480=
767/bin/lava-test-runner /lava-11480767/1

    2023-09-09T15:13:22.414524  =


    2023-09-09T15:13:22.419620  / # /lava-11480767/bin/lava-test-runner /la=
va-11480767/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8dd2026012eea8286da1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-im=
x6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-im=
x6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8dd2026012eea8286daa
        new failure (last pass: v6.1.52)

    2023-09-09T15:22:33.926886  + set[   15.020351] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 999967_1.5.2.3.1>
    2023-09-09T15:22:33.927080   +x
    2023-09-09T15:22:34.033686  / # #
    2023-09-09T15:22:34.135195  export SHELL=3D/bin/sh
    2023-09-09T15:22:34.135647  #
    2023-09-09T15:22:34.236913  / # export SHELL=3D/bin/sh. /lava-999967/en=
vironment
    2023-09-09T15:22:34.237317  =

    2023-09-09T15:22:34.338524  / # . /lava-999967/environment/lava-999967/=
bin/lava-test-runner /lava-999967/1
    2023-09-09T15:22:34.339051  =

    2023-09-09T15:22:34.342073  / # /lava-999967/bin/lava-test-runner /lava=
-999967/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8b69d0fc8237d7286d74

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8b69d0fc8237d7286d7d
        failing since 163 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-09T15:12:23.962703  <8>[   11.670646] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11480775_1.4.2.3.1>

    2023-09-09T15:12:24.067079  / # #

    2023-09-09T15:12:24.167726  export SHELL=3D/bin/sh

    2023-09-09T15:12:24.167951  #

    2023-09-09T15:12:24.268456  / # export SHELL=3D/bin/sh. /lava-11480775/=
environment

    2023-09-09T15:12:24.268672  =


    2023-09-09T15:12:24.369191  / # . /lava-11480775/environment/lava-11480=
775/bin/lava-test-runner /lava-11480775/1

    2023-09-09T15:12:24.369603  =


    2023-09-09T15:12:24.373454  / # /lava-11480775/bin/lava-test-runner /la=
va-11480775/1

    2023-09-09T15:12:24.380447  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8d30b4115f8c4a286d9c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8d30b4115f8c4a286da5
        failing since 53 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-09T15:21:48.030727  / # #

    2023-09-09T15:21:48.133158  export SHELL=3D/bin/sh

    2023-09-09T15:21:48.133918  #

    2023-09-09T15:21:48.235357  / # export SHELL=3D/bin/sh. /lava-11480937/=
environment

    2023-09-09T15:21:48.236129  =


    2023-09-09T15:21:48.337605  / # . /lava-11480937/environment/lava-11480=
937/bin/lava-test-runner /lava-11480937/1

    2023-09-09T15:21:48.338822  =


    2023-09-09T15:21:48.355508  / # /lava-11480937/bin/lava-test-runner /la=
va-11480937/1

    2023-09-09T15:21:48.403842  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-09T15:21:48.404361  + cd /lav<8>[   19.107510] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11480937_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8d64342853ec95286d7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8d64342853ec95286d83
        failing since 53 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-09T15:22:08.078367  / # #

    2023-09-09T15:22:09.155494  export SHELL=3D/bin/sh

    2023-09-09T15:22:09.156775  #

    2023-09-09T15:22:10.644816  / # export SHELL=3D/bin/sh. /lava-11480943/=
environment

    2023-09-09T15:22:10.646705  =


    2023-09-09T15:22:13.367517  / # . /lava-11480943/environment/lava-11480=
943/bin/lava-test-runner /lava-11480943/1

    2023-09-09T15:22:13.369731  =


    2023-09-09T15:22:13.372272  / # /lava-11480943/bin/lava-test-runner /la=
va-11480943/1

    2023-09-09T15:22:13.436855  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-09T15:22:13.436936  + cd /lava-114809<8>[   28.503077] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11480943_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fc8d434486386563286d83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
547-g2c143bb82ef6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fc8d434486386563286d8c
        failing since 53 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-09T15:21:57.558441  / # #

    2023-09-09T15:21:57.660509  export SHELL=3D/bin/sh

    2023-09-09T15:21:57.661253  #

    2023-09-09T15:21:57.762604  / # export SHELL=3D/bin/sh. /lava-11480944/=
environment

    2023-09-09T15:21:57.763348  =


    2023-09-09T15:21:57.864715  / # . /lava-11480944/environment/lava-11480=
944/bin/lava-test-runner /lava-11480944/1

    2023-09-09T15:21:57.865855  =


    2023-09-09T15:21:57.882648  / # /lava-11480944/bin/lava-test-runner /la=
va-11480944/1

    2023-09-09T15:21:57.950701  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-09T15:21:57.951192  + cd /lava-1148094<8>[   16.911973] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11480944_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
