Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1675E46B
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 21:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjGWTPJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 15:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWTPI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 15:15:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B861D1BC
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 12:15:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b9e93a538dso18742605ad.3
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690139707; x=1690744507;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1pj9WkR/BWQtfpGkIfCObqOWuoepjxYlipayAVs8qQU=;
        b=0SBKSRvTpjJ8+/32e1vEEgReqonhakCb6sLpLQkIshsQyaV+y+M6+irqzZeHmuXdj8
         fB04mFeKnxKqpV9G1rn23MknrPorTtP5W6poaC/l3cYNzZrnHWaTzvV31VRzYd65ykhY
         9ntCtn13+mjprJ0QP4znqragGnsUSR18KEbhwCwh/zYttlUl63zOxCckhDG9XmEuUBZO
         /IvaibfY5I7/hx5oSJ4psOUwC4oIIgr+rDlLgdFE6LGfWm4W8WtQ1oNaO/3AfvY96krC
         6KxXILcj0NLkrdCv8yjA32tYTCCF/tJXAIMY52mXllfHVjX1gqgLzSWOPzUfw3buCbc1
         QgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139707; x=1690744507;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pj9WkR/BWQtfpGkIfCObqOWuoepjxYlipayAVs8qQU=;
        b=TwwSQVy8HguBfhEkifd99WAO7JvStCBWhaoiD6mCbgU7/B7kFwN+SUn8Td8qu9fFCT
         l9XK77316Qlp4x9E2JrmsWlHAd5DT1TqNTnLns5lvbxctYEvPSEgl5taGH9HfARZvGGP
         EdRvklqv0ahOI0sSSzmBrsEb9qZA16eQNEFumxBsI4uCRTcXSD990R8YjZVQdN4R/vDT
         ZS/9fV+u83bBoTD1SnFHRrISDsDDeqVtnvrCubIJLj+wyCWKHutQURSxCszfu97vIT4h
         BsORhII4DcuOPXHPULM+J8lo+3r7YxpmD8mRRK/OyI1DD78OD9fwKQ48eDW9Urvlb9AU
         rFxQ==
X-Gm-Message-State: ABy/qLZ6uvUUDeP554dU1L8Q2e3nV5+FRNEgyI5NhVMl59CyBD3yPr+G
        lGpX2mkZz/3VfVWN2CSeKkB8sXfQK9HdLiH2e9M=
X-Google-Smtp-Source: APBJJlEgzuy3HiPGhNbmIIrA6ExDgGN0QXrSAEaFnFl7Y2rYAg02v0vwt8ROXda8r2Rxjw8XBXgq4Q==
X-Received: by 2002:a17:902:7590:b0:1b8:b275:3d20 with SMTP id j16-20020a170902759000b001b8b2753d20mr6270606pll.27.1690139706699;
        Sun, 23 Jul 2023 12:15:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b001b04c2023e3sm7175824plg.218.2023.07.23.12.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:15:06 -0700 (PDT)
Message-ID: <64bd7c3a.170a0220.ac6ea.c734@mx.google.com>
Date:   Sun, 23 Jul 2023 12:15:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.186-455-g64aed2315689d
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.10.y build: 1 build: 0 failed,
 1 passed (v5.10.186-455-g64aed2315689d)
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

stable-rc/linux-5.10.y build: 1 build: 0 failed, 1 passed (v5.10.186-455-g6=
4aed2315689d)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.186-455-g64aed2315689d/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.186-455-g64aed2315689d
Git Commit: 64aed2315689df8155c3b1dfcfb32b30df2cfd2d
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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---
For more info write to <info@kernelci.org>
