Return-Path: <stable+bounces-200077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACEFCA58BC
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 22:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ED833085B3B
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 21:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDDC2512E6;
	Thu,  4 Dec 2025 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF103HMQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB734CDD
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764885115; cv=none; b=pGcHiuwC2+k8v9rUZEno/wAP+5I/kiMB9hRbWDiHJZNjY4ZDp87DNRfqS5hQJ9BEDrnHIwQtmKkyE+jlSzCfjsd0qkoBxTrHpFLMc4wDIkreDcVvHWws0eYU1ZdgxciQoESzxFJUkzfcDcXPuGzp94qAtiQlTtGS4I3/ixzCqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764885115; c=relaxed/simple;
	bh=f86TfBhxSWen9/l8SlQALzJr44Fl7HRfBZ35Fh8g/pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sq7/Esb9l5j9j+yOEnwg38dpcZBvwEJJK35HRsIPrXDogP+cW2SljLaqfu873zmHNk70n7Tqzt+oqvCtjt/5tYMqKMmoJiSDos98/ThUBzj6S8iC4DDbyM3efw705mdTu0QkGmyexaNR7M63hJhhoBo9v/PReNpt2MktmqoE7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF103HMQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1639796b3a.3
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 13:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764885113; x=1765489913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAvfkDU3ZExZEkW+970sZ77IFU75i0OENqUmSqwulkA=;
        b=hF103HMQHSJogxShgz2PrwYpuJ1OEnPHCd1m+JE9kXrQ5YIii06DnG8ftqCHhg/cv/
         TBOOb5VMRtsSNCus7XqLvutljIKupYuNz97sj+/5nXbB7vhsio79G/z9dCvsqT+hKmTF
         ZyYSzDmie18lWO6yCH8oFEUe5tpsAv/fKkcoWb+vLVn34X7MTmppfiy/yiGyJGCzJfnZ
         AIa26+Z7viTXtQEQ+pj9J5n/LGqCDhh3ZiCEv6yFhsFqF4/VwnvF3mtvtLZ1OKmvXzyN
         TRD+Cm4Pyf5iQ5PZMT+7UxJbebRUYaKORdbD2RxbM48BNC3RGXLO/DPnWWNICJzUN8XF
         MlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764885113; x=1765489913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FAvfkDU3ZExZEkW+970sZ77IFU75i0OENqUmSqwulkA=;
        b=kL1gsyeDEEXy5kz8vT2Q22vxM5RQqnb44lwNmvs8UgLgkhp0auBFnrFvBlBeTJxm+M
         DKZIca47BhqyjbTxwBD4aOVY+4qxMqjpGeZgHnwnKgJWj9OdoqBFGxPuFnjjJWkduPqI
         xQqzprmn4UuyCEu3gi8J0yUboXqWXmNoKosGraYhbAhf1OD+Oo7JDhMpTOLCatYblk5M
         DEaNgdau+jn+8jG3DbaSbFgJ69WSLphyec8qERyf5VuqOAY7Mc5ddvu3pAiSbHk6kOjj
         SvbybD+Dv/9izleZuTERKJ5A7/OzMcl8Qw0M8SMliHP1KuXRxA3kX0pwWwXPzjpRe6Hd
         fwmA==
X-Forwarded-Encrypted: i=1; AJvYcCW2mUbAx6ZinmyAvkxRjmA13qDFP5cPIyPF2nIKxCrXsP9BwCKIZs/ubN9Gj7Iwy+zbCISUkUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyprNrKWGZowDsmfRW63YbZpFKwO8GasRIcClWJOYja7pV6RFsN
	RyM1LIsCDHU36KPnwBNBhHm767nKLMacdH9f7zr5nRPUWjzeMqtdM1AO
X-Gm-Gg: ASbGnct2grdQYcT7YX8ugdt6hV7lll8tNRpgDURQUwsYQw+Sk+aT+kMD0olFpzwGBEk
	4/z0kV8VjR1pes1FyxhyeeyivK8V9zahE4m+UFD9qYBsflll3PApwmyR0wxSQzxI35nJgCSqelS
	QyHCSv5F50fFJSXcB8RMdjbnocJWYS2hEBmdZ4tMmvT3svsX43aasK9bPBLa5124Dajj4IWGDQt
	mfi9hepMCtdhNhuyYVGifUs3nz4La3Ukc7KOXQSpVAcRZbU1vKl1z5Fg+MX8U3jZ7D6hebefSQS
	uvu3mHODj9xDyTS9cvcOL8t1EJjWaykfKo4oBEkStYjdEiEFuOiJmXMbQN3TWJVDIBNQxZb8+r+
	HAA3qovurv5mrBNz+q5DVVxkF2y38bnRQVF4QZnTlEHjkC47rip3xvTcnoMKIKCzVuq7Gk8oDN1
	D0DrQHUmJo3C+8pm3Q8w==
X-Google-Smtp-Source: AGHT+IFLywY9i1U+WFpfKnu6JXKAIn+zY7KfL8wOKIIB6nHSNIr3UwY8z/FYZFbnFSEIlLc7SnSndA==
X-Received: by 2002:a05:6a20:3d82:b0:35e:7605:56a4 with SMTP id adf61e73a8af0-363f5e94b35mr9784241637.51.1764885112920;
        Thu, 04 Dec 2025 13:51:52 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ecf89sm3131563b3a.12.2025.12.04.13.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 13:51:52 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	csander@purestorage.com,
	stable@vger.kernel.org
Subject: [PATCH v1 3/3] io_uring/rsrc: fix lost entries after cloned range
Date: Thu,  4 Dec 2025 13:51:16 -0800
Message-ID: <20251204215116.2642044-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204215116.2642044-1-joannelkoong@gmail.com>
References: <20251204215116.2642044-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cloning with node replacements (IORING_REGISTER_DST_REPLACE),
destination entries after the cloned range are not copied over.

Add logic to copy them over to the new destination table.

Fixes: c1329532d5aa ("io_uring/rsrc: allow cloning with node replacements")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 io_uring/rsrc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 04f56212398a..a63474b331bf 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1205,7 +1205,7 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 	if (ret)
 		return ret;
 
-	/* Fill entries in data from dst that won't overlap with src */
+	/* Copy original dst nodes from before the cloned range */
 	for (i = 0; i < min(arg->dst_off, ctx->buf_table.nr); i++) {
 		struct io_rsrc_node *node = ctx->buf_table.nodes[i];
 
@@ -1238,6 +1238,16 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		i++;
 	}
 
+	/* Copy original dst nodes from after the cloned range */
+	for (i = nbufs; i < ctx->buf_table.nr; i++) {
+		struct io_rsrc_node *node = ctx->buf_table.nodes[i];
+
+		if (node) {
+			data.nodes[i] = node;
+			node->refs++;
+		}
+	}
+
 	/*
 	 * If asked for replace, put the old table. data->nodes[] holds both
 	 * old and new nodes at this point.
-- 
2.47.3


