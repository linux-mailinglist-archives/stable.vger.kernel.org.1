Return-Path: <stable+bounces-252201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO4+KDEADmo95QUAu9opvQ
	(envelope-from <stable+bounces-252201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:40:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCE0596FA1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F7038E6727
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED63E95A4;
	Wed, 20 May 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UwldTLky"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DF3ED3B8;
	Wed, 20 May 2026 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300056; cv=none; b=YsAI8ogcrabNdPgzrsY5Ba6vRs0VlwVqpiLg2qPo1fwXfpFM3xUxK+PwWqnShHW7cfBkH4V/XIV1vjXoCQDUVTmq3/+G5q681xCMuNs9RDjRVDlRPK8bXVflkRxcQCjrNhp8FmAU1XSw9FCX5z+IpluJ2XrdiqrZGh3lfUzAKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300056; c=relaxed/simple;
	bh=XRkybAT4SSqWVme+2Bqdx4qib0I9frD6tvdpEX6FXeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7imumO0+Yt4pOdrVlySwFYQhLn7DGDh24jjly7tWJT5XfJZUwBLAtmGcUOtK8oSgYQsV0rj59jhhkojTQv+GeCoyPUppM1dr6Th0Dv0opwDEfNgD/9TrL9KLm29meXA3cWd127OHvAPIZecktfidGeXV5zis0hZUljLCwNyoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UwldTLky; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA571F000E9;
	Wed, 20 May 2026 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300055;
	bh=4L7jBQ0ZeWsNWhHZiQZijO3ovg31L8N9Ixc1cVL7kyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UwldTLkywJWo2ViY+zFvz1d62CEOfPg92v7+OWzB54hABmGNhu4a4vgeTbLyMjLhZ
	 2Ydx9BBdIsX3AkESavLjqvUeVTaTXSENKQsMHnM3lkL+bIOUjzM+D5ChZjMuThgx0U
	 hr5pZV6Iy/5F9XZM86DwCEKTVqHHhSDKR1Yw3Vsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyungjung Joo <jhj140711@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 004/666] fs/mbcache: cancel shrink work before destroying the cache
Date: Wed, 20 May 2026 18:13:35 +0200
Message-ID: <20260520162111.326029999@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-252201-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 0CCE0596FA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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




