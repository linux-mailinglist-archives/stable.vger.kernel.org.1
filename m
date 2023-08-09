Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DAF77655C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 18:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjHIQqh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjHIQqg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 12:46:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336C1BFF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 09:46:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso577245ad.2
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691599594; x=1692204394;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d4AlgEK69FrDUyQTpbXrGNdjhpuN8fqF/+6AHOuhV3Y=;
        b=VR3XKG64798qH4QG5vC9Hea/aBssQjrCzmjyg9iP4hkhIhccpzo9ByGOI8EFsOzJUX
         nY3iDFdi3W98xLIOmp5OZ0JglSxNnNFcnErKiN0fJjJOWoECSgvveNRhpWXX74inuP+l
         P6UoFzqJE7XjxPJwU+4UaOJvRneHxIUSMeCj13+NyJymwFmCUBoQu4u9RusTzXlHwEUR
         mXy4DFbIf2heQ3b1c6mFUzwDNFVbntx+cVjeyOsuOaJNouHpokB+dMV0W/T+ZcZKYp1b
         7z2p/BakfuuTa72P7ODdQhXp3tY6pDM6E1WuJ+QrMtnAL81WwQd62vTi4uBzgsnCswYZ
         2DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599594; x=1692204394;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4AlgEK69FrDUyQTpbXrGNdjhpuN8fqF/+6AHOuhV3Y=;
        b=O7vNv9cQs9c32s/oZK8c0xXSIAjXeqxTjAKpohhY4NTy+WKQm3dg5lU1efXZwR8Bcm
         nn6lsWi2n9SuzwUutiplaO9J9ilppYREzFHyp/F1PF1UB2roBoBUs1yEWnkvj9v00HeH
         Q3NZP9MHi+hxI9XKc+HWCcP+v8alDzWCqUK7bPu7iPQO5qYc9ovdunfHS5uPGUF3aYX1
         spubK8VXYQ/a4zfXvIBRPlrZcwkQmccp+Ze5TnsrrHFWTiW4JcoIHJn5oU1kN8BaIoD4
         c7PdBuQnkE0kYMf5htMXBLu5yTqmVJN+wyo2/q8C/oAW+3c/I4dOstmnYV1QH+k5lAxC
         kAgg==
X-Gm-Message-State: AOJu0Yyuydj0lOXzn3nbNu597mQ281FG6vDeUmk6K+MFEs+hx3SkPqs1
        hk9MBIwuSfYz6CtfT26cbIH5YP0RGmWLCpWIxttORg==
X-Google-Smtp-Source: AGHT+IGq3CtBX1Mta0kOqrqM8Vii54vcSa7YBOSgUGDQQ5bd6PgiC2zh+Dp/mHfIsuXGDm9RBuMqew==
X-Received: by 2002:a17:902:d38d:b0:1b6:6e3a:77fb with SMTP id e13-20020a170902d38d00b001b66e3a77fbmr3268774pld.2.1691599594347;
        Wed, 09 Aug 2023 09:46:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001bba3650448sm11509753plk.258.2023.08.09.09.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:46:33 -0700 (PDT)
Message-ID: <64d3c2e9.170a0220.5c69d.6081@mx.google.com>
Date:   Wed, 09 Aug 2023 09:46:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.125-93-gae7f23cbf199
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 50 runs,
 8 regressions (v5.15.125-93-gae7f23cbf199)
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

stable-rc/linux-5.15.y baseline: 50 runs, 8 regressions (v5.15.125-93-gae7f=
23cbf199)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.125-93-gae7f23cbf199/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.125-93-gae7f23cbf199
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ae7f23cbf199ef4564263bdf82cbcedca2f4d60c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38fd911bc95a57835b25c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38fd911bc95a57835b261
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-09T13:08:18.281513  <8>[   11.862679] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11245242_1.4.2.3.1>

    2023-08-09T13:08:18.284793  + set +x

    2023-08-09T13:08:18.388714  / # #

    2023-08-09T13:08:18.490080  export SHELL=3D/bin/sh

    2023-08-09T13:08:18.490707  #

    2023-08-09T13:08:18.591911  / # export SHELL=3D/bin/sh. /lava-11245242/=
environment

    2023-08-09T13:08:18.592596  =


    2023-08-09T13:08:18.693896  / # . /lava-11245242/environment/lava-11245=
242/bin/lava-test-runner /lava-11245242/1

    2023-08-09T13:08:18.694879  =


    2023-08-09T13:08:18.700478  / # /lava-11245242/bin/lava-test-runner /la=
