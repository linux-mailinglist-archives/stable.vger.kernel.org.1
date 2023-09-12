Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4D79D317
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjILOCl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 10:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjILOCl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 10:02:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EC810CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:02:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-501cef42bc9so9314081e87.0
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527355; x=1695132155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQKWmjxlOgD0sFnV2w19yinXyEz+FYaCQSbQXdSTv04=;
        b=lD3aLPwb2jrZdljn1gnaMIr73eE3oTjfkhb8BiZxt5Uo7vdOYBj2Odm1G5ZfSox6LH
         qWG/8et8oDfa6wo/sVygGXMFF9Oa1DlBV5UMKFmcSt58qU+2kSNWCT6BXmZtap3GXIiy
         79CA8Eop1wmBA0x8/+mun/IWL3kSAnBswt3k2XW86y06ymCq5nfxBes1vXCtiNuKUmjz
         VD95/B+09D14+EFo7YAPl4oTZFIAfZ0ILcnnv28cWDw6j7LwEGybiR2P1X5VQLxMEVTB
         Rhl1T6WW6WHs1G/nSWtVBy+nHlI5vYI6m9uMPFb7A7efqouWbROc2RXKIBWkFfPk8pOU
         8iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527355; x=1695132155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQKWmjxlOgD0sFnV2w19yinXyEz+FYaCQSbQXdSTv04=;
        b=LyNm8hyxcExNop82E743tuFdTdFuSCOZWZmwymwUjbCZPzzPfHJsHCpCPqSsu95x5c
         kIHwMIu66NlqgIXIYWkdAs74cFJrDkJKZqVoT6Vw8aAnDycUykZEQfmaNjDKnQ2cCCcf
         uVsMD0NEp4vn1UaMPhhvvG05wZ8CqZpqbhhkklGyIxXMH+kwnOeI0oXgtTjY5sz0m4zs
         wVAP3gYem2eaozJZb8OtksBXkvdvpRxM3mB/OU9y4H82aasuIbZ33g1BfYI/3iZyAcYw
         NArGr8Y/7/ANP4ccHfXsIqwI3XX+6eQHVUD7OBShYVrPTw6JjsKoi+HWq07L6XzpVygB
         3Kcw==
X-Gm-Message-State: AOJu0Yxh9p4jNClCrpYSpbVxqU8Usib1pADpBuGohEzNZS6+1iTLmk7j
        TTYtmZJHwDKUvUEYXIrgmPzBjJbAV1M=
X-Google-Smtp-Source: AGHT+IFtYkc0IQp926ZSy9/mYFLzFLFDfgLb8A0XsYLxCMPlp+1h9Xn5dkOiBl3EwUWMW8qNr05wZA==
X-Received: by 2002:a05:6512:3c81:b0:502:af38:3413 with SMTP id h1-20020a0565123c8100b00502af383413mr9848052lfv.2.1694527354262;
        Tue, 12 Sep 2023 07:02:34 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id pk24-20020a170906d7b800b0098d2d219649sm6997770ejb.174.2023.09.12.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:02:33 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 3/3] io_uring: break iopolling on signal
Date:   Tue, 12 Sep 2023 15:02:01 +0100
Message-ID: <b3b333ddf567f86104ce42708ad8982e561e9f59.1694522363.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694522363.git.asml.silence@gmail.com>
References: <cover.1694522363.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ upstream commit dc314886cb3d0e4ab2858003e8de2917f8a3ccbd ]

Don't keep spinning iopoll with a signal set. It'll eventually return
back, e.g. by virtue of need_resched(), but it's not a nice user
experience.

Cc: stable@vger.kernel.org
Fixes: def596e9557c9 ("io_uring: support for IO polling")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/eeba551e82cad12af30c3220125eb6cb244cc94c.1691594339.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 077c9527be37..1519125b9814 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2668,6 +2668,11 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
 				break;
 		}
 		ret = io_do_iopoll(ctx, &nr_events, min);
+
+		if (task_sigpending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
 	} while (!ret && nr_events < min && !need_resched());
 out:
 	mutex_unlock(&ctx->uring_lock);
-- 
2.41.0

