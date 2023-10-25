Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816157D77AD
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 00:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJYWRA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 18:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJYWRA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 18:17:00 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862B7137
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 15:16:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b20a48522fso223799b3a.1
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698272216; x=1698877016; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eM+k8mOi5O9C0LL43G8y4Xn8QCIuKvtCQD1ltD8Szk8=;
        b=lklyIhI+prxb0u/8lRLKw9JBhPccttqQuWwL0IntvU3ZpDWBH9MKrq86adEsmPfB8J
         oBubhCWZVp85np5UKRgMmzkLiqC6aARE11YTUl6nhxbFoeKnGgiQOBE6MWbFTLuE+cM5
         AaFCrvc6ie0MAAjG2Vk+qevutxWj3MFF9+rarfFp/TXc4D77EoZ0CAaeWfJA74jS8TFp
         8pfEs38+GeCB3e2Im/ttO+NTZu1rHFz2wBIaZY9M1rR/VSyv6L4JX+NRoLW7F4VulRe4
         /SUuRmLbtV4AWWjPhEQ+RbXZEToaGtW8CIwp0xvFr9xUTcMFJwRhVD3vJbCmQ0+XA0Df
         W0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698272216; x=1698877016;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eM+k8mOi5O9C0LL43G8y4Xn8QCIuKvtCQD1ltD8Szk8=;
        b=YGSImjR/y9pzNLsJziaK84TgEGLZokuQwoAy823mq0V5NJRQYXPUTHmWPY5e5tDQw0
         lJ5t1N+2Mp37xEz2c4vlL9hOHwy10dD8LR6OAGgQAtJQDWvXZeyiTqGgr3aEKW4rkTJL
         olUw7DNf5kxT8mD22fE/x4cRYJ49+WmYyOR3xTp9t37yFItHWIxfDpAMV1SuJUqRcaPQ
         ip/U07K3wrr6cU/omTZ1xph2iM2lG9Hc8rXbWj5fQD3Zm0YrKYmIIw/RLQBtvsVKxPxB
         e6WxZ2W1a8llWx+kDjep5R9GakwJbFCxCWW1eCsdWFc4ajc2xh9swAGTvk4I4usCUvQw
         Uwmw==
X-Gm-Message-State: AOJu0YyHzTlV2/O1c8Fs/7j+OEkoZI5RZ79TQmANZ2z5y3AIJ1nnUp6P
        GIAB8s4qJSBPEUEVQVkBPK3Uou6/7uBzZr+FCCE=
X-Google-Smtp-Source: AGHT+IFP1UgP0y0DnU2JK08fO+g2Zvol0+EX4qG9ETlEUjCi3kb9+WIoL9c1LzPLt92lUCEgMMtYeg==
X-Received: by 2002:a05:6a00:15c7:b0:6b4:6b8:e945 with SMTP id o7-20020a056a0015c700b006b406b8e945mr14845455pfu.15.1698272216531;
        Wed, 25 Oct 2023 15:16:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e11-20020aa798cb000000b006934a1c69f8sm9841778pfm.24.2023.10.25.15.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 15:16:55 -0700 (PDT)
Message-ID: <653993d7.a70a0220.c1dbc.1c0f@mx.google.com>
Date:   Wed, 25 Oct 2023 15:16:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.4.259
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.4.y baseline: 154 runs, 2 regressions (v5.4.259)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y baseline: 154 runs, 2 regressions (v5.4.259)

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
