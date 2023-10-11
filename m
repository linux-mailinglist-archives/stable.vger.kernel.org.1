Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE64D7C4756
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 03:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbjJKBfT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 21:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344233AbjJKBfS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 21:35:18 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2431E91
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 18:35:12 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c67060fdfbso4605402a34.2
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 18:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696988111; x=1697592911; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh+070l7tKCB6dysSSvnfPo6kvoPxW2on6GkNyiGkHM=;
        b=pf1GdJ+O3cAu7bSfTjXtXsCMdwLmcHU9feOprs4BSyrhIh/dm88zUT+hYLqqa2ryTQ
         iJ7w3oY3xCK4skIm5AlNBSFDVk9bkpwBZefcVbwVZzLszzIUIUBJrypm3Rlvm7ijfQmt
         kC5yI6e+HxHXKQZsjYwqMuloHKcmK4fVes4vSD/RyqppF03uW5rkmJDUKfDw6/eDlj6s
         YdB4U9MP//pCSzMzX+X1Vhdqmnm+ZDAySf5zNwPcomyEwxl86pdHqs2e5GJn7T4f7FfG
         VTr26xHg6dQ6twscAWHsINV593uRfHJvY0Cnp4ziDWjETTZcfG2V8Nv6EGd3LpaKkqDs
         FAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696988111; x=1697592911;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh+070l7tKCB6dysSSvnfPo6kvoPxW2on6GkNyiGkHM=;
        b=tG63xc3IR0ggqXhkVViuo0RwVplisIkBO6W4TcCxkhVBIGv0A6+y0CIsbG/cMNw6sw
         cqPK+FogNjU+Wn5RO5bY70Id5K+VS1Ke4VMk/WnEv+CnTLBil9zRnGobeH4QCCLbdgd9
         Mqi9fD8jWvflpVrfLH7LhKzTMW9+JHzSxOX3aiaelquQyDo8rjPratLE0LC42Eafm+QQ
         hkG8gjTaE1H3bISiJu6SuDDYx56D87v4DgM7kPd6Tvb4s0WjHquNQUQOKprtcWDnDWS+
         Tnc2oeiIDFM27zddbFsDDc8ZLda/4DdM8yXDWJu27SGhrBcXEDDMJ1/3tHBmisKkjpwu
         rGRg==
X-Gm-Message-State: AOJu0Yy1o8HhD4KsQ3LYKzJ01PLQNsnuYGr7vH0cBKqUahaMBlSKWqfb
        I4g6DYj/dfMLJekS/DE5R4JEHI8xCyyBF1pPEjsHug==
X-Google-Smtp-Source: AGHT+IGoWl+kRxAasY9in6fjsJbPipRVGbpTeLthiT+Vl/XrJvpFNdRWqqxb1dREMSahx7fm/3TRYw==
X-Received: by 2002:a05:6358:290f:b0:143:9b23:e850 with SMTP id y15-20020a056358290f00b001439b23e850mr24363418rwb.24.1696988110509;
        Tue, 10 Oct 2023 18:35:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j3-20020aa78003000000b0064d74808738sm8832492pfi.214.2023.10.10.18.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 18:35:09 -0700 (PDT)
Message-ID: <6525fbcd.a70a0220.aec4b.8277@mx.google.com>
Date:   Tue, 10 Oct 2023 18:35:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.135
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 150 runs, 33 regressions (v5.15.135)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 150 runs, 33 regressions (v5.15.135)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

hp-x360-14-G1-sona         | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

qemu_arm-vexpress-a15      | arm    | lab-baylibre  | gcc-10   | vexpress_d=
efconfig           | 1          =

qemu_arm-vexpress-a9       | arm    | lab-baylibre  | gcc-10   | vexpress_d=
efconfig           | 1          =

qemu_arm-virt-gicv2        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv3        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_i386                  | i386   | lab-baylibre  | gcc-10   | i386_defco=
nfig               | 1          =

qemu_i386-uefi             | i386   | lab-baylibre  | gcc-10   | i386_defco=
nfig               | 1          =

