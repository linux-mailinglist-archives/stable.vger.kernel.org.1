Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB4479D2FF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjILN5r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbjILN5q (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:57:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893C10CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991c786369cso752911166b.1
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527061; x=1695131861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGgm+Q1ISvcVbNXmrUKxzkTkchDbvViFbDmRswe/vbE=;
        b=lNSCisZZVXy6UIg3JdKk1kqO4d+Pi0aa/C0nJPl5s3yHTkIc7F/CTNpXORhkmNrwOU
         5SFcXaJnkqGytQ4Dk0byz8qFdnlsaIEXtZk+qk/tiuC5h4obdVR/LnM44sae4VGfTtyb
         hFkwXIQbLi8PQnj9OcksEZQr//ZWQdbxbU9TbKiR+0RSyG8zKAuVbh1YhaKlhlFNPIzn
         128wQpqc1N3MhCadl1MpKn94Jvq52M2p3CCg5rPlHxkmvVfAFoIT+r4/3JuFsykAdLOq
         uUjrAgDeQF2AOfAEVj2/el2JwhpQt/6FSW9CVtNAR0GBMRgK+zPwRI34eofThwQuuvlS
         I4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527061; x=1695131861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGgm+Q1ISvcVbNXmrUKxzkTkchDbvViFbDmRswe/vbE=;
        b=eLETdUhoa9wPLBsdzfYqtQKt8G8cgDbH0YAyfWB5JzJ3Vxn58KPUXtYPr1710mywXr
         I+e1XTYTo4TIRzSW3Z9GF69IMDYw6vdJ05h3AXQg90YJbmy999+hBmSXBpYoYFYYdu6/
         fYpawJXKSndQEUaDYA1s/+gIP7kbG8AXNocl+LADgXWLnMC4pSZlRZMP+BgTyYgp0X2m
         bVXyP19dbzhSuRHgilN3/DQAkalClEFwmf3Ns1L0CoxO4PtOCnJHa8IYHNAFWLUvXWMT
         5AV3XJirtHeC77kOkYzyeAFGx31Etf4AgsFwBqgTbjWB+qhOeZUCyub2ij5wVLgGhTtb
         Sr7w==
X-Gm-Message-State: AOJu0YxnMBo5PJcrTq3HTS9OmhwQdezrW+dKLDO4oIUYcfmTR4NXCdhu
        r5xTYyyWNoajzoHxvqhnXU0cJHo4+Lw=
X-Google-Smtp-Source: AGHT+IGMhVhSSgHdYS0OkzoiniuBUInS3u4pkP+BPH5rJmu9LiPFxHyXjxE12HwGhPodZNbJ0ZfRAg==
X-Received: by 2002:a17:907:b16:b0:9a1:f21e:cdfe with SMTP id h22-20020a1709070b1600b009a1f21ecdfemr9256169ejl.58.1694527060964;
        Tue, 12 Sep 2023 06:57:40 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0099cadcf13cesm6863182ejw.66.2023.09.12.06.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:57:40 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 3/6] io_uring/net: don't overflow multishot accept
Date:   Tue, 12 Sep 2023 14:57:05 +0100
Message-ID: <6dd4ad61d825bde6200a27e4f09dee059cb29214.1694486400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694486400.git.asml.silence@gmail.com>
References: <cover.1694486400.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ upstream commit 1bfed23349716a7811645336a7ce42c4b8f250bc ]

Don't allow overflowing multishot accept CQEs, we want to limit
the grows of the overflow list.

Cc: stable@vger.kernel.org
Fixes: 4e86a2c980137 ("io_uring: implement multishot mode for accept")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/7d0d749649244873772623dd7747966f516fe6e2.1691757663.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 00b4433b6cd8..7245218fdbe2 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1339,7 +1339,7 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (ret < 0)
 		return ret;
-	if (io_post_aux_cqe(ctx, req->cqe.user_data, ret, IORING_CQE_F_MORE, true))
+	if (io_post_aux_cqe(ctx, req->cqe.user_data, ret, IORING_CQE_F_MORE, false))
 		goto retry;
 
 	return -ECANCELED;
-- 
2.41.0

