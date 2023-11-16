Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE07ED921
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 03:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjKPCJ7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 21:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPCJ7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 21:09:59 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3B2187
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 18:09:55 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2f4a5ccebso197186b6e.3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 18:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700100594; x=1700705394; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jge6msL/+JniYXSRDUYwZ1gtj2Oz8qyUenaWgII62f4=;
        b=TTar4Gw2120BK8I0tBivBTjSTKsENavxgtXYTIg+ErLv8JPqqbLx30kHld4ebfIXmC
         DmRbaHO9q22ZhphKrJdb0OBbEF+j6rDhdD+dGm91cXMNnaSOV8HgUyoUEunN1HeSDuEs
         qOwYZYJ3l94oP4WhVvNKf7Rv/9OR7wuMBd0f/EzE1auK3xwMMRxq7bxnt1IsOqpR1lKN
         GQ4T97DGXeCgDklPtOLVmMO+c5zM/SvE7MPT8kCn7iMFov84I7jndhb4DvlDv6w8AywT
         WDsDnzlmgOQF/S4BLinplGaudNzGOpEDl77TLef8V/m/Vd/p9FNET1BhKPWNtB64SEbe
         CA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700100594; x=1700705394;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jge6msL/+JniYXSRDUYwZ1gtj2Oz8qyUenaWgII62f4=;
        b=vEUryvQDxxoZJhxVtB71bvrTZQan7TDXs8B6nyl8vkxLABivHD8vMVRT9ADQO5i/EL
         azaoPFrexPvok52a+F+AhvNnWxRE33iWWpAdaxhDuXdGb/OHtpwZTyswur05i6kiu1/+
         cS/IbPVqYRzFlm6QZGuqt+o720dPwhYrwyolIRdXGq/WRxpkdxeYYdkZaFP1K+ODnW+Y
         lKaE4Hs2lc0UXr9uUo2/CcoUSiuER+whI5alYfKgYq+1wdbkzlutyRd6XH3wM7Rn2Mtv
         DHQ5jajAifS5NP7eQ3+/veV9ldoaHwyDrudwWrL9vaYg1gGRe+uUfCHZSHTIqCqCTMmc
         myeA==
X-Gm-Message-State: AOJu0Yzp2UqNvVbHwm0kvdVqG8cwkU6mBhP8fqmSSo0WoN7C0vHx9IIV
        5N7vKaQ2dnpcv3xWOrA8hZlw/aU6bydfh/jaDYkWxg==
X-Google-Smtp-Source: AGHT+IF9E+2uMLYV/h74y8jVdiDEuAB1P7gxUF27yLWEK2p0q8L+uk1AlqrXtJdFub0wkxf6z/yJpg==
X-Received: by 2002:a05:6808:b3c:b0:3b2:db86:209 with SMTP id t28-20020a0568080b3c00b003b2db860209mr14981227oij.38.1700100594243;
        Wed, 15 Nov 2023 18:09:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m18-20020aa78a12000000b0068c10187dc3sm3403626pfa.168.2023.11.15.18.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:09:53 -0800 (PST)
Message-ID: <655579f1.a70a0220.ec95b.bac6@mx.google.com>
Date:   Wed, 15 Nov 2023 18:09:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.200-192-g550b7e1fee20
Subject: stable-rc/linux-5.10.y baseline: 113 runs,
 2 regressions (v5.10.200-192-g550b7e1fee20)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 113 runs, 2 regressions (v5.10.200-192-g55=
0b7e1fee20)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.200-192-g550b7e1fee20/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.200-192-g550b7e1fee20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      550b7e1fee20e8840f9c1028c89dd3fc9c959fff =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6555480a94a83a7be97e4aaa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-192-g550b7e1fee20/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-192-g550b7e1fee20/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6555480a94a83a7be97e4ab3
        failing since 35 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-15T22:36:48.806844  <8>[   16.949774] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 444163_1.5.2.4.1>
    2023-11-15T22:36:48.911795  / # #
    2023-11-15T22:36:49.013398  export SHELL=3D/bin/sh
    2023-11-15T22:36:49.014044  #
    2023-11-15T22:36:49.114991  / # export SHELL=3D/bin/sh. /lava-444163/en=
vironment
    2023-11-15T22:36:49.115644  =

    2023-11-15T22:36:49.216642  / # . /lava-444163/environment/lava-444163/=
bin/lava-test-runner /lava-444163/1
    2023-11-15T22:36:49.217545  =

    2023-11-15T22:36:49.222090  / # /lava-444163/bin/lava-test-runner /lava=
-444163/1
    2023-11-15T22:36:49.289300  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6555481c94a83a7be97e4b29

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-192-g550b7e1fee20/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-192-g550b7e1fee20/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6555481c94a83a7be97e4b32
        failing since 35 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-15T22:43:32.479712  / # #

    2023-11-15T22:43:32.582109  export SHELL=3D/bin/sh

    2023-11-15T22:43:32.582880  #

    2023-11-15T22:43:32.684259  / # export SHELL=3D/bin/sh. /lava-12012273/=
environment

    2023-11-15T22:43:32.685033  =


    2023-11-15T22:43:32.786554  / # . /lava-12012273/environment/lava-12012=
273/bin/lava-test-runner /lava-12012273/1

    2023-11-15T22:43:32.787714  =


    2023-11-15T22:43:32.802870  / # /lava-12012273/bin/lava-test-runner /la=
va-12012273/1

    2023-11-15T22:43:32.861501  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-15T22:43:32.861695  + cd /lava-1201227<8>[   18.183590] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12012273_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
