Return-Path: <stable+bounces-254473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NLMEXdkFmpamAcAu9opvQ
	(envelope-from <stable+bounces-254473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:26:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AC85DEDFE
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D226300CF0A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A946337C0F7;
	Wed, 27 May 2026 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4qt36iV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6737B41A
	for <stable@vger.kernel.org>; Wed, 27 May 2026 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852401; cv=none; b=VKzX3DSiic60x2IevJFLJ13z6Y0gDAY+c2mrRa359ysEp4mNQFTyURgDlDSV3h/aY3zWG4YPfm3+LfH9DaL40MVpNvoDMEZXbPn2SXvptKVLNKBY/qVDHZrHsD3xKxUKNuFQKlo67lBovcMdJQK7jtLFQ1sWK9hyDENLVItihfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852401; c=relaxed/simple;
	bh=7NqP8wTnbRIxVIzZFbQP+alLTQXvzELVOk1InVzXOvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hu56/traVj1wNhNdwHf7QSzgvHMoEwRr1cUMXhV6tWWmTYLwVbvB2MzrbZVqNE9o9EhuakWi21SYh26aWFVH62VKDwn1v7KFL2OCGCfXV9qRaDbPh0OpqEPkhNmPasWFjVQfl2hLSITrpiQsnKQWpDNc7QyjmoOjlTmzCXPHYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4qt36iV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bea7176c72so46034525ad.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852399; x=1780457199; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H63J7/JvszdGRcjeN8wXnJUHZrHDcDH58PcyxoI9MIw=;
        b=A4qt36iVvMAc/ws918KKQtswgZCew6tKtj08YXiOQLED15c9SiN/uusGM8CTylFeSl
         g87yM963JeyP4zCslII8wGa1nRNJQA9ZRqEVpfimfSo3FXxRxlHIDFUHjcacTT/o+Toy
         ldKOC/1y+/6H+1eyQ6u74xVICH4lE6tKCoXe7gzu3MmFTjzJQB8II2Vxx5AXVDqm/pPN
         VXh1Y5R0yZomLWH14p/JQvm0YCqIVXyM3MBxe2kp1IJJtF1LUUJF0TjAZYKMHVCafxqr
         F3rXvPHy6ozXbH3afC2tkil2ZH4wq5ECA+mRTkMh4TQBJqBIqq7ozwmASFue0Ygr3M+T
         AZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852399; x=1780457199;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H63J7/JvszdGRcjeN8wXnJUHZrHDcDH58PcyxoI9MIw=;
        b=OBlP2/OH8oRXU0VWbVbBvb+HY+DoW+tKmh7mY6lmhjOp2ezucJSYRp48rWx0GTzOis
         1jigQpfQkpNOHLjD7QMJQUuiNpXMRuQb5BVoCrIEvEFJST1AlTjWKHA7/vuMrRQdTOR5
         e9HDwi2pib2tFG+0p3OjoU+wuqcWFIBAUk4LDGcBnGyqhmxOGPdV6MrE7iJYt50VHAYw
         54YMU8MUJM1kKef+WDBy87fss+H2IpRhdqVultPnjVUcef8iVL1nfBzANxlM4vY8uoN+
         mfzcg9fjvJCXD9UIZ0OGAozoJDWUAS37D9KW9tG4HOsmXUUeP86Sm1UCzVfLz9DG0oGL
         fxgw==
X-Forwarded-Encrypted: i=1; AFNElJ/DCfc0zeGcyXAO7kcOBZv5/xowp7ol7Er3bxkE+T+1PqVfNfHYpaN9+G6j6CN9FWYkD9c+gMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPc/XrotGCmzO9uemNC7ObutaQwcpOF3HXcBs+IC9DidzYXeve
	nVTa/Ll8qe59CgYIxxfXokWtnN56xen3qKeBE3TYg9qwlE/qkDzA7ezk
X-Gm-Gg: Acq92OHRlRBC0P6hAdzuSSEA8ty1ztMRbcAFkwQbXv3luxpWg0t+P+o+zLXgEh3ibSu
	3iCNMj74VVfHqrXMcJpTjFYBJn1g1zUfBzFyo7rhbGUvSoULywHsjHGMftgdmmC6SaFzUXLTTyV
	pcgoBaqStW+HduH4KXUMPtV8HON6uQJ90sy1ZpQL4JdZykJBFAYvKrhYHlA6pwZp8sBc3dcajnJ
	M3ozOEeHUEVU9437dNacTpyG40TEce/WB2nVzYtrBlu6PywqP166GXRV8VbRl7zpWqHc6KaeYDz
	n3e1Jg1FkUVygzbAcva2cM3E7SXpDHeVLbp1iKj83IOHt5IGqq6qOJfrb1gb3URZRB9AgUHx02G
	EV9N58/c/E7/7+/d5dwhSzYqVsxPfkxik88lBStljk4Xp4hDTc1wjMRmnYyaMKBV7smrWq39ql1
	rai7xssewOh4vdtFTMMPs0xuMBBmTiC7P/quZboQMVgFA/
X-Received: by 2002:a17:903:2bcc:b0:2bc:b80f:677e with SMTP id d9443c01a7336-2beb069970bmr226864455ad.25.1779852398945;
        Tue, 26 May 2026 20:26:38 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dba7bsm133826365ad.66.2026.05.26.20.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:26:38 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Wed, 27 May 2026 11:26:20 +0800
Subject: [PATCH] zram: fix use-after-free in zram_bvec_write_partial()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-zram-v1-1-ce1acb2bfaf9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFtkFmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3aqixFzdJANDEyPTJPNUs2QzJaDSgqLUtMwKsDHRsbW1ALPvOSp
 WAAAA
X-Change-ID: 20260526-zram-b01425b7e6c6
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779852395; l=1573;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=7NqP8wTnbRIxVIzZFbQP+alLTQXvzELVOk1InVzXOvQ=;
 b=rMIc9aoiEnh5ChwVz/WDhL34yOkVfP7nSmRV3FVvu4I0exZ1M9lMnRqSVW+ZJNXsgn1H9tPeZ
 cerOcUqZw+JCmnJWc/vNNzhiTrqiUdUtfEtbzW1nN8rRT966vG6i9zb
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254473-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lst.de,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Queue-Id: 31AC85DEDFE
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

---
base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
change-id: 20260526-zram-b01425b7e6c6

Best regards,
-- 
Cunlong Li <shenxiaogll@gmail.com>


