Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE079D2F2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbjILN4E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjILN4E (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:56:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4010CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:56:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so96596371fa.2
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694526958; x=1695131758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvQF1KGRFXFC2cY8A1+U9HKS+G+QhXBRXTSA+wvBxN4=;
        b=COX9a2qMHrzoo7ZzPPtsNeMYOjTLq3zug3tZupiT3bC9uHVsf+Dxhh0TD6DPQQjV32
         2rjjOj+VbusTBfz0i9RPl5Lw9JHx/1c5wjnbvnoA/eQpeW9AWwRG4ZE4/mmmgnkTFBDv
         SOSgMmb/5WTT5U6ab/ecreOm20QZ+BLkIMJs1t3TEEiSwY5YityrtbblQBEq/3boJ25Q
         RPbluRdhL8I3BsRnE0eRopBmN5qLp2ehTideDeHM439cvkciTqg/HuCAVvzE8D0bkQPt
         TkTu6WlnL+mzBca6DsjiCYP17aPKCfsN6njns7P73TReKtR0FJqr8J4djODyZsBH3fzr
         YV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526958; x=1695131758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvQF1KGRFXFC2cY8A1+U9HKS+G+QhXBRXTSA+wvBxN4=;
        b=YhxbDOMsVkkgH1+68N26Yd1/Gv0x+EF1Nx4IGcI/QiqcLHFI36xKCRm4HctWk23W0i
         Sbxl8Is/fHmpgF3DQ3yVPIqc5NjLEUYS8VHSGQrf/yAbKs2xnMFlYWLlIxOjwWY/ib04
         wp7ggHGtWI4uCaalsFhWD373SfgMpG9sPEhjw3UCrpNfqoWMtzjjkaFkuod0POg9E0yi
         Wdo3aST+t/qcUKOmyr6HidUneEe1YKEufKO54iR7dLz7VaXr/wb7xQSMitPYIoI2UjPX
         Q72XsNzXcL1AOhSaRLmKStReZgDr2I2ZlFOY5id6HSL8UNmqqteH/1LLnQdAuyja+pMJ
         Qoig==
X-Gm-Message-State: AOJu0Yxz3J/hqCDrTW8MBSIbBOf/sOgDfRGLrZBvSbpMVkQfiPNoSZqh
        9hefsWSReUCfEks+akkFqNtkruOHByc=
X-Google-Smtp-Source: AGHT+IGzqavrD3lLy/+XlTmvUVnQOiTl+/N/vazmTTAazCfgMrf1zDdktu/stvJh5RqZQD96jqjK2w==
X-Received: by 2002:a2e:8495:0:b0:2bc:bcc6:d4ad with SMTP id b21-20020a2e8495000000b002bcbcc6d4admr10693912ljh.21.1694526958071;
        Tue, 12 Sep 2023 06:55:58 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906344c00b009a5c98fd82asm6802337ejb.81.2023.09.12.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:55:57 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 2/3] io_uring/net: don't overflow multishot accept
Date:   Tue, 12 Sep 2023 14:55:23 +0100
Message-ID: <a7435e75ceac76b00b0ddb95f3ad314f982ae6f9.1694479828.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694479828.git.asml.silence@gmail.com>
References: <cover.1694479828.git.asml.silence@gmail.com>
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
index bd25c1adbf13..0aadbd72b7a9 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1358,7 +1358,7 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 	if (ret < 0)
 		return ret;
 	if (io_aux_cqe(req, issue_flags & IO_URING_F_COMPLETE_DEFER, ret,
-		       IORING_CQE_F_MORE, true))
+		       IORING_CQE_F_MORE, false))
 		goto retry;
 
 	return -ECANCELED;
-- 
2.41.0

