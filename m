Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E666F15D4
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346080AbjD1KjX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbjD1Kiy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 06:38:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7046BE
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:38:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f315712406so54997745e9.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682678267; x=1685270267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1s33BqkwrOXWldobYRmvBQUVHfxB//MQJek/skSRYxk=;
        b=Cmb1h2L7cd2EOX1u4sUl6N2lAXgWD8e8aFjCf+YMCV0FSIIvXARx0jh0Bph/oda0lq
         QlbZFhgap2Aljgq2Hnbic3FH8xEJEqrPRlMGLhjKVhsR38GK0py0g3h/eI/NHk8hDdvy
         EzHm8CpMuVtYrXgWldKFJY0m/nAsI27ImmgRWxCvW9GcBDQv4DdhOG4gN74l3nRMCN/6
         VqpCIkOzM07qrWJr+bn7a+jm6PH7AHVjHhmwhIBKnzJUUCY31w4QMFA1Qd8mqG6bgAbL
         g3M0XcTPTqqFnJIHvuEevt/qqBd2h1HlZnt8ra2I+gKjY8SCT6ldRTh6JN1Upsz3jpaK
         bVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682678267; x=1685270267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1s33BqkwrOXWldobYRmvBQUVHfxB//MQJek/skSRYxk=;
        b=LvHOEzbdIIsCmDPowuDe1pa0iLMyURrsCtQjH2X6Tf9SAKrG0yKLt20H7Ey/MFtOwK
         czUmaJWBatBwJ4KkY6N2HLgLFm4hqb60q2QjBM5FFqlALkZy4cvlNsvZ2lK5y91Cxldb
         AMHV5p0eWbfwxbU5sdzqbyg8rsKWTnv68R48SFwmHBak4Rw8/ow3UE2Hjof+PTR7M77L
         M2C8QDy2WHfh3Cqlajvq/r8XO2svxzAW03VE6dUfHkTfxfbrhYdXEYr9aMAMP/f1BN1y
         kYiQqH5D2yZAIlkUbNjFIDdTNtPyY+hNPrEa8UmQrW6F/3u6Cywe8WkTAE/NvQ/zaB16
         ToXg==
X-Gm-Message-State: AC+VfDyn0w7ycSHWG4DmDGE/yDHnGLaVnht4hH1vTHYDo+5vqFtNO+IF
        19upk75/bBfsX6eTvwbkUynO9w==
X-Google-Smtp-Source: ACHHUZ74oXoVpbmlbHNTVnJE7yfKI9SCM66Ee81Pq4N/syTAakZHHN6ZXnctamj8kWiIQVtYMO0KgQ==
X-Received: by 2002:a05:600c:4706:b0:3f3:284d:8cec with SMTP id v6-20020a05600c470600b003f3284d8cecmr867941wmo.2.1682678267736;
        Fri, 28 Apr 2023 03:37:47 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id t13-20020a7bc3cd000000b003f173c566b5sm24009495wmj.5.2023.04.28.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:37:47 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 6.2.11 v2 0/3] Fixes for dtb mapping
Date:   Fri, 28 Apr 2023 12:37:42 +0200
Message-Id: <20230428103745.16979-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

We used to map the dtb differently between early_pg_dir and
swapper_pg_dir which caused issues when we referenced addresses from
the early mapping with swapper_pg_dir (reserved_mem): move the dtb mapping
to the fixmap region in patch 1, which allows to simplify dtb handling in
patch 2.

base-commit-tag: v6.2.11

Changes in v2:
- Add missing SoB

Alexandre Ghiti (3):
  riscv: Move early dtb mapping into the fixmap region
  riscv: Do not set initial_boot_params to the linear address of the dtb
  riscv: No need to relocate the dtb as it lies in the fixmap region

 Documentation/riscv/vm-layout.rst |  6 +--
 arch/riscv/include/asm/fixmap.h   |  8 +++
 arch/riscv/include/asm/pgtable.h  |  8 ++-
 arch/riscv/kernel/setup.c         |  6 +--
 arch/riscv/mm/init.c              | 82 ++++++++++++++-----------------
 5 files changed, 54 insertions(+), 56 deletions(-)

-- 
2.37.2