va-11245242/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38e93a7466d3c7c35b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d38e93a7466d3c7c35b=
1da
        new failure (last pass: v5.15.125-87-g976c140e8e74d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38da42ccb67b9d335b232

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38da42ccb67b9d335b237
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-09T12:58:58.827079  <8>[   10.746051] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11245225_1.4.2.3.1>

    2023-08-09T12:58:58.830311  + set +x

    2023-08-09T12:58:58.935747  =


    2023-08-09T12:58:59.037404  / # #export SHELL=3D/bin/sh

    2023-08-09T12:58:59.038036  =


    2023-08-09T12:58:59.139365  / # export SHELL=3D/bin/sh. /lava-11245225/=
environment

    2023-08-09T12:58:59.140024  =


    2023-08-09T12:58:59.241435  / # . /lava-11245225/environment/lava-11245=
225/bin/lava-test-runner /lava-11245225/1

    2023-08-09T12:58:59.242470  =


    2023-08-09T12:58:59.247194  / # /lava-11245225/bin/lava-test-runner /la=
va-11245225/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d392fd8026cf551f35b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d392fd8026cf551f35b=
1da
        failing since 14 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38d8493ef1240e135b225

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38d8493ef1240e135b22a
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-09T12:58:59.591296  + set +x

    2023-08-09T12:58:59.598143  <8>[    7.869131] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11245248_1.4.2.3.1>

    2023-08-09T12:58:59.702396  / # #

    2023-08-09T12:58:59.802977  export SHELL=3D/bin/sh

    2023-08-09T12:58:59.803141  #

    2023-08-09T12:58:59.903629  / # export SHELL=3D/bin/sh. /lava-11245248/=
environment

    2023-08-09T12:58:59.903822  =


    2023-08-09T12:59:00.004350  / # . /lava-11245248/environment/lava-11245=
248/bin/lava-test-runner /lava-11245248/1

    2023-08-09T12:59:00.004599  =


    2023-08-09T12:59:00.009443  / # /lava-11245248/bin/lava-test-runner /la=
va-11245248/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38d8893ef1240e135b230

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38d8893ef1240e135b235
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-09T12:58:36.158745  <8>[   10.331213] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11245243_1.4.2.3.1>

    2023-08-09T12:58:36.162055  + set +x

    2023-08-09T12:58:36.268024  =


    2023-08-09T12:58:36.369911  / # #export SHELL=3D/bin/sh

    2023-08-09T12:58:36.370697  =


    2023-08-09T12:58:36.472280  / # export SHELL=3D/bin/sh. /lava-11245243/=
environment

    2023-08-09T12:58:36.473071  =


    2023-08-09T12:58:36.574680  / # . /lava-11245243/environment/lava-11245=
243/bin/lava-test-runner /lava-11245243/1

    2023-08-09T12:58:36.575972  =


    2023-08-09T12:58:36.581783  / # /lava-11245243/bin/lava-test-runner /la=
va-11245243/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38d922ccb67b9d335b1fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38d922ccb67b9d335b201
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-09T12:58:49.433911  + <8>[   11.635875] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11245241_1.4.2.3.1>

    2023-08-09T12:58:49.433988  set +x

    2023-08-09T12:58:49.538287  / # #

    2023-08-09T12:58:49.638824  export SHELL=3D/bin/sh

    2023-08-09T12:58:49.638985  #

    2023-08-09T12:58:49.739509  / # export SHELL=3D/bin/sh. /lava-11245241/=
environment

    2023-08-09T12:58:49.739661  =


    2023-08-09T12:58:49.840178  / # . /lava-11245241/environment/lava-11245=
241/bin/lava-test-runner /lava-11245241/1

    2023-08-09T12:58:49.840467  =


    2023-08-09T12:58:49.845187  / # /lava-11245241/bin/lava-test-runner /la=
va-11245241/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38d7c93ef1240e135b1fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
25-93-gae7f23cbf199/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38d7c93ef1240e135b200
        failing since 133 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-09T12:58:23.597728  + set +x<8>[   12.612764] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11245212_1.4.2.3.1>

    2023-08-09T12:58:23.597835  =


    2023-08-09T12:58:23.701800  / # #

    2023-08-09T12:58:23.802372  export SHELL=3D/bin/sh

    2023-08-09T12:58:23.802554  #

    2023-08-09T12:58:23.903077  / # export SHELL=3D/bin/sh. /lava-11245212/=
environment

    2023-08-09T12:58:23.903258  =


    2023-08-09T12:58:24.003737  / # . /lava-11245212/environment/lava-11245=
212/bin/lava-test-runner /lava-11245212/1

    2023-08-09T12:58:24.004058  =


    2023-08-09T12:58:24.009179  / # /lava-11245212/bin/lava-test-runner /la=
va-11245212/1
 =

    ... (12 line(s) more)  =

 =20
