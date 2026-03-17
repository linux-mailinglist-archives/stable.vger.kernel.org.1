Return-Path: <stable+bounces-226903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHuzOim+uWnJMQIAu9opvQ
	(envelope-from <stable+bounces-226903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:48:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7340E2B2667
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8AA7314190F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A20345721;
	Tue, 17 Mar 2026 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGh95fk6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EEE38A732
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780426; cv=none; b=RF40xmwELzEgQWa7lxeUdpldwDPqEKhyVe9sZA2lYSPHArTQUzy+/uXdy+OGn7XmT6IGhKvgqJ3/a1sTC0BhOqzDDv3ORA7fmp5+DhDhvqBzicHBkRzgcRo64H8qWbC58X19FGcxLpRJOmv8fhmU60uqP/SelHNqmf+7jk8CDYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780426; c=relaxed/simple;
	bh=xANlG27QyovxPNgY1Tw+iDFM2K6PAxr+wn5PY2E6VfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ICwg3rF4yv29NuoJ/QKyvmvTMNGACJ9+cI2evcfRpfebl4FdTR4mGwLoKxGvfhsHfuo80Hn/BfFv+glW1ZTK3MI4bfYlVhI1NjOesLnT+sdHDdYZi63CHqgU0iXyyY2s/PZRBHM+zj5ABEXn6uny1aRBTQV10FOwE+Km6dHSBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGh95fk6; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c7413a0e5a0so498940a12.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773780424; x=1774385224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0vRQuQn8oykyA3GRd7qn+A3KcKbroWAPn66V/x+XSBo=;
        b=kGh95fk6E/07B9tL5lQKNWi5Ok/eoet5S15jwVoCSVgVYTeETeL7ytqAD69j/ED2X0
         rP2rdMiczUpedIgk7j7k5ZBmWhnTTKTirIF9ErPfqMejLZ06rpNd2k+3f6PEhym14va4
         1Mer7OOSPuefBIZpalxCtkn9XTeQKq80Sfw7l2tui/U5ib0T01lEfSZb6UHcr13Ag22Y
         nd7nqGJ1QKFSkOxXEq0RC9pilJxBcM/d7J4ev8hMhY5caD3CHwAbj3y1Cgv3BlhM0yM7
         KuUoAc8SHIrj3FvnaQHZziEpNuL1dSC+tAHzBgcgoAoqr0V9RxbuiLA3rqg2bfYkE6Eh
         lmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773780424; x=1774385224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vRQuQn8oykyA3GRd7qn+A3KcKbroWAPn66V/x+XSBo=;
        b=TXp7rVYATn9EJ6Yl8wgR3S1eSENMfmrQ/lBWEkf5R8v5Uh/pfELWGpW7LZgnPDZqc8
         VPjwTvpb76KraQ1dGchWr0js+7Xau+R1IM6b48Gy9lrmWfQZZH34ksJ2oJZ17n4YxSiw
         rR+aIoFGkNKQ3s1DYwOGpXps1omcigiaWebLQTfRYg8dpCR8wlMOmLdtY4RvvUXs8/b3
         q+2Efu+67DPgzfOZeIWXSIGL5Tsg6UezM43MQpfgYthLFm9oeA259o/A+/XERQ/IPoM3
         3VZ4zD2PPGp5zXkGo+8v7dbu4iBzPbW7YV0dGfe9mE5LLlmlAnlmAaAIcWgWNEVr3yd4
         yN/w==
X-Forwarded-Encrypted: i=1; AJvYcCUGywmwOe0Cm/RlScPGSQ76BSuFiZ5Tvdoem8p5S4UdZIOGYdD1jr7pyTzVhpTw+/TdO5T5Ov8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdBMRuubhgumQ0vDR7pTtz0/mLpYzLnfTdSt2mlMjlnZPh+IhV
	LyuXLTFj9i51XJLH+ccUd8OsJqZ7PYvyYdFQZ+Sxsbpnyk07LuwQS5a8
X-Gm-Gg: ATEYQzztK0UIpwPVoC8LokGpSVGhtcWU3mjFkAK3Q/M5JFO609DllAksS4h6MlaLOPC
	zLBgyaLdtCDpKYuul/lucyNeVRZljMZf4h9wOdfUG8kWSmt2QOHAFUYXSG48wm1CLs5MVm9HWWL
	b6r/mkrL0ckIEzfD9FZVuF2tEvrOt7+28Uzs7sXO1xL8kkq/9GCRjWgpPnovawTZ5nTnBENMCPF
	VKRewMEU0BHrFs2qTMVpNx15NdYfui66uNZ29X+RB06l8jUj4uTtIDXg2WezGM28N2IPZYBORz4
	TP9KRbBGLqvqjp1ZPKw0GNMuqS8EOZQXBFmwWr/H73xQvi3NRuk7Q1gsLUbgO0DgJzWYXUQojMr
	F7b0LSHxaKyml22NQ+2WdNOAbVUh7hr/MxUxRKYfaFMlERxV/YDlhQkwrOBKbyuFYbAKswR//jm
	XwX0E4FHhvUYl40e3p
X-Received: by 2002:a05:6a20:9f92:b0:39b:835f:174b with SMTP id adf61e73a8af0-39b99ccc832mr525031637.14.1773780424088;
        Tue, 17 Mar 2026 13:47:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb985csm320364b3a.38.2026.03.17.13.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 13:47:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	willy@infradead.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] iomap: fix invalid folio access when i_blkbits differs from I/O granularity
Date: Tue, 17 Mar 2026 13:39:35 -0700
Message-ID: <20260317203935.830549-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-226903-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7340E2B2667
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit aa35dd5cbc06 ("iomap: fix invalid folio access after
folio_end_read()") partially addressed invalid folio access for folios
without an ifs attached, but it did not handle the case where
1 << inode->i_blkbits matches the folio size but is different from the
granularity used for the IO, which means IO can be submitted for less
than the full folio for the !ifs case.

In this case, the condition:

  if (*bytes_submitted == folio_len)
    ctx->cur_folio = NULL;

in iomap_read_folio_iter() will not invalidate ctx->cur_folio, and
iomap_read_end() will still be called on the folio even though the IO
helper owns it and will finish the read on it.

Fix this by unconditionally invalidating ctx->cur_folio for the !ifs
case.

Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/linux-fsdevel/b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com/
Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3cf93ab2e38a..e4b6886e5c3c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -514,6 +514,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t folio_len = folio_size(folio);
+	struct iomap_folio_state *ifs;
 	size_t poff, plen;
 	loff_t pos_diff;
 	int ret;
@@ -525,7 +526,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		return iomap_iter_advance(iter, length);
 	}
 
-	ifs_alloc(iter->inode, folio, iter->flags);
+	ifs = ifs_alloc(iter->inode, folio, iter->flags);
 
 	length = min_t(loff_t, length, folio_len - offset_in_folio(folio, pos));
 	while (length) {
@@ -560,11 +561,15 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 
 			*bytes_submitted += plen;
 			/*
-			 * If the entire folio has been read in by the IO
-			 * helper, then the helper owns the folio and will end
-			 * the read on it.
+			 * Hand off folio ownership to the IO helper when:
+			 * 1) The entire folio has been submitted for IO, or
+			 * 2) There is no ifs attached to the folio
+			 *
+			 * Case (2) occurs when 1 << i_blkbits matches the folio
+			 * size but the underlying filesystem or block device
+			 * uses a smaller granularity for IO.
 			 */
-			if (*bytes_submitted == folio_len)
+			if (*bytes_submitted == folio_len || !ifs)
 				ctx->cur_folio = NULL;
 		}
 
-- 
2.52.0


