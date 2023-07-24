Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99826760180
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjGXVsT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 17:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGXVsN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 17:48:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308E1712
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 14:48:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso27458965ad.2
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690235292; x=1690840092;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n8AB2GgMyaBIxVgnfrXcmMN6DGjOr40AwmdkS6MirMQ=;
        b=Sbcyn5bD6nWBYI2kPWdxCBUJ/c1uKCr8S2b2lbF5MWlejspdyIe4jGxGSPz4DmJBwX
         OWkeaF/SignGXsAwO9rWAzFAShgIUfq1i4bDoFPMBHsn2Po7uBZPRq9pJ/aFCUXA8eIL
         OorpTC8ki3WSJbywevRZrbMfY1Kle+exNseCV9JJn/fhFIF9lQ1NFFM47Hl9CBcq/YzH
         H9yovm3dP3mRqRCqz6sv7MEJi/itK03flfMapF8tnXwVuKbqRGJfh3WEJMMlslYBZmND
         apPvSoz2C86DHA+z/+hpn9rpU+06VEshu/jxyADuNaSYJcc+BKUjoMzdyg0bFIcxjgWh
         5gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235292; x=1690840092;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8AB2GgMyaBIxVgnfrXcmMN6DGjOr40AwmdkS6MirMQ=;
        b=Y4Pj3skVUYQ/Gd6lXD33wDCl7pwx6souX4HBxUSRVUasfbxCn5R9oFYqZPQCPC+42u
         rvJpXX+SEUNiJvNwTtmZIUGlS/6c69PEeDfr+WY/3M8bw0uxIQghRPFO5E4XD4yS1NUL
         YvZ4uJ3ZGrMROauPhiKKlYnVVo/auobrfeY7c/p3U43Wf1usdEtRRGROIRFZW4tKiF+/
         yJX5t/70eKejNFcGb++8de46u653PcR5MnLhcawOqF6LHj76gOb/LssuNw/A3B959IED
         Bkp+0okFcal15HLXcUlCxCCGfxSlaOAzovJeUHvCZb0zAbH1j6vVFD7M12JRbV8JxHIH
         Ntvw==
X-Gm-Message-State: ABy/qLaUoeLNi/hbttTZIWl4Co01dJKLigZ5NeRpvWiNOjSpvpriOi3C
        m0hl+7T4xOLaToStLxU1WSyHlbeuQq4FJV/JnrbLnF1g
X-Google-Smtp-Source: APBJJlHi7VUlw97GradX7Tytl7eu8lNmbvxt9CvPgc+YwVq69Wh65fff6f1xtkdIchyBz//HOb2zOA==
X-Received: by 2002:a17:902:c951:b0:1b8:63c6:84ab with SMTP id i17-20020a170902c95100b001b863c684abmr10605035pla.61.1690235292009;
        Mon, 24 Jul 2023 14:48:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902b28300b001b8a897cd26sm9423231plr.195.2023.07.24.14.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:48:11 -0700 (PDT)
Message-ID: <64bef19b.170a0220.f0a4b.0fcb@mx.google.com>
Date:   Mon, 24 Jul 2023 14:48:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.289
X-Kernelci-Report-Type: build
Subject: stable/linux-4.19.y build: 1 build: 0 failed, 1 passed,
 2 warnings (v4.19.289)
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

stable/linux-4.19.y build: 1 build: 0 failed, 1 passed, 2 warnings (v4.19.2=
89)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-4.19.y/k=
ernel/v4.19.289/

Tree: stable
Branch: linux-4.19.y
Git Describe: v4.19.289
Git Commit: 767049cead76cf699707290d5aeefb3e4d0d5b43
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
Built: 1 unique architecture

Warnings Detected:

x86_64:
    tinyconfig (gcc-10): 2 warnings


Warnings summary:

    1    ld: warning: creating DT_TEXTREL in a PIE
    1    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
