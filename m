Return-Path: <stable+bounces-226776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FiOL3KRuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:37:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB782AFE50
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08637307C369
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CE137AA6B;
	Tue, 17 Mar 2026 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W0jZL+yk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE337700A;
	Tue, 17 Mar 2026 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768154; cv=none; b=TG5M3gdFs8akBBRVrU1NcdIUiGMrbTknqgJmR75btA/fv9/aevX5j6azKl4cfTC5HpI5Nx71K35XRPu3xhL94iw5T4n5N0z8FZHoDfxDOVOcB+zaA52IeMccGQpmQsZvNIoOhxbE/G0rOV9CflC/BqZqHcKvw1MXs9+jfszBVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768154; c=relaxed/simple;
	bh=F3nnUwJiWCovbHJZCof5gTkrNMze5BCWQdF1Qx+yqZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeT4OLdY/O3qgwvDVnep0yGOVB60qaNS2+o0YcJq8h/ZwYQZhtSHusafK+hkBa6A1a5MHMchlqjmtZahHv7fQrCaNJVQAn88hJawdrAAzZiBNZgr9YjCqqUvY3PlbSHS/XCzX0HuJEIc+/hPM4+3FeAWmEXoYz+3jMHQDt6WAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W0jZL+yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB83C2BC86;
	Tue, 17 Mar 2026 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768154;
	bh=F3nnUwJiWCovbHJZCof5gTkrNMze5BCWQdF1Qx+yqZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0jZL+ykK/DNlRTxhMbjqDZq4eivzwYS5rU5/uEf9L8ePSL9oqgs20Q9IaKw8ujBC
	 cjlrLT9NM40HcERcdJtGKbDPeYs1wHKIn0E8icc/Ytvb6/hmQbGor1DB7NqSZk7+2y
	 UrNy41yfMDC69lEzkDi+Oxspdqkud9qdUatX2qt0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hao Li <hao.li@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Vlastimil Babka <vbabka@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 241/333] memcg: fix slab accounting in refill_obj_stock() trylock path
Date: Tue, 17 Mar 2026 17:34:30 +0100
Message-ID: <20260317163008.302020337@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226776-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,linux-foundation.org:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: BDB782AFE50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Li <hao.li@linux.dev>

commit dccd5ee2625d50239510bcd73ed78559005e00a3 upstream.

In the trylock path of refill_obj_stock(), mod_objcg_mlstate() should use
the real alloc/free bytes (i.e., nr_acct) for accounting, rather than
nr_bytes.

The user-visible impact is that the NR_SLAB_RECLAIMABLE_B and
NR_SLAB_UNRECLAIMABLE_B stats can end up being incorrect.

For example, if a user allocates a 6144-byte object, then before this
fix efill_obj_stock() calls mod_objcg_mlstate(..., nr_bytes=2048), even
though it should account for 6144 bytes (i.e., nr_acct).

When the user later frees the same object with kfree(),
refill_obj_stock() calls mod_objcg_mlstate(..., nr_bytes=6144).  This
ends up adding 6144 to the stats, but it should be applying -6144
(i.e., nr_acct) since the object is being freed.

Link: https://lkml.kernel.org/r/20260226115145.62903-1-hao.li@linux.dev
Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
Signed-off-by: Hao Li <hao.li@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3028,7 +3028,7 @@ static void refill_obj_stock(struct obj_
 
 	if (!local_trylock(&obj_stock.lock)) {
 		if (pgdat)
-			mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
+			mod_objcg_mlstate(objcg, pgdat, idx, nr_acct);
 		nr_pages = nr_bytes >> PAGE_SHIFT;
 		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
 		atomic_add(nr_bytes, &objcg->nr_charged_bytes);



