Return-Path: <stable+bounces-247051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEBGHKEHBWpRRgIAu9opvQ
	(envelope-from <stable+bounces-247051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E173653BF13
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C55E306919E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B977838CFF8;
	Wed, 13 May 2026 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkDvro1I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64D3A63F9
	for <stable@vger.kernel.org>; Wed, 13 May 2026 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714466; cv=none; b=YE+/l8LKZRSiUQo8TvZPnxyF8rQtbkeRjTh7ApyqJ7k7ZeKtxeXLe2v8gQWupxqsjCNkJgn4aB1GLQhtDB4zjkmnyhuq9LJdDO3z3cglihPqEgkaB+0ZaVG8G++rruyQswsAWZRoh3Sff4on40K5TaQ5Uy+rWCiv02/xutVc8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714466; c=relaxed/simple;
	bh=8eMawit0OW6ad3SVf7uGB8gFZ+2QQvYBgQHoNHZfxY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOm2pUFfJj++HnymKUDIDDGlF5Lq+WSHE6RtTIIJ8tK05hKIZZ3JPRUfJvVhK9YT6TYwY1uHgYLBr46+1w93BqgsLOZkPU7iXLG+6tPojtosdra0ZftHwCxlgpZORDPU+Au1lNFmKO6W+xt3o8/1cB/Rab0fA8B1l1wdGlNFEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkDvro1I; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so3792751a91.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778714464; x=1779319264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDJV2MG7QKyZ3RMtUvYJDqEzlimYTMaUR24f6p6E6NU=;
        b=HkDvro1IYQNpaCCHmUb4OWTu8rAqj5mPUk1fK95N6aLSRugsQKxKpIiD+ZEA5hA8tS
         nIicpHgaTLz2HGhuuIk04TnZ+ZyVf6S2GTfAe/MaoP8JQGMrBSBLwh1FKhUJyR3XcHeU
         mfMAQAmrqqVSnkhuWtFudv7ngBRsjUAuk8REb+UKhD5XibOZZ8wDP5UmTnew8kVsWFxk
         vIvtQC0B19Xx1+HPkLhlZYFgEUI/pVg+KI8PbLdG6WiwiTMFw15U/WNnRkEafsiXxU6e
         4HUWSM9DqzMS6kshJBN2ac6Xf2CitGJfY36PFLU60Ad98u3g2dKkV2ZBhvI8Su0P870s
         py5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714464; x=1779319264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDJV2MG7QKyZ3RMtUvYJDqEzlimYTMaUR24f6p6E6NU=;
        b=qRRyq4anJRs8GfbPs9Qyx+C9kBLfF0z1s0sU1hiVTCR/VcX95xRGhHtEsjkzzx07+F
         BPkf9qx/z0JANyUvjA/UCdunJEe/zRqxCFV6xh0uVx7hrVPC1ZnSe6e+txRNyRGoyXga
         dOWU987KK+qxxo5Nms8RVIEXn0aQ73mMVnJ9phLAhHBGWXqiFoOuL2VBW60Np/GL7ty7
         hAu1Wycuf76BTEWieR3zhT2zJ6PZxAn48KZoOVEqtcLMbwyThjFJh1H6rkvXm2kPbK3v
         sF5j8C1/yPZerbYj3IEfQj3UXWKH4FNzlUiiK04khdhqhjldYqVvPm1Mb4qU8k4srFE8
         F7aQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HcN6mPZcc2yVcL2hx+QyquFYmVZ4fR6jt7l//U2wtr/bAdu6ig2S4I81aryjmmD22zG5ZVN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+MALbb+KTqi7zQsSd0QYRjV6z8ewnLagFVdW5xvewDqFBhps
	kCPuvyvrgFTUziVsa0EiPFdLVn5yHdPNKP7nLJoMzWrUieIG95BDKL3B
X-Gm-Gg: Acq92OFDuYXnYkT9eoq3F0qUt133wlHubGv0FcVllKUsjxWrBIxkPUxJV10YGXdgPKg
	geXTNfOp9h3k+gyH6dUFaVzgnOTJDQ0i6uMMAM1KhMXS0n0sHT1dfpsMZsTzv8RORl5AJ4cdUGc
	KDyF7lBe7ilDSRtWSr3Qt9M8oBp0c+fqG7viWZXeyDsavbzoEcaZI5po6jpgynRugPjeOPQzOqS
	ygkHCZqiE7yxOzChVHXi05075Ld0QjFGkuQn34qT4ppV493hgIGj9FBA29yXA3ekvCFvdApOr7J
	lVDdbD9uVOk9PHps1p2XqfUG+mo+gugLKW256elG9tyjLomjBo4JuzrKMqcTsLniJKnVH/y6PW6
	IbnQSMgARzlLpjAjD5ERtIrj9i6XmxefMvxKQ0nCHWB9R5WIIjBDzRJJgWh2Ct1AGU8cVAwZ6n2
	XgV7D4oFqwVzJhTOfoHITIaC5Z
X-Received: by 2002:a17:90b:3a46:b0:367:b9ed:dec4 with SMTP id 98e67ed59e1d1-368f3e7c1acmr6104542a91.27.1778714464483;
        Wed, 13 May 2026 16:21:04 -0700 (PDT)
Received: from sabzi.. ([2409:40d0:2506:51c1:7958:24d2:8e36:e527])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ede2074esm4089669a91.1.2026.05.13.16.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:21:04 -0700 (PDT)
From: Aditya <mail4adityaa@gmail.com>
To: dpenkler@gmail.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aditya <mail4adityaa@gmail.com>
Subject: [PATCH] gpib: lpvo_usb_gpib: fix heap buffer overflow in lpvo_do_write()
Date: Thu, 14 May 2026 04:50:16 +0530
Message-ID: <20260513232016.94653-1-mail4adityaa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E173653BF13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-247051-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail4adityaa@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The memcpy in lpvo_do_write() uses the original unbounded 'count' parameter instead of the capped 'writesize', causing a heap buffer overflow when a user writes more than MAX_TRANSFER (3584 bytes) to /dev/lpvo_raw%d.

Fix by using 'writesize' which is already capped to MAX_TRANSFER.

Cc: stable@vger.kernel.org
Signed-off-by: Aditya <mail4adityaa@gmail.com>
---
 drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index e6ea9422d6f2..ff7cef08031d 100644
--- a/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -1638,7 +1638,7 @@ static ssize_t lpvo_do_write(struct lpvo *dev, const char *buffer, size_t count)
 		goto error;
 	}
 
-	memcpy(buf, buffer, count);
+	memcpy(buf, buffer, writesize);
 
 	/* this lock makes sure we don't submit URBs to gone devices */
 	mutex_lock(&dev->io_mutex);
-- 
2.43.0


