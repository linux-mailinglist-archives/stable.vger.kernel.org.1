Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7876E8BE
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 14:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjHCMrr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 08:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHCMrq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 08:47:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6A110
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 05:47:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686e0213c0bso623689b3a.1
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691066861; x=1691671661;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=82/gspiF3yG1hEEtMX0/JU7tHYDlbaiclFpLtvDEgvA=;
        b=Y5CEjo9mYQ1mUSuw9YZAqKHfgqQelBs7OmKf/LSgDh62ZscFx1twgqWqAwZLduWzu3
         IDKyjKZJMy+ioMTwk1KbqQU5GyqMz73Et63XKMkjHlmdFFoAi40PK2Swv0oaktR5FB58
         muYaS6+QgEjfyH/Yl7Q5AJKoClQjHU/OHfVAhcmAqE4Q+Fz3kedtn0CbnxvWyAdgUoQv
         dx0VIpuqaNOOC5KGt7o/AiikE64iHy5Mw+4W1WExffA1784f3ZMaQQeQR9VXmVRNiyOE
         v4xKRzNypAofwKb50T4QRYgApw1RCHlVjWLvaG3289bVjm6U46q80QB0u7sJBvOPTE4F
         fMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691066861; x=1691671661;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82/gspiF3yG1hEEtMX0/JU7tHYDlbaiclFpLtvDEgvA=;
        b=RyvFy5DjS7wLWHdlZyeT5axhJHfRTJbM8D6WAocJJbfXI1vNkBKvjVdH3AO5HvQ+mi
         uY8toOicWej+FUEoPZlrW8S88UWIIOHJxtcWEWOT/iLW5r9NwV/juD4lFhI1j2c7D5Px
         XKdV4BiCVW3oLr6BpyJnOeWBy6yFy2q7eMI0udn9Bu6WAevIG5JUaWYwF814Cs4Xgfij
         DLNZZcGq2Q8zskvAtThW7hU7nG/SULfZ4z2q7H/e6/LebSlrIMvPg6e4AIKPoLNcfQGe
         1PbJQyygPb6ppclMIjWCj0kICR39htP7IEFvUEcbKVk1MBrgUOyuOw9DWFLB2zzLtZ6w
         JTbg==
X-Gm-Message-State: ABy/qLawSLN4z7uSKltSbojKHt9H1rAGXWEE53kJB2sQdQ+62PKeybnf
        VJgxIlAPiRJ7zFXda2n4g3LkYOBoT3kedLXjp61+hg==
X-Google-Smtp-Source: APBJJlE/hTnUHwlLJ9ebD61YIFrCgcCFN9Tr2C76etlIZNsGJS2H6BrEk3e+0x0PkZ8uTgAG5trCJQ==
X-Received: by 2002:a05:6a00:a85:b0:668:69fa:f78f with SMTP id b5-20020a056a000a8500b0066869faf78fmr20911303pfl.1.1691066860618;
        Thu, 03 Aug 2023 05:47:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n20-20020a62e514000000b0066684d8115bsm12799227pff.178.2023.08.03.05.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 05:47:39 -0700 (PDT)
Message-ID: <64cba1eb.620a0220.c4399.8eea@mx.google.com>
Date:   Thu, 03 Aug 2023 05:47:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.124
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.15.y
Subject: stable/linux-5.15.y baseline: 196 runs, 23 regressions (v5.15.124)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.15.y baseline: 196 runs, 23 regressions (v5.15.124)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.124/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.124
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      38d4ca22a5288c4bae7e6d62a1728b0718d51866 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6e64c6870320ed35b1ef

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6e64c6870320ed35b1f4
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:07:43.207212  <8>[   10.251694] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11197676_1.4.2.3.1>

    2023-08-03T09:07:43.210020  + set +x

    2023-08-03T09:07:43.315077  / # #

    2023-08-03T09:07:43.415764  export SHELL=3D/bin/sh

    2023-08-03T09:07:43.415985  #

    2023-08-03T09:07:43.516600  / # export SHELL=3D/bin/sh. /lava-11197676/=
environment

    2023-08-03T09:07:43.516820  =


    2023-08-03T09:07:43.617381  / # . /lava-11197676/environment/lava-11197=
676/bin/lava-test-runner /lava-11197676/1

    2023-08-03T09:07:43.617685  =


    2023-08-03T09:07:43.624046  / # /lava-11197676/bin/lava-test-runner /la=
