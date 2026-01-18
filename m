Return-Path: <stable+bounces-210239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D4AD3995C
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 20:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5F9B300252A
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596B92F3C26;
	Sun, 18 Jan 2026 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipBBsQcG"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45062749FE
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768764207; cv=none; b=qSBnQaPSlXPZBOzTxl+z6/ySPcRI+vX3cqbgORziBubkLsvkegUs7zAi43JDtCWjLdS0JpyyCCU7/zeDue5alDZleedeD8v5Vx6KjPtg2DfmBKYbl+TbFP0cwPpvEKTe6fvXD5SOaRgCiux0Zj35efZvjiyuq2Tq9UkV9XQ5cvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768764207; c=relaxed/simple;
	bh=53UopOiSS5GM7ARutLD39Ovf/BQMy7Mk8S2UQAf9p18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LwiG7WJzM6ri2SFW5wswQQiqVr/I1SbqtUNoRF2u52vtwwPSgo/l97BX/oVwdBlHWIUjn5/u18jxwdmJ2UV9JWn2fK8JJWLn4C2GoHNimrDsPPkZwyfycbQNY5S6FZXK80Nh46MvNnI5vdEt2s3EyHYhrdWAnEt8cKZ8LHikQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipBBsQcG; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c92df37fdso1345583b6e.3
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 11:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768764204; x=1769369004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDtxksZFS0nrsjFFEzMEftEkeVqAD5J3c5aurgBd+rU=;
        b=ipBBsQcG+7hi8OD6Ux8WsQ+AjzIwXFUXDHcuF3pWjdu7wNp1S6VUTai0HAuFEXmBA2
         4dsWgMtzkUSHHrCOo+8UKiPNr7s+O1Rp+VpnzKPuNfX3XM4Az6dv3r8xX6b7nkOuVyym
         KrkW2WIRsq9US+LUMNZL+ZQRLx5F+dAQ+LAWSavJdWGiLnQ3IdfVfDsXliLYzZmSow+Y
         Zehn1xz1N22knkslJSSlt3GFDGtUYiVHuSfYoLGVc9xHxdJREmjktvu4i3e+bu0bexXk
         wH6NtQS4UJtGCK0j7lZ04dZ62vDlIioejHy8jClGunYlNnWDd2oKqW7RDHO9693T6cuX
         9jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768764204; x=1769369004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDtxksZFS0nrsjFFEzMEftEkeVqAD5J3c5aurgBd+rU=;
        b=K6Chq38ZGh9YyN7OqBpqbKnjcuJaZ9uqr91ZCPdlS2wOUAY4NT+iepxVx/uhn1/Fzl
         ZQosC1qqZ5w0YEzWzW0IIemA0b9l2Yd5LGbMmeDcW8LNv00LgMjcSInobTWykya3sS+I
         Ep6LIi6k95GMCVHCdLdkVPDTvnOPb4mFfFkVnde2zb1AJFef/W8bV9EC0YRerAEiG5aK
         qsgSAGGE2Hbg3g477hZtHRGw+iVrcX5Fh8zyRAn0m1YtF4DQulOZBGcd6PSpPtIwPSd1
         NsjjgzA9e5G2HXhqunbpqi3Nf6UvLf4aKeiYBjJ/velO5g+XrOxLZAgObns8yiZ0XhmD
         TlTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwouwvvSV7Kg8By5j6VyDaIXFPVl9PQ5ohs8fZ8MjsghGxFQO8q6nfbwnv2Ke4vsleBUPxCaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcSdG0vq3AgwQFhPt2GE+0IISw+QsAtWe3ZAuC9QpJMP6d53L
	ZyJBh/KeeIe9KCFyp7yggBmV/Z5eYKhM1BWB0aixzp6ANIbeipGwhJ4N
X-Gm-Gg: AY/fxX4U6KhvZBU4gvzXOEPz9xjHGY0+2vLoIoOfWVhSA532JAj9uQbvyol0BMw8GyU
	iqij/22/B2ZsRyQKAPsrdf96A3hBsqYnfw31es6SEiXmEXgHUADGkJtnkxjQEK+QWkg8UNMzFwL
	vxOMbOnm0hBfeQOcM/MtqtRtNymNzHO05Cv3xhrfFtn1zEJgtSjc6+Lr55bkYqGAm8y2ky6l7Sd
	ombdpvosPFSjNBTXKiWQ5gJ65bznY9+pKxSG+YzZTDThyy6IW703AS9NpOV6HLL3RpQhU7OiCiI
	8X1q47OabfpVnkNw6/pt2ncbYw1/+HcQ31IYtD3wlxlnzdiem/Dyedjk29rv5VrnsFz/fiEOLhF
	k+gQIZ3eiXmUu7yF3HLSSr596zGSOf6kUPnrw0wDG2/PgYkCOSGtd+YClMWyjRMqzqLT9WLxIHt
	8ntSkE38jiytcvX5YATRRLX3mdvCiwPcMF
X-Received: by 2002:a05:6808:1986:b0:45c:90d8:c843 with SMTP id 5614622812f47-45c9c091394mr4106712b6e.37.1768764204403;
        Sun, 18 Jan 2026 11:23:24 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf000b80sm5543917a34.0.2026.01.18.11.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 11:23:23 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Cc: ocfs2-devel@lists.linux.dev,
	stable@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] ocfs2: fix potential OOB access in ocfs2_adjust_adjacent_records()
Date: Sun, 18 Jan 2026 19:23:18 +0000
Message-Id: <20260118192318.44212-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ocfs2_adjust_adjacent_records(), the code dereferences
right_child_el->l_recs[0] without verifying that the extent list
actually contains any records.

If right_child_el->l_next_free_rec is 0 (e.g., due to a corrupted
filesystem image), this results in an out-of-bounds access when
accessing l_recs[0].e_cpos.

In contrast, ocfs2_adjust_rightmost_records() explicitly validates
that l_next_free_rec is non-zero before accessing records.

This patch adds a check to ensure l_next_free_rec is not zero before
proceeding. If the list is empty, we log an error and return to avoid
reading invalid data.

Fixes: dcd0538ff4e8 ("ocfs2: sparse b-tree support")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 fs/ocfs2/alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 58bf58b68955..bc6f26613e6e 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1974,6 +1974,11 @@ static void ocfs2_adjust_adjacent_records(struct ocfs2_extent_rec *left_rec,
 {
 	u32 left_clusters, right_end;
 
+	if (le16_to_cpu(right_child_el->l_next_free_rec) == 0) {
+		mlog(ML_ERROR, "Extent list has no records\n");
+		return;
+	}
+
 	/*
 	 * Interior nodes never have holes. Their cpos is the cpos of
 	 * the leftmost record in their child list. Their cluster
-- 
2.25.1


