Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB17156E0
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 09:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjE3HfZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjE3HfA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 03:35:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49B9AB
        for <stable@vger.kernel.org>; Tue, 30 May 2023 00:34:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64f47448aeaso2966522b3a.0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685432059; x=1688024059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GAbt6LQUaP1wjoCInjWYbBZqvITDO76oETgC4BqLf+8=;
        b=O17tix+G3qfs2zWx/H19BWLPm71WjsAIA0OeUnaj2mxbErCaoOvtJS3bwCRDb4W7YH
         1Au0SciHBImduO77LRM9NlcbGQLblFZ0wzLKfJluhiI/ixIeaz4wGvZCnk5bySkkGLFj
         H2z17soaXCbz27EZ3ePfYMwTVWOLldeELna8kFp2IIISZD36DlXmO38e8XRm1jokrzXc
         MAu26BaZoatmPYi+SQXPl4URdzX0lA9YQ2cMYtyuv/6b/MHd9J3dcW988Q5kxXSZLutG
         cdA1/esjlBUNKp3d+AEr4B3qhh3EmeiyShFKih4c6K5IncgfD08IYtQB1MDn4Ao1ohcG
         gpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432059; x=1688024059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAbt6LQUaP1wjoCInjWYbBZqvITDO76oETgC4BqLf+8=;
        b=R0eu9n/Ab3IdJK1vt2nxVpSjo5PaWWkAYmlnDYnCZVHEph4dhmBfxvOxxWdu0ohNHO
         WPLe8DbO2cBR9h/8cRxPMYMw4lfMjcDbluix2yrQ0U4KC2bOKbT7czITFCjGwlE/lzp8
         EHPDkRCUZzW42U6W4LUZPn+AHVnN8bn7p8Jj783yRqWcEi2aldwv+R0sslyBl/aH/b2X
         Wb+k3ejaZeqeb7zuHqMkICjSs9yL/TlK/md8ww74SqBgDO3dTGDZeUJwMDjvoNycU+H1
         WDygC0HOXOsptM2Va+6UX2W7Hl3gYezVBKw63QTbRAm/moPkcMG8IobAymA/KdSOyAOb
         3C0g==
X-Gm-Message-State: AC+VfDzbRjuFZh7JIGaErfuyya3BXUIncIYl3QGTmgj1PUE5oEt6GSWO
        AZ74B6cwma5ZL8UnXbL/jVApCbbCUkZPsMX9+Iv8TA==
X-Google-Smtp-Source: ACHHUZ63WELiawPZy2bXziOUf6yCZPq0SvBf3RrY6rDp0TEHEbvuhtFJg7LOlu2Dv7O7htBhF9SuFQ==
X-Received: by 2002:a05:6a20:4288:b0:10c:5ff4:8bc6 with SMTP id o8-20020a056a20428800b0010c5ff48bc6mr1733910pzj.38.1685432059499;
        Tue, 30 May 2023 00:34:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 75-20020a63044e000000b0053423447a12sm288504pge.73.2023.05.30.00.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:34:18 -0700 (PDT)
Message-ID: <6475a6fa.630a0220.875fc.0596@mx.google.com>
Date:   Tue, 30 May 2023 00:34:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-273-g45d082d2c0da
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 158 runs,
 7 regressions (v5.15.112-273-g45d082d2c0da)
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

stable-rc/queue/5.15 baseline: 158 runs, 7 regressions (v5.15.112-273-g45d0=
82d2c0da)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-273-g45d082d2c0da/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-273-g45d082d2c0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      45d082d2c0daa97f3ea394c47e705afdd1c621e0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64756d055bd568c0072e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64756d055bd568c0072e85eb
        failing since 62 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-30T03:26:41.542689  + <8>[   12.157500] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10516776_1.4.2.3.1>

    2023-05-30T03:26:41.542851  set +x

    2023-05-30T03:26:41.647894  / # #

    2023-05-30T03:26:41.748771  export SHELL=3D/bin/sh

    2023-05-30T03:26:41.749059  #

    2023-05-30T03:26:41.849695  / # export SHELL=3D/bin/sh. /lava-10516776/=
environment

    2023-05-30T03:26:41.849976  =


    2023-05-30T03:26:41.950620  / # . /lava-10516776/environment/lava-10516=
776/bin/lava-test-runner /lava-10516776/1

    2023-05-30T03:26:41.951055  =


    2023-05-30T03:26:41.955666  / # /lava-10516776/bin/lava-test-runner /la=
