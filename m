Return-Path: <stable+bounces-197666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C57C94D8E
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 11:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF382341B2E
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 10:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C0221290;
	Sun, 30 Nov 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/8wrInE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1BF1373
	for <stable@vger.kernel.org>; Sun, 30 Nov 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764497998; cv=none; b=JKIZqvwfXIUpKKWVkFA9eSio9bCu4cRReK5HzuPUqM3iM0KMzhOFPnj0n7fzEYKUHGJ/VrqbGSsVR+vOhJ/CnW+bzsejL4EZn/7Vgu0LAqQbCxNsbN6W76bVxmBl8EnxEdaKyeUWzQvDInVuX6uPIlZEWQkl6ITxDjXqp7UFWYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764497998; c=relaxed/simple;
	bh=sdo/q3iINIFFuq/QfvXvxlYyusSMXCygxlfWxhnb15U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cz4evMkvNXHWdAtYOZo6csPhWehJHh2eqJnisdPw40gUJCqrgjhsom8oj3G45k9wVeIg60Um+6HPxu19D3TJT3ir6iSXBu5/LbnsIB0Ev4hw5v7cIxEKKRuMmXS8N7brKgbloXYn2K9quyqCfRC6BaRZgk7ey2+usZXlDYEwfQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/8wrInE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3437af8444cso3796278a91.2
        for <stable@vger.kernel.org>; Sun, 30 Nov 2025 02:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764497996; x=1765102796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BCHtTHaRWqa1Y8maKcwavQlRKugIXsy4oIUyklaeIO8=;
        b=I/8wrInE1J0WLRZJRTuzrAT3rTIwcRtXLtzdegR4hSuv7KXyGslDIV59M7r90Y3PjR
         k4VgtZeYXXX25yq2SkyfTIUJGUx8N0H5g/Xi70IDsdgJU38KCqXYAfGiiuYtG1+2BfW+
         XyPWXQj8bu84T/Qk4h1O1MahfYK7w+R8jvIgsmvckekaFV7MFXV1OlTYy5TO4NboVfRe
         Zgg2BT7obHWXCCGOUwWGQ+MFOQPZKEjlju9ArbBtxzT8Q3AytIY1z0VZP/SOccGYRmE0
         WXBvGD7QB7FlGuqwlckZCTleeu+/MZCGun7tF+J6k3oyVcu3IMvduDCoYgpdH8r3oYAZ
         5ZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764497996; x=1765102796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCHtTHaRWqa1Y8maKcwavQlRKugIXsy4oIUyklaeIO8=;
        b=Y7rbVXuB4DL+Cdg452XoJgGlWeZqs3lbafwtr5djxIYHdBkRiyQNeA37zBEhk9wNj3
         F1+wuCG9oX7qZ3ZYcEzKYnrbnKbIymLw4vD8WpP1BdURoloyz4ZdYU0od8YFFAYV6bEF
         DCljvXvNtyDjJ3kIeI9EehwkC8yoHTZUdetbX3wRwlvyntMXmQx6YQ7jYXD4jDtTznII
         mub4nOwGrGKpPt51aFsoZJoWbGVrMbj895dyLv9NKmC7x8O/P7b9Pm5Ar8viIlddv9AF
         twxUso03IwXRmJtPRrNnmR/1H+onQyQ+T6tWeqZJvr+EAivdWmBcdC0pIMBHPhuaYBr3
         nTrA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Mi4G+pkjWW1J2gCL9mafC7sz6GJKiw2ERpGmWeHN4tL2EvnC6NRd8eC0941yYSze+zw8tDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXTDQ9KCjMA4yQZ5fd17X/lcs1Tz2bLQZFulukvebCw1g5W2C
	jrsR/7g/UN4E8RGQA+1zLrUf3W0m527urwWFue3FI6fKeuvUt3RrMW2K
X-Gm-Gg: ASbGncv6Czokrj+F5Nky29SF50of1TVYpEb1R2XEr6OUO1qb7RIQ0eZa+j5BGDaqbiO
	cbomLUVvZtaMAGcjw1du4l8E+ywQD57zI1QaqFWRHdpWdsLi+drGWXKXMOi88b3ZoSzBerDBaTX
	wrI8T4JWQ71YK2ltnn+1QtyBci8YBxxorp1ZPX6vIYZIek500UgdHDDE+dHa5ZNpbkGuYcT/nEV
	bTus8PWCJ0Qt4TwYWCw77GCte6kykHAfcoS5vIYHLogkctyQUaiEheYp6CJtw97ebcvUbCphM6E
	JC271LUBYdzvYHhuF0dx8rErPLBdcGUcvb0IUxkk1PZlnJ16ItkNzZxPMWK3NNw3B+NtB6Bn6RM
	9loYu/D52uAc7F5OMQ/fU4aoiI7lwnYNIqUL+9QIZzlNq0guwzXk56TvuuOjYxxNpitGQoJPpHc
	J+yb1VAl0yTc1r+0auKC3Z3cqCK0Y=
X-Google-Smtp-Source: AGHT+IH1EFcr/pEzYbwfIXP1emSJ0HTHfFpl89uiVZKfVX7rfAaymLsZIyqt7wRNjf902i2DKAaUEg==
X-Received: by 2002:a17:90b:2b50:b0:340:ec6f:5ad0 with SMTP id 98e67ed59e1d1-34733e55257mr28829920a91.1.1764497995854;
        Sun, 30 Nov 2025 02:19:55 -0800 (PST)
Received: from localhost.localdomain ([114.79.136.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475fde79a1sm9120365a91.1.2025.11.30.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 02:19:55 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: activprithvi@gmail.com
Cc: syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] fs: ocfs2: fix kernel BUG in ocfs2_find_victim_chain
Date: Sun, 30 Nov 2025 15:49:48 +0530
Message-Id: <20251130101948.252220-1-activprithvi@gmail.com>
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
Tested-by: syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=96d38c6e1655c1420a72
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 fs/ocfs2/suballoc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 6ac4dcd54588..c7eb6efc00b4 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1993,6 +1993,13 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 
 	cl = (struct ocfs2_chain_list *) &fe->id2.i_chain;
 
+	if( le16_to_cpu(cl->cl_next_free_rec) == 0) {
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


