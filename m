Return-Path: <stable+bounces-202919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A845CCA201
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 04:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3048C3028D8F
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 03:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABE22620FC;
	Thu, 18 Dec 2025 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODkciTn7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C0221F12
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026833; cv=none; b=gbSN2Qcw6Mol+TdMyD7/QKUOPMa+6zMFIMRC9lvz0YiIGz0fUg0wFu8elM+lueoxgSP04wQcIfGY4+NUZVdBG/JSMXqhDUOZM8+Kfe+okZ+zP41/s44F2l2pQE39k/4BZry4DEgDyqnVb6uF72bvEDI8o8tn8Wqnr4uA+XkTJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026833; c=relaxed/simple;
	bh=Vm++0UfiI7mTMG7UcqfeOA+uxyR8LCbfyx1yxXxyHSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kpK2Y5uujSJ6fj1wahXZcO4Jq9dUgiMkKd9LsSJVMQPWrRhngnfbhDrPCtYdxQVuFa3eoxrAcpeFxzFfVDSZUsM7q3MskMXsNZvYjA04TVloedHWBv0tGqx+AXCx8EWjLD1pB7DnOCzRzBgKX7ddzp9mpbiOOiWsybEqdBhnBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODkciTn7; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-644795bf5feso164015d50.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 19:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766026831; x=1766631631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1aW+idYYoTpGggNMnP1gIvl+I8Ac1YfYU7BJVbP8Vk=;
        b=ODkciTn7QovESv863Wsiyh/h0tHGmaFu+zj5raTRO9WBC4QeHN9QKTaihFo/yh1552
         HVMr+NRdAzvTMU8zQBqVTAQXo6c3KBOTNcqtwIQfjaX0VwwyFWCHBA/wzLcM9NMMRue7
         0Z5ZhQOiYhfj44OxIJmgX/g5tiPY0aeijN978VndvrztXGnbOvulGRLmVzn70o63mEew
         dIWke/Ge5np0me26QkH3uM8AQ8eEge60QOAFgeNRj88FcSaTyuYSG2zdb5xD2ax70Ze0
         9wTaJ00SHw4A/ITdg1dh2BgO3MYXBywc4JjY6RNLEa3OHfP3Z0euGUdBR6Ln4Sd4mOU1
         Megg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766026831; x=1766631631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1aW+idYYoTpGggNMnP1gIvl+I8Ac1YfYU7BJVbP8Vk=;
        b=qv6cvWutdmtAtyDZTjkK/NvgoPH5db9OSokVAh5tLlf2FqwjGslGgs9o416ZNfg1XJ
         zDjA7jB/v+K3XTtYXH+/pO3irfSAYdBt6qNZn/s6W6RVnvt3E/SO12Awr3qT1iEiYm9S
         HUc48RPnuO43CzuM9xpEepG+qQ7OYz/WeaVp0lygPjMgI6p/i6Dfv35xxhudjtVUqzf/
         w5+sGS5BGx/IGCPys5gUdgSXMOAw2c9iv3KFzYrCt8kwzhcYUwJ1yW73LeqjYrcPr/RL
         wDY/ofE7k99B9iAijzjBIPXHE864+LGNpl9fYS0fHgZqIbqvW1oEqkRn0JG+00wdoz8s
         fs2g==
X-Forwarded-Encrypted: i=1; AJvYcCX94OZMY1OeA3b9MOsL9ARIEepXxf1+RNsuNi0T+YOne+Nih18W+ZBBGep8VNAOT/1NiLU57tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmnMIiDb/pwFNRZI01+qku5f2doRfKYdKHsgYfoQVAg7o+aFl
	yoJkD2ntlt1VZ1B9os0I3fprbt7p+/1BKMP8ANIi1dS+NJVZSkyL6het
X-Gm-Gg: AY/fxX5dEfLnzK5QRjJyrmbwN3E8Fy91Wik+Mb0BeFBc7wZUNprlF+Diunb7zAhT7rf
	Hbn3RUENGbo/wVnNuz2CXLnPdBMI3YyjufXw4P2tgNKLVBtVTFIF9QiUdasUic4GtxDrwQBJ736
	cPt2aEFsRcsJGWOuIyqrhIFAN7TCfL/ThEeMS71Ljjn9hr0od/BAzB5lqSdbweOGIh0h7rWO1hw
	fRDRmSLE6YwlmtxzUXoWBZgVHBJH8MC281qEmteDx44zcZxd8Y4KLaOl3bbjU5Ej6ZSqDzCC21T
	HtMERvv6M9Pf+Sa1tWDa62DUhWvBA5iBwrgudAfQZU0jdnCF00UgQev5n2AoIXiAJvXCEWuQ5VF
	si7XRduREZ0rtPe+dr694eAnL370xN3TmnFPbBwP4rcI4I/naR91v+7aUOmBrjleN1hHujaPHtm
	Ybx6gofDHLzpCw/HtYD+bNyM0QKFuJhSjDHpIf7Po0/JFvdrysXc9U2uB83pbC
