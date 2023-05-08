Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E115F6FB345
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 16:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjEHOwZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 10:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjEHOwY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 10:52:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B306358E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 07:52:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64115e652eeso35142535b3a.0
        for <stable@vger.kernel.org>; Mon, 08 May 2023 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683557540; x=1686149540;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KxWECxN+W48brqGleECcVVFBnv3S+YVdChhHhMss3kQ=;
        b=4Bz4+k/+rjSx1efyx/6YtENwb7O1QiT92UrJQ0qzDRiu0hOmGNOUSWZRSiLvwUtS13
         +BxFvTJI36QgtvKSRMt4nbzW8lR+G8KznKfman2hAiiM7MGLpV9agi+xB/f7sqku7JzQ
         C/V9Paq9TMddLySQcB8qti0GeEUlDJTl3xhyne2Dpi57HcqNLMRLkFBh43SxXcy1rZBq
         rfhTVvStacswrZPHa5VRCMDdFhasur2NONKIOLRxRTPVjHHJLjvkcjb2Ycoxz9k1zeZa
         AaSz/7Ty6XWKqClUpgOKTzOUTZ4DVShB6cDdpPiFpBVsVCAXB29QcauQ3xLfb+uTd3qC
         XKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683557540; x=1686149540;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxWECxN+W48brqGleECcVVFBnv3S+YVdChhHhMss3kQ=;
        b=Ed41O+erDaR3X+c/JEV8ITnGfJry9ponx6FiR81Tfg4v/9tfNOQ/hq6pQ7fUYoxbmn
         ifeItjD7LjQxNFRi+YX0n1yVphm0/3IsV02KqXRoq6VzoFDTeoGNNTHClr/h8Fuw6U7G
         s9/GEi+f3SOarq0e6Nb1TIBDE8HTTUpVVMrNw4E+z9nf5ULAeyUeEJdewC+MWT5JnlVV
         Sq63GMbCICOCDOJFCG9uukTyoTe8FU4zFsvlooHWzfhSinZEiLXGsPxB++4qP3Ql+FUe
         26Cnhf2BJ0TS2xs+nxz8vww7vo4cgHJ/WUBk8V4Ll+4KTQJAtf/aDmGNjmWqXaeCURF7
         fP8A==
X-Gm-Message-State: AC+VfDxE+tv+/b9Ae3IZjxUsp6wqziErPys6zrc6aNI2OZmlOI/qtOen
        EqXX77nJBWzqwWCNlBIk+frb0LZtA0zfea/2WxzdKA==
X-Google-Smtp-Source: ACHHUZ4J8zjJeK4vuM/zfS5zAXG3iaE55O1BFkNOrxWx1PUhRd91bcSFySa6pvWLO7PksR1d/vv3Aw==
X-Received: by 2002:a17:90a:ad09:b0:244:d441:8f68 with SMTP id r9-20020a17090aad0900b00244d4418f68mr17607981pjq.16.1683557540228;
        Mon, 08 May 2023 07:52:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090ad34e00b0024e3d26f644sm10577276pjx.3.2023.05.08.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:52:19 -0700 (PDT)
Message-ID: <64590ca3.170a0220.52c4e.5fce@mx.google.com>
Date:   Mon, 08 May 2023 07:52:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-1198-gec6cfda9dbac0
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 161 runs,
 11 regressions (v6.1.22-1198-gec6cfda9dbac0)
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

stable-rc/queue/6.1 baseline: 161 runs, 11 regressions (v6.1.22-1198-gec6cf=
da9dbac0)

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-1198-gec6cfda9dbac0/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-1198-gec6cfda9dbac0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ec6cfda9dbac0523ae8d77d48c52487b1113a119 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64582089168ea1d1682e86ac

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64582089168ea1d1682e86b1
        failing since 40 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T22:04:39.040495  <8>[   10.518347] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10233200_1.4.2.3.1>

    2023-05-07T22:04:39.043657  + set +x

    2023-05-07T22:04:39.144849  #

    2023-05-07T22:04:39.145120  =


    2023-05-07T22:04:39.245676  / # #export SHELL=3D/bin/sh

    2023-05-07T22:04:39.245852  =


    2023-05-07T22:04:39.346385  / # export SHELL=3D/bin/sh. /lava-10233200/=
