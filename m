Return-Path: <stable+bounces-189273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323FDC08FF3
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 14:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F553A4605
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881D2135D7;
	Sat, 25 Oct 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L98mhKpa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55493366
	for <stable@vger.kernel.org>; Sat, 25 Oct 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761393910; cv=none; b=Dt/yHhVuhc2lvp/aby/azIagq6UknWa7p47Vb7IawiCR2cxgAzwGV/AEmiw7o5KN9Z6o5eNspPNW16ugLs9JMYeUDBEWofPK5302yn9ZIIHoGPb4SKBNO/0ZC++sjHj6Bl8EY0JiIE7qrMT4H2hggaAys9pFr/mif1FajTbgNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761393910; c=relaxed/simple;
	bh=RqyLr/KFP6kVHxuT8uv8+KaJmrBYAr/DIIDr7cYq7eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cu68KJuBbxYsXokgQacKomKnb2WtP4LRd2aXjRU9aLvIdiJdcmWdMCrdlNcYo50YZadMEtpdh/I0F4C5YswbTvTw3fnjJh3yCr3g8i1sk00gLJKq4vLNIgM/6o9Mm8cDbg/Tev33vxRqpJl662uAMvJXUKfMGZI9/yYHKlGg67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L98mhKpa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27c369f898fso48003885ad.3
        for <stable@vger.kernel.org>; Sat, 25 Oct 2025 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761393908; x=1761998708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPoytxf9KSpw9USlqlPwbyYT9B/FM2gOwtvnsmod8wc=;
        b=L98mhKpaxkV56QwTM46XpSk7lQIJ/pBhQfQoJ5V1s6FhOdRITNR8mcbWamOV4BQbF0
         SVn+NQhkrg/LdPTKmHeZ16L54g5x35qgPvRoTfHccJwzJx/v8kDRYp9hCTZzjNFsFkVq
         nvuwiOEVu/uT9lsArBx+eI7iJpc7TsXVG10YpGxjAbIR3B2en4AAZp70nTTOLciaXqhS
         ELPJgrDgkqgOb53XgQmrqv3APdSI0OGEebcfBqfAH+rpmGC1+P23eSqGn3d3Ih4DueS+
         FWBUnEvB7JekvuMgb7FIP96Du8Nr7YBXAbo5gdmfqyIpjnArxaCo9gia0/iWDIqU9cSa
         qNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761393908; x=1761998708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPoytxf9KSpw9USlqlPwbyYT9B/FM2gOwtvnsmod8wc=;
        b=HU1/F/iinnRTJu0ewG15Wow4dD2A1uZdQpf9dG3s2UVt309rDPRkEWiKKNrPYdEw+0
         AuGFMhFFwKv6LBS6Vt6o7Wd93AdAUblvqD9Iht0WHGN+3VtSE6opLCTj1lzOGwZDJ2VR
         pdGyNGkBUEO3+2QqWCwMnLGzCw/mWhy/u6BUTFoqf46aGWcpHVX2Hv4UOZB8h4O0TrYv
         WKXOXXzfQeeMGSm2sDBreWvIX+aUoRfDkjX8FXpjTlgP8r+c2VcTRkG9XtcHp7QGtQ39
         7v8bZKqQIkb1jg30EKak5A04CanZEs3Syvp6WRRHzJ12XPqMNTy2QJt7u5lhwqTm/myZ
         GVLw==
X-Forwarded-Encrypted: i=1; AJvYcCXNSTuMNqvpzVUJXEhzJlsAyKWuGW/UbBTQEhP/NMHaJQtD1tHvX7JthO+NIkxbomf+SWrSxzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQJd78TS5VPJvEg4DXgCcMc9NsbByfjCvjs56orRMrtEkmMYF
	IBc87NFxI3YocMicedlrZR+SbBBhH+dyqUe2gFiJpp9ZmLb2JtUDPEQm
X-Gm-Gg: ASbGnctIyYJLIHA8oRTgkxmeKBgHdpw3dLpaOgbfSOsHchbh6HyvLMYajRUqj3qTlzE
	IM/Cb+DeNZgbx00uuAmNgMdQ2pxTIzwYi1veqL/O+lPQavXmXxzOdSPWm+B5cfPSZdsAe+QIwqf
	zx0ihAfibr7O0FdGGkGvfV75NVQisxmt7lrH0XQqQoZQ+XbOf11bfNQnWqmM1EWSW9JzdKn+cui
	IC9Yp/nPL0GWsHPZSRHZtm+JP+lYAvik1NVgxXbOAf9te9yuQAdCQc7KsjbMU/JjLnBc/xpqRA1
	Z7vwg5iqjBwVtkC73FqwYWR3OD/zRYFKiQH3W1n5SHX4Py4r3oLpncfiJUXwQO3OkMMkcUSkHle
	BxHrnrFo5wvR/TD08hzx6pWdmK2glaD2Vb1lVdhNjO2an3kQ3vmFDZCI8y+WB68/rb5fKn5LPrE
	XYiv3JlmbQkA==
X-Google-Smtp-Source: AGHT+IENHghZmAfoOLVQx3IvoJEGkCtm9ehcXpV3CexqECxrjj1hj7ylp/61RR7XbH9zkL6BI8FUWg==
X-Received: by 2002:a17:903:1746:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-290cb07d430mr374033525ad.46.1761393908432;
        Sat, 25 Oct 2025 05:05:08 -0700 (PDT)
Received: from Shardul.. ([223.185.39.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d099b6sm21480655ad.33.2025.10.25.05.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 05:05:07 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	shardulsb08@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 fs/btrfs v2] btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation
Date: Sat, 25 Oct 2025 17:35:00 +0530
Message-Id: <20251025120500.3092125-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025092951.2866847-1-shardulsb08@gmail.com>
References: <20251025092951.2866847-1-shardulsb08@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When btrfs_add_qgroup_relation() is called with invalid qgroup levels
(src >= dst), the function returns -EINVAL directly without freeing the
preallocated qgroup_list structure passed by the caller. This causes a
memory leak because the caller unconditionally sets the pointer to NULL
after the call, preventing any cleanup.

The issue occurs because the level validation check happens before the
mutex is acquired and before any error handling path that would free
the prealloc pointer. On this early return, the cleanup code at the
'out' label (which includes kfree(prealloc)) is never reached.

In btrfs_ioctl_qgroup_assign(), the code pattern is:

    prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
    ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
    prealloc = NULL;  // Always set to NULL regardless of return value
    ...
    kfree(prealloc);  // This becomes kfree(NULL), does nothing

When the level check fails, 'prealloc' is never freed by either the
callee or the caller, resulting in a 64-byte memory leak per failed
operation. This can be triggered repeatedly by an unprivileged user
with access to a writable btrfs mount, potentially exhausting kernel
memory.

Fix this by freeing prealloc before the early return, ensuring prealloc
is always freed on all error paths.

Fixes: 8465ecec9611 ("btrfs: Check qgroup level in kernel qgroup assign.")
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---

v2:
 - Free prealloc directly before returning -EINVAL (no mutex held),
   per review from Qu Wenruo.
 - Drop goto-based cleanup.

 fs/btrfs/qgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1175b8192cd7..31ad8580322a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1539,8 +1539,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst
 	ASSERT(prealloc);
 
 	/* Check the level of src and dst first */
-	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
+	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst)) {
+		kfree(prealloc);
 		return -EINVAL;
+	}
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-- 
2.34.1


