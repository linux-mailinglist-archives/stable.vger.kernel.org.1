Return-Path: <stable+bounces-114358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0325A2D295
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 02:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7870A1699D3
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 01:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDE780BEC;
	Sat,  8 Feb 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp1nDycn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073182941C
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977969; cv=none; b=iGt5yYGAD0NRXhehBFwtJ99yOE8qVUu9kzwgBVO6rj/CGJ4xqG39NbvP6WfvIBbtKY9s6m0SMcLbWRaDtmxYJlRWeGJWc6d0w26pHAUshbm1sH89p8AxccItcfay1VzfTWfG+ASYBfKa2dufePhGYCq6RtQmbv2ZN/FqSWJWuus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977969; c=relaxed/simple;
	bh=ih2V2u2JRgYsRiJkTeaP9nUaUVPt60/72MWSCmZQMsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=klnvxoSb3BSznXl1P3YxAR4yTMw9YqSZFFYY5QVGgCSp4CHz1YcSRfMagpEmGsvzabVjlBw5A5LNKms6lwM9nASmKaZZm2lY5zo25tIwgGMNNRmbKJlrvyoSEuanKNRsfFc6Nd/uHNuC2WAcGAjJmI89EQPg4rX0zr+DDhTiTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp1nDycn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dce4a5d8a0so4381313a12.1
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 17:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738977966; x=1739582766; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QXMuOfU9aeLeOXNoamHyBu+GzjgL34HVe/Hu19ptyv8=;
        b=Jp1nDycnGcA3zgT+G4AdQrgP5Vw3a1Ui3RNW8y509PUJchurG6WvtmjsSvg1JXSuLQ
         LgxwyJGGqUlg0DmnUSKpHYGoE5PwVB64QHbYno5ss+bn6ECOArvTk2vy/smxdODMzISr
         prGGHtSLqmtxQNgARWWYJFrf78TWULdAJZ7fpp3J0GDkkoZHvtn1qx3RGJrcMHt405Bh
         K9A/hxf4dDyDBmraM0w8i1M+55bmVCBXx+NS6f0vKgllYsbSNjpSeV4G4GFqSa+yz/eb
         Tp8bf7yEb9xX11enJEnvVBNLIQfc4qcj52oFcwBhxiSkENKauQW+ITEnwnF8G9Zcq9z6
         gNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738977966; x=1739582766;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXMuOfU9aeLeOXNoamHyBu+GzjgL34HVe/Hu19ptyv8=;
        b=Y3UvNdvDJWvQOVy2trZGQTnq72M+0FXgbXubmq9k+l082cmWEhLhzBa3DRDs1yc2Bb
         K9Ak652p8bztnI29axSr/ebzdQA6l2boi689i1Tl1P5nIs7JXE69y2i9/8KWj6pLwOyk
         h0dHNsSZZ3RxlGKUlGzgrTdo1BsuI3mK/l4TgmGb6lJV3L55T7FmtdwxjddiMkZqOA6W
         wRQtoVr7HxPuNbyB+1d7Ckjl49xM6hClGBZSJdq+FEKCQ46j6CbrT4mhB5U2UhqDFi2w
         P6cR1JXV1dBaSETsZM/knZ31QEL9q/lnJR8CkdcOmlFSewqOj6kj/baq38RQNLQOsNMl
         AH8w==
X-Forwarded-Encrypted: i=1; AJvYcCWlwIZIyFbb4MORGhatsY1M3V+IVK5/HH4c1yS4x+YX9inLcEkJN6NUSYArQfA4bEfyS6gRllM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtgUHQvAUYgI/XTHwsAjY6YI2qKo6TSFY5oNZVBb7VEGz4SrwV
	AoGtxxgT0Wef3yPWsxIw7HJQCcN5iFcb5Y8sf2eC+sbmf5TaXr91
X-Gm-Gg: ASbGncs4GlXjzPR4iDlWDjTw6YgmlFHvVffv6ylGPik4eIMWCPP7wAK25o3WT+Qy7/V
	n9vAoQiDTfRl07GaZeTXupCrlGnWRky+JRHmAUuoStjQnpnpk3rXxTXgHRwFjUQsyQzYd7edlm+
	fRjsceSYymp6za0yGN/VtVSUGnD6nVqJfLvsfg2pyuYXk0GQ8a8drWCbik0L62LLXSeBrkYrAWz
	7uzqEZH8wNkSFeHTKkIXN41Kihv+HlwlFrYJ6Z4ZEjEWQg1wgQQLZs3VxoQ4Z0wUhzn+ns0WoKz
	lkaqSUyKHbGL+5Y=
X-Google-Smtp-Source: AGHT+IGoxcD/POUZ+HJ4Vud78hPohCPfqRi5JFagFwUl2D/p7JnQAoppHgfJZccywsnOgywZxSLGTw==
X-Received: by 2002:a05:6402:194b:b0:5dc:7374:261d with SMTP id 4fb4d7f45d1cf-5de44fe941dmr14451789a12.7.1738977966013;
        Fri, 07 Feb 2025 17:26:06 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab78c3e8b5csm209441766b.18.2025.02.07.17.26.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2025 17:26:05 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] maple_tree: restart walk on correct status
Date: Sat,  8 Feb 2025 01:18:51 +0000
Message-Id: <20250208011852.31434-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250208011852.31434-1-richard.weiyang@gmail.com>
References: <20250208011852.31434-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit a8091f039c1e ("maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW
states") adds more status during maple tree walk. But it introduce a
typo on the status check during walk.

It expects to mean neither active nor start, we would restart the walk,
while current code means we would always restart the walk.

Fixes: a8091f039c1e ("maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
CC: <stable@vger.kernel.org>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d31f0a2858f7..e64ffa5b9970 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4899,7 +4899,7 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
-	if (!mas_is_active(mas) || !mas_is_start(mas))
+	if (!mas_is_active(mas) && !mas_is_start(mas))
 		mas->status = ma_start;
 retry:
 	entry = mas_state_walk(mas);
-- 
2.34.1