environment

    2023-05-07T22:04:39.346570  =


    2023-05-07T22:04:39.447080  / # . /lava-10233200/environment/lava-10233=
200/bin/lava-test-runner /lava-10233200/1

    2023-05-07T22:04:39.447379  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6458207e6e9bbe974f2e873c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6458207e6e9bbe974f2e8741
        failing since 40 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T22:04:29.233368  + <8>[   11.367649] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10233163_1.4.2.3.1>

    2023-05-07T22:04:29.233453  set +x

    2023-05-07T22:04:29.337838  / # #

    2023-05-07T22:04:29.438487  export SHELL=3D/bin/sh

    2023-05-07T22:04:29.438737  #

    2023-05-07T22:04:29.539394  / # export SHELL=3D/bin/sh. /lava-10233163/=
environment

    2023-05-07T22:04:29.539571  =


    2023-05-07T22:04:29.640051  / # . /lava-10233163/environment/lava-10233=
163/bin/lava-test-runner /lava-10233163/1

    2023-05-07T22:04:29.640452  =


    2023-05-07T22:04:29.645700  / # /lava-10233163/bin/lava-test-runner /la=
va-10233163/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6458207d6e9bbe974f2e8731

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6458207d6e9bbe974f2e8736
        failing since 40 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T22:04:22.757944  <8>[   10.613338] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10233158_1.4.2.3.1>

    2023-05-07T22:04:22.761500  + set +x

    2023-05-07T22:04:22.862796  #

    2023-05-07T22:04:22.863148  =


    2023-05-07T22:04:22.963784  / # #export SHELL=3D/bin/sh

    2023-05-07T22:04:22.963961  =


    2023-05-07T22:04:23.064434  / # export SHELL=3D/bin/sh. /lava-10233158/=
environment

    2023-05-07T22:04:23.064610  =


    2023-05-07T22:04:23.165235  / # . /lava-10233158/environment/lava-10233=
158/bin/lava-test-runner /lava-10233158/1

    2023-05-07T22:04:23.165506  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64582074168ea1d1682e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64582074168ea1d1682e85eb
        failing since 40 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T22:04:27.383403  + set +x

    2023-05-07T22:04:27.389778  <8>[   10.783810] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10233140_1.4.2.3.1>

    2023-05-07T22:04:27.494324  / # #

    2023-05-07T22:04:27.595040  export SHELL=3D/bin/sh

    2023-05-07T22:04:27.595330  #

    2023-05-07T22:04:27.695975  / # export SHELL=3D/bin/sh. /lava-10233140/=
environment

    2023-05-07T22:04:27.696177  =


    2023-05-07T22:04:27.796719  / # . /lava-10233140/environment/lava-10233=
140/bin/lava-test-runner /lava-10233140/1

    2023-05-07T22:04:27.797026  =


    2023-05-07T22:04:27.801526  / # /lava-10233140/bin/lava-test-runner /la=
va-10233140/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6458206dbbd7d1945f2e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6458206dbbd7d1945f2e85f8
        failing since 40 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T22:04:16.303334  <8>[    9.882067] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10233152_1.4.2.3.1>

    2023-05-07T22:04:16.306959  + set +x

    2023-05-07T22:04:16.412215  / # #

    2023-05-07T22:04:16.513071  export SHELL=3D/bin/sh

    2023-05-07T22:04:16.513360  #

    2023-05-07T22:04:16.614017  / # export SHELL=3D/bin/sh. /lava-10233152/=
environment

    2023-05-07T22:04:16.614209  =


    2023-05-07T22:04:16.714759  / # . /lava-10233152/environment/lava-10233=
152/bin/lava-test-runner /lava-10233152/1

    2023-05-07T22:04:16.715128  =


    2023-05-07T22:04:16.719631  / # /lava-10233152/bin/lava-test-runner /la=
va-10233152/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6458207f168ea1d1682e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6458207f168ea1d1682e85fa
        failing since 40 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T22:04:26.584046  + set<8>[   11.251358] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10233174_1.4.2.3.1>

    2023-05-07T22:04:26.584121   +x

    2023-05-07T22:04:26.688517  / # #

    2023-05-07T22:04:26.789037  export SHELL=3D/bin/sh

    2023-05-07T22:04:26.789204  #

    2023-05-07T22:04:26.889692  / # export SHELL=3D/bin/sh. /lava-10233174/=
