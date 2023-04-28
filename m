Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9300F6F1B84
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 17:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346445AbjD1P1y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 11:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346447AbjD1P1u (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 11:27:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1B11BF0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 08:27:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a667067275so744335ad.1
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682695630; x=1685287630;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AbRY42jNFLf+KRURHaYAV6wK3ODay1ABSH+A2u0X/Os=;
        b=t20GYKQLmAxBJR22vTJoF7S9UV9ZP49ITXoonBSyApCXa6Fm5HMs7Lg3V7nh3JvN+m
         AEhC4PmmaAGhSUrjRshU6/iNFv/WFFGBwFsYb2msLl61Fh1ZMwtXM/az08tELO6BU9M6
         BRWa7JoZZNGotkl+qT/BrUQbeVy4fh5czOrLSzZrW5wM5WRHYkwkKpyBavR7L8yosLhJ
         oxuxuuH4E+iP9h5G3X8gea3gmWKSftH9Q2RBuCG4jEv3KycrkcGFPZRKKxAgTNc4p3fv
         PEsFvA+WwrW+8sFdwFzPZHT+jMpvQQoSDjwbTGyw7GwNnXZfAA0+mYKnQ8x6iUWvvzLW
         B0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682695630; x=1685287630;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbRY42jNFLf+KRURHaYAV6wK3ODay1ABSH+A2u0X/Os=;
        b=R86fWQDLTQkAu9ACFYj2nMMgCTkYVxCpfEWmjRsyQ3CspEwaHlJ3PpGyMoch98t1RH
         IOCNKw0snqZkXZWojHx/c530okXhakpE7vXcT1tayWbS8I9qx8+cyP5+Zg7FipYmUcYd
         NLTvzwyVEIWM3DzHDSVubXhZTw51gqyZaYz+4qjXPbM2fu2dXkB2nKdWFyvVQTA/7tRG
         Di68Xxkw+0sEQWyY3/IhSkC6i93ubz2kEK9Ngfd1R50x1FXVatcIDKMm4+9bi5NqrTY4
         mgPcQlIobSBmH4YCKfIMrCOZKRZUUmwd39NO74ucrbnJ2AbLYPdgpvdW4ecb2/ilo00N
         xWqA==
X-Gm-Message-State: AC+VfDyr1UZVpIPXqdxxOaw8y/F+vYLee07Q3RQkOyLuZwdH1t/fZ5oU
        kP66fuLeibmzrdQsGctvuiTOrlMbjCJlFf8spZ0=
X-Google-Smtp-Source: ACHHUZ6U9dlvrQP7c5dzW/i/v/fEMd6h2YO2lKCWK0iXJjaBu+LKM3d/bD4KOu+JcvuQOkh2oh5+VA==
X-Received: by 2002:a17:902:d2c5:b0:1a9:5ee9:71e0 with SMTP id n5-20020a170902d2c500b001a95ee971e0mr7099051plc.0.1682695630328;
        Fri, 28 Apr 2023 08:27:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ix20-20020a170902f81400b001a3d041ca71sm13460296plb.275.2023.04.28.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:27:09 -0700 (PDT)
Message-ID: <644be5cd.170a0220.700f2.bc00@mx.google.com>
Date:   Fri, 28 Apr 2023 08:27:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.311-138-gef9658ef2577
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-4.14.y baseline: 100 runs,
 1 regressions (v4.14.311-138-gef9658ef2577)
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

stable-rc/linux-4.14.y baseline: 100 runs, 1 regressions (v4.14.311-138-gef=
9658ef2577)

Regressions Summary
-------------------

platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.14.y/ker=
nel/v4.14.311-138-gef9658ef2577/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.14.y
  Describe: v4.14.311-138-gef9658ef2577
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ef9658ef25778cd4104b0f99484a6a6ae4eef3a9 =



Test Regressions
---------------- =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
meson8b-odroidc1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/644bae3ad9111673002e861c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-138-gef9658ef2577/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-me=
son8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.14.y/v4.14.3=
11-138-gef9658ef2577/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-me=
son8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644bae3ad9111673002e8=
61d
        failing since 438 days (last pass: v4.14.266, first fail: v4.14.266=
-45-gce409501ca5f) =

 =20
