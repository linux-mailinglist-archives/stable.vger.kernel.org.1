Return-Path: <stable+bounces-226235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPlmOrSGuWncJAIAu9opvQ
	(envelope-from <stable+bounces-226235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:52:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEEC2AE8D3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CAA1315D409
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D4E3EDADF;
	Tue, 17 Mar 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tRPy3OW5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D13EC2F1;
	Tue, 17 Mar 2026 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765835; cv=none; b=Jxxkb5n3nUiXn6lpxBDwJCi1HcGYzJzuTlhGwYo549zELsB+I6aNg47IjBOrUkGMKyHis2gkIsLliMbDhB6WjCmVS/SKUHsgESq1rEYaxVeFhP+9mz9H71J3tb9aUWIsi/6s17C0TgmbIetInOCm45SbDuY/kh3ZqCd0jWX+bwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765835; c=relaxed/simple;
	bh=4YJ08IsBNstPGnH1LTlwepHfqOOsNpJBHNouTvRSm8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFBRqSxeTmsKGIDDEYWwn3C/u3lXAVFNk3zxtAi3sh5s3rnVObKn5o/3mWPH6OxFfyDv4Nil5KHpWwwj3G1z/Qv3QsOO8FxKRi0mypfT5TgvWkT0v9gLfqAzFxxIDaQmfArxHbYlTQWH4ij4AvTidQy7++hx/A8GH6Q4iNYHr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tRPy3OW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE4DC4CEF7;
	Tue, 17 Mar 2026 16:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765835;
	bh=4YJ08IsBNstPGnH1LTlwepHfqOOsNpJBHNouTvRSm8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tRPy3OW50zX88cR2/gprhF7Exio1xHi0fU7o1lUkDB1a89X1cOGMPZBZqg6YPpVK8
	 ECMAGmYJCDre3WLueUP3X3TyeUuOI1qU2E0MjSUFRZ05+ytPKotAqNFmSmt63ScjQP
	 xvxhpqS/a1KkcnjLvKs/yOPVcD5ngSdLfuCrG5z8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 106/378] neighbour: restore protocol != 0 check in pneigh update
Date: Tue, 17 Mar 2026 17:31:03 +0100
Message-ID: <20260317163010.917023687@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226235-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,queasysnail.net:email]
X-Rspamd-Queue-Id: 5AEEC2AE8D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit cbada1048847a348797aec63a1d8056621cbe653 ]

Prior to commit dc2a27e524ac ("neighbour: Update pneigh_entry in
pneigh_create()."), a pneigh's protocol was updated only when the
value of the NDA_PROTOCOL attribute was non-0. While moving the code,
that check was removed. This is a small change of user-visible
behavior, and inconsistent with the (non-proxy) neighbour behavior.

Fixes: dc2a27e524ac ("neighbour: Update pneigh_entry in pneigh_create().")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/38c61de1bb032871a886aff9b9b52fe1cdd4cada.1772894876.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 96a3b1a93252a..e4ee0c02fb443 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -821,7 +821,8 @@ int pneigh_create(struct neigh_table *tbl, struct net *net,
 update:
 	WRITE_ONCE(n->flags, flags);
 	n->permanent = permanent;
-	WRITE_ONCE(n->protocol, protocol);
+	if (protocol)
+		WRITE_ONCE(n->protocol, protocol);
 out:
 	mutex_unlock(&tbl->phash_lock);
 	return err;
-- 
2.51.0




