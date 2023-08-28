Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366FB78B334
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjH1OdY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 10:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjH1Ocx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 10:32:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E801AC9
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 07:32:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc3d94d40fso25103215ad.3
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693233169; x=1693837969;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VK61aDzQxE3uH7/a615ry55gYueKVrr19KIz8HovbAs=;
        b=xwbR08FshkFpoWKxiTWPcaFa75PeKpMmp9SSu3qRFX4xQ8ZLflt4QQ+o69RsCoAn8W
         STeSVQaVB2M6QnmRqiTZJAGyXMdSATZHR+x5+61jyKK7ZnZpjbH/oo208BvJC+5fmboI
         I6leX407ESDtlN78br8UKzJUxJSGhMmxCxIz1wX0nrYToDA1thL8ymJEMNYNjWl4jESl
         4s+69T6JB6SGu/EVFde7XqJwDzC/mNB6AFJ7yPSnhiOo3cEfNk7ROR6vJYDZB6Ep2w/p
         Ppg1TunJ9F/7u7fLw7EP7LzD7HViWxFhoEW2VCjDH6PnhceWKvmWbio3AEv/yFUQR11z
         cBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693233169; x=1693837969;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VK61aDzQxE3uH7/a615ry55gYueKVrr19KIz8HovbAs=;
        b=eJ51qShzaw67Ggo44ctwlBEypcjrWAjgoV6t+WIedN458g2xPay0k99CcIPsAhq7Xw
         DHZYdeibC+9z3OI4p1qzmiJd5icDZXm6I5wDqEDwaS6ItCOb7ldSvqiEJdD7jjtrcZZP
         e1M+5cBUdsCGvCWEchhWzbKQaGl3pUiI6q5W3M1p+ZwmftsvSSnBpPkCDFI4aDe/gvQN
         XKSnso3BJ+fZToFXlGjitBhWGLIERdqPcDiV1/+IahyhRIRmBxyE/mRg+ZbNiVnxuApZ
         1bTcXYWIC0XbehecinCRWxKhMQcQN9j6UmARZj6Ukoln25Ykrj8wdI+UOHzSsPC9Pu7e
         vDPA==
X-Gm-Message-State: AOJu0YyfKOu3IAgQnCUy/nBx0alw/MbPxFL0xDLvx2wMOOGaKDQhSfOP
        9Gvg/4QHmSs9oYnzq8DIwm4xkbqg/mCoCCJU/NM=
X-Google-Smtp-Source: AGHT+IGE67o+WXbzWbVRw4n1g1ztJ8XS6K89GwbgfRsmE/JGVkd9bPv1r1Xp19I7w4gY2O1pi+mf0Q==
X-Received: by 2002:a17:902:f94e:b0:1c0:e014:90c1 with SMTP id kx14-20020a170902f94e00b001c0e01490c1mr7607307plb.48.1693233168804;
        Mon, 28 Aug 2023 07:32:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jd14-20020a170903260e00b001b03a1a3151sm7418541plb.70.2023.08.28.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:32:48 -0700 (PDT)
Message-ID: <64ecb010.170a0220.caa35.b5a2@mx.google.com>
Date:   Mon, 28 Aug 2023 07:32:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.48-128-g1aa86af84d82
Subject: stable-rc/linux-6.1.y baseline: 128 runs,
 9 regressions (v6.1.48-128-g1aa86af84d82)
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

stable-rc/linux-6.1.y baseline: 128 runs, 9 regressions (v6.1.48-128-g1aa86=
af84d82)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-CM1400CXA-dalboz     | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.48-128-g1aa86af84d82/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.48-128-g1aa86af84d82
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1aa86af84d82ad518de80697bddd58a9df5dee09 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7b2c006961fad4286dac

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7b2c006961fad4286db5
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T10:46:53.060030  <8>[   10.873740] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11371179_1.4.2.3.1>

    2023-08-28T10:46:53.063108  + set +x

    2023-08-28T10:46:53.167480  / # #

    2023-08-28T10:46:53.268054  export SHELL=3D/bin/sh

    2023-08-28T10:46:53.268214  #

    2023-08-28T10:46:53.368756  / # export SHELL=3D/bin/sh. /lava-11371179/=
environment

    2023-08-28T10:46:53.368944  =


    2023-08-28T10:46:53.469468  / # . /lava-11371179/environment/lava-11371=
179/bin/lava-test-runner /lava-11371179/1

    2023-08-28T10:46:53.469779  =


    2023-08-28T10:46:53.474496  / # /lava-11371179/bin/lava-test-runner /la=
va-11371179/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-CM1400CXA-dalboz     | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7b1b006961fad4286d98

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7b1b006961fad4286da1
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T10:46:45.108311  + <8>[    9.495281] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11371175_1.4.2.3.1>

    2023-08-28T10:46:45.108743  set +x

    2023-08-28T10:46:45.215880  / # #

    2023-08-28T10:46:45.318179  export SHELL=3D/bin/sh

    2023-08-28T10:46:45.318945  #

    2023-08-28T10:46:45.420353  / # export SHELL=3D/bin/sh. /lava-11371175/=
environment

    2023-08-28T10:46:45.421110  =


    2023-08-28T10:46:45.522586  / # . /lava-11371175/environment/lava-11371=
175/bin/lava-test-runner /lava-11371175/1

    2023-08-28T10:46:45.523861  =


    2023-08-28T10:46:45.528937  / # /lava-11371175/bin/lava-test-runner /la=
