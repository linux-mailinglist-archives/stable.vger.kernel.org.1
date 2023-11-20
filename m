Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45017F1DC5
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 21:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjKTUGs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 15:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjKTUGq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 15:06:46 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3A1BE
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 12:06:42 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso3841451b3a.0
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 12:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700510802; x=1701115602; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2xaabY4MH9jTuTr8kVQDEEKlUCymhU5FgH1wBZ7nUzk=;
        b=UOOvdXBaZSqqkLgbhvwBA9dZLdzB9pwSBlOBA2IHSdS+nGrWkm/gshtGdQCkNIqJWl
         D7dyoJWSL62DtDwS1j/xa6+3zXg8+FsoXs2sbWXQ4iDyev8BQsBTeOPFTz9uzVv5xRGG
         efb+AJAWEBifkIxlSTCPpg2fCW1wcAe/akKF3nEpS+VW6kITc+xYbY96q8bP1Saufk0H
         7T62CJkP5lTOsHhLgztYaQexiqYsOa5uBAlCU5ZcVaIfY+WwolorxdMSPVnqkl1nKtXL
         eg9bHFrirypmuvd/ec+8h1je18thNpJPFwONkVaNnhLvry00hhtwJFmWlZxzCKRm332c
         shmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700510802; x=1701115602;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xaabY4MH9jTuTr8kVQDEEKlUCymhU5FgH1wBZ7nUzk=;
        b=iUg/J6svMV4wiVLoOELdsNEzxZqkOXCjI30ItPq51bgTufYB3IcLeb8JxszmHeckBe
         zocLFBTwK3JCyYBNk2yNcJR8kDKTwQnFmvy3oLCeJhLIzaq/isztqGtv5Eh/h6o7UKXK
         wGszxaoebZbhUuCfQwYQ6p7SG+/0QVxQGqZGy9f2fLhpzxl7lB4KFOWnXgpKnqe11QDO
         PVVC9PnY0ftXU9K8f4Fnbfac+yTCKQ41GktwOeXeShhFBAfOTlPjMj8G0olrh/TRgIQK
         QXqJnjOlfOEsop3npKTRAHNrfBERDTxxCygMXqjxLAq/4iEDZjjFi/AY1fUMiN1rZkei
         ak9g==
X-Gm-Message-State: AOJu0YxyB2+zpRjbKeD5d6l1HCRlfMw/vk6tZ0GvZUIa3Hr1lJzgUTYZ
        n8e+YFlIXZTv5ONnBexk8YfljWhvZ1rLmQoRdOk=
X-Google-Smtp-Source: AGHT+IGI2my3BZfSD1+kwS745k4/Nvl40TIbHGaG+7yyBJerTf/MomQpQyhC2g6ZfoFfsPRnG4rfrA==
X-Received: by 2002:a05:6a20:1faf:b0:187:9b8e:3a87 with SMTP id dm47-20020a056a201faf00b001879b8e3a87mr5449527pzb.30.1700510801765;
        Mon, 20 Nov 2023 12:06:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a00214c00b006c34015a8f2sm6632055pfk.146.2023.11.20.12.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:06:41 -0800 (PST)
Message-ID: <655bbc51.050a0220.d3a2d.127d@mx.google.com>
Date:   Mon, 20 Nov 2023 12:06:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63
Subject: stable-rc/linux-6.1.y baseline: 104 runs, 1 regressions (v6.1.63)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 104 runs, 1 regressions (v6.1.63)

Regressions Summary
-------------------

platform             | arch | lab        | compiler | defconfig          | =
regressions
---------------------+------+------------+----------+--------------------+-=
-----------
sun8i-h3-orangepi-pc | arm  | lab-clabbe | gcc-10   | multi_v7_defconfig | =
1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.63/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.63
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      69e434a1cb2146a70062d89d507b6132fa38bfe1 =



Test Regressions
---------------- =



platform             | arch | lab        | compiler | defconfig          | =
regressions
---------------------+------+------------+----------+--------------------+-=
-----------
sun8i-h3-orangepi-pc | arm  | lab-clabbe | gcc-10   | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/655b8cc000427eb9df7e4ab7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.63/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-h3-orangepi-pc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.63/=
arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8i-h3-orangepi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b8cc000427eb9df7e4=
ab8
        new failure (last pass: v6.1.62-380-g505b91175bcf) =

 =20
