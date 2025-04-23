Return-Path: <stable+bounces-135284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64805A98AE4
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF1C162537
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C514EC60;
	Wed, 23 Apr 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iu4GVOzd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554D1714B4
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414582; cv=none; b=bY7BZRPyfrPGiWaFvaaMe3iSBQLtM30zrM61Mx0w/pwqh4pWaIq1JYgaTq5nWpNVyDYlR+QSJ1zbo3nmzhvS8USGja42jr/QslSfe1u4tjJ4xV7TKXVS4Xvgga/TGxd1AUnLXof4YelHuE6Pc/thdKeTJiPLBKyK8J/L83FJmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414582; c=relaxed/simple;
	bh=yGMSVv9f4+/4b3cn0zZNoJ4i27It+95C4eOcXL1wdAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDMoSg03K6cA/LyFxLyYGWo5E8iUbM7vl8o8hqQOd0ZBAnSGROeGtXV8HiaG/VSrC3NNb/wsk41XDK3n/pBdzWM4XzRcoOg8LQ9pNGdTvkixS3FDu1IGHnkuDDODvxDec3/bmJnJOmuQizm2b1oCCoHbttA/4BFE92WYnInKpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iu4GVOzd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe574976so47813145e9.1
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745414578; x=1746019378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKMjh80pkF0U1r9Ws45Yco9sh0xx3u5MhQd3yiBsdSA=;
        b=iu4GVOzdGdvIbkMoSUvuhlzhXz9vyGHeztUkkvHfi9avJq426ILdaRtLltID3d0zWp
         la8GZ7n80hgTegYWxVoRWvJRsm6TThFJSxqyivyUp5w8nsnymgfLQtjEWEexVu35rtyc
         kbNUlI/SPWT2M4vCaave98TXhR8OYSOHpWX/T4D7ySjwOqirrW8bjgpMDfYI0W9rJ/zn
         ncBfu0H8/mjUeOZe5c8eduTav0qDU2bSugzAyHqBNEoYcZ3IZJqS+1/aDjscCKq5kFVo
         hkr+c7aRqPAO5VaJ428e29Id9rq3SQgj6CNn+mViTYGpUl0wUqaV5WQ4/vaWIYzODNOr
         AjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745414578; x=1746019378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKMjh80pkF0U1r9Ws45Yco9sh0xx3u5MhQd3yiBsdSA=;
        b=rYvL1Tb4xEm84a/FHCKdyZRAiTpxztHTHjE4uPLCgPN/ZheQbkEFYcS2kbfwk3UsCT
         35HfCy4sNtMWr4T4VrM/CcJgLV+G6j1aiqez6PBCZBecSMPI9I1PeIa3mj+KNfr5Oj8g
         19JUb3lj8yVuLKAn46kDAgTFlEFEJIl2MI44mBfOcRUmO1w8TziJq73UMkqepJ2AFhO/
         +UGfcOQ/9BVDW3ShDPQFaRo3UR0DV1qWpUnINb5Bg2/MTBTOl9ETi84GliDgXc3lD6KQ
         QchVHyDg412N7SHFsmGSFfl2Sk9Xpq4gieRa8eGI7NzRE6RIpXlI5vJkpTzbuBHFIWIK
         i36A==
X-Forwarded-Encrypted: i=1; AJvYcCVaVTTV1WD6xDJqOKfzxZDNuIHe0+BT1gA65syLFbQfKZWaJPRvta6BzWuiymKe/xlb6p08Pvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgfrHXCh+RvizJXl8QMNJRe2QoeAQVpGMuN5kyjVdke+c73S0j
	kgfMTZxADQj58lTB9+7Op6SVkDMQ5LFVXMuZRxvqc3br5LmZewILaKoHr4KBAQw=
X-Gm-Gg: ASbGnct0Cq2mAqmHdGz7ACbroXet1UyfGXGbMGogaJzl333RDZcriIbPqeb8jB+/f10
	mZjzh848tEjN9FeIlExrW0M2eEC5hxcnpHlJ+WFDcDtATBEcdvr8+B0V7AtuM7d04SU5Z2i+8rY
	iuvazoFaEuoOORgVJqELibXnN92a+UNY5UYsQYrNYJh1+vtbVOMfo1ppcrT3mrttQT1DCCpVx9W
	S27AKMIJC58fJ8QqIrLSiTMz064WYntaG+AcErjCVtABUwR/oDiRHzoZ6zOxBBhEjpUdy7Yoh0c
	JOaPZrMfPcnHEZRfD6brc3Bcvw6fhHf5iVze6G0HO3b6acmSWT84rEtwTuk4sPGHhRXTlWJbyD9
	QGWtZmBw+39sqp95rJBn2Etdw/haCbGRWbltc3rSf
X-Google-Smtp-Source: AGHT+IH3oOCJPqy8g9E1uMBWxJG33+l7Q/cJgMxL7y9T/lFqjvdA8c0HXVW/rdbAsZ8zObi1wqadtg==
X-Received: by 2002:a05:600c:3107:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-4406ac21886mr167630725e9.29.1745414577838;
        Wed, 23 Apr 2025 06:22:57 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f041700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:1700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d16dc0sm25792765e9.6.2025.04.23.06.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:22:57 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-nfs@vger.kernel.org,
	trondmy@kernel.org,
	anna@kernel.org,
	dwysocha@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/nfs/read: fix double-unlock bug in nfs_return_empty_folio()
Date: Wed, 23 Apr 2025 15:22:50 +0200
Message-ID: <20250423132250.1821518-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, when a file was read while it was being truncated by
another NFS client, the kernel could deadlock because folio_unlock()
was called twice, and the second call would XOR back the `PG_locked`
flag.

Most of the time (depending on the timing of the truncation), nobody
notices the problem because folio_unlock() gets called three times,
which flips `PG_locked` back off:

 1. vfs_read, nfs_read_folio, ... nfs_read_add_folio,
    nfs_return_empty_folio
 2. vfs_read, nfs_read_folio, ... netfs_read_collection,
    netfs_unlock_abandoned_read_pages
 3. vfs_read, ... nfs_do_read_folio, nfs_read_add_folio,
    nfs_return_empty_folio

The problem is that nfs_read_add_folio() is not supposed to unlock the
folio if fscache is enabled, and a nfs_netfs_folio_unlock() check is
missing in nfs_return_empty_folio().

Rarely this leads to a warning in netfs_read_collection():

 ------------[ cut here ]------------
 R=0000031c: folio 10 is not locked
 WARNING: CPU: 0 PID: 29 at fs/netfs/read_collect.c:133 netfs_read_collection+0x7c0/0xf00
 [...]
 Workqueue: events_unbound netfs_read_collection_worker
 RIP: 0010:netfs_read_collection+0x7c0/0xf00
 [...]
 Call Trace:
  <TASK>
  netfs_read_collection_worker+0x67/0x80
  process_one_work+0x12e/0x2c0
  worker_thread+0x295/0x3a0

Most of the time, however, processes just get stuck forever in
folio_wait_bit_common(), waiting for `PG_locked` to disappear, which
never happens because nobody is really holding the folio lock.

Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when fscache is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/nfs/read.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 81bd1b9aba17..3c1fa320b3f1 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -56,7 +56,8 @@ static int nfs_return_empty_folio(struct folio *folio)
 {
 	folio_zero_segment(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
-	folio_unlock(folio);
+	if (nfs_netfs_folio_unlock(folio))
+		folio_unlock(folio);
 	return 0;
 }
 
-- 
2.47.2


