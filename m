Return-Path: <stable+bounces-116336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9455CA3502A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 22:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470F816BDDF
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019C8269836;
	Thu, 13 Feb 2025 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/5JdAUG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB465266B74;
	Thu, 13 Feb 2025 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480802; cv=none; b=aabK6U/1+tWbdLhZkTIXLShurzndj3owq22NuVo+lsc1pdvjTL8K5soRb8gNtXZ4d6aOCkzoPspgWY4szb5AxwKktBftzYTO0TacaMlcdbg4+/pIm+iX5KX1WpjVmerYN8nPCvpdHdoU8xDgFuPAbsYGpqXC9YYv4VsyMKl51iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480802; c=relaxed/simple;
	bh=hK2r8d4CW/cwvDuuMbpTukJ/vvFf/JZqXrC75rIGDrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdQCd9i8utX4ugpuMh5prMj1rgXn1TH9vr7vd8b880mR+6UiNsJ6meAfb/WjsHAdIiVK3Lt6OYnqYEwcYqvxN71S9x9GjUw8AimT879j8rdysmDpeEo/RhTyDPvBX99xyZpjmgyKH4vAvEkmLcNq4StH1mddJx0YzPUG917oHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/5JdAUG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43967004304so1170285e9.2;
        Thu, 13 Feb 2025 13:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739480799; x=1740085599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4SxlfpmEUW0FnLcr8a0midof5G/rcbn5Skbhr1r78A=;
        b=B/5JdAUGfkj2nE1Qgku47w9uD/qT9GLVN7NwYF9AoTNNUPrbDgIHr3XK6DllhwFP3t
         77DcwyhpUcdJjA4ojt7mCMXzV+ywmi+/rl9aTHNJebaPBAyuIQvJIN1f6Vm77YfSLw0J
         nlfyngTcSseOHn5JnC7pCaZ57DoZR5d13xgedE/R6uEEwCCnW8+iQmVhrAABYUItH0BT
         RirAlJ//dRN9b/vonOwNsjp0eC2976Z5ogXsDE2H5ip7CKsiBKQt20AZm1bX+85LD3WX
         iMyA8vPewikZha09vypTVsmIq9xi3fh1sYGW/iYwir97iLMr2HNAB6BbeAGKG/VM4w5w
         Tn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480799; x=1740085599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4SxlfpmEUW0FnLcr8a0midof5G/rcbn5Skbhr1r78A=;
        b=FhN14Y9GSlMWlOzrZt2hOhqSYbcv5x6BT4W4u106R2nPRacKlHTLsOVoAq8RF5t51b
         cR43SxwlDlPEQW+CIjJMT/ORFJtPt8QYcC9rY0OZOgWyEtn4EjIaWlfVZy8OpqpN2nMs
         /L3hjaUGlN0y1pNlhYA0yDjSoG58HJYYouyZNjcmtHAJKgrVKVYkw+X8Su2GaM0+6FBm
         tDkek0DO+hkAltJISzeHycUG2p9GGWJ503ekGnndsDQNP7nS75n3Mzhxh0PZhWJOoRgg
         +JLaF1XSFhhRH5WJzxk6OtVgY4v0J1fP7oMcT/XI0zSvcsHUchX810BcZ3HO5yRYG7bC
         ytVA==
X-Forwarded-Encrypted: i=1; AJvYcCUCfBtVxYLNiWdvJwsaVPiSbvh6DhXToSaNw5pZ1Fj/i+1zf6C0H/TlNHUqPiuAp/O/J2aPlGZl@vger.kernel.org, AJvYcCV0LzE8KOURAz2mYfsuzKoRYkfetj/l59MKrLzCV4vaQ8J4a9O2vkQx9HDP+XtoTjFrtNseeihfmJp/GVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRNjgl0znenGxfhX4Gl1CNZgEpP7WTWBAI7gYRc0z7yDe0Z4qf
	8x/VXLcCuFlrKiknvTjYyM7GwIyXPJCw6alBHOqBoeJlqSAKiTUj
