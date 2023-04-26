Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E826EFAB1
	for <lists+stable@lfdr.de>; Wed, 26 Apr 2023 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDZTLQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Apr 2023 15:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbjDZTLM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Apr 2023 15:11:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B03C0C
        for <stable@vger.kernel.org>; Wed, 26 Apr 2023 12:11:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51f6461af24so5755536a12.2
        for <stable@vger.kernel.org>; Wed, 26 Apr 2023 12:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682536268; x=1685128268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4XAPfl8GzBWjj6U4kKvWCiX20YMxLQ/cFB1w475G0Sg=;
        b=OutFM/pJiYZcGznMnumhVOAbda/IzjJbGd5YFVA/BaJohSSYiV2vRGGTzMAKO97NcB
         ZXdgxSnbQ6U8p9bqvkdn/jS1IZBMBImj3hpnPZtYRoqtOCtfDbXgvDY/+ASrJYpqFEvA
         Ce5CKYMVypYBn9OnEwaOl2Re/Y68xAxOuXGF2KjFW+m2HZ+F0DtP/aBAKoX19qU7anPt
         zYKxGQMu6aFITdG5f4RMKp29sDkRigAIjl78xN4r1by1GQOK44yuRGkC3WadghXKYdDB
         7WiVtuDtX4XVdXCJu2pX5i9yc8TNmn1bR2f2TmEtmy66Mt3X9aHNgr9tbHECNqqPmqvj
         VNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682536268; x=1685128268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XAPfl8GzBWjj6U4kKvWCiX20YMxLQ/cFB1w475G0Sg=;
        b=HWbTfz3HGdGp39kFgKqxDbNd5JOujQtDzR9MoaG+4W371sLggZeOytwmGH4TIZHUSf
         zoQmt0c8VMsL8sVbeytkSKpQE9UwUXWv91Xe4SuzLV5aFxgvAWkSm2KyoRSgBUPZF3qM
         oBvFOQlmnIfF6tJOG0xIa69jQDcAnX79TpSZp3JeOQyR5B6kAJY4C8J7kvS8UXwiziFm
         SG3slRSWi+ZW5+OY6OuTqlfldfnlbEd+Wq//+AXCW8feJOYhvPAspGa/S74zADHrfCKa
         ji8tRFlIA2y7FdkXQYi6xZZEBBxpKgsQVHZee/DtvXtrpmXVhdjL1oF1RKcuK1KmEIGw
         Elgg==
X-Gm-Message-State: AAQBX9cjdf9ylypeA3XUOUqTKD53HG/aXccJX4o0kRO2kDQmURJ9XXMN
        MzlOYpGHiGJxGlNfjR8g6ukT5G773eYxUBnmbVoq2g==
X-Google-Smtp-Source: AKy350ZWxpJGePXpGtNu2juhCVI2F8thauIWjCyZpBwYjOR2Hsu7Ijv64pvnW7kbrwS0Q4CNHZjWJw==
X-Received: by 2002:a17:90a:c20b:b0:246:94cf:6c49 with SMTP id e11-20020a17090ac20b00b0024694cf6c49mr21641648pjt.20.1682536267565;
        Wed, 26 Apr 2023 12:11:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y9-20020a63e249000000b0051b36aee4f6sm10241824pgj.83.2023.04.26.12.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 12:11:07 -0700 (PDT)
Message-ID: <6449774b.630a0220.c9f55.60de@mx.google.com>
Date:   Wed, 26 Apr 2023 12:11:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v6.1.26
X-Kernelci-Report-Type: test
Subject: stable/linux-6.1.y baseline: 102 runs, 8 regressions (v6.1.26)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y baseline: 102 runs, 8 regressions (v6.1.26)

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

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.26/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.26
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      ca1c9012c941ab1520851938d5f695f5a4d23634 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64493bbe4dbabc407b2e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64493bbe4dbabc407b2e85fb
        failing since 27 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-26T14:56:38.485664  + set +x

    2023-04-26T14:56:38.492292  <8>[   10.141721] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10132769_1.4.2.3.1>

    2023-04-26T14:56:38.596460  / # #

    2023-04-26T14:56:38.697053  export SHELL=3D/bin/sh

    2023-04-26T14:56:38.697269  #

    2023-04-26T14:56:38.797843  / # export SHELL=3D/bin/sh. /lava-10132769/=
environment

    2023-04-26T14:56:38.798029  =


    2023-04-26T14:56:38.898567  / # . /lava-10132769/environment/lava-10132=
769/bin/lava-test-runner /lava-10132769/1

    2023-04-26T14:56:38.898837  =


    2023-04-26T14:56:38.904429  / # /lava-10132769/bin/lava-test-runner /la=
va-10132769/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64494bb2df7e906daa2e8618

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64494bb2df7e906daa2e861d
        failing since 27 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-26T16:05:01.291019  + <8>[   11.063941] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10132767_1.4.2.3.1>

    2023-04-26T16:05:01.291575  set +x

    2023-04-26T16:05:01.399230  / # #

    2023-04-26T16:05:01.501494  export SHELL=3D/bin/sh

    2023-04-26T16:05:01.502197  #

    2023-04-26T16:05:01.603437  / # export SHELL=3D/bin/sh. /lava-10132767/=
environment

    2023-04-26T16:05:01.603622  =


    2023-04-26T16:05:01.704209  / # . /lava-10132767/environment/lava-10132=
767/bin/lava-test-runner /lava-10132767/1

    2023-04-26T16:05:01.705290  =


    2023-04-26T16:05:01.709629  / # /lava-10132767/bin/lava-test-runner /la=
