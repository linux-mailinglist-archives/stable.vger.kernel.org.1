Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE67C9C02
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjJOVsz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 17:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOVsy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 17:48:54 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C382E0
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 14:48:50 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7b92cd0ccso49205057b3.1
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697406529; x=1698011329; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r9KywskA1Mfk5GDaiq1n5EcKSnJamdCUONBUzx84dFI=;
        b=xSWZAlzS7dXx7mrEmFD35GjHrHtmhpT0cDdUS5Rqg5Qy06yJdDkwVgC+pYpnGz4pt8
         gQYoXyILGn71834fjAPWaG9Iy1nqIKP6SxkU7X6KBOvrLlCzin9SxoopkHdAoqEKLzmo
         x2YIf3gHcPOFI4/Sg3q0GlbGwZdhtsMPVhqeQiVzHqV0LllL/00s7nC/m+1WfU8akTwG
         DasKCHmPgEJw5fIzzC8w/KqRhxy+VHJ6dbSP+vuWQy6WHxyzPBCKuigERt75oxQskKhE
         ELR7qSPSVbAtU663g28wMn0tBWG1JIuIWQjB8jU2iGo68qmZM+6NJbCoH46wL0AxNTXo
         5k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697406529; x=1698011329;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9KywskA1Mfk5GDaiq1n5EcKSnJamdCUONBUzx84dFI=;
        b=jsIX5sAxjRGC3RB0lRBHhSDbkd3ezEMK0N8DsBhKyTyUD7h9MPYgE6wnMEm28asoT0
         zkxM+AVdXxFfn5WZHDb+40snNtZzd26mVdSP45eUPqgzuvDsaIDhUlx0WN/8+RKmbQwy
         pA6Qmfg9td9z4rwCWvSDLEwyiNcTi7Pigm1j5AfRNbU051QHThurwmuyHNxKSdDzOCL/
         j47TMkFHNQfEWZ+0hPzZ6iKFaBwWlHi5Nqh0b59tFP2iBKHh/+7jA672XmE9bzKjDfUZ
         xqmOOWP9oT0wMlFnEn8dgxKMZ7IKnAlQMozvkUXsWofuOOoLoaOoeqFt8kr1CosGz47y
         rSuw==
X-Gm-Message-State: AOJu0YyCujzptYEJtUc+fX5PpCC7E+krWtP8U21640o5sp3m6oZNHmuh
        cc+ljct6QbBsAgR5UbTWGsqmo/FhNl6sj5JD5mrJIw==
X-Google-Smtp-Source: AGHT+IFdQOIObKLfJL/0+qKhWTxQ9j4bWXhIFi+X+qj5tP/+ntPEBQ6W7ZYmcfYdjRr/O/WKEgZjsw==
X-Received: by 2002:a05:690c:2b89:b0:5a7:dda8:f291 with SMTP id en9-20020a05690c2b8900b005a7dda8f291mr11630038ywb.33.1697406529247;
        Sun, 15 Oct 2023 14:48:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gd1-20020a17090b0fc100b0026801e06ac1sm3391404pjb.30.2023.10.15.14.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 14:48:48 -0700 (PDT)
Message-ID: <652c5e40.170a0220.d61fb.a393@mx.google.com>
Date:   Sun, 15 Oct 2023 14:48:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
Subject: stable/linux-6.1.y baseline: 164 runs, 11 regressions (v6.1.58)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y baseline: 164 runs, 11 regressions (v6.1.58)

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

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.58/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.58
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      adc4d740ad9ec780657327c69ab966fa4fdf0e8e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c29e31a6aa11fc5efcfe0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c29e31a6aa11fc5efcfe9
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:05:05.986262  <8>[    9.848766] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11782024_1.4.2.3.1>

    2023-10-15T18:05:05.989542  + set +x

    2023-10-15T18:05:06.094922  / # #

    2023-10-15T18:05:06.195932  export SHELL=3D/bin/sh

    2023-10-15T18:05:06.196282  #

    2023-10-15T18:05:06.296984  / # export SHELL=3D/bin/sh. /lava-11782024/=
environment

    2023-10-15T18:05:06.297360  =


    2023-10-15T18:05:06.398097  / # . /lava-11782024/environment/lava-11782=
024/bin/lava-test-runner /lava-11782024/1

    2023-10-15T18:05:06.398414  =


    2023-10-15T18:05:06.403367  / # /lava-11782024/bin/lava-test-runner /la=
