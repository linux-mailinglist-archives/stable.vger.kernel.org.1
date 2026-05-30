Return-Path: <stable+bounces-257826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HXaaLAIfG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:31:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A7660FD9E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBF98300E291
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131DA349CCF;
	Sat, 30 May 2026 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eYLcZJ/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9823403F9;
	Sat, 30 May 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162299; cv=none; b=MLzX84EV2/ShM4X6odkWlm6M7uqVRv32EpHSATO590n9yITDZIwoaCc6J1xv576yZFvz/tI25MSV6qShV1Ob1mDQWobmcTsaP+OS9YwU4bmpaYsEwz9Rrnj4JX684HF60N6w6FMVn2EnyyAkVnfj2tOLSZm1Q3ywMuoBHoyWR7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162299; c=relaxed/simple;
	bh=u68KilQYUnyf2HH8P70VHdHzN+dbvY9kHKz/mHeiTus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzvsTpd7HMY9tRQH+5HyPg1JdUuwQHcQaFQjqzHmGyppOtbqxYd/6LntqaXubafWG/z5nIC6rgpI4PltixHZM5j6aFvalCM6iMl7NGcEbf4ErmMsvM4QkoVWsKjngTC8v81FVZ5snaBE/ZgLuyXo44oyAVqmKuCJmRsxYvh0TVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eYLcZJ/7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F4F1F00893;
	Sat, 30 May 2026 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162298;
	bh=FD5q1Mai6UgvL8WwvJv4I5X4JpdT3oMGeS40F1PWsow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eYLcZJ/7Lr1+ojuoEzSDm/yLc4LRU5Qt8rT7CalhDtnlXeY1xfWTvPHCVb7NGWU7y
	 u75y7Tl0Sa4kFbKhwEMCwRcxnKZ+L+76vY3w4i7Od7GJDtoFWqn2SGz7K5d5Gbx8WK
	 J6S5Dg2z0iEYKdMWremV40/LHnnpjNcHj9YG+DQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 880/969] batman-adv: mcast: fix use-after-free in orig_node RCU release
Date: Sat, 30 May 2026 18:06:44 +0200
Message-ID: <20260530160324.988719350@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257826-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,narfation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,c0d3.blue:email]
X-Rspamd-Queue-Id: 48A7660FD9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 20c2d6a20ca936f5aaa6dd40f73f262ac45c87cc upstream.

batadv_mcast_purge_orig() removes entries from RCU-protected hlists but
does not wait for an RCU grace period before returning. Concurrent RCU
readers may still accesses references to those entries at the point of
removal. RCU-protected readers trying to operate on entries like
orig->mcast_want_all_ipv6_node will then access already freed memory.

Fix this by moving batadv_mcast_purge_orig() to batadv_orig_node_release(),
just before the call_rcu() invocation. This ensures RCU readers that were
active at purge time have drained before the orig_node memory is reclaimed.

Cc: stable@kernel.org
Fixes: ab49886e3da7 ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")
Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/originator.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -823,8 +823,6 @@ static void batadv_orig_node_free_rcu(st
 
 	orig_node = container_of(rcu, struct batadv_orig_node, rcu);
 
-	batadv_mcast_purge_orig(orig_node);
-
 	batadv_frag_purge_orig(orig_node, NULL);
 
 	kfree(orig_node->tt_buff);
@@ -878,6 +876,8 @@ void batadv_orig_node_release(struct kre
 	/* Free nc_nodes */
 	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
 
+	batadv_mcast_purge_orig(orig_node);
+
 	call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 