va-11197676/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6eca32e8b6db7e35b230

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6eca32e8b6db7e35b235
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:09:15.732380  + set +x

    2023-08-03T09:09:15.738755  <8>[   12.362003] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11197712_1.4.2.3.1>

    2023-08-03T09:09:15.844117  / # #

    2023-08-03T09:09:15.945482  export SHELL=3D/bin/sh

    2023-08-03T09:09:15.946353  #

    2023-08-03T09:09:16.047918  / # export SHELL=3D/bin/sh. /lava-11197712/=
environment

    2023-08-03T09:09:16.048116  =


    2023-08-03T09:09:16.148654  / # . /lava-11197712/environment/lava-11197=
712/bin/lava-test-runner /lava-11197712/1

    2023-08-03T09:09:16.148991  =


    2023-08-03T09:09:16.154607  / # /lava-11197712/bin/lava-test-runner /la=
va-11197712/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6e65f258c6439835b1da

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6e65f258c6439835b1df
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:07:40.936168  + set<8>[   11.547215] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11197672_1.4.2.3.1>

    2023-08-03T09:07:40.936258   +x

    2023-08-03T09:07:41.040485  / # #

    2023-08-03T09:07:41.141120  export SHELL=3D/bin/sh

    2023-08-03T09:07:41.141313  #

    2023-08-03T09:07:41.241786  / # export SHELL=3D/bin/sh. /lava-11197672/=
environment

    2023-08-03T09:07:41.242029  =


    2023-08-03T09:07:41.342669  / # . /lava-11197672/environment/lava-11197=
672/bin/lava-test-runner /lava-11197672/1

    2023-08-03T09:07:41.342930  =


    2023-08-03T09:07:41.347356  / # /lava-11197672/bin/lava-test-runner /la=
va-11197672/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6eb53d44b58ee935b1dd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6eb53d44b58ee935b1e2
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:08:51.785403  <8>[   12.462750] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11197738_1.4.2.3.1>

    2023-08-03T09:08:51.892051  / # #

    2023-08-03T09:08:51.994210  export SHELL=3D/bin/sh

    2023-08-03T09:08:51.994907  #

    2023-08-03T09:08:52.096219  / # export SHELL=3D/bin/sh. /lava-11197738/=
environment

    2023-08-03T09:08:52.096929  =


    2023-08-03T09:08:52.198307  / # . /lava-11197738/environment/lava-11197=
738/bin/lava-test-runner /lava-11197738/1

    2023-08-03T09:08:52.199452  =


    2023-08-03T09:08:52.204354  / # /lava-11197738/bin/lava-test-runner /la=
va-11197738/1

    2023-08-03T09:08:52.217101  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6e79210baa73c635b1f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6e79210baa73c635b1f9
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:07:44.546078  <8>[   11.176669] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11197706_1.4.2.3.1>

    2023-08-03T09:07:44.549654  + set +x

    2023-08-03T09:07:44.651338  =


    2023-08-03T09:07:44.751968  / # #export SHELL=3D/bin/sh

    2023-08-03T09:07:44.752187  =


    2023-08-03T09:07:44.852790  / # export SHELL=3D/bin/sh. /lava-11197706/=
environment

    2023-08-03T09:07:44.853002  =


    2023-08-03T09:07:44.953538  / # . /lava-11197706/environment/lava-11197=
706/bin/lava-test-runner /lava-11197706/1

    2023-08-03T09:07:44.953867  =


    2023-08-03T09:07:44.958523  / # /lava-11197706/bin/lava-test-runner /la=
va-11197706/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6e8d210baa73c635b205

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6e8d210baa73c635b20a
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:08:46.570419  <8>[   12.121143] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11197731_1.4.2.3.1>

    2023-08-03T09:08:46.574027  + set +x

    2023-08-03T09:08:46.675560  =


    2023-08-03T09:08:46.776241  / # #export SHELL=3D/bin/sh

    2023-08-03T09:08:46.776448  =


    2023-08-03T09:08:46.876953  / # export SHELL=3D/bin/sh. /lava-11197731/=
environment

    2023-08-03T09:08:46.877161  =


    2023-08-03T09:08:46.977650  / # . /lava-11197731/environment/lava-11197=
731/bin/lava-test-runner /lava-11197731/1

    2023-08-03T09:08:46.978022  =


    2023-08-03T09:08:46.982852  / # /lava-11197731/bin/lava-test-runner /la=
va-11197731/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6a979232fbd58b35b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6a979232fbd58b35b1de
        failing since 7 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-03T08:52:51.067646  / # #

    2023-08-03T08:52:51.169832  export SHELL=3D/bin/sh

    2023-08-03T08:52:51.170549  #

    2023-08-03T08:52:51.271968  / # export SHELL=3D/bin/sh. /lava-11197538/=
