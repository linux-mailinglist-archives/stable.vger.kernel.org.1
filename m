Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D2B7545AD
	for <lists+stable@lfdr.de>; Sat, 15 Jul 2023 02:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGOArW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 20:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOArV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 20:47:21 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436BE3A9B
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 17:47:19 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3460aee1d57so11575155ab.0
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 17:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689382037; x=1691974037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZJjYV9nmYHhdWBo7q69wFF51OLjPoIEX5333fEgEUI=;
        b=aQUWuuFUT6YqG1qs6Qan4mOHVx0kx0nnIkBffGtSrJalgydnaLNFnZMmHtESM6qAR4
         UiVZh2TCBVbuXbJ4mvWvLXutP2FK8BfZ8KrPMrPcGArBwPBJQt2EjW/QfrDcujURm+1o
         mIbCMRNtwZV7Z9ytkEX9DV1m7prZazo2+iagM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689382037; x=1691974037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZJjYV9nmYHhdWBo7q69wFF51OLjPoIEX5333fEgEUI=;
        b=ickyZFu4PksBX7xAIcy7sDBglXel03vG2ce9K+tnuYKiWYfZGxOq+RJtLEUHLMmA2M
         Kgex/FvfkoAeUE6wvd/Nv0xJqcHd9qbAWSqi37XbVLEHoM4rZeKRcFHEtgG/seD5UA9L
         yERc3AjsbnxosGkn3LRMEuVEXtpLGRhSjAEG4S9TvxayPlbzDZ8EqOKngCNwtjPNMaU3
         l7oJVieFeBYU49F2klyKuXgrIyDxGejCncdVoLGizLkQXgI6QvjA/Lo3KyxzM2sxjFli
         vaVGSSxR6S2j4Wfv1OF/DRGRnPwCZrC2FBfnvcqlCZ9WNza0kEOkozaFopFzLZTra9Nz
         gFpw==
X-Gm-Message-State: ABy/qLbaFhN1UolBGCt4KU8q1U1ikBylhxcOs3gJMnk8k3MqI9HPLXa/
        tDrW8sjBV5tR/DwFHy2Pcl2O8oirvq7vhED0BRI=
X-Google-Smtp-Source: APBJJlFwb1+NgaLwZCZAWgwHjUyXdqRaHFfA6VDYnCtvyeERX07UVAZoSey4F1U5Sym+0I4isY6hwg==
X-Received: by 2002:a92:502:0:b0:347:223f:92f4 with SMTP id q2-20020a920502000000b00347223f92f4mr6302379ile.24.1689382037498;
        Fri, 14 Jul 2023 17:47:17 -0700 (PDT)
Received: from rcubot2.c.googlers.com.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id x16-20020a92d310000000b003486fa3e78csm643420ila.11.2023.07.14.17.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 17:47:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH -stable v5.10 0/3] Fixes for rcutorture TRACE02 warning
Date:   Sat, 15 Jul 2023 00:47:08 +0000
Message-ID: <20230715004711.2938489-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

These patches required to prevent the following TRACE02 warning when running rcutorture.

I confirmed the patch fixes the following splat:

[  765.941351] WARNING: CPU: 0 PID: 80 at kernel/rcu/tasks.h:895 trc_read_check_handler+0x61/0xe0
[  765.949880] Modules linked in:
[  765.953006] CPU: 0 PID: 80 Comm: rcu_torture_rea Not tainted 5.15.86-rc1+ #25
[  765.959982] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[  765.967964] RIP: 0010:trc_read_check_handler+0x61/0xe0
[  765.973050] Code: 01 00 89 c0 48 03 2c c5 80 f8 a5 ae c6 45 00 00 [..]
[  765.991768] RSP: 0000:ffffa64ac0003fb0 EFLAGS: 00010047
[  765.997042] RAX: ffffffffad4f8610 RBX: ffffa26b41bd3000 RCX: ffffa26b5f4ac8c0
[  766.004418] RDX: 0000000000000000 RSI: ffffffffae978121 RDI: ffffa26b41bd3000
[  766.011502] RBP: ffffa26b41bd6000 R08: ffffa26b41bd3000 R09: 0000000000000000
[  766.018778] R10: 0000000000000000 R11: ffffa64ac0003ff8 R12: 0000000000000000
[  766.025943] R13: ffffa26b5f4ac8c0 R14: 0000000000000000 R15: 0000000000000000
[  766.034383] FS:  0000000000000000(0000) GS:ffffa26b5f400000(0000) knlGS:0000000000000000
[  766.042925] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  766.048775] CR2: 0000000000000000 CR3: 0000000001924000 CR4: 00000000000006f0
[  766.055991] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  766.063135] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  766.070711] Call Trace:
[  766.073515]  <IRQ>
[  766.075807]  flush_smp_call_function_queue+0xec/0x1a0
[  766.081087]  __sysvec_call_function_single+0x3e/0x1d0
[  766.086466]  sysvec_call_function_single+0x89/0xc0
[  766.091431]  </IRQ>
[  766.093713]  <TASK>
[  766.095930]  asm_sysvec_call_function_single+0x16/0x20
