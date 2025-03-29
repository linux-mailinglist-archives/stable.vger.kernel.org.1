Return-Path: <stable+bounces-126997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A1A755DB
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 12:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BE1B7A63A5
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4141AF0CA;
	Sat, 29 Mar 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRROQjr5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650854763;
	Sat, 29 Mar 2025 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743247044; cv=none; b=bNHuK9UKGldYfIrrqx8hB+wlyXMBU0gZBnY6RLIlncys6Qv87Rn0u2XSFrMioz2it+eASBIHMeOE5LZ0OWp1ni5wrEeY/5OsgJhI0u8l3whPWLwbYtsPS9jAd9xbOCCr1p2Inu7BU0OxosFE2v76Nr95FG1ifsOhsu0OK5ACvyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743247044; c=relaxed/simple;
	bh=iVyKzVfxR8LdP5by3NoY8zhrOtkB7jVDbkJlfjDY8OE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J6apyt9NZczyEsBEfiw6OZUPQVzXBYbrfnAxGZfNsx5/diuEYWWoFwd43nEg/WpZi/e/x6ZHJFSVQh+tebfWRJLG6bmQy8kFbRtNnDJt22LdWveacJK4W3zHn8NgP7jrMP0gocy1lNke/QeEI5Iv6XTCy18kC2OFDRxZzu3KaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRROQjr5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so16017185e9.1;
        Sat, 29 Mar 2025 04:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743247040; x=1743851840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCZ2IYJ2ToIg9/KMdOINj9YW27Hjn4u6ydCp4dWPNz0=;
        b=cRROQjr5/4OoQFSgLDATLr7vPcd6bd6UODvDfOhEJjYRvi0IFdCDn9X2YfjOFYdAKN
         evDlHP/PlhLAD9fEry2EqFeBRCHIjF/nzWtYx0jNO84amj9B9yKFA4qfIVL96X5buVXg
         nTVvOzTdkv0iqBP47/bIyraDq2Z+VDbXNCXsApCXrIpbG4dgN6DhTgzNsZLzlsLsmbWS
         7D0UJrpqanDVlYpV52Tma8Mpms0PoW6LE54IT7EgXCElotk1U1x8K/cuYRlPPVgzPenr
         SsTrwVyRCl0Y9uEwnlK6EvEf0Jskjg2G/NIwMZJVa8zrp5PRblLE2ts1TxdeTRJkkUnZ
         qzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743247041; x=1743851841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCZ2IYJ2ToIg9/KMdOINj9YW27Hjn4u6ydCp4dWPNz0=;
        b=N3JW0DljNhIANVsBQM7xlZmhdAUWmvSbh4wpG+3d4orlRKv2fDsu072dVuwC5kMYED
         xIIc1T5srf+1Zbm3eQRZuI7WJHueJxUdJjCTSpBq//1pTbjOj8TKNikowG6Fd/TBtWp2
         C12WnaYBLnvVcyhKjtPaTZbx8AAyuLuLp6c0iSmzRz7NbnI/I3C2vh0KfZsJNlGGEeiB
         l/a/OjvWE30muI1QFSV4h2QyAPWYk9pvhoeNhfpi62ziujD3jugjZWhwOMA+xOEX+pq6
         mbFy9y4nOdpkVk8VnqidI9mE3ChsZNbaFzd1S52uMGhEze5LMbNhldAE70P9mbN5nRux
         wUvA==
X-Forwarded-Encrypted: i=1; AJvYcCXGs//XFH25+8ohN7pKWYXXNLvWuQfCu7u/+vQizxjQ0tAAJdHaD1n77gvJPkHaxByVlzKove45@vger.kernel.org, AJvYcCXaVbJxIEmfPOF8tayXxY0sFHkzHOu0L0IljB0MryS87XSTTlS0ZOQMfLX9YtWVS/YfUCfH8Z8w48xEAFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvN/rkzLA44mF0du/KD/cIHHS2q79bnRmV0CfrujuHV7C7fHoZ
	FupaEgCsPRSsu/u61v14q/sLMKJIsaOjqeG5acvqogYba04Sgfad60C1wg==
