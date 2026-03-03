Return-Path: <stable+bounces-222958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PlOJmlwp2kEhgAAu9opvQ
	(envelope-from <stable+bounces-222958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 00:36:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1268D1F8699
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 00:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3856030E9DB9
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 23:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E64B3537FA;
	Tue,  3 Mar 2026 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX7c+Onv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8243537E5
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580941; cv=none; b=VhkNriU4Cfi+YsjVQ4Bc1sXNhnnIZ6/qa+TCH51dA+hq3n7MBC7HLCa7qvCHlVQsHxUp38vDKaj58QtPRjLtFD5kGGtCXDTLLEwbT3WHf7osT6/ZUAjRQQ9dYU6DG5S7hm540Uh5MD7r18oxzciQZRvU5KVZQbufgT/GxaVgGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580941; c=relaxed/simple;
	bh=jkrHDNgM25d59kJT571jsnGyvqtlao7ohHl2wkdYRY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skVoShff21/F9AUa/u+c+ixBf9yFYH8scRHc4HmLwe+GkwYNw1jMDkbXbZDSiBYuXxa8sXDl1DHaoz6yYFBwOuOECUezoBQKDye4i01Hg6Me6Qh/M/Rt0j+JVlE7e2E/YqP44ZPgjUdaRRypTadBiuvUw+HeoiaW56dT2w0uE3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX7c+Onv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae43042ea7so35907015ad.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 15:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580940; x=1773185740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obiQ76qiUJNFcjhp64R+cgHHcte5lFLkqq9i5N4t7sU=;
        b=YX7c+OnvhyNMzk8gdQRX/X1slGQ1cyv/Rs+IolRFbjcAToi+gpnWuZ5i/ajfHXT435
         Wm4kEtDHoMjgWnIGuYM5fZFnl2VrUKiJULhXQJKAw6xAuhJl5MEooXyG4OQ9IckFxSGL
         MUlsM7zjcJ+Sadifs7DkMFk4kwu1pPuNycPmVW5oa1Y+mpKW1La3IjHMp6S4U4Kp4U/Q
         kPEGxHLoEv0/VDOs5OsScofad0plVYoDsUJhwZ17WYJPKuX8Jy+MzMRJTupeevoq0P0Z
         wNwzC6TPJDe03jsS1P+vnFcCsaZWke4i2yI3QGx9xmEWGElZKC9h78l2X2E/bDbcbcq5
         JXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580940; x=1773185740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obiQ76qiUJNFcjhp64R+cgHHcte5lFLkqq9i5N4t7sU=;
        b=GNm+S0IHLsZLRlLa3WYa3qWp8iYj8+9XZdWXl29xEXBRZV3NX3eguiO3ey3Mp60R9M
         9ho/fD9ea2gBVmh8ZY+4heGcTFRse5x0wi30nmE88kIVvXw2J+PD8HbKp2Ti7jmpTSFt
         WY0D7uEdiebW7TOr5YEadbAp412UDDhxdoIbVKkKS+pjDfceZsqRA0F1/9efoGSAdiua
         lPzZ2oHOuMA4xpvErW80bMPBK4rCbyMQiGOXeDFxAS6/6xOeEMC6wUMO5gtBYsW8k2MQ
         TqsypGGrUIPOGDvXBdgnPisUR7ldv/bP5leX+UNOBIWekK+tPJL5WZZXrUIaaZ/v2ceO
         mS6A==
X-Forwarded-Encrypted: i=1; AJvYcCWAPzo73O9JLdGD0WJ+f2ZdLI238QUNqu39UuNxameN5k676FEtSNIjXTtigeyKxO/0jzcyEXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkTr/ZlavKY0wCSRFYXAqaNzM+vTpMgLbf0VjO4A7WBsRcxcfI
	6AnSHT68YnmIlfdHchEv+mIONsBi9kSRqKWnYuE2RL2fAIVtWfnuGoqP
X-Gm-Gg: ATEYQzwl2ivJoYEyN3Edq7UDusYhq35Mw/gu8GBHGGoBe9GBkdRH2cCnRMDHrM82Cl2
	dRDbfo2Q7bscom5FbkvBW5AFkJkWqydWJtVB7lzIJZWMDuQX9Xlllc/+v/JASxkw1Nl+XzBE28w
	qA5MBInHTqin3Pd6LvOoq+n4XSwKTvyDis9+a70W47uLOMmegcuiQ6rA5HBa6e9xSYlKZnA2xt6
	jyxQaldHfG0BTsN2o1GDAbgXfwQe7Fsa/aH97XkqTnl6sT9vJcAJnG51L1u98KGfBFYVfW8XOWf
	sm3RJQc7wzq/kI9LAeh0ZnjENC0EaYhUE2iNOLVjfjTqreJL1a2jJMHoU/RmWs6OXIbrRiiqR/V
	6I8KTuMQ8Kg+/e2IuOpKQrkGCIbJgirrEPUHgAMPj0anJkudoZ+vPZoMaeb8K1wglfVdsjEdo6E
	u1LubpzWv6ZBIcgY40ag==
X-Received: by 2002:a17:902:ccd0:b0:2ae:3f72:fdc5 with SMTP id d9443c01a7336-2ae6aaae6camr1189365ad.26.1772580939922;
        Tue, 03 Mar 2026 15:35:39 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45e07626sm107308075ad.39.2026.03.03.15.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:35:39 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	willy@infradead.org,
	wegao@suse.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/1] iomap: don't mark folio uptodate if read IO has bytes pending
