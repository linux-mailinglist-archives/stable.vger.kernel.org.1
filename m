Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C346D7A68CB
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjISQYL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 12:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISQYL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 12:24:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D1AB
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 09:24:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso44579265ad.1
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695140643; x=1695745443; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r4MbxzvSBTwOzi9ChX/7QmwuyR8R7LPVxHJrSAfWD6U=;
        b=fxeXJHCSZTJip+dGYtTdIFLqi7m4+4mLQ1TwYR9s/rMqt8xJzLmhDFq70aD9mwzIOC
         KjcCSx2yPd7mh+yopF2G5t402wYSJOqKJVdwxB0iwizuN8+XqpU/OqSwHhcGkx8B2NNI
         VSlWTfwy51o3h0SHT/xIjt+0BcfawLvlmllAnLm3ldI7gituaNX2yqFSXi87BEq53Dig
         JCWyamxX1hYc/FKIq6HQJp54HbYi0Qbl/vDhwnvf9lyrAqzdVzo22Beyx0XdZAek0JVu
         cgwFrrILwaSVQHqZYICyVBUG5rUl1liFKiQ74++wQw8tIzU5dxJ6hpVopT5b1VfSloCt
         UXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695140643; x=1695745443;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4MbxzvSBTwOzi9ChX/7QmwuyR8R7LPVxHJrSAfWD6U=;
        b=T1SDOh0F/8CZZojhwWYRZ2nmX+7OO5yITjk/uvqPa0MfQM2VAOKqTBmwUuBcRTI85V
         NyxmipzENIEUyZECfQd/rRqUjpDieFaTHvCiAywbDXH4orW5Mq/j5k9CLVToARXMVGfa
         neN6djIZr6U+dBabxUWepEixXXshYynTEGmWs8e/wEU2hNKYWMLEhpfVZq18vL4K8/M3
         HQN4B8XKAXhbGVXGwZB/XSbtUM2xSIfE+SInfFsZwroc35UCvH2uuu1/7+LZFi5NeJ93
         vvVT0tAG02eWgeBlWTkBx1zKomSJg0C+0srjzUdDbIQyIqdGSb/3F32SAvrWUcPeY2oI
         0ZZA==
X-Gm-Message-State: AOJu0Yz0B5uKjz7n1I8x7wPoV8SXcstuxIYIk4iTskCC0fjarDTPC+Qm
        AsSmFNB6OCCnXHc9w+NMD333hV2+C9ByBIo0r3dAUQ==
X-Google-Smtp-Source: AGHT+IEuY/49JBkqjVObUq1J325AvAj2zMVAJ3nCgxcc4VXm6U9tXt3YBdo8THcGY67PizFi+18c7w==
X-Received: by 2002:a17:902:76c5:b0:1bb:1523:b311 with SMTP id j5-20020a17090276c500b001bb1523b311mr8781983plt.41.1695140643237;
        Tue, 19 Sep 2023 09:24:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001bb9aadfb04sm10142930plr.220.2023.09.19.09.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 09:24:02 -0700 (PDT)
Message-ID: <6509cb22.170a0220.1cf90.3638@mx.google.com>
Date:   Tue, 19 Sep 2023 09:24:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.132
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 91 runs, 9 regressions (v5.15.132)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 91 runs, 9 regressions (v5.15.132)

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

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.132/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.132
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      35ecaa3632bff102decb9f2277cf99150b2bf690 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650994d1c3f092ba838a0a59

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650994d1c3f092ba838a0a62
        failing since 174 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-19T12:32:01.382333  + set +x

    2023-09-19T12:32:01.389053  <8>[   10.752052] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570841_1.4.2.3.1>

    2023-09-19T12:32:01.497694  =


    2023-09-19T12:32:01.599577  / # #export SHELL=3D/bin/sh

    2023-09-19T12:32:01.600348  =


    2023-09-19T12:32:01.702042  / # export SHELL=3D/bin/sh. /lava-11570841/=
environment

    2023-09-19T12:32:01.702847  =


    2023-09-19T12:32:01.804541  / # . /lava-11570841/environment/lava-11570=
841/bin/lava-test-runner /lava-11570841/1

    2023-09-19T12:32:01.805828  =


    2023-09-19T12:32:01.812263  / # /lava-11570841/bin/lava-test-runner /la=
va-11570841/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650994d8c3f092ba838a0a9d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650994d8c3f092ba838a0aa6
        failing since 174 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-19T12:32:07.183941  <8>[   10.616553] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570858_1.4.2.3.1>

    2023-09-19T12:32:07.187475  + set +x

    2023-09-19T12:32:07.292337  #

    2023-09-19T12:32:07.293743  =


    2023-09-19T12:32:07.395671  / # #export SHELL=3D/bin/sh

    2023-09-19T12:32:07.396460  =


    2023-09-19T12:32:07.497961  / # export SHELL=3D/bin/sh. /lava-11570858/=
environment

    2023-09-19T12:32:07.498917  =


    2023-09-19T12:32:07.600427  / # . /lava-11570858/environment/lava-11570=
858/bin/lava-test-runner /lava-11570858/1

    2023-09-19T12:32:07.601670  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099742f357ad2b858a0a4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65099742f357ad2b858a0=
