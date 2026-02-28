Return-Path: <stable+bounces-221163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGmWGrldo2myBQUAu9opvQ
	(envelope-from <stable+bounces-221163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:27:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C51C9138
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 234F234FBEA9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B800373157;
	Sat, 28 Feb 2026 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wzp4syla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D034373155;
	Sat, 28 Feb 2026 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301515; cv=none; b=a792vuZ+UUzqq/zHSQgbgt/kohENNygKzIp2phvOVq+nVZ09pNBKdScDpb5XrPGwK670rDQc+GmEOuXTYqRCApJAPKeWydMEVAT0VXWFj2GdJraNm1OiFzP9Tk6m/t4uKaWvxLnu5Dl+6hi+TISgfB3nILpTdAZzk9+wtBOTnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301515; c=relaxed/simple;
	bh=LNzFhU9XfZhjf8xxOub6ucNaRuUyk/B2S4O+7kveyFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyaSzllXtrrddHgVLR5ceo/KMMeHBA/eCxl5XVR9+Skjk5EsILwnMXxHgGlbwQ85T5HbdiSLe0Po6qOZsOcQPhFUu+J+CbqXh4sD0g8Gs75LISI36MxiQhhg4o1OI/3WUOIRysuq1Woopwfx+25WB+6tUM0RzWt8Nio3ifU+M4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wzp4syla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF996C116D0;
	Sat, 28 Feb 2026 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301515;
	bh=LNzFhU9XfZhjf8xxOub6ucNaRuUyk/B2S4O+7kveyFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wzp4sylaz7RK6SE8A4Or0PanMqbdKWv7P1s07W6xybnhJ7sglqGz3kpD+t4Gv5zus
	 eIAh3/TYMALxoOyyFBAqHMhv8TlIzBgOU29HPf3dnICcHSPzwYRJWvOyx1XvGuo0ep
	 QcExmbw1yZRYZTcpoFg5QRpcIJenpNPrSsiaLaOsJu4Q37wVj5eTsF+VTchZWVgVTI
	 oUPMJHCiSdwxqEtgkCt12oYI/K+9NxHLuLqjg5h3gP2Y+/H320JWd55Lvu1lf78uGD
	 L1/opAoV0Zhwopmbt155XnJIRhTwo7kTYwgZMMQAP4t/7hm7Uu41B4TUtOJ77EqAnC
	 AfNriG9Cik4Mw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 701/752] io_uring/filetable: clamp alloc_hint to the configured alloc range
Date: Sat, 28 Feb 2026 12:46:52 -0500
Message-ID: <20260228174750.1542406-701-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221163-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: BD7C51C9138
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


