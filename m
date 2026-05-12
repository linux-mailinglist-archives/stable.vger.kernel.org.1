Return-Path: <stable+bounces-246655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAN5GAaIA2r46wEAu9opvQ
	(envelope-from <stable+bounces-246655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:05:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 001BB528F0E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4E99309147A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA06A3AB482;
	Tue, 12 May 2026 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiVLlJll"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22D3A8737
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616313; cv=none; b=KPKt4rkknezVa0Qca9YfOJ4/6aWVtS2DkpraHQsEbtZgMh2JdppIJ6K+Gg/0QUW2HoMoPpn52wn2vYNhKcZi5aSTKmlXiiLNBJD1IYn7uN/pGbraqbhwCuJg8m3tpA8Z8NgSRNiCTVm64WHgt4KdGu+rG5t6vL3dYdHmU+PoEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616313; c=relaxed/simple;
	bh=oauhwQ4bfgPwVDvS1oO+Iizts7tGkAlW1rmqN7jXvFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fctVhbFiaRQ2fkaeha6Z8krFvqI+HpOp/jqPOdow7HATLg5kKOu4OUexI2+Hlx4pjHP52pnDygwTc7FXegRajkvvfaPIzSpZQRDtAuX1BqVZqA27TNv3coLJqzUk7aP7ydwPwnmSjEbrCeAj3uienVy/zj26yKhGGdQYkhL9Im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiVLlJll; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-90f850473f9so16015085a.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778616311; x=1779221111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6dz5TXqHWQjetWKKAInNPkpUojoo8oCZ/Ayi/D/P0KA=;
        b=QiVLlJllR3es502xph0zSQwyUCQzer2aVd471P9czjOeNFGFk6mue4cl1PTFWJlQPb
         /GWziTqv83gF65epK0HhikoMLVbm+UgLLUfyQ6g0Ib/iTZnWKi/apZfe61paGnfdbwsL
         PiHKU8/5LKb0UK8usctRCJ8MEPRaIc6EWr5h04yMevLlGhC5pRqvyduI6E6qeSClACWT
         div0LBTYdzmSA9YCHWMm+dEOhdCS6s9QBvfSdl+MGkMNiXvTlwTpbP/bDmjpXyR69PUC
         v13KjXgepcqvNzETmHy1lljeUE1d6vh3xcMZUPEwA1r3qaCh9RIPMlRKXVlBxLG/pNjz
         6UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616311; x=1779221111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dz5TXqHWQjetWKKAInNPkpUojoo8oCZ/Ayi/D/P0KA=;
        b=W5PpVXNV0KefIG1s2AsVzCcD0Bwa1PNLiEiuMMoWGnfchcANAMaAUWeIOPXmqTU1Tr
         AohmgZqIpQiwGFlL0nWn+dZkvKb/Pbcu4l4vCmLFZyg9NuTHYsHiR0dPClVKHTA9cJpx
         rftUflPxdZHtke6HLPUSFb1CMwpDamPI1XpGB91xYxprXYOboLCbe9aWIu08D6ZYpeFC
         8CwLL3gc9/5vhRsNevIQRbLmCEzkX9m6RZCpDWMJJRJ7Ha0UO0u++o2X26CgOIwNuOC3
         Bj/c06VE6WGYmYF1jSE2x7g/T7Ja59KGTLpss0RENfpb2+5ft8ypu/7GSC0syg+RwfMU
         uTkg==
X-Gm-Message-State: AOJu0YyXFFQVnCLI2DgbZT7Xmp0mULeZnoqPMzyGy6Q1p4BuDlptUmFs
	hGxXNG9RHgB0ftKlZtDB4+COUQ36SIMTOqNy/VGXdOpnf0eZTftFmTeHfykc8A==
X-Gm-Gg: Acq92OHSFGLXVyLUdFBrfOJW0vDRYDM8YHWvjIVHxDJQv0VgQQ2HzNYaUtIQBoVgNsG
	YfhAvvgFP5l6RD4uZGwTQfOX59KPObMPQ299MIFpaHLA2AvJFYH5hfl/rHbxH3sYIudEiLCuA46
	wilR30flXjn4P7lzc5ipghIO3BsEH6qTpfLKwF6C+kyBRDjfULakCJsX+pDqU96UCBomuVMIXuG
	uJv/Lg6WQKexj9OQMVefAsU1wr8fttNsj+Ovc6E6zDbHq1UiC/rQ6aDZ/WvMvp9PIkJv9GdsyTd
	GDsLjhOMHh2c8DPNTv4R5hAZEmqOoAQRGDvS/xR4cYQ/lBSWo59IeOd1/8NCIbtEtc3cxvMoi7n
	/xJavxUu15Cp1UMcLniHJMeQ8X85AH8G++lTtOrpbPOfq8v3UDqhOkEAhcrFrZQdURdmQbA9huv
	aPYQtjkGlaA3oXxhydjQ==
X-Received: by 2002:a05:620a:1a10:b0:8e4:ebbb:b162 with SMTP id af79cd13be357-90f884e7aadmr73101385a.9.1778616311117;
        Tue, 12 May 2026 13:05:11 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91fb3bsm3438265485a.41.2026.05.12.13.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:05:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	fuse-devel@lists.linux.dev
Cc: stable@vger.kernel.org
Subject: [PATCH v1] fuse: use copy_splice_read() for FOPEN_DIRECT_IO splice read
Date: Tue, 12 May 2026 13:04:48 -0700
Message-ID: <20260512200448.3818665-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 001BB528F0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246655-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When FOPEN_DIRECT_IO is set, fuse_splice_read() calls
filemap_splice_read(), which populates the pipe with pages from the fuse
inode's page cache.

This contradicts FOPEN_DIRECT_IO, which is set by the server to indicate
that the page cache should be bypassed entirely. Subsequent splice reads
can then read stale data from the cache instead of fetching fresh data
from the server.

Use copy_splice_read() instead, which will invoke ->read_iter() on each
splice read, sending a FUSE_READ to the server every time without
populating the page cache.

We do not need to add checking for O_DIRECT since this is already
handled at the vfs layer in do_splice_read().

Fixes: 2cb1e08985e3 ("splice: Use filemap_splice_read() instead of generic_file_splice_read()")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3bdab8d03373..3ebe18ed0264 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1859,7 +1859,9 @@ static ssize_t fuse_splice_read(struct file *in, loff_t *ppos,
 	struct fuse_file *ff = in->private_data;
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
-	if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		return copy_splice_read(in, ppos, pipe, len, flags);
+	else if (fuse_file_passthrough(ff))
 		return fuse_passthrough_splice_read(in, ppos, pipe, len, flags);
 	else
 		return filemap_splice_read(in, ppos, pipe, len, flags);
-- 
2.52.0


