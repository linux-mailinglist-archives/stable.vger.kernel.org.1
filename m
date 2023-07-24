Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15321760323
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 01:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGXX3T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 19:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGXX3S (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 19:29:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C603810F0
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 16:29:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26837895fbbso109458a91.3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 16:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690241357; x=1690846157;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=77YcIZU04bzjYpiMcBt2g/X7UC25zSq1wFli1geXVHs=;
        b=YW1fdOKO0H8iLHWaF/8bDnGLS6hSfzSPnptmD6/sbm7eQWqAW09ZScPEfqyI6+3b9M
         +UzQrL52vv4mdZB294yioVVrVjc9QB+L0EBfsUisYvTgW3px42537U1TdVBpG9zhtvqO
         y0FFK4vIWsUkHFdqQt9WqZKoqlEZLsKruSXhnQfuMlRgIPu7cMo8078vXUR8SNYUmLHH
         oC0VF+aK5UiZHGFOGTCahzSpgM85vkfT/sxzI5Nf8j2wcMiF7Szd+P4hsP2/dtkUJoXG
         taVGG7E6aBfmOHfgbLPS6Nlli8mmu+bZQDmrzgbMCwT/CR+/Zw4n6UFWg7zWIWFlfUUv
         kYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690241357; x=1690846157;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77YcIZU04bzjYpiMcBt2g/X7UC25zSq1wFli1geXVHs=;
        b=fdkecOimcBsiLUGtzekFGZowUwrnHBuEjMnZgQcwXhtlhh4UCSU1iDtlY2okv/igS1
         FjRucdWT3yzXWbc3hUV9QjGep+c0PJIE6aFQi0PN9ck6jlqxneflm/51EfhWwidczQGu
         45ABR6ycxczSuJcudZr/UKSZjtIL+1aG4yqqIpncc91nJ4JGzK7h0b1tN4iAr8nmRBYL
         Vc3wlJh9JfLfWsPANDoryhdk4IZDyrkbqmNWU7tCQUI+qH2EcWrPoTPIXAUQlkZRhb/t
         ZQMyn8i0Fpo2df8532Ehef/eZbxM3X5gLSsHdA3IBCX4FEnWmECl1EEYlJYnl5IkEJ4p
         tjbA==
X-Gm-Message-State: ABy/qLb/6TomQK1vmRpsiWUFtlSNbFFWrZoqgFsTkJmoqup0aBI0s5Ll
        aMDxo0PdweCn1ahsuPM+yWeIzHLi1Oo3HSiS/Goiu7xI
X-Google-Smtp-Source: APBJJlG7q/3xXKxFVu3LfXqMt/wX5NvNXwpxLP3KR+BYMjDCR68kw10pYpxfiMYyuUZS43OOEr2cGw==
X-Received: by 2002:a17:90a:748e:b0:268:18d6:101a with SMTP id p14-20020a17090a748e00b0026818d6101amr4078429pjk.14.1690241356770;
        Mon, 24 Jul 2023 16:29:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gf4-20020a17090ac7c400b00263d15f0e87sm6962495pjb.42.2023.07.24.16.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 16:29:15 -0700 (PDT)
Message-ID: <64bf094b.170a0220.bfdca.c0b3@mx.google.com>
Date:   Mon, 24 Jul 2023 16:29:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.122
X-Kernelci-Report-Type: build
Subject: stable/linux-5.15.y build: 2 builds: 0 failed, 2 passed,
 1 warning (v5.15.122)
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

stable/linux-5.15.y build: 2 builds: 0 failed, 2 passed, 1 warning (v5.15.1=
22)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-5.15.y/k=
ernel/v5.15.122/

Tree: stable
Branch: linux-5.15.y
Git Describe: v5.15.122
Git Commit: 5c6a716301d915055c7bd6d935f7a4fccec2649c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
Built: 2 unique architectures

Warnings Detected:

riscv:

x86_64:
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning


Warnings summary:

    1    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unr=
eachable instruction

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
nommu_k210_sdcard_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