Date: Tue,  3 Mar 2026 15:34:20 -0800
Message-ID: <20260303233420.874231-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260303233420.874231-1-joannelkoong@gmail.com>
References: <20260303233420.874231-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1268D1F8699
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222958-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Action: no action

If a folio has ifs metadata attached to it and the folio is partially
read in through an async IO helper with the rest of it then being read
in through post-EOF zeroing or as inline data, and the helper
successfully finishes the read first, then post-EOF zeroing / reading
inline will mark the folio as uptodate in iomap_set_range_uptodate().

This is a problem because when the read completion path later calls
iomap_read_end(), it will call folio_end_read(), which sets the uptodate
bit using XOR semantics. Calling folio_end_read() on a folio that was
already marked uptodate clears the uptodate bit.

Fix this by not marking the folio as uptodate if the read IO has bytes
pending. The folio uptodate state will be set in the read completion
path through iomap_end_read() -> folio_end_read().

Reported-by: Wei Gao <wegao@suse.com>
Suggested-by: Sasha Levin <sashal@kernel.org>
Tested-by: Wei Gao <wegao@suse.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Cc: <stable@vger.kernel.org> # v6.19
Link: https://lore.kernel.org/linux-fsdevel/aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org/
Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bc82083e420a..00f0efaf12b2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -80,18 +80,27 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 {
 	struct iomap_folio_state *ifs = folio->private;
 	unsigned long flags;
-	bool uptodate = true;
+	bool mark_uptodate = true;
 
 	if (folio_test_uptodate(folio))
 		return;
 
 	if (ifs) {
 		spin_lock_irqsave(&ifs->state_lock, flags);
-		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
+		/*
+		 * If a read with bytes pending is in progress, we must not call
+		 * folio_mark_uptodate(). The read completion path
+		 * (iomap_read_end()) will call folio_end_read(), which uses XOR
+		 * semantics to set the uptodate bit. If we set it here, the XOR
+		 * in folio_end_read() will clear it, leaving the folio not
+		 * uptodate.
+		 */
+		mark_uptodate = ifs_set_range_uptodate(folio, ifs, off, len) &&
+				!ifs->read_bytes_pending;
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
-	if (uptodate)
+	if (mark_uptodate)
 		folio_mark_uptodate(folio);
 }
 
-- 
2.47.3


