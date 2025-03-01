Return-Path: <stable+bounces-120009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBD8A4AC58
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 15:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540F97A751C
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5294E1E1A08;
	Sat,  1 Mar 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXAd3yx5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CCB1C5D7E;
	Sat,  1 Mar 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740840104; cv=none; b=qA2h4R9E/zZaHPHiAf6Lj2eJK+96eDZCd6NlIMWceMrDgxhr2gpZioeY+yjYSKXxekEKZymptk7o8fI5/dneADxvOxASanIBNfiITz0z8sKS6pJ57b9wibk3N+AAmYn6ZLMLgocclktxWX9UuGfafv1NRFn8Q4xU+lQXNKnjRzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740840104; c=relaxed/simple;
	bh=iVyKzVfxR8LdP5by3NoY8zhrOtkB7jVDbkJlfjDY8OE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i33y+QhGTXfY+eBFUMVdcDqKH90N6ZvAnsxa7pY/0n0pQTNi74Rivh3Bsft9g1TgAuJumlUfif01CMu5UVjRVpEYQSthqTltJ9E3WE1ekV6Wb0osQyK1hi3BSsngAdX9G4c4DalRRtlQ4vn3HR4bp2JQmWl3SOKWBa00EHSIrQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXAd3yx5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4399d14334aso28178315e9.0;
        Sat, 01 Mar 2025 06:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740840101; x=1741444901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCZ2IYJ2ToIg9/KMdOINj9YW27Hjn4u6ydCp4dWPNz0=;
        b=cXAd3yx5//5slt2qnIcdo/Rurc/kPrddZ8Irwo8c+AJk3fSviyxjQABZ8ha9wlyg6T
         XINrSdt2pV+fl2TFmO0RsjpkEibXbLKfugMJJFXGM0ENVhHUMhrSOmnyH7RoyGKI3KF2
         6p6uOsHM7KAdR7Igsc22AvBpqb+/gnFCwNt1pBV2OqMlXLzkJFSxgT3SZBbCkN5cOjQd
         Yp5pLRrg4v8y7SNAZBofyOwm376hSDTjTYXO4ALK9N0Mb+GpYSdTi9iLaKx5cZX9Nw5v
         45wPHD0rUCvf61koT5Yg7TwRJRlkkA79o4oRXx3cijkX+Z9TaZPIZv/BdpiuqOVyERy4
         nt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740840101; x=1741444901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCZ2IYJ2ToIg9/KMdOINj9YW27Hjn4u6ydCp4dWPNz0=;
        b=JyCPPa58qu8bHmPJEJPVqyVhrZ6neE+VnFRbyBweebi9D/+meTtyYjSmVx8vIemt2y
         vdvpV7kkczXgDyCAfb/0WRRdCIAtUZI7s02oy4pa7+gThMHjSFGn5iCxsjjrcSaJYghH
         6iOXL/xsTAs/wRJVfhss78nv1PP8GSCEIwK5c4aLj+Hu26dizbR1wZNWO5hiiyl57oAc
         tEW95hItHJBIGVXroCCKVRkhcKRx7OMGG4oh7fITGRlMC3Nhhl/KCG8cjaxeWzJWgV8w
         j3CXu5BpO9xjVGUlK85HmXbx6Vagd4qm68jPhISReaBukVVEFzF1aBP+90cSQPYZmYY9
         yfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK6tesC6edEXUDEEBW+F/aAkJCeHUvvVrUIHnQcWGRD8YAvPfED21S/XFJdnL8O8pem2mQYCX5Y6l44Bg=@vger.kernel.org, AJvYcCWvjbgxJ3T27gJ1Jp5Awhy2jhpWtBlBkfKTahnYv9sDeCOhh3FTw0SHz3lyR/pRpMYV89/8Nw3k@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6YnLLf0Xj74THDVBk6GZF4QXniq88r4evqCQwDt2dFJ513Vny
	8ZRtLlIomQavNDNhFh3tKX63jZIc2HaS9qiZbnRR7XidW90LFh0Q
X-Gm-Gg: ASbGncv/nZqqXOv9WyIFzo6d2XRZm6FOk1xquCMNrPu4E80x6IPqOcZ+e6cwpp+b6q1
	UiTCL2SJTj+iozM628lBPcZZ3DA8X+6W4niTmWz+ctdJlovXIIXC2QBCYOiDhbdiCwUQMyRfaEf
	y1g9T1AehmGviwZWtkZDAR0meRKHYTUw34+Q/PDeylN9p+WKSxC1ml3bIaYO7GK6iWosKqTvMc1
	zDWsMS+mCHN3rEwpWmWTwJulbb5v0jHKK9MZ/577gm3JGfF7KpHlipR6htXiPHuJtZwFb8uTxs5
	5xnpeK72wTowe3A9kzhbG5ZH9AN5Lbm10/frNtCDfZ7Jh75loBRFqJBVTqg=
X-Google-Smtp-Source: AGHT+IE7BqfWKIc6fP9w4TydXM/STuAZnBVGkxNgCzpMCvHzilFb+OhHXakcpD6IR5NJpQlPSJwzCA==
X-Received: by 2002:a5d:6da3:0:b0:38d:d666:5448 with SMTP id ffacd0b85a97d-390eca52d9bmr7180064f8f.40.1740840100500;
        Sat, 01 Mar 2025 06:41:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:913b:dad9:fe38:d4f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a22sm8572051f8f.74.2025.03.01.06.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:41:39 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+e41e83af7a07a4df8051@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: Validate chain list bits per cluster to prevent div-by-zero
Date: Sat,  1 Mar 2025 14:40:37 +0000
Message-Id: <20250301144037.45920-1-qasdev00@gmail.com>
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


