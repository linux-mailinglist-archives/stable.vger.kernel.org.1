Return-Path: <stable+bounces-220866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MDGHlFHo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:51:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C411C76F4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1377E30B5FBC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B580C41E5A7;
	Sat, 28 Feb 2026 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qyv7oFsi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353D4963C7;
	Sat, 28 Feb 2026 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300751; cv=none; b=l4AbKKFzmEFIKFveF0EZUjT60yovCDi2gYvyOwVhIEtTCXUKGjhgl0LFh4dymssPESEs/uN225OWs+jUXDQcWxA8xqoaviCXKF41wszUryaBeoBXdpg9p45UUYaK5XerCYcReCvEzYdj4tGdVaRkRbYr3TAN85Jgw83F+FL7AUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300751; c=relaxed/simple;
	bh=LNzFhU9XfZhjf8xxOub6ucNaRuUyk/B2S4O+7kveyFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4qFJTJkjP2GvE5njuA72UJU5zY1Tj3j6yOL0DnS1ihSsS4CudFqhaeOVRDNFp8ri2cFbvAWuwAkHoN2wubFzRzm9HaATPh9+LPrmpPIHrIPy0cvG67hTbBoNg/gQt/p7rQ34zsKqj3BbRCJNnG+96/eMhuKQxQFjyalNTNtaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qyv7oFsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAE8C19424;
	Sat, 28 Feb 2026 17:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300751;
	bh=LNzFhU9XfZhjf8xxOub6ucNaRuUyk/B2S4O+7kveyFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qyv7oFsiZaoDhAbEBuEzf1ifhVT6UrptbGQT9O0KwqBD8eQUbJE1Ra4Sut1C7HuJz
	 X3r5CqORQZoT+gghZe3JeET9akDQVKttxUoaxwAczJPIVqZgV0HvXKF7DcKypp1ML/
	 IMuoJEY38JSxHOdqXIYlct+Z8hGuYhMMj63lwlaL2TSdE0AaTJNypoD7YaxW7xdDeZ
	 dm9Ya4peutWZoRHq+MCWIhwfxwWq9lZbxHcRn8n/wJWcOisEz5r5WdPhWMFd9CcmlQ
	 aYzzKdlsIYj3xsm1nZ3BDATb6Kk4tqfObzhsEn82AUWn0b6JOTZBcx0PT35YIUfSOQ
	 3VhD0NoJdadAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 787/844] io_uring/filetable: clamp alloc_hint to the configured alloc range
Date: Sat, 28 Feb 2026 12:31:40 -0500
Message-ID: <20260228173244.1509663-788-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220866-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17C411C76F4
X-Rspamd-Action: no action

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit a6bded921ed35f21b3f6bd8e629bf488499ca442 ]

Explicit fixed file install/remove operations on slots outside the
configured alloc range can corrupt alloc_hint via io_file_bitmap_set()
and io_file_bitmap_clear(), which unconditionally update alloc_hint to
the bit position. This causes subsequent auto-allocations to fall
outside the configured range.

For example, if the alloc range is [10, 20) and a file is removed at
slot 2, alloc_hint gets set to 2. The next auto-alloc then starts
searching from slot 2, potentially returning a slot below the range.

Fix this by clamping alloc_hint to [file_alloc_start, file_alloc_end)
at the top of io_file_bitmap_get() before starting the search.

Cc: stable@vger.kernel.org
Fixes: 6e73dffbb93c ("io_uring: let to set a range for file slot allocation")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/filetable.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io_uring/filetable.c b/io_uring/filetable.c
index 794ef95df293c..cb1838c9fc377 100644
--- a/io_uring/filetable.c
+++ b/io_uring/filetable.c
@@ -22,6 +22,10 @@ static int io_file_bitmap_get(struct io_ring_ctx *ctx)
 	if (!table->bitmap)
 		return -ENFILE;
 
+	if (table->alloc_hint < ctx->file_alloc_start ||
+	    table->alloc_hint >= ctx->file_alloc_end)
+		table->alloc_hint = ctx->file_alloc_start;
+
 	do {
 		ret = find_next_zero_bit(table->bitmap, nr, table->alloc_hint);
 		if (ret != nr)
-- 
2.51.0


