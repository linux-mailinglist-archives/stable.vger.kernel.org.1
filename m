Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC3749204
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 01:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjGEXnn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 19:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjGEXnm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 19:43:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800FB12A
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 16:43:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-66f5faba829so132957b3a.3
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 16:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688600618; x=1691192618;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LrF/Txg4jnIwkdyFa+2tstVRVr4X+CShVQXvzHCGmpo=;
        b=uue/suUeI4/kTYVzD4dTpi+jiuAm969Lt84zVydygbqXTH7wWHjtS+TxKBMBsk8CHo
         QOLMn5fxsH2GpMFl6E6r08CyMPY/lSFJabrI4tV11NeJSZxVjb81oo77Dv5gczZJTf+Q
         bqSe84CSTGVUcfHwAHJXJv5pvtkT/wK+n/pkELgj4BYFLfluk5qfGWBDoJcbHW0y7q0j
         gI0f16UIODEkft/26MaTNblFtja/XpwACB2cMZOyQCPGWpPfVYbfFtBhL7KEaaEpUwNm
         IxjTkeP7gQWrc1WRrkDIB85Waro3fTZEaXlOSZfFyaVMYqWhUT5cy0Zdp/yw3rhNLY9g
         rMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688600618; x=1691192618;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrF/Txg4jnIwkdyFa+2tstVRVr4X+CShVQXvzHCGmpo=;
        b=hY2soR+U9+/+v0KI8Ayqkzy+ziT2rhpBktt6+Xr59z/SNy0J1wiqEDL5pOm+IUr/I5
         2O2VXGGUhHyHOUbpK9sRAXqYYtEC5NA1YlXVlE5nu337deuD5QyrIKQ4UF6GX5XZoQTm
         Zm/fhzKwwQpCIGY5QqCCjMlTwq5afnwx370G5y10W7akDKQpJ4oSGCIFtj1GE5aCcqhH
         LnahPFJLtAq9W9kJMlf4CWmP+9trz/cdu/RDI6awR6qdK7XAQBN7gMQOrgOzQ36iF4bm
         3uSPhXL1er7YT/vvz6tyxLf3e9hiorXTXDCjHEu63QYItwIZDnThJnPE3fzyw7xHQHvT
         r6Cw==
X-Gm-Message-State: ABy/qLZ5CeRTGTrjVSTlVFn8+EbLy865Bpj+lXlIEk1apvqunP+uvvYs
        0J1U/xxYUCX+EKjrZy7pRlgamOqdac4rtE8HHJ/e6g==
X-Google-Smtp-Source: APBJJlGvhoqtOZcBnCLkHZERwotT9+dZ1KRxlvYpUu4Oten0i9ZjXed3KpyT98Gqsa+7t+9V0y/mrA==
X-Received: by 2002:a05:6a20:18c:b0:126:eed0:f55e with SMTP id 12-20020a056a20018c00b00126eed0f55emr250796pzy.11.1688600618180;
        Wed, 05 Jul 2023 16:43:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902e90300b001b8a697372dsm44614pld.33.2023.07.05.16.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 16:43:37 -0700 (PDT)
Message-ID: <64a60029.170a0220.5c876.0218@mx.google.com>
Date:   Wed, 05 Jul 2023 16:43:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.120
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
Subject: stable/linux-5.15.y baseline: 130 runs, 18 regressions (v5.15.120)
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

stable/linux-5.15.y baseline: 130 runs, 18 regressions (v5.15.120)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.120/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.120
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      d54cfc420586425d418a53871290cc4a59d33501 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c17642b9b5c8f3bb2aa6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c17642b9b5c8f3bb2aab
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:15:49.110390  + set +x

    2023-07-05T19:15:49.117369  <8>[   10.575277] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11021867_1.4.2.3.1>

    2023-07-05T19:15:49.218968  #

    2023-07-05T19:15:49.219210  =


    2023-07-05T19:15:49.319720  / # #export SHELL=3D/bin/sh

    2023-07-05T19:15:49.319893  =


    2023-07-05T19:15:49.420380  / # export SHELL=3D/bin/sh. /lava-11021867/=
environment

    2023-07-05T19:15:49.420560  =


    2023-07-05T19:15:49.521096  / # . /lava-11021867/environment/lava-11021=
867/bin/lava-test-runner /lava-11021867/1

    2023-07-05T19:15:49.521353  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c748ad4b2fb00dbb2adc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c748ad4b2fb00dbb2ae1
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:41:07.738524  + set +x

    2023-07-05T19:41:07.745199  <8>[    9.268858] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11022270_1.4.2.3.1>

    2023-07-05T19:41:07.849255  / # #

    2023-07-05T19:41:07.949955  export SHELL=3D/bin/sh

    2023-07-05T19:41:07.950201  #

    2023-07-05T19:41:08.050813  / # export SHELL=3D/bin/sh. /lava-11022270/=
