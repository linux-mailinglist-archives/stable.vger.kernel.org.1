Return-Path: <stable+bounces-254480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCrZNwN4Fmr3mgcAu9opvQ
	(envelope-from <stable+bounces-254480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 06:50:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF115DF3DA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 06:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCDB53041A36
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97039305675;
	Wed, 27 May 2026 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehKKIGMy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF72E1F02
	for <stable@vger.kernel.org>; Wed, 27 May 2026 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857374; cv=none; b=GJst5aq+6lOyLG39uj2b3TJ8KnHN2Mq7cSYhf6o/MNLGsQEOpIT5Ar07vC7vZja6E8mExHW0QOz3O7nt0Yw3kS6ZXzOfkFcaI6i5pEesLVkROFeFkKLWE0enb7/GFvaAxEpNjQZxmw0tqae5sxDVo4IXIIb3FByXGAyI1pJB2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857374; c=relaxed/simple;
	bh=GYq7eClao3GaV9lgjcsADvNLW1hhn25v8rqXYSyuj3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx68q+s/y0ga53U/T9z8bA6IS8qv29Ijj1dMufdPL5wecVuO/go8vqS3sMhjSXmAGJAgq7d3YghcSfsoWVc/HdVVTAT91HOFW4+qcEsqRw88ABzOxURU94/XshK6vbhe4zoXZLB8p+GF81rmhlHRR8N0puCHHf4a7O/tfAmEFHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehKKIGMy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba21d32776so83128525ad.2
        for <stable@vger.kernel.org>; Tue, 26 May 2026 21:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857372; x=1780462172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdeTI3Be/i5d72s0tyEQ/VcPybxiAdaZv+qc7OW/TlU=;
        b=ehKKIGMynH3pBDv7rLxR4zIm4GhX/DIcUpFSMyiiAHjO8wK4veZ1Opdcryt7TuXZyi
         OAtsGq3iSuFBZeoK6bODIFweimgGSXPWNxu3HVRdbJYk+XjClvnecXx/uyYgR5Da1uje
         YcAjDqGQI5WcnXJcj2HRMsBHCAsoBCA0cnYbxD+Ug9BgjCV/nWqs+ohrnGbUS6ZOnE1c
         kRMmHrzCl7ebiqj7L6fMnCVNGCdEXM8wRzsOoddSUqKzyQHaubzt41rtuJ/v/DWFUyvA
         lR/lEAoFNsPOHHKifPvbqEKgK3/HwI3dBSdAEyXh4ESk3ffhLwxKyyaglxN9Ezlz9/nl
         oKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857372; x=1780462172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HdeTI3Be/i5d72s0tyEQ/VcPybxiAdaZv+qc7OW/TlU=;
        b=mabl5ySoFAxuc3gAduMvo34FUtUadniQ4sRNKFpZ3CI/pEX7c3HmDYLD86I7HEk5Jp
         OA0xrRIa5dRaHiI/Lpz5NBh3/ieh52uABZcfggdfTTG85nY4to7Ulq2aCxajcGWAB1Dd
         8SOvo94iKWB/YMOJjExdvFXLnHFOsut6ez/1vtWgaLNKWPEI0MhJWG8h+XdIatCDdgf7
         qGqG5SnPaTYx+mEqN0zCwtYKaUFsuX/g4qfGmaLsfgLhrPIoOrLilVsDshgU7GYgEIj4
         ah+kOv61IAT4WxLwLAG65zi7wKh8rpHXAuGfKJoHXjpOUHszTCtkPq7w0Irm7M1kbXlS
         OWWg==
X-Forwarded-Encrypted: i=1; AFNElJ9N4lHPv0+c3U+NXH1/H/teDWdKNI3/eGocdvGyjfj2smj89ZWjoZanJbEAnLicAkmq5YDmL3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/nV+Pt4GJhPEKuVwGjh+2K3PhNhqrWY4T+bPaXeFWbkV94dWe
	klrJkUs3mu5Ngs/kAFVd7zGn7Tc2yCoS4pSuQtmFP0ySiIAZRim4eVuR
X-Gm-Gg: Acq92OH7EvQ6Hv3sbo+OD9moOkvHEy9YSyXsq/zHzIDk6/Ln1lDqfQOiTpXLCMCHo5G
	/1ICKciGCLaXt9+VVGK0VGviNMoKw8KhQWRsWGDFumRgM/Wpp/rArprdkCKMFbIy+FmiC+Mrc2i
	Ge81eFbMZc/7nkFKJk1ncB8WBEymH46z+DtEGDWnd9UXDp4ldcNQpAUE1nem0Fi7gN5aKJjMzYv
	t9s3qhd7CEwIPuR6nykEXiblowmQOo1D0iS4R2FjlP/xF3D3gY3rlprzCvSWGZAMNKNuekPxH0Q
	G6iJEb4K/h7eLQgkiBPotKWPMdrU7ZkVR6zwpcCAC1lJjvsPuTLWptGw7y+ZobWMy3I9X0BD+Lc
	z7DwGxdpOAgt/SIa1wC1L55+j5W/RVXyUpjp5h6uLkpSOi41wHj1wbGDrZgwwucnu+XB3oEoqLm
	kljfwjnKSbubfKk5zGkcLpq3bUWxKY42lqvQ==
X-Received: by 2002:a17:903:3b8c:b0:2be:1db0:f166 with SMTP id d9443c01a7336-2beb0346484mr233822145ad.10.1779857372512;
        Tue, 26 May 2026 21:49:32 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dba7bsm135704105ad.66.2026.05.26.21.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:49:31 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Wed, 27 May 2026 12:49:24 +0800
Subject: [PATCH v2 1/2] zram: fix use-after-free in
 zram_bvec_write_partial()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-zram-v2-1-2fb84b054b5c@gmail.com>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
In-Reply-To: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779857366; l=1429;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=GYq7eClao3GaV9lgjcsADvNLW1hhn25v8rqXYSyuj3E=;
 b=y0NCB/JE8egqDA7ZvcgiKHXXTPhJDt3eJNcyH9vjqfcf2urXXxuO/7LuiX3+8OQB5bskhQHGQ
 e9j1YvGYcbyBEJhvACdZy6pB4TiDjVceAUvbcQ9UF8MJErpnJDy5PYO
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254480-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shenxiaogll@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1DF115DF3DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

zram_read_page() picks the sync or async backing device read path
based on whether the parent bio is NULL.  zram_bvec_write_partial()
passes its parent bio down, so for ZRAM_WB slots the read is
dispatched asynchronously and zram_read_page() returns 0 while the
bio is still in flight.  The caller then runs memcpy_from_bvec(),
zram_write_page() and __free_page() on the buffer, leaving the
async read to write into a freed page.

zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
("zram: fix synchronous reads") for the same reason; the
write_partial counterpart was missed.

Fixes: 4e3c87b9421d ("zram: fix synchronous reads")
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..b23a8bbb687c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2333,7 +2333,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);

-- 
2.30.2