qemu_riscv64               | riscv  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_smp8_riscv64          | riscv  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_x86_64                | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =

qemu_x86_64                | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

qemu_x86_64-uefi           | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =

qemu_x86_64-uefi           | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

r8a77960-ulcb              | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

r8a779m1-ulcb              | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

sun50i-h6-pine-h64         | arm64  | lab-clabbe    | gcc-10   | defconfig =
                   | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.135/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.135
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      02e21884dcf2f1746ab686a6ea41a0a92520fe58 =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c95cf277f14517efcf3d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c95cf277f14517efcf46
        failing since 196 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-10T21:59:38.131533  <8>[    8.089138] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11730046_1.4.2.3.1>

    2023-10-10T21:59:38.134930  + set +x

    2023-10-10T21:59:38.241530  / # #

    2023-10-10T21:59:38.342202  export SHELL=3D/bin/sh

    2023-10-10T21:59:38.342411  #

    2023-10-10T21:59:38.442951  / # export SHELL=3D/bin/sh. /lava-11730046/=
environment

    2023-10-10T21:59:38.443145  =


    2023-10-10T21:59:38.543689  / # . /lava-11730046/environment/lava-11730=
046/bin/lava-test-runner /lava-11730046/1

    2023-10-10T21:59:38.543954  =


    2023-10-10T21:59:38.549845  / # /lava-11730046/bin/lava-test-runner /la=
va-11730046/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c94466476773f8efcf4c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c94466476773f8efcf55
        failing since 196 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-10T21:59:23.313024  <8>[    7.885062] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11730086_1.4.2.3.1>

    2023-10-10T21:59:23.316524  + set +x

    2023-10-10T21:59:23.417924  =


    2023-10-10T21:59:23.518465  / # #export SHELL=3D/bin/sh

    2023-10-10T21:59:23.518642  =


    2023-10-10T21:59:23.619129  / # export SHELL=3D/bin/sh. /lava-11730086/=
environment

    2023-10-10T21:59:23.619315  =


    2023-10-10T21:59:23.719853  / # . /lava-11730086/environment/lava-11730=
086/bin/lava-test-runner /lava-11730086/1

    2023-10-10T21:59:23.720153  =


    2023-10-10T21:59:23.724887  / # /lava-11730086/bin/lava-test-runner /la=
va-11730086/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-14-G1-sona         | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c9436141099707efcf0f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c9446141099707efcf18
        failing since 196 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-10T22:00:50.606770  + set +x<8>[   12.458564] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11730057_1.4.2.3.1>

    2023-10-10T22:00:50.606863  =


    2023-10-10T22:00:50.708660  #

    2023-10-10T22:00:50.809441  / # #export SHELL=3D/bin/sh

    2023-10-10T22:00:50.809647  =


    2023-10-10T22:00:50.910205  / # export SHELL=3D/bin/sh. /lava-11730057/=
environment

    2023-10-10T22:00:50.910404  =


    2023-10-10T22:00:51.010992  / # . /lava-11730057/environment/lava-11730=
057/bin/lava-test-runner /lava-11730057/1

    2023-10-10T22:00:51.011282  =


    2023-10-10T22:00:51.016412  / # /lava-11730057/bin/lava-test-runner /la=
va-11730057/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-14a-cb0001xx-zork  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c95f329d9d33afefcef6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c95f329d9d33afefceff
        failing since 196 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-10T21:59:37.675248  + set<8>[   11.479962] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11730074_1.4.2.3.1>

    2023-10-10T21:59:37.675439   +x

    2023-10-10T21:59:37.780586  / # #

    2023-10-10T21:59:37.881410  export SHELL=3D/bin/sh

    2023-10-10T21:59:37.882177  #

    2023-10-10T21:59:37.983522  / # export SHELL=3D/bin/sh. /lava-11730074/=
environment

    2023-10-10T21:59:37.983734  =


    2023-10-10T21:59:38.084352  / # . /lava-11730074/environment/lava-11730=
