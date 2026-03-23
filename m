Return-Path: <stable+bounces-227958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBsaOKkiwWmTQwQAu9opvQ
	(envelope-from <stable+bounces-227958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:23:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885462F1257
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26BC230185C0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE26396578;
	Mon, 23 Mar 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bStwlgPP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C336C59E
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264888; cv=none; b=dIfqe+G9/WBb6iLzrxt6GBETV4NMiEg+DtwwAE2t0mSGiNJyr7aOQFfIyKaP3y7BAb/WO7gIgos4/Qh2j1FTigdwH8jb/FguzrttY/PN2Sw0L4eEFSKFFk1b56UvQUnywJ0NI70ccTwyCG9kwAZ2MBDiIXXlvKbhcKOqo5qcFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264888; c=relaxed/simple;
	bh=bCfS4sC0ksfVsXpah9Z4HDDrTDp0UYSty2uqIzyok+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqmUqF3E9Lkd4/P9Dq5qw/+fF44FUQ+tgCQ5/YVLS5NmMg8GFNKgul4kBQP6XCiHXE0r784OdnKUAmW8VmEqtp/DoBIWTtC13uRwu8BANenqbRe725Bb+8lRnUKIK3DsFEbdRSRIizPEqzpp+3u9jRaYHPvAXMag+qOV+A1ysLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bStwlgPP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486ff201041so21361525e9.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 04:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774264886; x=1774869686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cEcb08vVAZPET7mzr3THVkEg4dX8DJXZ2uDFEvO98U=;
        b=bStwlgPP8H+L4jopT0Sg/oV9+H1V5Rw8KGRjFk+5NY3qMSxQJoWSbGPz8l+5m69QpX
         HlKtvbUdPEr0aGLXxnD3jrNuc97S1noXqpLkwOw+5BPF3Yc+E6RFyCfaDR0y9fMBMrKf
         C5rHu8+qoaoLyKdXJGqIzeeGaWuTT9xLk9eNmwmUVFzBzuyEZmxOIw+m0lR3kgm7lmXg
         TlDohmfCXcDy4qE59qzJfKvFLvozq1+mlrF5b1UaatzpSu5uL72r8Rpsx/Cs0mVlFkGv
         WVzFFxqm78VrbBw0wiZumXtHyIV39eMJehdJwD25jSRPJKPqNZeNF/ot6ZNebWK59z1c
         5vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774264886; x=1774869686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cEcb08vVAZPET7mzr3THVkEg4dX8DJXZ2uDFEvO98U=;
        b=cNMcMf/NLPHX+qD/iKttNJDWOcZfEM6zlm/cAbI3urOkj6dpDtyzZbcIEw2zPV/nda
         Db6BkQVRyrjyH882IgdDnXHaePiWofHtw/K7ITjz5efVC7YJGbn1DCPWwXnGlBOaeCDA
         kghqaoYOKtiEBmxQwawsXAP3OvBWZMuV4QBnTmHfzZg0ToFQ/6og4P7avVyygImyL5IN
         p5i0o8RUEkmLjyMKx/Fy2fwCBOaFV7YXGiqJi87qy0pqft0WaZAuLvaqZCCuGsVnPFbz
         ifDQiAcdwlir1YJRG/XNouKmPtbSmz5x0eDFM9M+Ml/0YRG1L40DPo1uHmE/Hz2f8nHi
         +kqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWij/lDpeE9Il7vtzsja5QjgREg61ykbZbL9AhIq1UyNDJRnVq4pGMNS+9wng6FsfbqYcb7d1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YymwMjmrnUCxQvbpnVabw/+LxULk4q/MIaLUC/1H1Q9aNop2sXg
	X8s6b6Da+sEvnsreeQ+hl/xHUXrSr2V6N6/guKUCYJ88kQc37Ez9a8lt
X-Gm-Gg: ATEYQzzF5q9F2eS4DVTGqpZUu+htWPeokn6JPilCdmCe8eMcyNuDYnSHQqF+82RmqEr
	MtdNxhTetvb8GZbFcIz6YPlnC+Df5B+czzdSIh/zZAsIp/wCuHXZ4AQAaQF7eptZacMInClbbCb
	H61aN7txGXeaWWi45Hyjq5W3vvkBdEoXzEttIBLQqMdBvM2mo5Elayu9ytCsg162uCSarwU13+v
	+vyNfec2yYRswKdqN8f1Ma3U/tdE22FiDi+Anvh/iXzidIZlU6x7Da+MsZQpb+nGOn2wTdxdy8L
	pYLjBmOrxcmRB1PeHZBqWW9sPZ+nG4F9WLKt7NwnOjOeiM3DCKBbG1zymxi850Vz5G4rqPLhoXM
	i+ptt1Qc9sQRCcDxpbxBkLV+/4IpJntrlkGIgOK7AwPvWmxrfWIyGJ9rxd58I3P4g3quQtgzB9f
	HNeQ1RTceZa+qVSNjcwbXYID7LAMJuiohRwz43RHsDihLrK1wgt0wzdH2K9s9Ji9mh3J50zXpO2
	AVwyuwyLx7wfoZJKn9F6FX9oB8M4zmdH8bpjknog7ey
X-Received: by 2002:a5d:5f86:0:b0:43b:5356:a7f7 with SMTP id ffacd0b85a97d-43b6423db79mr18794794f8f.9.1774264885468;
        Mon, 23 Mar 2026 04:21:25 -0700 (PDT)
Received: from fedora.communityfibre.co.uk ([2a02:6b6f:fb26:6400:da6:2a24:3e4a:d588])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae619sm30257656f8f.5.2026.03.23.04.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:21:24 -0700 (PDT)
From: George Saad <geoo115@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	stable@vger.kernel.org,
	George Saad <geoo115@gmail.com>
Subject: [PATCH v4] f2fs: fix use-after-free of sbi in f2fs_compress_write_end_io()
Date: Mon, 23 Mar 2026 11:21:23 +0000
Message-ID: <20260323112123.786090-1-geoo115@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032354-country-saddlebag-5331@gregkh>
References: <2026032354-country-saddlebag-5331@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227958-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.sourceforge.net,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geoo115@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 885462F1257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In f2fs_compress_write_end_io(), dec_page_count(sbi, type) can bring
the F2FS_WB_CP_DATA counter to zero, unblocking
f2fs_wait_on_all_pages() in f2fs_put_super() on a concurrent unmount
CPU. The unmount path then proceeds to call
f2fs_destroy_page_array_cache(sbi), which destroys
sbi->page_array_slab via kmem_cache_destroy(), and eventually
kfree(sbi). Meanwhile, the bio completion callback is still executing:
when it reaches page_array_free(sbi, ...), it dereferences
sbi->page_array_slab — a destroyed slab cache — to call
kmem_cache_free(), causing a use-after-free.

This is the same class of bug as CVE-2026-23234 (which fixed the
equivalent race in f2fs_write_end_io() in data.c), but in the
compressed writeback completion path that was not covered by that fix.

Fix this by moving dec_page_count() to after page_array_free(), so
that all sbi accesses complete before the counter decrement that can
unblock unmount. For non-last folios (where atomic_dec_return on
cic->pending_pages is nonzero), dec_page_count is called immediately
before returning — page_array_free is not reached on this path, so
there is no post-decrement sbi access. For the last folio,
page_array_free runs while the F2FS_WB_CP_DATA counter is still
nonzero (this folio has not yet decremented it), keeping sbi alive,
and dec_page_count runs as the final operation.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Cc: stable@vger.kernel.org
Signed-off-by: George Saad <geoo115@gmail.com>
---
Changes in v4:
- Rewrite fix: instead of caching sbi->page_array_slab (which is
  destroyed by kmem_cache_destroy before kfree(sbi)), move
  dec_page_count() to after page_array_free() so all sbi accesses
  complete before the counter decrement can unblock unmount
  (Chao Yu)

Changes in v3:
- Add Cc: stable@vger.kernel.org for backport to affected stable kernels

Changes in v2:
- Fix Fixes: tag commit hash (4c8ff7095bef, verified in Linus's tree)

 fs/f2fs/compress.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7b68bf229..d9d105efa 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1489,10 +1489,10 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 
 	f2fs_compress_free_page(page);
 
-	dec_page_count(sbi, type);
-
-	if (atomic_dec_return(&cic->pending_pages))
+	if (atomic_dec_return(&cic->pending_pages)) {
+		dec_page_count(sbi, type);
 		return;
+	}
 
 	for (i = 0; i < cic->nr_rpages; i++) {
 		WARN_ON(!cic->rpages[i]);
@@ -1502,6 +1502,14 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 
 	page_array_free(sbi, cic->rpages, cic->nr_rpages);
 	kmem_cache_free(cic_entry_slab, cic);
+
+	/*
+	 * Make sure dec_page_count() is the last access to sbi.
+	 * Once it drops the F2FS_WB_CP_DATA counter to zero, the
+	 * unmount thread can proceed to destroy sbi and
+	 * sbi->page_array_slab.
+	 */
+	dec_page_count(sbi, type);
 }
 
 static int f2fs_write_raw_pages(struct compress_ctx *cc,
-- 
2.53.0


