Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D36FEAC7
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 06:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbjEKEig (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 00:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjEKEif (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 00:38:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6225B1FD6
        for <stable@vger.kernel.org>; Wed, 10 May 2023 21:38:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaed87d8bdso58060645ad.3
        for <stable@vger.kernel.org>; Wed, 10 May 2023 21:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683779911; x=1686371911;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aU+vDobEa0YK/ETxUpYAzY4c1jPjn0/xAw7cAQfDjKo=;
        b=PnlG2YKAjlGKzlfvZPjmVm7TgK75w6aREna8lJogZu1tNm+dua0Tp3oUp3q570rkJd
         yH7/wBVAaY9iuP8HE3A5Ft56hDUaaal7t+zuebUFCsqY8zHoqB8InNb4eLqIc24N0jRu
         6GTPCcP24xm5scM9LpZardejowViM4Xlz9Ubuw+wwHfUceoc9XiyVaRS/UYDyobdbCSQ
         UxFmV089B619VJdPM67RSW0eev9mquWZeKKBpFtFMAti0aZ4oG9Zfpacf0b8wHLqvszD
         FhEk+zW5rAJX6BfJwGyq2Fmv2S6d9eZFluUJBNJlgDndVkEu3M/AwIy7+4GXbHsloNEH
         XZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683779911; x=1686371911;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU+vDobEa0YK/ETxUpYAzY4c1jPjn0/xAw7cAQfDjKo=;
        b=XWN1pjre1ERGMtK70TIh/RFdt9EoiFgL2xOizaWcF2+OqnXGzDSVhs11AJYhSwyLl8
         ydg1mTrfqaUqWelh/gTOPxEg6p0F388rEhFXJlT9wAyY31Utb4WWF5V1O7vUPMfJck9o
         eIEHy2hINAsAw1xTfHrOvSoY9YoFZUFJrlYhGA8dKynpmJ8WFMbDJrotFlGfyTE4M0h7
         TdNr0/8NCsy9OQeBxYOjZy0r0ak0j0LIgBp7VWi3lFtLWCnIdHvL9CyADO8wNwFcO/n2
         bqNv4T0BJjtp71wshZHWZaS80ZviKwvFdxpQ635QvOhFptgqkcycOlAvXb6SycUZI707
         sOAA==
X-Gm-Message-State: AC+VfDwQyMVuGqq8X760ruRCwDQCKwGTW/aDgFhgOjF8OJ+4/ehAw1My
        dkTmN5urWl7baZsd0s60vTY7d+WBLPDoTu77UOGi6w==
X-Google-Smtp-Source: ACHHUZ60NHweUYNv5VGWcFH7bAEgsmcvs/MlrIZi/NhamCuXnPVAa9Lu1WAazWgsZGcJnyzreKy2yQ==
X-Received: by 2002:a17:902:f391:b0:1ab:275:5abf with SMTP id f17-20020a170902f39100b001ab02755abfmr16584957ple.55.1683779910625;
        Wed, 10 May 2023 21:38:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001a9293597efsm4674557pld.246.2023.05.10.21.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 21:38:30 -0700 (PDT)
Message-ID: <645c7146.170a0220.f5849.9ce2@mx.google.com>
Date:   Wed, 10 May 2023 21:38:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.27-610-gc6b46250d53e
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 138 runs,
 10 regressions (v6.1.27-610-gc6b46250d53e)
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

stable-rc/queue/6.1 baseline: 138 runs, 10 regressions (v6.1.27-610-gc6b462=
50d53e)

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.27-610-gc6b46250d53e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.27-610-gc6b46250d53e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c6b46250d53e859cf018d2ba8b8d2abe3fb86906 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3a36ca5f92de512e8652

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3a36ca5f92de512e8657
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T00:43:16.886324  + set +x

    2023-05-11T00:43:16.892766  <8>[   10.450531] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273266_1.4.2.3.1>

    2023-05-11T00:43:17.001585  / # #

    2023-05-11T00:43:17.104086  export SHELL=3D/bin/sh

    2023-05-11T00:43:17.104885  #

    2023-05-11T00:43:17.206682  / # export SHELL=3D/bin/sh. /lava-10273266/=
environment

    2023-05-11T00:43:17.207486  =


    2023-05-11T00:43:17.309250  / # . /lava-10273266/environment/lava-10273=
266/bin/lava-test-runner /lava-10273266/1

    2023-05-11T00:43:17.310545  =


    2023-05-11T00:43:17.316025  / # /lava-10273266/bin/lava-test-runner /la=
va-10273266/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c39af3ea9844e642e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c39af3ea9844e642e85eb
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T00:41:10.581401  + set<8>[   11.440966] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10273272_1.4.2.3.1>

    2023-05-11T00:41:10.581529   +x

    2023-05-11T00:41:10.686139  / # #

    2023-05-11T00:41:10.786809  export SHELL=3D/bin/sh

    2023-05-11T00:41:10.787007  #

    2023-05-11T00:41:10.887519  / # export SHELL=3D/bin/sh. /lava-10273272/=
environment

    2023-05-11T00:41:10.887687  =


    2023-05-11T00:41:10.988246  / # . /lava-10273272/environment/lava-10273=
272/bin/lava-test-runner /lava-10273272/1

    2023-05-11T00:41:10.988557  =


    2023-05-11T00:41:10.993232  / # /lava-10273272/bin/lava-test-runner /la=
va-10273272/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c39b5559e3397762e86dc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c39b5559e3397762e86e1
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T00:41:18.988237  <8>[   11.075837] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273281_1.4.2.3.1>

    2023-05-11T00:41:18.991393  + set +x

    2023-05-11T00:41:19.093587  =


    2023-05-11T00:41:19.194252  / # #export SHELL=3D/bin/sh

    2023-05-11T00:41:19.194562  =


    2023-05-11T00:41:19.295223  / # export SHELL=3D/bin/sh. /lava-10273281/=
environment

    2023-05-11T00:41:19.295533  =


    2023-05-11T00:41:19.396214  / # . /lava-10273281/environment/lava-10273=
281/bin/lava-test-runner /lava-10273281/1

    2023-05-11T00:41:19.396704  =


    2023-05-11T00:41:19.401490  / # /lava-10273281/bin/lava-test-runner /la=
va-10273281/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c3a0a0bdd45f83e2e864e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3a0a0bdd45f83e2e8653
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T00:42:34.375487  + set +x

    2023-05-11T00:42:34.382106  <8>[   11.397917] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273302_1.4.2.3.1>

    2023-05-11T00:42:34.486498  / # #

    2023-05-11T00:42:34.587131  export SHELL=3D/bin/sh

    2023-05-11T00:42:34.587334  #

    2023-05-11T00:42:34.687885  / # export SHELL=3D/bin/sh. /lava-10273302/=
environment

    2023-05-11T00:42:34.688124  =


    2023-05-11T00:42:34.788680  / # . /lava-10273302/environment/lava-10273=
302/bin/lava-test-runner /lava-10273302/1

    2023-05-11T00:42:34.788996  =


    2023-05-11T00:42:34.794213  / # /lava-10273302/bin/lava-test-runner /la=
va-10273302/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c39a26683dfbd532e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c39a26683dfbd532e85f8
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T00:40:51.029128  <8>[   10.467988] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273245_1.4.2.3.1>

    2023-05-11T00:40:51.032250  + set +x

    2023-05-11T00:40:51.137157  / # #

    2023-05-11T00:40:51.237823  export SHELL=3D/bin/sh

    2023-05-11T00:40:51.238004  #

    2023-05-11T00:40:51.338496  / # export SHELL=3D/bin/sh. /lava-10273245/=
environment

    2023-05-11T00:40:51.338756  =


    2023-05-11T00:40:51.439279  / # . /lava-10273245/environment/lava-10273=
245/bin/lava-test-runner /lava-10273245/1

    2023-05-11T00:40:51.439559  =


    2023-05-11T00:40:51.444343  / # /lava-10273245/bin/lava-test-runner /la=
va-10273245/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c39c13ea9844e642e8623

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c39c13ea9844e642e8628
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T00:41:14.926164  + set<8>[   11.761631] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10273307_1.4.2.3.1>

    2023-05-11T00:41:14.926268   +x

    2023-05-11T00:41:15.030660  / # #

    2023-05-11T00:41:15.131433  export SHELL=3D/bin/sh

    2023-05-11T00:41:15.131667  #

    2023-05-11T00:41:15.232257  / # export SHELL=3D/bin/sh. /lava-10273307/=
environment

    2023-05-11T00:41:15.232522  =


    2023-05-11T00:41:15.333111  / # . /lava-10273307/environment/lava-10273=
307/bin/lava-test-runner /lava-10273307/1

    2023-05-11T00:41:15.333378  =


    2023-05-11T00:41:15.337618  / # /lava-10273307/bin/lava-test-runner /la=
va-10273307/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645c39bc068e642a282e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c39bc068e642a282e85f9
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T00:41:15.851161  / # #

    2023-05-11T00:41:15.952298  export SHELL=3D/bin/sh

    2023-05-11T00:41:15.952603  #

    2023-05-11T00:41:16.053263  / # export SHELL=3D/bin/sh. /lava-10273294/=
environment

    2023-05-11T00:41:16.053540  =


    2023-05-11T00:41:16.154231  / # . /lava-10273294/environment/lava-10273=
294/bin/lava-test-runner /lava-10273294/1

    2023-05-11T00:41:16.154555  =


    2023-05-11T00:41:16.158819  / # /lava-10273294/bin/lava-test-runner /la=
va-10273294/1

    2023-05-11T00:41:16.165790  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-11T00:41:16.168897  + cd /lava-10273294/1/tests/1_bootrr
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645c3ff750f3f5faad2e8618

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645c3ff750f3f5faad2e862c
        failing since 3 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-11T01:07:41.924972  /lava-10273681/1/../bin/lava-test-case

    2023-05-11T01:07:41.931050  <8>[   22.915563] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645c3ff750f3f5faad2e86c0
        failing since 3 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-11T01:07:36.472527  + set +x

    2023-05-11T01:07:36.479691  <8>[   17.462623] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10273681_1.5.2.3.1>

    2023-05-11T01:07:36.584965  / # #

    2023-05-11T01:07:36.685750  export SHELL=3D/bin/sh

    2023-05-11T01:07:36.685999  #

    2023-05-11T01:07:36.786600  / # export SHELL=3D/bin/sh. /lava-10273681/=
environment

    2023-05-11T01:07:36.786841  =


    2023-05-11T01:07:36.887420  / # . /lava-10273681/environment/lava-10273=
681/bin/lava-test-runner /lava-10273681/1

    2023-05-11T01:07:36.887790  =


    2023-05-11T01:07:36.893256  / # /lava-10273681/bin/lava-test-runner /la=
va-10273681/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645c38a6ea1c1404052e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-gc6b46250d53e/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645c38a6ea1c1404052e8=
604
        failing since 3 days (last pass: v6.1.22-1159-g8729cbdc1402, first =
fail: v6.1.22-1196-g571a2463c150b) =

 =20
