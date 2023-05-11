Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085CC6FFBD6
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 23:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbjEKV02 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjEKV01 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 17:26:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16031992
        for <stable@vger.kernel.org>; Thu, 11 May 2023 14:26:24 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6436e075166so6892880b3a.0
        for <stable@vger.kernel.org>; Thu, 11 May 2023 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683840384; x=1686432384;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7dqHO7wsfR3xC03e8RVqVLXBqiIshF/DYwgi5NyifBI=;
        b=R9ouDIYk6RM6MKPvo6CW8BJbz70hLsvVdqzet31w6A4Sg9P/kMqAPjcIWo1s4x4UKa
         lL0IsliyDMFVyu0JALWAtQou2eRyjvIMLpkV1SN/OboPIewYM+K6MzbZPiWLXbJ0roEu
         lIsDDHIFZUPvwZrkHVjMvJo37Rcvv++os3/r5hGpsRat4ZTZIykO5fMhomBOYgGv/8LX
         lJghgYEdI1MQYYpA0wkydfdpzHbMiaIzYbiibdNHRvfrzFyPg1p8JphJTGrd8VSQl6nF
         i3pgQRBR/czQwSdgLIJtVNCSJ8G4o623M6/KN8SZBg5w2DgNBYKRI4l/6RdQbnbONIu+
         6hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683840384; x=1686432384;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dqHO7wsfR3xC03e8RVqVLXBqiIshF/DYwgi5NyifBI=;
        b=Q/zsJEgbkGdOveXH7nTIjLIDZ/JtVNSFFsEF44/E1z7IKEKoG6TUfuqpOPKcZIVq3+
         ASbhiWB1VLmrx14YQxH61S9yPvZVXNsnrmsPg0KiyQX7B1olYXy0/CC4tXdgh/el2ZTn
         iQizwTka+qsbXkTjfqLpeJ8GwWukkLOuu1pmAeOuI+qxTH9theivSVCmIRhQ2dkpX6xg
         th77b7pj1qP/2uXsRicftndkqSKUGOTTM71uN4wQV6POZtqK4ZhilElI6UOZbO3OecBs
         QGmahtYKIqbErf35HOs1iJmKcVyOwmL44EL/g5pbPiQ/9V/HGt0E7YuDwY2jATA4JPLy
         rR0g==
X-Gm-Message-State: AC+VfDzMwa7rg57J8LMVItXvhAUNiFEMqK78mUsG35hqct3EQG3N+9No
        K++q6msghPaXMr28O1I0Clhb9odRy8cOrBCtUT3mcg==
X-Google-Smtp-Source: ACHHUZ6RNVFsZrxSNX7U4rnPXG7fs3YVw4y2OBukKG6Ny0/IwSiJVxL0j0gufvP4JJAN0gYnE3sK7g==
X-Received: by 2002:a05:6a00:10d3:b0:63b:5496:7afa with SMTP id d19-20020a056a0010d300b0063b54967afamr26991770pfu.11.1683840383704;
        Thu, 11 May 2023 14:26:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78510000000b00627e87f51a5sm5716349pfn.161.2023.05.11.14.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:26:23 -0700 (PDT)
Message-ID: <645d5d7f.a70a0220.1d70c.c6c1@mx.google.com>
Date:   Thu, 11 May 2023 14:26:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-10-g437e125656ffc
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 173 runs,
 9 regressions (v5.15.111-10-g437e125656ffc)
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

stable-rc/queue/5.15 baseline: 173 runs, 9 regressions (v5.15.111-10-g437e1=
25656ffc)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
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

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-10-g437e125656ffc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-10-g437e125656ffc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      437e125656ffc5bf4817f9f096a0cef4cf8a2987 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d29f259f832950f2e8692

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d29f259f832950f2e8697
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T17:46:07.636452  + set<8>[   11.172531] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10286394_1.4.2.3.1>

    2023-05-11T17:46:07.637028   +x

    2023-05-11T17:46:07.744898  / # #

    2023-05-11T17:46:07.847521  export SHELL=3D/bin/sh

    2023-05-11T17:46:07.848311  #

    2023-05-11T17:46:07.949830  / # export SHELL=3D/bin/sh. /lava-10286394/=