environment

    2023-07-05T19:41:08.051030  =


    2023-07-05T19:41:08.151567  / # . /lava-11022270/environment/lava-11022=
270/bin/lava-test-runner /lava-11022270/1

    2023-07-05T19:41:08.151892  =


    2023-07-05T19:41:08.157800  / # /lava-11022270/bin/lava-test-runner /la=
va-11022270/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c176b67dd516bdbb2a91

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c176b67dd516bdbb2a96
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:15:58.381730  + set<8>[    8.809462] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11021849_1.4.2.3.1>

    2023-07-05T19:15:58.381831   +x

    2023-07-05T19:15:58.486122  / # #

    2023-07-05T19:15:58.586891  export SHELL=3D/bin/sh

    2023-07-05T19:15:58.587132  #

    2023-07-05T19:15:58.687790  / # export SHELL=3D/bin/sh. /lava-11021849/=
environment

    2023-07-05T19:15:58.688356  =


    2023-07-05T19:15:58.789471  / # . /lava-11021849/environment/lava-11021=
849/bin/lava-test-runner /lava-11021849/1

    2023-07-05T19:15:58.789856  =


    2023-07-05T19:15:58.794369  / # /lava-11021849/bin/lava-test-runner /la=
va-11021849/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c731a343bb42fdbb2a82

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c731a343bb42fdbb2a87
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:40:24.496383  + <8>[   12.471329] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11022294_1.4.2.3.1>

    2023-07-05T19:40:24.496469  set +x

    2023-07-05T19:40:24.600794  / # #

    2023-07-05T19:40:24.701659  export SHELL=3D/bin/sh

    2023-07-05T19:40:24.701944  #

    2023-07-05T19:40:24.802580  / # export SHELL=3D/bin/sh. /lava-11022294/=
environment

    2023-07-05T19:40:24.802808  =


    2023-07-05T19:40:24.903396  / # . /lava-11022294/environment/lava-11022=
294/bin/lava-test-runner /lava-11022294/1

    2023-07-05T19:40:24.903726  =


    2023-07-05T19:40:24.908341  / # /lava-11022294/bin/lava-test-runner /la=
va-11022294/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c17642b9b5c8f3bb2a9b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c17642b9b5c8f3bb2aa0
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:15:59.630475  <8>[    9.887445] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11021834_1.4.2.3.1>

    2023-07-05T19:15:59.633723  + set +x

    2023-07-05T19:15:59.734867  #

    2023-07-05T19:15:59.735151  =


    2023-07-05T19:15:59.835707  / # #export SHELL=3D/bin/sh

    2023-07-05T19:15:59.835903  =


    2023-07-05T19:15:59.936445  / # export SHELL=3D/bin/sh. /lava-11021834/=
environment

    2023-07-05T19:15:59.936686  =


    2023-07-05T19:16:00.037241  / # . /lava-11021834/environment/lava-11021=
834/bin/lava-test-runner /lava-11021834/1

    2023-07-05T19:16:00.037496  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c73da343bb42fdbb2ab8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c73da343bb42fdbb2abd
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:40:38.370103  <8>[   11.753756] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11022279_1.4.2.3.1>

    2023-07-05T19:40:38.373138  + set +x

    2023-07-05T19:40:38.474525  #

    2023-07-05T19:40:38.575280  / # #export SHELL=3D/bin/sh

    2023-07-05T19:40:38.575473  =


    2023-07-05T19:40:38.675981  / # export SHELL=3D/bin/sh. /lava-11022279/=
environment

    2023-07-05T19:40:38.676169  =


    2023-07-05T19:40:38.776692  / # . /lava-11022279/environment/lava-11022=
279/bin/lava-test-runner /lava-11022279/1

    2023-07-05T19:40:38.776934  =


    2023-07-05T19:40:38.781490  / # /lava-11022279/bin/lava-test-runner /la=
va-11022279/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c9e589aed5370fbb2a76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a5c9e589aed5370fbb2=
a77
        failing since 91 days (last pass: v5.15.105, first fail: v5.15.106) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5ca2100ce4524dcbb2aac

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5ca2100ce4524dcbb2ab1
        failing since 168 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-07-05T19:52:50.741367  <8>[   10.011889] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3712947_1.5.2.4.1>
    2023-07-05T19:52:50.854392  / # #
    2023-07-05T19:52:50.958397  export SHELL=3D/bin/sh
    2023-07-05T19:52:50.959738  #
    2023-07-05T19:52:51.062440  / # export SHELL=3D/bin/sh. /lava-3712947/e=
nvironment
    2023-07-05T19:52:51.063661  =

    2023-07-05T19:52:51.166113  / # . /lava-3712947/environment/lava-371294=
