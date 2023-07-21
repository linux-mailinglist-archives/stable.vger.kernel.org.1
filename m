Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B860975D52F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGUTpe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGUTpd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:45:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0B11BDC
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:45:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb7b8390e8so1412455ad.2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689968732; x=1690573532;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U7dqxR39ZajSRax+DH0M1HQre567QpFGwZtqgnXs8OM=;
        b=IekUvqPeZhTnSXVwIRQA7SNaUJENA+kY8W7iQni0IkDGesefMz9KKi2fLIgQEQf4Ez
         Ww7NWY21Vua4KqJksIV9zO49wrP2h1IsLpLpc8BGKkAmw7LLBR8odJ9ScFI6oYACJxVu
         nLG6gMnQOH068KrKpYL9RX1hG7qyhXpLxdP6wL7uLGkSxwaGRolX7+iRUfSbk9Jn2Tc0
         gv2mswxifgqmooCtBvmZ/wvegoHXxp2M1usIxwtsaHWUn7ZIYPFA6tHf7hmu+QAKGT2J
         XtzJTwz4/XIqKP++HHaVF7vQdlIf8cci6yY6J6tkj8p9Vhabue7khEq9tzyKDMprnEps
         LdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968732; x=1690573532;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7dqxR39ZajSRax+DH0M1HQre567QpFGwZtqgnXs8OM=;
        b=B6L8oRGVu5TWhbwWsoTwakUVyvAQyCfnIvRil8h1HXgD3j+NwfOEEC3n5OlQ0YvFLC
         wL77QBUoMgMBOSoYmTepIENnZiHt5x+GCojGopwkoq/cpO+2hWEtaKhkuRZ+ze4o2gBZ
         8iOC+Fw9QH7OR+wZp/WHAnaVee20nCDBlxouM3T1dvW/LAfavm3EuY16wWJC4YX/An6L
         ptk1qmOxkRkRk0FhCCUf1vfNEPncjQY+VBwvE2840W728snHAjWqDnpQRngTFVnWExQW
         F/Gv3dSRq9/AUhvfHziJzYBNBfU6YjJuxqKPf1xvSuDaZqu70f4bQhfcTHrJQjK5H+63
         maAA==
X-Gm-Message-State: ABy/qLZ3HADxKkdvkvBUaPLcnZWKeS3q+3w0OyVBkdg415wnINW0qorW
        yF20YWjX5N23zuiUZ8Mp6AZz2U67NM11cG4G5KI=
X-Google-Smtp-Source: APBJJlEwZSLa4vFMAhYKGMsI1LcgK3U1CMg6jn2n1fkoDZ13D4HBFF875LYose/XVOSVdFPS+UUQCA==
X-Received: by 2002:a17:902:c950:b0:1b8:1c9e:4453 with SMTP id i16-20020a170902c95000b001b81c9e4453mr2904863pla.4.1689968731986;
        Fri, 21 Jul 2023 12:45:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l1-20020a170903244100b001b3fb2f0296sm3894627pls.120.2023.07.21.12.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:45:31 -0700 (PDT)
Message-ID: <64bae05b.170a0220.83dd3.79c1@mx.google.com>
Date:   Fri, 21 Jul 2023 12:45:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.288-188-g71e850d72cc5
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-4.19.y build: 1 build: 1 failed,
 0 passed (v4.19.288-188-g71e850d72cc5)
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

stable-rc/linux-4.19.y build: 1 build: 1 failed, 0 passed (v4.19.288-188-g7=
1e850d72cc5)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.288-188-g71e850d72cc5/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.288-188-g71e850d72cc5
Git Commit: 71e850d72cc54c75316c30f51b1163a0da4f00e1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 1 unique architecture

Build Failure Detected:

riscv:
    tinyconfig: (gcc-10) FAIL

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---
For more info write to <info@kernelci.org>
