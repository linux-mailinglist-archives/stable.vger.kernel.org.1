Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3334E70D288
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 05:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjEWDxH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 23:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEWDxG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 23:53:06 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3705190
        for <stable@vger.kernel.org>; Mon, 22 May 2023 20:53:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51452556acdso4693733a12.2
        for <stable@vger.kernel.org>; Mon, 22 May 2023 20:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684813983; x=1687405983;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=22ttsHPG8lmhlaRZ0UCqXSJ+qsQ2j1vDhDlwo+4PCnw=;
        b=iJI1ZmMjbE0Qb/DvQRV8uuftpMvnI4eLYRq/W22P9PAPVFmvDcynaU/EbYw3LL0dyl
         Id/9V8u6okAEWcDlYQ030fd5LZ2x8R+IMZfy/cova3MeNYKJjk99kvwZiL7v+TpSsPHJ
         BN3haxjJkKK2otIys4NoFH4PmI8nUg2CaYU3GARasYF735r6liRRebpwDYc0Ka12LEjz
         sYwoMTi7wA+dhYr6/QmscUHpcbh9iLnysWT+tR9lWBl2tXef9D0ZwrLrlobqUOP9jm6K
         r/757i3WLdSjxYosJCSiJDuVomRb9cwNSiZowRA7vUOw17DOyomTRKdMdzbBI74MSAzZ
         EyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684813983; x=1687405983;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22ttsHPG8lmhlaRZ0UCqXSJ+qsQ2j1vDhDlwo+4PCnw=;
        b=F/j5oQ0l+vzrCyvkjKRIdB/ajPAAWrU/B5B0MLOJwSBMe/oGcIxCFC4kClzJZeGww3
         7oHvZvxL1xx3aH8t6xg6xsrQRkDJ0KadYD3khiO6seLTfJ7kxsPrpoS3K64B4jLGvZBK
         IabP+p+Y/sJVrXl4NJR6B6MVSBLmTlSH0LbwJxsXehNRZOnA0n0X+gyRWA3yyveGPQqh
         8UzAySnxPorfP+rdoRKYVcj35a3nDEZbZ/grTmxIPoiXm/Fvn1dMyrbD6ewnHzVTQ4yq
         vhz1I8n9XxFcdbfjNcwLUYCXNDcz+C5XR1Kwlq30lw9JpSy1aJbEls3/DUGQ6o5JncSZ
         Ud0w==
X-Gm-Message-State: AC+VfDzQlMHcXxz88dlRlacxSXImxpti5wEsqEuXdfxhLJUC9PN2ekT4
        P2QW90X5eOTwRn6UY1uMDaLEFEGR3wqHRXxtKjw21w==
X-Google-Smtp-Source: ACHHUZ70V6P11zy24xldCRKb7Xb5FEV/mVZd+P+eYwWvKZs8hsiwobjoRgVg3TQSOw9i4snbxNSubw==
X-Received: by 2002:a17:902:a413:b0:1ae:626b:475f with SMTP id p19-20020a170902a41300b001ae626b475fmr11279364plq.12.1684813982980;
        Mon, 22 May 2023 20:53:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709026b8100b001afba6edc8esm2230595plk.166.2023.05.22.20.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 20:53:02 -0700 (PDT)
Message-ID: <646c389e.170a0220.4330f.5065@mx.google.com>
Date:   Mon, 22 May 2023 20:53:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-204-g30213a86a6fe
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 162 runs,
 12 regressions (v5.15.112-204-g30213a86a6fe)
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

stable-rc/linux-5.15.y baseline: 162 runs, 12 regressions (v5.15.112-204-g3=
0213a86a6fe)

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

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.112-204-g30213a86a6fe/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.112-204-g30213a86a6fe
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      30213a86a6fe2d0296aba978d583ebc81793df40 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c036af04d8f41142e85f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c036af04d8f41142e85fe
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-23T00:05:46.591247  <8>[   12.513992] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419106_1.4.2.3.1>

    2023-05-23T00:05:46.594582  + set +x

    2023-05-23T00:05:46.699519  / # #

    2023-05-23T00:05:46.800235  export SHELL=3D/bin/sh

    2023-05-23T00:05:46.800483  #

    2023-05-23T00:05:46.901048  / # export SHELL=3D/bin/sh. /lava-10419106/=
