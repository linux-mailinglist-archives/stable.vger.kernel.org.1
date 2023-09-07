Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F926796F90
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 06:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjIGERj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 00:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjIGERh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 00:17:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA75E9
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 21:17:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c09f1f9df2so419576a34.2
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 21:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694060250; x=1694665050; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=14Nf11VSpqm8YAvS7EzYHPR1nuJF9JFJaUvncSRVyL8=;
        b=ePbRBqA+sigC5LAwp1RnzPy2ZHZY92Jddr+78p6uXOtic/gW6Um4f4c5PIqLrecu4Q
         yElrAgB3Uktd4g3K0MVoWCA/DiTOnweouzakX53/sI5e3y9JXCEHQCd9yYn/QBqV1iAP
         NuJ4mDaXZS1DtdahOYRTcP8+tp60WqkvFmTqPcvTQB9Yo7yYt7rbnNLfzkQIPyJRY9BZ
         Z1DgL99fEBYlek0JnwMdnQtr6dycTXfc2sKwU0gK43lKT8aWzWgcQouEzJHYr+2W7vDN
         vyYKKsESlNI84xaxS89NeAm8wPmc/VFTNRqEWwjJM/dvtMxPpNTryhLUrUihQ20yufmN
         eEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694060250; x=1694665050;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14Nf11VSpqm8YAvS7EzYHPR1nuJF9JFJaUvncSRVyL8=;
        b=ACWIuDNQdNzhekD3L2wnjYKV6WlgJoV7CC98If6zeC0g6S08S6qgRxN3ZU7gkxZhMq
         EeGQRHuxhWBwZHaFTQb2Ekg4dw6EGi7RoCA+0Ql7U4DYsMP2eeNcqtBD5JZVjGsPBu25
         DJagbTB1Jyov+5e/X6RaswSvAvEUeU6tA9nQWRsGuCnqAm0fE3zePqiHiSq0vzbVHhPO
         HNnqQd8j1MJwPNUMr59pJ4fNZ/nVDNUQOESRa+abDrwbCcgURkRJQ++FdWBTQ4kbuZ5Z
         hbRUmIvJaHyBGThI/NWNERzPH8nC1tZKaKPCI7fLMR28qfyefMNI+JdtqxNHEJuhHwbQ
         oYXA==
X-Gm-Message-State: AOJu0YxpdvkSiwMSG5VPh2jO+f8y/070stXeGBKX8s2LuVZd5jfFmjFn
        IQ3Mx2b0S7siVS9vpeIERGSk3QyBaPYfULZQ6mjHJA==
X-Google-Smtp-Source: AGHT+IFgP6KTwqH2BZFS0KJpcHl0kMK0KOyoPWczyLdgpW2NhvBKd9qxQU8JnCTidYkSQ84nI2Il/A==
X-Received: by 2002:a05:6358:318a:b0:13e:bd8d:c2a2 with SMTP id q10-20020a056358318a00b0013ebd8dc2a2mr5436930rwd.23.1694060250429;
        Wed, 06 Sep 2023 21:17:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a01cc00b00268188ea4b9sm608288pjd.19.2023.09.06.21.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 21:17:29 -0700 (PDT)
Message-ID: <64f94ed9.170a0220.fb1ef.248c@mx.google.com>
Date:   Wed, 06 Sep 2023 21:17:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.52
Subject: stable/linux-6.1.y baseline: 111 runs, 10 regressions (v6.1.52)
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

stable/linux-6.1.y baseline: 111 runs, 10 regressions (v6.1.52)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
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
v6.1.52/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.52
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      59b13c2b647e464dd85622c89d7f16c15d681e96 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f9128a295f8c0ef9286d86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f9128a295f8c0ef9286=
d87
        failing since 10 days (last pass: v6.1.48, first fail: v6.1.49) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f9124cf60a2a91a6286d89

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f9124df60a2a91a6286d92
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T23:58:08.854410  <8>[    9.785915] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451993_1.4.2.3.1>

    2023-09-06T23:58:08.857916  + set +x

    2023-09-06T23:58:08.962775  #

    2023-09-06T23:58:08.963820  =


    2023-09-06T23:58:09.065495  / # #export SHELL=3D/bin/sh

    2023-09-06T23:58:09.066154  =


    2023-09-06T23:58:09.167348  / # export SHELL=3D/bin/sh. /lava-11451993/=
