Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB28279D315
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 16:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjILOCj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 10:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjILOCi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 10:02:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2910CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:02:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50078e52537so9568696e87.1
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527352; x=1695132152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zno98FuHk7zQ2Y9buKLvxKctEwnBrjX7YmPzoNsXu4U=;
        b=XCKBYRO8Mc4LA/DMExwywLe3rrkcbgAuPLjPonKxlEe8n63+HCTTrM0RUwK8YmnNSI
         py9tZfkYWD976SXtep1VBO3Ea3FclvetRC8muDnxj+wk6Ya0LYfkXRy9MGoCtumgOnav
         bUFZlqbGPYovm0p3/60gHQCrdziWWQ+cuGFSn/1hcHDrcwNaVeDxnQtQzBfN8vzVYiZe
         xrN2OXvXtngpUjPP6UX+cBUoosqnL51WB4F1Bd698i11LF/omW92E5HB3FqPiltYVKLq
         +T8In1G72O5poz0+ypnn6exfZWe/Bqnku7uT6m/uqQlorcnUI32YB1SL7zRQRT9jMrAI
         1lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527352; x=1695132152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zno98FuHk7zQ2Y9buKLvxKctEwnBrjX7YmPzoNsXu4U=;
        b=irvkZv1YFfyzhgfHHvMg6jGxoeYMYi5h/lkEv79KoyZFbrZPKdf/xPCce3veR59dQ1
         vP9IjSejbJD+7mCF9SIzIFv62fS40NZ3aI8Sgze5jSs1PDvF+i/QUT2F6Y8BRzMgKQ5d
         6oGKteY+VoMFGNZc2BDeyp6Nyt/y228jpN2oYpga3hpS9hrY8NBPZaO7JNPeDjzidWxe
         MzYXd+VijKKMJljooYIhmmlDPq3V7vx3E4oVOEmKy5mAiUHRvV9TTHGGGjG39AAkT4vy
         UtbsBA3sk4NAf8uTbUd0geRuNZKFsksY+uSVdk3OFMQyk6ExBzTbnNY94t+0JuT0MVr3
         0NLA==
X-Gm-Message-State: AOJu0YxY8q5GlGNKRddQD2BErn3NXWkUx+RJvSV/yeKa2M9Cy35p6Dwa
        QIuBDc81ZK7gMytl0l5hDtWPcub4ozo=
X-Google-Smtp-Source: AGHT+IFllLUMaHA2kbYc7KAXHk8/dxt2XLrdQ+dfBcMP177mWRosNvQYKj/AR7TsIXA++58i0OC4sw==
X-Received: by 2002:a05:6512:3d2a:b0:500:9a45:636 with SMTP id d42-20020a0565123d2a00b005009a450636mr13563236lfv.13.1694527352277;
        Tue, 12 Sep 2023 07:02:32 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id pk24-20020a170906d7b800b0098d2d219649sm6997770ejb.174.2023.09.12.07.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:02:32 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com,
        Dylan Yudaken <dylany@meta.com>
Subject: [PATCH 1/3] io_uring: always lock in io_apoll_task_func
Date:   Tue, 12 Sep 2023 15:01:59 +0100
Message-ID: <83d9ee49014ac3c453f9d338bcf18dcba1be947d.1694522363.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694522363.git.asml.silence@gmail.com>
References: <cover.1694522363.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dylan Yudaken <dylany@meta.com>

[ upstream commit c06c6c5d276707e04cedbcc55625e984922118aa ]

This is required for the failure case (io_req_complete_failed) and is
missing.

The alternative would be to only lock in the failure path, however all of
the non-error paths in io_poll_check_events that do not do not return
IOU_POLL_NO_ACTION end up locking anyway. The only extraneous lock would
be for the multishot poll overflowing the CQE ring, however multishot poll
would probably benefit from being locked as it will allow completions to
be batched.

So it seems reasonable to lock always.

Signed-off-by: Dylan Yudaken <dylany@meta.com>
Link: https://lore.kernel.org/r/20221124093559.3780686-3-dylany@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e4de493bcff4..fec6b6a409e7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -5716,6 +5716,7 @@ static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
 	if (ret > 0)
 		return;
 
+	io_tw_lock(req->ctx, locked);
 	io_poll_remove_entries(req);
 	spin_lock(&ctx->completion_lock);
 	hash_del(&req->hash_node);
-- 
2.41.0

