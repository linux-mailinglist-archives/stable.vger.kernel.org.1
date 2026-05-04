Return-Path: <stable+bounces-243704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN7dDIWs+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:26:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B884BF63F
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBA6A3028C30
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892283DE44F;
	Mon,  4 May 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DCrjxb9w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4EE3DE450;
	Mon,  4 May 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904563; cv=none; b=C+oyawKPE7VECEsKcWS3DKQbPNFUG5aN1fBFvY8NV5K/4G04/61g7/3JmnCSvrsjTIIrANnAssS2FA7t33MItDmWIYsiZ4BVVLii+uxqdQekC+APf6yOT67czVg2KZ/PVt3lzUA1mquyOY3nt3/7OxSdkNXbJJXQQFqiTKsN9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904563; c=relaxed/simple;
	bh=JyWyk2YiKLXg9xy1lPJywczN4zTn8fuTFevqNIuHNYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkUnJ+5cI6hqmkQqzWPFlXZh4rPYFVWO1xHWwYZPyZ2YVMdjWPNFUHqeycdNA3NTVWyetIFy++zYXtivuLLD97+/SukqttjIP2E1tW7c/T8iwi5CTu3aRJCo49L+cFSpfWWZ6uZdMdKcK68ZmeERI1z22V++2eBWJ9+Iz6q4bKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DCrjxb9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CECC2BCB8;
	Mon,  4 May 2026 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904563;
	bh=JyWyk2YiKLXg9xy1lPJywczN4zTn8fuTFevqNIuHNYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCrjxb9wGuR/L7uCQlaye6L1doHKUW/urYtdhqDg5WWB0ZZvQnn0KQylG71w7L3md
	 4lQ6MtkTehwIVSoFK3rVA03MFLLu3XDfv+f/3w5qJD7wr9GPpRQBu0M75Cbln9tAyU
	 jzi9D6slmifchB5Fes8IcQXU/jLE/Cpe7ThRV6w4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ao Zhou <draw51280@163.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Allison Henderson <achender@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 087/215] net: rds: fix MR cleanup on copy error
Date: Mon,  4 May 2026 15:51:46 +0200
Message-ID: <20260504135133.337566732@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 61B884BF63F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243704-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,163.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,lzu.edu.cn:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ao Zhou <draw51280@163.com>

commit 8141a2dc70080eda1aedc0389ed2db2b292af5bd upstream.

__rds_rdma_map() hands sg/pages ownership to the transport after
get_mr() succeeds. If copying the generated cookie back to user space
fails after that point, the error path must not free those resources
again before dropping the MR reference.

Remove the duplicate unpin/free from the put_user() failure branch so
that MR teardown is handled only through the existing final cleanup
path.

Fixes: 0d4597c8c5ab ("net/rds: Track user mapped pages through special API")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ao Zhou <draw51280@163.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Allison Henderson <achender@kernel.org>
Link: https://patch.msgid.link/79c8ef73ec8e5844d71038983940cc2943099baf.1776764247.git.draw51280@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/rdma.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -326,10 +326,6 @@ static int __rds_rdma_map(struct rds_soc
 
 	if (args->cookie_addr &&
 	    put_user(cookie, (u64 __user *)(unsigned long)args->cookie_addr)) {
-		if (!need_odp) {
-			unpin_user_pages(pages, nr_pages);
-			kfree(sg);
-		}
 		ret = -EFAULT;
 		goto out;
 	}



