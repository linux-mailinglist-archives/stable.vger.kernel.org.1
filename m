Return-Path: <stable+bounces-114678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EF4A2F160
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A976C7A14E3
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B652204879;
	Mon, 10 Feb 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRjEdQNj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CB23643C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200919; cv=none; b=ZV1EkFaa13qvBPA99bSzQEq9oS6HED0R0A92Yyn4cRzt3HMvoFPTUzqdEv/iSaqZwIsIsXR249cN6yE4F/PqhMW/JS48vGPEBUfvWvA4oyXup8kHucpmjvcGqtJ78MwyeToh2VQ8K6gwXJ3ktzaIjcr4e9cJIAj6KdwDjrS/yTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200919; c=relaxed/simple;
	bh=Zr9pHjatWYEDLqOxVW+gAhdTFZCk+p+4bh8UZoKtCKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/GUqq5iQ7hyzJPu/TX4jsd7LpSKh5wrtppL25CLJkFqP0KzYtSJn+NZBMglQUOANCEfcoP2phofoOSfY3HT2a5G5reNDJZrB/Achp8WDpbqV2buCnT9F8DljXsfJE2UJ/Fk6ygU9aYa1KJ0CBYA8WaIPW2rdpjWFszfbCK6gL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRjEdQNj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaeec07b705so709470266b.2
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 07:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739200916; x=1739805716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+olSB00Ju+bmptgOdIEZo87aFJNqrzYF/ItANXDlPRE=;
        b=SRjEdQNjyT0oYxplDeogTtnE4QO8Ueom0s0/RWMBXejhywxWIOGbK6BUDGv3ZwTtbY
         TI5/GvVDOo2+A9ZEqwt/WyUuYaY7XIDTNTwmorglilo4tB2Jmkq2G5/Keyf82F1b1jGm
         a1c36FiqZ56o+J5JJs+K6PSC9zF9d/CSewDVujqvke33I9V/VvOV17LTIi1ol/ltUvXW
         Dy7o5a3FkzaxfNKa9fkuksmbgY/Kl8XTz/yD6vBHEgBWLem90gfRMCZm5QXfSSwPnRlD
         MRjwtANj2lBPqcSjT9o8eK2iPMl4uyhGtwT4/J+kPLXrN2GOitYLlJrRh+eWL0BsY9ru
         pu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200916; x=1739805716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+olSB00Ju+bmptgOdIEZo87aFJNqrzYF/ItANXDlPRE=;
        b=Pm5h9pEC7FrI/xxuwbUkE+JRpjWmYjN2m7itMaopPO9lHRuJNGgrra+zId+SmMhD0y
         Dd9uLhDBoq0bHxK+QVzkYbKiWhGgNPVKhc2txLAQLusNCV2YUwo6LKO+1oom0B8PibLm
         caNnTaPvr8qnurLqRgp593M6ozCJNucCjY5OQ7+Fg1VOegRMdPggIsEiyEKFJ2h1ZrU/
         DdVRTgAI7QLkna2bRd9e++bPHSaOm2xZlljPbG4D+FG2ZRroL67JXQsrX5sEE7reua6G
         T2RimT58l1VttVczZb7EY8J6eD11etIU8K+e60wXomYqw7cz3YoN/eWhvH8iv/amk0s4
         FJtQ==
X-Gm-Message-State: AOJu0YxEWRR7rAvL3dbn+xEjJPDIIHXQdv7nQhBx/EzsQ2fSAQkH3tdH
	W4oYjkU9gdesQwp7tEyN+BVrW6UddyuZINmj9sldKzwE2S5m+2i4EoznQA==
X-Gm-Gg: ASbGncu2X9scXufxTGjvOpaxB0CQIs7SYS8jlGIP/ySDVntm3IvFCvRBvumHYZ1bI4/
	7IZnF+qABntf8G2AgZR8BcAqrIN1Nw7JHlQFERRr+t3r4XTVobqbKIrQmIIthHPy3v82QMprxaM
	xLRIPMDznWiplgt12mm9ew7eqGFJLvQ6Kf57XygSyyCGbuJAolsV3TFdSpU7kzElQ90MCDCgxXU
	B+NDF6Yd5kxZEY8iyeeOTr13fu5exCGMyVALaZDwX82HBZZ3tUKl1nQuM4BsNYoQruk1w3/l8g=
X-Google-Smtp-Source: AGHT+IH84rFlarOiYAR1juWIIdguov2PziPhini3CMt4zMmZpqXIc/pYR9C1m269z+bqEL/Hih+MSQ==
X-Received: by 2002:a17:907:948f:b0:aa6:5d30:d971 with SMTP id a640c23a62f3a-ab789a688b5mr1441364566b.11.1739200915666;
        Mon, 10 Feb 2025 07:21:55 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:e0cd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d2c1797asm69587166b.22.2025.02.10.07.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:21:54 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH stable-6.6 3/3] io_uring/rw: commit provided buffer state on async
Date: Mon, 10 Feb 2025 15:21:38 +0000
Message-ID: <cb9ec75521cc59ee1ab3119d8d28a8697cd9cae1.1738772087.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738772087.git.asml.silence@gmail.com>
References: <cover.1738772087.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ upstream commit d63b0e8a628e62ca85a0f7915230186bb92f8bb4 ]

When we get -EIOCBQUEUED, we need to ensure that the buffer is consumed
from the provided buffer ring, which can be done with io_kbuf_recycle()
+ REQ_F_PARTIAL_IO.

Reported-by: Muhammad Ramdhan <ramdhan@starlabs.sg>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Reported-by: Jacob Soo <jacob.soo@starlabs.sg>
Fixes: c7fb19428d67d ("io_uring: add support for ring mapped supplied buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index a62f84e28bac..75b001febb4d 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -793,6 +793,8 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 			goto done;
 		ret = 0;
 	} else if (ret == -EIOCBQUEUED) {
+		req->flags |= REQ_F_PARTIAL_IO;
+		io_kbuf_recycle(req, issue_flags);
 		if (iovec)
 			kfree(iovec);
 		return IOU_ISSUE_SKIP_COMPLETE;
@@ -816,6 +818,9 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 		goto done;
 	}
 
+	req->flags |= REQ_F_PARTIAL_IO;
+	io_kbuf_recycle(req, issue_flags);
+
 	io = req->async_data;
 	s = &io->s;
 	/*
@@ -956,6 +961,11 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	else
 		ret2 = -EINVAL;
 
+	if (ret2 == -EIOCBQUEUED) {
+		req->flags |= REQ_F_PARTIAL_IO;
+		io_kbuf_recycle(req, issue_flags);
+	}
+
 	if (req->flags & REQ_F_REISSUE) {
 		req->flags &= ~REQ_F_REISSUE;
 		ret2 = -EAGAIN;
-- 
2.47.1


