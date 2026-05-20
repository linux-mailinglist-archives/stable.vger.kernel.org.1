Return-Path: <stable+bounces-250650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOX+BSj1DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:53:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 987F8594DAF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1235A314DF14
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C436A352;
	Wed, 20 May 2026 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EiXyRPYV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091834216C;
	Wed, 20 May 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295964; cv=none; b=E7aRbQvvx6eCCJ8ZuKWXe8CuQnnGJp/RFy7VK39rVCp2q8LcgCd3YL9LuZCwmGzGodk20l5tALQSqS1JNCplXAghmx3zWBDcrrUPfAk9EGIUKZjU2kR5pfdKqmA803b511Rx5Rmd0CaeAldaqsBHoUnCgZpS4XVB4g8/hHba6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295964; c=relaxed/simple;
	bh=sdn621/DKpaig8m/n+nzHoGJ8Rx8NaekHPA+mooyYII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVTXHHaRD0iuM/9B+chKZTmJbaR5iPmtgnh4tskOqzrXPA4AaVzKVehaGwPKw8UYU+3eQOLP0GnvNtYz/WdMIYsSL4yHwCh6bPtK1Xu9qHKiKEnGLL9cvLJov1E+2bLK3ea6itXOdnIQ8U9oF8CinrW8fXm/YnuHhfBVKMsjGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EiXyRPYV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C931F000E9;
	Wed, 20 May 2026 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295962;
	bh=s3yhkyL5ESWBRFRB2F0ftY5i8dOqijlcBLNnPNTmIVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EiXyRPYVvk0HjIbejAH2lKfGzzhhDPsRTMIXkXPEqmqyrJCRRPI1ZyosG9rO7wc2k
	 0vVMnDjN5Us135yEqyWHibKe9AVS3x0YpvhtSpBpyrNnhhA+sQ1lVy4XyGLo139w3X
	 39xYyTWVGuZRJjWcFqxc1FSvWcCrvFaxO+Go7keI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Puranjay Mohan <puranjay@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0620/1146] bpf: Validate node_id in arena_alloc_pages()
Date: Wed, 20 May 2026 18:14:30 +0200
Message-ID: <20260520162202.217568853@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250650-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,etsalapatis.com:email]
X-Rspamd-Queue-Id: 987F8594DAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Puranjay Mohan <puranjay@kernel.org>

[ Upstream commit 2845989f2ebaf7848e4eccf9a779daf3156ea0a5 ]

arena_alloc_pages() accepts a plain int node_id and forwards it through
the entire allocation chain without any bounds checking.

Validate node_id before passing it down the allocation chain in
arena_alloc_pages().

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Link: https://lore.kernel.org/r/20260417152135.1383754-1-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/arena.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 9c68c9b0b24ad..523c3a61063bf 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -562,6 +562,10 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	u32 uaddr32;
 	int ret, i;
 
+	if (node_id != NUMA_NO_NODE &&
+	    ((unsigned int)node_id >= nr_node_ids || !node_online(node_id)))
+		return 0;
+
 	if (page_cnt > page_cnt_max)
 		return 0;
 
-- 
2.53.0




