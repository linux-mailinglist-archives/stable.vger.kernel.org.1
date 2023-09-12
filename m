Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0B679D2F3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjILN4G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjILN4F (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:56:05 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C2D10CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:56:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5007616b756so9330981e87.3
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694526959; x=1695131759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0vDCZC07WoVjz677rNQsPwUxzThva8Nlzh2FzhLhC4=;
        b=iLa011Co77/Zr2fx+Hq25aGEKQWLaAdxOgLqU0COJeuAP45eQqJCTtja0Vbt7BI3cr
         xx91CUAYjndL5Ve4zx7p/GGSgjgy7LVhFxa0GxSXnvXIOEOu9CeYYGgRPORMG25lMTfG
         oOnW+jKmvvuc7yYnX0ymkpauURhsoU5ymddiMi9AU2v5vd+cnHBh6aGwL9QXj9XRMySk
         uBIRXG9qzgP4ibJvVPzPRw1N9B22YajpwDRc+gFG6Wvya+q7jXd2SnI0Dzbnw0MgqBxr
         iZRo0B1HqYDAqfgEcGAPDp27mDhmNFyLrD085VKKi2fF8CM4KG3510ZzQXyZ9HuyVB+J
         KLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526959; x=1695131759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0vDCZC07WoVjz677rNQsPwUxzThva8Nlzh2FzhLhC4=;
        b=IDT7BuGQ92n3WS4oYtcosovCtRW+81sObzcZyC2Q7Nd+Vu5pSEj1q3cLeH449bSuxz
         LPGPmgOw3UX2QDWwTGNtXzcZ9pvktodONrvN+c3YJbgWLDqfDXfCKCzvSeCv3ku3d2bC
         FHa1RA1gcSQcVsVNo1J3idQuQOnMmh2k0ZKh6ZYStw4Q5yV7+/ak+w2UT4uPHpRrlJvZ
         CFi/MgYi+Rbjd/cO02K5qz8i6PxPrb4uuklBNWGKmcRrFJuqscdDIi7JwCjw+0zb43JS
         XqXUnwSoxLv13jvqPKb9rq8uX8AGGFhzjWiQ5SGNLL2CyHqrKKlCYDNFxZABKU9XutKq
         9VEQ==
X-Gm-Message-State: AOJu0YwwA2AwM+ZIFThBNrdW9r0vM5iy0L8C4GlzgzcILE/Z9jTk6dEB
        +BF41UFrsFgA5GShtK6MykfK3mFvSQI=
X-Google-Smtp-Source: AGHT+IE3Hl27d8ENz63NnpNzaEkevCjoT5COcOM5Ej9T+GsX05UAg62zmzj68ShxPE0Gs82B5jLWyw==
X-Received: by 2002:ac2:4c86:0:b0:4f9:596d:c803 with SMTP id d6-20020ac24c86000000b004f9596dc803mr10054184lfl.53.1694526959158;
        Tue, 12 Sep 2023 06:55:59 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906344c00b009a5c98fd82asm6802337ejb.81.2023.09.12.06.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:55:58 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 3/3] io_uring/net: don't overflow multishot recv
Date:   Tue, 12 Sep 2023 14:55:24 +0100
Message-ID: <df016c103e360c3d26e62bcd64fcef748ac14ce1.1694479828.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694479828.git.asml.silence@gmail.com>
References: <cover.1694479828.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ upstream commit b2e74db55dd93d6db22a813c9a775b5dbf87c560 ]

Don't allow overflowing multishot recv CQEs, it might get out of
hand, hurt performance, and in the worst case scenario OOM the task.

Cc: stable@vger.kernel.org
Fixes: b3fdea6ecb55c ("io_uring: multishot recv")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/0b295634e8f1b71aa764c984608c22d85f88f75c.1691757663.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 0aadbd72b7a9..0e0cc8c8189e 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -635,7 +635,7 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 
 	if (!mshot_finished) {
 		if (io_aux_cqe(req, issue_flags & IO_URING_F_COMPLETE_DEFER,
-			       *ret, cflags | IORING_CQE_F_MORE, true)) {
+			       *ret, cflags | IORING_CQE_F_MORE, false)) {
 			io_recv_prep_retry(req);
 			return false;
 		}
-- 
2.41.0