environment

    2023-05-23T00:05:46.901290  =


    2023-05-23T00:05:47.001811  / # . /lava-10419106/environment/lava-10419=
106/bin/lava-test-runner /lava-10419106/1

    2023-05-23T00:05:47.002157  =


    2023-05-23T00:05:47.007538  / # /lava-10419106/bin/lava-test-runner /la=
va-10419106/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c036cf04d8f41142e8611

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c036cf04d8f41142e8616
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-23T00:05:42.539801  + set<8>[   11.632987] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10419080_1.4.2.3.1>

    2023-05-23T00:05:42.540226   +x

    2023-05-23T00:05:42.647192  / # #

    2023-05-23T00:05:42.749286  export SHELL=3D/bin/sh

    2023-05-23T00:05:42.750025  #

    2023-05-23T00:05:42.851438  / # export SHELL=3D/bin/sh. /lava-10419080/=
environment

    2023-05-23T00:05:42.852167  =


    2023-05-23T00:05:42.953481  / # . /lava-10419080/environment/lava-10419=
080/bin/lava-test-runner /lava-10419080/1

    2023-05-23T00:05:42.954580  =


    2023-05-23T00:05:42.959532  / # /lava-10419080/bin/lava-test-runner /la=
va-10419080/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c036af04d8f41142e8604

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c036af04d8f41142e8609
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-23T00:05:51.894493  <8>[   10.659870] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419134_1.4.2.3.1>

    2023-05-23T00:05:51.898211  + set +x

    2023-05-23T00:05:52.000178  =


    2023-05-23T00:05:52.100790  / # #export SHELL=3D/bin/sh

    2023-05-23T00:05:52.101048  =


    2023-05-23T00:05:52.201834  / # export SHELL=3D/bin/sh. /lava-10419134/=
environment

    2023-05-23T00:05:52.202759  =


    2023-05-23T00:05:52.304375  / # . /lava-10419134/environment/lava-10419=
134/bin/lava-test-runner /lava-10419134/1

    2023-05-23T00:05:52.305554  =


    2023-05-23T00:05:52.310266  / # /lava-10419134/bin/lava-test-runner /la=
va-10419134/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c049bc76d9cc1de2e862a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c049bc76d9cc1de2e862f
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-23T00:10:46.517065  + <8>[   10.632482] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10419146_1.4.2.3.1>

    2023-05-23T00:10:46.517160  set +x

    2023-05-23T00:10:46.618442  #

    2023-05-23T00:10:46.720546  / # #export SHELL=3D/bin/sh

    2023-05-23T00:10:46.721291  =


    2023-05-23T00:10:46.822718  / # export SHELL=3D/bin/sh. /lava-10419146/=
environment

    2023-05-23T00:10:46.823438  =


    2023-05-23T00:10:46.924908  / # . /lava-10419146/environment/lava-10419=
146/bin/lava-test-runner /lava-10419146/1

    2023-05-23T00:10:46.925983  =


    2023-05-23T00:10:46.931125  / # /lava-10419146/bin/lava-test-runner /la=
va-10419146/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c040ac0eec685212e85ed

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c040ac0eec685212e85f2
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-23T00:08:20.746593  + set +x<8>[   10.664619] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10419143_1.4.2.3.1>

    2023-05-23T00:08:20.747024  =


    2023-05-23T00:08:20.854292  #

    2023-05-23T00:08:20.855492  =


    2023-05-23T00:08:20.957179  / # #export SHELL=3D/bin/sh

    2023-05-23T00:08:20.957420  =


    2023-05-23T00:08:21.057938  / # export SHELL=3D/bin/sh. /lava-10419143/=
environment

    2023-05-23T00:08:21.058167  =


    2023-05-23T00:08:21.158693  / # . /lava-10419143/environment/lava-10419=
143/bin/lava-test-runner /lava-10419143/1

    2023-05-23T00:08:21.158970  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0368e96c0385782e864c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0368e96c0385782e8651
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-23T00:05:38.963590  + set +x<8>[   10.904759] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10419085_1.4.2.3.1>

    2023-05-23T00:05:38.963687  =


    2023-05-23T00:05:39.068461  / # #

    2023-05-23T00:05:39.169090  export SHELL=3D/bin/sh

    2023-05-23T00:05:39.169280  #

    2023-05-23T00:05:39.269744  / # export SHELL=3D/bin/sh. /lava-10419085/=
