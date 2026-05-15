Return-Path: <stable+bounces-248353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO/2DdFVB2oHzAIAu9opvQ
	(envelope-from <stable+bounces-248353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:20:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3122554D9B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 202D131DCFD2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441AE3B9D91;
	Fri, 15 May 2026 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qZvSwyBq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1B3FBB50;
	Fri, 15 May 2026 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861517; cv=none; b=PA8jqI7DDvh1RrcFxY2fCd/KwOx89wRngl5rfDc2pEWlZT5AhFy1ay36LJ0hrez83zmWyAmHrFtb4iyWFvUljbwBEk+QG3XoVH4Xe/MmKBY+0trqKVzzNvFzr6EsLbRjypydwIUyeaBn+V1oF/n9+ABZ1J+X7gnmUTz0ACyM6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861517; c=relaxed/simple;
	bh=Zq2qIAcb9FW3ooC1gV7KQHni0hbGxQhNdqXeuHQ+tjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr4QPY/loN9Sg5A7sGp4q2eDay9ywTahr/QnfX9MzK5AmbaiBDNoTWMkiOSa5uF34Q83vypY9I7WwHgxYtCTmCdScFO5Wdt+eQn/I30VBGd6SMmQlcpVzi/RuY7OA5FwW6NMclpqv1IgY/tnFxGK4aFEjfU+8riZUtmpnm9AZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qZvSwyBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9173CC2BCB0;
	Fri, 15 May 2026 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861516;
	bh=Zq2qIAcb9FW3ooC1gV7KQHni0hbGxQhNdqXeuHQ+tjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZvSwyBqtZTJsQGAfWZ56nZLzsDQ4J4oa0KsMKJTo58RPObYPn8mK4pLrfA5P8XYx
	 8vL6R+nbbleTP3ThNcJgYbOw8xL93eayWKputA3XkgKxJKv8RJu8udcjzFVhb7qjT4
	 rKXFLGeNbChzRHT6f9i6NgwiJk3LXMX3I5uicGY0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6 359/474] batman-adv: bla: prevent use-after-free when deleting claims
Date: Fri, 15 May 2026 17:47:48 +0200
Message-ID: <20260515154722.787071259@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B3122554D9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248353-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,narfation.org:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 4ae1709a314060a196981b344610d023ea841e57 upstream.

When batadv_bla_del_backbone_claims() removes all claims for a backbone, it
does this by dropping the link entry in the hash list. This list entry
itself was one of the references which need to be dropped at the same time
via batadv_claim_put().

But the batadv_claim_put() must not be done before the last access to the
claim object in this function. Otherwise the claim might be freed already
by the batadv_claim_release() function before the list entry was dropped.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bridge_loop_avoidance.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -318,8 +318,8 @@ batadv_bla_del_backbone_claims(struct ba
 			if (claim->backbone_gw != backbone_gw)
 				continue;
 
-			batadv_claim_put(claim);
 			hlist_del_rcu(&claim->hash_entry);
+			batadv_claim_put(claim);
 		}
 		spin_unlock_bh(list_lock);
 	}