va-10132767/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64493aed6d75237e362e8605

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64493aed6d75237e362e860a
        failing since 27 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-26T14:53:06.805556  <8>[   10.012641] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10132805_1.4.2.3.1>

    2023-04-26T14:53:06.808779  + set +x

    2023-04-26T14:53:06.910209  =


    2023-04-26T14:53:07.010757  / # #export SHELL=3D/bin/sh

    2023-04-26T14:53:07.010932  =


    2023-04-26T14:53:07.111511  / # export SHELL=3D/bin/sh. /lava-10132805/=
environment

    2023-04-26T14:53:07.111706  =


    2023-04-26T14:53:07.212219  / # . /lava-10132805/environment/lava-10132=
805/bin/lava-test-runner /lava-10132805/1

    2023-04-26T14:53:07.212562  =


    2023-04-26T14:53:07.217574  / # /lava-10132805/bin/lava-test-runner /la=
va-10132805/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64493b0292e4a2bae32e8640

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64493b0292e4a2bae32e8645
        failing since 27 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-26T14:53:32.847111  + set +x

    2023-04-26T14:53:32.853718  <8>[   10.196108] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10132832_1.4.2.3.1>

    2023-04-26T14:53:32.961662  / # #

    2023-04-26T14:53:33.063777  export SHELL=3D/bin/sh

    2023-04-26T14:53:33.064486  #

    2023-04-26T14:53:33.166009  / # export SHELL=3D/bin/sh. /lava-10132832/=
environment

    2023-04-26T14:53:33.166788  =


    2023-04-26T14:53:33.268275  / # . /lava-10132832/environment/lava-10132=
832/bin/lava-test-runner /lava-10132832/1

    2023-04-26T14:53:33.268658  =


    2023-04-26T14:53:33.273497  / # /lava-10132832/bin/lava-test-runner /la=
va-10132832/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64493ae2a7c4817cdd2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64493ae2a7c4817cdd2e85eb
        failing since 27 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-26T14:53:06.321694  <8>[   10.322883] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10132793_1.4.2.3.1>

    2023-04-26T14:53:06.324980  + set +x

    2023-04-26T14:53:06.429464  / # #

    2023-04-26T14:53:06.530068  export SHELL=3D/bin/sh

    2023-04-26T14:53:06.530279  #

    2023-04-26T14:53:06.630787  / # export SHELL=3D/bin/sh. /lava-10132793/=
environment

    2023-04-26T14:53:06.630982  =


    2023-04-26T14:53:06.731491  / # . /lava-10132793/environment/lava-10132=
793/bin/lava-test-runner /lava-10132793/1

    2023-04-26T14:53:06.731755  =


    2023-04-26T14:53:06.736836  / # /lava-10132793/bin/lava-test-runner /la=
va-10132793/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64493aeb6d75237e362e85ed

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64493aeb6d75237e362e85f2
        failing since 27 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-26T14:53:06.886954  + set<8>[   11.194554] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10132802_1.4.2.3.1>

    2023-04-26T14:53:06.887038   +x

    2023-04-26T14:53:06.991120  / # #

    2023-04-26T14:53:07.091638  export SHELL=3D/bin/sh

    2023-04-26T14:53:07.091849  #

    2023-04-26T14:53:07.192386  / # export SHELL=3D/bin/sh. /lava-10132802/=
environment

    2023-04-26T14:53:07.192614  =


    2023-04-26T14:53:07.293148  / # . /lava-10132802/environment/lava-10132=
802/bin/lava-test-runner /lava-10132802/1

    2023-04-26T14:53:07.293476  =


    2023-04-26T14:53:07.298380  / # /lava-10132802/bin/lava-test-runner /la=
va-10132802/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64494213dcc88bbb962e8602

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/arm=
/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/arm=
/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64494213dcc88bbb962e8607
        new failure (last pass: v6.1.25)

    2023-04-26T15:23:44.676944  + set[   14.963896] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 938517_1.5.2.3.1>
    2023-04-26T15:23:44.677111   +x
    2023-04-26T15:23:44.782730  / # #
    2023-04-26T15:23:44.884424  export SHELL=3D/bin/sh
    2023-04-26T15:23:44.884913  #
    2023-04-26T15:23:44.986216  / # export SHELL=3D/bin/sh. /lava-938517/en=
vironment
    2023-04-26T15:23:44.986710  =

    2023-04-26T15:23:45.088079  / # . /lava-938517/environment/lava-938517/=
bin/lava-test-runner /lava-938517/1
    2023-04-26T15:23:45.088690  =

    2023-04-26T15:23:45.092027  / # /lava-938517/bin/lava-test-runner /lava=
-938517/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64493b10c6479c46362e86c1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.26/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64493b10c6479c46362e86c6
        failing since 27 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-04-26T14:53:54.697023  + set<8>[   11.331680] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10132827_1.4.2.3.1>

    2023-04-26T14:53:54.697111   +x

    2023-04-26T14:53:54.801673  / # #

    2023-04-26T14:53:54.902313  export SHELL=3D/bin/sh

    2023-04-26T14:53:54.902541  #

    2023-04-26T14:53:55.003157  / # export SHELL=3D/bin/sh. /lava-10132827/=
environment

    2023-04-26T14:53:55.003474  =


    2023-04-26T14:53:55.104372  / # . /lava-10132827/environment/lava-10132=
827/bin/lava-test-runner /lava-10132827/1

    2023-04-26T14:53:55.105572  =


    2023-04-26T14:53:55.110445  / # /lava-10132827/bin/lava-test-runner /la=
va-10132827/1
 =

    ... (12 line(s) more)  =

 =20
