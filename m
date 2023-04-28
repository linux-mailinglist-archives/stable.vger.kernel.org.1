Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B786F1579
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 12:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbjD1KaO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 06:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbjD1KaA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 06:30:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2F81FCA
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:29:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f19a7f9424so72480195e9.2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682677794; x=1685269794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VuobEM20wENlIb/i1FLm/rwJYm5aDk2oP7/PSy0qYng=;
        b=NVmZAGNqQ4OUoAljrho2/Fqv77+8w3gn6clorQSkXP1FmeWFg8GaiUPbsKUTVfI0pR
         UC8Cv4mqsPX0Upt6sFgrJcVe+XYGr4VDKHPK+w2Er6avxhDGnOg1ar01opRcyrhsyBRU
         fUgJGTWRngyXtTAMzJIGcDOusy+XMjZI74xCKzU5s93BOIauIpfPuf6a6iOCDKT7PGgm
         HtNcwymAJ1+CsMoZyY+74ubmLWnFp7+O0hT0ZtbI+PWPKqGmajwpBbu07ai0NclY1Eux
         sCO9p24LxYfmbqdtbmAXvSJCgmf2RLOXUKH6Ew4GpSMq6+uD57LN2v3u4YtWNU1e5EMO
         1gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682677794; x=1685269794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuobEM20wENlIb/i1FLm/rwJYm5aDk2oP7/PSy0qYng=;
        b=f5f2nClkOhzjQzrvPfBgPnuQTdRZs8hF6DtE9YpteZKL5LYOBBcnbrHDGo/6UEr/T+
         c33jowEnjHYd+aojHXW1SAMQVmDVv1GQGIS5WkYJG69k1oArImNRDnKcKX9EtfjmYNW/
         x3SsQWsQM3tP9cO75vQOAKQITzMXVQDzOjW3EbUM2nV67GNJ7GYc6TG8K5YLVlFu1iim
         rDyRX5tx9EBtvCPQ+5oQrzOuv/i7y7vKUQ2OJL6w1sK+vCqufMzVKHqt7Tdj2o77s5i3
         98w5UXo0dZjup/FNiKpRjztSbL1R6dZsWc8acj/QXj4/2YPGzNsGHw4gambDKr8B/6Hg
         d+6Q==
X-Gm-Message-State: AC+VfDwrGuFYVPC+IFr4pppX7Rp7Qp2opkBsrkOyxjcDDMKQSIxx1bi3
        unpbuTInBWARSWqgjXTvxo6WIg==
X-Google-Smtp-Source: ACHHUZ4rzaQe95Xe8wrVDGhKDZoz7kPKSaaB0jpON89Rn6jckFmOWfUghkWvl0AWDVk3uxa8G3CXzw==
X-Received: by 2002:a1c:4c0e:0:b0:3f1:9527:8e8a with SMTP id z14-20020a1c4c0e000000b003f195278e8amr3625273wmf.21.1682677794503;
        Fri, 28 Apr 2023 03:29:54 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id c16-20020a05600c0ad000b003f198dfbbfcsm18154174wmr.19.2023.04.28.03.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:29:54 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 6.1.24 v2 0/3] Fixes for dtb mapping
Date:   Fri, 28 Apr 2023 12:29:25 +0200
Message-Id: <20230428102928.16470-1-alexghiti@rivosinc.com>
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

base-commit-tag: v6.1.24

Changes in v2:
- Add missing SoB

Alexandre Ghiti (3):
  riscv: Move early dtb mapping into the fixmap region
  riscv: Do not set initial_boot_params to the linear address of the dtb
  riscv: No need to relocate the dtb as it lies in the fixmap region

 Documentation/riscv/vm-layout.rst |  4 +-
 arch/riscv/include/asm/fixmap.h   |  8 +++
 arch/riscv/include/asm/pgtable.h  |  8 ++-
 arch/riscv/kernel/setup.c         |  6 +--
 arch/riscv/mm/init.c              | 82 ++++++++++++++-----------------
 5 files changed, 53 insertions(+), 55 deletions(-)

-- 
2.37.2