va-11782024/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c29de1a6aa11fc5efcfd3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c29de1a6aa11fc5efcfdc
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:05:00.748875  + set<8>[   11.289407] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11781972_1.4.2.3.1>

    2023-10-15T18:05:00.748987   +x

    2023-10-15T18:05:00.853730  / # #

    2023-10-15T18:05:00.954418  export SHELL=3D/bin/sh

    2023-10-15T18:05:00.954642  #

    2023-10-15T18:05:01.055179  / # export SHELL=3D/bin/sh. /lava-11781972/=
environment

    2023-10-15T18:05:01.055413  =


    2023-10-15T18:05:01.156027  / # . /lava-11781972/environment/lava-11781=
972/bin/lava-test-runner /lava-11781972/1

    2023-10-15T18:05:01.156307  =


    2023-10-15T18:05:01.161340  / # /lava-11781972/bin/lava-test-runner /la=
va-11781972/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c29fc01373375d9efcf00

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c29fc01373375d9efcf09
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:06:52.628935  <8>[   11.248886] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11782077_1.4.2.3.1>

    2023-10-15T18:06:52.629045  + set +x

    2023-10-15T18:06:52.732900  / # #

    2023-10-15T18:06:52.833485  export SHELL=3D/bin/sh

    2023-10-15T18:06:52.833675  #

    2023-10-15T18:06:52.934229  / # export SHELL=3D/bin/sh. /lava-11782077/=
environment

    2023-10-15T18:06:52.934467  =


    2023-10-15T18:06:53.035017  / # . /lava-11782077/environment/lava-11782=
077/bin/lava-test-runner /lava-11782077/1

    2023-10-15T18:06:53.035339  =


    2023-10-15T18:06:53.040253  / # /lava-11782077/bin/lava-test-runner /la=
va-11782077/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c29d2247034b0f7efcf00

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c29d2247034b0f7efcf09
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:04:54.206844  + set +x

    2023-10-15T18:04:54.213262  <8>[   10.593971] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11782034_1.4.2.3.1>

    2023-10-15T18:04:54.317764  / # #

    2023-10-15T18:04:54.418338  export SHELL=3D/bin/sh

    2023-10-15T18:04:54.418559  #

    2023-10-15T18:04:54.519096  / # export SHELL=3D/bin/sh. /lava-11782034/=
environment

    2023-10-15T18:04:54.519288  =


    2023-10-15T18:04:54.619786  / # . /lava-11782034/environment/lava-11782=
034/bin/lava-test-runner /lava-11782034/1

    2023-10-15T18:04:54.620116  =


    2023-10-15T18:04:54.624959  / # /lava-11782034/bin/lava-test-runner /la=
va-11782034/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c29caa64c7fc524efcf02

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c29caa64c7fc524efcf0b
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:04:44.207277  <8>[    9.995702] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11781968_1.4.2.3.1>

    2023-10-15T18:04:44.210552  + set +x

    2023-10-15T18:04:44.311919  #

    2023-10-15T18:04:44.312320  =


    2023-10-15T18:04:44.412954  / # #export SHELL=3D/bin/sh

    2023-10-15T18:04:44.413176  =


    2023-10-15T18:04:44.513723  / # export SHELL=3D/bin/sh. /lava-11781968/=
environment

    2023-10-15T18:04:44.513962  =


    2023-10-15T18:04:44.614536  / # . /lava-11781968/environment/lava-11781=
968/bin/lava-test-runner /lava-11781968/1

    2023-10-15T18:04:44.614923  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c29e41a6aa11fc5efcfeb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c29e41a6aa11fc5efcff4
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:05:02.968584  + set<8>[   10.899563] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11781995_1.4.2.3.1>

    2023-10-15T18:05:02.968670   +x

    2023-10-15T18:05:03.072725  / # #

    2023-10-15T18:05:03.173285  export SHELL=3D/bin/sh

    2023-10-15T18:05:03.173464  #

    2023-10-15T18:05:03.273943  / # export SHELL=3D/bin/sh. /lava-11781995/=
environment

    2023-10-15T18:05:03.274164  =


    2023-10-15T18:05:03.374719  / # . /lava-11781995/environment/lava-11781=
995/bin/lava-test-runner /lava-11781995/1

    2023-10-15T18:05:03.375033  =


    2023-10-15T18:05:03.379361  / # /lava-11781995/bin/lava-test-runner /la=
