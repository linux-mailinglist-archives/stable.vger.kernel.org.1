Return-Path: <stable+bounces-106775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A95A01E30
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 04:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E18E1883622
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 03:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8927619067A;
	Mon,  6 Jan 2025 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cw3mFBp+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088161D5CF4
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736134318; cv=none; b=ISXoPOUs//S79cyrELhfq4GoLVe1BwMltqufiI9LjQ/ixpu90iMZnxPLQ8uvTFpiJqPASFWqUfJoTVHy5yomgDqwTBn98GHxmhF9/pyL5mWJNSEr3w/uyKhPOHyunrcuTBMZYwPaie230KrP/+8iZdjssI+T0QOie3D8qvnE0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736134318; c=relaxed/simple;
	bh=TjsGZu1BkZh8/ajVsU6A9ih+QvR83X2ElBnNxJt0u5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jt55gsuN0GDc3Y3wsN9DQuw6EyoApLdwKgClYC9vGbQNx6Tx+f4kEURtSvBSQSf2oAtbJd3enQ985Aiy8kwptDvlwPOahNs9auThEivqSosqAqzcHBKBwbj2F0hBHkHt3FkWObDo4GWJbYMEv92dadYkVPtQO1K8Jtr1ShYBWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cw3mFBp+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21628b3fe7dso191753725ad.3
        for <stable@vger.kernel.org>; Sun, 05 Jan 2025 19:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736134304; x=1736739104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L52rvo+Xinet56DqCazfsooXe+eXMDS7wR/C1rggopk=;
        b=cw3mFBp+KqTgwsb+zVCwE2I7UlecRFuhcDMdtyWFamERj2wfBHxu0MBEkhkOLbQLOm
         QGFu7U9vxqvrT5BoztAqLeWmOWieCxvwQh7GRjjPZUqtUZMV+lQSOid1JBGIJhWdNTjX
         7VLnxM4zjnk32XCriuchaECoPZdwyG4uhRVI4eHLP4zv5yecmuNbJgXgPL7UD8cr1GLC
         LOR4bcpsiEIabW6nt0NsdiqKHqorPalMdKFVBBWABgLGEhb48Uu3xaCMf9wcauf9FzqH
         rEeHCFihIIZNcgr3RYEZiQGfXOKsrGQOewZuQLZDw09rLq/Dtz7djYoNJdDvgwhy1Hr9
         WROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736134304; x=1736739104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L52rvo+Xinet56DqCazfsooXe+eXMDS7wR/C1rggopk=;
        b=moHzJJaH4bFhMlIE0VNke5Vn3aiUUwCL6XKFpJam52U7yFLFUt7OMdgyv1xm3Ak5kS
         cZgeeYCuN+5dvbEifayAmBSB4ZTigQWPJ4nr1b4PeXkqTSIhi1KgK5H/TWNiuxe2LXwa
         emWqUJXgRYL3cjs6m3bK5mXED7VG2u1T5uD43s/bMKLJNfZ/j2sUddEXJIwiNrdHgdOB
         fwYxGElQl7lcfo/VTvSpLEY60iUjGuLJPu7HNbmzQlT75Ixi2wRv8COpogP+sNQXArcT
         DZP5yfx6mrxZUEuhhqNQsI5ZwNqD8zcmYfGbEeH0LDyC4mxqFOAXumY+mb/YPgif7gW9
         kZYw==
X-Forwarded-Encrypted: i=1; AJvYcCUvSmHbgwXTs4lg/cU9sQX651Njo9ac65V3I0xk1E07BzShqpXsHyXOtww+PQ+M8btS+Im8LXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzezjTFLKoKtAcCDGK7hj1lMwjoeCvqwas42hgLatEBpb6yG7Gc
	Mnwir5uKguVaLgcaB2LZuGkQH4YDZXE0/67OQANJnHTxpVqTYXuKxnB/bNPTnKQ=
X-Gm-Gg: ASbGncug4X0+2PtPGH7i/c8ue5kv+dq8w/mSVhuO7Fr3n6T4//fd8/BmXeUfs1SyO0w
	iRR8Szo5zhef3hNo3wwSvz3lRiSUgDip9WNDswBX5F8WZ3XZCLCoXPYxq7ohp1jo2XQBY+mQUaq
	wSmONEBTfW6JQWlucVukbNDHjCHRAl+gusIoRWzU2+StbiLq7Y0H6+sJ/aI9V0gnfieY9lkAE+H
	eo7AzzSid4FIJMRqRfyAN0MqknkdmB62tZOh3YaeBWL6Ff0Z665rrkzRxtbT1fsBju6uuWRax5S
	hmDOYWVhnRnTNQ==
X-Google-Smtp-Source: AGHT+IHTDND3pNhNoEGlfFUQ2ez1LpWF/jUmJRoSp+psOxVg/ZgzMtJNsV0Qtt4Wu/gpBrf77MNeZA==
X-Received: by 2002:a05:6a20:6f06:b0:1e1:b014:aec9 with SMTP id adf61e73a8af0-1e5e080c77fmr89285785637.29.1736134304340;
        Sun, 05 Jan 2025 19:31:44 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbb87sm30391698b3a.113.2025.01.05.19.31.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jan 2025 19:31:43 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: muchun.song@linux.dev,
	brauner@kernel.org,
	lihongbo22@huawei.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org,
	Cheung Wall <zzqq0103.hey@gmail.com>
Subject: [PATCH] hugetlb: fix NULL pointer dereference in trace_hugetlbfs_alloc_inode
Date: Mon,  6 Jan 2025 11:31:17 +0800
Message-Id: <20250106033118.4640-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hugetlb_file_setup() will pass a NULL @dir to hugetlbfs_get_inode(), so
we will access a NULL pointer for @dir. Fix it and set __entry->dr to
0 if @dir is NULL. Because ->i_ino cannot be 0 (see get_next_ino()),
there is no confusing if user sees a 0 inode number.

Fixes: 318580ad7f28 ("hugetlbfs: support tracepoint")
Cc: stable@vger.kernel.org
Reported-by: Cheung Wall <zzqq0103.hey@gmail.com>
Closes: https://lore.kernel.org/linux-mm/02858D60-43C1-4863-A84F-3C76A8AF1F15@linux.dev/T/#
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/trace/events/hugetlbfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hugetlbfs.h
index 8331c904a9ba8..59605dfaeeb43 100644
--- a/include/trace/events/hugetlbfs.h
+++ b/include/trace/events/hugetlbfs.h
@@ -23,7 +23,7 @@ TRACE_EVENT(hugetlbfs_alloc_inode,
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->ino		= inode->i_ino;
-		__entry->dir		= dir->i_ino;
+		__entry->dir		= dir ? dir->i_ino : 0;
 		__entry->mode		= mode;
 	),
 
-- 
2.20.1


