Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BDF7347A4
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 20:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjFRSie (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 14:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFRSie (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 14:38:34 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C591312B
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:38:31 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39ecf336d85so648031b6e.2
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687113510; x=1689705510;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cnwzJnWLrFwVBdJNErmYOtJgqlDmQdewFwBj+l9UQKk=;
        b=1gX0Sa/c6DJBClGrHpnl4rjjPjKqeq/3BwI4HP2Qjf6mWnrqZN1JybjgYXTrZ8f4oQ
         Z245QNbQ/uDVnXGr4LYbhAsIkeVAtSb+Xr2tGzbeJRnPeSZKiqe8r71rSiKyVrODTrXG
         3A030zp3vsjYxRo1u4JreAuYbHyvVKmPTHD6eeY+Z9uKOSKhIk5VjBB/kIEt8o69Xiyl
         bG780K0C9xaN/HegkBPiAFPAjB1HW4aMj2xMHNIrtw/1EI2TbGGBdxgNmaligd9TIJPy
         tvKRMUsjqWIps7g7kScuJlco1Kp+UFLJTdwhbzCCH2yXDr+PXgEzXzYdIXQOj6GgntGp
         N9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687113510; x=1689705510;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnwzJnWLrFwVBdJNErmYOtJgqlDmQdewFwBj+l9UQKk=;
        b=a7zHjs7T1N8cfr7CTzgA9lOsTbfYbZRPz1uLxWWV4l1Gvkf4Itrne1MFghAJB/XGB3
         d9R+Yqh83yoWhASu2yMhLgn9FJhFfcjoBfsFDiuFVPh7Jes3SoBcWb6dmEhkxBtPCngN
         SepWvKBEJqPvBR8FDKAiInyp4mYiPB83oNrh9MNyszx50p5QFiNIoFjqXdwD5fmix52j
         pw2VJl4GgJUyLV8ROkmMXmftEuLYYK/ykogKlHAPBHAeQlrA6x0e+6UOJGe/Ll2vtJat
         PaxL8cQCbvI8soPQIiTflsyn45wiPpDWgXnX8fW0egMjPcM5R1sUwf0EMa+CAsZvNzie
         2/iA==
X-Gm-Message-State: AC+VfDzRByYnEJIdYAa4oqb8f7FVrH28icpiQBOgf9zYKLsQjcZCw1xQ
        NweRl6jgbgiHJuh78ySv+9n1BshtlxfAavvYIlh4Jlnn
X-Google-Smtp-Source: ACHHUZ6yaouHtjNIf4NcK9D1K5I+igfUfoeVb+722vQX8q5nDCeNWqYRPLOmXrKCFV+TTXM2OX/12Q==
X-Received: by 2002:a05:6808:20a9:b0:398:2b78:3272 with SMTP id s41-20020a05680820a900b003982b783272mr12160016oiw.26.1687113510452;
        Sun, 18 Jun 2023 11:38:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b001a1a82fc6d3sm2453988plt.268.2023.06.18.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 11:38:29 -0700 (PDT)
Message-ID: <648f4f25.170a0220.68a2d.3514@mx.google.com>
Date:   Sun, 18 Jun 2023 11:38:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.34-90-g7a9de0e648cfb
Subject: stable-rc/linux-6.1.y baseline: 115 runs,
 8 regressions (v6.1.34-90-g7a9de0e648cfb)
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

stable-rc/linux-6.1.y baseline: 115 runs, 8 regressions (v6.1.34-90-g7a9de0=
e648cfb)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.34-90-g7a9de0e648cfb/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.34-90-g7a9de0e648cfb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7a9de0e648cfb4b236cc4c3dfe0928c4deabad82 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f16f6d981e1978b30619e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f16f6d981e1978b3061a3
        failing since 79 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-18T14:38:31.259243  <8>[   11.006583] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10793797_1.4.2.3.1>

    2023-06-18T14:38:31.262499  + set +x

    2023-06-18T14:38:31.364214  #

    2023-06-18T14:38:31.465104  / # #export SHELL=3D/bin/sh

    2023-06-18T14:38:31.465316  =


    2023-06-18T14:38:31.565862  / # export SHELL=3D/bin/sh. /lava-10793797/=
environment

    2023-06-18T14:38:31.566137  =


    2023-06-18T14:38:31.666772  / # . /lava-10793797/environment/lava-10793=
797/bin/lava-test-runner /lava-10793797/1

    2023-06-18T14:38:31.667100  =


    2023-06-18T14:38:31.673138  / # /lava-10793797/bin/lava-test-runner /la=
va-10793797/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f16f3d981e1978b30612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f16f3d981e1978b306133
        failing since 79 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-18T14:38:25.350889  + set<8>[   11.619055] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10793804_1.4.2.3.1>

    2023-06-18T14:38:25.351464   +x

    2023-06-18T14:38:25.458555  / # #

    2023-06-18T14:38:25.560940  export SHELL=3D/bin/sh

    2023-06-18T14:38:25.561718  #

    2023-06-18T14:38:25.663290  / # export SHELL=3D/bin/sh. /lava-10793804/=
environment

    2023-06-18T14:38:25.664080  =


    2023-06-18T14:38:25.765731  / # . /lava-10793804/environment/lava-10793=
804/bin/lava-test-runner /lava-10793804/1

    2023-06-18T14:38:25.766871  =


    2023-06-18T14:38:25.772174  / # /lava-10793804/bin/lava-test-runner /la=
va-10793804/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f16eb79ee465ce430615f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f16eb79ee465ce4306164
        failing since 79 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-18T14:38:22.151935  <8>[    7.774066] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10793774_1.4.2.3.1>

    2023-06-18T14:38:22.154967  + set +x

    2023-06-18T14:38:22.256542  =


    2023-06-18T14:38:22.357108  / # #export SHELL=3D/bin/sh

    2023-06-18T14:38:22.357325  =


    2023-06-18T14:38:22.457826  / # export SHELL=3D/bin/sh. /lava-10793774/=
environment

    2023-06-18T14:38:22.458041  =


    2023-06-18T14:38:22.558595  / # . /lava-10793774/environment/lava-10793=
774/bin/lava-test-runner /lava-10793774/1

    2023-06-18T14:38:22.558867  =


    2023-06-18T14:38:22.563740  / # /lava-10793774/bin/lava-test-runner /la=
va-10793774/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648f16103059eba00930612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648f16103059eba009306=
12f
        failing since 10 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f16e7d319778fb5306185

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f16e7d319778fb530618a
        failing since 79 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-18T14:38:35.027297  + set +x

    2023-06-18T14:38:35.033942  <8>[   10.719706] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10793838_1.4.2.3.1>

    2023-06-18T14:38:35.138793  / # #

    2023-06-18T14:38:35.239385  export SHELL=3D/bin/sh

    2023-06-18T14:38:35.239607  #

    2023-06-18T14:38:35.340149  / # export SHELL=3D/bin/sh. /lava-10793838/=
environment

    2023-06-18T14:38:35.340393  =


    2023-06-18T14:38:35.440984  / # . /lava-10793838/environment/lava-10793=
838/bin/lava-test-runner /lava-10793838/1

    2023-06-18T14:38:35.441274  =


    2023-06-18T14:38:35.445761  / # /lava-10793838/bin/lava-test-runner /la=
va-10793838/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f16e89fff8e09c430614f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f16e89fff8e09c4306154
        failing since 79 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-18T14:38:16.649884  + set +x

    2023-06-18T14:38:16.656061  <8>[   10.370727] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10793821_1.4.2.3.1>

    2023-06-18T14:38:16.761058  / # #

    2023-06-18T14:38:16.861664  export SHELL=3D/bin/sh

    2023-06-18T14:38:16.861863  #

    2023-06-18T14:38:16.962357  / # export SHELL=3D/bin/sh. /lava-10793821/=
environment

    2023-06-18T14:38:16.962625  =


    2023-06-18T14:38:17.063276  / # . /lava-10793821/environment/lava-10793=
821/bin/lava-test-runner /lava-10793821/1

    2023-06-18T14:38:17.063562  =


    2023-06-18T14:38:17.068600  / # /lava-10793821/bin/lava-test-runner /la=
va-10793821/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f16ee9fff8e09c430616d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f16ee9fff8e09c4306172
        failing since 79 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-18T14:38:16.584989  + set<8>[   11.238777] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10793805_1.4.2.3.1>

    2023-06-18T14:38:16.585099   +x

    2023-06-18T14:38:16.689934  / # #

    2023-06-18T14:38:16.790548  export SHELL=3D/bin/sh

    2023-06-18T14:38:16.790745  #

    2023-06-18T14:38:16.891233  / # export SHELL=3D/bin/sh. /lava-10793805/=
environment

    2023-06-18T14:38:16.891528  =


    2023-06-18T14:38:16.992192  / # . /lava-10793805/environment/lava-10793=
805/bin/lava-test-runner /lava-10793805/1

    2023-06-18T14:38:16.992571  =


    2023-06-18T14:38:16.997187  / # /lava-10793805/bin/lava-test-runner /la=
va-10793805/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648f16ea79ee465ce4306154

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
90-g7a9de0e648cfb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648f16ea79ee465ce4306159
        failing since 79 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-18T14:38:27.005956  + set +x<8>[   12.343137] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10793841_1.4.2.3.1>

    2023-06-18T14:38:27.006412  =


    2023-06-18T14:38:27.113825  / # #

    2023-06-18T14:38:27.216012  export SHELL=3D/bin/sh

    2023-06-18T14:38:27.216690  #

    2023-06-18T14:38:27.318043  / # export SHELL=3D/bin/sh. /lava-10793841/=
environment

    2023-06-18T14:38:27.318764  =


    2023-06-18T14:38:27.420139  / # . /lava-10793841/environment/lava-10793=
841/bin/lava-test-runner /lava-10793841/1

    2023-06-18T14:38:27.421415  =


    2023-06-18T14:38:27.426264  / # /lava-10793841/bin/lava-test-runner /la=
va-10793841/1
 =

    ... (12 line(s) more)  =

 =20
