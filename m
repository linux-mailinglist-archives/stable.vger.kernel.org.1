Return-Path: <stable+bounces-239975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IALhKYBz5mnKwgEAu9opvQ
	(envelope-from <stable+bounces-239975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:42:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D3432FED
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C95430CA93F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF333AA510;
	Mon, 20 Apr 2026 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwgrtnVl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBB3AA1BD;
	Mon, 20 Apr 2026 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708636; cv=none; b=knTSi7SZfXbOwefNXXfy0pp5txhOLS7F3phIUNC2F6Ui7dWwir89HFOLuy87AbOgI1Xmb40Nwb8JuV9V+48mFmsfzhxy0wMYAPxij8jh+4MMMQfkMDPfiCk2HTDKKYrtwJJVrxPAuCMOt5hGps4fC8PJIz+cbFBBQd4qXTVU7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708636; c=relaxed/simple;
	bh=gqGC/kFvTHGn9tLIUxI543db1kmdHoUs0kMugEBuba4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YRLJKO3PT76ppl7Sn5aA2dIFBDgPGsobg71DLtV+t1p7EH3+m/AFLujVE3i7L77l1mOiRe+l3ulwRbK7yvW0n0Gk9PDmnhRLwlseJwOXZbKJWhEy9BXNG5+5b+XnGKhWWWBtD5vs9JGJGZmE7jbzlxVbLgcD4m7mxJzacLKQcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwgrtnVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010E6C2BCB0;
	Mon, 20 Apr 2026 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708636;
	bh=gqGC/kFvTHGn9tLIUxI543db1kmdHoUs0kMugEBuba4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=jwgrtnVlz63Vfue65WoLp2OfBMyPch1CFdt+6zUfsCAadymL7ipYmcKBRvUg85DAL
	 fuR9hHP6s3L/oEB7cRotrWDDUk1HCUyekWTij9z06DYnRF/sj1ehThZ/YNZ8tCJJl3
	 VKGohiSi0SFR2+txVpknMOgZ2uzkkMVw2iQcgZyvDYpG0YC4QINmssiiWL3CmiqN1/
	 7m5L7wob0zhndkUtMbSYlGFMvbjqu0i0YJgbZFCUynhIJh2moiPe8CV+Y7r/kYGZpj
	 2/mCgGNRYsiheBPpSdvxe+p02sBqI+nCrL2A5LFJyDumL9Ge0JCW7k7vFSoMLSuW1f
	 XzoGUPKC1JYRg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1wEt6a-00000006nIJ-1QQg;
	Mon, 20 Apr 2026 14:12:20 -0400
Message-ID: <20260420181220.197994575@kernel.org>
User-Agent: quilt/0.69
Date: Mon, 20 Apr 2026 14:11:52 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [for-linus][PATCH 1/2] eventfs: Use list_add_tail_rcu() for SRCU-protected children list
References: <20260420181151.771404678@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239975-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Queue-Id: 2A5D3432FED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Carlier <devnexen@gmail.com>

Commit d2603279c7d6 ("eventfs: Use list_del_rcu() for SRCU protected
list variable") converted the removal side to pair with the
list_for_each_entry_srcu() walker in eventfs_iterate(). The insertion
in eventfs_create_dir() was left as a plain list_add_tail(), which on
weakly-ordered architectures can expose a new entry to the SRCU reader
before its list pointers and fields are observable.

Use list_add_tail_rcu() so the publication pairs with the existing
list_del_rcu() and list_for_each_entry_srcu().

Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260418152251.199343-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 81df94038f2e..8dd554508828 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -706,7 +706,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	scoped_guard(mutex, &eventfs_mutex) {
 		if (!parent->is_freed)
-			list_add_tail(&ei->list, &parent->children);
+			list_add_tail_rcu(&ei->list, &parent->children);
 	}
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-- 
2.51.0