environment

    2023-05-11T17:46:07.950619  =


    2023-05-11T17:46:08.052431  / # . /lava-10286394/environment/lava-10286=
394/bin/lava-test-runner /lava-10286394/1

    2023-05-11T17:46:08.053671  =


    2023-05-11T17:46:08.058537  / # /lava-10286394/bin/lava-test-runner /la=
va-10286394/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d29f8151b075a6c2e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d29f8151b075a6c2e8602
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T17:46:10.673353  <8>[    8.740389] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10286350_1.4.2.3.1>

    2023-05-11T17:46:10.673454  + set +x

    2023-05-11T17:46:10.778208  / # #

    2023-05-11T17:46:10.878781  export SHELL=3D/bin/sh

    2023-05-11T17:46:10.878949  #

    2023-05-11T17:46:10.979473  / # export SHELL=3D/bin/sh. /lava-10286350/=
environment

    2023-05-11T17:46:10.979637  =


    2023-05-11T17:46:11.080142  / # . /lava-10286350/environment/lava-10286=
350/bin/lava-test-runner /lava-10286350/1

    2023-05-11T17:46:11.080469  =


    2023-05-11T17:46:11.085242  / # /lava-10286350/bin/lava-test-runner /la=
va-10286350/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d29e859f832950f2e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d29e859f832950f2e8613
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T17:46:03.477286  + <8>[    8.161162] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10286330_1.4.2.3.1>

    2023-05-11T17:46:03.477370  set +x

    2023-05-11T17:46:03.578488  #

    2023-05-11T17:46:03.679233  / # #export SHELL=3D/bin/sh

    2023-05-11T17:46:03.679397  =


    2023-05-11T17:46:03.779907  / # export SHELL=3D/bin/sh. /lava-10286330/=
environment

    2023-05-11T17:46:03.780072  =


    2023-05-11T17:46:03.880628  / # . /lava-10286330/environment/lava-10286=
330/bin/lava-test-runner /lava-10286330/1

    2023-05-11T17:46:03.880967  =


    2023-05-11T17:46:03.886272  / # /lava-10286330/bin/lava-test-runner /la=
va-10286330/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d29d4369140249d2e8616

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d29d4369140249d2e861b
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T17:45:41.309100  <8>[   10.844401] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10286322_1.4.2.3.1>

    2023-05-11T17:45:41.312482  + set +x

    2023-05-11T17:45:41.416150  / # #

    2023-05-11T17:45:41.516693  export SHELL=3D/bin/sh

    2023-05-11T17:45:41.516872  #

    2023-05-11T17:45:41.617343  / # export SHELL=3D/bin/sh. /lava-10286322/=
environment

    2023-05-11T17:45:41.617549  =


    2023-05-11T17:45:41.718029  / # . /lava-10286322/environment/lava-10286=
322/bin/lava-test-runner /lava-10286322/1

    2023-05-11T17:45:41.718311  =


    2023-05-11T17:45:41.723098  / # /lava-10286322/bin/lava-test-runner /la=
va-10286322/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d29da14b33cc2e62e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d29da14b33cc2e62e8607
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T17:45:37.959903  + <8>[   10.539216] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10286328_1.4.2.3.1>

    2023-05-11T17:45:37.960431  set +x

    2023-05-11T17:45:38.070700  / # #

    2023-05-11T17:45:38.173367  export SHELL=3D/bin/sh

    2023-05-11T17:45:38.174182  #

    2023-05-11T17:45:38.275739  / # export SHELL=3D/bin/sh. /lava-10286328/=
environment

    2023-05-11T17:45:38.276426  =


    2023-05-11T17:45:38.378170  / # . /lava-10286328/environment/lava-10286=
