Return-Path: <stable+bounces-114159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E9DA2B096
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F242A3A5652
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119281A0BF3;
	Thu,  6 Feb 2025 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI7goJpQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684AF1A072A
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865774; cv=none; b=eCIKBI8vH3qFABwiGyJ1RZU1F6fwPvUfsfInXzr6JfpirPZ8PLtFkZbAaYWowrGK0vxvwGUzghEHY7bgug09POjLuhNhpMsRDEIV3KzRALT2A52cw1woaC6IQPhCd8os3glSy+NfykPAx++xvrK6oOd9zLb9/uGHZLxMkKiAl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865774; c=relaxed/simple;
	bh=+CJjMItBN+amB7BHtVMJkF0jPirq8oWF7UQNN/jcKoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYENz6y0Pmu8xRlvHeqwd/dUt3SwSrlDmH/A0JNXeddLv371EY3CiMaGkJMgMXgxhxEB/Wr5+/YHoLMT7QbOAtYWkDeDMWnOIgtuLhjTbSyKRoO7sLvyfXVMVUyFoqXBIYCncrF0LuAXJi/9TNUwbKwsqb5iPB0wdDEgrvZem+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI7goJpQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21c2f1b610dso31383065ad.0
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 10:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738865772; x=1739470572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tde+v8aLUyEkAIpdE5FG5PX7/6c9Ke8/XHJAD7odEWA=;
        b=kI7goJpQamuG+BRssmBS9yZlgeuMafPUPZ1rkQVk079GweWwaQ76Ptsqppy1KWl4w6
         i1s6QOm/TVFDLlI2iJ92ff0V1726XRipi5GXAEFegHHdoOjzfbMwiYABdxt+v3Z1P+vp
         lJggGiL0dL/IwpB9UcWreWXcGfqjwA4F52OyNzE/1fSziezI7RI3pW9Qic/32heVuJVd
         e27d0sA+YNqw7zOFWA/Si7NyYbx6xeNkA2mk2wc60ZNcnUNCUg3xUNEVNdheoYZXSZHU
         X14pMetb2+bOqKC3Y0rgtCDRJybX0gpqdC6RznLrMFteMM9aKkWOJXIstcW59iGGlaXB
         txdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865772; x=1739470572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tde+v8aLUyEkAIpdE5FG5PX7/6c9Ke8/XHJAD7odEWA=;
        b=RNjThtyneaoDRx1SuS9NF/EXEQb7gKGL2Q2tAxel2odQGC2UyayZcuhEJtHo2LdAY2
         jlLMH6WxGeC4jFwID0E+5HjvzAA0aT290as2RIjwcLyEMsY6tLba9qCeG1VKfM3UH1Zz
         3gL7faYD6mow9OiqmTQmatWwGDIwibIqW/KXLbriOY8r2/IARNxFpNvyf/0t9+B1Qqo8
         Qvg913E76vspUMVAjmNwMHBevxCA5BHrybDSFQFQmIV7neqs7o/saAQjUrouxuTv5arf
         NQaLKfCfuAvrPitrWVcmScxLZpKTadk43GKQQoqLSX+nipBDUBo1pVKMN+fSXtVfEYfP
         kwrw==
X-Gm-Message-State: AOJu0YyaP4tsohecI4jxY9D8jrxsvKw29YKrczGStZRfgtYCDaBcdTvS
	/Uj5ALBGYHOwfI+0RA+wqdB0AnhJ8GQo65NkLBzDebe4Ed3hhelDhgajxw==
X-Gm-Gg: ASbGncsdI1GP3WQj1Rx4pp8eXF4VMkeyfySWCZWfvVpISPeRPW0sxusYoNvnmLs4x8h
	ZOaGc9AZiIg4ZonzHBELsQVN6h0/6Ec+XaFQb8d6gvGI3ItjBvDtu6FamiFMd/bAAUJJdzlMg/r
	1AmZ0+r6zwajYchEikBYb35PwqRfkA8E1+4j6IAo7VQeyIKjh9aCbUKmIaD28Q6QmI/drj//gHg
	Oo+PQn4TldbBErxmja5kgmrMwmpKdQST0fDD2lgguv28BfZGzxiarA9EpD7gpwwKu806A0OwuMV
	tLKtcc1PoJuPZDEU8IVcy9fGdefwSbHRijiLb+xr1rMHOCB2sDPCqprZ4A==
X-Google-Smtp-Source: AGHT+IHFaHYVvv/Q1VXiOdDI+Oiie17SmjYN7M/F7FJbejjS4QIWGRgKci9DMhkIXl6gcdYr+8UG+A==
X-Received: by 2002:a05:6a20:d49a:b0:1e0:ae58:2945 with SMTP id adf61e73a8af0-1ee03b12991mr771846637.31.1738865772227;
        Thu, 06 Feb 2025 10:16:12 -0800 (PST)
Received: from carrot.. (i222-151-22-8.s42.a014.ap.plala.or.jp. [222.151.22.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf1375sm1587200b3a.119.2025.02.06.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:16:11 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 3/3] nilfs2: protect access to buffers with no active references
Date: Fri,  7 Feb 2025 03:14:32 +0900
Message-ID: <20250206181559.7166-4-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206181559.7166-1-konishi.ryusuke@gmail.com>
References: <20250206181559.7166-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 367a9bffabe08c04f6d725032cce3d891b2b9e1a upstream.

nilfs_lookup_dirty_data_buffers(), which iterates through the buffers
attached to dirty data folios/pages, accesses the attached buffers without
locking the folios/pages.

For data cache, nilfs_clear_folio_dirty() may be called asynchronously
when the file system degenerates to read only, so
nilfs_lookup_dirty_data_buffers() still has the potential to cause use
after free issues when buffers lose the protection of their dirty state
midway due to this asynchronous clearing and are unintentionally freed by
try_to_free_buffers().

Eliminate this race issue by adjusting the lock section in this function.

[konishi.ryusuke@gmail.com: adjusted for page/folio conversion]
Link: https://lkml.kernel.org/r/20250107200202.6432-3-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Fixes: 8c26c4e2694a ("nilfs2: fix issue with flush kernel thread after remount in RO mode because of driver's internal error or metadata corruption")
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/nilfs2/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 6bc8ad0d41f8..af4ab80443fe 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -732,7 +732,6 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		}
 		if (!page_has_buffers(page))
 			create_empty_buffers(page, i_blocksize(inode), 0);
-		unlock_page(page);
 
 		bh = head = page_buffers(page);
 		do {
@@ -742,11 +741,14 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 			list_add_tail(&bh->b_assoc_buffers, listp);
 			ndirties++;
 			if (unlikely(ndirties >= nlimit)) {
+				unlock_page(page);
 				pagevec_release(&pvec);
 				cond_resched();
 				return ndirties;
 			}
 		} while (bh = bh->b_this_page, bh != head);
+
+		unlock_page(page);
 	}
 	pagevec_release(&pvec);
 	cond_resched();
-- 
2.43.5


