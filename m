Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E80744A7E
	for <lists+stable@lfdr.de>; Sat,  1 Jul 2023 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjGAQTc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 1 Jul 2023 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGAQTb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 1 Jul 2023 12:19:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2E610DC
        for <stable@vger.kernel.org>; Sat,  1 Jul 2023 09:19:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b80b343178so16309275ad.0
        for <stable@vger.kernel.org>; Sat, 01 Jul 2023 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688228370; x=1690820370;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IGUyEamBeKEJrCWvlMIlhfEst7+03GwPP7tlnUUtuv4=;
        b=g/t1blWYpaVX0NqjxBAq0JKCJp5djVlCaz5VRordFbGpGhBSQPyxZlC7V6bAAOgiG8
         +v8fWXdGbO7f0vxSwzoSHh81H+APOgTUxQ/w2zVpFP6G1f/qM4TVA3KeeCNX+sz9w6NP
         3tVR0VyGvfoaYlOxMdagH7efMF7u/CUhEvHDZ29BKADBiw5bpXcpjJXFf1LCen/g9NcU
         7iFmvH0NiAwR1vHLwQZc9GP6WLTQcE9oO1oh+vNHXtQCN3eaPPn97Ja3u+GzHtri9iaw
         XDY/JR0gWZwI3Jrbgzf/wmaQ9fkK3dlCPm/iUKFTuxqzUCbaIe5MEPc4MxFBPj7fhVvv
         H1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688228370; x=1690820370;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGUyEamBeKEJrCWvlMIlhfEst7+03GwPP7tlnUUtuv4=;
        b=Tq4LSkh6nhlGSzBksVtDktVnnepVd6luvHhfs6h6X2RoSWN0XU7bqKeG4mbmKYltno
         44uH0uzL7ivRkFi4OzKDdsJua0LcZmCpu7ChEhxIOg7O4qM15Z7g1QJU8HC1/MD/UZ8V
         p0N5m+4Bu9/el4smqouJnFmoXjFJkFyMBC1MPbZPmllXbvRr8QEtHwVPyYSudMZKQWKe
         kFy4H1zxAUozr7qjpbR7SleIWHl19C2YNALMAyEOiK1heUXFK+XVcYOH6E4gn05huKFr
         w+EWF43UhyDg4qqmqm/v089RPr3BvSEWkwZx4NJRgUHZtrXxyt6hVP13MWD5HwxWfU/h
         RBHA==
X-Gm-Message-State: ABy/qLbp48aQ2agCw/H+WB1eYuZO97dIErNPVfOgvtIJjjS/AK6D8oOq
        o2suLCCCs20/aQNJLV2U+g4zcBgNbz7JyyHsLz5y5Hg9
X-Google-Smtp-Source: APBJJlHJkR9D1+n36W/6Fol8w+XUjB6iMCzNukpvta+iYbkABEy6D58dtPp4Ka+g6tzTbd/RnTmKfA==
X-Received: by 2002:a17:903:244a:b0:1b8:8711:bf2b with SMTP id l10-20020a170903244a00b001b88711bf2bmr709383pls.47.1688228369936;
        Sat, 01 Jul 2023 09:19:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001ac897026cesm12569174plh.102.2023.07.01.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 09:19:29 -0700 (PDT)
Message-ID: <64a05211.170a0220.891cc.808d@mx.google.com>
Date:   Sat, 01 Jul 2023 09:19:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.11
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
Subject: stable/linux-6.3.y baseline: 116 runs, 2 regressions (v6.3.11)
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

stable/linux-6.3.y baseline: 116 runs, 2 regressions (v6.3.11)

Regressions Summary
-------------------

platform    | arch | lab         | compiler | defconfig          | regressi=
ons
------------+------+-------------+----------+--------------------+---------=
---
imx6dl-udoo | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 2       =
   =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.3.y/kernel/=
v6.3.11/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.3.y
  Describe: v6.3.11
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      429cff33b400edd76fc4d5e470742812a44fbc91 =



Test Regressions
---------------- =



platform    | arch | lab         | compiler | defconfig          | regressi=
ons
------------+------+-------------+----------+--------------------+---------=
---
imx6dl-udoo | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64a01cd05f874c5a3bbb2af9

  Results:     29 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.11/arm=
/multi_v7_defconfig/gcc-10/lab-broonie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.11/arm=
/multi_v7_defconfig/gcc-10/lab-broonie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64a01cd05=
f874c5a3bbb2b02
        new failure (last pass: v6.3.8)

    2023-07-01T12:32:08.710205  /lava-684273/1/../bin/lava-test-case
    2023-07-01T12:32:08.737990  <8>[   24.808363] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sound-card-probed: https://kernelci.org/test/case/id/64=
a01cd05f874c5a3bbb2b03
        new failure (last pass: v6.3.8)

    2023-07-01T12:32:07.659176  /lava-684273/1/../bin/lava-test-case
    2023-07-01T12:32:07.687987  <8>[   23.757832] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card-probed RESULT=3Dfail>   =

 =20
