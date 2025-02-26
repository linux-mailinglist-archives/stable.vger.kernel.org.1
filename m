Return-Path: <stable+bounces-119599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAA2A45350
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 03:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F76172DD1
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 02:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E980121CA0C;
	Wed, 26 Feb 2025 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSqaQ/TT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441D1DFE12;
	Wed, 26 Feb 2025 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537867; cv=none; b=YFjq8BKXJ5YZhLxy1B2P5/EExbSBHDOGT86kQWuDS67v0SzOm74Ej7cq8+WdxRQvD6xrK7osg6a48PSqN6w3CuzdqkNTOUfVPvapGenWiDK3u3PB/bxvjbTtvWSod6cZxHM2PUHcUqfEmG87+aWOK3Ts41+DUydM/wl5KeLNQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537867; c=relaxed/simple;
	bh=/SsM2lvIy+4I5ZCHTuMAYaqGMvZ9KXloNa1qv9ctxBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOD3Y/lqvkUQn8/SM8iEnzmuyv5tnj/yFaITvulKCsw5tyOu29GyP9jRdPFTFHwbW2uPg87d0/Fy88aZgiOlKEqSNMZ5iCOYhE2pLEOfcygYScwbs6JC595q3m4IY6YTW19R4shy29d9HHmJV7Sl+FyNy267r3u7pM9JCDE9A8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSqaQ/TT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c665ef4cso110954695ad.3;
        Tue, 25 Feb 2025 18:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740537865; x=1741142665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+uXOnMgJWi0E4hYshfQG3k7XndxyGiWTLCTuagC7Zs=;
        b=dSqaQ/TTu7O1v0144ArpZzJQ3wa0PKYQuCe1OLStuiEARdyWNPSHCnq+YrfUkc4/aV
         UJr8tlu7ltrfvyJYp0UETP6BToAUBJCPJat1bRv6mADiX27f+22cuX4MSMRxHfEgm69e
         qFFJLVEk81QdOmdXI+E/d2GuelrXvsMjUmUfUJcY9jZDoUoZU2C/4F/pS6gfXXDtS40l
         EYXoLzWzKFUqjzFvaPuMrhyS/QvydDJyXDMG8MlCsrOwlYg4JS8GMrfP5Du6WWSBQufG
         zMMIGmJutyHTXK+Y2AMOLxUI8s9xa8Xg1k6Npvv3XiynUGLQX/F1nyLy0WrZu92+70u8
         D6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740537865; x=1741142665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+uXOnMgJWi0E4hYshfQG3k7XndxyGiWTLCTuagC7Zs=;
        b=PplP7+VhWp80YgcdI+HCw34W5CzWJHp5ongd18kLJF5skRxvjnPS8cFuBONAIenc/O
         mV7JR4M8JxpOy9o+AGenizLY6/SWZfcagxRgRMclTY2XH5FP3zeiZdUK06YKhCcttdf1
         DptWazB+L6SOpHQi22kIbbCuOBn8gOmcB5kVbu0VqMVdrxXZDa/OJZd3dUMSl6+TctsH
         en1g8wBcdDtdwS4tSt8yVoEPWdYvGWEMOCQdWCh9UUUs40Au9bQ28a9X8laa/0xLC3Rm
         RADx4dm9fRMVi79J23LQyXiBsG+7N5KbsPNK8rwfY5ZcXtgO3W6F7l5P7Q835ihKWOCs
         /VEA==
X-Forwarded-Encrypted: i=1; AJvYcCUvqdpk4qcBbRh0yctzFHEjBbNpw+FpR/vBnHw7e9vFQBBFGuuVI4p7YYKRhSAwb04ktUqB+nAK@vger.kernel.org, AJvYcCWwYsWENq+NPMmJtxVBopMz4gDioqXcXYjy4hHQgV3nXiOMAxNsCWuWiHoBqUf3B8n0KmOF0x23W09tM/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsE9RlAgG5BpcRYtSFZj5RhkG/704G0To8dwoAIzjTyViBQXS
	8ZdfdEJbdhsryeo1719we0AVajfbX67vPIb4yBHXJPHMiyBtW4Ev
