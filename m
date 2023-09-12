Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF75679D2FE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjILN5q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjILN5p (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:57:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE57510CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so751691066b.3
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527060; x=1695131860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW4orxAP7Rpu+67X2Ekr0XhNYH8NLh0oXTcAmvjjIiI=;
        b=RyGkoyE7Ld49gTOjEjhDev9JEq8UntzVoKKNtB0K98vtQsS51Iv3tFrGfxA/Vdf/cV
         +fwoyW/ga/68orzeDVeDhUyoByxghmrYIE0uqY9Z8+f4BDC85aa1BlZVnK8FqcORE0B5
         G+OYnUfh5TAFwga+q7wVbP9blM+NDGWCMmYYkkn/pS8+DbyW/NB9uh+wh9Na+OmTFRH1
         x/1xkWjDuwOtJ83bTORjRObj7o6CpLwuNzWI9xNBr0+XpypZ5zLnGgFYzwL6EzOPZKYi
         +caI6tbjhDIZyhhSKwPTatn0KzZI6MEjBzXGkrp1Wr7fTwpIIbI1YR4wN3zb9dMOkOcD
         zuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527060; x=1695131860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW4orxAP7Rpu+67X2Ekr0XhNYH8NLh0oXTcAmvjjIiI=;
        b=nAnldMg7K+PIoxw/DyfzjRmkPWP2/nj+aR0WWwQzOIfqpOn1DLJnN7j7VwaGdssv1r
         I53nww7DOZaUX9svIZ7PDH4XRDlkZhyw+CRdj/xHymePylb1RDVmGyhRVt6fZR9u0+Mm
         WkFk+VBZNa0NSV47vgXw+SXBKvA/MhvzP1BGgayjH/+u7qLzJ46C70EdJM3dV7024Sry
         yxPVLEbJqNoYQP8uvkvcpFuSexzPfLef2X4Y7e5ubUucSWK68/T9Xk/+ZI7fGtav2AfZ
         RFc5yHDKxplN7FdGdgTcpAWey8SuqFi0ih2BLMBMJuEFV1nUG8M7v0XWlupbtV0RR+aM
         oYRQ==
X-Gm-Message-State: AOJu0YzZlvH5XbBQ/vTQ9LhixP2fyPy2A/igG+PntaqBdPmQt9mmlocm
        anCEfISYV218DzIpLV+p44g38L0rAVY=
X-Google-Smtp-Source: AGHT+IERhpHPrcYkc0ovtWLmBEU1Xr2OIpjJoTlh3njeC2tSrvH9aiBQ6C6uJsyTf1FY/s4fQenNcg==
X-Received: by 2002:a17:906:5395:b0:9aa:25f5:8d93 with SMTP id g21-20020a170906539500b009aa25f58d93mr5940087ejo.49.1694527060027;
        Tue, 12 Sep 2023 06:57:40 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0099cadcf13cesm6863182ejw.66.2023.09.12.06.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:57:39 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com,
        Dylan Yudaken <dylany@meta.com>
Subject: [PATCH 2/6] io_uring: revert "io_uring fix multishot accept ordering"
Date:   Tue, 12 Sep 2023 14:57:04 +0100
Message-ID: <1efad3afea9ba65984ae63ec853f4a29f8e1c0fa.1694486400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694486400.git.asml.silence@gmail.com>
References: <cover.1694486400.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dylan Yudaken <dylany@meta.com>

[ upstream commit 515e26961295bee9da5e26916c27739dca6c10e1 ]

This is no longer needed after commit aa1df3a360a0 ("io_uring: fix CQE
reordering"), since all reordering is now taken care of.

This reverts commit cbd25748545c ("io_uring: fix multishot accept
ordering").

Signed-off-by: Dylan Yudaken <dylany@meta.com>
Link: https://lore.kernel.org/r/20221107125236.260132-2-dylany@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 2b44126a876e..00b4433b6cd8 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1337,12 +1337,12 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 		return IOU_OK;
 	}
 
-	if (ret >= 0 &&
-	    io_post_aux_cqe(ctx, req->cqe.user_data, ret, IORING_CQE_F_MORE, false))
+	if (ret < 0)
+		return ret;
+	if (io_post_aux_cqe(ctx, req->cqe.user_data, ret, IORING_CQE_F_MORE, true))
 		goto retry;
 
-	io_req_set_res(req, ret, 0);
-	return (issue_flags & IO_URING_F_MULTISHOT) ? IOU_STOP_MULTISHOT : IOU_OK;
+	return -ECANCELED;
 }
 
 int io_socket_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
-- 
2.41.0

