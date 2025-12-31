Return-Path: <stable+bounces-204310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F23CEB1FA
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 03:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1195A30321F9
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 02:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8F2E7F1C;
	Wed, 31 Dec 2025 02:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ2lS/m6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7362E6CA6
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767149730; cv=none; b=P1ot2LtX/7OjrfTzLOTxiF/TFturQ2iKSCeVlmg2yJ7gTyNaiMWNQvAA1635nMan+W45Dx2E9dJwZcYHRZbESaGUtTql+UCknZhG8WqA9307u1ohOo7R+MEb6ox14zCzmr/QYiRUZjuz/ERBn9kLhVj+SMMsC9d6pw23sJiaBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767149730; c=relaxed/simple;
	bh=w1Epuv8pplEL0CHRjiqpgO68o19GjvzKVSFTQ/iERRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhZnAYu0WuashvCZTQkr2jQjDdOVfY5BlkImtROGMFeh1W1rhg9ymFCAPu6C3i7FWM4GVxuJ79erDx71M5GTgnlapqbIzZd+kmbpSCV6LnJqjcGsYavFWhdXoQNAAMXcG1cTEsrUATqAQQVpN6x6MDX+d2gSgfs82u9cqu3DLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ2lS/m6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so7756192b3a.0
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 18:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767149728; x=1767754528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovFZ7nDpGXAGjzX1rK/nF0C1dw1vDfNt7z4qsrWCWJw=;
        b=PQ2lS/m6xVR43MYALQcEXKGkrLrqODYxOZDmTvpL1wlF9ZFreFNLoDP2EX5gRkzbE7
         wZKCqmAcc4lsYm/6HK29ud0NBE+r/17xaen+GNpPAPG5ZLhYML5iBItX1GOvkg3xMDCp
         42y9esTtVBJt0BioiBEHpHAdVXs8qw63IHUqLolL6SxdbdqcTop+7TPGGMKoJEidj4D5
         j6LnxVgOtaC/35y2/M4nVTuK+l7kqZMvFuRgi+eA/M2Z8r1z9sp6YfrfWyElE6fS679F
         OfhGiE8YNx7jrZN9E6CoPBHAJwO83xDVs1Go2Nk9XKHJHT+aDtPRrgxMt+6X8/sqfRj1
         mZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767149728; x=1767754528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ovFZ7nDpGXAGjzX1rK/nF0C1dw1vDfNt7z4qsrWCWJw=;
        b=cZQ62sdf+MVKne7GNLrKaOpVqYLBJlg6DzAWhQQTO93mdP7cUvqs279UkuJ5pfZkhh
         lBTM3H4C3zHA6JXi3SrlpWtoYzNPHGnBbhLQ/Ewi4OKyQHinU3NToszNRz6tiiCDiLUp
         ml3QYcde8ZYPsolLMRg5DeCPnK4qKzVfeKxJwMp9QBmkqeLVi+z2wcCK4VcyHuYHKT1y
         8nXZLQuj7YLhrwRHMT73AQeBtLBAaOwlSLskcV1cPns0LpL0G/XKQ6fmxY5UhNITBHkk
         GDiPJMWdWr9nitDqXqheo+9D1AVd98cqQFmqqpgUdemjTl0hNDhu+fccF5ri7RmYacQC
         33CA==
X-Forwarded-Encrypted: i=1; AJvYcCWhogoi95kkfbZqGYDUiKmDwD4Mv0FGxkfrk3QeLxCYI75ofEG5Rcijc6UAlOhi42GOSBSs0aY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9nqGa2iok/roByNGCj1xkRRvGDr+TmJEasbN/wHTBUN4q4r2B
	SABt0jh9evla4ddtaAIwwgUB+Qt9Yh+Ynsk826BKg/ViQPsX1aBIdA2f
X-Gm-Gg: AY/fxX56/NMCQK2F34fOQHy6QWtsGKxNBEal1sT6vIJ5/eQC6Jv+9QHUBiqOsGmtC5R
	XfKYJDqu4hTZtzqTDiahdxHAeN11Dh3+3eRJNQQXRA/2yZd8zfci10Mu5LYaCa1ta9lTeSgRujR
	IsByzjZUNK8DWYT7ZlSK4reEsmw+TVUilhTl3stVz3c3QeGDRb5FssPek0b1hCksahC94T7WeJ9
	5mPiiEnrGno2peTCY2T2l3RwEWPPaP1kj8nU6Qho13+hzZjnMSdlo3umqG7LBzV5+P47/apBI8q
	ljqsDt/5fGWvvcJHeR3+h8CtJtS2cQUsPWQ+nsBJ3l8l/p4lEA82OgqqdLWQuoYKP8GjzHdFCOD
	TslLQPefmznAI7tWmgNhGF93iwhwC90eXnlwCpGBhR8J0G4sKYk+dL5b6B7v6xNYtDXaX7Y6ZoR
	B/zw==
X-Google-Smtp-Source: AGHT+IFjVb9L7i5dRy0ErgLaowmMDW/jAgagrfbQrXsnKJtMt/MDazwp5eKXxShX9HNXUzfl7Ik/Yw==
X-Received: by 2002:a05:6a00:1d14:b0:7e8:43f5:bd44 with SMTP id d2e1a72fcca58-7ff6725797emr32738775b3a.48.1767149728092;
        Tue, 30 Dec 2025 18:55:28 -0800 (PST)
Received: from celestia ([69.9.135.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e892926sm33623646b3a.66.2025.12.30.18.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:55:26 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] ceph: Do not propagate page array emplacement errors as batch errors
Date: Tue, 30 Dec 2025 18:43:12 -0800
Message-ID: <20251231024316.4643-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231024316.4643-1-CFSworks@gmail.com>
References: <20251231024316.4643-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fscrypt is enabled, move_dirty_folio_in_page_array() may fail
because it needs to allocate bounce buffers to store the encrypted
versions of each folio. Each folio beyond the first allocates its bounce
buffer with GFP_NOWAIT. Failures are common (and expected) under this
allocation mode; they should flush (not abort) the batch.

However, ceph_process_folio_batch() uses the same `rc` variable for its
own return code and for capturing the return codes of its routine calls;
failing to reset `rc` back to 0 results in the error being propagated
out to the main writeback loop, which cannot actually tolerate any
errors here: once `ceph_wbc.pages` is allocated, it must be passed to
ceph_submit_write() to be freed. If it survives until the next iteration
(e.g. due to the goto being followed), ceph_allocate_page_array()'s
BUG_ON() will oops the worker. (Subsequent patches in this series make
the loop more robust.)

Note that this failure mode is currently masked due to another bug
(addressed later in this series) that prevents multiple encrypted folios
from being selected for the same write.

For now, just reset `rc` when redirtying the folio and prevent the
error from propagating. After this change, ceph_process_folio_batch() no
longer returns errors; its only remaining failure indicator is
`locked_pages == 0`, which the caller already handles correctly. The
next patch in this series addresses this.

Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 63b75d214210..3462df35d245 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1369,6 +1369,7 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
+			rc = 0;
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
 			break;
-- 
2.51.2