X-Gm-Gg: ASbGncvKBhL6OfzvpieG+nPnh18YBvKHFkYe17KvmqMg5u6orvTc4cLfT7KKvvCTjfy
	RQNmM8ETNiAAZlcJGO2Jsbw8KPWrf1sdfsLhsBC9LQ20+DJ1fhYa33NASpkkoHPLvRyHEJi7HfL
	Fh0zmbqRKvcOR5GxVVlHX8l8gxosg+HMVevC7wLe36Y2GGGLDFAwCnuTQ9nHywjOVQ71l7t03bd
	gx63VaUebUU/je8sIwZ5fTbBrU6wYbLZ5kYc/pHJv9bU21Ul1O/wEoetLrxfGT1AJen88r7n8rB
	Pjb8D3G8IR4izhQiQLLKGuecSbqyPIl9Z18WwXmC4A==
X-Google-Smtp-Source: AGHT+IG1fRtUBVAiDJJoWtLf7D3sCM2/eafgzX/Bc/o0aMgJXWae3BE9C/HTxwJmx8C5S+M/UIUHdA==
X-Received: by 2002:a17:902:e546:b0:221:7b4a:474b with SMTP id d9443c01a7336-2219ffb857dmr380479915ad.24.1740537865641;
        Tue, 25 Feb 2025 18:44:25 -0800 (PST)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00ab82sm21797685ad.70.2025.02.25.18.44.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Feb 2025 18:44:25 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: peterx@redhat.com,
	akpm@linux-foundation.org
Cc: 21cnbao@gmail.com,
	Liam.Howlett@oracle.com,
	aarcange@redhat.com,
	axelrasmussen@google.com,
	bgeffon@google.com,
	brauner@kernel.org,
	david@redhat.com,
	hughd@google.com,
	jannh@google.com,
	kaleshsingh@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lokeshgidra@google.com,
	mhocko@suse.com,
	ngeoffray@google.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	stable@vger.kernel.org,
	surenb@google.com,
	v-songbaohua@oppo.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	zhangpeng362@huawei.com,
	zhengtangquan@oppo.com
Subject: Re: [PATCH v2] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
Date: Wed, 26 Feb 2025 15:44:11 +1300
Message-Id: <20250226024411.47092-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <Z75nokRl5Bp0ywiX@x1.local>
References: <Z75nokRl5Bp0ywiX@x1.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Feb 26, 2025 at 2:00 PM Peter Xu <peterx@redhat.com> wrote:
>
> Acked-by: Peter Xu <peterx@redhat.com>
>

Thanks!

> Some nitpicks below, maybe no worth for a repost..

Hi Andrew,

Could you please help squash the below change?

From 42273506ba00723151e3a08b4ffd3f2c303e7ccc Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Wed, 26 Feb 2025 15:22:17 +1300
Subject: [PATCH] minor cleanup according to Peter Xu

According to Peter Xu:
1. Unnecessary line move.
2. Can drop this folio check as it just did check
   "!IS_ERR_OR_NULL(folio)"
3. Not sure if it can do any harm, but maybe still nicer
   to put swap before locking folio.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/userfaultfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 2df5d100e76d..2955e20f86bf 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1101,8 +1101,8 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
-
 	double_pt_unlock(dst_ptl, src_ptl);
+
 	return 0;
 }
 
@@ -1369,7 +1369,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			folio = filemap_get_folio(swap_address_space(entry),
 					swap_cache_index(entry));
 		if (!IS_ERR_OR_NULL(folio)) {
-			if (folio && folio_test_large(folio)) {
+			if (folio_test_large(folio)) {
 				err = -EBUSY;
 				folio_put(folio);
 				goto out;
@@ -1380,10 +1380,10 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				pte_unmap(&orig_src_pte);
 				pte_unmap(&orig_dst_pte);
 				src_pte = dst_pte = NULL;
-				/* now we can block and wait */
-				folio_lock(src_folio);
 				put_swap_device(si);
 				si = NULL;
+				/* now we can block and wait */
+				folio_lock(src_folio);
 				goto retry;
 			}
 		}
-- 
2.39.3 (Apple Git-146)

> Peter Xu
>

Thanks
Barry