environment

    2023-09-06T23:58:09.167539  =


    2023-09-06T23:58:09.268069  / # . /lava-11451993/environment/lava-11451=
993/bin/lava-test-runner /lava-11451993/1

    2023-09-06T23:58:09.268313  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f9122e9ee60ba4fb286d6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f9122f9ee60ba4fb286d77
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T23:58:02.339616  + set<8>[   11.412198] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11452001_1.4.2.3.1>

    2023-09-06T23:58:02.340109   +x

    2023-09-06T23:58:02.446634  / # #

    2023-09-06T23:58:02.548702  export SHELL=3D/bin/sh

    2023-09-06T23:58:02.549463  #

    2023-09-06T23:58:02.650870  / # export SHELL=3D/bin/sh. /lava-11452001/=
environment

    2023-09-06T23:58:02.651577  =


    2023-09-06T23:58:02.752944  / # . /lava-11452001/environment/lava-11452=
001/bin/lava-test-runner /lava-11452001/1

    2023-09-06T23:58:02.754425  =


    2023-09-06T23:58:02.759230  / # /lava-11452001/bin/lava-test-runner /la=
va-11452001/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f912421bdf2070c4286d77

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f912431bdf2070c4286d80
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T23:58:11.741051  <8>[   10.451922] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451970_1.4.2.3.1>

    2023-09-06T23:58:11.744794  + set +x

    2023-09-06T23:58:11.846353  =


    2023-09-06T23:58:11.946910  / # #export SHELL=3D/bin/sh

    2023-09-06T23:58:11.947098  =


    2023-09-06T23:58:12.047652  / # export SHELL=3D/bin/sh. /lava-11451970/=
environment

    2023-09-06T23:58:12.047833  =


    2023-09-06T23:58:12.148330  / # . /lava-11451970/environment/lava-11451=
970/bin/lava-test-runner /lava-11451970/1

    2023-09-06T23:58:12.148634  =


    2023-09-06T23:58:12.153561  / # /lava-11451970/bin/lava-test-runner /la=
va-11451970/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f91217fa7b7ae317286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f91218fa7b7ae317286d75
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T23:59:02.252453  + set +x

    2023-09-06T23:59:02.258856  <8>[   11.061342] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11451982_1.4.2.3.1>

    2023-09-06T23:59:02.363312  / # #

    2023-09-06T23:59:02.463997  export SHELL=3D/bin/sh

    2023-09-06T23:59:02.464198  #

    2023-09-06T23:59:02.564700  / # export SHELL=3D/bin/sh. /lava-11451982/=
environment

    2023-09-06T23:59:02.564895  =


    2023-09-06T23:59:02.665430  / # . /lava-11451982/environment/lava-11451=
982/bin/lava-test-runner /lava-11451982/1

    2023-09-06T23:59:02.665708  =


    2023-09-06T23:59:02.670260  / # /lava-11451982/bin/lava-test-runner /la=
va-11451982/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f9124ae489db9e5b286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f9124ce489db9e5b286d75
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T23:58:06.243165  + set<8>[    8.700895] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11452012_1.4.2.3.1>

    2023-09-06T23:58:06.243249   +x

    2023-09-06T23:58:06.347672  / # #

    2023-09-06T23:58:06.449235  export SHELL=3D/bin/sh

    2023-09-06T23:58:06.449960  #

    2023-09-06T23:58:06.551641  / # export SHELL=3D/bin/sh. /lava-11452012/=
environment

    2023-09-06T23:58:06.552469  =


    2023-09-06T23:58:06.653926  / # . /lava-11452012/environment/lava-11452=
