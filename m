Return-Path: <stable+bounces-268015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WN2VOQ3kOmolKQgAu9opvQ
	(envelope-from <stable+bounces-268015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 21:52:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2996B9C97
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 21:52:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UVuAgQDm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268015-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268015-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BDC9301111D
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 19:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944733921CE;
	Tue, 23 Jun 2026 19:52:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364530BF4E
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 19:52:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244363; cv=none; b=fWRwC5HCzUBPxIJ8QcG8ZpXOgniyOA/6UZOIgca2D9kE9dqgro9X7oEN2chz0f92ZZnaMim4ZMYRjXmUilgouOlUsgCsZ+iTbIBDbonj6uXkrT0msthxFC+8VLnNc4HEALXWdobVEIUvaOOqQt3eu1m5US2+p+twKZamr8BjT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244363; c=relaxed/simple;
	bh=jpVy0QVc2BGEF8kHIQbOvoc1+4joSiGrA7UDy2tep8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWuuxXWPtVykzxpH30kwqdhXUUejPUP7ZQ5YH4K/HwObb/mfxuq48a0NXqkMJuFqhkv0CV+4kb2j2QwIaM9WtCgGtPUi1b3hp7bN/bUbyrt5CAOo2EZPShd8nAlpc4Xb9ndOqKLhHgmIxN8KmBZKT6UwSum5H0WrjPnwCpLYXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVuAgQDm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB951F000E9;
	Tue, 23 Jun 2026 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782244362;
	bh=SCtNyAccqIG1mBViTpaZCxe142RZfiD/rltBGNu9ZkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVuAgQDmITmoZZgLvFrP1XOZPFb8h36UaALS3Sm6Lm/XGu8xwakchM9y4S25zj8yC
	 BnhLZHqcDRKVu7SpaZv22drcrE1ZY4UalQwx9hju7ksIOpYubT0osMMaqiFXJ8XhK2
	 WBsInkpnVfaq/CCnL3prH9iPSkD42UGb/yC6a7EgZxjc57j31Zr/OiWhwfmCCfRPDf
	 hE0Vk3fcHhIKsJ3WgM2FaO9C2xA4FIwlG6qaNwGL1hhf1JwtBVGXQQuEbaeOl9WLi4
	 Zxc2pQfjeECe+RmMX/JdtHSqm9pkdTAvK80PFMtLtl1+U5YuzsXeV45TQ+fIhuyzpx
	 TfoFnh8ukZ2lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Lei Lu <llfamsec@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fuse: re-lock request before replacing page cache folio
Date: Tue, 23 Jun 2026 15:52:40 -0400
Message-ID: <20260623195240.1378610-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062231-impale-afar-8694@gregkh>
References: <2026062231-impale-afar-8694@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268015-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:joannelkoong@gmail.com,m:llfamsec@gmail.com,m:mszeredi@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E2996B9C97

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit a078484921052d0badd827fcc2770b5cfc1d4120 ]

fuse_try_move_folio() unlocks the request on entry but does not
re-lock it on the success path. This means fuse_chan_abort() can end the
request and free the fuse_io_args (eg fuse_readpages_end()) while the
subsequent copy chain logic after fuse_try_move_folio() accesses the
fuse_io_args, leading to use-after-free issues.

Fix this by calling lock_request() before replace_page_cache_folio().
This ensures the request is locked on the success path which will
prevent the fuse_io_args from being freed while the later copying logic
runs, and also ensures that the ap->folios[i]->mapping is never null
since ap->folios[i] will always point to the newfolio after
replace_page_cache_folio().

Fixes: ce534fb05292 ("fuse: allow splice to move pages")
Cc: stable@vger.kernel.org
Reported-by: Lei Lu <llfamsec@gmail.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 231b1c14b76778..618f3a3b1d8f65 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -845,6 +845,10 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (WARN_ON(PageMlocked(oldpage)))
 		goto out_fallback_unlock;
 
+	err = lock_request(cs->req);
+	if (err)
+		goto out_fallback_unlock;
+
 	replace_page_cache_page(oldpage, newpage);
 
 	get_page(newpage);
@@ -858,20 +862,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	 */
 	pipe_buf_release(cs->pipe, buf);
 
-	err = 0;
-	spin_lock(&cs->req->waitq.lock);
-	if (test_bit(FR_ABORTED, &cs->req->flags))
-		err = -ENOENT;
-	else
-		*pagep = newpage;
-	spin_unlock(&cs->req->waitq.lock);
-
-	if (err) {
-		unlock_page(newpage);
-		put_page(newpage);
-		goto out_put_old;
-	}
-
+	*pagep = newpage;
 	unlock_page(oldpage);
 	/* Drop ref for ap->pages[] array */
 	put_page(oldpage);
-- 
2.53.0


