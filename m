Return-Path: <stable+bounces-202695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD8CC2F65
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8637A302C46D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C98396DDF;
	Tue, 16 Dec 2025 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngymEgMG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2A2396DD8
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888803; cv=none; b=dbdpLh3V0T3VvxDajJqAwxSospKG0UeCd1gpyK/5b5UTaLmaFSsPPWD6EQyOq6JZPInAvNMahuCtdPTRH7y/Vd9YIH+CKT5jOHOYeTbMDK5vXzsZkxLPO5J9Z0L9K4nMe1ug/B+N1A/qxXQXATSRb3/RPLqeQ6QeRPe2ZKz3buQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888803; c=relaxed/simple;
	bh=+KKOTUcJ+YH7NkqkHTszL8KhwwaiCIPTpBFLvTcUgOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0wZIArOliZ5budeJr8zEkDNvf2lXsBmUQ6vWydROsqO0RmgmnD1jjRK+V0bV942LFhNUDXsgOzK/KYtEd0vinEzdW/cLqCBUNiXpqhfwLFvgzMvPpGVE1aEdrX9RVvVqae38K/vOn/5JtEftn3Ihn+/x5G/4lAJTxXoxWHKpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngymEgMG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7f1243792f2so3001484b3a.1
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 04:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765888801; x=1766493601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94bYdVB1hl8L1OqlCa3ZFNJ0l6TA3STYv+6WFJaCFaQ=;
        b=ngymEgMGUXf8VFfGtKqE0oJ9/icinP0cUg8Cka/eCsnHtIyIb8M0xFJeUxsUl2tPGt
         TJJkC3CK/LCh0oY26u/QVyZfMZBnv2NNGBmRhsIODCWNsBMXnIwT9FD/JPxhBqRUp/n5
         u20KXtI0yZclqtVZVnp9B4yxtwM4foFhTWUvGH+tAFzsYtFEZcW8qHI9xpBfahLOrKpj
         PFXKJaDPEUfLRO24bDfZvAQMAesn2kuiTxJIovpGDetEmTJr5n8QErmk5fbchdTY4oXn
         ME12PpsUSc7HYQ4UnD/u211zCMM9yM5F4VD1xr3XkeWfhAn0sceGWZkyyG2ErKsvJk5W
         d00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765888801; x=1766493601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94bYdVB1hl8L1OqlCa3ZFNJ0l6TA3STYv+6WFJaCFaQ=;
        b=XhMxypKyRFpRSNHtVZmnuqH891GXJJTfPGUhQ270jRt/MjVR0YPwqnom/mJU6aaYRp
         1MX6gtuurSCIrrdkm/Nk+OhtzQibQHTL04bVgqvw3ZyodGWMpyhk+2O31Tn2ha+qSewi
         /Wl5Vcg+fJzVaIGSaLv95a6mkQx/7/REMXLkDTibTNhviOnXgdgNTDcctchcfj7WOyOg
         zm6prTlWHhQ56H2iF3LbuR5iMaD+BADqn4GCNri032+idEDA9myTLKB1LK/L1vT3AV7l
         PMpGBWn1b8vMMf8zi7/SUcqTlj0AS8PgjDO4hsg/OrC2VcDkH8mJnMbF1XyEKimORosJ
         o4Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWGo/iM6xy7HssJXAjzO7bsuMLNdf7SW4qHRvmHxcw6laLdq79gicn2srjvcEscfCJwhV14YGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxabA7k+G+Iqlx6iG7EqFR1aAp9jcWdoSkx4gub/rOvCayCeeBP
	yfHcLpDbccYoTckdXv2mEjL+MUTZVWMRBPlRcqj8n6Sj/mHlWJRTTEho
X-Gm-Gg: AY/fxX5J+O3ldSu+usHZLRrV/LfLFEMnSgNf1EXodbv7aIw7GFo4q8hR6IPqGeybGIv
	Do5fp/opN9qZDCPqFPzsf470bEgjtTH5o3eGfQhH8nnEKNxXMgNXUI7d7gKlby3v+1gXfYZEzm9
	NoY2bhdqJINDsA3B2In1wzbMEr7TVbt3I7bcjvSsPJrcyfoMsh4ifDJE5AuaXjd/aQyHzXgNJfh
	olEo03vkZDhSdL4kI7Z3YU7IpWgbJAw4M9J8GfFec8mrrmva0//8iKALiO1QaBk/mVU7+GPvk4y
	Y7Duex1b/Tm03NQL+SwcAB9Sl+69p/HwyXbNPT3K9BlwWwtrp1oUzgpT4tzuXljv2rrAiZ8ynnu
	zEuATuDjjQp3U4qH0ZSPKK0Mg30KDCi61C20iGQ9CSpI5LCi9iC/zkFbC563Fw4L1QznLg0/jLT
	uXY/o=
X-Google-Smtp-Source: AGHT+IF2IMiXqfEiWIV2msJLDxtZPgeGJVbFcrhWZcSK5A/1IMenk/OHRFWQx4TyjXRPNLfoHntUCw==
X-Received: by 2002:aa7:8806:0:b0:7f7:5c07:a867 with SMTP id d2e1a72fcca58-7f75c07a973mr7978914b3a.21.1765888801480;
        Tue, 16 Dec 2025 04:40:01 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4aa91d0sm15366895b3a.32.2025.12.16.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:40:00 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ext4: xattr: fix wrong search.here in clone_block
Date: Tue, 16 Dec 2025 20:39:38 +0800
Message-ID: <20251216123945.391988-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a KASAN out-of-bounds Read in ext4_xattr_set_entry()[1].

When xattr_find_entry() returns -ENODATA, search.here still points to the
position after the last valid entry. ext4_xattr_block_set() clones the xattr
block because the original block maybe shared and must not be modified in
place.

In the clone_block, search.here is recomputed unconditionally from the old
offset, which may place it past search.first. This results in a negative
reset size and an out-of-bounds memmove() in ext4_xattr_set_entry().

Fix this by initializing search.here correctly when search.not_found is set.

#syz test

[1] https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1

Fixes: fd48e9acdf2 (ext4: Unindent codeblock in ext4_xattr_block_set)
Cc: stable@vger.kernel.org
Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 fs/ext4/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 2e02efbddaac..cc30abeb7f30 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1980,7 +1980,10 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			goto cleanup;
 		s->first = ENTRY(header(s->base)+1);
 		header(s->base)->h_refcount = cpu_to_le32(1);
-		s->here = ENTRY(s->base + offset);
+		if (s->not_found)
+			s->here = s->first;
+		else
+			s->here = ENTRY(s->base + offset);
 		s->end = s->base + bs->bh->b_size;
 
 		/*
-- 
2.43.0


