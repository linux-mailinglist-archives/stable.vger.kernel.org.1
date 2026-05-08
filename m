Return-Path: <stable+bounces-244811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH0NKU81/mnYnwAAu9opvQ
	(envelope-from <stable+bounces-244811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:11:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DB74FAFC6
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFBCD3033D39
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 19:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC6A308F26;
	Fri,  8 May 2026 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgMI8J9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20761A9F8C
	for <stable@vger.kernel.org>; Fri,  8 May 2026 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267454; cv=none; b=Y8E14Accm22tHhX3YVS9Dc2e1QqtE4Yijr2dwPRLhngkWgBTWHlCKE/iu/+uu95n0ysi4DTJ4QlQ+FS70wETVvu70PGuf5JYwSCmwn52bCAu7tx0ElrubnUlSVsDa2xUMbrSkxgN2Pccl0rbJEFXPbBaz5MNAbqJMhG4SkkxEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267454; c=relaxed/simple;
	bh=IxFWhosczW10OUNTEtwlxmZ+VftMaDSQNbEARzKVXbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Du0N8zEf+9yod0ZumWKEEm8bfjYDBKOocyg7fGgyMLJeAFOrl4S5Kpt0sv/jMO0EOemHNs0IE/0wUCGskeVU9hOQGVwCIqA2YrJiQvtkEpFKO2LDLF84ncjpl7Zfo3kKHf9coX3KFsJcNm5zdOVOzJpejVxubnTHcG0qjQeyimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgMI8J9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D97BC2BCC7;
	Fri,  8 May 2026 19:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778267454;
	bh=IxFWhosczW10OUNTEtwlxmZ+VftMaDSQNbEARzKVXbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgMI8J9r0Q3mcH94SzHJrLlJ04iKib1/bWe3D4uSZBfMlaIOpUaMvssEYpEx8t2XE
	 p/F7tZT0iTcE5C7xAraLbPezYQClhxYUgeKT9Vdf6syOqPaeOpHllgQQ6LHFctdcZz
	 EjRrO1LXniBaFIpM52+s6gIwSfPOfFyCoe8Z1W7fVuotItXvbxYoicHiqQznhpC7Dk
	 yetTdiC63/4vFD0UwMr0jhkg9V7c3B99eoZ1ZbIjJiluYCkQ73sLlTdG2MDrDnaFnT
	 8YOWAEd1+t1UwMg9a459nJopW57s2N5ZhOGmlv3HzUdZB59F8U63SnmaI1D7o0hF0P
	 tOYLWDvW/g/4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	chenyichong <chenyichong@uniontech.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/vmalloc: take vmap_purge_lock in shrinker
Date: Fri,  8 May 2026 15:10:50 -0400
Message-ID: <20260508191051.1831166-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050349-operation-curled-2359@gregkh>
References: <2026050349-operation-curled-2359@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 09DB74FAFC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,uniontech.com,linux-foundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244811-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:email,linux-foundation.org:email]
X-Rspamd-Action: no action

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

[ Upstream commit ec05f51f1e65bce95528543eb73fda56fd201d94 ]

decay_va_pool_node() can be invoked concurrently from two paths:
__purge_vmap_area_lazy() when pools are being purged, and the shrinker via
vmap_node_shrink_scan().

However, decay_va_pool_node() is not safe to run concurrently, and the
shrinker path currently lacks serialization, leading to races and possible
leaks.

Protect decay_va_pool_node() by taking vmap_purge_lock in the shrinker
path to ensure serialization with purge users.

Link: https://lore.kernel.org/20260413192646.14683-1-urezki@gmail.com
Fixes: 7679ba6b36db ("mm: vmalloc: add a shrinker to drain vmap pools")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Baoquan He <baoquan.he@linux.dev>
Cc: chenyichong <chenyichong@uniontech.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ kept index-based loop instead of for_each_vmap_node() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1d2262fb54185..d4a42980b4d02 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -5204,6 +5204,7 @@ vmap_node_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int i;
 
+	guard(mutex)(&vmap_purge_lock);
 	for (i = 0; i < nr_vmap_nodes; i++)
 		decay_va_pool_node(&vmap_nodes[i], true);
 
-- 
2.53.0


