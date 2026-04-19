Return-Path: <stable+bounces-238666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGVjF75H5WnPgQEAu9opvQ
	(envelope-from <stable+bounces-238666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:23:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E67754258C5
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555B53036608
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 21:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C27C30DEBA;
	Sun, 19 Apr 2026 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzHHOgUh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D475B30BB94
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776633739; cv=none; b=sAiR9Nm/VssSfC/L5E4RiAQWyWBsQ8kh2BniJrZvCM2yDvjlm5W39YzsaI8P2SHkPo7tq+01bfiCF2NV9VKwA8+GB549LbFlxlvr3JEkpd4TPqjoPyi/Pj7PkqPs1p+XZjkffiCHkk/TEWwu22EsOGQf7qouiJcgVVK0QfXxL1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776633739; c=relaxed/simple;
	bh=iyYciPGfOWS+PP4eS+FUuE/6DmHsutqvGRb809Gt3a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/O2y3voWoBqbN6YIDOTo2yS0gu2ybNNzOLidRJa4Ybx5fKoSYGUPDzM9P8szxwXTwDWBRnZII2gX949TL42zcKby6NgwfPGBwjQTFIFTBURVMiq4wb7dhSo1IRhbyecKyGfZ2TCs+0jr7RDlnXUCwYDVfjgR2I9SX36NyHMx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzHHOgUh; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d67a483d3eso270823285a.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776633737; x=1777238537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xR/LK1vY5jMYZYpJbaDoVbD4RzkYk8NMN3z+ldfPAwI=;
        b=HzHHOgUhWj+nC27pznyTLokTvYsk54RJ+D0dyQE3u549ihFLTnAUp/1JALCrY80q9s
         eL8Bj4UrOuRWz2ZOYWDTeezP4z8JUMEvOeZdi0s1yEXs78QqtnumGZT9+oSzuUWbqjZE
         ElDUot6NCb6lPGwG9+0vcaJhxQsZyD5nJoMQsc7TzbpF8c3aaFOms0jhVUuxZhRrMERT
         4n6mQZIJHLVOSeyX0opgINAFGacKdg+qHG7nsDOWY6LE3rVj6w/RDEumflNRj/sRXd1m
         RCBURDP+iQVP4hsJLIGdKg8kOuDXwCavgD+b2Qk/SwD7Cy1mnMknjV9rr+sNc1Lbzoyq
         xsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776633737; x=1777238537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xR/LK1vY5jMYZYpJbaDoVbD4RzkYk8NMN3z+ldfPAwI=;
        b=kcTRCyjFR7hL32V/KpgVRgw60vMoIZN28Ritb6XwCj4yHlDvxL0zp0UBz8LQBYmJB8
         C+vrzNnaBiO+krZwT+FnP9Y1WVfe7iawEW6/fdu1NT4VvuYFITN0RsAFX1wOZotxVaPr
         A9vFb7HVrschC11k0CDSKiTLQE7jhxQBMxvBYogyrwI5VD1BI4eU03NRb8UtFrMTbBuN
         HLqZpwZgfHMARkzELhV4QQ+O+ICEjq+T+Zvugeg3izQeVrhtMxTxquRyKEUFOIvUjWKu
         8PAZWNXNu26HJLwGe5mV2Re7nEbPsrJ/z4fK7FzOK29cL1MhAdCQLhckKvyp3zk8wKBI
         FSaw==
X-Forwarded-Encrypted: i=1; AFNElJ/0dIBByBOg73sbTNCPl69wjDxqc7Offaetv69GUkGSSjMvTSbrN3vWpp9iOHT0WS4yCU4E8bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCAfuLmoSrQb0OqsNSluMyn0zPshOu09zsrFjDXKRoI92kx7B
	XALkruPmsmRca+hD3W9UBmCldn4MfpMzfGmBe3XZAnDm9Fur5yKCzdYG
X-Gm-Gg: AeBDiet6LkOfCGZ0XoQ0AvNSyEuzuFr3hI5rCEp9owvaMCblRRdcx5sP2G4OXlx+9Gu
	OoiA7v/ItpllU8p/zP1qngEgAe7Bw6PdIwXnip5EfdY1TZdzYRlyj5kt4ht1zEqw2aLiBe36jja
	yltsR3XMBFvBebaidjnWzlBxRHql3Mmkdnss90DrSGhCygfsqSJfOJnmKksu4OKF9i4t1c4u67H
	BmLFiOSz2PV59Lxq+2SiCF7+UTkLe2ucdkinX+A5QlymD1s3D0GY0V6fvXR/uChwJ9nCa3fYjJF
	FgXoSBr/lr0cbKmWJIC1DHT9uq2OdG1xJkyrJeqLYa+hWCQyn2R4LmjmMbm3ZyEjUPcj8Uhc0k5
	wAGK2Ov5J9wAU8YpcAEmQcZRLZRloJNbl0YWHL/RmZLckzPMLcrO6cWWxHEw/h85cDp3sdvRU9T
	GesjYqPHhgqp8jMnWCSf0kf2SQmixXfSRXutIsb7+xvH4lmi8AJyyEFPahgZM7KML+hEAKzNeOx
	12TTNlnjpdJhJRqcq9GCBknKvl3qO4=
X-Received: by 2002:a05:620a:44c3:b0:8d6:39c0:e6b2 with SMTP id af79cd13be357-8e793047868mr1577053385a.62.1776633736831;
        Sun, 19 Apr 2026 14:22:16 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d65c1321sm654849185a.15.2026.04.19.14.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:22:16 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Edward Adam Davis <eadavis@qq.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] isofs: validate block number from NFS file handle in isofs_export_iget
Date: Sun, 19 Apr 2026 17:21:55 -0400
Message-ID: <20260419212155.2169382-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419212155.2169382-1-michael.bommarito@gmail.com>
References: <20260419212155.2169382-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238666-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[qq.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E67754258C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

isofs_fh_to_dentry() and isofs_fh_to_parent() pass an attacker-
controlled block number (ifid->block or ifid->parent_block) from
the NFS file handle to isofs_export_iget(), which only rejects
block == 0 before calling isofs_iget() and ultimately sb_bread().
A crafted file handle with fh_len sufficient to pass the check
added by commit 0405d4b63d08 ("isofs: Prevent the use of too small
fid") can still drive the server to read any in-range block on the
backing device as if it were an iso_directory_record.  That earlier
fix was assigned CVE-2025-37780.

sb_bread() on an out-of-range block returns NULL cleanly via the
EIO path, so there is no memory-safety violation.  For in-range
reads of adjacent-partition data on the same block device, the
unrelated bytes end up in iso_inode_info fields that reach the NFS
client as dentry metadata.  The deployment surface (isofs exported
over NFS from loop-mounted images) is narrow and requires an
authenticated NFS peer, but the malformed-file-handle class is
reportable as hardening next to the existing CVE-2025-37780 fix.

Reject block >= ISOFS_SB(sb)->s_nzones in isofs_export_iget() so
the check covers both isofs_fh_to_dentry() and isofs_fh_to_parent()
call sites with a single line.

Fixes: 0405d4b63d08 ("isofs: Prevent the use of too small fid")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/isofs/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 421d247fae52..78f80c1a5c54 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -24,7 +24,7 @@ isofs_export_iget(struct super_block *sb,
 {
 	struct inode *inode;
 
-	if (block == 0)
+	if (block == 0 || block >= ISOFS_SB(sb)->s_nzones)
 		return ERR_PTR(-ESTALE);
 	inode = isofs_iget(sb, block, offset);
 	if (IS_ERR(inode))
-- 
2.53.0


