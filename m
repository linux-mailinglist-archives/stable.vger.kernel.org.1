Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE03716FCE
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 23:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjE3Vfp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 17:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE3Vfo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 17:35:44 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC520C7
        for <stable@vger.kernel.org>; Tue, 30 May 2023 14:35:43 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fbb3a013dso972858a12.1
        for <stable@vger.kernel.org>; Tue, 30 May 2023 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685482543; x=1688074543;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8BwVZEz7eeoiRq8NCkuTyvuokkbIRjwcbdyFSyrkvm8=;
        b=iLrqB9SKHCpJBJ0PszlfHiDomjiJFLqqqfLA9gdhSNxD30TTEC7CdLYcvTYcjpVNML
         jg13C5GgmzvH6CT3jJXjku+NzQUD7hICoVwe2fDFr9xQjHJBJyioNjrGwYC5IHwGNnQh
         5hD8b/jcMEOtfJvuQ/QXLLU9854LkvbuHjsav2TBq4+GXFf+WBTH9GEMClalgkksETPb
         2wcmD+LdAbOagnfmzRgY5eeks2eJQMYVVY+5xa27CjUh8ASgEdn52Vxohx62JZ31KdGB
         rIMSyX7S2PlNRrtdzB957qhHGh/0SVfZS5a5fgwhRM893T07Q+W5T4hxObXHzsdsmUC3
         foiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685482543; x=1688074543;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BwVZEz7eeoiRq8NCkuTyvuokkbIRjwcbdyFSyrkvm8=;
        b=lsCxUtPPI6QDy4CbuNPKnHw8zzto/U76Ui6FIQ7Epg/6jJ52MsbtTBZJKFff58GxVE
         QmhQXhOAZf4eJ6EW0hvpJUv5uw1xGghZtoedaGNihzbbg46Gr7ns3vXp9TM7HEJ6bOc/
         kpOjHMMRWto9d29nHFSaCV06r75kkKuJPqJwagJ7OXSRbyWUTPuESGxWIgfq2EWt5weW
         NwHWmOk6DuIQ/7PuEb5brFxLjgCOR8AR196WysQCtRwZ6e6e1YNN6f3uirQDyY/HUdrT
         UO8m6IAXBAZTJJSFNrUYpq4vE1aIVC0ECFZWcCgpEMFVFQ53rsd34vrDQg1W34jVarJw
         O4iQ==
X-Gm-Message-State: AC+VfDx/Vb64tnZ9G6xf7M9nrWm6HfOYoMSmWL+VTYqOH+lrQhDfZg0A
        lcABpZXMzkfKJ6bgPs7X3DHkl6EVvP3lBP2iUIHRVA==
X-Google-Smtp-Source: ACHHUZ4ek54Sofvc3pUbUB46f6qdsP0op3os8clpwaCPyRriNUeyEQi106IVERxTyq5Ep4lI9z1Cwg==
X-Received: by 2002:a17:902:ce91:b0:1b0:2b0e:d3ef with SMTP id f17-20020a170902ce9100b001b02b0ed3efmr4146316plg.55.1685482542944;
        Tue, 30 May 2023 14:35:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b001b05e97ee09sm2060115plp.283.2023.05.30.14.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:35:42 -0700 (PDT)
Message-ID: <64766c2e.170a0220.3c338.45c2@mx.google.com>
Date:   Tue, 30 May 2023 14:35:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.3.5
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.3.y baseline: 168 runs, 1 regressions (v6.3.5)
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

stable-rc/linux-6.3.y baseline: 168 runs, 1 regressions (v6.3.5)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.5/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c297019eca71ec5236ffe916eb37091de041bf23 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647638f94c0aaefb1a2e860f

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5/a=
rm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-=
jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5/a=
rm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-=
jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/647638f94c0aaefb1a2e862c
        new failure (last pass: v6.3.3-492-g1cd506b5ec44)

    2023-05-30T17:56:52.917550  /lava-10528814/1/../bin/lava-test-case
   =

 =20
