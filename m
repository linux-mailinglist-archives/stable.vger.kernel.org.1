Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF17056F3
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjEPTTM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 15:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEPTTL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 15:19:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC917DA7
        for <stable@vger.kernel.org>; Tue, 16 May 2023 12:19:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53063897412so7144252a12.0
        for <stable@vger.kernel.org>; Tue, 16 May 2023 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684264750; x=1686856750;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0EqpNqgZsevT5xAqHb/uzEVM35HIUICcfZyWaHXiX2E=;
        b=wSElPkIgQgTYfjLbO+oc/gOZk+LttiFE/UaenSj/K2TNZMc9gIpl4mVjx5Vi865f/i
         G3KSLcnYJSk9hG/ImrP9uLgW+TzzYtfdbrHgLABPFGXQnvo1gaYwm00vFP0aID6HVQG0
         J079agioSwczrF1DAyjsOPoSnsguV0XGxm0+1TtoDPDaPGhse7ZEC3hNlMGAJxPAMB2A
         acKvWEnqLHnhCeYj4ZehPhQ/VZsuW0tghLY+OtIi9RdTWObOUrivxMlvrhKBw9NkuTxw
         sGk2GHTJ8L0Vwy4a59wIZ8aLbMue1cfd9fJSihUZeu9wicDlLj5/OW7OMrC6UvIEDWjP
         ZXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684264750; x=1686856750;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EqpNqgZsevT5xAqHb/uzEVM35HIUICcfZyWaHXiX2E=;
        b=H9eP18sxvUkDUCDtqLyU6+T4hQ+X3VPIl3Q0Nzh0rUuPZnPo7tuOr7xeCTFNGmaYdo
         Ylq52q45MHGvdAt+/KxQThBk/WcFMn9C+ZX2YNZxBov4OYiOtOqqgZXCwEvbNUDOeiU7
         yLHVyQZyIRrL06f/8FqS9WTEJgjV20EXRexWYuDvhRNVrJ3HoOB7yU1DNVgSPZZ9sago
         NMi4vwbMhRVTZgMTux92XhxG5KD7qp76atE7TFOI1ofUROdTGPcvjGaKQWxxaxuYCA/C
         Ly7gPerOSIdc1WK8raYE5eLPyN8/MfzvGg2zcRmJ5rDVMC6MzJtWf02u8d4XY3RS/Qnr
         QrRw==
X-Gm-Message-State: AC+VfDypyP8ysHLbJepSc2nVJbAEz9STUTLGhbqr2eipUfTFDn/qX4DF
        251rQxES619M2pYqhUBU3GdTxsQEI9Af0fyW4RqCkw==
X-Google-Smtp-Source: ACHHUZ6tmYJD2K5+I4OMvN7GHoCqOsNiqc6D96Siy6qSYcYYfwkozPAtMiVNrpbQG/+hP7pgMF0Rvw==
X-Received: by 2002:a05:6a20:938f:b0:103:9871:7403 with SMTP id x15-20020a056a20938f00b0010398717403mr28035968pzh.31.1684264749986;
        Tue, 16 May 2023 12:19:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k13-20020aa792cd000000b0063f1430dd57sm13685651pfa.49.2023.05.16.12.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:19:09 -0700 (PDT)
Message-ID: <6463d72d.a70a0220.b5e9c.b7cb@mx.google.com>
Date:   Tue, 16 May 2023 12:19:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-238-g3eb27d124b83
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 95 runs,
 1 regressions (v6.1.28-238-g3eb27d124b83)
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

stable-rc/queue/6.1 baseline: 95 runs, 1 regressions (v6.1.28-238-g3eb27d12=
4b83)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-238-g3eb27d124b83/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-238-g3eb27d124b83
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3eb27d124b83d4ddc4e2cf46a904ce4cc8adf6f3 =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6463a5fdd8f34d87222e8622

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-g3eb27d124b83/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-g3eb27d124b83/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463a5fdd8f34d87222e8=
623
        failing since 26 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =20
