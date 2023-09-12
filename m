Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A079D2FD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjILN5p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjILN5p (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:57:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EE810CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52f33659d09so3770556a12.1
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527059; x=1695131859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVswjlQIEjbOlczYnqk1lm9FFJlWKlw+RATulc/J7KI=;
        b=C+DfS8r8O4Qguuf410RVSRs9bP7rlE3t6f7dJ51nKCbbizQK5rpajAeMeemHJtmzv6
         2e+A0FYjWX8LxWOxyHvn3B5BJMUqthOIKg3Sff5KGB4adzOcpnUugmT/tyYYLJFdpm3T
         o8L6TCNp3X/ysaNSyExSC2c2oyjuCV8hnOnQTFThZhQ50wW8zxlo3obBcHXZggj+GjnJ
         DWFkf8hflQmQ/I1N7MEOB13+nIJexERPqrSklpSVjNJCqHrkbTWU1AlW+W4Lh/dAO0vO
         ZZ3orWdYCQLtTcx5fntgqHoeyRbCiYGI6/FsunanoJTeYhtsUgnMEQNrY4UiD2hSu56k
         5Gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527059; x=1695131859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVswjlQIEjbOlczYnqk1lm9FFJlWKlw+RATulc/J7KI=;
        b=Ryrf8VeSdPu1BXoLVR7SedV6OzwcOXZCW7onhE7hk3oHi/5+MY3VU/NKeN9IajWg/r
         9lH3ePuDs8hCmrjeWIQ3edNF1vErlh5zALdpx8P7Um5iNCQ6KJcrms/9Q47hOmhy6IsE
         qDDr3zBI2LK0oArWsWPKg8mp+vM8fSmseS1N0DIOsTKivZ2ZAPWSNH9GwBkrXFUBYpDA
         2ECYzgt2QGG6SUlnNal7PxO51PGJ3dsNVJWtkv26vCBqnNy8ClmSD3/9QBx6+gno3oEN
         82YEuq46lZND7o8R/n2HG0OWSfH42WTNisK7IbGzxu6jtQzEsq4KU+qc71Xsu4Isbytn
         dvBA==
X-Gm-Message-State: AOJu0YzxzBXsHcK6rkeUOPk4Wu4RCWdz1oLpRgw90oT2hkuazK4Yl+pl
        zQ5XQnxPFlXpi9UaluaERB7XFHx1shM=
X-Google-Smtp-Source: AGHT+IGmo4W3eygyYdy/czWd5DRFZ4euXiXUSo6ABvd1qREHIdD2B3vrZF0ImUUko1ABBGyVeXgFeg==
X-Received: by 2002:a17:907:7636:b0:991:37d2:c9f0 with SMTP id jy22-20020a170907763600b0099137d2c9f0mr10116500ejc.68.1694527059101;
        Tue, 12 Sep 2023 06:57:39 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0099cadcf13cesm6863182ejw.66.2023.09.12.06.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:57:38 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com,
        Dylan Yudaken <dylany@meta.com>
Subject: [PATCH 1/6] io_uring: always lock in io_apoll_task_func
Date:   Tue, 12 Sep 2023 14:57:03 +0100
Message-ID: <4704923ecc4e9771262e99b2b6907fb8ff756c62.1694486400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694486400.git.asml.silence@gmail.com>
References: <cover.1694486400.git.asml.silence@gmail.com>
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
 io_uring/poll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 869e1d2a4413..a4084acaff91 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -360,11 +360,12 @@ static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
 	if (ret == IOU_POLL_NO_ACTION)
 		return;
 
+	io_tw_lock(req->ctx, locked);
 	io_poll_remove_entries(req);
 	io_poll_tw_hash_eject(req, locked);
 
 	if (ret == IOU_POLL_REMOVE_POLL_USE_RES)
-		io_req_complete_post(req);
+		io_req_task_complete(req, locked);
 	else if (ret == IOU_POLL_DONE || ret == IOU_POLL_REISSUE)
 		io_req_task_submit(req, locked);
 	else
-- 
2.41.0