X-Google-Smtp-Source: AGHT+IFLtp/YJVgdDwF2T2NRVscU9ohhAIZGe3jf1diZBtUCBHkPwsifUpFmbcBIew2yjf6ZKbexmg==
X-Received: by 2002:a05:690e:13c4:b0:644:60d9:866e with SMTP id 956f58d0204a3-6455567be0dmr15248816d50.95.1766026830540;
        Wed, 17 Dec 2025 19:00:30 -0800 (PST)
Received: from abc-virtual-machine.localdomain ([170.246.157.94])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fa728f8b7sm3638087b3.45.2025.12.17.19.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 19:00:30 -0800 (PST)
From: Yuhao Jiang <danisjiang@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] io_uring/rsrc: fix RLIMIT_MEMLOCK bypass via compound page accounting
Date: Wed, 17 Dec 2025 20:59:47 -0600
Message-Id: <20251218025947.36115-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multiple registered buffers share the same compound page, only the
first buffer accounts for the memory via io_buffer_account_pin(). The
subsequent buffers skip accounting since headpage_already_acct() returns
true.

When the first buffer is unregistered, the accounting is decremented,
but the compound page remains pinned by the remaining buffers. This
creates a state where pinned memory is not properly accounted against
RLIMIT_MEMLOCK.

On systems with HugeTLB pages pre-allocated, an unprivileged user can
exploit this to pin memory beyond RLIMIT_MEMLOCK by cycling buffer
registrations. The bypass amount is proportional to the number of
available huge pages, potentially allowing gigabytes of memory to be
pinned while the kernel accounting shows near-zero.

Fix this by recalculating the actual pages to unaccount when unmapping
a buffer. For regular pages, always unaccount. For compound pages, only
unaccount if no other registered buffer references the same compound
page. This ensures the accounting persists until the last buffer
referencing the compound page is released.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: 57bebf807e2a ("io_uring/rsrc: optimise registered huge pages")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 io_uring/rsrc.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index a63474b331bf..dcf2340af5a2 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -139,15 +139,80 @@ static void io_free_imu(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
 		kvfree(imu);
 }
 
+/*
+ * Calculate pages to unaccount when unmapping a buffer. Regular pages are
+ * always counted. Compound pages are only counted if no other registered
+ * buffer references them, ensuring accounting persists until the last user.
+ */
+static unsigned long io_buffer_calc_unaccount(struct io_ring_ctx *ctx,
+					      struct io_mapped_ubuf *imu)
+{
+	struct page *last_hpage = NULL;
+	unsigned long acct = 0;
+	unsigned int i;
+
+	for (i = 0; i < imu->nr_bvecs; i++) {
+		struct page *page = imu->bvec[i].bv_page;
+		struct page *hpage;
+		unsigned int j;
+
+		if (!PageCompound(page)) {
+			acct++;
+			continue;
+		}
+
+		hpage = compound_head(page);
+		if (hpage == last_hpage)
+			continue;
+		last_hpage = hpage;
+
+		/* Check if we already processed this hpage earlier in this buffer */
+		for (j = 0; j < i; j++) {
+			if (PageCompound(imu->bvec[j].bv_page) &&
+			    compound_head(imu->bvec[j].bv_page) == hpage)
+				goto next_hpage;
+		}
+
+		/* Only unaccount if no other buffer references this page */
+		for (j = 0; j < ctx->buf_table.nr; j++) {
+			struct io_rsrc_node *node = ctx->buf_table.nodes[j];
+			struct io_mapped_ubuf *other;
+			unsigned int k;
+
+			if (!node)
+				continue;
+			other = node->buf;
+			if (other == imu)
+				continue;
+
+			for (k = 0; k < other->nr_bvecs; k++) {
+				struct page *op = other->bvec[k].bv_page;
+
+				if (!PageCompound(op))
+					continue;
+				if (compound_head(op) == hpage)
+					goto next_hpage;
+			}
+		}
+		acct += page_size(hpage) >> PAGE_SHIFT;
+next_hpage:
+		;
+	}
+	return acct;
+}
+
 static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
 {
+	unsigned long acct;
+
 	if (unlikely(refcount_read(&imu->refs) > 1)) {
 		if (!refcount_dec_and_test(&imu->refs))
 			return;
 	}
 
-	if (imu->acct_pages)
-		io_unaccount_mem(ctx->user, ctx->mm_account, imu->acct_pages);
+	acct = io_buffer_calc_unaccount(ctx, imu);
+	if (acct)
+		io_unaccount_mem(ctx->user, ctx->mm_account, acct);
 	imu->release(imu->priv);
 	io_free_imu(ctx, imu);
 }
-- 
2.34.1


