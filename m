Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016147C48B3
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 06:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbjJKEJd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 00:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbjJKEJd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 00:09:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815448F
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 21:09:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27cefb5ae1fso943816a91.3
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 21:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696997367; x=1697602167; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i2pFhkonJGFlEPDVRv3d3PyfZf59ThnrhprE7eOj9tA=;
        b=B0NyFWrv+4pud+oDkUmhe/h8iq4lynRMkMWvi5MPd7Sa1mmaZUnXqU0VXY+iaOpkuS
         +pSj5+BAmgLGegnxBuCjNVxeBDNnoWa5i2GKbYvVQZV1oSzms0004N6VvFE1bUuP3Jz0
         +tyT8OuU9yFY+1iBmihpm2rXO7zCpoBeznbe11Wk2fdyzqyhR2lqtPyVIN9Ro5fib6qh
         tnLsgW+Vv64sw56V0LUNObX2OdZ05hlOF8kcB2S+n4EmSETfNDWMgaUDAt65eODm5WaT
         p54YeeNV8/YSteCM7+Ae+pURj4VUk7dpaBRlQXlVJDhSH33m+n7aAEmMDF1C4VpL2wfA
         VOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696997367; x=1697602167;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2pFhkonJGFlEPDVRv3d3PyfZf59ThnrhprE7eOj9tA=;
        b=aROczxpJNQJndNGtnEcOYOlV1sSlf//GGXgxMAexnGhyIMk1Ywj5x1P/J+2kh3sJbZ
         ESY6gCcSTqnGmaI3AtAiME0Gx37CK5UQ31mXodHp6qi8B3pnHJoo3Ak6zH0aTNILpu2G
         GlxIkszWahYBKlMAZK5Cj2HTMHFuQXclHbjvKACpAAZbVq5MlRRYKYgZdzmdhZ2GIFpt
         c0+vfm5CseW9OIUzaLyxlt+1i+A0E80uXzQudbhNdT5q3brSS3Vc3EZWtElGBV3ISAn8
         s+uVsnMHgLmQx0ZP+tRtPDleE8JSly0nAj86D/9nCSPcji7B3GxZd/tFsjOuRFyQCkjS
         oFEA==
X-Gm-Message-State: AOJu0Yzy2vhWcbF6E5MKxGYV/WI2ScvNhQhFyPRs3iLK00E2KYMyDxtx
        wIHaOPjJD1g5wrDZT/zAJ3PlwMyE6b+DE1Js+kRRqA==
X-Google-Smtp-Source: AGHT+IGIWq43RpIhutQ87RXen04kzKexJQ30AFxazKnVAgkfHWfu339Bbj+MYNpR+g5J7bhz+/0WkQ==
X-Received: by 2002:a17:90b:1a8c:b0:271:9237:a07f with SMTP id ng12-20020a17090b1a8c00b002719237a07fmr18410178pjb.32.1696997367084;
        Tue, 10 Oct 2023 21:09:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090a0c8500b00256b67208b1sm13926180pja.56.2023.10.10.21.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 21:09:26 -0700 (PDT)
Message-ID: <65261ff6.170a0220.1eb44.9909@mx.google.com>
Date:   Tue, 10 Oct 2023 21:09:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.57
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 126 runs, 29 regressions (v6.1.57)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 126 runs, 29 regressions (v6.1.57)

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

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm-vexpress-a15        | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =

qemu_arm-vexpress-a9         | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =

qemu_i386-uefi               | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =

qemu_riscv64                 | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_smp8_riscv64            | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.57/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.57
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      082280fe94a09462c727fb6e7b0c982efb36dede =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e8aaf96df3571befcfac

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525e8aaf96df3571befcfb5
        failing since 194 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-11T00:13:16.810072  <8>[    9.932820] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11732223_1.4.2.3.1>

    2023-10-11T00:13:16.813415  + set +x

    2023-10-11T00:13:16.918564  / #

    2023-10-11T00:13:17.021384  # #export SHELL=3D/bin/sh

    2023-10-11T00:13:17.022214  =


    2023-10-11T00:13:17.123877  / # export SHELL=3D/bin/sh. /lava-11732223/=
environment

    2023-10-11T00:13:17.124709  =


    2023-10-11T00:13:17.226371  / # . /lava-11732223/environment/lava-11732=
223/bin/lava-test-runner /lava-11732223/1

    2023-10-11T00:13:17.227835  =


    2023-10-11T00:13:17.232798  / # /lava-11732223/bin/lava-test-runner /la=