va-10516776/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64756cffb9edceb6522e863b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64756cffb9edceb6522e8640
        failing since 62 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-30T03:26:34.895807  <8>[   10.645227] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10516771_1.4.2.3.1>

    2023-05-30T03:26:34.900179  + set +x

    2023-05-30T03:26:35.005944  =


    2023-05-30T03:26:35.107592  / # #export SHELL=3D/bin/sh

    2023-05-30T03:26:35.108293  =


    2023-05-30T03:26:35.209626  / # export SHELL=3D/bin/sh. /lava-10516771/=
environment

    2023-05-30T03:26:35.210289  =


    2023-05-30T03:26:35.311775  / # . /lava-10516771/environment/lava-10516=
771/bin/lava-test-runner /lava-10516771/1

    2023-05-30T03:26:35.312895  =


    2023-05-30T03:26:35.318223  / # /lava-10516771/bin/lava-test-runner /la=
va-10516771/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647574481dfbf197c32e8639

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647574481dfbf197c32e8=
63a
        failing since 115 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475704be2be85907f2e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475704be2be85907f2e85ea
        failing since 132 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-30T03:40:34.059117  <8>[    9.975365] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3630220_1.5.2.4.1>
    2023-05-30T03:40:34.169090  / # #
    2023-05-30T03:40:34.272827  export SHELL=3D/bin/sh
    2023-05-30T03:40:34.273928  #
    2023-05-30T03:40:34.376358  / # export SHELL=3D/bin/sh. /lava-3630220/e=
nvironment
    2023-05-30T03:40:34.377470  =

    2023-05-30T03:40:34.378070  / # . /lava-3630220/environment<3>[   10.27=
6814] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-05-30T03:40:34.480421  /lava-3630220/bin/lava-test-runner /lava-36=
30220/1
    2023-05-30T03:40:34.482126  =

    2023-05-30T03:40:34.486578  / # /lava-3630220/bin/lava-test-runner /lav=
a-3630220/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64756ce455897ee6342e8603

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64756ce455897ee6342e8608
        failing since 62 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-30T03:26:18.188889  + set +x

    2023-05-30T03:26:18.195308  <8>[   10.685860] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10516781_1.4.2.3.1>

    2023-05-30T03:26:18.300218  / # #

    2023-05-30T03:26:18.402241  export SHELL=3D/bin/sh

    2023-05-30T03:26:18.402572  #

    2023-05-30T03:26:18.503525  / # export SHELL=3D/bin/sh. /lava-10516781/=
environment

    2023-05-30T03:26:18.504198  =


    2023-05-30T03:26:18.605895  / # . /lava-10516781/environment/lava-10516=
781/bin/lava-test-runner /lava-10516781/1

    2023-05-30T03:26:18.606936  =


    2023-05-30T03:26:18.611943  / # /lava-10516781/bin/lava-test-runner /la=
va-10516781/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64756cea869373954d2e8657

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64756ceb869373954d2e865c
        failing since 62 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-30T03:26:20.192006  + set +x<8>[   11.022901] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10516779_1.4.2.3.1>

    2023-05-30T03:26:20.192257  =


    2023-05-30T03:26:20.296723  #

    2023-05-30T03:26:20.296982  =


    2023-05-30T03:26:20.397698  / # #export SHELL=3D/bin/sh

    2023-05-30T03:26:20.398061  =


    2023-05-30T03:26:20.499023  / # export SHELL=3D/bin/sh. /lava-10516779/=
environment

    2023-05-30T03:26:20.499914  =


    2023-05-30T03:26:20.601584  / # . /lava-10516779/environment/lava-10516=
779/bin/lava-test-runner /lava-10516779/1

    2023-05-30T03:26:20.603095  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64756cf6b9edceb6522e8616

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-273-g45d082d2c0da/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64756cf6b9edceb6522e861b
        failing since 62 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-30T03:26:23.849799  + set<8>[   11.357998] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10516824_1.4.2.3.1>

    2023-05-30T03:26:23.849913   +x

    2023-05-30T03:26:23.954757  / # #

    2023-05-30T03:26:24.055328  export SHELL=3D/bin/sh

    2023-05-30T03:26:24.055548  #

    2023-05-30T03:26:24.156052  / # export SHELL=3D/bin/sh. /lava-10516824/=
environment

    2023-05-30T03:26:24.156257  =


    2023-05-30T03:26:24.256774  / # . /lava-10516824/environment/lava-10516=
824/bin/lava-test-runner /lava-10516824/1

    2023-05-30T03:26:24.257030  =


    2023-05-30T03:26:24.261590  / # /lava-10516824/bin/lava-test-runner /la=
va-10516824/1
 =

    ... (12 line(s) more)  =

 =20
