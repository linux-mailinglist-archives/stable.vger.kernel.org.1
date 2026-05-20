Return-Path: <stable+bounces-251228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG4fBcvyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E49FE594667
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3683A305399E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37035C1A0;
	Wed, 20 May 2026 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s4rCFKL6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840B33D4E9;
	Wed, 20 May 2026 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297434; cv=none; b=srdEHorkT/QKMJj62bIS+1BRZbM/AuR3V0chaZU09+kGIkngxoiobRoQyEEeUCnmYejR7OeK0UGU7tmIV8JMF5iDoECslXYedbyv2b+vdnAEtSPTYQqZlw8fzJsBzHQQEGPRyLtFHWhSjJB07yNOBVaJYGKknDP2+FV7ifFZyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297434; c=relaxed/simple;
	bh=9OwUhgg+3CUIgEiISb2XdPsq0KepqQ37VV2c+PSBENw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=squFRhKnQ1RYlEtAo4dRb1h5oiEnTlozbqFaWeS5HwBhLQ9+0SS7ZFIlC4GOiGgwt0xnNETAXW0T46Z5KzxrEN+VTf448M2oWgH4Jp5O5c8cSmmjZctwMiCnfTigPC5zR20eWMtcQhEAsD0pmiW5KcoDxxll2Zx2c+S1SCX1B1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s4rCFKL6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1331F000E9;
	Wed, 20 May 2026 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297433;
	bh=7IvGxWyNWsiu3tOBHIyhYDdCCX5hTcLeUOcnwF7xpJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s4rCFKL6xKSYuqBwVlJ9AaSPSqgO4nQKGqPdb+UbTNXUcAW+n73K+fTwKmrWkDszp
	 dlSgeATnY0GA9e0Jj66HrnEL2cRQdVSYNMruAGUTStJPe0fWcLvD3pe8NOAYKWwkdE
	 sbJ+TpaDtCHZ6xZo+7sfYt/6c9SL4XQ+0miur2g8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyungjung Joo <jhj140711@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 003/957] fs/mbcache: cancel shrink work before destroying the cache
Date: Wed, 20 May 2026 18:08:06 +0200
Message-ID: <20260520162134.633525500@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251228-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E49FE594667
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: HyungJung Joo <jhj140711@gmail.com>

[ Upstream commit d227786ab1119669df4dc333a61510c52047cce4 ]

mb_cache_destroy() calls shrinker_free() and then frees all cache
entries and the cache itself, but it does not cancel the pending
c_shrink_work work item first.

If mb_cache_entry_create() schedules c_shrink_work via schedule_work()
and the work item is still pending or running when mb_cache_destroy()
runs, mb_cache_shrink_worker() will access the cache after its memory
has been freed, causing a use-after-free.

This is only reachable by a privileged user (root or CAP_SYS_ADMIN)
who can trigger the last put of a mounted ext2/ext4/ocfs2 filesystem.

Cancel the work item with cancel_work_sync() before calling
shrinker_free(), ensuring the worker has finished and will not be
rescheduled before the cache is torn down.

Fixes: c2f3140fe2ec ("mbcache2: limit cache size")
Signed-off-by: Hyungjung Joo <jhj140711@gmail.com>
Link: https://patch.msgid.link/20260317054556.1821600-1-jhj140711@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/mbcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index e60a840999aa9..90b0564c62d0b 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -408,6 +408,7 @@ void mb_cache_destroy(struct mb_cache *cache)
 {
 	struct mb_cache_entry *entry, *next;
 
+	cancel_work_sync(&cache->c_shrink_work);
 	shrinker_free(cache->c_shrink);
 
 	/*
-- 
2.53.0