va-11781995/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652c29fb01373375d9efcef5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c29fb01373375d9efcefe
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-15T18:05:19.212989  + set<8>[   11.175435] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11782052_1.4.2.3.1>

    2023-10-15T18:05:19.213179   +x

    2023-10-15T18:05:19.318208  / # #

    2023-10-15T18:05:19.418945  export SHELL=3D/bin/sh

    2023-10-15T18:05:19.419296  #

    2023-10-15T18:05:19.520143  / # export SHELL=3D/bin/sh. /lava-11782052/=
environment

    2023-10-15T18:05:19.520523  =


    2023-10-15T18:05:19.621451  / # . /lava-11782052/environment/lava-11782=
052/bin/lava-test-runner /lava-11782052/1

    2023-10-15T18:05:19.622009  =


    2023-10-15T18:05:19.626370  / # /lava-11782052/bin/lava-test-runner /la=
va-11782052/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652c28f52c43d08ad0efcf22

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c28f52c43d08ad0efcf2b
        failing since 88 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-10-15T18:05:22.440584  / # #

    2023-10-15T18:05:22.542529  export SHELL=3D/bin/sh

    2023-10-15T18:05:22.543232  #

    2023-10-15T18:05:22.644566  / # export SHELL=3D/bin/sh. /lava-11781907/=
environment

    2023-10-15T18:05:22.645261  =


    2023-10-15T18:05:22.746454  / # . /lava-11781907/environment/lava-11781=
907/bin/lava-test-runner /lava-11781907/1

    2023-10-15T18:05:22.747525  =


    2023-10-15T18:05:22.748711  / # /lava-11781907/bin/lava-test-runner /la=
va-11781907/1

    2023-10-15T18:05:22.812472  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-15T18:05:22.812982  + cd /lav<8>[   19.122919] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11781907_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652c29112c43d08ad0efcf85

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c29112c43d08ad0efcf8e
        failing since 88 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-10-15T18:04:04.317234  / # #

    2023-10-15T18:04:05.396778  export SHELL=3D/bin/sh

    2023-10-15T18:04:05.398651  #

    2023-10-15T18:04:06.887890  / # export SHELL=3D/bin/sh. /lava-11781917/=
environment

    2023-10-15T18:04:06.889668  =


    2023-10-15T18:04:09.614667  / # . /lava-11781917/environment/lava-11781=
917/bin/lava-test-runner /lava-11781917/1

    2023-10-15T18:04:09.617102  =


    2023-10-15T18:04:09.627664  / # /lava-11781917/bin/lava-test-runner /la=
va-11781917/1

    2023-10-15T18:04:09.686736  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-15T18:04:09.687250  + cd /lava-117819<8>[   28.528188] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11781917_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652c28e847f679a3feefcfb8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/arm=
64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/arm=
64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c28e847f679a3feefcfc1
        failing since 4 days (last pass: v6.1.24, first fail: v6.1.57)

    2023-10-15T18:00:50.779422  / # #
    2023-10-15T18:00:50.881347  export SHELL=3D/bin/sh
    2023-10-15T18:00:50.882041  #
    2023-10-15T18:00:50.983101  / # export SHELL=3D/bin/sh. /lava-438683/en=
vironment
    2023-10-15T18:00:50.983773  =

    2023-10-15T18:00:51.084789  / # . /lava-438683/environment/lava-438683/=
bin/lava-test-runner /lava-438683/1
    2023-10-15T18:00:51.085710  =

    2023-10-15T18:00:51.090134  / # /lava-438683/bin/lava-test-runner /lava=
-438683/1
    2023-10-15T18:00:51.163331  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-15T18:00:51.163727  + cd /lava-438683/<8>[   18.604582] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 438683_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652c28f72c43d08ad0efcf2d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.58/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652c28f72c43d08ad0efcf36
        failing since 4 days (last pass: v6.1.24, first fail: v6.1.57)

    2023-10-15T18:05:34.874343  / # #

    2023-10-15T18:05:34.976603  export SHELL=3D/bin/sh

    2023-10-15T18:05:34.977329  #

    2023-10-15T18:05:35.078796  / # export SHELL=3D/bin/sh. /lava-11781911/=
environment

    2023-10-15T18:05:35.079533  =


    2023-10-15T18:05:35.181060  / # . /lava-11781911/environment/lava-11781=
911/bin/lava-test-runner /lava-11781911/1

    2023-10-15T18:05:35.182238  =


    2023-10-15T18:05:35.198784  / # /lava-11781911/bin/lava-test-runner /la=
va-11781911/1

    2023-10-15T18:05:35.266747  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-15T18:05:35.267255  + cd /lava-11781911/1/tests/1_boot<8>[   16=
.956782] <LAVA_SIGNAL_STARTRUN 1_bootrr 11781911_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
