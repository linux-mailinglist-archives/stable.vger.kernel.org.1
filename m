Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2847CAC81
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjJPOzr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjJPOzq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:55:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F59B4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:55:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so1357475b3a.2
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697468142; x=1698072942; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8nx2G9U0q5KJHUb/+P7uPnEazDYsuEvExZeo3x2+Jw=;
        b=JxU/tuy+8EE8wXJvkIshznkO3WEJ+EDUmXPxBV+dQCrSfmPGbYXI2Inpkn9AphNMzd
         ol4f7dh4DfCsmbSUF3gwQJueIdRB9lPBK70rI2rIZH5se/Y5T6GOOKXIddYhZ06QbiAA
         jYr+7UHVyEiNk4A/3tDeobXhvHx3qwqsH1KIZue49wI/2KIiTMyhUrLt8cjCWG5Eca5h
         hbgTA2uizaXpybdmWE9xaJDObFuP1gRmtM1JO0cxrcynyYdzvUXVoXQuXM0Xtw5S8OnW
         yEV3Tk3yiNIeFhsabyai2vzltk8Em19RzL11/fmm0rN/T9wxis9wVEtnHJYQEE3hEDkB
         qsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697468142; x=1698072942;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8nx2G9U0q5KJHUb/+P7uPnEazDYsuEvExZeo3x2+Jw=;
        b=Y9bF9Vl7dy/bqelDILlEZZT8B/fYhC6Z+lspIQT+iscfsC2SVsy9bJpb43Cp9QguPF
         cApWaQnFnjAjThdk56aEaubQ+OAz+Tk+K5LVuJknwzYgtT6Z8s1ELdwU/yZyWO1wv9f/
         xqNEkj+LVpphQ/119yd2e4sv9y5KQz+CHF80HrkrBEUbH0YUGEJIZUj3DIhgLyjj3oqJ
         5sr0Bb34WHz8p4qEJLX9/MlaMYYjWR9VjtYQqObuvmBIS7Yog9FQmtXQB7T+NipILBtP
         VHeYTVMJuePHhp0PacF3InTJ9sJ7PiyPSOAi6BMb997y6qGU/WUiFDB4lCij6BDPxhKv
         WEAw==
X-Gm-Message-State: AOJu0YycV0hH6UXv8sg/4zV45zNgI2ZOLE1ukfySkaBjrXvDWIrkhrNs
        5Q3aR3o/lrHWiVhJtDHpCuZczwUmGNgmw11b35iQfQ==
X-Google-Smtp-Source: AGHT+IElhAKf06kp/PJsmegXgUkDRbIXPeUXwZAHQH7DcHJqINhh1Nil+LpLWoYh2CJTGV1SZgcWyQ==
X-Received: by 2002:a05:6a00:23c4:b0:6be:bf7:fda5 with SMTP id g4-20020a056a0023c400b006be0bf7fda5mr3139288pfc.12.1697468141702;
        Mon, 16 Oct 2023 07:55:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v3-20020aa799c3000000b006934a1c69f8sm1231810pfi.24.2023.10.16.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:55:41 -0700 (PDT)
Message-ID: <652d4eed.a70a0220.7af84.2f2d@mx.google.com>
Date:   Mon, 16 Oct 2023 07:55:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.135-103-gf11fc66f963f
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 160 runs,
 10 regressions (v5.15.135-103-gf11fc66f963f)
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

