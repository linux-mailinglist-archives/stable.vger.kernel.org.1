Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B139275D106
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGUSEb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUSEa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:04:30 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AAF2737
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:04:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666edfc50deso1527966b3a.0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689962668; x=1690567468;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A+SPKC04kfsdm0AJBj26PcNm5NY0wsiBX4r+9AXreMo=;
        b=NYuc5NXbwfVNzpO+he6g8PJ8+5jnKBH60+mrwfNDzyEFlqBy9WXJDp5q8RdLBJuuJr
         GjFvbnsLurMsN4q5Dcs3RGUsZevHzcJ0rTcXaS90qs5p6ceZKi6PUMsztFrMg3zmLGwG
         sIh+94OPQ07bpXW4Lmya8ur1+PDsvtWXUGB+2NNjlwOuSVc9OCO7yRYeVe5aIsZea5Jv
         do0L3gYlfENCDg+yw0zdK+m0Le6mS5pr0rxRB8Z8dkTQ0xkrxX+PrrWA7C5Izn5fJwLy
         MuoP0aMGSYFKMxUH+eKA+/+zxskIDGtYu1aaQhWaR8SVhvRJOkbrsc3ldWdRjL4Z9VCE
         Gbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962668; x=1690567468;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+SPKC04kfsdm0AJBj26PcNm5NY0wsiBX4r+9AXreMo=;
        b=NSdDW6nPbFmgcrX7lQL3xrqi+Js9Xuenq7QVCjENLbQEFVZbv9C+7kozG6oLWEMw7M
         2pj3l7/yT57rET70U32k1loiJeqbgA2Giv+wgQ3B0tSsVjsiMdrmRq081ZXFCkdKLyTB
         vEsUfZ2B1W3YQ9jw2ifAtkSKv+AVbx36blY2dg+MZtkm4CDlUtF3So7Axam++ZfINgiF
         1WXu6lX+7yTKrFAbWDFuoq5HpaAb3n7GBCEydITZBPjRjCDgKyI6Ov3JvxX8LlavFmuP
         FDBxzx2HNOmn4j+0R/OV+RVWBAQ4Gl20EPWFM4np3qcmSbry09K/KFXj6Al2bfGgUHHP
         qWUQ==
X-Gm-Message-State: ABy/qLa8v62VXx4HEntPOI2esgNhp/v8iumTDBAJCdv3hDI7MuQx1aW0
        D8TgEjiqhp8v/TaCZvk4c/KdQ+qnnLZ8yKW2GGI=
X-Google-Smtp-Source: APBJJlHto2HN9NatZ8wJNqz1VWgFNFhnxwiJSunsXsUZoEcHJ13BWBFf91rP0qcosS6UXmcnsTEgEQ==
X-Received: by 2002:a17:90b:1b0a:b0:261:2824:6b8c with SMTP id nu10-20020a17090b1b0a00b0026128246b8cmr4720179pjb.13.1689962668339;
        Fri, 21 Jul 2023 11:04:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a670100b002630bfd35b0sm4442815pjj.7.2023.07.21.11.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:04:27 -0700 (PDT)
Message-ID: <64bac8ab.170a0220.11f68.8952@mx.google.com>
Date:   Fri, 21 Jul 2023 11:04:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.120-533-g48958c96454b
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.15.y build: 1 build: 0 failed,
 1 passed (v5.15.120-533-g48958c96454b)
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

stable-rc/linux-5.15.y build: 1 build: 0 failed, 1 passed (v5.15.120-533-g4=
8958c96454b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.120-533-g48958c96454b/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.120-533-g48958c96454b
Git Commit: 48958c96454b9acda1f1117b5206838864697de8
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 1 unique architecture

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---
For more info write to <info@kernelci.org>
