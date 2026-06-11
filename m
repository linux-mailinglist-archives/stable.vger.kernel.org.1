Return-Path: <stable+bounces-262803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IyP9MFomK2oX3QMAu9opvQ
	(envelope-from <stable+bounces-262803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 23:19:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87E67566E
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 23:19:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openai.com header.s=google header.b=FrCuAGLb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262803-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262803-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=openai.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93ACD306CC45
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 21:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E383672A9;
	Thu, 11 Jun 2026 21:19:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B632ABC0
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 21:19:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212748; cv=none; b=ABO2wATFf/0lS5uDfA+Qoi3RE4+u8w1I6ZBQmBp5AzMzhiFMRSffmTA1e01KVyyW4N+TguzXAGdvSQy54b8AXmXEGB3AQrx2wliBcHcIj1+NJXYSNpltbcF2j0nSS5Wpna4sNTAT7D2yMmwDzvonCYo0OosnkKvBXHMC+2TEttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212748; c=relaxed/simple;
	bh=gz8XXCvKDIUvwALZy3EPayeAQ0OgphiwA++tk+FDTuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9xI2CIvZ0fah1mnepoMwWnSYgwLG0MFpuuf1vU1MOsN7SB1qoc2DRVDMEoVlo+pW6n/RwSlycwSy3kdSqp/hDNpod4csf9hdb3h0H84GG8Ogd3USLXwsx4INKsBnD3GqyZk7GqXICGzPbTqTKMR4iTBWZhTOLqxZV7YrYGtgBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=FrCuAGLb; arc=none smtp.client-ip=209.85.222.173
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-915bf8800a2so40029685a.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781212746; x=1781817546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9gu0vVO+upgROS7/Iq8V7N+x8+Xf5/itiHQvLUydmI=;
        b=FrCuAGLbpYWbe7JoXGoxC59kngoAd/ndrY5P84QwVk3ykfLK652BRh0z6GtK0qxtwg
         mem6SxQcZoP0fcfIjA1Fcw/xLF9R1NjJOyhfFk/PQxF/Wp3m0dhqdekvaRIiWjkPyBwB
         8V67qZU5BR6pdR6ir8xoH5wWDQ8O0VcqGANpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212746; x=1781817546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9gu0vVO+upgROS7/Iq8V7N+x8+Xf5/itiHQvLUydmI=;
        b=f3Lei02BSxE7eb3TVyE/AQi58dHIb3KYkUg9s+zNlfTHE8u/jjeOfo0tNf7CxKMhe/
         2bSSomZa5ehPpefABW0CzoKWZu3lF+wxv7iKDPWuz+qrEiyf6uAy8/NFVV9YSny20Hg9
         iKSpmGwqJon86WkXuwLICfi3AtiGKEr5RMhQdsGP9+IxPV+k9hMmBGrknnw9bsz/Bojr
         0I+1niel9ChBJaMojtMCiHLh3vZ9xxEvjn1U9xC+G36PNbxrJdxC3Nc296Bo1PrG/WHG
         h1XKgbYaKDGKuxGYlYrIZPzKw2mgdUMymQuwNiJkZToGxtfW2QBst5nLxRb2EQKTOCh6
         S5SQ==
X-Gm-Message-State: AOJu0YygG/9RPqJGQkCMEV0ylKTTVKuvMxmEG3WNtehpiBr/aR+TbDH6
	r7Qsmp2EzYekEr4g+GNU0ya0f0VCieCHGGwVnoVXyEfbdyV2Y8F/CoK5VsIOsNRKhDw=
X-Gm-Gg: Acq92OEqMJBehiZI3OLgWXmVrGuaGw6SLK68AfTEE21Ok1pvRlGobJWC6cJq5+I5VFv
	WAHydBodEJ4Y9EqW7j1SG3Wn17pIS0ncy8gnO5ParCGheVmVcLpmDqG05cPpPHCXvKutuEfDBt/
	C95U3vwRDSFW83EROM/R8UpYMGUG+0INLr0h5h7vnl4LisG3/o9nztWakBagnJ3O83ON3z0Fj22
	XqoCbv/HwOtk3Y8SLh7voYNiWbVEtMcZ97/oSXXrYO7C9/+gT74qhgHTfFlcnhIBGVDLqaUbWQ1
	O/HNoh2nXoE0t9R2/bruGUY3xpzxvB5OT9lAkcZW1cKMUnykgGiYwjBB05+Vnsbq20GgBvP78u0
	W6Hqsqaek0+VRRdS7sxHxamK4mJ0e754daKlZ//Ar9dXhGd+ONQwPrlYGRHIBXNO+Wg8SusNt4u
	ebt5q2DWC9wTGLlT5kU2wnHJWOUqvGbpTLLCkvGtmJUrU+0G9VwWWnK9v64N6jUG4fke6UYl5D8
	Vo1w4bFmGXBR1RZlDeFc8mtrXby9yIIA5Q=
X-Received: by 2002:a05:620a:3724:b0:915:9984:5781 with SMTP id af79cd13be357-9160ad7073dmr708074585a.51.1781212745651;
        Thu, 11 Jun 2026 14:19:05 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a069389sm23600185a.45.2026.06.11.14.19.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:19:05 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: kylebot@openai.com
Cc: stable@vger.kernel.org
Subject: [PATCH] affs: validate blocks before freeing them
Date: Thu, 11 Jun 2026 14:19:00 -0700
Message-ID: <20260611211900.3720-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[openai.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:kylebot@openai.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kylebot@openai.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262803-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kylebot@openai.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[openai.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,openai.com:dkim,openai.com:email,openai.com:mid,openai.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E87E67566E

affs_free_block() accepts block numbers from on-disk file block tables
when truncating or unlinking files. The function currently rejects only
block numbers greater than s_partition_size before subtracting
s_reserved and using the result to index the in-memory bitmap descriptor
array.

That check still accepts reserved blocks and the one-past-end block at
s_partition_size. A crafted image can therefore make the subtraction
underflow or make the computed bitmap index equal to s_bmap_count,
leading to an out-of-bounds access on s_bitmap before the bitmap block is
read and updated.

Use the existing AFFS block validity helper so freeing uses the same
range as block reads and writes: s_reserved <= block < s_partition_size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/affs/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
--- a/fs/affs/bitmap.c
+++ b/fs/affs/bitmap.c
@@ -46,7 +46,7 @@ affs_free_block(struct super_block *sb, u32 block)
 
 	pr_debug("%s(%u)\n", __func__, block);
 
-	if (block > sbi->s_partition_size)
+	if (!affs_validblock(sb, block))
 		goto err_range;
 
 	blk     = block - sbi->s_reserved;
-- 
2.50.0