7/bin/lava-test-runner /lava-3712947/1
    2023-07-05T19:52:51.168210  =

    2023-07-05T19:52:51.172602  / # /lava-3712947/bin/lava-test-runner /lav=
a-3712947/1
    2023-07-05T19:52:51.256101  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c159d2dbee64b2bb2a93

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c159d2dbee64b2bb2a98
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:15:38.400722  + set +x

    2023-07-05T19:15:38.407614  <8>[    7.914461] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11021846_1.4.2.3.1>

    2023-07-05T19:15:38.512051  / # #

    2023-07-05T19:15:38.612634  export SHELL=3D/bin/sh

    2023-07-05T19:15:38.612819  #

    2023-07-05T19:15:38.713312  / # export SHELL=3D/bin/sh. /lava-11021846/=
environment

    2023-07-05T19:15:38.713527  =


    2023-07-05T19:15:38.814072  / # . /lava-11021846/environment/lava-11021=
846/bin/lava-test-runner /lava-11021846/1

    2023-07-05T19:15:38.814407  =


    2023-07-05T19:15:38.819462  / # /lava-11021846/bin/lava-test-runner /la=
va-11021846/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c8cda9e8c817f2bb2a90

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c8cea9e8c817f2bb2a95
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:47:17.962467  + set +x<8>[   12.750756] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11022298_1.4.2.3.1>

    2023-07-05T19:47:17.962903  =


    2023-07-05T19:47:18.070040  / # #

    2023-07-05T19:47:18.172189  export SHELL=3D/bin/sh

    2023-07-05T19:47:18.172827  #

    2023-07-05T19:47:18.274177  / # export SHELL=3D/bin/sh. /lava-11022298/=
environment

    2023-07-05T19:47:18.274835  =


    2023-07-05T19:47:18.376212  / # . /lava-11022298/environment/lava-11022=
298/bin/lava-test-runner /lava-11022298/1

    2023-07-05T19:47:18.377240  =


    2023-07-05T19:47:18.382331  / # /lava-11022298/bin/lava-test-runner /la=
va-11022298/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c162d2dbee64b2bb2aba

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c162d2dbee64b2bb2abf
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:15:32.963274  + set +x<8>[   10.768668] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11021874_1.4.2.3.1>

    2023-07-05T19:15:32.963826  =


    2023-07-05T19:15:33.071465  #

    2023-07-05T19:15:33.072771  =


    2023-07-05T19:15:33.174610  / # #export SHELL=3D/bin/sh

    2023-07-05T19:15:33.175552  =


    2023-07-05T19:15:33.277524  / # export SHELL=3D/bin/sh. /lava-11021874/=
environment

    2023-07-05T19:15:33.278367  =


    2023-07-05T19:15:33.380050  / # . /lava-11021874/environment/lava-11021=
874/bin/lava-test-runner /lava-11021874/1

    2023-07-05T19:15:33.381285  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c7ff1c52a4cb49bb2a82

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c7ff1c52a4cb49bb2a87
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:43:43.890057  + set +x

    2023-07-05T19:43:43.896339  <8>[   11.696971] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11022316_1.4.2.3.1>

    2023-07-05T19:43:44.004388  / # #

    2023-07-05T19:43:44.107348  export SHELL=3D/bin/sh

    2023-07-05T19:43:44.107982  #

    2023-07-05T19:43:44.209476  / # export SHELL=3D/bin/sh. /lava-11022316/=
environment

    2023-07-05T19:43:44.210260  =


    2023-07-05T19:43:44.311780  / # . /lava-11022316/environment/lava-11022=
316/bin/lava-test-runner /lava-11022316/1

    2023-07-05T19:43:44.312990  =


    2023-07-05T19:43:44.318206  / # /lava-11022316/bin/lava-test-runner /la=
va-11022316/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c16eb9b5b9188dbb2b05

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c16eb9b5b9188dbb2b0a
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:15:51.477060  + set<8>[   13.632460] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11021863_1.4.2.3.1>

    2023-07-05T19:15:51.477181   +x

    2023-07-05T19:15:51.581423  / # #

    2023-07-05T19:15:51.682134  export SHELL=3D/bin/sh

    2023-07-05T19:15:51.682369  #

    2023-07-05T19:15:51.782955  / # export SHELL=3D/bin/sh. /lava-11021863/=
environment

    2023-07-05T19:15:51.783149  =


    2023-07-05T19:15:51.883710  / # . /lava-11021863/environment/lava-11021=
863/bin/lava-test-runner /lava-11021863/1

    2023-07-05T19:15:51.884015  =


    2023-07-05T19:15:51.888891  / # /lava-11021863/bin/lava-test-runner /la=
