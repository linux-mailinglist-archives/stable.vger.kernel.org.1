Return-Path: <stable+bounces-227952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA2GEZAZwWn5QQQAu9opvQ
	(envelope-from <stable+bounces-227952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:44:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC852F0688
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D93E300ACA1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D131F36EAAE;
	Mon, 23 Mar 2026 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc6RcCuD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1D36B047
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262669; cv=none; b=GJseNCv7upizPR/3gabd86eKdsDnKYQJLNGQtUlSHGczupA58sWR1dx8u90k3gRUJt3xfwNOilXK7p98IViKcbf/bxk7ulAEiPLBPUbf1M5HVgSdjWOBtYTflULQzKzwN1RLsHbEdUR/mRlGIU9MPwjWO9gYYWdVB/2ex6Qe69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262669; c=relaxed/simple;
	bh=oxjlJbHsBXO80cPvlokC7qRCc+nN2t3FG/Z6C40Zccc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no95IR+xqzbkoDF7T2KqIVMmQy3UAmYKQdtwPKv9w0s4rLCSUhoMNn/GdcgKtjUDK/xU5r8PRktXgmzVZyYXl5pDQPYGij5mYZY2f++nh0T8PyK7po1pIu+6l+HyDadKSAZGl8z/14tax6dCI5Ld0FYLjhULl9y1akYGe8fz0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc6RcCuD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b9b190easo3440f8f.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774262667; x=1774867467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7kx18ZtDYXjvQFOa0TwuTMVPJdqvqJYrZ0DR3wfVxI=;
        b=Xc6RcCuD5C9OLF+0EzvpLmRtusSb9eyMUyzEl95skUmXD9JEjTdIdbl6B6CGCos4XZ
         spno3j7FEI+7KCyqtsg3250bHRiC8N+JO/Ta1YXacxGhxXciWzDGQk/VNmScVync21kl
         3o/QdLlNjoSjbjBvl068CLeAf+r1tMolE3PgCVvKl8TmTneCWlS9nENMsVUnaRE20Dr5
         IZ7faoIniMnQOQwsF8pR/vWZbTka+/wMk8Cgr7kQEDAqIrkfn70hhjytUlL+mp/1r866
         eBFEeNEw1MUcyabOZvwYF2L6JjJSYhWTZXFHg3owc3ZUjKWJaGe4FozZ4mWe2ovIx8gM
         lnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262667; x=1774867467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7kx18ZtDYXjvQFOa0TwuTMVPJdqvqJYrZ0DR3wfVxI=;
        b=rxetLygR31TWgdNGgFTmh0nJvS6QBPl9DZeL6KCrLXAprj3SA7v9hrGOv+qargMDNB
         Ivz2MvIim50kouxtiUso7holOSsQr4yQBzaZLImUKOx30RDiik3v3emfdc26Enyj0XhQ
         9ybke8ML0pXqeSDORBXmufe+H8ZzzTRno3rxTvDpNX9/CQkteG2SYSazYSecUJjQ8piY
         QWoKPcVI/Ix5KgZIYlJATyje1WzCai0PIvwsWduEaObrFtNmm47FU+9KPHyT6slTly9P
         7oQiiXN51xpZRa2kTZK/7GF7CG8v/bZl1z011c4QA/AX/XHQkAu3URbt/Qk3ONl1zT+E
         9sOw==
X-Forwarded-Encrypted: i=1; AJvYcCWu8uJcNcOIjNuBmjSl0gHAQCrnrU5F9QKH7TwAMCZobT9wIuOkpuRrqnrQ8ILyTyNE2LLO+Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAzcJjvm/dowi1SaorO1qlRT6d+i7/qbjdGyORL4hOxJCW95b
	rxP8Up8Wu8l+sRYQPuqCON2k4PnRwdqduDiS4FUhrSdk/mZeWvkmeH+VwMKTsak6ZyE=
X-Gm-Gg: ATEYQzwZpi28VviOMVc+TdG8AGU0KD9tOgyC5cYMkaDmbiZfqsulZcU87ePJDdjNcGj
	B5sy+sjZ55/lH3pouajxueMYjsxH2pVMHczuw9ffViTFsuTpJOJyc4wM9CMhpPhsveWPw++ecYn
	+oJUJul9iAOUUXjRfeU/KkLKGVP+b5eCEL7KOGJKYKYritm0al6oomuNlsf9HdF9uRdAsBLpl1p
	EEWfYr1yAK4fVlXY5cEgLVcn0ges8yEax5RaEwL89ImZnnMroaqMZMyzc0QChX7ceyuOPgNeo2q
	bdi2RE7NlzDI8LKxl+c4nfrMV4y6DGm8f9LFeVmT5QGx3l1rxKrcWVINWWq+IyQegcwZrx958vb
	5hTDkfwu0Qmb9JeR/BAoNyVM9M14CriZ5tQSxbH2nC+7JI00EQwo5zhzEauwSJFDRzrYENF/ohF
	pEmegkJ3HDBx8wGvCrgJdEzI2W/LcJWn1EAtfzrLrt8jRdEGsmEi2EasO7BdJRgKLFybz6cTwEJ
	8kC1limGJftEkUQg49H0/1CmBF9EQmieA==
X-Received: by 2002:a05:6000:250e:b0:43b:498f:dcfb with SMTP id ffacd0b85a97d-43b64242f3amr20505189f8f.8.1774262666467;
        Mon, 23 Mar 2026 03:44:26 -0700 (PDT)
Received: from fedora.communityfibre.co.uk ([2a02:6b6f:fb26:6400:da6:2a24:3e4a:d588])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd0dcsm27420281f8f.11.2026.03.23.03.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:44:25 -0700 (PDT)
From: George Saad <geoo115@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	stable@vger.kernel.org,
	George Saad <geoo115@gmail.com>
Subject: [PATCH v3] f2fs: fix use-after-free of sbi in f2fs_compress_write_end_io()
Date: Mon, 23 Mar 2026 10:44:25 +0000
Message-ID: <20260323104425.780693-1-geoo115@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032354-country-saddlebag-5331@gregkh>
References: <2026032354-country-saddlebag-5331@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,lists.sourceforge.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-227952-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geoo115@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCC852F0688
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In f2fs_compress_write_end_io(), dec_page_count(sbi, type) at line 1492
can bring the F2FS_WB_CP_DATA counter to zero, unblocking
f2fs_wait_on_all_pages() in f2fs_put_super() on a concurrent unmount
CPU. The unmount path then proceeds to call
f2fs_destroy_page_array_cache(sbi) and kfree(sbi). Meanwhile, the bio
completion callback is still executing: when it reaches
page_array_free(sbi, ...), it dereferences sbi->page_array_slab_size
and sbi->page_array_slab within the now-freed f2fs_sb_info structure.

This is the same class of bug as CVE-2026-23234 (which fixed the
equivalent race in f2fs_write_end_io() in data.c), but in the
compressed writeback completion path that was not covered by that fix.

Fix this by caching sbi->page_array_slab and sbi->page_array_slab_size
into local variables at function entry, before dec_page_count(). At
function entry, sbi is guaranteed valid because the F2FS_WB_CP_DATA
counter is still nonzero (this invocation has not yet decremented it),
preventing the unmount path from proceeding past
f2fs_wait_on_all_pages(). The cached values are then used in place of
the post-decrement sbi dereference.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Cc: stable@vger.kernel.org
Signed-off-by: George Saad <geoo115@gmail.com>
---
Changes in v3:
- Add Cc: stable@vger.kernel.org for backport to affected stable kernels

Changes in v2:
- Fix Fixes: tag commit hash (4c8ff7095bef, verified in Linus's tree)

 fs/f2fs/compress.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7b68bf229..c3d837df3 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1479,11 +1479,20 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 {
 	struct page *page = &folio->page;
 	struct f2fs_sb_info *sbi = bio->bi_private;
+	struct kmem_cache *pa_slab = sbi->page_array_slab;
+	unsigned int pa_slab_size = sbi->page_array_slab_size;
 	struct compress_io_ctx *cic = folio->private;
 	enum count_type type = WB_DATA_TYPE(folio,
 				f2fs_is_compressed_page(folio));
 	int i;
 
+	/*
+	 * Cache sbi fields before dec_page_count(), which may unblock
+	 * f2fs_wait_on_all_pages() in the unmount path, allowing
+	 * f2fs_put_super() to free sbi.  At this point sbi is still
+	 * valid because the F2FS_WB_CP_DATA counter is nonzero.
+	 */
+
 	if (unlikely(bio->bi_status != BLK_STS_OK))
 		mapping_set_error(cic->inode->i_mapping, -EIO);
 
@@ -1500,7 +1509,10 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 		end_page_writeback(cic->rpages[i]);
 	}
 
-	page_array_free(sbi, cic->rpages, cic->nr_rpages);
+	if (likely(sizeof(struct page *) * cic->nr_rpages <= pa_slab_size))
+		kmem_cache_free(pa_slab, cic->rpages);
+	else
+		kfree(cic->rpages);
 	kmem_cache_free(cic_entry_slab, cic);
 }
 
-- 
2.53.0


