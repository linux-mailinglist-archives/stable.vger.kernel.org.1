Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463EC75C740
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjGUM6y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 08:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjGUM6u (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 08:58:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29B3580
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:58:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b9cdef8619so12978055ad.0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689944317; x=1690549117;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ4YpnYCGUdztkAtW3QTJlJ4LpbdGYK0fvDw2eJSiKk=;
        b=0k+Kj9f6O8qlYjDaDxsNzdRSM6tLaIvcr+SoHDsJjvUoyjvnHZYKoMypWPCdy5Eh1a
         HQ8YO85Za7EEpwSjMUrr/sd1hqDQZ42gIDhN1VLihEy163zpYz0BiIJl/IQ6FdH/+m8R
         RF7eedXx+gqkYSL9uzNH2tsmEcSR1PzhJoO22yvUADRWstE7YWd1798EHHbbFkLISNQP
         9CWoKIs9tO4LVB+ZeH4CnldEMQDBAPKAKAcOAIcsyXTHkFollzcRXOtA+6UZXnh6JoiN
         RGGOW+Fx0ih18+xCO6NN/6WdXLpgEd+nQYUQ2f39DP/bYKJXsydzLPPiHgr1fdRHqSxX
         V7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689944317; x=1690549117;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZ4YpnYCGUdztkAtW3QTJlJ4LpbdGYK0fvDw2eJSiKk=;
        b=Na0Tx5cns7HnIQdVUt2RIyS9LIBCeihbxNqX5pq1CYgE/WAOBF3e6iSrgqBMDdDvpA
         6MvhpBXFYquBqyKnkM/FmmizhKXlXij69k8RRp5bm71jqr2PqTNY6lJyrUGZc3OLDvY8
         AEPdvGSpWdVAM7fPYBdRCdUL2nMFnn9EbWJJDpEtIkR7mirwOpJKTLwpRga6G3TOs+Uw
         VtsTFP8AR1nyyNOAZME318nmOKHNwZDDrP1AA4Y13T/vfIaimLYk+NgJJqmlKgNezAiu
         4mwDhJnzzyiJkkeheCNRIHJH1+iRXFW0mQfcdAuheeYc8Dwf6k53/7Fd+2wf5Z15LLbU
         lV/w==
X-Gm-Message-State: ABy/qLaVYuziFyKq3QNOOBjx5IDY88XptMf7/mZB8pX7euT78pgsLxBv
        xNwArVA8E4TWyTUxtSjTVHYUPkL2ph1YUYnx194g0A==
X-Google-Smtp-Source: APBJJlH/g2QYjzkdsCwdBNGsipxce2lLkb5qwKplQDa5Ml67XxI2Cj0Vxxt45SbPh33ix4kZ/8mfig==
X-Received: by 2002:a17:902:c1c4:b0:1bb:6eeb:7a08 with SMTP id c4-20020a170902c1c400b001bb6eeb7a08mr1158154plc.10.1689944317158;
        Fri, 21 Jul 2023 05:58:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jl14-20020a170903134e00b001b54a88e4a6sm3401372plb.51.2023.07.21.05.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:58:36 -0700 (PDT)
Message-ID: <64ba80fc.170a0220.dfe42.633f@mx.google.com>
Date:   Fri, 21 Jul 2023 05:58:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.320-105-g282438860ec9
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-4.14.y build: 2 builds: 0 failed, 2 passed,
 3 warnings (v4.14.320-105-g282438860ec9)
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

stable-rc/linux-4.14.y build: 2 builds: 0 failed, 2 passed, 3 warnings (v4.=
14.320-105-g282438860ec9)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.320-105-g282438860ec9/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.320-105-g282438860ec9
Git Commit: 282438860ec92ec9e8b121075ca42f80a0c1b8e1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 2 unique architectures

Warnings Detected:

arm:

i386:
    i386_defconfig (gcc-10): 3 warnings


Warnings summary:

    1    ld: warning: creating DT_TEXTREL in a PIE
    1    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    1    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 secti=
on mismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