012/bin/lava-test-runner /lava-11452012/1

    2023-09-06T23:58:06.654944  =


    2023-09-06T23:58:06.660337  / # /lava-11452012/bin/lava-test-runner /la=
va-11452012/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f911fdb9b2bd5bee286da3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f911feb9b2bd5bee286dac
        failing since 160 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-06T23:57:42.284448  + set +x<8>[   11.820769] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11452006_1.4.2.3.1>

    2023-09-06T23:57:42.285071  =


    2023-09-06T23:57:42.393020  / # #

    2023-09-06T23:57:42.495622  export SHELL=3D/bin/sh

    2023-09-06T23:57:42.496444  #

    2023-09-06T23:57:42.598264  / # export SHELL=3D/bin/sh. /lava-11452006/=
environment

    2023-09-06T23:57:42.599074  =


    2023-09-06T23:57:42.700788  / # . /lava-11452006/environment/lava-11452=
006/bin/lava-test-runner /lava-11452006/1

    2023-09-06T23:57:42.702138  =


    2023-09-06T23:57:42.707078  / # /lava-11452006/bin/lava-test-runner /la=
va-11452006/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f91a522238b2d83f286da1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f91a532238b2d83f286daa
        failing since 49 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-09-07T00:34:37.752753  / # #

    2023-09-07T00:34:37.854930  export SHELL=3D/bin/sh

    2023-09-07T00:34:37.855583  #

    2023-09-07T00:34:37.956868  / # export SHELL=3D/bin/sh. /lava-11452189/=
environment

    2023-09-07T00:34:37.957620  =


    2023-09-07T00:34:38.059062  / # . /lava-11452189/environment/lava-11452=
189/bin/lava-test-runner /lava-11452189/1

    2023-09-07T00:34:38.060167  =


    2023-09-07T00:34:38.077131  / # /lava-11452189/bin/lava-test-runner /la=
va-11452189/1

    2023-09-07T00:34:38.125218  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-07T00:34:38.125755  + cd /lav<8>[   19.018553] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11452189_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f91a860bd5b04151286dfe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f91a860bd5b04151286e07
        failing since 49 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-09-07T00:35:15.778095  / # #

    2023-09-07T00:35:16.858745  export SHELL=3D/bin/sh

    2023-09-07T00:35:16.860542  #

    2023-09-07T00:35:18.351870  / # export SHELL=3D/bin/sh. /lava-11452191/=
environment

    2023-09-07T00:35:18.353754  =


    2023-09-07T00:35:21.079197  / # . /lava-11452191/environment/lava-11452=
191/bin/lava-test-runner /lava-11452191/1

    2023-09-07T00:35:21.081695  =


    2023-09-07T00:35:21.086368  / # /lava-11452191/bin/lava-test-runner /la=
va-11452191/1

    2023-09-07T00:35:21.149777  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-07T00:35:21.150290  + cd /lava-114521<8>[   28.488227] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11452191_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f91a530bd5b04151286da5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.52/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f91a540bd5b04151286dae
        failing since 49 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-09-07T00:34:50.861104  / # #

    2023-09-07T00:34:50.961652  export SHELL=3D/bin/sh

    2023-09-07T00:34:50.961788  #

    2023-09-07T00:34:51.062379  / # export SHELL=3D/bin/sh. /lava-11452193/=
environment

    2023-09-07T00:34:51.062500  =


    2023-09-07T00:34:51.163008  / # . /lava-11452193/environment/lava-11452=
193/bin/lava-test-runner /lava-11452193/1

    2023-09-07T00:34:51.163208  =


    2023-09-07T00:34:51.208959  / # /lava-11452193/bin/lava-test-runner /la=
va-11452193/1

    2023-09-07T00:34:51.209042  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-07T00:34:51.243374  + cd /lava-11452193/1/tests/1_boot<8>[   16=
.910402] <LAVA_SIGNAL_STARTRUN 1_bootrr 11452193_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
