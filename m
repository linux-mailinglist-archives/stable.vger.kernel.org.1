Return-Path: <stable+bounces-206218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C21D00171
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 22:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E9913082EB0
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 21:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABEE2D130B;
	Wed,  7 Jan 2026 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci4kyi3z"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5D29E101
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819731; cv=none; b=nQf1WO037OJOHdj07wlNRWtMw2cHyY445XRpoe651xmMWN0P/z9zCwXioRm10DmPXFJaUzr8vxDfj9e1X82d/p/HJ7HIP37iOu6qpyZ9Qcoinq2asJRxqLDBuRNc2IigMzotK1p1p/Sd8/z/ghktR+7GjCRH44YLcALsAkLFidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819731; c=relaxed/simple;
	bh=MH9ItMzBcZTluvZqALSZ1F57m7cvQEt2yG0/5jKRRIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6JQzob7FNiJAfjP6/M7aHpOenMQQ5McfvZZu+YIWR2pFJS6OFhjDGqXQlOAVjYXikO2NV4bUoPTITyguI6q2/zs6FVudWuUXo9R/fjWdEzzV9TyfmzMhLPgTKV33BquG/eiKkin3pIfd/2yjBmtXhi86lJa46nTfv8uDWHFy+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci4kyi3z; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ae5af476e1so724931eec.1
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 13:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767819728; x=1768424528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI9ht6zLDnTdHsEUK/2YLyBXC/hQ/zyK3ZFH+/rd3ZU=;
        b=ci4kyi3zD2j7KiLUjQkIcDU7vuOsX6S4mJZQ4AVy+npgOrbsZh/gpA6dORUo6X6ds9
         Tw8napnxETN5al9CCa2jPUtv+17djSqaDZqFicacXROVkiQlgyo6Vp4M1aXCupq0tRUQ
         vJVtuOlv6CEzy3AIwBCADL6oDk2iqiIGlzCNaat5/llGCRur5W7Wm4narV0IDWbTOz1Y
         Y9ne0NH9h9fdsqH9bQh0aeKxp5rp8DPdnIQP+9Qqs+VPUcNxVQNN+RN89Fk47Y7QNU6Z
         laBqZktA3/2NYT/Bi993LIQGBXVsEnfVQVXNXJO+9OhYjWN/fhPDLGQfeb+xo0vTxV/K
         Z3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767819728; x=1768424528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rI9ht6zLDnTdHsEUK/2YLyBXC/hQ/zyK3ZFH+/rd3ZU=;
        b=n7jjCYr4cg3g9L0EdcP2ls77rVbeaj3zkjCW23BsQooF+31wqObeui7O6k2IPsBai9
         xjPykzLIa42QSNGD3GcI6JKFTIfUeWs4MYYhFE2dbrVgiVGeikfslzyf+3UVkzR49OC5
         Z8butJtVtOyChcz9zoL4nSJo7DoQLJgHl4aDkNihIAN2f66jkUi8nNYfqSzBdXIF36PM
         C3DtKZI0KLK9e8As2v10HS23NTE40btk3pQCkMPevhr45ClJ7xGcfYtKvj51z5r1njsZ
         z3DAK4mbHTrLPl2hMdiUx/GzJtvTVcDHfium9EaPn9skB+NlkeN25ARt3eX5E+4+9/Re
         nNfg==
X-Forwarded-Encrypted: i=1; AJvYcCU4ACHk23ZEyKsFsfmjryoKpX/6NUSfoOELpboKVB6Fet0KSCQdU7kDJWxLMfupOYEoWBvhmno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBbT6cny8dOBFmtaapf629dipx/Ljx7lnjI1Xphs+KckdiF8Z
	+COELBWSXW4WtH89SzmGi6Sv2vIpxjdkCZ8eZutev3m5+azlcjDwgbTG
X-Gm-Gg: AY/fxX6jWeO6rngLxmcxAi1IjVnhcMfV2abbQ9wqS6wc+ti5/kcS/fR+qbABtC6m843
	PpWeX6+RaabENo/XK33x4w4uulpwFQkVEWVN5Y/XFaZSC/YYBa9IORRpRWPsIIblLMB0SrJSowD
	hEDKUQKSejFILCrYM91BfMvoFXeO7dE0Sc42Twq6LI6Wp/+I6F3vZgZnbycRzbvShNOSebWYS6z
	HePnT9F8mBuMId0Sl8aGEW9LcslcG9Se/ed8U2XU6d6Sn6JoqONrv22s5yTgJjWIXOp81WxvVmc
	LBdkZn7IL6STUqerOhbu1lNaSYtfhtyG9/nFCMst+BV3qn7VjVk934iKCTRFgd/aGxPqtl/jyWP
	X6KWtBadvdwOoPLw5x4gHB0EVt94KLN3igTjNafSopHQsg9mTnIkyZmYyCN55dZmEVJga5BJMm1
	pI9MTcvHPOARAT/G7zI9cDN1BYW9FA+vqcINvVwNZCLBRuypBj9YW+wnPO3Gjm
X-Google-Smtp-Source: AGHT+IGz/j2Ai3L0sVPhta32pFiq7xX5jIWUYZAFCkfFw3N2nVApKTu2oj9sPXVOchzP/JfTY8hCxQ==
X-Received: by 2002:a05:7301:700e:b0:2ae:4c10:138c with SMTP id 5a478bee46e88-2b16fe5a43bmr3571639eec.11.1767819727866;
        Wed, 07 Jan 2026 13:02:07 -0800 (PST)
Received: from celestia.turtle.lan (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673b2esm7730320eec.6.2026.01.07.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 13:02:07 -0800 (PST)
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
Subject: [PATCH v2 1/6] ceph: Do not propagate page array emplacement errors as batch errors
Date: Wed,  7 Jan 2026 13:01:34 -0800
Message-ID: <20260107210139.40554-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107210139.40554-1-CFSworks@gmail.com>
References: <20260107210139.40554-1-CFSworks@gmail.com>
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

For now, just reset `rc` when redirtying the folio to prevent errors in
move_dirty_folio_in_page_array() from propagating. (Note that
move_dirty_folio_in_page_array() is careful never to return errors on
the first folio, so there is no need to check for that.) After this
change, ceph_process_folio_batch() no longer returns errors; its only
remaining failure indicator is `locked_pages == 0`, which the caller
already handles correctly. The next patch in this series addresses this.

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