environment

    2023-05-07T22:04:26.889868  =


    2023-05-07T22:04:26.990419  / # . /lava-10233174/environment/lava-10233=
174/bin/lava-test-runner /lava-10233174/1

    2023-05-07T22:04:26.990712  =


    2023-05-07T22:04:26.995650  / # /lava-10233174/bin/lava-test-runner /la=
va-10233174/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64582087168ea1d1682e8649

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-im=
x6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-im=
x6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64582087168ea1d1682e864e
        new failure (last pass: v6.1.22-1196-g571a2463c150b)

    2023-05-07T22:04:35.504034  + set[   14.920680] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 943270_1.5.2.3.1>
    2023-05-07T22:04:35.504202   +x
    2023-05-07T22:04:35.610198  / # #
    2023-05-07T22:04:35.711885  export SHELL=3D/bin/sh
    2023-05-07T22:04:35.712360  #
    2023-05-07T22:04:35.813635  / # export SHELL=3D/bin/sh. /lava-943270/en=
vironment
    2023-05-07T22:04:35.814123  =

    2023-05-07T22:04:35.915491  / # . /lava-943270/environment/lava-943270/=
bin/lava-test-runner /lava-943270/1
    2023-05-07T22:04:35.916144  =

    2023-05-07T22:04:35.919359  / # /lava-943270/bin/lava-test-runner /lava=
-943270/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6458206a0fe1e537952e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6458206a0fe1e537952e8606
        failing since 40 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T22:04:20.195528  <8>[   11.762516] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10233178_1.4.2.3.1>

    2023-05-07T22:04:20.299872  / # #

    2023-05-07T22:04:20.400490  export SHELL=3D/bin/sh

    2023-05-07T22:04:20.400643  #

    2023-05-07T22:04:20.501162  / # export SHELL=3D/bin/sh. /lava-10233178/=
environment

    2023-05-07T22:04:20.501362  =


    2023-05-07T22:04:20.601911  / # . /lava-10233178/environment/lava-10233=
178/bin/lava-test-runner /lava-10233178/1

    2023-05-07T22:04:20.602206  =


    2023-05-07T22:04:20.606976  / # /lava-10233178/bin/lava-test-runner /la=
va-10233178/1

    2023-05-07T22:04:20.614050  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64581f34d4ac9a57d22e85e8

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64581f34d4ac9a57d22e8604
        failing since 0 day (last pass: v6.1.22-704-ga3dcd1f09de2, first fa=
il: v6.1.22-1160-g24230ce6f2e2)

    2023-05-07T21:58:56.484168  /lava-10233103/1/../bin/lava-test-case
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64581f34d4ac9a57d22e8690
        failing since 0 day (last pass: v6.1.22-704-ga3dcd1f09de2, first fa=
il: v6.1.22-1160-g24230ce6f2e2)

    2023-05-07T21:58:51.089034  + set +x

    2023-05-07T21:58:51.095399  <8>[   17.573337] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10233103_1.5.2.3.1>

    2023-05-07T21:58:51.201109  / # #

    2023-05-07T21:58:51.301709  export SHELL=3D/bin/sh

    2023-05-07T21:58:51.301904  #

    2023-05-07T21:58:51.402419  / # export SHELL=3D/bin/sh. /lava-10233103/=
environment

    2023-05-07T21:58:51.402623  =


    2023-05-07T21:58:51.503164  / # . /lava-10233103/environment/lava-10233=
103/bin/lava-test-runner /lava-10233103/1

    2023-05-07T21:58:51.503460  =


    2023-05-07T21:58:51.508910  / # /lava-10233103/bin/lava-test-runner /la=
va-10233103/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645820cbc4088b5a7f2e8629

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
98-gec6cfda9dbac0/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645820cbc4088b5a7f2e8=
62a
        failing since 0 day (last pass: v6.1.22-1159-g8729cbdc1402, first f=
ail: v6.1.22-1196-g571a2463c150b) =

 =20
