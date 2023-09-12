Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC41E79D31D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjILOD0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjILODZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 10:03:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F110CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:03:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so7351596a12.0
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527400; x=1695132200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DxXh0n2bZD6v8mOCSJ3ioP5Dz4du6tb8WfpIi+aDtU=;
        b=AOp30ouCu8mA7AzJp/dV9Heaa5h13KreQln0K2dNKRjdUHP3kNuk/c3hXnTrrW14/g
         MPm8AbuZp9lpy9hr5lB2wuS9DcNabrAdvg6GGMxqmAHt+CF6+tvmddnFe97NIpkjsch0
         tvInSdTFgCcif42dhuJQGu2q7MraVSvmwZysY7lMXVKrmoJ05zdm9DTg6pePhuO7wu27
         H7Fk/nIquEBuhX+HbQu3C89uYuNvn7did+eNobE2mB/a4otglQ3hwVMMQ5tztiSCJYhs
         R0CufppNR2JQI4uobajaVhmYXh12XpiB/TOM6kCAXAZj5nHZtB5SZbtuQ458F3Bzeikr
         mukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527400; x=1695132200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DxXh0n2bZD6v8mOCSJ3ioP5Dz4du6tb8WfpIi+aDtU=;
        b=Gh327XpFJ+vEZQ0owkBV2d0pxqauRoUW5DGdU5u0F7o76da8iFcUQrsQONiuyZyC7C
         XFjIGac0D8amMpSjGO/jIeCtPjjywkuu8GW0amriEDOJvul9ZbxbAvCMapElpn3hCnz0
         UTUrN70tqrmLk5UaQ5QWMraf6Mrjx+hwXyhYeUNZ9ZtATShCQarKZqTQ26HffGf9POxy
         lrRbv/A3q7MywE5ByKrqOH49AjLElmujA7/DQpSDqHW0/i1NE1dimBGV04MT9CPO0BSl
         BBF2jWntPf/IEp0gJK4NugDnK7GuZmD/tloAp/JdhtOiLIeQ3fGbJWzKAccQnTCpbZ/e
         zDwQ==
X-Gm-Message-State: AOJu0YxkltW9aMEABQ/5+O8KvO6WJTMzYnjBot6ANiNKrlgW+FGLeL6m
        IKnz7qXxE2VGBNuq+icnyr8w0WY0ypg=
X-Google-Smtp-Source: AGHT+IHRNa5+1httr5gdZUEM+p3qKZMbTLUfNT+IlY31WI68+/y22Jd1O+4PXJ+tsExTTWL6MIaogQ==
X-Received: by 2002:a17:906:214:b0:9a2:86b:bb18 with SMTP id 20-20020a170906021400b009a2086bbb18mr12687366ejd.26.1694527399953;
        Tue, 12 Sep 2023 07:03:19 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id ib10-20020a1709072c6a00b009ad8d444be4sm751671ejc.43.2023.09.12.07.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:03:19 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com,
        Dylan Yudaken <dylany@meta.com>
Subject: [PATCH 1/3] io_uring: always lock in io_apoll_task_func
Date:   Tue, 12 Sep 2023 15:02:48 +0100
Message-ID: <9f8a30b981705fa8fef31ad76c9bf7192b8db2a4.1694524751.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694524751.git.asml.silence@gmail.com>
References: <cover.1694524751.git.asml.silence@gmail.com>
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
index dec8a6355f2a..ca484c4012b5 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -5571,6 +5571,7 @@ static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
 	if (ret > 0)
 		return;
 
+	io_tw_lock(req->ctx, locked);
 	io_poll_remove_entries(req);
 	spin_lock(&ctx->completion_lock);
 	hash_del(&req->hash_node);
-- 
2.41.0

