Return-Path: <stable+bounces-125171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496B5A690D0
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E40188662F
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E2B20B808;
	Wed, 19 Mar 2025 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S6rqk/SS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49351DEFD9;
	Wed, 19 Mar 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395003; cv=none; b=sKsuCqMbZFAfll9BRmlCcpxI1CD8JnQ0RD1op54VvfzKpMbR8sQA5zMU1zZAHQgOOPsGIymhy7ze2e+xh6Yks0ES/AZrxPDZonJdmFSKW70/vYQc6EN5zz3YO7Kp3D+ihovVY6YxPH/kB8naaClZZFD4UJldy14zzoXNcFaGRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395003; c=relaxed/simple;
	bh=1C3wBngThNTroShwA9O+t+uk51Qo12yR24LwF28KI/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8EpE+NHIxBPdFAu3EbCbMk8vat9HdDbIxivLK0LC3QZI1rUovh686fCdulV0dTHb3kGFPw6uPHRRT0j8AqxXqOlvWijNWupQ0rExU9i73wbfdlXHf+3Gkt1FPoAD4zpxGp3OUq4o7WshCa7B/ZN9rRrsGqy21KttQ+b1XCW6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S6rqk/SS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C9BC4CEE4;
	Wed, 19 Mar 2025 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395003;
	bh=1C3wBngThNTroShwA9O+t+uk51Qo12yR24LwF28KI/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6rqk/SSkKY/PXbfq5DObDyF5foMeEACCDQDbriwluglXGK1SBKx7FrrcGZkkCnuf
	 WGlI42wlULCbI4JH0U248GEjKoynxyXP1xti7ltd8Br8jIssf1q3pO+/xW0HObVVF6
	 hsbO8cFr46UHgQgwmpipIc4QIJ10xKSXGxcauwhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicklas Bo Jensen <njensen@akamai.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 011/231] netfilter: nf_conncount: garbage collection is not skipped when jiffies wrap around
Date: Wed, 19 Mar 2025 07:28:24 -0700
Message-ID: <20250319143027.139001998@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicklas Bo Jensen <njensen@akamai.com>

[ Upstream commit df08c94baafb001de6cf44bb7098bb557f36c335 ]

nf_conncount is supposed to skip garbage collection if it has already
run garbage collection in the same jiffy. Unfortunately, this is broken
when jiffies wrap around which this patch fixes.

The problem is that last_gc in the nf_conncount_list struct is an u32,
but jiffies is an unsigned long which is 8 bytes on my systems. When
those two are compared it only works until last_gc wraps around.

See bug report: https://bugzilla.netfilter.org/show_bug.cgi?id=1778
for more details.

Fixes: d265929930e2 ("netfilter: nf_conncount: reduce unnecessary GC")
Signed-off-by: Nicklas Bo Jensen <njensen@akamai.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conncount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 4890af4dc263f..ebe38ed2e6f4f 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -132,7 +132,7 @@ static int __nf_conncount_add(struct net *net,
 	struct nf_conn *found_ct;
 	unsigned int collect = 0;
 
-	if (time_is_after_eq_jiffies((unsigned long)list->last_gc))
+	if ((u32)jiffies == list->last_gc)
 		goto add_new_node;
 
 	/* check the saved connections */
@@ -234,7 +234,7 @@ bool nf_conncount_gc_list(struct net *net,
 	bool ret = false;
 
 	/* don't bother if we just did GC */
-	if (time_is_after_eq_jiffies((unsigned long)READ_ONCE(list->last_gc)))
+	if ((u32)jiffies == READ_ONCE(list->last_gc))
 		return false;
 
 	/* don't bother if other cpu is already doing GC */
-- 
2.39.5




