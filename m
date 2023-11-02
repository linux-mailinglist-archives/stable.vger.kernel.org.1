Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A467DFC6C
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 23:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjKBWaj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 18:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377503AbjKBWaf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 18:30:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A9BB7
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 15:30:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc0d0a0355so11881975ad.3
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698964228; x=1699569028; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/DCbLnDw+vzEWXtHatQcVAYEklcu4HMnlq1zW/b01Q8=;
        b=qJ7rU2or0rm+4NYDOGA+nEPnMn3w+twyofBso26Md2JQ05LM8vwvGUmXWhJPb7Txvy
         92h7JHXVKsYLJ5rWbBIW5W2flfXDXPXN4Guo5WdphhwDULgLOqHPPrLggmIop54hTbdK
         qZhl4Uc4JV9ge+ZUXIta521ua299bV5Od++wzN9HfUyevIeSyx3GhbcZMuvj8auntHWT
         kfR1+1niPCDxe9Xc3NU9LlnO5m1X7Qi3H7FcvRGxNlW330nA2pV1k67NVag1hfivrccG
         PHVuu8c2Ds9/AW7Msh52OW6OYxlEDH1uwF9tKE2c914RTB6IMax0ZYDiluScRxX/liZZ
         UC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698964228; x=1699569028;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DCbLnDw+vzEWXtHatQcVAYEklcu4HMnlq1zW/b01Q8=;
        b=JH61/J+0t4s8sZh2JQzcfCs/0d02u75CPRkJMdGGHQqwVSNqqcHlKhyyhl9eh56EBp
         C7E/XAkLakMrWJAtMZzjtZdm55sxJpq6N9wIPlUvWN3LbpudhT4BUhC1er/h2FcYW3U6
         Zzq6xt/6a1VUgZ6dqxzxFJEn7t6CAZMZFSWhdWIRNdwK56p4PWjiddGm6XCKm8wux/I9
         fHvqMjVjH3TSGO0b0ImJYOFiwz5c64YjO6oL09PEHHq3d0BhAL58ZMk0GtzrDYmgs/X4
         JKjRMvjlxfw/t/37L+tRD5i36eNkw9kxJi0PCYXq2ceb7gStgInaRit2ckcvSd9AUSIA
         i9IQ==
X-Gm-Message-State: AOJu0YwoLQHzxhpzVxgmmtZsKVc2nn/XH3gKXYmkbWcHwSQoT4cr1m9o
        IzdlW+kEQguLB6HkYme8FJbxXahWPp62zzpktlSCuA==
X-Google-Smtp-Source: AGHT+IHOF0pg9J4lb2krBl7EcEIIFr/EEAEIEPP+oLNlHP0hBlN5QlQ+atrVuSlcwptBsIqSHAWKTQ==
X-Received: by 2002:a17:903:11c4:b0:1cc:6e8f:c14d with SMTP id q4-20020a17090311c400b001cc6e8fc14dmr9310659plh.50.1698964227810;
        Thu, 02 Nov 2023 15:30:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b001c8a0879805sm189264plb.206.2023.11.02.15.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:30:27 -0700 (PDT)
Message-ID: <65442303.170a0220.b1ff5.0ce0@mx.google.com>
Date:   Thu, 02 Nov 2023 15:30:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.199-61-g2c4e8ef8a1d9
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 157 runs,
 2 regressions (v5.10.199-61-g2c4e8ef8a1d9)
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

stable-rc/linux-5.10.y baseline: 157 runs, 2 regressions (v5.10.199-61-g2c4=
e8ef8a1d9)

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
nel/v5.10.199-61-g2c4e8ef8a1d9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.199-61-g2c4e8ef8a1d9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2c4e8ef8a1d9a42120a88be22e51f2665497b473 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6543f155b77d6417fbefcf24

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99-61-g2c4e8ef8a1d9/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99-61-g2c4e8ef8a1d9/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543f155b77d6417fbefcf2d
        failing since 22 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-02T18:58:21.852103  <8>[   16.964203] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 442403_1.5.2.4.1>
    2023-11-02T18:58:21.957204  / # #
    2023-11-02T18:58:22.058850  export SHELL=3D/bin/sh
    2023-11-02T18:58:22.059482  #
    2023-11-02T18:58:22.160483  / # export SHELL=3D/bin/sh. /lava-442403/en=
vironment
    2023-11-02T18:58:22.161077  =

    2023-11-02T18:58:22.262074  / # . /lava-442403/environment/lava-442403/=
bin/lava-test-runner /lava-442403/1
    2023-11-02T18:58:22.262907  =

    2023-11-02T18:58:22.267411  / # /lava-442403/bin/lava-test-runner /lava=
-442403/1
    2023-11-02T18:58:22.334408  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6543f166bdbd98d6dcefcef5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99-61-g2c4e8ef8a1d9/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99-61-g2c4e8ef8a1d9/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543f166bdbd98d6dcefcefe
        failing since 22 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-02T19:02:55.212917  / # #

    2023-11-02T19:02:55.315006  export SHELL=3D/bin/sh

    2023-11-02T19:02:55.315753  #

    2023-11-02T19:02:55.417191  / # export SHELL=3D/bin/sh. /lava-11932840/=
environment

    2023-11-02T19:02:55.417883  =


    2023-11-02T19:02:55.519229  / # . /lava-11932840/environment/lava-11932=
840/bin/lava-test-runner /lava-11932840/1

    2023-11-02T19:02:55.520202  =


    2023-11-02T19:02:55.537485  / # /lava-11932840/bin/lava-test-runner /la=
va-11932840/1

    2023-11-02T19:02:55.580333  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-02T19:02:55.596366  + cd /lava-1193284<8>[   18.197759] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11932840_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