a4f
        failing since 55 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650994e0c3f092ba838a0b02

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650994e0c3f092ba838a0b0b
        failing since 174 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-19T12:32:13.665728  <8>[   10.926760] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570875_1.4.2.3.1>

    2023-09-19T12:32:13.669614  + set +x

    2023-09-19T12:32:13.770976  =


    2023-09-19T12:32:13.871621  / # #export SHELL=3D/bin/sh

    2023-09-19T12:32:13.871794  =


    2023-09-19T12:32:13.972262  / # export SHELL=3D/bin/sh. /lava-11570875/=
environment

    2023-09-19T12:32:13.972436  =


    2023-09-19T12:32:14.072926  / # . /lava-11570875/environment/lava-11570=
875/bin/lava-test-runner /lava-11570875/1

    2023-09-19T12:32:14.073182  =


    2023-09-19T12:32:14.078125  / # /lava-11570875/bin/lava-test-runner /la=
va-11570875/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650994e1c3f092ba838a0b18

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650994e1c3f092ba838a0b21
        failing since 174 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-19T12:32:26.148698  + set<8>[   11.047329] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11570878_1.4.2.3.1>

    2023-09-19T12:32:26.148783   +x

    2023-09-19T12:32:26.253021  / # #

    2023-09-19T12:32:26.353582  export SHELL=3D/bin/sh

    2023-09-19T12:32:26.353740  #

    2023-09-19T12:32:26.454255  / # export SHELL=3D/bin/sh. /lava-11570878/=
environment

    2023-09-19T12:32:26.454414  =


    2023-09-19T12:32:26.554917  / # . /lava-11570878/environment/lava-11570=
878/bin/lava-test-runner /lava-11570878/1

    2023-09-19T12:32:26.555170  =


    2023-09-19T12:32:26.559687  / # /lava-11570878/bin/lava-test-runner /la=
va-11570878/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650994ddc3f092ba838a0ae1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650994ddc3f092ba838a0aea
        failing since 174 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-19T12:32:06.391038  <8>[   12.012927] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570861_1.4.2.3.1>

    2023-09-19T12:32:06.495769  / # #

    2023-09-19T12:32:06.596448  export SHELL=3D/bin/sh

    2023-09-19T12:32:06.596630  #

    2023-09-19T12:32:06.697195  / # export SHELL=3D/bin/sh. /lava-11570861/=
environment

    2023-09-19T12:32:06.697382  =


    2023-09-19T12:32:06.797947  / # . /lava-11570861/environment/lava-11570=
861/bin/lava-test-runner /lava-11570861/1

    2023-09-19T12:32:06.798269  =


    2023-09-19T12:32:06.802506  / # /lava-11570861/bin/lava-test-runner /la=
va-11570861/1

    2023-09-19T12:32:06.808045  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f66c2983c4d3a8a0a48

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65099f66c2983c4d3a8a0a51
        failing since 61 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-19T13:21:23.023815  / # #

    2023-09-19T13:21:23.125953  export SHELL=3D/bin/sh

    2023-09-19T13:21:23.126815  #

    2023-09-19T13:21:23.228291  / # export SHELL=3D/bin/sh. /lava-11570895/=
environment

    2023-09-19T13:21:23.228994  =


    2023-09-19T13:21:23.330424  / # . /lava-11570895/environment/lava-11570=
895/bin/lava-test-runner /lava-11570895/1

    2023-09-19T13:21:23.331578  =


    2023-09-19T13:21:23.333410  / # /lava-11570895/bin/lava-test-runner /la=
va-11570895/1

    2023-09-19T13:21:23.397224  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T13:21:23.397727  + cd /lav<8>[   15.985395] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11570895_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6509965282ec6c15c78a0af2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509965282ec6c15c78a0afb
        failing since 61 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-19T12:38:44.638656  / # #

    2023-09-19T12:38:45.718309  export SHELL=3D/bin/sh

    2023-09-19T12:38:45.720082  #

    2023-09-19T12:38:47.209731  / # export SHELL=3D/bin/sh. /lava-11570904/=
environment

    2023-09-19T12:38:47.211610  =


    2023-09-19T12:38:49.934736  / # . /lava-11570904/environment/lava-11570=
904/bin/lava-test-runner /lava-11570904/1

    2023-09-19T12:38:49.937162  =


    2023-09-19T12:38:49.945937  / # /lava-11570904/bin/lava-test-runner /la=
va-11570904/1

    2023-09-19T12:38:50.006066  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T12:38:50.006561  + cd /lava-115709<8>[   25.494604] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11570904_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6509963ff5332605798a0a8f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
32/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509963ff5332605798a0a98
        failing since 61 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-19T12:42:38.036208  / # #

    2023-09-19T12:42:38.138333  export SHELL=3D/bin/sh

    2023-09-19T12:42:38.139034  #

    2023-09-19T12:42:38.240456  / # export SHELL=3D/bin/sh. /lava-11570898/=
environment

    2023-09-19T12:42:38.241164  =


    2023-09-19T12:42:38.342523  / # . /lava-11570898/environment/lava-11570=
898/bin/lava-test-runner /lava-11570898/1

    2023-09-19T12:42:38.343593  =


    2023-09-19T12:42:38.359949  / # /lava-11570898/bin/lava-test-runner /la=
va-11570898/1

    2023-09-19T12:42:38.419045  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T12:42:38.419543  + cd /lava-1157089<8>[   16.881282] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11570898_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
