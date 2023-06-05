Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01AE722657
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 14:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjFEMui (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjFEMuU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 08:50:20 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750DC7
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 05:50:01 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-559b0ddcd4aso432194eaf.0
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685969400; x=1688561400;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d+TjSMNj/D/pSTRYkkM1rDcHDPEv65xKX1YV27XdGhg=;
        b=o90ztXEhxJHPpXzu6rEtWJHd4GY6y2c5+cgO+25XWoWIe9gPHZ7jNJuLA+wPD4zcaw
         dA2I8LewwxK4kuBwX8O8yDRh7sGKi1H02ElCxfNYxpsD5OWRQ2x+2pD/3crF4DNvAdPA
         rwO4EWMv1lVhCv/VjwqyWqzO4dejBVSpelI1TI0uHRoG2re/Iav9HBkkO1xhi3TxXAiv
         K30oPoBa7UoJjS+SiQEKBy7cVZHjRHIGs9Dmsq++jn+v/7g0qbdqpZCP3hNJBxR8d98B
         Zi+YyprzEe5v2MN1S2sMgkUp2hoJDI3Nv3AmrxS3RMH3SAXCFavCQ3zVfFnDOB2+rPOL
         Lc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685969400; x=1688561400;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+TjSMNj/D/pSTRYkkM1rDcHDPEv65xKX1YV27XdGhg=;
        b=J90+frc11bVVABCQoG6N5sCNT6zHfXA222Qbg0lzz5clP9NJtNtDj3PsMXo7O656k4
         1p153cVsFPCY3OBNy6sBS2bcLwfBB5JX6r5RwH6SvC6lz2V/ZHQvBYnHnB8/UJ8ttfKO
         KetNH5Ur3YVHwh/vdbeys3YkUJtQJFCr6NXPly46cK//OyFnU2pdkrsX9noJUd5slFpb
         bnMaL44WKSUZR4JGgLoB+xYRhZtjY4L8LKmyasQq50b84yXZ2DNkHxBWk0DcQPkXTcQ9
         /KNAyZNGzxBD78b1cgJtXKwCdBA7zvGnSBq8cpuTogE6VH0AopNLrO0Tw03LZiKWvitS
         2T/A==
X-Gm-Message-State: AC+VfDwW5KNyPgvPyGbz2JR9ktitLNKNqGdzwIm6SIkpvFRJyxPCJiwV
        2STj1FQIO9HtXxMRQuTRkzZqxX1iwbrfA9aHqABplg==
X-Google-Smtp-Source: ACHHUZ5eJ3IsZSE/E8b8l3sFauKdDH6pDdUlxjUG+DSNAOXbZU00j2xMxKetQV+KwhlRkVmPF/NfsQ==
X-Received: by 2002:a05:6358:9f82:b0:129:6079:14fe with SMTP id fy2-20020a0563589f8200b00129607914femr2277474rwb.14.1685969399758;
        Mon, 05 Jun 2023 05:49:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090a498300b00252b3328ad8sm5786444pjh.0.2023.06.05.05.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:49:59 -0700 (PDT)
Message-ID: <647dd9f7.170a0220.9a814.9675@mx.google.com>
Date:   Mon, 05 Jun 2023 05:49:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable
Subject: stable/linux-6.3.y baseline: 175 runs, 2 regressions (v6.3.6)
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

stable/linux-6.3.y baseline: 175 runs, 2 regressions (v6.3.6)

Regressions Summary
-------------------

platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6dl-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 2      =
    =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.3.y/kernel/=
v6.3.6/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.3.y
  Describe: v6.3.6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      abfd9cf1c3d4d143a889b76af835078897e46c55 =



Test Regressions
---------------- =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6dl-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/647da605fbf642cb0bf5de41

  Results:     29 PASS, 4 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.6/arm/=
imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.6/arm/=
imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/647da605f=
bf642cb0bf5de4e
        new failure (last pass: v6.3.5)

    2023-06-05T09:08:04.159663  /lava-561726/1/../bin/lava-test-case
    2023-06-05T09:08:04.181732  <8>[   17.965782] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sound-card-probed: https://kernelci.org/test/case/id/64=
7da605fbf642cb0bf5de4f
        new failure (last pass: v6.3.5)

    2023-06-05T09:08:03.109193  /lava-561726/1/../bin/lava-test-case
    2023-06-05T09:08:03.137273  <8>[   16.920110] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card-probed RESULT=3Dfail>   =

 =20
