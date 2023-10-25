Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217BD7D7474
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 21:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjJYThQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYThP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 15:37:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9587A137
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 12:37:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d5fe999caso56263a91.1
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698262633; x=1698867433; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ftDoQU+2xmtM5Ksa3K3J6mc0meUapZvx3t1CWz9FTYg=;
        b=ZlbL88VvPtRCZnatsChiJVkWQFHBK3mQ9x1hABgZG8jhefx9fKQlqQ+eKJnHY0Js6C
         U5VvqOKNqcPSOW1pI18K/zBIq+AjIiuuqbccrPJGVji6xpqv1iSpzuovJOb+IcykZtHH
         zCg5o0OIvhvYkaQroHMgDZRA5h7EPTSMDAAZhDN3Ehc+PFuE8GLL41rpDwuiRSer/d9D
         Dd8EVg7gg/1M1qaJCOS0IPvQV2RHu6ptBE84Sbzmux9+hgCjGcvyRDYe31giSVcMBwwP
         LDCxtou1BYVYNALu5clYiRUHLRjQgi6nxe2wC0c4BiU27vIi/2KBXm/dO/CKKHAh+hq7
         ks3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698262633; x=1698867433;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftDoQU+2xmtM5Ksa3K3J6mc0meUapZvx3t1CWz9FTYg=;
        b=Ux/HsUDwjYUMBOn1o9y0yS5YfDJMq7JN9B/tWVeZHmMzhlTRiU/ru5rd+1JSi04Nhn
         jwORMeZRBJZg3kuG6nvUvmtEC/XOuz4kYF0/w4NjRPK+DvEZevHnPI4rLZY1iD5a1pcL
         UQ6OWWl3c+6MrCJNR9kuWqgezb4U9xiXPGTftEqSDSgP+Q4MzUQrEy8zWaNytnRzWoDx
         FYTGH4qYAoVSHeU/Ig0LJkk1KoJKA3cyITIaRb4+I0X3LxgAHpDreTbWjBMNNF7Vbihl
         mN+xyZ+mhFoHFNN0hjClbhak/XgmoF6x87MXmIa+Ry+tkpTgcLaYd/JVPCqE5eKwnB41
         MmtQ==
X-Gm-Message-State: AOJu0YxIjFwabnaXXhw3CV7JmnJTORSe+UcnWN+8TtyTxc5qJVDM3OQX
        8ha/vfnW7lsooRA9UA8B/WfSBx2AqgYwK6ko2p4=
X-Google-Smtp-Source: AGHT+IGWV4SrYpVNLv5pJGZkvRbiKWIGOOhhii6ZAwvdAMkDMAOb+MZF+4exKmUHkJvkx1Z09gbHwg==
X-Received: by 2002:a17:90b:1fce:b0:27d:e18:810d with SMTP id st14-20020a17090b1fce00b0027d0e18810dmr13227494pjb.11.1698262632705;
        Wed, 25 Oct 2023 12:37:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id em4-20020a17090b014400b00274b9dd8519sm250049pjb.35.2023.10.25.12.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:37:12 -0700 (PDT)
Message-ID: <65396e68.170a0220.2b53b.19b8@mx.google.com>
Date:   Wed, 25 Oct 2023 12:37:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.199
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
Subject: stable/linux-5.10.y baseline: 171 runs, 1 regressions (v5.10.199)
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

stable/linux-5.10.y baseline: 171 runs, 1 regressions (v5.10.199)

Regressions Summary
-------------------

platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.199/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.199
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      cb49f0e441ce7db63ef67ccfa9d9562c22f5d6c3 =



Test Regressions
---------------- =



platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65393d32c56c634badefcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.199/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.199/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65393d32c56c634badefcefc
        new failure (last pass: v5.10.148)

    2023-10-25T16:06:55.028018  + <8>[   24.847930] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 3813999_1.5.2.4.1>
    2023-10-25T16:06:55.028245  set +x
    2023-10-25T16:06:55.133717  / # #
    2023-10-25T16:06:55.234988  export SHELL=3D/bin/sh
    2023-10-25T16:06:55.235350  #
    2023-10-25T16:06:55.336128  / # export SHELL=3D/bin/sh. /lava-3813999/e=
nvironment
    2023-10-25T16:06:55.336497  =

    2023-10-25T16:06:55.437331  / # . /lava-3813999/environment/lava-381399=
9/bin/lava-test-runner /lava-3813999/1
    2023-10-25T16:06:55.438038  =

    2023-10-25T16:06:55.443282  / # /lava-3813999/bin/lava-test-runner /lav=
a-3813999/1 =

    ... (12 line(s) more)  =

 =20
