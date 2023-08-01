Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA2076B353
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 13:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjHALeH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 07:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjHALeG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 07:34:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A362E6F
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 04:34:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-268128a0105so3933558a91.3
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690889642; x=1691494442;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HTyCNYYWuWIlKezGghMUzOWukXPZBBM82XMwfatpqik=;
        b=zlHSkVN+VjfKDbkcHhfHTmysJGF2chhiZYupxK4dGAQ+57vxWKJePKal1GsIbgxP1m
         qy0CfHOXOIQipfOn58ca8CQzJOcJH3i2hgXuP2QC2zJ6ZaT/DvG1ZGwixuYVcByUEEsj
         29lgXVLiw28KKsfaDUVokoH+wRsdCHMwlYsdtyY5NnGW1chzgFZFFobcn+YNw2zsijfq
         eHXAbbGR5bpK7cYvwwQkfI/UprLnEKbuE1uaZEyrSCfgzIX/zsRj96V/s0uCuV7AB4rr
         9xAo5UL3c5Z4JpfWuMItEzPnTOkIkKB3CYrswNdTNFV9X9SvVlEE6aBzfZI4SprhTtBd
         7zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889642; x=1691494442;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTyCNYYWuWIlKezGghMUzOWukXPZBBM82XMwfatpqik=;
        b=SrmZLdeiRoDk2LyWMOQhMIVMC+fQmBuObsMD1JA+EK26N/oDIqXrNMF2fWLIfd9S5F
         z7f2LRiwGFoCKoJPtWHN3Dlfa/Xnm3rUJn9+wLLsuY4y+n3Lqe2ooK0sHTTjIt7Tc+YT
         50S1X8cq2L9OVKgakqcU2Moyh5ZboqenrmMOQJRL46vfCKu3gHVyHqG8MSbRbpRL3PSn
         1Q2NrIjNjBTTEvCxJ8Vui0xvp1k4z88RiV2EnFULkldNwBd1dvud9UkXXV7X24aY3kVK
         s47DBIzhpd28fQeLjnZmK6cSMhtW2DMFXuuchPtVLJljaDXlfWDhRJT4jJ2CEnVKXDU1
         w7Sg==
X-Gm-Message-State: ABy/qLaGsj9SXo1IrBlvxtE8OGY5wtvQj3QxX791AMuv2lgvhj0CtDBb
        3crhDbl+e+5ap6rV6/FrWyBfU6JmfbmkLZ69TYpHRg==
X-Google-Smtp-Source: APBJJlFd4biZcWDu0Y+K0cQmf9Lv208KU2IQpmtz+S1+PnGauoaWPM66FZJn1a86+XspqbGJ4XfzTQ==
X-Received: by 2002:a17:90b:19d7:b0:263:4164:dfba with SMTP id nm23-20020a17090b19d700b002634164dfbamr11579970pjb.6.1690889642099;
        Tue, 01 Aug 2023 04:34:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pj1-20020a17090b4f4100b002681bda127esm7398929pjb.35.2023.08.01.04.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:34:01 -0700 (PDT)
Message-ID: <64c8eda9.170a0220.7b56d.d977@mx.google.com>
Date:   Tue, 01 Aug 2023 04:34:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.42-221-gf40ed79b9e80
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 128 runs,
 11 regressions (v6.1.42-221-gf40ed79b9e80)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 128 runs, 11 regressions (v6.1.42-221-gf40e=
d79b9e80)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-R721T-grunt             | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.42-221-gf40ed79b9e80/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.42-221-gf40ed79b9e80
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f40ed79b9e80b61b5ef079dbb21b2c7b450191a2 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-R721T-grunt             | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bc9aeb4c84b9ae8ace25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-R721T-grunt.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-R721T-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c8bc9aeb4c84b9ae8ac=
e26
        new failure (last pass: v6.1.42) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bb9ca5dcdaace98ace2b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8bb9ca5dcdaace98ace30
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T08:00:31.270961  <8>[    7.925647] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11181438_1.4.2.3.1>

    2023-08-01T08:00:31.274014  + set +x

    2023-08-01T08:00:31.378670  / # #

    2023-08-01T08:00:31.479302  export SHELL=3D/bin/sh

    2023-08-01T08:00:31.479485  #

    2023-08-01T08:00:31.580050  / # export SHELL=3D/bin/sh. /lava-11181438/=
