Return-Path: <stable+bounces-271292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qp9dANqkRmqMawsAu9opvQ
	(envelope-from <stable+bounces-271292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:50:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E56FBA94
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="TOOKKp/q";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271292-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271292-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C535332BF4B4
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62D833A6F2;
	Thu,  2 Jul 2026 16:52:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DACA33689F;
	Thu,  2 Jul 2026 16:52:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011166; cv=none; b=gBsnHUbVxZZmm4xRTiU//nyF1uU9CAjbGoCHQbap81envM8Yq6zBwu+AzPAFmTFwhOGNP3nRy3I5n0BJvGGeECKpq4FDVi76te36tRiLahcJd27m71gCmtHuE0po8TlMm1Fl0RQIAtLp1gkC/IJiO7F5GXDkVv97Mew5iNKd8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011166; c=relaxed/simple;
	bh=6NQEhYhKR+jcYWTptUKxA4HyvQUxHlzXcS0ino7WPYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfiT3q6Ifuh4z0dvl0iM1SWGM2rsDVz86Brvq/YZ90MnH03iYIoDinTlf0Ytbe2hVDAA+esocZLb7fy3+D4IPGC+sM/nk15o/Orzph4OVUQoROrEQw9Z96yz4d/nbo2QBiTz8p3rY57TELv/MYcaQAFLD+YtV8du66/zcfbiNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TOOKKp/q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1301F000E9;
	Thu,  2 Jul 2026 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011165;
	bh=q7nWwbFyQoitSWRmMt6kYeRBbDvXtMVGUF/Lw2qV9lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TOOKKp/qtdNWLUw1pZ4J6BQps4qcpJ5zPCVX4TyfORywilorytS4Ljk994HGfW6WW
	 hM/JBrZb7L85mbm3TB39zdRQhOMyF+BEYs0Y7iCvK/qSpPT8V1GICx0Bc7ySxMu6aD
	 jzPBFXl7u6PPPl+Sd1d5OMT7MBewvnr8jl0d56/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jay Shin <jaeshin@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>,
	coregee2000@gmail.com,
	Ming Lei <ming.lei@redhat.com>,
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 147/175] blk-cgroup: fix UAF in __blkcg_rstat_flush()
Date: Thu,  2 Jul 2026 18:20:48 +0200
Message-ID: <20260702155118.901771463@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,kernel.org,gmail.com,linux.dev,kernel.dk];
	TAGGED_FROM(0.00)[bounces-271292-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jaeshin@redhat.com,m:tj@kernel.org,m:longman@redhat.com,m:coregee2000@gmail.com,m:ming.lei@redhat.com,m:jose.fernandez@linux.dev,m:axboe@kernel.dk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel.dk:email,msgid.link:url,linux.dev:email,suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 341E56FBA94

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Koutný <mkoutny@suse.com>

commit 0ab5ee5a1badb58cbb2242617cb01a4972b1f2a2 upstream.

When multiple blkgs in the same blkcg are released concurrently,
a use-after-free can occur. The race happens when one blkg's
__blkcg_rstat_flush() removes another blkg's iostat entries via
llist_del_all(). The second blkg sees an empty list and proceeds
to free itself while the first is still iterating over its entries.

Move the flush from __blkg_release() (RCU callback) to blkg_release()
(before call_rcu). This ensures the RCU grace period waits for any
concurrent flush's rcu_read_lock() section to complete before freeing.

Cc: stable@vger.kernel.org
Cc: Jay Shin <jaeshin@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Fixes: 20cb1c2fb756 ("blk-cgroup: Flush stats before releasing blkcg_gq")
Reported-by: coregee2000@gmail.com
Closes: https://lore.kernel.org/linux-block/CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Link: https://patch.msgid.link/20260205155425.342084-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-cgroup.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -170,20 +170,10 @@ static void blkg_free(struct blkcg_gq *b
 static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
-	struct blkcg *blkcg = blkg->blkcg;
-	int cpu;
 
 #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
 	WARN_ON(!bio_list_empty(&blkg->async_bios));
 #endif
-	/*
-	 * Flush all the non-empty percpu lockless lists before releasing
-	 * us, given these stat belongs to us.
-	 *
-	 * blkg_stat_lock is for serializing blkg stat update
-	 */
-	for_each_possible_cpu(cpu)
-		__blkcg_rstat_flush(blkcg, cpu);
 
 	/* release the blkcg and parent blkg refs this blkg has been holding */
 	css_put(&blkg->blkcg->css);
@@ -201,6 +191,17 @@ static void __blkg_release(struct rcu_he
 static void blkg_release(struct percpu_ref *ref)
 {
 	struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);
+	struct blkcg *blkcg = blkg->blkcg;
+	int cpu;
+
+	/*
+	 * Flush all the non-empty percpu lockless lists before releasing
+	 * us, given these stat belongs to us.
+	 *
+	 * blkg_stat_lock is for serializing blkg stat update
+	 */
+	for_each_possible_cpu(cpu)
+		__blkcg_rstat_flush(blkcg, cpu);
 
 	call_rcu(&blkg->rcu_head, __blkg_release);
 }