va-11732223/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e8b6f96df3571befcfef

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525e8b6f96df3571befcff8
        failing since 194 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-11T00:13:47.132249  + set<8>[   11.455052] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11732237_1.4.2.3.1>

    2023-10-11T00:13:47.132734   +x

    2023-10-11T00:13:47.240326  / # #

    2023-10-11T00:13:47.342584  export SHELL=3D/bin/sh

    2023-10-11T00:13:47.343402  #

    2023-10-11T00:13:47.445003  / # export SHELL=3D/bin/sh. /lava-11732237/=
environment

    2023-10-11T00:13:47.445746  =


    2023-10-11T00:13:47.547143  / # . /lava-11732237/environment/lava-11732=
237/bin/lava-test-runner /lava-11732237/1

    2023-10-11T00:13:47.547504  =


    2023-10-11T00:13:47.552989  / # /lava-11732237/bin/lava-test-runner /la=
va-11732237/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e8bb29f91f79f0efcef3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525e8bb29f91f79f0efcefc
        failing since 194 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-11T00:13:23.529332  <8>[   10.668822] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11732236_1.4.2.3.1>

    2023-10-11T00:13:23.532393  + set +x

    2023-10-11T00:13:23.633714  =


    2023-10-11T00:13:23.734251  / # #export SHELL=3D/bin/sh

    2023-10-11T00:13:23.734428  =


    2023-10-11T00:13:23.834879  / # export SHELL=3D/bin/sh. /lava-11732236/=
environment

    2023-10-11T00:13:23.835043  =


    2023-10-11T00:13:23.935519  / # . /lava-11732236/environment/lava-11732=
236/bin/lava-test-runner /lava-11732236/1

    2023-10-11T00:13:23.935776  =


    2023-10-11T00:13:23.940667  / # /lava-11732236/bin/lava-test-runner /la=