environment

    2023-05-23T00:05:39.269937  =


    2023-05-23T00:05:39.370480  / # . /lava-10419085/environment/lava-10419=
085/bin/lava-test-runner /lava-10419085/1

    2023-05-23T00:05:39.370746  =


    2023-05-23T00:05:39.375773  / # /lava-10419085/bin/lava-test-runner /la=
va-10419085/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c04a7886b329ae12e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c04a7886b329ae12e85f9
        failing since 112 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-05-23T00:11:11.340090  + set +x
    2023-05-23T00:11:11.340272  [    9.432201] <LAVA_SIGNAL_ENDRUN 0_dmesg =
956955_1.5.2.3.1>
    2023-05-23T00:11:11.447239  / # #
    2023-05-23T00:11:11.548695  export SHELL=3D/bin/sh
    2023-05-23T00:11:11.549096  #
    2023-05-23T00:11:11.650256  / # export SHELL=3D/bin/sh. /lava-956955/en=
vironment
    2023-05-23T00:11:11.650776  =

    2023-05-23T00:11:11.752081  / # . /lava-956955/environment/lava-956955/=
bin/lava-test-runner /lava-956955/1
    2023-05-23T00:11:11.752638  =

    2023-05-23T00:11:11.755230  / # /lava-956955/bin/lava-test-runner /lava=
-956955/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0371b59f5448412e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0371b59f5448412e8607
        failing since 55 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-23T00:05:49.888147  <8>[   12.791244] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419130_1.4.2.3.1>

    2023-05-23T00:05:49.995418  / # #

    2023-05-23T00:05:50.097539  export SHELL=3D/bin/sh

    2023-05-23T00:05:50.098283  #

    2023-05-23T00:05:50.199950  / # export SHELL=3D/bin/sh. /lava-10419130/=
environment

    2023-05-23T00:05:50.200695  =


    2023-05-23T00:05:50.302098  / # . /lava-10419130/environment/lava-10419=
130/bin/lava-test-runner /lava-10419130/1

    2023-05-23T00:05:50.303223  =


    2023-05-23T00:05:50.307573  / # /lava-10419130/bin/lava-test-runner /la=
va-10419130/1

    2023-05-23T00:05:50.313523  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/646c0627dd2f5f135e2e85f2

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12-204-g30213a86a6fe/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/646c0627dd2f5f135e2e85ff
        failing since 7 days (last pass: v5.15.110, first fail: v5.15.111-1=
30-g93ae50a86a5dd)

    2023-05-23T00:17:17.384940  /lava-10419230/1/../bin/lava-test-case

    2023-05-23T00:17:17.391362  <8>[   60.537540] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0627dd2f5f135e2e8687
        failing since 7 days (last pass: v5.15.110, first fail: v5.15.111-1=
30-g93ae50a86a5dd)

    2023-05-23T00:17:03.206347  + set +x

    2023-05-23T00:17:03.212496  <8>[   46.358241] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419230_1.5.2.3.1>

    2023-05-23T00:17:03.321024  / # #

    2023-05-23T00:17:03.423583  export SHELL=3D/bin/sh

    2023-05-23T00:17:03.424376  #

    2023-05-23T00:17:03.525975  / # export SHELL=3D/bin/sh. /lava-10419230/=
environment

    2023-05-23T00:17:03.526757  =


    2023-05-23T00:17:03.628223  / # . /lava-10419230/environment/lava-10419=
230/bin/lava-test-runner /lava-10419230/1

    2023-05-23T00:17:03.629419  =


    2023-05-23T00:17:03.634558  / # /lava-10419230/bin/lava-test-runner /la=
va-10419230/1
 =

    ... (13 line(s) more)  =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/646c0627dd2f5f135e2e8696
        failing since 7 days (last pass: v5.15.110, first fail: v5.15.111-1=
30-g93ae50a86a5dd)

    2023-05-23T00:17:18.424892  /lava-10419230/1/../bin/lava-test-case

    2023-05-23T00:17:18.431100  <8>[   61.577528] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/646c0627dd2f5f135e2e8696
        failing since 7 days (last pass: v5.15.110, first fail: v5.15.111-1=
30-g93ae50a86a5dd)

    2023-05-23T00:17:18.424892  /lava-10419230/1/../bin/lava-test-case

    2023-05-23T00:17:18.431100  <8>[   61.577528] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =

 =20