074/bin/lava-test-runner /lava-11730074/1

    2023-10-10T21:59:38.085625  =


    2023-10-10T21:59:38.090130  / # /lava-11730074/bin/lava-test-runner /la=
va-11730074/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c93b6141099707efcefb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525c93b6141099707efcf04
        failing since 196 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-10T21:59:16.936908  + set +x<8>[   11.134992] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11730067_1.4.2.3.1>

    2023-10-10T21:59:16.937014  =


    2023-10-10T21:59:17.041945  / # #

    2023-10-10T21:59:17.142463  export SHELL=3D/bin/sh

    2023-10-10T21:59:17.142655  #

    2023-10-10T21:59:17.243147  / # export SHELL=3D/bin/sh. /lava-11730067/=
environment

    2023-10-10T21:59:17.243340  =


    2023-10-10T21:59:17.343864  / # . /lava-11730067/environment/lava-11730=
067/bin/lava-test-runner /lava-11730067/1

    2023-10-10T21:59:17.344166  =


    2023-10-10T21:59:17.348966  / # /lava-11730067/bin/lava-test-runner /la=
va-11730067/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-vexpress-a15      | arm    | lab-baylibre  | gcc-10   | vexpress_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c7217296e84742efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a1=
5.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a1=
5.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c7227296e84742efc=
ef7
        failing since 6 days (last pass: v5.15.120-461-gf00f5bd44794, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-vexpress-a9       | arm    | lab-baylibre  | gcc-10   | vexpress_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c722fe765350b5efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a9=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a9=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c723fe765350b5efc=
ef4
        failing since 6 days (last pass: v5.15.120-461-gf00f5bd44794, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525caa6671b819e86efcf56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525caa6671b819e86efc=
f57
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525caa8e9e790c67cefcf16

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2-=
uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv2-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525caa8e9e790c67cefc=
f17
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525caabfbebea46e4efcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525caabfbebea46e4efc=
ef9
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525caa9e9e790c67cefcf19

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525caa9e9e790c67cefc=
f1a
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c95643233eb6d7efcf35

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c95643233eb6d7efc=
f36
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525caad89835b9aa9efcefe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525caad89835b9aa9efc=
eff
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c95343233eb6d7efcf2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c95343233eb6d7efc=
f2e
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525caaae9e790c67cefcf1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525caaae9e790c67cefc=
f1d
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c95443233eb6d7efcf30

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c95443233eb6d7efc=
f31
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525caa7e9e790c67cefcf12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525caa7e9e790c67cefc=
f13
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c955b329e1e7f4efcf31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c955b329e1e7f4efc=
f32
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525caacfbebea46e4efcefe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525caacfbebea46e4efc=
eff
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_i386                  | i386   | lab-baylibre  | gcc-10   | i386_defco=
nfig               | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c812ee06dab7c9efcf28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c812ee06dab7c9efc=
f29
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_i386-uefi             | i386   | lab-baylibre  | gcc-10   | i386_defco=
nfig               | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c813b631f72d42efceff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c813b631f72d42efc=
f00
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_riscv64               | riscv  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c75f4fbaee04d7efcf75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c75f4fbaee04d7efc=
f76
        failing since 6 days (last pass: v5.15.121-29-g391f6b7e3028e, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_smp8_riscv64          | riscv  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c75e4fbaee04d7efcf72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c75e4fbaee04d7efc=
f73
        failing since 6 days (last pass: v5.15.121-29-g391f6b7e3028e, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64                | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c7afc7594e1f2befcf01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c7afc7594e1f2befc=
f02
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64                | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c916a1aaa70696efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu=
_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu=
_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c916a1aaa70696efc=
efa
        failing since 6 days (last pass: v5.15.120-461-gf00f5bd44794, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi           | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c7b189026fdcc3efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c7b189026fdcc3efc=
ef7
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi           | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c918a1aaa70696efceff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu=
_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu=
_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c918a1aaa70696efc=
f00
        failing since 6 days (last pass: v5.15.120-461-gf00f5bd44794, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c7b0c7594e1f2befcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi-mi=
xed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi-mi=
xed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c7b0c7594e1f2befc=
f06
        failing since 6 days (last pass: v5.15.120, first fail: v5.15.133-1=
84-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525c917082870e1bbefcf17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu=
_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu=
_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525c917082870e1bbefc=
f18
        failing since 6 days (last pass: v5.15.120-461-gf00f5bd44794, first=
 fail: v5.15.133-184-g6f28ecf24aef) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a77960-ulcb              | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cad8c9c3c66bd5efcfa5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525cad8c9c3c66bd5efcfae
        failing since 83 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-10T22:10:13.173961  / # #

    2023-10-10T22:10:13.274539  export SHELL=3D/bin/sh

    2023-10-10T22:10:13.274694  #

    2023-10-10T22:10:13.375264  / # export SHELL=3D/bin/sh. /lava-11730187/=
environment

    2023-10-10T22:10:13.375405  =


    2023-10-10T22:10:13.475946  / # . /lava-11730187/environment/lava-11730=
187/bin/lava-test-runner /lava-11730187/1

    2023-10-10T22:10:13.476223  =


    2023-10-10T22:10:13.481779  / # /lava-11730187/bin/lava-test-runner /la=
va-11730187/1

    2023-10-10T22:10:13.542406  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T22:10:13.542896  + cd /lav<8>[   15.979016] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11730187_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a779m1-ulcb              | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cb1096031e7e75efcf05

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525cb1096031e7e75efcf0e
        failing since 83 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-10T22:09:23.365219  / # #

    2023-10-10T22:09:24.445755  export SHELL=3D/bin/sh

    2023-10-10T22:09:24.447643  #

    2023-10-10T22:09:25.938374  / # export SHELL=3D/bin/sh. /lava-11730206/=
environment

    2023-10-10T22:09:25.940235  =


    2023-10-10T22:09:28.664695  / # . /lava-11730206/environment/lava-11730=
206/bin/lava-test-runner /lava-11730206/1

    2023-10-10T22:09:28.667049  =


    2023-10-10T22:09:28.674519  / # /lava-11730206/bin/lava-test-runner /la=
va-11730206/1

    2023-10-10T22:09:28.739530  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T22:09:28.740026  + cd /lav<8>[   25.459154] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11730206_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-clabbe    | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cade718626ed3cefcf12

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525cade718626ed3cefcf1b
        failing since 83 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-10T22:06:09.985415  / # #
    2023-10-10T22:06:10.087107  export SHELL=3D/bin/sh
    2023-10-10T22:06:10.087758  #
    2023-10-10T22:06:10.188794  / # export SHELL=3D/bin/sh. /lava-437894/en=
vironment
    2023-10-10T22:06:10.189399  =

    2023-10-10T22:06:10.290457  / # . /lava-437894/environment/lava-437894/=
bin/lava-test-runner /lava-437894/1
    2023-10-10T22:06:10.291424  =

    2023-10-10T22:06:10.295303  / # /lava-437894/bin/lava-test-runner /lava=
-437894/1
    2023-10-10T22:06:10.327353  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-10T22:06:10.368628  + cd /lava-437894/<8>[   16.567746] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 437894_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525cada718626ed3cefcf07

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525cada718626ed3cefcf10
        failing since 83 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-10T22:10:28.157235  / # #

    2023-10-10T22:10:28.259367  export SHELL=3D/bin/sh

    2023-10-10T22:10:28.260112  #

    2023-10-10T22:10:28.361396  / # export SHELL=3D/bin/sh. /lava-11730201/=
environment

    2023-10-10T22:10:28.361604  =


    2023-10-10T22:10:28.462348  / # . /lava-11730201/environment/lava-11730=
201/bin/lava-test-runner /lava-11730201/1

    2023-10-10T22:10:28.463301  =


    2023-10-10T22:10:28.470743  / # /lava-11730201/bin/lava-test-runner /la=
va-11730201/1

    2023-10-10T22:10:28.536446  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T22:10:28.536584  + cd /lava-1173020<8>[   16.868618] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11730201_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