va-11021863/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c7480ebdea0a3dbb2a81

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c7480ebdea0a3dbb2a86
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:40:44.851019  + <8>[   16.502074] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11022325_1.4.2.3.1>

    2023-07-05T19:40:44.851194  set +x

    2023-07-05T19:40:44.955317  / # #

    2023-07-05T19:40:45.055935  export SHELL=3D/bin/sh

    2023-07-05T19:40:45.056151  #

    2023-07-05T19:40:45.156698  / # export SHELL=3D/bin/sh. /lava-11022325/=
environment

    2023-07-05T19:40:45.156908  =


    2023-07-05T19:40:45.257423  / # . /lava-11022325/environment/lava-11022=
325/bin/lava-test-runner /lava-11022325/1

    2023-07-05T19:40:45.257734  =


    2023-07-05T19:40:45.262940  / # /lava-11022325/bin/lava-test-runner /la=
va-11022325/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c177e7e9ed91e9bb2a91

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c177e7e9ed91e9bb2a96
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:15:48.842618  <8>[   11.693346] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11021862_1.4.2.3.1>

    2023-07-05T19:15:48.946712  / # #

    2023-07-05T19:15:49.048538  export SHELL=3D/bin/sh

    2023-07-05T19:15:49.048930  #

    2023-07-05T19:15:49.149717  / # export SHELL=3D/bin/sh. /lava-11021862/=
environment

    2023-07-05T19:15:49.149930  =


    2023-07-05T19:15:49.250412  / # . /lava-11021862/environment/lava-11021=
862/bin/lava-test-runner /lava-11021862/1

    2023-07-05T19:15:49.250692  =


    2023-07-05T19:15:49.255922  / # /lava-11021862/bin/lava-test-runner /la=
va-11021862/1

    2023-07-05T19:15:49.260909  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c79ac542c420acbb2a8e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c79ac542c420acbb2a93
        failing since 97 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-07-05T19:42:14.531165  + <8>[   12.053953] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11022309_1.4.2.3.1>

    2023-07-05T19:42:14.531538  set +x

    2023-07-05T19:42:14.638366  / # #

    2023-07-05T19:42:14.740635  export SHELL=3D/bin/sh

    2023-07-05T19:42:14.741260  #

    2023-07-05T19:42:14.842438  / # export SHELL=3D/bin/sh. /lava-11022309/=
environment

    2023-07-05T19:42:14.843040  =


    2023-07-05T19:42:14.944448  / # . /lava-11022309/environment/lava-11022=
309/bin/lava-test-runner /lava-11022309/1

    2023-07-05T19:42:14.945448  =


    2023-07-05T19:42:14.950406  / # /lava-11022309/bin/lava-test-runner /la=
va-11022309/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c91fb2d25aa13cbb2ac8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c920b2d25aa13cbb2acd
        failing since 154 days (last pass: v5.15.73, first fail: v5.15.91)

    2023-07-05T19:48:38.494696  <8>[   11.607410] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3712937_1.5.2.4.1>
    2023-07-05T19:48:38.601526  / # #
    2023-07-05T19:48:38.703867  export SHELL=3D/bin/sh
    2023-07-05T19:48:38.704587  #
    2023-07-05T19:48:38.806526  / # export SHELL=3D/bin/sh. /lava-3712937/e=
nvironment
    2023-07-05T19:48:38.807028  =

    2023-07-05T19:48:38.908511  / # . /lava-3712937/environment/lava-371293=
7/bin/lava-test-runner /lava-3712937/1
    2023-07-05T19:48:38.909189  =

    2023-07-05T19:48:38.913762  / # /lava-3712937/bin/lava-test-runner /lav=
a-3712937/1
    2023-07-05T19:48:38.980784  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5c8011c52a4cb49bb2a90

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.=
txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.120/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a5c8011c52a4cb49bb2a95
        failing since 153 days (last pass: v5.15.82, first fail: v5.15.91)

    2023-07-05T19:43:34.302542  <8>[    5.973364] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3712884_1.5.2.4.1>
    2023-07-05T19:43:34.443461  / # #
    2023-07-05T19:43:34.549016  export SHELL=3D/bin/sh
    2023-07-05T19:43:34.550666  #
    2023-07-05T19:43:34.654027  / # export SHELL=3D/bin/sh. /lava-3712884/e=
nvironment
    2023-07-05T19:43:34.655638  =

    2023-07-05T19:43:34.759058  / # . /lava-3712884/environment/lava-371288=
4/bin/lava-test-runner /lava-3712884/1
    2023-07-05T19:43:34.761857  =

    2023-07-05T19:43:34.772211  / # /lava-3712884/bin/lava-test-runner /lav=
a-3712884/1
    2023-07-05T19:43:34.938791  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
