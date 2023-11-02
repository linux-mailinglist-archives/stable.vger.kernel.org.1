Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23547DF4F7
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 15:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjKBO2K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjKBO2J (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 10:28:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58CB1BF
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 07:27:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5b8c39a2dceso681355a12.2
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698935259; x=1699540059; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vz+M3gvZ6SLKFdhAz+E2UBlSQaSlopd2Lv2Su/Fxchs=;
        b=JM0nawqQ8GNzK7Xbt6WvhbFeeOF0xGWB3oQW++apiFcZ+dYKq1bRR9UFyUVxKpfxM/
         Mi+3fJiTl2L0fkG1ipbe+vebmunrFTVsyqtlJaiA0RdZYxJmzpKyk/7iRHhOsKRxXK6V
         cF91DToMtXV0lMpgQjMWchy34OSq3L3etYMV4nZTW57s/HFOxfGNzgpC3YDR2GJO6mbe
         2MAEhut4vTfEJ/kwO2br2ftElrkq1+nGy+I0w5hHcKkY1gSKJetmm+PbAw1mIzNeWvcf
         7tQS+ouhiRuk/1dQUHH25Q5Wcu06Zesxn+ebAcSAl/xyppYxQ4k0XmYERurhi/fw8Anf
         TprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935259; x=1699540059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vz+M3gvZ6SLKFdhAz+E2UBlSQaSlopd2Lv2Su/Fxchs=;
        b=qqtbA96rvt19VNcCDlSrNgZ9WAn3YaS+jW3+FZJlvO8TC5YpB6Drw7eq3XpLpnZutI
         c0gOTyGzm2dh3jU8K6awtWJu+/mjgR5jKb6kfC3WSgGoAvRMbEkEhaQacOAZo415noPN
         OkatCvGECoarrfP+twwThUjs9hQWE++pkwBH6WC0SwatNuiPN9JhnQYLcmqbfCA9aS+C
         i4TbceVuIZgKveJOeMV4AJKCz2j5Q571A/QHuTpEGQK1dCGtR1J+7pJ96b8ss4vNbgpf
         8hUavrsJ9S5Hy1/a+HvAHcBSJxQiyu3nsc3vJlUVuHBym1OwD8keiV7BbA+5CI0Ugk99
         chnA==
X-Gm-Message-State: AOJu0YweZYPNDAJnR6JI/DSf5gMNZ/pto3rQudgvoGJFa3749JBzGMsm
        JzrEoiM5P5DVC2Rpe+pRj1Wj1oYgsNsIkY94MSlKKw==
X-Google-Smtp-Source: AGHT+IE1NxB3xuzg1fz4FJolDb3gxOTPnTUmuMlwc33UE9bUcx+HcMWbRHpoox50B83QxuMfKAEUzw==
X-Received: by 2002:a17:90a:d388:b0:27d:515d:94f0 with SMTP id q8-20020a17090ad38800b0027d515d94f0mr14183505pju.24.1698935258920;
        Thu, 02 Nov 2023 07:27:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id az23-20020a17090b029700b00271c5811019sm2526058pjb.38.2023.11.02.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:27:38 -0700 (PDT)
Message-ID: <6543b1da.170a0220.d8be7.6848@mx.google.com>
Date:   Thu, 02 Nov 2023 07:27:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.4.259
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.4.y baseline: 160 runs, 2 regressions (v5.4.259)
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

stable-rc/linux-5.4.y baseline: 160 runs, 2 regressions (v5.4.259)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig          | re=
gressions
----------------+-------+--------------+----------+--------------------+---=
---------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig          | 1 =
         =

panda           | arm   | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.259/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.259
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      86ea40e6ad22d9d7daa54b9e8167ad1e4a8a48ee =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig          | re=
gressions
----------------+-------+--------------+----------+--------------------+---=
---------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig          | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6539637d595e489851efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.259=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.259=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6539637d595e489851efc=
ef6
        new failure (last pass: v5.4.258-121-g18f5a3e6c35c) =

 =



platform        | arch  | lab          | compiler | defconfig          | re=
gressions
----------------+-------+--------------+----------+--------------------+---=
---------
panda           | arm   | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/653962de22637550e2efcef6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.259=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.259=
/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653962de22637550e2efceff
        failing since 0 day (last pass: v5.4.218-5-g5a1de46f7e74, first fai=
l: v5.4.258-121-g18f5a3e6c35c)

    2023-10-25T18:47:34.464333  <8>[   21.144439] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3814585_1.5.2.4.1>
    2023-10-25T18:47:34.572041  / # #
    2023-10-25T18:47:34.673866  export SHELL=3D/bin/sh
    2023-10-25T18:47:34.674354  #
    2023-10-25T18:47:34.775250  / # export SHELL=3D/bin/sh. /lava-3814585/e=
nvironment
    2023-10-25T18:47:34.775939  =

    2023-10-25T18:47:34.877089  / # . /lava-3814585/environment/lava-381458=
5/bin/lava-test-runner /lava-3814585/1
    2023-10-25T18:47:34.878114  =

    2023-10-25T18:47:34.883067  / # /lava-3814585/bin/lava-test-runner /lav=
a-3814585/1
    2023-10-25T18:47:34.937208  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
