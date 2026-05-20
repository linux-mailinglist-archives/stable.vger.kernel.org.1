Return-Path: <stable+bounces-250708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN1dHrb2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:00:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB83059514D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05DFD302B3BF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6C3EAC82;
	Wed, 20 May 2026 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vwnnakwu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C973EAC8F;
	Wed, 20 May 2026 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296108; cv=none; b=rV0XyYH7AGL8DllE7jExT4FIF0UOAihTmJZHZvpxZH2V+izzut0244TrrALWf2C5szZqwX4gcx/ddlg33awdbRXp2DEwDI0QypVz4yqcv2diugwWkFd8lnK3GXEijw4t1GTfSjX6ofd1+FV3mrpSBcwyCPrT9PtMsG4new3f1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296108; c=relaxed/simple;
	bh=MPdeHy2lVFimsy3digCUR+j22FPjWG7dyvTt4PLoYRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UABh6Da/aSF5VQ/QUJfBMQu1aHeCl17Kwq3Rk9yrjUbwrfIvyvB68sBMZ/+rid//ECvMH9MfjT8KGp+Nf8MBWzbdSzeTw8qaPzZVhmTmekh2H635yAQMVLUxOR5OuTLOVmfiDmfwo4x0t4V7X942Ze4sNF1Cfj8lZpFqTowW+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vwnnakwu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFCC1F000E9;
	Wed, 20 May 2026 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296107;
	bh=JijRQzudNvro19WmR1BiM/j6GTDozbHeZbHurvfJ+oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VwnnakwunTwi9W1WPVStVTVjxCwN7cWCKFXojbWKSR7DwUB4CvDyStuycvV5coFUi
	 7qNk3eAvBI/cslqTOCMqnS8RsxHbHa3QDPYHp3MHt1wWYcm8fjDC4s69fXWBD9PhTE
	 czFAqnrTKBatVlIxxsQTDcPnsRQquBKcUDdjKIvs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anna Schumaker <anna.schumkaer@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0674/1146] nfs/blocklayout: Fix compilation error (`make W=1`) in bl_write_pagelist()
Date: Wed, 20 May 2026 18:15:24 +0200
Message-ID: <20260520162203.441060680@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250708-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: CB83059514D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit f83c8dda456ce4863f346aa26d88efa276eda35d ]

Clang compiler is not happy about set but unused variable
(when dprintk() is no-op):

.../blocklayout/blocklayout.c:384:9: error: variable 'count' set but not used [-Werror,-Wunused-but-set-variable]

Remove a leftover from the previous cleanup.

Fixes: 3a6fd1f004fc ("pnfs/blocklayout: remove read-modify-write handling in bl_write_pagelist")
Acked-by: Anna Schumaker <anna.schumkaer@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/blocklayout/blocklayout.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index cb0a645aeb501..94e85ad9067e5 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -381,14 +381,13 @@ bl_write_pagelist(struct nfs_pgio_header *header, int sync)
 	sector_t isect, extent_length = 0;
 	struct parallel_io *par = NULL;
 	loff_t offset = header->args.offset;
-	size_t count = header->args.count;
 	struct page **pages = header->args.pages;
 	int pg_index = header->args.pgbase >> PAGE_SHIFT;
 	unsigned int pg_len;
 	struct blk_plug plug;
 	int i;
 
-	dprintk("%s enter, %zu@%lld\n", __func__, count, offset);
+	dprintk("%s enter, %u@%lld\n", __func__, header->args.count, offset);
 
 	/* At this point, header->page_aray is a (sequential) list of nfs_pages.
 	 * We want to write each, and if there is an error set pnfs_error
@@ -429,7 +428,6 @@ bl_write_pagelist(struct nfs_pgio_header *header, int sync)
 		}
 
 		offset += pg_len;
-		count -= pg_len;
 		isect += (pg_len >> SECTOR_SHIFT);
 		extent_length -= (pg_len >> SECTOR_SHIFT);
 	}
-- 
2.53.0




