Return-Path: <stable+bounces-35721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414608971C2
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A5C1C20C11
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F7D148FE4;
	Wed,  3 Apr 2024 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ojex1MN0"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E540148856
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152573; cv=none; b=oo1tszp+NTClZRFcAsGAd1lNSH/ggIsg4y5hn9jebXW5eviZvzFHs+hE5YFxIiASkVpsNJCTKBGVC6JbXx9tS0Z+eLYzfHXeqjjLdlzvVKA5QUtzSN6epJbUED1ZfJTDXLgGlCiZ3dlUU8Sog5OEi+ESw0x3TEJ/AChkf8/dMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152573; c=relaxed/simple;
	bh=r6XgXgs9mKWgscIg4VAtSi4STibkfVlgbPBlVpthNeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTj137OmVU4mlY87NL6vVYJ1oef/I9wmrKfGzoSGTjlaofDAaNUmuYyKN3eDmMheAIZqU+zxXQad5dCmNnwjx8UUWDnOco5UlxdS4CJc7q4ZHxxZ4buVHbz4M9IvrqKMtwVm33c487rnh30wLtUMbRG1LTyumM7yQka85ZSedFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ojex1MN0; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-369f8526c85so306555ab.1
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712152571; x=1712757371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFSNOKrcq5ApWo4Nga/6FYpd0SvuTRy5qoeoKrxISH4=;
        b=ojex1MN0hquv2mV3urXahKOBXDBbMpQ3XmrzcCaH1hvQpDodFMRaExgnh9bFTan3dL
         wxBynVuuV9nGIUPiggPLs0v6AcMBB81Ni2TC4VjrBO3UiZP1aACoXKH5zUWwHesWIz2d
         rMiUhCsiCPr62XWmNrcEzIWAqwi6DsZdgEHKbi3/nz+t14Q/WcB3XS5XC2hUoR7sHS5B
         eoiIcdP7qTBZ3dv7DGWSh5zeSZa5LKHcD+ys1OGW8RCZEc87NdeAEH52OKQ2DJalRgD8
         8HXVWU+KRiklik0HdQweY7khFRuLpk8j4Ui8wUNvhPejx/8r6abbP1HMTR3wPMMP77os
         HWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152571; x=1712757371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFSNOKrcq5ApWo4Nga/6FYpd0SvuTRy5qoeoKrxISH4=;
        b=OBeM0Wcz7n6evLywHbmrRY/LM71RZSSy+UBW5yyzL0wRGZOv3nasrK5VCV5m9yfNzf
         YRwKEn8cfm6rGgvvjMTC0KjnLubha9MRlvh1d5BL8qUNEsQo0pIA87T0vniAMNP6W/9V
         T7vaFVXiv8GSccCfO3hCt2PVOMuV8d0Kvw5ADG0w/4WFNHqHGMJVaziQ1gSIVt5UtLDl
         in0Al43zCoMJO+5NNqzriKTNCCE+c/TGHPuXZuzdkvvfxnVepM5xFp4gQ9c8r9l/dHO7
         3ue4ubQdbM10j/HSt20FiQbswcCtxg8QGTCOZUzkKOcQ1JzhP5293bizx9Ydg7g02Y8M
         AvwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqdLmIqksB3bA8LF8aw94zbVD2nGUyOpB3SjLmP5EuILz9pRT2EPrJv1bfmQGfpQVkm4/6dLdlRBf/WOeJoOYAs5kWeLVb
X-Gm-Message-State: AOJu0YwQsnX+7Hh+WUShDlXqopPgt7BhxHBPE3GHDx/rH0ersRGQdRmo
	SSZoUFS57jl/yDc1n1g29AsWcosdWmYySrWl5zIIYCAIfWyoLqGYFVvFmjxYLqiP0+iqtno3TC5
	8
X-Google-Smtp-Source: AGHT+IF9Zi4uvNNy7T1FuA+tqiqprZAvAFxTCAusdlcoyvAnEk+vYjAs4AoV51xGoFTdzwF3oo52vQ==
X-Received: by 2002:a6b:5907:0:b0:7c8:d514:9555 with SMTP id n7-20020a6b5907000000b007c8d5149555mr14852580iob.1.1712152570679;
        Wed, 03 Apr 2024 06:56:10 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l14-20020a02ccee000000b0047ec296d3c1sm3839460jaq.19.2024.04.03.06.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:56:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] io_uring/kbuf: get rid of bl->is_ready
Date: Wed,  3 Apr 2024 07:52:35 -0600
Message-ID: <20240403135602.1623312-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403135602.1623312-1-axboe@kernel.dk>
References: <20240403135602.1623312-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that xarray is being exclusively used for the buffer_list lookup,
this check is no longer needed. Get rid of it and the is_ready member.

Cc: stable@vger.kernel.org # v6.4+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/kbuf.c | 8 --------
 io_uring/kbuf.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 8bf0121f00af..011280d873e7 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -61,7 +61,6 @@ static int io_buffer_add_list(struct io_ring_ctx *ctx,
 	 * always under the ->uring_lock, but the RCU lookup from mmap does.
 	 */
 	bl->bgid = bgid;
-	smp_store_release(&bl->is_ready, 1);
 	return xa_err(xa_store(&ctx->io_bl_xa, bgid, bl, GFP_KERNEL));
 }
 
@@ -721,13 +720,6 @@ void *io_pbuf_get_address(struct io_ring_ctx *ctx, unsigned long bgid)
 
 	if (!bl || !bl->is_mmap)
 		return NULL;
-	/*
-	 * Ensure the list is fully setup. Only strictly needed for RCU lookup
-	 * via mmap, and in that case only for the array indexed groups. For
-	 * the xarray lookups, it's either visible and ready, or not at all.
-	 */
-	if (!smp_load_acquire(&bl->is_ready))
-		return NULL;
 
 	return bl->buf_ring;
 }
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 1c7b654ee726..fdbb10449513 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -29,8 +29,6 @@ struct io_buffer_list {
 	__u8 is_buf_ring;
 	/* ring mapped provided buffers, but mmap'ed by application */
 	__u8 is_mmap;
-	/* bl is visible from an RCU point of view for lookup */
-	__u8 is_ready;
 };
 
 struct io_buffer {
-- 
2.43.0


