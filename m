Return-Path: <stable+bounces-204311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A183CEB21A
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 03:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28A97304C6E3
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 02:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6802E889C;
	Wed, 31 Dec 2025 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw5O2WZq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D302E888A
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767149734; cv=none; b=jbFRPvV52KVudeIx5DXhSVijdsawELP4Os1bCPEI/atyNY7r9GlIP7XCTfdtLPS13nxTIfgeEuzYE0lKjFbNUA8lQ0EKMyz6rPrebUjL25lqcxgzMarEzZy6rzchC/g3oXx3KMwrQveXEjIwgMY6J6TZto6Zd44J1mdQYfft6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767149734; c=relaxed/simple;
	bh=2MYN99jAWMQpINhvGeEWth578u35RLmt80tvIG1rBvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koOrA9NuPbsqQqdTgLZfB2rFttx6PxwM2NjHVEYUrmohJyum+BbDn654qovagqmeqV1Vh9U6DGJ1/ZCJO0NgnntJhLF1ARSYqT+KVZZsp4momaysRnl8TiHX8f4K3rSbo9rQ5s5VQlF3eDOET8RNEXydcKueyVPPcbtRIHgZjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw5O2WZq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7e2762ad850so10969619b3a.3
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 18:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767149730; x=1767754530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WD8xYCq07j/aj+WegcGPJWer+Tc/bnFPxdD4Wp5XP0Y=;
        b=Xw5O2WZqu+0d8OEAuJi4mL3abvMp2lybFKx4CXtYiBTZtP1EDq2Rnq8qyvcoa+AzDY
         T54bl6tkq+MWXAQFn92cbGBUTu49Fz94EWk9ROgKTXCRhmfboxXnxcG4onOmzlV1S6Yo
         ORjlJamX6xTw6YoiqSRCWwccx3p4I8ejzLoyYQqdvAEqlDVPPG4gVeiWNChPm3SMg5oi
         Xmw+futbmadY39MucZk0QLh4v6gWY5mXXKoInubl8+cI93o6luY41Vh8f2SXB4BIpcP6
         bBe/4Pk93hv6wxcY2d7qE3XxN6n0Bc2KblFDNoJJllWbgLSx5kjin/77PyrlS3+PmcaY
         G5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767149730; x=1767754530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WD8xYCq07j/aj+WegcGPJWer+Tc/bnFPxdD4Wp5XP0Y=;
        b=WjFVOgInj9DmStwGh3fgbmphE/72SGP12OXXhJkH5fSINl9eHIT8s0FmahnDuFvMUJ
         cHnGC5Fdp2vBERfWhGa0yguAM4DSy9YCvRvgCWHfhwvhMFOax0pjamHaK39XtMDma/G8
         yGen8w8+670pECYu3RRtobeUzUADq1pePsBItL7MX5r6/xSgq5AwgtTyRGsNHWczSau9
         Xi4Z/VXQwsu8cCW/g0I6OSM4bPqCHMAzenoeqlwc32P2DOPgjJT83p7ETZHw8e6XokIo
         ZuvrAulAt/B8WCSOxpg6B3/UizazA7wuWHgA6WiYcrDrXmF7nftDZYX0oI7giS9vWozu
         VPrg==
X-Forwarded-Encrypted: i=1; AJvYcCWMwL2dEAWwRWnfabFvRhAhnN3abGuxrPM7b51mZr53E2kKG9//3FdGYnSgVYDTlEt5A6nHHkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1dDylhbK3a+mYlyxRmerO8/5urHh+4H/u7Tc7JQnsVF8FMVP
	dSsQOlk9KPqWnrFMMdgdVxQadl3SLSeHHCTjCN8jawdEQh0449IKqqC4
X-Gm-Gg: AY/fxX6sw4wUalHUKwiHbGjxw+t9IUwYA525bsX4MGJaMAmwnZT8faYkWin8j7EBwas
	YGDPTPORojxMvJ9IvmZMdarJlhn9QCtoKN8K8+f+hd3wr97l7h19GR92sE7ax5qSHMYg4b/ufEi
	4wr8DAnhaCSAd+qVivF4Znupa7KpSyrv4QEipsXXrIeYrWZzP737yOEqiRc0zOxj0uyPkd9kXyZ
	fhj3o8ONAuGfAAqFzqiGRuZ60e+1IMSgSUP6Py4Q3QbSFO2a/nsNpokcivqapsBrS6ubbZqT+9r
	5kMVqkEQP9pcwFn6nPV2GNxGv54BqyfLOQS2yTd3jt1xaVDpKH1Yk2O2f6Vjr5IQNNu/LRHL+sT
	MqW9Wr6BirjWa06Az2L3zeu+JVh5S0yzhpPVwzYeulvPqPD2FKXIKmuThW7wXRz02+Jx1S0l6YP
	bBXA==
X-Google-Smtp-Source: AGHT+IF3Z5kgxOEyZ8TlUQEufDwaKzpJsoPdOR1wRnbEP5UUX7ilO8guI8waAq1O8VB1kpQTu9fn1Q==
X-Received: by 2002:a05:6a00:ab0d:b0:7e8:4433:8fa4 with SMTP id d2e1a72fcca58-7ff6607e208mr29157334b3a.44.1767149730562;
        Tue, 30 Dec 2025 18:55:30 -0800 (PST)
Received: from celestia ([69.9.135.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e892926sm33623646b3a.66.2025.12.30.18.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:55:30 -0800 (PST)
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
Subject: [PATCH 3/5] ceph: Free page array when ceph_submit_write fails
Date: Tue, 30 Dec 2025 18:43:14 -0800
Message-ID: <20251231024316.4643-4-CFSworks@gmail.com>
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

If `locked_pages` is zero, the page array must not be allocated:
ceph_process_folio_batch() uses `locked_pages` to decide when to
allocate `pages`, and redundant allocations trigger
ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
writeback stall) or even a kernel panic. Consequently, the main loop in
ceph_writepages_start() assumes that the lifetime of `pages` is confined
to a single iteration.

The ceph_submit_write() function claims ownership of the page array on
success. But failures only redirty/unlock the pages and fail to free the
array, making the failure case in ceph_submit_write() fatal.

Free the page array in ceph_submit_write()'s error-handling 'if' block
so that the caller's invariant (that the array does not outlive the
iteration) is maintained unconditionally, allowing failures in
ceph_submit_write() to be recoverable as originally intended.

Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2b722916fb9b..91cc43950162 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1466,6 +1466,13 @@ int ceph_submit_write(struct address_space *mapping,
 			unlock_page(page);
 		}
 
+		if (ceph_wbc->from_pool) {
+			mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
+			ceph_wbc->from_pool = false;
+		} else
+			kfree(ceph_wbc->pages);
+		ceph_wbc->pages = NULL;
+
 		ceph_osdc_put_request(req);
 		return -EIO;
 	}
-- 
2.51.2


