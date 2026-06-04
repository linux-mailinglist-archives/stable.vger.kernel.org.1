Return-Path: <stable+bounces-260502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bdNiFqKFIWoSIAEAu9opvQ
	(envelope-from <stable+bounces-260502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 16:03:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16290640A46
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 16:03:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B8jV09cF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260502-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260502-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA5C3172D2F
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B6F48094B;
	Thu,  4 Jun 2026 13:54:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4647ECC8
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:54:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581266; cv=none; b=s6Epj++iAp8+IvmFIZbAYKs6CANuiFsNId/5msL0XYCzq/mW/Ohw5dq62ha/it/zrr028dhX35VE/G2M3YjUYXBZWkZSYA3i/Vc6QXpajwak0j2DWGNPlFYKO89sPy3Jb3x5P82buoVVIHyrAAJeYqz3Tcfs3tFnQm1QhQMANBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581266; c=relaxed/simple;
	bh=j/Mt77pdw50VFOnyy0z78fR2HPjj0Gu5NwX/In56ydg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKLQktFmyGDcPi2oz/TmDmqsNr1bDyLAapNzzGLVxsbPSg4alOlWvga++gpSs3Vgd0urRlj9xuKi8t42ltWX/LeatpDsQ0W6aMw04wNFubLbOc35V3j9bKDG8IejMR5MFXLkvzL9+7473QlBkfov4s/KHJeXevqaWWxbuEVHJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8jV09cF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA401F00899;
	Thu,  4 Jun 2026 13:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581264;
	bh=pDx4rQf8I7GKb3SCm3K+ru6o1WMAaUztvt88cH7Bql4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B8jV09cFB3whNtZu5y9E3qveOrNKKwa9WPr6vA6bv+2XZel0WgGg7JmYxDGxp1U0x
	 +lkwzzVBjPLy5WdjJGGPtAgWyNtYR1mWKdsBwzLT47CQyU9A2023anSrPAoc0nuR7R
	 0ReSLTb4ewJtwN9L+iaCCA280E/gz+JbasicEbcZyd2XbB7zP2rgS9n5mNZ+X4kclK
	 LGTRS/j7yfboCn6szeEPVcqEap0jdiaMzJagkNMufAqDyAo6+EhpVUzJ4DqvNUtsR8
	 ZFHvhJNeJE0kdthG3Ndn+Dw5fr9RUGlHQPHMd6l50xiJpxiA5NSV376nUG4h+vQFYE
	 nlhAaJlP8FgEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liu Ye <liuye@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] mm/memfd: fix spelling and grammatical issues
Date: Thu,  4 Jun 2026 09:54:20 -0400
Message-ID: <20260604135421.3490773-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604135421.3490773-1-sashal@kernel.org>
References: <2026060408-corrosive-dental-a22b@gregkh>
 <20260604135421.3490773-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260502-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:liuye@kylinos.cn,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16290640A46

From: Liu Ye <liuye@kylinos.cn>

[ Upstream commit 33c9b01ed2fcbc101cdfeb497f4581e981e7c1e7 ]

The comment "If a private mapping then writability is irrelevant" contains
a typo.  It should be "If a private mapping then writability is
irrelevant".  The comment "SEAL_EXEC implys SEAL_WRITE, making W^X from
the start." contains a typo.  It should be "SEAL_EXEC implies SEAL_WRITE,
making W^X from the start."

Link: https://lkml.kernel.org/r/20250206060958.98010-1-liuye@kylinos.cn
Signed-off-by: Liu Ye <liuye@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3b041514cb6e ("memfd: deny writeable mappings when implying SEAL_WRITE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 190f07b6b98af3..5c575d3e6fa6cd 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -286,7 +286,7 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 	}
 
 	/*
-	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
+	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
 	 */
 	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
 		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
@@ -364,7 +364,7 @@ static int check_write_seal(unsigned long *vm_flags_ptr)
 	unsigned long vm_flags = *vm_flags_ptr;
 	unsigned long mask = vm_flags & (VM_SHARED | VM_WRITE);
 
-	/* If a private matting then writability is irrelevant. */
+	/* If a private mapping then writability is irrelevant. */
 	if (!(mask & VM_SHARED))
 		return 0;
 
-- 
2.53.0