environment

    2023-08-01T08:00:31.580251  =


    2023-08-01T08:00:31.680844  / # . /lava-11181438/environment/lava-11181=
438/bin/lava-test-runner /lava-11181438/1

    2023-08-01T08:00:31.681137  =


    2023-08-01T08:00:31.687234  / # /lava-11181438/bin/lava-test-runner /la=
va-11181438/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bba4a5dcdaace98ace38

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8bba4a5dcdaace98ace3d
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T08:00:21.684869  + <8>[   11.650812] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11181453_1.4.2.3.1>

    2023-08-01T08:00:21.685327  set +x

    2023-08-01T08:00:21.794471  / # #

    2023-08-01T08:00:21.897082  export SHELL=3D/bin/sh

    2023-08-01T08:00:21.897885  #

    2023-08-01T08:00:21.999544  / # export SHELL=3D/bin/sh. /lava-11181453/=
environment

    2023-08-01T08:00:22.000314  =


    2023-08-01T08:00:22.101893  / # . /lava-11181453/environment/lava-11181=
453/bin/lava-test-runner /lava-11181453/1

    2023-08-01T08:00:22.103154  =


    2023-08-01T08:00:22.108136  / # /lava-11181453/bin/lava-test-runner /la=
va-11181453/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bbaacd906a330a8acead

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8bbaacd906a330a8aceb2
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T08:00:21.150171  <8>[   10.434269] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11181471_1.4.2.3.1>

    2023-08-01T08:00:21.153452  + set +x

    2023-08-01T08:00:21.258574  #

    2023-08-01T08:00:21.259902  =


    2023-08-01T08:00:21.361730  / # #export SHELL=3D/bin/sh

    2023-08-01T08:00:21.362478  =


    2023-08-01T08:00:21.464142  / # export SHELL=3D/bin/sh. /lava-11181471/=
environment

    2023-08-01T08:00:21.464971  =


    2023-08-01T08:00:21.566569  / # . /lava-11181471/environment/lava-11181=
471/bin/lava-test-runner /lava-11181471/1

    2023-08-01T08:00:21.568101  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bcd3e35136618d8ace47

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c8bcd3e35136618d8ac=
e48
        failing since 54 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bb81d894df2ac98ace4a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8bb81d894df2ac98ace4f
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T07:59:52.106435  + set +x

    2023-08-01T07:59:52.112487  <8>[   11.019203] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11181441_1.4.2.3.1>

    2023-08-01T07:59:52.217533  / # #

    2023-08-01T07:59:52.318230  export SHELL=3D/bin/sh

    2023-08-01T07:59:52.318423  #

    2023-08-01T07:59:52.418972  / # export SHELL=3D/bin/sh. /lava-11181441/=
environment

    2023-08-01T07:59:52.419186  =


    2023-08-01T07:59:52.519750  / # . /lava-11181441/environment/lava-11181=
441/bin/lava-test-runner /lava-11181441/1

    2023-08-01T07:59:52.520002  =


    2023-08-01T07:59:52.524202  / # /lava-11181441/bin/lava-test-runner /la=
va-11181441/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bb9659d0cf596d8acec3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8bb9659d0cf596d8acec8
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T08:00:16.336938  + set<8>[   10.887748] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11181436_1.4.2.3.1>

    2023-08-01T08:00:16.337371   +x

    2023-08-01T08:00:16.444485  / # #

    2023-08-01T08:00:16.546679  export SHELL=3D/bin/sh

    2023-08-01T08:00:16.547366  #

    2023-08-01T08:00:16.648674  / # export SHELL=3D/bin/sh. /lava-11181436/=
environment

    2023-08-01T08:00:16.649382  =


    2023-08-01T08:00:16.750914  / # . /lava-11181436/environment/lava-11181=
