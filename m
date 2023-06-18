Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB84A734910
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 00:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjFRWLb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 18:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRWLa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 18:11:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C645110
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 15:11:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25e89791877so1011538a91.2
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687126288; x=1689718288;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SMTP+QgQZ279PkEP/99AlW5gdaKzDbqHd2E9MA/1ruc=;
        b=h4MFqDEJhpUQQMlRmMIO8cDmzVrlqHmEr1kq8WT9l52IVSWm4RwhfzBjphTdtzOVpx
         FbCPcc/1o15JYWU6huSLiXS31lWDAHnD9PExlKjX5Z/2Ki7Ido4Lg0zPD6gA7HcRjpIQ
         b3Vjpjju3SzGTlZd+hu3gjmRjChd9R8wIHfaRFPAEC05cGPjD3qsHMTGdkvujwtyWFbl
         iCrDI4q2SVsXWBmWCc3+VgD/Kvw3GINdBo5CsNJ+EHxAmX5VY7epi/MA9RSaOd3xA4Jx
         SWgXffQgxdk3gKPVWCgNTV3qYeFrlyqmg0XLF30tKMBRVUbEpkjTZSeGARxn37kU89me
         NK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687126288; x=1689718288;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMTP+QgQZ279PkEP/99AlW5gdaKzDbqHd2E9MA/1ruc=;
        b=RYt7oiMpSsp/Dw6fCOeGc9hIBfRAtvlf7Wgm0AqZzQWCQtZE8KkD+WybQUHIWwerV4
         j6ZdzVnte1Rl6bnsIrhgUsmEVq7rVLjArbZfRwvs0UBm7mgn/y3xBWmCu5m0PE+kp0A1
         wqJbkJ188MjGs5nmb7tD3cuA04ltb1ZVIc9ey/GdcZ9x3MMqHqLWQTsa168m7ssD1OFo
         IHXe8O32WXmezSc09UGIpEnPK5KDKXGHWqCJB7Ze/d6l12xewrsZ6ZkdGfcHDqaL+KvC
         P7584OP6ltDza4PUqgNEmZfDCrd6UUe3oUtNtLOJUPI6TMKfyPGBXZOfbWcOYkaSzR+r
         pQEQ==
X-Gm-Message-State: AC+VfDxktKugR1hAJoSHa6m8Fygpz1Pvi9+RonlWdpY9TZs/1PxCnwkE
        rSPPyO530330CrEi8jBIWddCj+DmDksr5/TdMPk64CRN
X-Google-Smtp-Source: ACHHUZ68jjFxbV8QKmvQGa0Os2GSInkipabfB1jsKdeAlOvB5d9cPaYN+vVnU2tQeJYNmUJfdRANeg==
X-Received: by 2002:a17:90a:bb85:b0:24d:fbaf:e0b1 with SMTP id v5-20020a17090abb8500b0024dfbafe0b1mr3796960pjr.19.1687126287937;
        Sun, 18 Jun 2023 15:11:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090abc9200b002533ce5b261sm4489024pjr.10.2023.06.18.15.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 15:11:27 -0700 (PDT)
Message-ID: <648f810f.170a0220.7b038.7625@mx.google.com>
Date:   Sun, 18 Jun 2023 15:11:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-75-gb03b7f10db06
Subject: stable-rc/linux-5.10.y baseline: 113 runs,
 5 regressions (v5.10.184-75-gb03b7f10db06)
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

stable-rc/linux-5.10.y baseline: 113 runs, 5 regressions (v5.10.184-75-gb03=
b7f10db06)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.184-75-gb03b7f10db06/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.184-75-gb03b7f10db06
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b03b7f10db06b3155cb49bad4a1b8b36eaecb8bc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648f47facd7d319a61306157

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-75-gb03b7f10db06/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-75-gb03b7f10db06/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f47facd7d319a6130615c
        failing since 151 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-18T18:07:29.268705  + set +x<8>[   11.079232] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3673683_1.5.2.4.1>
    2023-06-18T18:07:29.269280  =

    2023-06-18T18:07:29.379049  / # #
    2023-06-18T18:07:29.480465  export SHELL=3D/bin/sh
    2023-06-18T18:07:29.480822  #
    2023-06-18T18:07:29.581976  / # export SHELL=3D/bin/sh. /lava-3673683/e=
nvironment
    2023-06-18T18:07:29.582338  =

    2023-06-18T18:07:29.683543  / # . /lava-3673683/environment/lava-367368=
3/bin/lava-test-runner /lava-3673683/1
    2023-06-18T18:07:29.684086  =

    2023-06-18T18:07:29.684220  / # <3>[   11.452015] Bluetooth: hci0: comm=
and 0x0c03 tx timeout =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f47f6086064a01030614a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-75-gb03b7f10db06/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-75-gb03b7f10db06/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f47f6086064a01030614f
        failing since 81 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-18T18:07:47.810663  + <8>[   14.877572] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10796934_1.4.2.3.1>

    2023-06-18T18:07:47.810753  set +x

    2023-06-18T18:07:47.911981  #

    2023-06-18T18:07:48.012802  / # #export SHELL=3D/bin/sh

    2023-06-18T18:07:48.013011  =


    2023-06-18T18:07:48.113619  / # export SHELL=3D/bin/sh. /lava-10796934/=
environment

    2023-06-18T18:07:48.113849  =


    2023-06-18T18:07:48.214426  / # . /lava-10796934/environment/lava-10796=
934/bin/lava-test-runner /lava-10796934/1

    2023-06-18T18:07:48.214789  =


    2023-06-18T18:07:48.219941  / # /lava-10796934/bin/lava-test-runner /la=
va-10796934/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f48035f1da5530e306158

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-75-gb03b7f10db06/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-75-gb03b7f10db06/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f48035f1da5530e30615d
        failing since 81 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-18T18:07:52.640699  + set<8>[   12.629177] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10796965_1.4.2.3.1>

    2023-06-18T18:07:52.641175   +x

    2023-06-18T18:07:52.745943  / ##

    2023-06-18T18:07:52.848100  export SHELL=3D/bin/sh

    2023-06-18T18:07:52.848846   #

    2023-06-18T18:07:52.950509  / # export SHELL=3D/bin/sh. /lava-10796965/=
environment

    2023-06-18T18:07:52.951233  =


    2023-06-18T18:07:53.052717  / # . /lava-10796965/environment/lava-10796=
965/bin/lava-test-runner /lava-10796965/1

    2023-06-18T18:07:53.053830  =


    2023-06-18T18:07:53.059045  / # /lava-10796965/bin/lava-test-runner /la=
va-10796965/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f4902c625c6334630617a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-75-gb03b7f10db06/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-75-gb03b7f10db06/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f4902c625c63346306=
17b
        new failure (last pass: v5.10.184-46-gb25b2921d506) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648f472815cd51aa92306131

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-75-gb03b7f10db06/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-=
iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
84-75-gb03b7f10db06/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-=
iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f472815cd51aa92306=
132
        new failure (last pass: v5.10.184-46-gb25b2921d506) =

 =20
