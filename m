Return-Path: <stable+bounces-257362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGg3CE0bG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:15:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F260F42D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 617BD30DAFE2
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB66534BA42;
	Sat, 30 May 2026 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HBUz/fsv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A042690D5;
	Sat, 30 May 2026 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160730; cv=none; b=ASqRxrvCBuEENTy6hCJ8T3mmifm8CRaB5RPR2nBaIGV8T1KF+SndaowAhb9M2HvQA3WOrBk9G7UnXBDYNPjhL/Y80yasQAD67kKJD+Hj5bWWBENJvizx6ceG8Vw7ONKUvuytHgNKs5S3yJQO3h02WjtdtbM26bObODajUPiZzug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160730; c=relaxed/simple;
	bh=euWPhgmuy+a/6GnvU8059hwV+4OPJpXuA4lKmLDHAPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjL8Hk9Hn48MVFoGgcE6VfQ6h8ZkzXxg7OoBk4xCvYK+EYLjSESaqgsVdjLZDpaHxIZ+JvGO35bIWU2e6wp9CDNFRPuDPL5chOHRv3rka51XE2mJFXBwY+r8GOiA6zcq8Bi2KwM2fUw4lcvfsiBAQ0XSGEfkZ5F3BkBK98Tjbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HBUz/fsv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162511F00893;
	Sat, 30 May 2026 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160729;
	bh=KdDT6HFsSup8NyHhQYE0+hAaI5SEqm6/0nO5XcExtFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HBUz/fsvGSF6mmSBzHrSGlyF6hXaG1fnQs233Iw7vHUb35tfb94bkD2dX+YJkaLBn
	 fbBgU1qvA/u2yoz/tvd6o5MRe4kzjQniAFczZbKm+lV4RHWxI8QdXZayIIXxYaXHnF
	 iDsZGe3m6JDQdOn1vPYNzm7+8F19RZiQXJ2wEqKo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 419/969] batman-adv: bla: prevent use-after-free when deleting claims
Date: Sat, 30 May 2026 17:59:03 +0200
Message-ID: <20260530160311.839716976@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257362-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AE2F260F42D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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



