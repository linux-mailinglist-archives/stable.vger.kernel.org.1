Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46282774FFE
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 02:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHIAph (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 20:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjHIApg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 20:45:36 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0F619A1
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 17:45:33 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7656652da3cso440801985a.1
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 17:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691541932; x=1692146732;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O80Rg6R6r8tKWu5djPZUxC9W2ujPoD2ZzOq0Gs9PAvY=;
        b=VlBvk+UPE7J0x3apt5kvk9axh9NZ4oougxbmntSIxY+zsioYs9WBSZIQRqx6ifJxd8
         9Zf2bPq67Vwja6z0EhL8HKOWbirxhR10c2ohfLbj4GczMzh1yaVNU4tJqfzQ5w0W1R4k
         07G7RKWUfTnRUi4PrQBoceI1AjpTMIIzAuV/niwl5WOJgszfN2FpVIyt38XAwi/yw+mt
         2qQKA0y+P/9DnRqiP7bN0QnZ5yn1ryBnPD+6Ic5yRNQnOJg0Z9ebGGBgPEq9FsteblNI
         t+bmV81Za98T6kktXREt+X90XfbjwmHS26G26MNOY97z9mC3dDpggkV0FHCb9UAvZY5v
         XCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541932; x=1692146732;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O80Rg6R6r8tKWu5djPZUxC9W2ujPoD2ZzOq0Gs9PAvY=;
        b=U3dmsVJ+N7frEIKDXS/9jF5tw+jjD9dvIC1fHqQJMfamlWEC+AVi5IzrfFGsbkY6Xl
         S/X9AyisgE5MJnACaMfmEBi391v68nC/j/dvUE0zc/VGuCXHbGIR2TQEfQhW2bA8agG1
         msbqtH82p04lAfz1jvacgyAn2tuHtHgyelNThvCDOZBmeJv9d8Y4jjGNP1aivfsgDFLr
         HHrgNLD00QWAOKWQziWmQ5OoOE5vuILsuljgQBwVyeHfa2iPqQFnJ4+LzDUMquvwvyOg
         p6bXjfRG+Mad+bjzt0LUF92uTQyWK3gBhEpC03oiSPvvwZEqhOjT86g1ZlFfcMTyZJjE
         E8WA==
X-Gm-Message-State: AOJu0YwSKDo4ljDJnyIj8vJYxsLyeb+3pJQfYKVvdc2VxeEcPH7hAy85
        xTshnTviXXl27sx/5vGpn1bDfw6DLFTfcWfW0v11ug==
X-Google-Smtp-Source: AGHT+IFBDZ9s8J9leuhWebBespLwppOq2gzrOV7/kyOeqAFpk4ODwrfD24ldo6Fq0e52zbTZNhK47A==
X-Received: by 2002:a05:620a:830f:b0:76c:af30:3281 with SMTP id pa15-20020a05620a830f00b0076caf303281mr1390933qkn.10.1691541931457;
        Tue, 08 Aug 2023 17:45:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t22-20020a62ea16000000b0066a4e561beesm8896557pfh.173.2023.08.08.17.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:45:30 -0700 (PDT)
Message-ID: <64d2e1aa.620a0220.8a251.115a@mx.google.com>
Date:   Tue, 08 Aug 2023 17:45:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.125
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.15.y
Subject: stable/linux-5.15.y baseline: 185 runs, 24 regressions (v5.15.125)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.15.y baseline: 185 runs, 24 regressions (v5.15.125)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-R721T-grunt             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.125/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.125
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      c275eaaaa34260e6c907bc5e7ee07c096bc45064 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-R721T-grunt             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2afa64be61bce8c35b207

  Results:     18 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-R=
721T-grunt.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-R=
721T-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/64d2afa64be61bc=
e8c35b21a
        new failure (last pass: v5.15.124)
        1 lines

    2023-08-08T21:11:41.224905  kern  :emerg : __common_interrupt: 1.55 No =
irq handler for vector<8>[   11.059936] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=
=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>

    2023-08-08T21:11:41.225464  =

   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ad3b74e952a73935b1f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ad3b74e952a73935b1fa
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:01:33.788886  <8>[   11.598945] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236734_1.4.2.3.1>

    2023-08-08T21:01:33.792206  + set +x

    2023-08-08T21:01:33.894798  =


    2023-08-08T21:01:33.996827  / # #export SHELL=3D/bin/sh

    2023-08-08T21:01:33.997533  =


    2023-08-08T21:01:34.099127  / # export SHELL=3D/bin/sh. /lava-11236734/=
environment

    2023-08-08T21:01:34.099917  =


    2023-08-08T21:01:34.201301  / # . /lava-11236734/environment/lava-11236=
734/bin/lava-test-runner /lava-11236734/1

    2023-08-08T21:01:34.202406  =


    2023-08-08T21:01:34.208555  / # /lava-11236734/bin/lava-test-runner /la=
va-11236734/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2afe5192b2a828d35b1e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2afe5192b2a828d35b1ed
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:12:52.833068  <8>[   10.464195] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236890_1.4.2.3.1>

    2023-08-08T21:12:52.836702  + set +x

    2023-08-08T21:12:52.941058  / # #

    2023-08-08T21:12:53.041608  export SHELL=3D/bin/sh

    2023-08-08T21:12:53.041749  #

    2023-08-08T21:12:53.142232  / # export SHELL=3D/bin/sh. /lava-11236890/=
environment

    2023-08-08T21:12:53.142386  =


    2023-08-08T21:12:53.242846  / # . /lava-11236890/environment/lava-11236=
890/bin/lava-test-runner /lava-11236890/1

    2023-08-08T21:12:53.243085  =


    2023-08-08T21:12:53.248550  / # /lava-11236890/bin/lava-test-runner /la=
va-11236890/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ad1328b62a8f1535b247

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ad1328b62a8f1535b24c
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:01:07.017171  + <8>[   10.322485] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11236710_1.4.2.3.1>

    2023-08-08T21:01:07.017255  set +x

    2023-08-08T21:01:07.121712  / # #

    2023-08-08T21:01:07.222248  export SHELL=3D/bin/sh

    2023-08-08T21:01:07.222388  #

    2023-08-08T21:01:07.322890  / # export SHELL=3D/bin/sh. /lava-11236710/=
environment

    2023-08-08T21:01:07.323145  =


    2023-08-08T21:01:07.423737  / # . /lava-11236710/environment/lava-11236=
710/bin/lava-test-runner /lava-11236710/1

    2023-08-08T21:01:07.423993  =


    2023-08-08T21:01:07.429037  / # /lava-11236710/bin/lava-test-runner /la=
va-11236710/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2afa8769eef27dd35b1f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2afa8769eef27dd35b1f6
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:11:51.020790  + set<8>[   11.805697] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11236926_1.4.2.3.1>

    2023-08-08T21:11:51.020895   +x

    2023-08-08T21:11:51.125249  / # #

    2023-08-08T21:11:51.225855  export SHELL=3D/bin/sh

    2023-08-08T21:11:51.226002  #

    2023-08-08T21:11:51.326457  / # export SHELL=3D/bin/sh. /lava-11236926/=
environment

    2023-08-08T21:11:51.326612  =


    2023-08-08T21:11:51.427079  / # . /lava-11236926/environment/lava-11236=
926/bin/lava-test-runner /lava-11236926/1

    2023-08-08T21:11:51.427358  =


    2023-08-08T21:11:51.431979  / # /lava-11236926/bin/lava-test-runner /la=
va-11236926/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ad27d4c57ac28435b1f8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ad27d4c57ac28435b1fd
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:01:18.616414  <8>[    9.209589] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236739_1.4.2.3.1>

    2023-08-08T21:01:18.619349  + set +x

    2023-08-08T21:01:18.720860  =


    2023-08-08T21:01:18.821451  / # #export SHELL=3D/bin/sh

    2023-08-08T21:01:18.821674  =


    2023-08-08T21:01:18.922241  / # export SHELL=3D/bin/sh. /lava-11236739/=
environment

    2023-08-08T21:01:18.922469  =


    2023-08-08T21:01:19.023031  / # . /lava-11236739/environment/lava-11236=
739/bin/lava-test-runner /lava-11236739/1

    2023-08-08T21:01:19.023323  =


    2023-08-08T21:01:19.028303  / # /lava-11236739/bin/lava-test-runner /la=
va-11236739/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2afa94be61bce8c35b245

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2afa94be61bce8c35b24a
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:11:51.880626  <8>[   10.509286] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236887_1.4.2.3.1>

    2023-08-08T21:11:51.884115  + set +x

    2023-08-08T21:11:51.989792  #

    2023-08-08T21:11:51.990986  =


    2023-08-08T21:11:52.093038  / # #export SHELL=3D/bin/sh

    2023-08-08T21:11:52.093872  =


    2023-08-08T21:11:52.195403  / # export SHELL=3D/bin/sh. /lava-11236887/=
environment

    2023-08-08T21:11:52.196188  =


    2023-08-08T21:11:52.297863  / # . /lava-11236887/environment/lava-11236=
887/bin/lava-test-runner /lava-11236887/1

    2023-08-08T21:11:52.299104  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2adf3170736a46235b1de

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2adf3170736a46235b1e3
        failing since 12 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-08T21:06:08.709328  / # #

    2023-08-08T21:06:08.811457  export SHELL=3D/bin/sh

    2023-08-08T21:06:08.812161  #

    2023-08-08T21:06:08.913605  / # export SHELL=3D/bin/sh. /lava-11236748/=
environment

    2023-08-08T21:06:08.914324  =


    2023-08-08T21:06:09.015761  / # . /lava-11236748/environment/lava-11236=
748/bin/lava-test-runner /lava-11236748/1

    2023-08-08T21:06:09.016851  =


    2023-08-08T21:06:09.033502  / # /lava-11236748/bin/lava-test-runner /la=
va-11236748/1

    2023-08-08T21:06:09.141466  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T21:06:09.141976  + cd /lava-11236748/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2b058a74d86e75535b20a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2b058a74d86e75535b=
20b
        failing since 125 days (last pass: v5.15.105, first fail: v5.15.106=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2af1797fcd5dd0335b1de

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2af1797fcd5dd0335b1e3
        failing since 202 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-08-08T21:09:30.547250  + set +x<8>[   10.016378] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3733550_1.5.2.4.1>
    2023-08-08T21:09:30.547972  =

    2023-08-08T21:09:30.657796  / # #
    2023-08-08T21:09:30.761494  export SHELL=3D/bin/sh
    2023-08-08T21:09:30.762608  #
    2023-08-08T21:09:30.864979  / # export SHELL=3D/bin/sh. /lava-3733550/e=
nvironment
    2023-08-08T21:09:30.866232  =

    2023-08-08T21:09:30.968746  / # . /lava-3733550/environment/lava-373355=
0/bin/lava-test-runner /lava-3733550/1
    2023-08-08T21:09:30.970465  =

    2023-08-08T21:09:30.975603  / # /lava-3733550/bin/lava-test-runner /lav=
a-3733550/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ac82624303961135b1e1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ac82624303961135b1e4
        failing since 158 days (last pass: v5.15.79, first fail: v5.15.97)

    2023-08-08T20:58:19.217012  / # #
    2023-08-08T20:58:19.318870  export SHELL=3D/bin/sh
    2023-08-08T20:58:19.319354  #
    2023-08-08T20:58:19.420376  / # export SHELL=3D/bin/sh. /lava-1241819/e=
nvironment
    2023-08-08T20:58:19.420796  =

    2023-08-08T20:58:19.521864  / # . /lava-1241819/environment/lava-124181=
9/bin/lava-test-runner /lava-1241819/1
    2023-08-08T20:58:19.522623  =

    2023-08-08T20:58:19.525275  / # /lava-1241819/bin/lava-test-runner /lav=
a-1241819/1
    2023-08-08T20:58:19.541047  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-08T20:58:19.546664  + cd /lava-1241819/1/[   15.265945] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 1241819_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ad16d4c57ac28435b1de

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ad16d4c57ac28435b1e3
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:00:45.899654  + set +x

    2023-08-08T21:00:45.906209  <8>[   12.221951] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236736_1.4.2.3.1>

    2023-08-08T21:00:46.010434  / # #

    2023-08-08T21:00:46.111003  export SHELL=3D/bin/sh

    2023-08-08T21:00:46.111159  #

    2023-08-08T21:00:46.211649  / # export SHELL=3D/bin/sh. /lava-11236736/=
environment

    2023-08-08T21:00:46.211813  =


    2023-08-08T21:00:46.312330  / # . /lava-11236736/environment/lava-11236=
736/bin/lava-test-runner /lava-11236736/1

    2023-08-08T21:00:46.312671  =


    2023-08-08T21:00:46.316970  / # /lava-11236736/bin/lava-test-runner /la=
va-11236736/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2affbb6503d9b6535b234

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2affbb6503d9b6535b239
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:13:13.881564  + <8>[   10.126588] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11236922_1.4.2.3.1>

    2023-08-08T21:13:13.882083  set +x

    2023-08-08T21:13:13.990417  =


    2023-08-08T21:13:14.092295  / # #export SHELL=3D/bin/sh

    2023-08-08T21:13:14.093129  =


    2023-08-08T21:13:14.194931  / # export SHELL=3D/bin/sh. /lava-11236922/=
environment

    2023-08-08T21:13:14.195766  =


    2023-08-08T21:13:14.297420  / # . /lava-11236922/environment/lava-11236=
922/bin/lava-test-runner /lava-11236922/1

    2023-08-08T21:13:14.298840  =


    2023-08-08T21:13:14.303691  / # /lava-11236922/bin/lava-test-runner /la=
va-11236922/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ad25789c246bb035b213

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ad25789c246bb035b218
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:01:38.290338  + set<8>[   11.915221] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11236724_1.4.2.3.1>

    2023-08-08T21:01:38.290430   +x

    2023-08-08T21:01:38.392445  #

    2023-08-08T21:01:38.392765  =


    2023-08-08T21:01:38.493413  / # #export SHELL=3D/bin/sh

    2023-08-08T21:01:38.493612  =


    2023-08-08T21:01:38.594144  / # export SHELL=3D/bin/sh. /lava-11236724/=
environment

    2023-08-08T21:01:38.594393  =


    2023-08-08T21:01:38.694976  / # . /lava-11236724/environment/lava-11236=
724/bin/lava-test-runner /lava-11236724/1

    2023-08-08T21:01:38.695284  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2afa44be61bce8c35b1fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2afa44be61bce8c35b201
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:12:13.340608  + set<8>[   10.965638] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11236897_1.4.2.3.1>

    2023-08-08T21:12:13.340695   +x

    2023-08-08T21:12:13.442338  /#

    2023-08-08T21:12:13.543202   # #export SHELL=3D/bin/sh

    2023-08-08T21:12:13.543410  =


    2023-08-08T21:12:13.643976  / # export SHELL=3D/bin/sh. /lava-11236897/=
environment

    2023-08-08T21:12:13.644158  =


    2023-08-08T21:12:13.744729  / # . /lava-11236897/environment/lava-11236=
897/bin/lava-test-runner /lava-11236897/1

    2023-08-08T21:12:13.745045  =


    2023-08-08T21:12:13.749893  / # /lava-11236897/bin/lava-test-runner /la=
va-11236897/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ad38d4c57ac28435b215

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ad38d4c57ac28435b21a
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:01:23.297505  + set +x

    2023-08-08T21:01:23.300739  <8>[   12.961827] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236713_1.4.2.3.1>

    2023-08-08T21:01:23.404649  / # #

    2023-08-08T21:01:23.505232  export SHELL=3D/bin/sh

    2023-08-08T21:01:23.505405  #

    2023-08-08T21:01:23.605959  / # export SHELL=3D/bin/sh. /lava-11236713/=
environment

    2023-08-08T21:01:23.606128  =


    2023-08-08T21:01:23.706677  / # . /lava-11236713/environment/lava-11236=
713/bin/lava-test-runner /lava-11236713/1

    2023-08-08T21:01:23.707001  =


    2023-08-08T21:01:23.712252  / # /lava-11236713/bin/lava-test-runner /la=
va-11236713/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2afa44be61bce8c35b1f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2afa44be61bce8c35b1f6
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:11:44.236848  + set<8>[   11.089555] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11236883_1.4.2.3.1>

    2023-08-08T21:11:44.237415   +x

    2023-08-08T21:11:44.345305  / # #

    2023-08-08T21:11:44.447783  export SHELL=3D/bin/sh

    2023-08-08T21:11:44.448553  #

    2023-08-08T21:11:44.550075  / # export SHELL=3D/bin/sh. /lava-11236883/=
environment

    2023-08-08T21:11:44.550886  =


    2023-08-08T21:11:44.652556  / # . /lava-11236883/environment/lava-11236=
883/bin/lava-test-runner /lava-11236883/1

    2023-08-08T21:11:44.653776  =


    2023-08-08T21:11:44.659571  / # /lava-11236883/bin/lava-test-runner /la=
va-11236883/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ad15561f4cc29e35b1d9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ad15561f4cc29e35b1de
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:00:51.511094  + <8>[   12.746604] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11236728_1.4.2.3.1>

    2023-08-08T21:00:51.511515  set +x

    2023-08-08T21:00:51.618605  / # #

    2023-08-08T21:00:51.720776  export SHELL=3D/bin/sh

    2023-08-08T21:00:51.721617  #

    2023-08-08T21:00:51.823110  / # export SHELL=3D/bin/sh. /lava-11236728/=
environment

    2023-08-08T21:00:51.823795  =


    2023-08-08T21:00:51.925406  / # . /lava-11236728/environment/lava-11236=
728/bin/lava-test-runner /lava-11236728/1

    2023-08-08T21:00:51.926492  =


    2023-08-08T21:00:51.931626  / # /lava-11236728/bin/lava-test-runner /la=
va-11236728/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2afa833497bbbe835b246

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2afa833497bbbe835b24b
        failing since 131 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-08-08T21:11:55.251335  + set<8>[   11.318629] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11236914_1.4.2.3.1>

    2023-08-08T21:11:55.251420   +x

    2023-08-08T21:11:55.355450  / # #

    2023-08-08T21:11:55.456377  export SHELL=3D/bin/sh

    2023-08-08T21:11:55.457172  #

    2023-08-08T21:11:55.558781  / # export SHELL=3D/bin/sh. /lava-11236914/=
environment

    2023-08-08T21:11:55.559638  =


    2023-08-08T21:11:55.661316  / # . /lava-11236914/environment/lava-11236=
914/bin/lava-test-runner /lava-11236914/1

    2023-08-08T21:11:55.662535  =


    2023-08-08T21:11:55.668020  / # /lava-11236914/bin/lava-test-runner /la=
va-11236914/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2b14b66b27a8fe135b1e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2b14b66b27a8fe135b=
1e9
        failing since 196 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ac14228fc29bfb35b1de

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ac14228fc29bfb35b1e3
        failing since 12 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-08T20:58:07.087247  / # #

    2023-08-08T20:58:07.189346  export SHELL=3D/bin/sh

    2023-08-08T20:58:07.190050  #

    2023-08-08T20:58:07.291421  / # export SHELL=3D/bin/sh. /lava-11236675/=
environment

    2023-08-08T20:58:07.292136  =


    2023-08-08T20:58:07.393592  / # . /lava-11236675/environment/lava-11236=
675/bin/lava-test-runner /lava-11236675/1

    2023-08-08T20:58:07.394687  =


    2023-08-08T20:58:07.411646  / # /lava-11236675/bin/lava-test-runner /la=
va-11236675/1

    2023-08-08T20:58:07.460396  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T20:58:07.460929  + cd /lav<8>[   16.003368] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11236675_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2af0c65bb99e64c35b1e0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2af0c65bb99e64c35b1e5
        failing since 12 days (last pass: v5.15.118, first fail: v5.15.123)

    2023-08-08T21:10:58.386275  / # #

    2023-08-08T21:10:58.488491  export SHELL=3D/bin/sh

    2023-08-08T21:10:58.489263  #

    2023-08-08T21:10:58.590683  / # export SHELL=3D/bin/sh. /lava-11236837/=
environment

    2023-08-08T21:10:58.591395  =


    2023-08-08T21:10:58.692740  / # . /lava-11236837/environment/lava-11236=
837/bin/lava-test-runner /lava-11236837/1

    2023-08-08T21:10:58.693772  =


    2023-08-08T21:10:58.698915  / # /lava-11236837/bin/lava-test-runner /la=
va-11236837/1

    2023-08-08T21:10:58.839843  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T21:10:58.840347  + cd /lava-11236837/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ac509e1be3767935b21d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ac509e1be3767935b222
        failing since 12 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-08T20:57:59.800765  / # #

    2023-08-08T20:58:00.881287  export SHELL=3D/bin/sh

    2023-08-08T20:58:00.883098  #

    2023-08-08T20:58:02.373841  / # export SHELL=3D/bin/sh. /lava-11236681/=
environment

    2023-08-08T20:58:02.375794  =


    2023-08-08T20:58:05.101203  / # . /lava-11236681/environment/lava-11236=
681/bin/lava-test-runner /lava-11236681/1

    2023-08-08T20:58:05.103380  =


    2023-08-08T20:58:05.109494  / # /lava-11236681/bin/lava-test-runner /la=
va-11236681/1

    2023-08-08T20:58:05.173179  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T20:58:05.173696  + cd /lava-112366<8>[   25.531053] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11236681_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ac1229e0d3091435b252

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.125/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2ac1229e0d3091435b257
        failing since 12 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-08-08T20:58:19.000358  / # #

    2023-08-08T20:58:19.102550  export SHELL=3D/bin/sh

    2023-08-08T20:58:19.103264  #

    2023-08-08T20:58:19.204677  / # export SHELL=3D/bin/sh. /lava-11236672/=
environment

    2023-08-08T20:58:19.205428  =


    2023-08-08T20:58:19.306881  / # . /lava-11236672/environment/lava-11236=
672/bin/lava-test-runner /lava-11236672/1

    2023-08-08T20:58:19.307980  =


    2023-08-08T20:58:19.324385  / # /lava-11236672/bin/lava-test-runner /la=
va-11236672/1

    2023-08-08T20:58:19.382499  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T20:58:19.383006  + cd /lava-1123667<8>[   16.886148] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11236672_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