X-Gm-Gg: ASbGnctQs1bZx1KHyY4PWfyZyqT9Fj9J5EVZZAHezQrpJZ6Xp8KS4glK+x2ZzPxm2pA
	s7EL3uqJ2sIbSJ1UQEBJd0w8W2QXOKN6vnIf4n1KKZqFaG21Nu65yjg1XKYdAZYYYtO8FBdmItF
	JeOa0ZLKxhiaoYA+w3EKmIHym4AnDYRYD80zWy3or4z3o0F8a0lEF9rHG/VrGjmoQxavrhDDaif
	6FgRoDuHvuPTNjLEM+c2+HrHsdlp6sdAUoTb6LFfG7VDdM349YeIjGaMrRbNMc6Y8lzNWW6F0CB
	6qZWkT8QeEH1GQXNdYF/EP0z7uZXRhmTZDu26seNK1YEjg==
X-Google-Smtp-Source: AGHT+IGDbZteM2t+YPVw5ySzoBnXTQv1/QQFxNbONb1Mvy0uKs3/oMD8mkZWX/L6t/AP9Jyjt5WQWQ==
X-Received: by 2002:a05:600c:b98:b0:43d:16a0:d82c with SMTP id 5b1f17b1804b1-43db61d7b53mr27399475e9.2.1743247040450;
        Sat, 29 Mar 2025 04:17:20 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:c564:b82e:4883:713c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8ff042bcsm57170215e9.28.2025.03.29.04.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 04:17:20 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+e41e83af7a07a4df8051@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] ocfs2: Validate chain list bits per cluster to prevent div-by-zero
Date: Sat, 29 Mar 2025 11:16:54 +0000
Message-Id: <20250329111654.5764-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The call trace shows that the div error occurs on the following line where the code sets 
the e_cpos member of the extent record while dividing bg_bits by the bits per 
cluster value from the chain list:

		rec->e_cpos = cpu_to_le32(le16_to_cpu(bg->bg_bits) /
				  le16_to_cpu(cl->cl_bpc));
				  
Looking at the code disassembly we see the problem occurred during the divw instruction
which performs a 16-bit unsigned divide operation. The main ways a divide error can occur is
if:

1) the divisor is 0
2) if the quotient is too large for the designated register (overflow).

Normally the divisor being 0 is the most common cause for a division error to occur.

Focusing on the bits per cluster cl->cl_bpc (since it is the divisor) we see that cl is created in
ocfs2_block_group_alloc(), cl is derived from ocfs2_dinode->id2.i_chain. To fix this issue we should 
verify the cl_bpc member in the chain list to ensure it is valid and non-zero.

Looking through the rest of the OCFS2 code it seems like there are other places which could benefit 
from improved checks of the cl_bpc members of chain lists like the following:

In ocfs2_group_extend():

	cl_bpc = le16_to_cpu(fe->id2.i_chain.cl_bpc);
	if (le16_to_cpu(group->bg_bits) / cl_bpc + new_clusters >
		le16_to_cpu(fe->id2.i_chain.cl_cpg)) {
		ret = -EINVAL;
		goto out_unlock;
	}

Reported-by: syzbot <syzbot+e41e83af7a07a4df8051@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=e41e83af7a07a4df8051
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 fs/ocfs2/resize.c   | 4 ++--
 fs/ocfs2/suballoc.c | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
index b0733c08ed13..22352c027ecd 100644
--- a/fs/ocfs2/resize.c
+++ b/fs/ocfs2/resize.c
@@ -329,8 +329,8 @@ int ocfs2_group_extend(struct inode * inode, int new_clusters)
 	group = (struct ocfs2_group_desc *)group_bh->b_data;
 
 	cl_bpc = le16_to_cpu(fe->id2.i_chain.cl_bpc);
-	if (le16_to_cpu(group->bg_bits) / cl_bpc + new_clusters >
-		le16_to_cpu(fe->id2.i_chain.cl_cpg)) {
+	if (!cl_bpc || le16_to_cpu(group->bg_bits) / cl_bpc + new_clusters >
+		       le16_to_cpu(fe->id2.i_chain.cl_cpg)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index f7b483f0de2a..844cb36bd7ab 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -671,6 +671,11 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
 	BUG_ON(ocfs2_is_cluster_bitmap(alloc_inode));
 
 	cl = &fe->id2.i_chain;
+	if (!le16_to_cpu(cl->cl_bpc)) {
+		status = -EINVAL;
+		goto bail;
+	}
+
 	status = ocfs2_reserve_clusters_with_limit(osb,
 						   le16_to_cpu(cl->cl_cpg),
 						   max_block, flags, &ac);
-- 
2.39.5


