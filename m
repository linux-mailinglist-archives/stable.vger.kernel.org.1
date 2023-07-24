Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDBE75F48A
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGXLJV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 07:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjGXLJU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 07:09:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378E10F4
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 04:08:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb775625e2so13965205ad.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 04:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690196896; x=1690801696;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QOvlioC4rKzBhy0MpdBD5rmoguMUIdou06Aq2BBueN8=;
        b=nImh/e7al6ekT5YAoFIv0yHbJAFsKFYqoYTM7S6GROceX+BRE9YnpRtNvfBImWQVlv
         skJer5N/j8micGkJ2QfF1GAO/h0V6po3zulXf/+9Y4ucJhBSx0DSFgjlueJfavh8wA5u
         SQXfDgBpjgpMvxSU7Pw6Dz7v7wuEHHQ2E/aX20WZ9FXkOiXVGBThHjWSqdHs7+6KMux9
         6ZQC1hJKjzh6rly/sau/wKbYby8CQx6QS63anlNlGsY6p/c7U4CmqkY07y0MajMycg7x
         CF0cui6G6FW8LVAWXKP9/G1NVaOOth/Layz6gNMf1UYP1R/mUo8TLMPdGXx7GoCD2Un5
         kHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196896; x=1690801696;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOvlioC4rKzBhy0MpdBD5rmoguMUIdou06Aq2BBueN8=;
        b=Epiw9tnew5P2uMpy2kgLLotJ+sDVFX1ECI1niw9co8Jn6oxS7yHG08CJc/qApaYkBR
         eI26eYGzKHOmvY0LcAwpl+nEFukyGkYXvikzGIhnGULc6div9XjyTZBUDI2DwMk8P4D7
         QRZvGhKE9buS+5CpT1IY1Lo13F/yQhIZQ0ujeperMr4MBqd9oUibHZb1N05GgxPzAxqX
         I0M/vj8kokF6CTZQL2XiHoKynZ9iWE4EasA5ZAgQJ7TV6LDUXXxFxrC93F4ICsoDmE0G
         wVITOR4iYXqLvluUgMwtt5XXzNrChFEPpHOTPe+zw7+En4IwVTCS3gINibHJS0AbyIWu
         Pb9g==
X-Gm-Message-State: ABy/qLbi+pUG23gMDm51luaXWsq1wHwpqH8mleghnpcYIFHeVOnKPacf
        my450WuRcMLpsTBOxNxxt7Ys1c3hITEgZlMVuQVF5gVH
X-Google-Smtp-Source: APBJJlFnHlF/AwiUlUTHUPuxioFu4NGtvNR4K0sAMG47jsfmPRvMfgEOqgs/NAPaPedznMBnfTs4tA==
X-Received: by 2002:a17:902:f545:b0:1bb:55be:e198 with SMTP id h5-20020a170902f54500b001bb55bee198mr12858393plf.0.1690196895765;
        Mon, 24 Jul 2023 04:08:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902868d00b001b85a4821f8sm8572495plo.276.2023.07.24.04.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:08:14 -0700 (PDT)
Message-ID: <64be5b9e.170a0220.697db.e937@mx.google.com>
Date:   Mon, 24 Jul 2023 04:08:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.40-172-gd796cfd075afc
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 2 builds: 0 failed,
 2 passed (v6.1.40-172-gd796cfd075afc)
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

stable-rc/linux-6.1.y build: 2 builds: 0 failed, 2 passed (v6.1.40-172-gd79=
6cfd075afc)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.40-172-gd796cfd075afc/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.40-172-gd796cfd075afc
Git Commit: d796cfd075afc1c50fd811cd00d8844e6749641d
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
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---
For more info write to <info@kernelci.org>
