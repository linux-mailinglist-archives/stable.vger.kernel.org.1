Return-Path: <stable+bounces-176594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE59B39B4D
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 13:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D71165E1C
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 11:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FF315B0FE;
	Thu, 28 Aug 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UzYBM3Yp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D74A23
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379767; cv=none; b=DIWkcMhEpcSvbEMCSPQ3NEhPaikHYysyqOK2ezKGBeuWfwvYx7zDYwLHgzekDd8LR0jOa4xasApKrEbpfJJqRPpaGRChzSG2iHmFKKhRYhG65iPDRbS6+HPFthPoyr1K0J5Tqa5sKGYYIXoCqbOGOfOVnBt8tx5kR7artutonU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379767; c=relaxed/simple;
	bh=x2CwY0f27ONX+8fmDC68h7bPHgxl9g7WINlENPZM7FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rw/5T44PTMNMz80k1UXpHK888NrweqErup4VfeICWXPh0RnjGMT5k+/mIUpUcRpLvBC5MVsEItUKC1c+zHOa6Ly8Lw3RHNE55a+bvPIEN0KIgrvperrY6m566+avyV1z35GQEsfMpkiY8mZZAPpsClan0s1lqaH6HXRvB0uorFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UzYBM3Yp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b4d892175so4676885e9.2
        for <stable@vger.kernel.org>; Thu, 28 Aug 2025 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756379763; x=1756984563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QHBOrXAja8iWLDpJiD9eodym9F/g93zNuwCDVC3UT0=;
        b=UzYBM3YpxrIrUDUDvNEAWw2vlcnHMx9856CwgCzIbpqufWz5OIC7H3YnE9AEr+5ViS
         CX0GWtKb0n7Rke7qJPva1KgsXh7vscFoPb9p955qR5TqOlqnGH99lfR9htG0G+yoZfVP
         wWaXDhQCVi+E/lshbryHpuCGuFUB6qUIu23Xi7K4Up92Tws8mHzDJm4Wip5NA0axCmt7
         WcTcEbMjBpxuJBxhdaXo6XEUx67BWrIP3HYEs6FjNoO62dUJuncyzJLJbYhLvVOFVMaS
         YFdGN6iYOJ9culihj1bkvcuzxY1IDmnAYuAdwrMhrTxIkUBtUgYREytBFt8MQO6UhAUq
         gj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756379763; x=1756984563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QHBOrXAja8iWLDpJiD9eodym9F/g93zNuwCDVC3UT0=;
        b=BOxZvpYVs7lvU4ZhsrcZXh/6rr9zGN+qZTu78JeuyvjiVYPRA+9R1Cd8s4+bL25gG4
         ZeWUiUPdFLS/4lq+eI9FXrQ9ZhGMuxCbO6SXD9H3W32IM22512HHPjnws+sa/2oWbq+M
         smk1IlU6O4AtrmOKaNyHiwUU/XmORHkTI0RyD0zGH/PTUMzPkE4nZPwBLd/GvXFjknYj
         k3Zgo87gEC1PB7cI3ymZ7IZhBlPOznbrrqLi3hsAuur2AvJIzYRwgVfSIqhZ0auilb7H
         frsPgfmuOskqEFZ33au/aOHmw67aoq/RC81reyhgItMB7kUjVAKT4L+0iErHS1Q2OWuP
         VcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl6HhgdhnFNjqz+lvgTOrcEzcVj3flgDEzfF9p+k+3UvNvxpfBdN8/85Kj5fRLIuB/izBxi6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eHjHkvCisoLc5Y0J6maO/7AS34tqQXbOGtghxEl8TmIN6naH
	SfrYU9pMNFzj1RUbFi4w/noeO8hP3hMjjnPIL44OVchzWVviTacbi7Cga8PmXJtxQck=
X-Gm-Gg: ASbGncuESRdgBaXO1hUVFsABbXfHVGGhuNJnOVcslRtvbvrIxjuQtzpZUhbzIf06fQK
	rtqpP00t3ce4vVHqenfyNGYFEUfi2mwmYqC5STNfNprdrfDHSOAnzpYgmr7fEBpD3j0mr6fO1MN
	P5QWFu8NBZw5eUcpE+sRKmW8YS2aL5ZQpWz+Ugzs8otOvVWl8NcsEEXnfTP2Gh/fhEGWn1dWd1/
	BuKsAj5gosZO3dP8QDHHRzifVjfOlVb4fijm5F+jKbrWsf54g9F70GkVXEBKa1r7HDBGe8B7C44
	o84nnotE61fyKWSBteyBl7Ri1IrzbASZvfa5k7C9va7Osha3+WquUU2HjisSeNhywFxgbBuBFyU
	aW9rlgg8F0jq1o3XY/M80Qyook6Rp200RaW0tsSQ37rzl05KeBgiiiv0SSErfnac/EfhVoGuMw3
	VeWGJCMol25nzq9Ndh/EXiE8qc2B3HMOGM
X-Google-Smtp-Source: AGHT+IErHCmWbg2YMUeSrTBCHGmKcPBhN8tMdoOfMQOVPGyHr5ox98O0LhP5cUl5kKNQOFlN8MsLNw==
X-Received: by 2002:a05:600c:35c9:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-45b517a0655mr207154405e9.11.1756379762476;
        Thu, 28 Aug 2025 04:16:02 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c93sm69608945e9.14.2025.08.28.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:16:01 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Slava.Dubeyko@ibm.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph/addr: fix crash after fscrypt_encrypt_pagecache_blocks() error
Date: Thu, 28 Aug 2025 13:15:52 +0200
Message-ID: <20250828111552.686973-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function move_dirty_folio_in_page_array() was created by commit
ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method") by
moving code from ceph_writepages_start() to this function.

This new function is supposed to return an error code which is checked
by the caller (now ceph_process_folio_batch()), and on error, the
caller invokes redirty_page_for_writepage() and then breaks from the
loop.

However, the refactoring commit has gone wrong, and it by accident, it
always returns 0 (= success) because it first NULLs the pointer and
then returns PTR_ERR(NULL) which is always 0.  This means errors are
silently ignored, leaving NULL entries in the page array, which may
later crash the kernel.

The simple solution is to call PTR_ERR() before clearing the pointer.

Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Link: https://lore.kernel.org/ceph-devel/aK4v548CId5GIKG1@swift.blarg.de/
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8b202d789e93..e3e0d477f3f7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1264,7 +1264,9 @@ static inline int move_dirty_folio_in_page_array(struct address_space *mapping,
 								0,
 								gfp_flags);
 		if (IS_ERR(pages[index])) {
-			if (PTR_ERR(pages[index]) == -EINVAL) {
+			int err = PTR_ERR(pages[index]);
+
+			if (err == -EINVAL) {
 				pr_err_client(cl, "inode->i_blkbits=%hhu\n",
 						inode->i_blkbits);
 			}
@@ -1273,7 +1275,7 @@ static inline int move_dirty_folio_in_page_array(struct address_space *mapping,
 			BUG_ON(ceph_wbc->locked_pages == 0);
 
 			pages[index] = NULL;
-			return PTR_ERR(pages[index]);
+			return err;
 		}
 	} else {
 		pages[index] = &folio->page;
-- 
2.47.2


