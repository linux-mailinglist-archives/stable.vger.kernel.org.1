Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC6970715E
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjEQS4u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjEQS4t (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 14:56:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1211738
        for <stable@vger.kernel.org>; Wed, 17 May 2023 11:56:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso269133a12.1
        for <stable@vger.kernel.org>; Wed, 17 May 2023 11:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684349805; x=1686941805;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B9PMP+J1O5Nl9WoDqKlVPQImGKAbW3IMiQpVPdwVz8Q=;
        b=hQ579R4yCPJqcJx9RB/Dw+cXPKOUYgw4VlO3oojIHnuc5qk27yYACrQKovdoNo67t7
         yMBzuo1uTgaz1Hc6GwpsgmOGgnYAPUss0XfWcptKtKN1N1FsbeWP5nblJ5dnSBFcHl4M
         yfgQHxqylL+unUAHdrjx/slPT4u8iGaEY1uAJr0P4Ok+rg1qSPOlH1OlGDnSCBBRHYiZ
         MKV0fNHBnkXT9NOAPbzmx+s8hIWEo6UMBYsB8GFlhC+xRAh6cSIOmeVkDXyWm6odjmct
         99TNbJ7wUvmDTUIIsMpJlnAmm//K09PQeQdRwhdgaXZ/w0jUDvMmX5w1AEljPog4/WFd
         YmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684349805; x=1686941805;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9PMP+J1O5Nl9WoDqKlVPQImGKAbW3IMiQpVPdwVz8Q=;
        b=Xdew8Qtj8B1bPuTZbFbMjI57qBjIyDmY1MRmDz6zSwhcqSB5hrnpEaIhakMa7riEZZ
         X2Y1IQJ3HARGg0P+cj0FFCMvAUF39/s0XHsMB2ixXY6359E6+wrxU0NEGHw3rFgVloBR
         44C3kvCjuY/NNDBgtDMkz5YlD5HFdP2yC2znTwZc08GNpDMJismxmjFotbmd3BCB547S
         W422e7gMyZkmwGBYpqfLObzqnn7djj2C4ocBypeNIfe5+9nalEkG4V6tBAKtHQIO3Oly
         kLA6ycP1Eu3DGM7M2sfAAEKljj03l+Y1olks9SGObebys3WjqCPZMeAwPacfTXXbA4e9
         sciA==
X-Gm-Message-State: AC+VfDwSvw0XNfyAiqdqIK3NVMlx4rwOH9aOUhn7QYu5jmn7WJzv6wCU
        ALzyACCpcTIuQeN8+boYsuCDAz6tYsfLk3WowaOywA==
X-Google-Smtp-Source: ACHHUZ4SDgIIAJE2lb+oxfd4a9CB+XYv/ICwl5cGfG61oo18VHMgWoU6lqAEhrswzROS7K12WNYzPg==
X-Received: by 2002:a17:902:9a85:b0:1a9:6a10:70e9 with SMTP id w5-20020a1709029a8500b001a96a1070e9mr2714323plp.33.1684349804911;
        Wed, 17 May 2023 11:56:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001ac896ff667sm17897703plh.204.2023.05.17.11.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:56:44 -0700 (PDT)
Message-ID: <6465236c.170a0220.97830.38f2@mx.google.com>
Date:   Wed, 17 May 2023 11:56:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 149 runs, 12 regressions (v5.15.112)
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

stable-rc/linux-5.15.y baseline: 149 runs, 12 regressions (v5.15.112)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.112/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.112
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9d6bde853685609a631871d7c12be94fdf8d912e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464ecb9c174b5cbd42e862a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464ecb9c174b5cbd42e862f
        failing since 49 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-17T15:02:58.431705  <8>[   10.348502] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10357054_1.4.2.3.1>

    2023-05-17T15:02:58.435011  + set +x

    2023-05-17T15:02:58.541322  / # #

    2023-05-17T15:02:58.643623  export SHELL=3D/bin/sh

    2023-05-17T15:02:58.644332  #

    2023-05-17T15:02:58.745827  / # export SHELL=3D/bin/sh. /lava-10357054/=
environment

    2023-05-17T15:02:58.746894  =


    2023-05-17T15:02:58.848771  / # . /lava-10357054/environment/lava-10357=
054/bin/lava-test-runner /lava-10357054/1

    2023-05-17T15:02:58.850015  =


    2023-05-17T15:02:58.855847  / # /lava-10357054/bin/lava-test-runner /la=
va-10357054/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464ec8de078d6b4d72e8613

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464ec8de078d6b4d72e8618
        failing since 49 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-17T15:02:18.523248  + set<8>[   11.613873] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10357074_1.4.2.3.1>

    2023-05-17T15:02:18.523332   +x

    2023-05-17T15:02:18.627429  / # #

    2023-05-17T15:02:18.727994  export SHELL=3D/bin/sh

    2023-05-17T15:02:18.728158  #

    2023-05-17T15:02:18.828662  / # export SHELL=3D/bin/sh. /lava-10357074/=
environment

    2023-05-17T15:02:18.828848  =


    2023-05-17T15:02:18.929408  / # . /lava-10357074/environment/lava-10357=
074/bin/lava-test-runner /lava-10357074/1

    2023-05-17T15:02:18.929637  =


    2023-05-17T15:02:18.934046  / # /lava-10357074/bin/lava-test-runner /la=
va-10357074/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464ec96942f5b78d72e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464ec96942f5b78d72e8607
        failing since 49 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-17T15:02:23.298410  <8>[    8.608506] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10357079_1.4.2.3.1>

    2023-05-17T15:02:23.301875  + set +x

    2023-05-17T15:02:23.403132  #

    2023-05-17T15:02:23.403457  =


    2023-05-17T15:02:23.504093  / # #export SHELL=3D/bin/sh

    2023-05-17T15:02:23.504286  =


    2023-05-17T15:02:23.604819  / # export SHELL=3D/bin/sh. /lava-10357079/=
environment

    2023-05-17T15:02:23.605012  =


    2023-05-17T15:02:23.705591  / # . /lava-10357079/environment/lava-10357=
079/bin/lava-test-runner /lava-10357079/1

    2023-05-17T15:02:23.705929  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464ec85942f5b78d72e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464ec85942f5b78d72e85ec
        failing since 49 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-17T15:02:17.143730  + set +x

    2023-05-17T15:02:17.150520  <8>[    9.954620] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10357041_1.4.2.3.1>

    2023-05-17T15:02:17.254702  / # #

    2023-05-17T15:02:17.355316  export SHELL=3D/bin/sh

    2023-05-17T15:02:17.355506  #

    2023-05-17T15:02:17.456024  / # export SHELL=3D/bin/sh. /lava-10357041/=
environment

    2023-05-17T15:02:17.456217  =


    2023-05-17T15:02:17.556733  / # . /lava-10357041/environment/lava-10357=
041/bin/lava-test-runner /lava-10357041/1

    2023-05-17T15:02:17.557034  =


    2023-05-17T15:02:17.561571  / # /lava-10357041/bin/lava-test-runner /la=
va-10357041/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464ec7e28584c5d6e2e8616

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464ec7e28584c5d6e2e861b
        failing since 49 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-17T15:02:07.285613  + set +x

    2023-05-17T15:02:07.292291  <8>[   11.023635] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10357077_1.4.2.3.1>

    2023-05-17T15:02:07.397037  / # #

    2023-05-17T15:02:07.497983  export SHELL=3D/bin/sh

    2023-05-17T15:02:07.498300  #

    2023-05-17T15:02:07.598959  / # export SHELL=3D/bin/sh. /lava-10357077/=
environment

    2023-05-17T15:02:07.599313  =


    2023-05-17T15:02:07.699998  / # . /lava-10357077/environment/lava-10357=
077/bin/lava-test-runner /lava-10357077/1

    2023-05-17T15:02:07.700545  =


    2023-05-17T15:02:07.705496  / # /lava-10357077/bin/lava-test-runner /la=
va-10357077/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464ec94e078d6b4d72e8650

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464ec94e078d6b4d72e8655
        failing since 49 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-17T15:02:23.943045  + set<8>[   10.854828] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10357086_1.4.2.3.1>

    2023-05-17T15:02:23.943148   +x

    2023-05-17T15:02:24.047423  / # #

    2023-05-17T15:02:24.148142  export SHELL=3D/bin/sh

    2023-05-17T15:02:24.148325  #

    2023-05-17T15:02:24.248841  / # export SHELL=3D/bin/sh. /lava-10357086/=
environment

    2023-05-17T15:02:24.249081  =


    2023-05-17T15:02:24.349727  / # . /lava-10357086/environment/lava-10357=
086/bin/lava-test-runner /lava-10357086/1

    2023-05-17T15:02:24.350006  =


    2023-05-17T15:02:24.354724  / # /lava-10357086/bin/lava-test-runner /la=
va-10357086/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464eca1914ad9fb862e860b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464eca1914ad9fb862e8610
        failing since 49 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-17T15:02:38.296944  <8>[   11.924399] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10357110_1.4.2.3.1>

    2023-05-17T15:02:38.401817  / # #

    2023-05-17T15:02:38.502647  export SHELL=3D/bin/sh

    2023-05-17T15:02:38.502900  #

    2023-05-17T15:02:38.603466  / # export SHELL=3D/bin/sh. /lava-10357110/=
environment

    2023-05-17T15:02:38.603711  =


    2023-05-17T15:02:38.704364  / # . /lava-10357110/environment/lava-10357=
110/bin/lava-test-runner /lava-10357110/1

    2023-05-17T15:02:38.704710  =


    2023-05-17T15:02:38.709548  / # /lava-10357110/bin/lava-test-runner /la=
va-10357110/1

    2023-05-17T15:02:38.714798  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6464f25ca17bf196372e861d

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-ku=
kui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-ku=
kui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6464f25ca17bf196372e862a
        failing since 2 days (last pass: v5.15.110, first fail: v5.15.111-1=
30-g93ae50a86a5dd)

    2023-05-17T15:27:05.957163  /lava-10357518/1/../bin/lava-test-case

    2023-05-17T15:27:05.963928  <8>[   60.545969] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464f25ca17bf196372e86b2
        failing since 2 days (last pass: v5.15.110, first fail: v5.15.111-1=
30-g93ae50a86a5dd)

    2023-05-17T15:26:51.792719  <8>[   46.377738] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10357518_1.5.2.3.1>

    2023-05-17T15:26:51.796048  + set +x

    2023-05-17T15:26:51.900655  / # #

    2023-05-17T15:26:52.001613  export SHELL=3D/bin/sh

    2023-05-17T15:26:52.001950  #

    2023-05-17T15:26:52.102617  / # export SHELL=3D/bin/sh. /lava-10357518/=
environment

    2023-05-17T15:26:52.102957  =


    2023-05-17T15:26:52.203640  / # . /lava-10357518/environment/lava-10357=
518/bin/lava-test-runner /lava-10357518/1

    2023-05-17T15:26:52.204133  =


    2023-05-17T15:26:52.208735  / # /lava-10357518/bin/lava-test-runner /la=
va-10357518/1
 =

    ... (13 line(s) more)  =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6464f25ca17bf196372e86c1
        failing since 2 days (last pass: v5.15.110, first fail: v5.15.111-1=
30-g93ae50a86a5dd)

    2023-05-17T15:27:06.998585  /lava-10357518/1/../bin/lava-test-case

    2023-05-17T15:27:07.005138  <8>[   61.586962] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6464f25ca17bf196372e86c1
        failing since 2 days (last pass: v5.15.110, first fail: v5.15.111-1=
30-g93ae50a86a5dd)

    2023-05-17T15:27:06.998585  /lava-10357518/1/../bin/lava-test-case

    2023-05-17T15:27:07.005138  <8>[   61.586962] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6464ef3a9a72c3fd102e85ec

  Results:     65 PASS, 5 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
6464ef3a9a72c3fd102e8629
        new failure (last pass: v5.15.111-135-g070cc2c270b1)

    2023-05-17T15:13:54.934764  /lava-10357350/1/../bin/lava-test-case
   =

 =20
