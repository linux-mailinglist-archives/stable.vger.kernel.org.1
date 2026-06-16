Return-Path: <stable+bounces-265084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JbmQHCKEMWqSlQUAu9opvQ
	(envelope-from <stable+bounces-265084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:13:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B3692DE5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:13:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xxmZZfPl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265084-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265084-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61BE331A89C1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B06477E21;
	Tue, 16 Jun 2026 17:03:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71D328610;
	Tue, 16 Jun 2026 17:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629393; cv=none; b=p4R4QaaUTQpDWXu6HOpC9//GDdkNUSHcsCJVKexQMFCXw0D98A3svyIe7ju8qNwvbPbwoZlKfM2tA4X+43g3tZcLreHZG6tpU2ZV9XVEp9I326Tw1HxtHq0dAtq/Jbygz5rE2WUPeDVUeTlQzko2+WjJYfXWRnwwpNhu3K6G9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629393; c=relaxed/simple;
	bh=1uRm54xE73AUE/i1r2inNg5uXiABvQaoLKE0/wSPTgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWqvRdqlwmvyy0ivSCxT6f5nd8nfcJ7MqgCJdbhB7uG0LojBryY8ELezWbBHkjdO0wDmJhpiQA1nrJpUXLyQvYI6UHCw6KTxmiwZ3cwWC0Ze/imDvZsZVHnfgf04rgXMtXuLod1Zt3B0TQxxTkjxXueSv05H6WwOjTqpUnnAX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xxmZZfPl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD5F1F000E9;
	Tue, 16 Jun 2026 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629391;
	bh=G6WKqt59AbRgPj/wX+OQBBmZfX+vjE6+pXR9vWSAAZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xxmZZfPlKtYIVT6bWqKM52mDcsRdLVAsCuwFGeUU4VavSXRCiqlkZvW1Jkp1S7v97
	 XKFL3gtQ1aEDVTrDmJM2/H+9vWUy7zId4kS4vw3MHjDsYECWUwh5hy1Zb8A4LcJaB3
	 M86VcovdiwXco/j5/zD/UMTiHwC1VJ61Y+JLQvrM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Allison Henderson <achender@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 276/452] rds: mark snapshot pages dirty in rds_info_getsockopt()
Date: Tue, 16 Jun 2026 20:28:23 +0530
Message-ID: <20260616145132.148085005@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265084-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:leitao@debian.org,m:achender@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D91B3692DE5

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 512db8267b73a220a64180d95ab5eebe7c4964a8 ]

rds_info_getsockopt() pins the destination user pages with FOLL_WRITE and
the RDS_INFO_* producers memcpy the snapshot into them through
kmap_atomic(). Because that copy goes through the kernel direct map, the
dirty bit on the user PTE is never set, so unpin_user_pages() releases the
pages without marking them dirty. A file-backed destination page can then
be reclaimed without writeback, silently discarding the copied data.

Use unpin_user_pages_dirty_lock() with make_dirty=true so the modified
pages are marked dirty before they are unpinned.

Fixes: a8c879a7ee98 ("RDS: Info and stats")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Allison Henderson <achender@kernel.org>
Link: https://patch.msgid.link/20260608-rds_fix-v1-1-006c88543408@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rds/info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/info.c b/net/rds/info.c
index b6b46a8214a0a5..b3ee5f8238c44d 100644
--- a/net/rds/info.c
+++ b/net/rds/info.c
@@ -235,7 +235,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 
 out:
 	if (pages)
-		unpin_user_pages(pages, nr_pages);
+		unpin_user_pages_dirty_lock(pages, nr_pages, true);
 	kfree(pages);
 
 	return ret;
-- 
2.53.0




