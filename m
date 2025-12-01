Return-Path: <stable+bounces-197911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB4EC977B6
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 14:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A81934306A
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883A530FC34;
	Mon,  1 Dec 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh1ClINV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB70D30BF79
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594458; cv=none; b=YMbHLLk6kSElyMTBME+AQZQt5WJBmW7QJofZLUvyZypV9RnomcA8ohCFVnUOHmyJBVqlwp/ditaQoXS1Tm7dbBSv6JFyLoMOzoBHLkx7qRs1iJc5BgUdcjYoSJm7NCEUtfwLbpIKeeN6oMMZZlE7rq2fIe1lCZGDlPCKXh52r98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594458; c=relaxed/simple;
	bh=plntT5yPstXzUw0Dpn9IFxN4qgEosGtIgjWLHWO4W/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ilr/P2dsqmpIusUN2vEdoIlL6Fv1BuV0bauA+qDNowF2eCULavajkA1JOj8eyj1Jf3Xp+TR2xgUfq3nb6uJ/qWNSZXgI76jRN23WouObbzxtF1oFkMmqC3JAB6bp8AtWkLoimRUrfqy6+CycwtyDfSbKvwn53shjYXG74cQaVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh1ClINV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7baf61be569so4917295b3a.3
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 05:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764594456; x=1765199256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNXu/1jH2RyJZPkWpjl7hMV9jv2CQqUwV3vZHk8AaQc=;
        b=Fh1ClINVJH1m8leJY2XGabZ3WYjjUfHjJXdI8kUfSDxHXXxbFkozLc4Zb/X6kQVr7I
         rP/H4TjhFqmdtCv9az9ktiMR55K6kii9mrdFaobYRafGWYJSrbDxk1RW6elDcu/jO/Gn
         cpBWwM4chNUR6bk5yT5cRh0MonjMIgkIoEo/mZ/G5TJzsKfUfnJPpPlCUHgKdOvEWM4X
         ngOLAabgbdmUCI4TV9+WvJz/IWRNVygUAqOjTezdEretK9OR8CqcFdyTPoxKou9pk7fj
         ctZusqzflyl9bBKz3hdnGF50lZyZdlz0L6KNlJXH6XnZ6e4SeXpEaMyUR8qf2ecaLVH3
         0ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764594456; x=1765199256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNXu/1jH2RyJZPkWpjl7hMV9jv2CQqUwV3vZHk8AaQc=;
        b=vQ11TM+sXtVC19aUAjY9EQEWNZQoCGrzj/svGj2SmFLRNIVE1KJlouSquY0P2skE3Y
         0JTWkfKo3vXERthilq5jKLKgsyYjZB5wx31EQoJCHPx0nJn71021ZuqnuWZxEI+A4oY4
         8I6kenDv1C4H7fpQVspg9+MawwZloi3kCtmfSV036C/etDQhVIaEZFTmk2wbsKs/Lwyd
         OOAqoea0d3YUMYrnqHMRBlJ2LDovXrr8ibmPoiI+kGLARMVEO1ennB3/rClgxj+y6XHR
         RqfQmipyEN8sdLqH3XMlo28MTSrq8M9m2Q6fDHJA+mj2PrNBm34Sk9lMw/l9eVoYeXvD
         IqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD+Ogc3nHTgDIT68pkkfQDI97yxKVUA0ib/VA3pMRhLjwxmS6VpUg49oFwez62hKoZQP9vODw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9UFDhPO5nTS2w3bt1zYpv0EvFIKIRoqboEe1MNRUJN3bmsTG
	6xNc2No3igQiFUa66Z8WUuAOHH2k1UqHhJSrb6QhoC+FGpKNx/8xAyIY