stable-rc/linux-5.15.y baseline: 160 runs, 10 regressions (v5.15.135-103-gf=
11fc66f963f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-clabbe    | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.135-103-gf11fc66f963f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.135-103-gf11fc66f963f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f11fc66f963fdd01d969cd3dbb90f0f775de525e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1b77f0bae5633eefcf30

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1b77f0bae5633eefcf39
        failing since 201 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-16T11:15:50.314358  + set +x

    2023-10-16T11:15:50.321420  <8>[   10.699732] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11790137_1.4.2.3.1>

    2023-10-16T11:15:50.423368  =


    2023-10-16T11:15:50.524003  / # #export SHELL=3D/bin/sh

    2023-10-16T11:15:50.524236  =


    2023-10-16T11:15:50.624766  / # export SHELL=3D/bin/sh. /lava-11790137/=
environment

    2023-10-16T11:15:50.624976  =


    2023-10-16T11:15:50.725684  / # . /lava-11790137/environment/lava-11790=
137/bin/lava-test-runner /lava-11790137/1

    2023-10-16T11:15:50.725967  =


    2023-10-16T11:15:50.731067  / # /lava-11790137/bin/lava-test-runner /la=
va-11790137/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1b745c33b65d51efcef3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1b745c33b65d51efcefc
        failing since 201 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-16T11:15:41.349889  <8>[   10.482305] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11790145_1.4.2.3.1>

    2023-10-16T11:15:41.353225  + set +x

    2023-10-16T11:15:41.454754  #

    2023-10-16T11:15:41.455088  =


    2023-10-16T11:15:41.555727  / # #export SHELL=3D/bin/sh

    2023-10-16T11:15:41.555914  =


    2023-10-16T11:15:41.656422  / # export SHELL=3D/bin/sh. /lava-11790145/=
environment

    2023-10-16T11:15:41.656645  =


    2023-10-16T11:15:41.757294  / # . /lava-11790145/environment/lava-11790=
145/bin/lava-test-runner /lava-11790145/1

    2023-10-16T11:15:41.757638  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1d971e3443df73efcf4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652d1d971e3443df73efc=
f4d
        new failure (last pass: v5.15.133) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1b59cfd42f0e71efcf58

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1b59cfd42f0e71efcf61
        failing since 201 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-16T11:15:24.470126  <8>[   10.677219] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11790161_1.4.2.3.1>

    2023-10-16T11:15:24.473384  + set +x

    2023-10-16T11:15:24.575006  =


    2023-10-16T11:15:24.675535  / # #export SHELL=3D/bin/sh

    2023-10-16T11:15:24.675681  =


    2023-10-16T11:15:24.776130  / # export SHELL=3D/bin/sh. /lava-11790161/=
environment

    2023-10-16T11:15:24.776306  =


    2023-10-16T11:15:24.876829  / # . /lava-11790161/environment/lava-11790=
161/bin/lava-test-runner /lava-11790161/1

    2023-10-16T11:15:24.877075  =


    2023-10-16T11:15:24.881428  / # /lava-11790161/bin/lava-test-runner /la=
va-11790161/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1b76202cb3666fefcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1b76202cb3666fefcefc
        failing since 201 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-16T11:16:15.643543  + set<8>[    8.547771] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11790176_1.4.2.3.1>

    2023-10-16T11:16:15.643634   +x

    2023-10-16T11:16:15.747569  / # #

    2023-10-16T11:16:15.848143  export SHELL=3D/bin/sh

    2023-10-16T11:16:15.848331  #

    2023-10-16T11:16:15.948844  / # export SHELL=3D/bin/sh. /lava-11790176/=
environment

    2023-10-16T11:16:15.949045  =


    2023-10-16T11:16:16.049567  / # . /lava-11790176/environment/lava-11790=
176/bin/lava-test-runner /lava-11790176/1

    2023-10-16T11:16:16.049846  =


    2023-10-16T11:16:16.054781  / # /lava-11790176/bin/lava-test-runner /la=
va-11790176/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1b5156c50363b0efcf05

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1b5156c50363b0efcf0e
        failing since 201 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-16T11:15:39.034537  <8>[   11.444188] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11790128_1.4.2.3.1>

    2023-10-16T11:15:39.139490  / # #

    2023-10-16T11:15:39.240242  export SHELL=3D/bin/sh

    2023-10-16T11:15:39.240445  #

    2023-10-16T11:15:39.340990  / # export SHELL=3D/bin/sh. /lava-11790128/=
environment

    2023-10-16T11:15:39.341200  =


    2023-10-16T11:15:39.441782  / # . /lava-11790128/environment/lava-11790=
128/bin/lava-test-runner /lava-11790128/1

    2023-10-16T11:15:39.442160  =


    2023-10-16T11:15:39.447244  / # /lava-11790128/bin/lava-test-runner /la=
va-11790128/1

    2023-10-16T11:15:39.452519  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1d2d133bd8e263efcf4e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1d2d133bd8e263efcf57
        failing since 88 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-16T11:27:22.635135  / # #

    2023-10-16T11:27:22.737281  export SHELL=3D/bin/sh

    2023-10-16T11:27:22.737990  #

    2023-10-16T11:27:22.839371  / # export SHELL=3D/bin/sh. /lava-11790257/=
environment

    2023-10-16T11:27:22.840117  =


    2023-10-16T11:27:22.941586  / # . /lava-11790257/environment/lava-11790=
257/bin/lava-test-runner /lava-11790257/1

    2023-10-16T11:27:22.942684  =


    2023-10-16T11:27:22.984329  / # /lava-11790257/bin/lava-test-runner /la=
va-11790257/1

    2023-10-16T11:27:23.008961  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-16T11:27:23.009473  + cd /lav<8>[   16.029597] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11790257_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1d225a81a64c38efcf22

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1d225a81a64c38efcf2b
        failing since 88 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-16T11:25:29.376711  / # #

    2023-10-16T11:25:30.456876  export SHELL=3D/bin/sh

    2023-10-16T11:25:30.458788  #

    2023-10-16T11:25:31.949682  / # export SHELL=3D/bin/sh. /lava-11790246/=
environment

    2023-10-16T11:25:31.951578  =


    2023-10-16T11:25:34.676026  / # . /lava-11790246/environment/lava-11790=
246/bin/lava-test-runner /lava-11790246/1

    2023-10-16T11:25:34.678439  =


    2023-10-16T11:25:34.684314  / # /lava-11790246/bin/lava-test-runner /la=
va-11790246/1

    2023-10-16T11:25:34.750643  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-16T11:25:34.751108  + cd /lava-117902<8>[   25.522172] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11790246_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-clabbe    | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1d0e6821d9b6b5efcefe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1d0e6821d9b6b5efcf07
        failing since 5 days (last pass: v5.15.105-194-g415a9d81c640, first=
 fail: v5.15.135)

    2023-10-16T11:22:47.987381  / # #
    2023-10-16T11:22:48.089278  export SHELL=3D/bin/sh
    2023-10-16T11:22:48.090037  #
    2023-10-16T11:22:48.191049  / # export SHELL=3D/bin/sh. /lava-438877/en=
vironment
    2023-10-16T11:22:48.191680  =

    2023-10-16T11:22:48.292768  / # . /lava-438877/environment/lava-438877/=
bin/lava-test-runner /lava-438877/1
    2023-10-16T11:22:48.293745  =

    2023-10-16T11:22:48.297565  / # /lava-438877/bin/lava-test-runner /lava=
-438877/1
    2023-10-16T11:22:48.329540  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-16T11:22:48.370616  + cd /lava-438877/<8>[   16.613409] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 438877_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/652d1d2e3de9276ce6efcf0f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-103-gf11fc66f963f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d1d2e3de9276ce6efcf18
        failing since 5 days (last pass: v5.15.105-194-g415a9d81c640, first=
 fail: v5.15.135)

    2023-10-16T11:27:35.305522  / # #

    2023-10-16T11:27:35.406258  export SHELL=3D/bin/sh

    2023-10-16T11:27:35.407001  #

    2023-10-16T11:27:35.508336  / # export SHELL=3D/bin/sh. /lava-11790261/=
environment

    2023-10-16T11:27:35.508980  =


    2023-10-16T11:27:35.610251  / # . /lava-11790261/environment/lava-11790=
261/bin/lava-test-runner /lava-11790261/1

    2023-10-16T11:27:35.611333  =


    2023-10-16T11:27:35.619633  / # /lava-11790261/bin/lava-test-runner /la=
va-11790261/1

    2023-10-16T11:27:35.685724  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-16T11:27:35.686239  + cd /lava-1179026<8>[   16.790163] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11790261_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