436/bin/lava-test-runner /lava-11181436/1

    2023-08-01T08:00:16.751972  =


    2023-08-01T08:00:16.756987  / # /lava-11181436/bin/lava-test-runner /la=
va-11181436/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bb3e369f08aa3e8ace1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-im=
x6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-im=
x6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8bb3e369f08aa3e8ace22
        new failure (last pass: v6.1.41-184-gb3f8a9d2b1371)

    2023-08-01T07:58:34.500533  + set[   14.991743] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 996695_1.5.2.3.1>
    2023-08-01T07:58:34.500693   +x
    2023-08-01T07:58:34.606472  / # #
    2023-08-01T07:58:34.708074  export SHELL=3D/bin/sh
    2023-08-01T07:58:34.708528  #
    2023-08-01T07:58:34.809722  / # export SHELL=3D/bin/sh. /lava-996695/en=
vironment
    2023-08-01T07:58:34.810229  =

    2023-08-01T07:58:34.911557  / # . /lava-996695/environment/lava-996695/=
bin/lava-test-runner /lava-996695/1
    2023-08-01T07:58:34.912248  =

    2023-08-01T07:58:34.915272  / # /lava-996695/bin/lava-test-runner /lava=
-996695/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bb951d71665ecc8ace1d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8bb951d71665ecc8ace22
        failing since 123 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-01T08:00:02.589790  <8>[   11.567475] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11181425_1.4.2.3.1>

    2023-08-01T08:00:02.694050  / # #

    2023-08-01T08:00:02.794737  export SHELL=3D/bin/sh

    2023-08-01T08:00:02.794950  #

    2023-08-01T08:00:02.895481  / # export SHELL=3D/bin/sh. /lava-11181425/=
environment

    2023-08-01T08:00:02.895680  =


    2023-08-01T08:00:02.996253  / # . /lava-11181425/environment/lava-11181=
425/bin/lava-test-runner /lava-11181425/1

    2023-08-01T08:00:02.996594  =


    2023-08-01T08:00:03.001300  / # /lava-11181425/bin/lava-test-runner /la=
va-11181425/1

    2023-08-01T08:00:03.008003  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bbc6c46b8902d18ace36

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8bbc6c46b8902d18ace3b
        failing since 14 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-01T08:00:56.595875  / # #

    2023-08-01T08:00:57.674340  export SHELL=3D/bin/sh

    2023-08-01T08:00:57.675595  #

    2023-08-01T08:00:59.159145  / # export SHELL=3D/bin/sh. /lava-11181470/=
environment

    2023-08-01T08:00:59.160410  =


    2023-08-01T08:01:01.876442  / # . /lava-11181470/environment/lava-11181=
470/bin/lava-test-runner /lava-11181470/1

    2023-08-01T08:01:01.878513  =


    2023-08-01T08:01:01.888139  / # /lava-11181470/bin/lava-test-runner /la=
va-11181470/1

    2023-08-01T08:01:01.947179  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T08:01:01.947644  + cd /lava-111814<8>[   28.478482] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11181470_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8bbaedfc7fcf5738ace31

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
221-gf40ed79b9e80/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8bbaedfc7fcf5738ace36
        failing since 14 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-01T08:01:59.892464  / # #

    2023-08-01T08:01:59.994629  export SHELL=3D/bin/sh

    2023-08-01T08:01:59.995356  #

    2023-08-01T08:02:00.096778  / # export SHELL=3D/bin/sh. /lava-11181464/=
environment

    2023-08-01T08:02:00.097544  =


    2023-08-01T08:02:00.199025  / # . /lava-11181464/environment/lava-11181=
464/bin/lava-test-runner /lava-11181464/1

    2023-08-01T08:02:00.200125  =


    2023-08-01T08:02:00.217214  / # /lava-11181464/bin/lava-test-runner /la=
va-11181464/1

    2023-08-01T08:02:00.283141  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T08:02:00.283646  + cd /lava-11181464/1/tests/1_boot<8>[   16=
.982409] <LAVA_SIGNAL_STARTRUN 1_bootrr 11181464_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
