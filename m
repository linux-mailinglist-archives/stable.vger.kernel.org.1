Return-Path: <stable+bounces-266323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jlvNAfGaMWouoAUAu9opvQ
	(envelope-from <stable+bounces-266323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:50:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD8D69481B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:50:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NNnUWI3G;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266323-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266323-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C29D304916E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1550247D93F;
	Tue, 16 Jun 2026 18:50:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B6A3D8100;
	Tue, 16 Jun 2026 18:50:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635821; cv=none; b=WwrVhluKdNdr+3I68ZzA7z5Nu4aKGRFE5jBB7S4eqMPbfxHczKgnee6W+C4K4x5WxR4Q2TNTwgBXzb3VWMNGrGkcKBJwhovWftLUpd6krKg1/XdYuqQLEEUiCoEFUNR0ELYVPUgFNeDuOw8N3ErG7qLCBUbGtVchk3cXu2CzecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635821; c=relaxed/simple;
	bh=UMZpHmV2RIx+xHr2BVDq8/nLKnoIaFzlWIpn25BBbIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFYdrw5wo68VNgp+z1G0vFk3kwBdc3X5rBCgu9w6v2MpvX0PEplrNImbSUuqV6NuSKmp7YeIM075ZTm/OlIl/zApvoXGNSF8xR89HeNNyIrhdOimeXUCajdp4ZSmdsp5js/EleDDS163gyh44KFz6wnhZKk6fKR7T2Y0ZktVGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNnUWI3G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A578C1F000E9;
	Tue, 16 Jun 2026 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635819;
	bh=ykNSYiRLyr9cy6Mgu/KqDhKACe4958Th0NUuHRkJORU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NNnUWI3GkL4yFO9JSmh6ccBeyRFPqryinZoknxZ7gsX70aKuNHrmR7YqWJnA2fqwa
	 stcOIcp0zvm/vQTrXUJg2rnA7iNhciQNmVsWniBTLcYfjBRehQ4wJj+k6tgf+95fm1
	 UuLBJmvbwWrLWduLJPLHwY4w7DjFPkWZcdTrgj7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com,
	Dong Chenchen <dongchenchen2@huawei.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Bjoern Doebel <doebel@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 120/342] page_pool: Fix use-after-free in page_pool_recycle_in_ring
Date: Tue, 16 Jun 2026 20:26:56 +0530
Message-ID: <20260616145053.801255804@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266323-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kuba@kernel.org,m:syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com,m:dongchenchen2@huawei.com,m:toke@redhat.com,m:almasrymina@google.com,m:doebel@amazon.de,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	TAGGED_RCPT(0.00)[stable,204a4382fcb3311f3858];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,msgid.link:url,appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,amazon.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CD8D69481B

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dong Chenchen <dongchenchen2@huawei.com>

[ Upstream commit 271683bb2cf32e5126c592b5d5e6a756fa374fd9 ]

syzbot reported a uaf in page_pool_recycle_in_ring:

BUG: KASAN: slab-use-after-free in lock_release+0x151/0xa30 kernel/locking/lockdep.c:5862
Read of size 8 at addr ffff8880286045a0 by task syz.0.284/6943

root cause is:

page_pool_recycle_in_ring
  ptr_ring_produce
    spin_lock(&r->producer_lock);
    WRITE_ONCE(r->queue[r->producer++], ptr)
      //recycle last page to pool
                                    page_pool_release
                                      page_pool_scrub
                                        page_pool_empty_ring
                                          ptr_ring_consume
                                          page_pool_return_page  //release all page
                                      __page_pool_destroy
                                         free_percpu(pool->recycle_stats);
                                         free(pool) //free

     spin_unlock(&r->producer_lock); //pool->ring uaf read
  recycle_stat_inc(pool, ring);

page_pool can be free while page pool recycle the last page in ring.
Add producer-lock barrier to page_pool_release to prevent the page
pool from being free before all pages have been recycled.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20250513083123.3514193-1-dongchenchen2@huawei.com
Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
Reported-by: syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=204a4382fcb3311f3858
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20250527114152.3119109-1-dongchenchen2@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[v5.10: introduced page_pool_producer_lock/unlock helpers inline since
 prerequisite commit 368d3cb406cd ("page_pool: fix inconsistency for
 page_pool_ring_[un]lock()") depends on page_pool_put_page_bulk which
 does not exist in 5.10; used in_serving_softirq() per 5.10 convention;
 kept struct page * API (no netmem_ref); dropped recycle_stat_inc change
 as page pool stats do not exist in this tree]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Assisted-by: Claude:claude-opus-4-6-v1
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/page_pool.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 15ad99330bb9b1..09d98fcf669f2c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -318,16 +318,39 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 	 */
 }
 
+static bool page_pool_producer_lock(struct page_pool *pool)
+	__acquires(&pool->ring.producer_lock)
+{
+	bool in_softirq = in_serving_softirq();
+
+	if (in_softirq)
+		spin_lock(&pool->ring.producer_lock);
+	else
+		spin_lock_bh(&pool->ring.producer_lock);
+
+	return in_softirq;
+}
+
+static void page_pool_producer_unlock(struct page_pool *pool,
+				      bool in_softirq)
+	__releases(&pool->ring.producer_lock)
+{
+	if (in_softirq)
+		spin_unlock(&pool->ring.producer_lock);
+	else
+		spin_unlock_bh(&pool->ring.producer_lock);
+}
+
 static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
 {
-	int ret;
+	bool in_softirq, ret;
+
 	/* BH protection not needed if current is serving softirq */
-	if (in_serving_softirq())
-		ret = ptr_ring_produce(&pool->ring, page);
-	else
-		ret = ptr_ring_produce_bh(&pool->ring, page);
+	in_softirq = page_pool_producer_lock(pool);
+	ret = !__ptr_ring_produce(&pool->ring, page);
+	page_pool_producer_unlock(pool, in_softirq);
 
-	return (ret == 0) ? true : false;
+	return ret;
 }
 
 /* Only allow direct recycling in special circumstances, into the
@@ -464,10 +487,14 @@ static void page_pool_scrub(struct page_pool *pool)
 
 static int page_pool_release(struct page_pool *pool)
 {
+	bool in_softirq;
 	int inflight;
 
 	page_pool_scrub(pool);
 	inflight = page_pool_inflight(pool);
+	/* Acquire producer lock to make sure producers have exited. */
+	in_softirq = page_pool_producer_lock(pool);
+	page_pool_producer_unlock(pool, in_softirq);
 	if (!inflight)
 		page_pool_free(pool);
 
-- 
2.53.0




