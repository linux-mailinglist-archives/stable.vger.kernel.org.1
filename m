Return-Path: <stable+bounces-78584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C842F98C751
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 23:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559BA286389
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC181C3F3C;
	Tue,  1 Oct 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlOgS67C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C61C1AC9
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816976; cv=none; b=RIw1xWcYzXeYxoAcShLW633C5gGGn8b2b/JcRe8WMsumTIPcfpxwVPC4Pg/XduK2iR4oV0MWqSft5pwN42I3DQv8RZbunKsfRa6tbxTSfep7rfHP6B6k6G+bKQZ5WIaydDWKedaI906tbejU3bl9YzG1quULC9uTkldSM+/I1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816976; c=relaxed/simple;
	bh=cJ/2Re56157t6q1UXeGWFufbfXA+YtxlyYhcIYg3skA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIPbLvCW1ymFjYCSZoH/pnvuHtMLGNK0zBc32kKdFYlT4xVIBmFggh8hVO7gecCcrsiJsjE3k4gDZB1lqsge83UwrVUzNZ2vVXAUlSkRMx1iI3cJ32DDuIL9FD1gd0wAJiaHs7AQTPrOXQaeQsCxMl78dkk8DvsBdKYxABYBNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlOgS67C; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20bcae5e482so129225ad.0
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816973; x=1728421773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qdvAoevzEock6Xd3WXHPH7pOSUyoqph8Y1/PDGhcbUE=;
        b=OlOgS67C9CoxV9DGa/1v9UI/xOMT56TWPj9qCapqLIP78iez0lDlV39Qc64YE3fXTo
         1A0rF31jk1mzOP2Kpki+Ia6gamXwzFuLreNVv7yvJrlK8HRXrzPF+GBCpjn0DVEBBu8D
         Gn9C8zJij3JptNEtpZZqCm8txRbAW+mWk0Pg6H6kDrVQRS4FuR+47KC5gMbot9tlqH6z
         oxEAuWCY7UiGd6Lwz3x1JwJnR/bEgg6Rf2cVQ8NZl7qEzII58sDxlcV87rRvJTVe0Q60
         supCWhndabs4C6It9JE5wbEQI7VW9KAShjRhldSc7OHg+vIPk747RY0jWrywpfRM3n1G
         Spjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816973; x=1728421773;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdvAoevzEock6Xd3WXHPH7pOSUyoqph8Y1/PDGhcbUE=;
        b=BBFyqeYwMM7oAVw8QOKSc0NFR1w/A26sOWF9UL2fISJrW3YmD+A+d9YaJVyeBFkTiL
         N85V5EEK58i9GklN4knz308kz36gV59JlCZ8EAqMbBY3zZFVgitXe3oLfqsf75/QfFsd
         RWTwPuFibMcybUJHD5QkOx1yvdFuLCIrvkY61h5q/aVuotQiX8Ji96bRPlm+07B97kpN
         KWnq7Aaf+KVoYeb6rFvP74D05f/UYC27U+sc8H4K7UYNWvefHp14yog1GCa5FhETv90y
         EC8BmzmukngXTFiIrDGyfmRmNbw8PVIKrKIuMcROF5VL5aAdG0ImnYjkqMEtmZzBSpu3
         44SQ==
X-Gm-Message-State: AOJu0YwBAiuXXYBz8oQvSao5V23Z2QGkoNmDYTk/s8RFls+rBpxUKHK4
	x3vSsJPaMMcTutg330Ln/CULxoCtI02cEtvAsku4NxwWiS45hIv6cSRV/Xyzvok=
X-Google-Smtp-Source: AGHT+IHdO/CaD5IQX4o6Ribz2rM3d6oyF1wJzFoKLnOgDhnqyKJS4AxGhCzGklJa4pfUzLWjeT0BoA==
X-Received: by 2002:a17:90a:fd90:b0:2d8:94f1:b572 with SMTP id 98e67ed59e1d1-2e1846b5349mr1147329a91.18.1727816973617;
        Tue, 01 Oct 2024 14:09:33 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.120.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f798037sm34307a91.25.2024.10.01.14.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Oct 2024 14:09:33 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Christian Theune <ct@flyingcircus.io>,
	Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@meta.com>,
	Sam James <sam@gentoo.org>,
	Daniel Dao <dqminh@cloudflare.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y 6.6.y 1/3] mm/filemap: return early if failed to allocate memory for split
Date: Wed,  2 Oct 2024 05:06:23 +0800
Message-ID: <20241001210625.95825-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001210625.95825-1-ryncsn@gmail.com>
References: <20241001210625.95825-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

commit de60fd8ddeda2b41fbe11df11733838c5f684616 upstream.

xas_split_alloc could fail with NOMEM, and in such case, it should abort
early instead of keep going and fail the xas_split below.

Link: https://lkml.kernel.org/r/20240416071722.45997-1-ryncsn@gmail.com
Link: https://lkml.kernel.org/r/20240415171857.19244-1-ryncsn@gmail.com
Link: https://lkml.kernel.org/r/20240415171857.19244-2-ryncsn@gmail.com
Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 6758c1128ceb ("mm/filemap: optimize filemap folio adding")
---
 mm/filemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2809b1174f04..f85c13a1b739 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -867,9 +867,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
 		void *entry, *old = NULL;
 
-		if (order > folio_order(folio))
+		if (order > folio_order(folio)) {
 			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
 					order, gfp);
+			if (xas_error(&xas))
+				goto error;
+		}
 		xas_lock_irq(&xas);
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;
-- 
2.46.1