328/bin/lava-test-runner /lava-10286328/1

    2023-05-11T17:45:38.379697  =


    2023-05-11T17:45:38.384323  / # /lava-10286328/bin/lava-test-runner /la=
va-10286328/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645d2897de348824fe2e85ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d2897de348824fe2e8604
        failing since 104 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-11T17:40:31.168645  + set +x
    2023-05-11T17:40:31.168812  [    9.407493] <LAVA_SIGNAL_ENDRUN 0_dmesg =
948049_1.5.2.3.1>
    2023-05-11T17:40:31.276400  / # #
    2023-05-11T17:40:31.377877  export SHELL=3D/bin/sh
    2023-05-11T17:40:31.378290  #
    2023-05-11T17:40:31.479567  / # export SHELL=3D/bin/sh. /lava-948049/en=
vironment
    2023-05-11T17:40:31.480066  =

    2023-05-11T17:40:31.581330  / # . /lava-948049/environment/lava-948049/=
bin/lava-test-runner /lava-948049/1
    2023-05-11T17:40:31.581947  =

    2023-05-11T17:40:31.585387  / # /lava-948049/bin/lava-test-runner /lava=
-948049/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d29dc5961bdff9b2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d29dc5961bdff9b2e85eb
        failing since 44 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-11T17:45:49.176229  <8>[    8.757883] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10286339_1.4.2.3.1>

    2023-05-11T17:45:49.280928  / # #

    2023-05-11T17:45:49.381540  export SHELL=3D/bin/sh

    2023-05-11T17:45:49.381736  #

    2023-05-11T17:45:49.482338  / # export SHELL=3D/bin/sh. /lava-10286339/=
environment

    2023-05-11T17:45:49.482515  =


    2023-05-11T17:45:49.583000  / # . /lava-10286339/environment/lava-10286=
339/bin/lava-test-runner /lava-10286339/1

    2023-05-11T17:45:49.583273  =


    2023-05-11T17:45:49.587776  / # /lava-10286339/bin/lava-test-runner /la=
va-10286339/1

    2023-05-11T17:45:49.592955  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645d2880d59748ce002e85f5

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d2880d59748ce002e8622
        failing since 113 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-11T17:39:55.640182  + set +x
    2023-05-11T17:39:55.644296  <8>[   16.075109] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3576377_1.5.2.4.1>
    2023-05-11T17:39:55.764351  / # #
    2023-05-11T17:39:55.869877  export SHELL=3D/bin/sh
    2023-05-11T17:39:55.871418  #
    2023-05-11T17:39:55.974711  / # export SHELL=3D/bin/sh. /lava-3576377/e=
nvironment
    2023-05-11T17:39:55.976289  =

    2023-05-11T17:39:56.079770  / # . /lava-3576377/environment/lava-357637=
7/bin/lava-test-runner /lava-3576377/1
    2023-05-11T17:39:56.085189  =

    2023-05-11T17:39:56.087782  / # /lava-3576377/bin/lava-test-runner /lav=
a-3576377/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645d259a25e33131032e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-10-g437e125656ffc/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d259a25e33131032e85f9
        failing since 100 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.90-203-gea2e94bef77e)

    2023-05-11T17:27:41.689965  / ##
    2023-05-11T17:27:41.796301  export SHELL=3D/bin/sh
    2023-05-11T17:27:41.798254   #
    2023-05-11T17:27:41.901972  / # export SHELL=3D/bin/sh. /lava-3576320/e=
nvironment
    2023-05-11T17:27:41.903740  =

    2023-05-11T17:27:42.008072  / # . /lava-3576320/environment/lava-357632=
0/bin/lava-test-runner /lava-3576320/1
    2023-05-11T17:27:42.010983  =

    2023-05-11T17:27:42.027047  / # /lava-3576320/bin/lava-test-runner /lav=
a-3576320/1
    2023-05-11T17:27:42.152007  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-11T17:27:42.153257  + cd /lava-3576320/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
