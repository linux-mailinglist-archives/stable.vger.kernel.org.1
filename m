Return-Path: <stable+bounces-197667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCCCC94E69
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 11:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AA2034AC0A
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E827CCEE;
	Sun, 30 Nov 2025 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6uchbDi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3932773D3
	for <stable@vger.kernel.org>; Sun, 30 Nov 2025 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499621; cv=none; b=DAPTZPW9vN659bHEmWEvaQWjNzzMPIu/Y1e2+Q5ocDSkbUFFRzGJoD2tefzjlWp6ONiR80DKBhkTxSR3RfWquWk/+4K+kg+RFy7gLKyvZn6WziHZYW5e0rlc65+1BknFJqXcoHzRGOHo8mUqGkywRNGp+jao4xPC+WC8UnwTpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499621; c=relaxed/simple;
	bh=rlIrI/UmoKYEL0vlVjf1XS3AzQOskSjVa2f/87hoTwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q0SiTJ3LlONfzZx27zcDpUWbAcIOzbZBaRyjYajdY18VV7RXzPHq5HOGPM8kjMM2QdkFU21UsrUQ+Ey/3SxireZEjFBov3wu9VWYOyrFQ0415IesBnZUKokk3EIxGWXqzvzprOrbE1aG2tlTd4Ft66OaGZB4W5VihWyHk0GndJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6uchbDi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297f35be2ffso48435315ad.2
        for <stable@vger.kernel.org>; Sun, 30 Nov 2025 02:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764499619; x=1765104419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qTNLxP/M5VH8d16ArvNC5jrTL5Ks/32ppFB8c0OA9Rk=;
        b=Y6uchbDiB4uvfX6+LRmJXtOvsJHNYqXKpFZZLCXKcTYTVwjbLmgAjtC9iBLC48satq
         dRJxCQmUV1XlxvxV+Ixv0u1E/3QFcQrQ8f+NDGBaQNaYGG8p0yso2xqCvDm0IEzM80h7
         AWSNZEUDzMmeVXGqa/61EH4pZqzW9Ld+BaMjJmjLMKx31n9tpi2W98CyiOly9vrVsdBR
         8Isp68uhwD32sykuGtTrnfrKs3iuGvxkWCUFPO6QB+w2RC4aQwPA1KNAL/E+iaPBsFFf
         wZF/rtJjGX8Bik+dA9pMzrGf5plvDrglziaPQ3Q7jl21irh40Ep2u6cibLLdtH9+nCVQ
         uq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764499619; x=1765104419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTNLxP/M5VH8d16ArvNC5jrTL5Ks/32ppFB8c0OA9Rk=;
        b=Qq965RUPuaZdwOsBH0Hw+wMn8X6rxa+4v6N14D1gAzwYhn0c8uCZGPm0fk0mJn5iY1
         w2LhkHTui2ziHxUCyLwiUfHLa2sLFL2M5oloODbFF64PveCWn+ivR6/Vw285qyYvhaMa
         1g+aGPuWu6iHPAeyDNQjP/6xN0zEy3qUrAU0/6w0Lm7gDIlx5V+2ytOuL4jLv+c7qSZA
         SfzlNlYKSFGrYAtJW+cFs030u+DqYYJLXso4c3nsDd8YfqLQipT6Sl/YMt0biX8WIuvs
         oEyhCN/uwhEtLBAZtAvO0UEqJ/NKX0Sf4CIs7glElZXBeuy9DMYo5vvynGVM2u14yThK
         2OWA==
X-Forwarded-Encrypted: i=1; AJvYcCX9CfsgvnS0eCx8Ew7rK9Xn1L8kCOZOPkUNSs75W0Ui+yRUnY5QIghESiQJFKR9J2CKX0IdeC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQz0nW+Ftc2zH7nTEFmoS2bCkd2/CC3HApL9xoIb3FsVKyv/XQ
	Nmp10zAehxZ2BmOUVBq18SBMZaTr7+qucfnzYzVsTdWMS9GhpP6cZ69l
X-Gm-Gg: ASbGncsPBNPRlE0Wio9njYLbQ/6Rrx7f0/tVaicNDVUZsIKxfvzjw2pYoaXK9mPfQPF
	kGvjvk71Xps1y3iaSou9SvCQ7Hkg8bM2LfLYJDAfQLMgw/Ag3C/XPANCAwSd1F+6WyH9u3ug/Dh
	CnJQpvb9Ns2Ru86fGkqRQ1id47GnTfGcu5k7j2Dn7L6NvCtw8g0w2IXVLMP6TOjS0KGa11jHbFV
	pjaxUQDBhFOXE9F0wOmPx5NXru59M3SOxFHzaCR+UjbtcY24lR86su7q2Jsw77AmB4+B2yoy0VF
	G95jpjtkxgoMj40yCAb/0VMw4kam4LBuobHbW3BDUkLDQMtkW8ohVxlLzEE2UZedhxPCkndW0ol
	hqL1aCYW5xwcBJUsN9aULtk6/B+qiFCLRQ13gLjKh4lBfi87c7ab86bTkoQuWWjFkBhz/kqMJ7l
	GBWpGI58qUy0C6LYQxko41H0j46bI=
X-Google-Smtp-Source: AGHT+IERaLvmsksXdm4uqqeOPDAGOjVLAPcWW+DVufQ2i3ULjffRh0sjXfMbZt3b4sdgIKb56s8bhw==
X-Received: by 2002:a17:903:2b07:b0:290:c94b:8381 with SMTP id d9443c01a7336-29b6c3db606mr396664675ad.7.1764499618952;
        Sun, 30 Nov 2025 02:46:58 -0800 (PST)
Received: from localhost.localdomain ([114.79.136.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb471c6sm91492475ad.79.2025.11.30.02.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 02:46:58 -0800 (PST)
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
Subject: [PATCH] fs: ocfs2: fix kernel BUG in ocfs2_find_victim_chain
Date: Sun, 30 Nov 2025 16:16:37 +0530
Message-Id: <20251130104637.264258-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a kernel BUG in ocfs2_find_victim_chain() because the
`cl_next_free_rec` field of the allocation chain list is 0, triggring the
BUG_ON(!cl->cl_next_free_rec) condition and panicking the kernel.

To fix this, `cl_next_free_rec` is checked inside the caller of
ocfs2_find_victim_chain() i.e. ocfs2_claim_suballoc_bits() and if it is
equal to 0, ocfs2_error() is called, to log the corruption and force the
filesystem into read-only mode, to prevent further damage.

Reported-by: syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=96d38c6e1655c1420a72
Tested-by: syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 fs/ocfs2/suballoc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 6ac4dcd54588..84bb2d11c2aa 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1993,6 +1993,13 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 
 	cl = (struct ocfs2_chain_list *) &fe->id2.i_chain;
 
+	if (le16_to_cpu(cl->cl_next_free_rec) == 0) {
+		status = ocfs2_error(ac->ac_inode->i_sb,
+				     "Chain allocator dinode %llu has 0 chains\n",
+				     (unsigned long long)le64_to_cpu(fe->i_blkno));
+		goto bail;
+	}
+
 	victim = ocfs2_find_victim_chain(cl);
 	ac->ac_chain = victim;
 

base-commit: 939f15e640f193616691d3bcde0089760e75b0d3
-- 
2.34.1