X-Gm-Gg: ASbGncvx0m7k2gUi8nR54yw7DAdyZvwxhRtDDz9NO+/t0zWR/GMIgIx3Ppol9G8ux3g
	k9lgMb5b+Do17jExqeBtk2ItjURqoV+yLBzeoAJRvFhbozp02fC505vzsZdnr+oDlwOtjiqaAKk
	1BfDyJ/9hqa2nVeT8VG4DOYKEMBwimph7XIzfHtISm/0eMSnlXPEjcBS8OZv6C0Vi5zmRxZ+ElA
	ciQhO5gV6L+fqjHWjTtPywQxPH3DuudFXOyNFBbGNZOl6PFub4JpYC2AoONN0lh23aF/fvqzlHB
	SfaXC4KlOxGQwkvr
X-Google-Smtp-Source: AGHT+IF7u7hR4wJ9MUECIOlUfhxo/vYJ/M4oO5lTySXwILQOrrh7aVaRI3hMredeSbdzBUL62uyBnw==
X-Received: by 2002:a05:600c:1d88:b0:439:574c:bf77 with SMTP id 5b1f17b1804b1-439601799b2mr65697825e9.8.1739480798965;
        Thu, 13 Feb 2025 13:06:38 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:594f:c4b7:a2b1:c822])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee48sm59038735e9.3.2025.02.13.13.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:06:37 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: shaggy@kernel.org,
	zhaomengmeng@kylinos.cn,
	llfamsec@gmail.com,
	gregkh@linuxfoundation.org,
	ancowi69@gmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] jfs: fix slab-out-of-bounds read in ea_get()
Date: Thu, 13 Feb 2025 21:05:53 +0000
Message-Id: <20250213210553.28613-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the "size_check" label in ea_get(), the code checks if the extended 
attribute list (xattr) size matches ea_size. If not, it logs 
"ea_get: invalid extended attribute" and calls print_hex_dump().

Here, EALIST_SIZE(ea_buf->xattr) returns 4110417968, which exceeds 
INT_MAX (2,147,483,647). Then ea_size is clamped:

	int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));

Although clamp_t aims to bound ea_size between 0 and 4110417968, the upper 
limit is treated as an int, causing an overflow above 2^31 - 1. This leads 
"size" to wrap around and become negative (-184549328).

The "size" is then passed to print_hex_dump() (called "len" in 
print_hex_dump()), it is passed as type size_t (an unsigned 
type), this is then stored inside a variable called 
"int remaining", which is then assigned to "int linelen" which 
is then passed to hex_dump_to_buffer(). In print_hex_dump() 
the for loop, iterates through 0 to len-1, where len is 
18446744073525002176, calling hex_dump_to_buffer() 
on each iteration:

	for (i = 0; i < len; i += rowsize) {
		linelen = min(remaining, rowsize);
		remaining -= rowsize;

		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
				   linebuf, sizeof(linebuf), ascii);
	
		...
	}
	
The expected stopping condition (i < len) is effectively broken 
since len is corrupted and very large. This eventually leads to 
the "ptr+i" being passed to hex_dump_to_buffer() to get closer 
to the end of the actual bounds of "ptr", eventually an out of 
bounds access is done in hex_dump_to_buffer() in the following 
for loop:

	for (j = 0; j < len; j++) {
			if (linebuflen < lx + 2)
				goto overflow2;
			ch = ptr[j];
		...
	}

To fix this we should validate "EALIST_SIZE(ea_buf->xattr)" 
before it is utilised.

Reported-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=4e6e7e4279d046613bc5
Fixes: d9f9d96136cb ("jfs: xattr: check invalid xattr size more strictly")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 v2:
- Added Cc stable tag

 fs/jfs/xattr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 24afbae87225..7575c51cce9b 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -559,11 +555,16 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 
       size_check:
 	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
-		int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
-
-		printk(KERN_ERR "ea_get: invalid extended attribute\n");
-		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ea_buf->xattr, size, 1);
+		if (unlikely(EALIST_SIZE(ea_buf->xattr) > INT_MAX)) {
+			printk(KERN_ERR "ea_get: extended attribute size too large: %u > INT_MAX\n",
+			       EALIST_SIZE(ea_buf->xattr));
+		} else {
+			int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
+
+			printk(KERN_ERR "ea_get: invalid extended attribute\n");
+			print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
+				       ea_buf->xattr, size, 1);
+		}
 		ea_release(inode, ea_buf);
 		rc = -EIO;
 		goto clean_up;
-- 
2.39.5


