Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA61079D31F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 16:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbjILOD3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 10:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbjILOD3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 10:03:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14B010CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:03:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500913779f5so9803288e87.2
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527403; x=1695132203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdXYMak+OWjyBvWJIxPafuIXSu32TDNy69xl85UNpyU=;
        b=l1KMImNf2BT8oUGVu3tZUkZnNM1qG7UrY5acTq+RRnIq3eUX9B/DJVGkdQP6vSMnK5
         z4TaVuGQoDZJ06RfEHbk66oM5sr8y7cb3IY2WzE9SYGKf+aYrgbr7U6JPqS4kve0bBoc
         PudZOwpZYEzdvoU+oo9hvEi+88zWubylYeLTdYxURgB6f1+OgbXZiSbnT4E+f9jZlIGX
         tyq491HNi16ZKSSvhNT8w3LObkHLDw/yDHrd55Ua+npKH6m4tHSyS1jNsAHj95cgVoxW
         rZYwq5CiRPR5gWgAbAfE+/e7H0gDG+JSp7J1P0qrCHgY5eOiVhSQlt4UJfFlJU9suj3Z
         Blcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527403; x=1695132203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdXYMak+OWjyBvWJIxPafuIXSu32TDNy69xl85UNpyU=;
        b=pwcP/Lgg8Gmoe3X6aOm1DiYlv82IPpsioJESsd78mrURKzi7DD5Bot8AU+lYxEbCDJ
         l8H2qQwt72lqfGRn3WtfIbZ4cOtqJGFeaUcVgSyhtCCM9Vr+Duz+9xVyfhSqCczIkZvF
         DwIo/bRZiH1Hs+2mOEtzvgUQa0iTgXsggQaMW2HH/YCKgrykMNBPmQyIr0fOzLJFKZ2U
         8gkv9iDLcW+0QqgFhIgirIPMA3Ef6/3DBd5C+YdfqpvOHhZ70zWhKiEDSKB5rTh8EqNr
         TQYDx9kkpoPsX02EBrw2an95LzRD1B1c2L62J8rjA5hfV08/jfuMafKkarIYU7C/mlJT
         i2MQ==
X-Gm-Message-State: AOJu0YyJ1WBR/E7nY6UvzXGzETsDLgMDCBAd7e0+kLht3IcZ6zPYCLEI
        Rz/an7WlYeVISrY8mwCtW2FWulTvaMQ=
X-Google-Smtp-Source: AGHT+IET+5AGkm73Q7aIHfkHmpcJoX0K4TJ2BO384VxcQ/bRgmlwTRbVS/KId1yq+wQafZ8Hsx62nQ==
X-Received: by 2002:a05:6512:3d21:b0:4fb:8616:7a03 with SMTP id d33-20020a0565123d2100b004fb86167a03mr14382389lfv.4.1694527402880;
        Tue, 12 Sep 2023 07:03:22 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id ib10-20020a1709072c6a00b009ad8d444be4sm751671ejc.43.2023.09.12.07.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:03:22 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 3/3] io_uring: break iopolling on signal
Date:   Tue, 12 Sep 2023 15:02:50 +0100
Message-ID: <d3156dc2243c9a419f46d7c3cb4dcb2b839c3c65.1694524751.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694524751.git.asml.silence@gmail.com>
References: <cover.1694524751.git.asml.silence@gmail.com>
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
index e5bef0a8e5ea..800b5cc385af 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2665,6 +2665,11 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
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

