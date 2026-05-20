Return-Path: <stable+bounces-251599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAj4BCXyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:40:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFE559443C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10E38312B76A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23A3A3825;
	Wed, 20 May 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ly13JKSj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E48369D7E;
	Wed, 20 May 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298400; cv=none; b=Ppyt7ZlhumsyiL18XW3kf8lGV2/FBnR8izKU5u580p1C9V1ii/6Z4y0Lh+qdwLPoxYANsWQABP/Qhj5sN+SOI1kt7+VKqDiM7cK8H4cfFZspQo4Bary7/LhWIGLXa8Gm6F9YTCd5YdeuSycXbG1/DWPZ7MdgPNR9Xsxpwx8UVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298400; c=relaxed/simple;
	bh=uEiBYne8AqzX11+RmBuyW13DIAP8J6WhLbRYMROOjWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca8r5pk+LW7vC5lPi4kYh0ap49ubWaNfd+xO9KreXIvwO3AP/6/V8fIY8ZqrFWEZb3vco+VB3jYYp0vAN02wpRcb88Qk37s1n4IdA1a0VPEBEI1WWcQqIWu+zKP08ReuwS63TuTPInC4FPdTklPSmI7F/ZxAEopwNACHEuQIbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ly13JKSj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A471F000E9;
	Wed, 20 May 2026 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298399;
	bh=UX3iAwtyv6RXDO8m3GtDgN9pArH9QBa3xF6/Nw65Hg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ly13JKSjsaEl0U11BWlRwhAYCrzVqlBUVKd1WXeEGbO/b98/GT0X+dXQYcqJJEunO
	 3WOdSfLyouD8wqFemdQAzt7YXpCyDwz64NDZSGPSp+rK1hZBzLfj8NvznkAQSO5ZfM
	 U1XwlXsdf4VkLZ1AGD2jm4BkjOCBBu0BBIJyGpso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 354/957] gfs2: less aggressive low-memory log flushing
Date: Wed, 20 May 2026 18:13:57 +0200
Message-ID: <20260520162142.206802549@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251599-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BCFE559443C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 7288185ce87ec70133b7bc3b694b0f74bf46a0ee ]

It turns out that for some workloads, the fix in commit b74cd55aa9a9d
("gfs2: low-memory forced flush fixes") causes the number of forced log
flushes to increase to a degree that the overall filesystem performance
drops significantly.  Address that by forcing a log flush only when
gfs2_writepages cannot make any progress rather than when it cannot make
"enough" progress.

Fixes: b74cd55aa9a9d ("gfs2: low-memory forced flush fixes")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/aops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 47d74afd63ac9..eafe0488b10d4 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -159,6 +159,7 @@ static int gfs2_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
 	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
+	long initial_nr_to_write = wbc->nr_to_write;
 	struct iomap_writepage_ctx wpc = {
 		.inode		= mapping->host,
 		.wbc		= wbc,
@@ -167,13 +168,13 @@ static int gfs2_writepages(struct address_space *mapping,
 	int ret;
 
 	/*
-	 * Even if we didn't write enough pages here, we might still be holding
+	 * Even if we didn't write any pages here, we might still be holding
 	 * dirty pages in the ail. We forcibly flush the ail because we don't
 	 * want balance_dirty_pages() to loop indefinitely trying to write out
 	 * pages held in the ail that it can't find.
 	 */
 	ret = iomap_writepages(&wpc);
-	if (ret == 0 && wbc->nr_to_write > 0)
+	if (ret == 0 && wbc->nr_to_write == initial_nr_to_write)
 		set_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
 	return ret;
 }
-- 
2.53.0