va-11732236/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ea18ffaae51649efcf56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525ea18ffaae51649efc=
f57
        failing since 125 days (last pass: v6.1.31-40-g7d0a9678d276, first =
fail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e8951fef0e5e81efcf40

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525e8951fef0e5e81efcf49
        failing since 194 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-11T00:13:22.769326  + set +x

    2023-10-11T00:13:22.775928  <8>[   11.003447] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11732246_1.4.2.3.1>

    2023-10-11T00:13:22.880661  / # #

    2023-10-11T00:13:22.981254  export SHELL=3D/bin/sh

    2023-10-11T00:13:22.981451  #

    2023-10-11T00:13:23.081997  / # export SHELL=3D/bin/sh. /lava-11732246/=
environment

    2023-10-11T00:13:23.082211  =


    2023-10-11T00:13:23.182781  / # . /lava-11732246/environment/lava-11732=
246/bin/lava-test-runner /lava-11732246/1

    2023-10-11T00:13:23.183102  =


    2023-10-11T00:13:23.187664  / # /lava-11732246/bin/lava-test-runner /la=
va-11732246/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e8aaf96df3571befcfa1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525e8aaf96df3571befcfaa
        failing since 194 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-11T00:13:31.155384  + set +x<8>[   10.587416] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11732229_1.4.2.3.1>

    2023-10-11T00:13:31.155476  =


    2023-10-11T00:13:31.259705  / # #

    2023-10-11T00:13:31.360352  export SHELL=3D/bin/sh

    2023-10-11T00:13:31.360550  #

    2023-10-11T00:13:31.461045  / # export SHELL=3D/bin/sh. /lava-11732229/=
environment

    2023-10-11T00:13:31.461245  =


    2023-10-11T00:13:31.561772  / # . /lava-11732229/environment/lava-11732=
229/bin/lava-test-runner /lava-11732229/1

    2023-10-11T00:13:31.562058  =


    2023-10-11T00:13:31.566901  / # /lava-11732229/bin/lava-test-runner /la=
va-11732229/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e8951fef0e5e81efcf34

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525e8951fef0e5e81efcf3d
        failing since 194 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-11T00:12:54.557969  + set +x<8>[   11.843690] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11732241_1.4.2.3.1>

    2023-10-11T00:12:54.558364  =


    2023-10-11T00:12:54.665726  / # #

    2023-10-11T00:12:54.766889  export SHELL=3D/bin/sh

    2023-10-11T00:12:54.767526  #

    2023-10-11T00:12:54.868606  / # export SHELL=3D/bin/sh. /lava-11732241/=
environment

    2023-10-11T00:12:54.868809  =


    2023-10-11T00:12:54.969297  / # . /lava-11732241/environment/lava-11732=
241/bin/lava-test-runner /lava-11732241/1

    2023-10-11T00:12:54.969606  =


    2023-10-11T00:12:54.974091  / # /lava-11732241/bin/lava-test-runner /la=
va-11732241/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-vexpress-a15        | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e743aafff610b2efcf63

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a15.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a15.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e743aafff610b2efc=
f64
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-vexpress-a9         | arm    | lab-baylibre  | gcc-10   | vexpress=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e744a12575d75aefcf78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: vexpress_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a9.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm/vexpress_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-vexpress-a9.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e744a12575d75aefc=
f79
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525eb06715c852981efd000

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525eb06715c852981efd=
001
        failing since 6 days (last pass: v6.1.38-590-gce7ec1011187, first f=
ail: v6.1.55-260-g0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525eb2e2ab962bbfbefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525eb2e2ab962bbfbefc=
ef4
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525eb079a4434f601efcff8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525eb079a4434f601efc=
ff9
        failing since 6 days (last pass: v6.1.38-590-gce7ec1011187, first f=
ail: v6.1.55-260-g0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525eb192dabd4cdcaefcefd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525eb192dabd4cdcaefc=
efe
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525eb182dabd4cdcaefcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525eb182dabd4cdcaefc=
efa
        failing since 6 days (last pass: v6.1.38-590-gce7ec1011187, first f=
ail: v6.1.55-260-g0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525eb2ca509d83f85efcf17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525eb2ca509d83f85efc=
f18
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525eb059a4434f601efcff2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525eb059a4434f601efc=
ff3
        failing since 6 days (last pass: v6.1.38-590-gce7ec1011187, first f=
ail: v6.1.55-260-g0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525eb2d2dabd4cdcaefcf23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525eb2d2dabd4cdcaefc=
f24
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386                    | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e6a55bdd2766ffefd037

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e6a55bdd2766ffefd=
038
        failing since 6 days (last pass: v6.1.39-224-ge54fe15e179b, first f=
ail: v6.1.55-260-g0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386-uefi               | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e6a4d7a3dd0adeefcf17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e6a4d7a3dd0adeefc=
f18
        failing since 6 days (last pass: v6.1.39-224-ge54fe15e179b, first f=
ail: v6.1.55-260-g0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_riscv64                 | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e8bf7d937379e8efcf0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e8bf7d937379e8efc=
f0f
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_smp8_riscv64            | riscv  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e8c07d937379e8efcf1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e8c07d937379e8efc=
f20
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e86fd7a5f8fc6fefd024

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e86fd7a5f8fc6fefd=
025
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e873967a3e18bcefcf3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e873967a3e18bcefc=
f40
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e870d7a5f8fc6fefd027

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e870d7a5f8fc6fefd=
028
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e8749a808f3cd6efcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e8749a808f3cd6efc=
f01
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e871967a3e18bcefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e871967a3e18bcefc=
ef4
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6525e872967a3e18bcefcf31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi-mixed=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi-mixed=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525e872967a3e18bcefc=
f32
        failing since 6 days (last pass: v6.1.39, first fail: v6.1.55-260-g=
0353a7bfd2b60) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525eb39de0e1bac32efcf07

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525eb39de0e1bac32efcf10
        new failure (last pass: v6.1.22-178-gf8a7fa4a96bb)

    2023-10-11T00:24:13.074929  / # #
    2023-10-11T00:24:13.176623  export SHELL=3D/bin/sh
    2023-10-11T00:24:13.177210  #
    2023-10-11T00:24:13.278286  / # export SHELL=3D/bin/sh. /lava-437997/en=
vironment
    2023-10-11T00:24:13.279078  =

    2023-10-11T00:24:13.380418  / # . /lava-437997/environment/lava-437997/=
bin/lava-test-runner /lava-437997/1
    2023-10-11T00:24:13.381586  =

    2023-10-11T00:24:13.399014  / # /lava-437997/bin/lava-test-runner /lava=
-437997/1
    2023-10-11T00:24:13.463018  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-11T00:24:13.463636  + cd /lava-437997/<8>[   18.564780] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 437997_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525eb492ab962bbfbefd00a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.57/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525eb492ab962bbfbefd013
        new failure (last pass: v6.1.22-178-gf8a7fa4a96bb)

    2023-10-11T00:28:53.277211  / # #

    2023-10-11T00:28:53.379278  export SHELL=3D/bin/sh

    2023-10-11T00:28:53.380019  #

    2023-10-11T00:28:53.481410  / # export SHELL=3D/bin/sh. /lava-11732362/=
environment

    2023-10-11T00:28:53.482116  =


    2023-10-11T00:28:53.583531  / # . /lava-11732362/environment/lava-11732=
362/bin/lava-test-runner /lava-11732362/1

    2023-10-11T00:28:53.584866  =


    2023-10-11T00:28:53.586170  / # /lava-11732362/bin/lava-test-runner /la=
va-11732362/1

    2023-10-11T00:28:53.668370  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-11T00:28:53.668871  + cd /lava-11732362/1/tests/1_boot<8>[   17=
.037479] <LAVA_SIGNAL_STARTRUN 1_bootrr 11732362_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
