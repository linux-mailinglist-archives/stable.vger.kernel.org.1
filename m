Return-Path: <stable+bounces-215632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O69OnoAi2nJPAAAu9opvQ
	(envelope-from <stable+bounces-215632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:55:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2149D11933B
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 508BC3055106
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735F634214A;
	Tue, 10 Feb 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1Jrfkg4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27C342519
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717047; cv=none; b=j7MbeZpyR5Ww+oBzF0G7t5w49LF33pqfjbTqc2cJ0z5Ysth/NZ7hAvXZrxOuK6ScG8kvOcEQw9oHi9cT3eZeKgKHQ4XowWWXZ0YPKC/l1s9GoFmHJ56iD80/FG2j7/UnOpVZVEIPWtGt7TSLUATnc96JAX3J931Ah080J+QnJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717047; c=relaxed/simple;
	bh=FzUa2h0cznjZCgel5VHCjhSB3pMwOsaKbhc6w65ivdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbCXJnWLvS6ccl/60VQ8gzQGhyET43tz4VCAon7FZYehWZDgkLWbSJwwzo/o8vxiixTc4NyjBPS1OLPy/nBvd2xIzwyWvgkz3L32VFg5HY7HrTSdGw3iiJ68EHgfOaPuswF/PuQY6e2GIFu7Ziv4P4LVXlpn7H0ODXlYogQcT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1Jrfkg4; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6582e8831aeso989313a12.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 01:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770717044; x=1771321844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mZEeVQ0QwOznaKfyu8Y0DuL81Ja7HibPoeTh6Jnlyo=;
        b=i1Jrfkg4zn9F0b5KeocofCLUfX3V2Uiriu3V7iWXEEUuRMVsY2LyyOpeDrp5QPNOPd
         ulwSubrv4mw3rJOLy61uWuIDi5SDITZJPpfz2fxVUbsQTBTJAKZP+zy/IesjxPnKirU5
         dV7osavq2e86clkZ36F+P3x8kSYfUfb84A+Sy87nCM9l82qOG2JucpbVckKk+zg5ZFjz
         fc5C1G8mPvmlbVC7HJWNWhnbQQm3yvZ2HlP/83hOo3kTvipJO3TSzu6WuSFngxNlSiy2
         HAAHg6XjN/4/sIaJpptYl1ARw/D7Hz7s24AV+hNPsIaQARiV+ILcIWEt9y+GazuQ8ci/
         2pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770717044; x=1771321844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mZEeVQ0QwOznaKfyu8Y0DuL81Ja7HibPoeTh6Jnlyo=;
        b=HqPky+pS1yIjjdxnjaRACN88IK49sTL6pzM7urT0ogLnIwQ9oPVvaO1I+RtZWg/aZa
         gg0fYhxAVhEjf2LrcayKbcyg3otRWcQJf7N0SaQULeP6scz0lsg6Hf0a3FMPw8hlNnXm
         XYxLhU6heGrZu9izMiMJhdw/oGVLNlYtUj0C9S5BH+bFIktJ4ECFLjEmLmqKoshalNiS
         cqv+F3xWm93LrYrRYHIJGJfNLDiU5lklplqZfwrgKVNa7O41VOR5kYL3grr1Q5wBwcbh
         A+dPq9gbZY5zozBAqAeHk4JUcYDKewhSaShkOIiquf49rNNjm/VWQV59l0/3dXeWWoAo
         6zAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU90nit3w09A1AkPOuFP7Kk2KConmT/2LeFKxFDvcwA6MEjgeYPdh295CRHRkUQFJ4QdEuhFIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykFfDO0KbDKOhWXF6Exsjcfom2LScBs5BU+f9vFAAT5wxDAH3u
	Aw/nRCiAlWoKZ497SHDEI3cu6H52D8N7UNpV7n4hMSnC44It4RnKY9Jx
X-Gm-Gg: AZuq6aKggOjQ9C88Sy9WADYyV3puHl7oKQzQr5UIAFqo6Shvn1NkilmvN2l/ZGCon0P
	lqSMweTYG5U0aFSRwzsOw2Ux6O5H0TqtlxDPPHemSjTCeKhQPk7++X9OWdhlWLNHMRfqD/VvtWi
	AQd9hE1U8S0vcqknS37SrqIlf/WTFXA172R4C8TR+V21n+tkMMOCAVSNakQpbE5Sr6aKK32VZ8r
	RNkHEvhpjGfa+88qYYzMWetkc5pGl6kwf8/HZ6iOAnwF+Pt2ICzxc4JhHaxQqkZEdhrisR4QFxt
	96skJQzvVCvJ+GohBUVGAGDjWRNBHrMjSNCf1cigwxXHSTKM3HtbTsVf9YMLZCQOZIxtyEr4D+8
	LSEE7D7zYnGwudVjVTFb+GVMPntCj4mCZt5AlpwhbxzldCnxHyunPYbstWaMLxluXnAGV2lWQyj
	vzefBWokBBfbbuAWWN2N/IU9T91XGOFWxxSWLFf/oA3PvzeUN2zHnEMY73rBmEV2LMaYsuQ9CYz
	xHKA+ptOGahasHNSless78HBg==
X-Received: by 2002:a05:6402:13c1:b0:659:3ff1:58fa with SMTP id 4fb4d7f45d1cf-659843bdc44mr6047224a12.29.1770717043948;
        Tue, 10 Feb 2026 01:50:43 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-0695-e133-2257-07cf.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:695:e133:2257:7cf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65983eaa593sm3602304a12.2.2026.02.10.01.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:50:43 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com,
	Andrey Albershteyn <aalbersh@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] fs: set fsx_valid hint in file_getattr() syscall
Date: Tue, 10 Feb 2026 10:50:42 +0100
Message-ID: <20260210095042.506707-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215632-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,fa79520cb6cf363d660d];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2149D11933B
X-Rspamd-Action: no action

The vfs_fileattr_get() API is a unification of the two legacy ioctls
FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR.

The legacy ioctls set a hint flag, either flags_valid or fsx_valid,
which overlayfs and fuse may use to convert back to one of the two
legacy ioctls.

The new file_getattr() syscall is a modern version of the ioctl
FS_IOC_FSGETXATTR, but it does not set the fsx_valid hint leading to
uninit-value KMSAN warning in ovl_fileattr_get() as is also expected
to happen in fuse_fileattr_get().

Reported-by: syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/698ad8b7.050a0220.3b3015.008b.GAE@google.com/
Fixes: be7efb2d20d67 ("fs: introduce file_getattr and file_setattr syscalls")
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 53b356dd8c33a..910c346d81bcd 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -379,7 +379,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	struct filename *name __free(putname) = NULL;
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = { .fsx_valid = true }; /* hint only */
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
-- 
2.52.0