va-11371175/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7b2d6cfeab8a64286d98

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7b2d6cfeab8a64286da1
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T10:46:49.355077  <8>[   10.668001] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11371165_1.4.2.3.1>

    2023-08-28T10:46:49.358307  + set +x

    2023-08-28T10:46:49.463205  #

    2023-08-28T10:46:49.464453  =


    2023-08-28T10:46:49.566180  / # #export SHELL=3D/bin/sh

    2023-08-28T10:46:49.566798  =


    2023-08-28T10:46:49.668271  / # export SHELL=3D/bin/sh. /lava-11371165/=
environment

    2023-08-28T10:46:49.668892  =


    2023-08-28T10:46:49.770388  / # . /lava-11371165/environment/lava-11371=
165/bin/lava-test-runner /lava-11371165/1

    2023-08-28T10:46:49.771492  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7ce0e01cd6f171286d87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ec7ce0e01cd6f171286=
d88
        failing since 81 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7b259379c57bd2286d97

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7b259379c57bd2286da0
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T10:46:44.351174  + <8>[   11.480253] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11371199_1.4.2.3.1>

    2023-08-28T10:46:44.351361  set +x

    2023-08-28T10:46:44.456268  / # #

    2023-08-28T10:46:44.557921  export SHELL=3D/bin/sh

    2023-08-28T10:46:44.558644  #

    2023-08-28T10:46:44.660130  / # export SHELL=3D/bin/sh. /lava-11371199/=
environment

    2023-08-28T10:46:44.660892  =


    2023-08-28T10:46:44.762330  / # . /lava-11371199/environment/lava-11371=
199/bin/lava-test-runner /lava-11371199/1

    2023-08-28T10:46:44.763526  =


    2023-08-28T10:46:44.768885  / # /lava-11371199/bin/lava-test-runner /la=
va-11371199/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7b35e0f526784c286d6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7b35e0f526784c286d73
        failing since 150 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-28T10:46:59.170414  + set<8>[   10.943064] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11371185_1.4.2.3.1>

    2023-08-28T10:46:59.170500   +x

    2023-08-28T10:46:59.274740  / # #

    2023-08-28T10:46:59.375426  export SHELL=3D/bin/sh

    2023-08-28T10:46:59.375610  #

    2023-08-28T10:46:59.476136  / # export SHELL=3D/bin/sh. /lava-11371185/=
environment

    2023-08-28T10:46:59.476319  =


    2023-08-28T10:46:59.576853  / # . /lava-11371185/environment/lava-11371=
185/bin/lava-test-runner /lava-11371185/1

    2023-08-28T10:46:59.577145  =


    2023-08-28T10:46:59.581932  / # /lava-11371185/bin/lava-test-runner /la=
va-11371185/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec9595cfaadd627b286d74

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec9595cfaadd627b286d7d
        failing since 41 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-28T12:41:09.193079  / # #

    2023-08-28T12:41:09.295277  export SHELL=3D/bin/sh

    2023-08-28T12:41:09.296032  #

    2023-08-28T12:41:09.397476  / # export SHELL=3D/bin/sh. /lava-11371390/=
environment

    2023-08-28T12:41:09.398219  =


    2023-08-28T12:41:09.499687  / # . /lava-11371390/environment/lava-11371=
390/bin/lava-test-runner /lava-11371390/1

    2023-08-28T12:41:09.500848  =


    2023-08-28T12:41:09.517274  / # /lava-11371390/bin/lava-test-runner /la=
va-11371390/1

    2023-08-28T12:41:09.565773  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T12:41:09.566287  + cd /lav<8>[   19.113953] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11371390_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7f4ab21ae9abd4286ee5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7f4ab21ae9abd4286eea
        failing since 41 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-28T11:04:28.104465  / # #

    2023-08-28T11:04:29.183794  export SHELL=3D/bin/sh

    2023-08-28T11:04:29.185607  #

    2023-08-28T11:04:30.675417  / # export SHELL=3D/bin/sh. /lava-11371401/=
environment

    2023-08-28T11:04:30.677259  =


    2023-08-28T11:04:33.400789  / # . /lava-11371401/environment/lava-11371=
401/bin/lava-test-runner /lava-11371401/1

    2023-08-28T11:04:33.403215  =


    2023-08-28T11:04:33.411991  / # /lava-11371401/bin/lava-test-runner /la=
va-11371401/1

    2023-08-28T11:04:33.471231  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T11:04:33.471749  + cd /lava-<8>[   28.496866] <LAVA_SIGNAL_S=
TARTRUN 1_bootrr 11371401_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7f3cb21ae9abd4286d8f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.48-=
128-g1aa86af84d82/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7f3cb21ae9abd4286d98
        failing since 41 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-28T11:05:54.597985  / # #

    2023-08-28T11:05:54.700397  export SHELL=3D/bin/sh

    2023-08-28T11:05:54.701163  #

    2023-08-28T11:05:54.802565  / # export SHELL=3D/bin/sh. /lava-11371391/=
environment

    2023-08-28T11:05:54.803218  =


    2023-08-28T11:05:54.904621  / # . /lava-11371391/environment/lava-11371=
391/bin/lava-test-runner /lava-11371391/1

    2023-08-28T11:05:54.905790  =


    2023-08-28T11:05:54.922284  / # /lava-11371391/bin/lava-test-runner /la=
va-11371391/1

    2023-08-28T11:05:54.987330  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T11:05:54.987858  + cd /lava-1137139<8>[   18.767323] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11371391_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
