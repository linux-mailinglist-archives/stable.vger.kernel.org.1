Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CFF72CA9C
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjFLPsG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjFLPsF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 11:48:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2C8CA
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 08:48:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-655d1fc8ad8so3698227b3a.1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 08:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686584883; x=1689176883;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nQipBEhDHAy8kObfIQ7kDMQIe8ArlQ9p+9BhvkTdA20=;
        b=VtIBMDzqFpWCAMAMp7039U4Yzw3gKLqMM9jlQCAr7EL3OEkExoBy9y9KUkZLL0R9kx
         yYoTPhuzJuRTt+JU/Iei03MpVxHnzkKlKXYzuvFvjf8TVqKfSvJ9dwuP1IWLZjqdEN1z
         D9ULf281bKG0kNll0by0hfWHAX1TKvWce1LM+yqGiDM3L96SOSEOTy81vgeSFztjJWfn
         Y1uL4kTqCJ0EZWRbPf+dqKrGhjrNbDqBxx7iXeMCRm3a7D9v+uLxUU7QsC2c94JIF1Nf
         UpqHaxhy4lWD1A0X2HF9VkZvB3WURpwWNhdIe7NnBe0W34zvnv5e8WoTqJUbqYPSMGHU
         pdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686584883; x=1689176883;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQipBEhDHAy8kObfIQ7kDMQIe8ArlQ9p+9BhvkTdA20=;
        b=AJdn7a3BdlcCUd9aDYXNtSmvo+dEEkR97zXJgIxN7JGat7asaJWAv9Pa3p+G40D7NY
         v4JtXVXNdPw422qo1W4FsHRLOhem/pX7S++0B7tqG7sFARCpZC2/fbhT+8hfyx/SKDfc
         G3zcWw3BlNjaYtWXCvpYbuZV51lQzrqiYojcX3qkQi5mbB0plSi5Vr2LEj1F54+N/mDq
         +J/XUrz2WKG65/+vK3NNqPuyo4YAyGZ6K8E+b21ZTXBqZjSxXVwjQMLAMsslYypY7eBS
         rfqNx5phUG+jgq5V8XcBTM2cLT9y9gII1E97dZrbaPr0p6YA0AD/CwbTXpXtRgVCYkXY
         Kl4g==
X-Gm-Message-State: AC+VfDxTfG+sdJawV7IL9LIxYwuO/aBgJDtMDuJYpskKRXPUVgJZQfre
        pMNdSkiIg9bWOe48uDtmEOFHK4lBcWHNyS/fP9kloA==
X-Google-Smtp-Source: ACHHUZ4yhghbHR8BGqdcrfTg47mKF/h7M2yEdTvvpaGsZCW26mUubB7DLBad5Vxmk6hK3zY0GUS4hA==
X-Received: by 2002:a05:6a20:1442:b0:114:28dc:2d94 with SMTP id a2-20020a056a20144200b0011428dc2d94mr11176018pzi.25.1686584883406;
        Mon, 12 Jun 2023 08:48:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r201-20020a632bd2000000b0054a8200ac4bsm5152624pgr.89.2023.06.12.08.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:48:02 -0700 (PDT)
Message-ID: <64873e32.630a0220.b0b10.9b29@mx.google.com>
Date:   Mon, 12 Jun 2023 08:48:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.7-161-g718be3905b8f1
Subject: stable-rc/linux-6.3.y baseline: 180 runs,
 4 regressions (v6.3.7-161-g718be3905b8f1)
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

stable-rc/linux-6.3.y baseline: 180 runs, 4 regressions (v6.3.7-161-g718be3=
905b8f1)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.7-161-g718be3905b8f1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.7-161-g718be3905b8f1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      718be3905b8f1b4c3ef58c6b82bba0bb167f5da8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64870f447b8ceb7941306209

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
61-g718be3905b8f1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
61-g718be3905b8f1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64870f447b8ceb7941306=
20a
        new failure (last pass: v6.3.7-153-g1fda3156534da) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6487096ea7847e5a15306184

  Results:     18 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
61-g718be3905b8f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
61-g718be3905b8f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.tpm-chip-is-online: https://kernelci.org/test/case/id/6=
487096ea7847e5a15306193
        new failure (last pass: v6.3.7-153-g1fda3156534da)

    2023-06-12T12:02:30.128819  /usr/bin/tpm2_getcap

    2023-06-12T12:02:40.337726  /lava-10689260/1/../bin/lava-test-case

    2023-06-12T12:02:40.344603  <8>[   21.297194] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64870e187cb45221fb3061e3

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
61-g718be3905b8f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
61-g718be3905b8f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64870e187cb45221fb3061ed
        new failure (last pass: v6.3.7-153-g1fda3156534da)

    2023-06-12T12:22:53.100812  /lava-10689737/1/../bin/lava-test-case

    2023-06-12T12:22:53.110416  <8>[   26.491892] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/648709825af2b82cce30616e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
61-g718be3905b8f1/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
61-g718be3905b8f1/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648709825af2b82cce306=
16f
        new failure (last pass: v6.3.7-153-g1fda3156534da) =

 =20