environment

    2023-08-03T08:52:51.272684  =


    2023-08-03T08:52:51.374183  / # . /lava-11197538/environment/lava-11197=
538/bin/lava-test-runner /lava-11197538/1

    2023-08-03T08:52:51.375302  =


    2023-08-03T08:52:51.392042  / # /lava-11197538/bin/lava-test-runner /la=
va-11197538/1

    2023-08-03T08:52:51.498715  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-03T08:52:51.499237  + cd /lava-11197538/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6e83a586bec87035b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64cb6e83a586bec87035b=
1da
        failing since 119 days (last pass: v5.15.105, first fail: v5.15.106=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6b2cf5c1b3f0c735b1fc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6b2cf5c1b3f0c735b201
        failing since 196 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-08-03T08:53:53.298061  <8>[   10.024820] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3727973_1.5.2.4.1>
    2023-08-03T08:53:53.408078  / # #
    2023-08-03T08:53:53.511577  export SHELL=3D/bin/sh
    2023-08-03T08:53:53.512750  #
    2023-08-03T08:53:53.615117  / # export SHELL=3D/bin/sh. /lava-3727973/e=
nvironment
    2023-08-03T08:53:53.616319  =

    2023-08-03T08:53:53.718648  / # . /lava-3727973/environment/lava-372797=
3/bin/lava-test-runner /lava-3727973/1
    2023-08-03T08:53:53.720398  =

    2023-08-03T08:53:53.725381  / # /lava-3727973/bin/lava-test-runner /lav=
a-3727973/1
    2023-08-03T08:53:53.812394  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb716d399f4bb04935b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb716d399f4bb04935b1dd
        failing since 152 days (last pass: v5.15.79, first fail: v5.15.97)

    2023-08-03T09:20:18.925733  [   10.679987] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1240549_1.5.2.4.1>
    2023-08-03T09:20:19.030943  =

    2023-08-03T09:20:19.132127  / # #export SHELL=3D/bin/sh
    2023-08-03T09:20:19.132527  =

    2023-08-03T09:20:19.233468  / # export SHELL=3D/bin/sh. /lava-1240549/e=
nvironment
    2023-08-03T09:20:19.233868  =

    2023-08-03T09:20:19.334840  / # . /lava-1240549/environment/lava-124054=
9/bin/lava-test-runner /lava-1240549/1
    2023-08-03T09:20:19.335588  =

    2023-08-03T09:20:19.338622  / # /lava-1240549/bin/lava-test-runner /lav=
a-1240549/1
    2023-08-03T09:20:19.355566  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb70582c157bb8b435b1f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb70582c157bb8b435b1f5
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:15:53.903648  + set +x

    2023-08-03T09:15:53.910082  <8>[   10.885210] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11197669_1.4.2.3.1>

    2023-08-03T09:15:54.014578  / # #

    2023-08-03T09:15:54.115319  export SHELL=3D/bin/sh

    2023-08-03T09:15:54.116167  #

    2023-08-03T09:15:54.217802  / # export SHELL=3D/bin/sh. /lava-11197669/=
environment

    2023-08-03T09:15:54.218618  =


    2023-08-03T09:15:54.320130  / # . /lava-11197669/environment/lava-11197=
669/bin/lava-test-runner /lava-11197669/1

    2023-08-03T09:15:54.321366  =


    2023-08-03T09:15:54.326089  / # /lava-11197669/bin/lava-test-runner /la=
va-11197669/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb70a8dac43a8a6835b285

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb70a8dac43a8a6835b28a
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:17:21.027588  + set +x

    2023-08-03T09:17:21.033555  <8>[   11.932110] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11197718_1.4.2.3.1>

    2023-08-03T09:17:21.137919  / # #

    2023-08-03T09:17:21.238466  export SHELL=3D/bin/sh

    2023-08-03T09:17:21.238633  #

    2023-08-03T09:17:21.339138  / # export SHELL=3D/bin/sh. /lava-11197718/=
environment

    2023-08-03T09:17:21.339297  =


    2023-08-03T09:17:21.439839  / # . /lava-11197718/environment/lava-11197=
718/bin/lava-test-runner /lava-11197718/1

    2023-08-03T09:17:21.440081  =


    2023-08-03T09:17:21.444515  / # /lava-11197718/bin/lava-test-runner /la=
va-11197718/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6fa4485c7e0a4635b2c5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6fa4485c7e0a4635b2ca
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:12:46.560645  <8>[    8.025610] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11197701_1.4.2.3.1>

    2023-08-03T09:12:46.565608  + set +x

    2023-08-03T09:12:46.673339  / # #

    2023-08-03T09:12:46.775868  export SHELL=3D/bin/sh

    2023-08-03T09:12:46.776534  #

    2023-08-03T09:12:46.877825  / # export SHELL=3D/bin/sh. /lava-11197701/=
environment

    2023-08-03T09:12:46.878534  =


    2023-08-03T09:12:46.980021  / # . /lava-11197701/environment/lava-11197=
701/bin/lava-test-runner /lava-11197701/1

    2023-08-03T09:12:46.981114  =


    2023-08-03T09:12:46.986525  / # /lava-11197701/bin/lava-test-runner /la=
va-11197701/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6fb8485c7e0a4635b2f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6fb8485c7e0a4635b2fb
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:13:47.773104  <8>[   11.555654] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11197732_1.4.2.3.1>

    2023-08-03T09:13:47.776292  + set +x

    2023-08-03T09:13:47.877472  #

    2023-08-03T09:13:47.978264  / # #export SHELL=3D/bin/sh

    2023-08-03T09:13:47.978454  =


    2023-08-03T09:13:48.079004  / # export SHELL=3D/bin/sh. /lava-11197732/=
environment

    2023-08-03T09:13:48.079185  =


    2023-08-03T09:13:48.179741  / # . /lava-11197732/environment/lava-11197=
732/bin/lava-test-runner /lava-11197732/1

    2023-08-03T09:13:48.180049  =


    2023-08-03T09:13:48.185803  / # /lava-11197732/bin/lava-test-runner /la=
va-11197732/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6e6409baf38b2235b1f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6e6509baf38b2235b1f6
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:07:28.180756  + set<8>[   10.762630] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11197675_1.4.2.3.1>

    2023-08-03T09:07:28.180870   +x

    2023-08-03T09:07:28.285124  / # #

    2023-08-03T09:07:28.385808  export SHELL=3D/bin/sh

    2023-08-03T09:07:28.386041  #

    2023-08-03T09:07:28.486577  / # export SHELL=3D/bin/sh. /lava-11197675/=
environment

    2023-08-03T09:07:28.486822  =


    2023-08-03T09:07:28.587399  / # . /lava-11197675/environment/lava-11197=
675/bin/lava-test-runner /lava-11197675/1

    2023-08-03T09:07:28.587737  =


    2023-08-03T09:07:28.592725  / # /lava-11197675/bin/lava-test-runner /la=
va-11197675/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6e90210baa73c635b211

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6e90210baa73c635b216
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:08:08.755832  + <8>[   12.041483] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11197734_1.4.2.3.1>

    2023-08-03T09:08:08.755915  set +x

    2023-08-03T09:08:08.859990  / # #

    2023-08-03T09:08:08.960713  export SHELL=3D/bin/sh

    2023-08-03T09:08:08.960957  #

    2023-08-03T09:08:09.061507  / # export SHELL=3D/bin/sh. /lava-11197734/=
environment

    2023-08-03T09:08:09.061747  =


    2023-08-03T09:08:09.162335  / # . /lava-11197734/environment/lava-11197=
734/bin/lava-test-runner /lava-11197734/1

    2023-08-03T09:08:09.162648  =


    2023-08-03T09:08:09.166580  / # /lava-11197734/bin/lava-test-runner /la=
va-11197734/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6e509d25e52f2e35b212

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6e509d25e52f2e35b217
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:07:19.335150  + <8>[   11.591791] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11197703_1.4.2.3.1>

    2023-08-03T09:07:19.335263  set +x

    2023-08-03T09:07:19.439521  / # #

    2023-08-03T09:07:19.540221  export SHELL=3D/bin/sh

    2023-08-03T09:07:19.540425  #

    2023-08-03T09:07:19.640955  / # export SHELL=3D/bin/sh. /lava-11197703/=
environment

    2023-08-03T09:07:19.641176  =


    2023-08-03T09:07:19.741682  / # . /lava-11197703/environment/lava-11197=
703/bin/lava-test-runner /lava-11197703/1

    2023-08-03T09:07:19.742009  =


    2023-08-03T09:07:19.746377  / # /lava-11197703/bin/lava-test-runner /la=
va-11197703/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb6ea0baa6184d4035b1f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb6ea0baa6184d4035b1f5
        failing since 125 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-03T09:08:36.733673  + <8>[   12.274723] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11197729_1.4.2.3.1>

    2023-08-03T09:08:36.733805  set +x

    2023-08-03T09:08:36.838569  / # #

    2023-08-03T09:08:36.939303  export SHELL=3D/bin/sh

    2023-08-03T09:08:36.939530  #

    2023-08-03T09:08:37.040079  / # export SHELL=3D/bin/sh. /lava-11197729/=
environment

    2023-08-03T09:08:37.040326  =


    2023-08-03T09:08:37.140892  / # . /lava-11197729/environment/lava-11197=
729/bin/lava-test-runner /lava-11197729/1

    2023-08-03T09:08:37.141165  =


    2023-08-03T09:08:37.145315  / # /lava-11197729/bin/lava-test-runner /la=
va-11197729/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb710c53751ceecd35b28c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64cb710c53751ceecd35b=
28d
        failing since 190 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb8642e2e48128c535b1ec

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb8642e2e48128c535b1f1
        failing since 6 days (last pass: v5.15.118, first fail: v5.15.123)

    2023-08-03T10:51:03.617050  / # #

    2023-08-03T10:51:03.718954  export SHELL=3D/bin/sh

    2023-08-03T10:51:03.719681  #

    2023-08-03T10:51:03.821089  / # export SHELL=3D/bin/sh. /lava-11197605/=
environment

    2023-08-03T10:51:03.821799  =


    2023-08-03T10:51:03.923206  / # . /lava-11197605/environment/lava-11197=
605/bin/lava-test-runner /lava-11197605/1

    2023-08-03T10:51:03.924204  =


    2023-08-03T10:51:03.941387  / # /lava-11197605/bin/lava-test-runner /la=
va-11197605/1

    2023-08-03T10:51:04.068288  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-03T10:51:04.068799  + cd /lava-11197605/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb86926cfa04135a35b1ea

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb86926cfa04135a35b1ef
        failing since 6 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-03T10:52:13.456355  / # #

    2023-08-03T10:52:13.558538  export SHELL=3D/bin/sh

    2023-08-03T10:52:13.559251  #

    2023-08-03T10:52:13.660648  / # export SHELL=3D/bin/sh. /lava-11197962/=
environment

    2023-08-03T10:52:13.661381  =


    2023-08-03T10:52:13.762737  / # . /lava-11197962/environment/lava-11197=
962/bin/lava-test-runner /lava-11197962/1

    2023-08-03T10:52:13.763856  =


    2023-08-03T10:52:13.780535  / # /lava-11197962/bin/lava-test-runner /la=
va-11197962/1

    2023-08-03T10:52:13.829510  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-03T10:52:13.830021  + cd /lav<8>[   16.008196] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11197962_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb70d14c5ffabc1235b2b1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb70d14c5ffabc1235b2b6
        failing since 7 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-03T09:17:57.458796  / # #

    2023-08-03T09:17:58.538183  export SHELL=3D/bin/sh

    2023-08-03T09:17:58.540143  #

    2023-08-03T09:18:00.030159  / # export SHELL=3D/bin/sh. /lava-11197964/=
environment

    2023-08-03T09:18:00.032092  =


    2023-08-03T09:18:02.751964  / # . /lava-11197964/environment/lava-11197=
964/bin/lava-test-runner /lava-11197964/1

    2023-08-03T09:18:02.754149  =


    2023-08-03T09:18:02.766146  / # /lava-11197964/bin/lava-test-runner /la=
va-11197964/1

    2023-08-03T09:18:02.825257  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-03T09:18:02.825724  + cd /lava-111979<8>[   25.508178] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11197964_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb70aedac43a8a6835b290

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.124/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb70aedac43a8a6835b295
        failing since 7 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-03T09:19:06.494755  / # #

    2023-08-03T09:19:06.595258  export SHELL=3D/bin/sh

    2023-08-03T09:19:06.595368  #

    2023-08-03T09:19:06.695818  / # export SHELL=3D/bin/sh. /lava-11197969/=
environment

    2023-08-03T09:19:06.695933  =


    2023-08-03T09:19:06.796361  / # . /lava-11197969/environment/lava-11197=
969/bin/lava-test-runner /lava-11197969/1

    2023-08-03T09:19:06.796590  =


    2023-08-03T09:19:06.808404  / # /lava-11197969/bin/lava-test-runner /la=
va-11197969/1

    2023-08-03T09:19:06.869457  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-03T09:19:06.869537  + cd /lava-1119796<8>[   16.861897] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11197969_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