X-Gm-Gg: ASbGncvIUUUuFW2iwoyXzTN8FiJtXynIj+flUf9nGjzhTq+WjaTsZoF+fb4JF/UNBkF
	auXTs0lkK+lTQLL4Hh9PjB7kxWmCQ3pFuYzWrdsgKdqAiuo3L5PckfJ9bmRSMnyrYl/BFtjBLHX
	qTQzm14kNxmCw+bNs4RcUZm1gOkLTwwlaWh0Wz9G6+N7cbd85aMTe81w41+KJslxeOZeWvTW7MI
	95AKBARmiPmIAbKEIQEaJb6t5jl7X1y9s9Zzt06lobSBFNEKnJMQruhyirhWeVpBNk5FRre0tnK
	IuPcwRO5Bc1ZwLk+UtMexhNrSSdh33tOjtMl5V3rAVY6TcaV710ZAqMMs/hqs0LsgwUfQjL9glR
	aQC8jJjzbBjtQ3JvmfbhS2OaTyo4BgQJx+S1LH+GwssrtSHx/2CJmCDAVsDItRXs5Xfa7cYGiXx
	jH5oLvjOCawbXsNhV/RvmoopjjTe0=
X-Google-Smtp-Source: AGHT+IHPOrXcm13bffCEXfP6/yWgQTkgDN8RI4zKLTdSkUdTCCIaY6ua/6tI8O1gMmObE4vDOKYpRQ==
X-Received: by 2002:a05:6a00:2789:b0:7a2:73a9:97e with SMTP id d2e1a72fcca58-7c58e6016fdmr38241883b3a.26.1764594455804;
        Mon, 01 Dec 2025 05:07:35 -0800 (PST)
Received: from localhost.localdomain ([114.79.136.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db6ddsm13365913b3a.34.2025.12.01.05.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 05:07:35 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] ocfs2: fix kernel BUG in ocfs2_find_victim_chain
Date: Mon,  1 Dec 2025 18:37:11 +0530
Message-Id: <20251201130711.143900-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a kernel BUG in ocfs2_find_victim_chain() because the
`cl_next_free_rec` field of the allocation chain list (next free slot in 
the chain list) is 0, triggring the BUG_ON(!cl->cl_next_free_rec) 
condition in ocfs2_find_victim_chain() and panicking the kernel.

To fix this, an if condition is introduced in ocfs2_claim_suballoc_bits(),
just before calling ocfs2_find_victim_chain(), the code block in it being 
executed when either of the following conditions is true:

1. `cl_next_free_rec` is equal to 0, indicating that there are no free 
chains in the allocation chain list
2. `cl_next_free_rec` is greater than `cl_count` (the total number of 
chains in the allocation chain list)

Either of them being true is indicative of the fact that there are no 
chains left for usage. 

This is addressed using ocfs2_error(), which prints
the error log for debugging purposes, rather than panicking the kernel.

Reported-by: syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=96d38c6e1655c1420a72
Tested-by: syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com 
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
v2->v3
 - Revise log message for reflecting changes from v1->v2
 - Format code style as suggested in v2

v1->v2:
 - Remove extra line before the if statement in patch
 - Add upper limit check for cl->cl_next_free_rec in the if condition

 fs/ocfs2/suballoc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 6ac4dcd54588..e93fc842bb20 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1992,6 +1992,16 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 	}
 
 	cl = (struct ocfs2_chain_list *) &fe->id2.i_chain;
+	if (!le16_to_cpu(cl->cl_next_free_rec) ||
+	    le16_to_cpu(cl->cl_next_free_rec) > le16_to_cpu(cl->cl_count)) {
+		status = ocfs2_error(ac->ac_inode->i_sb,
+				     "Chain allocator dinode %llu has invalid next "
+				     "free chain record %u, but only %u total\n",
+				     (unsigned long long)le64_to_cpu(fe->i_blkno),
+				     le16_to_cpu(cl->cl_next_free_rec),
+				     le16_to_cpu(cl->cl_count));
+		goto bail;
+	}
 
 	victim = ocfs2_find_victim_chain(cl);
 	ac->ac_chain = victim;

base-commit: 939f15e640f193616691d3bcde0089760e75b0d3
-- 
2.34.1


