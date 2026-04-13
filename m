Return-Path: <stable+bounces-237666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOYVJFtn3WnsdgkAu9opvQ
	(envelope-from <stable+bounces-237666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:59:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E74B93F3ACC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFE3C3016ED0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DBD397E7E;
	Mon, 13 Apr 2026 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhcJyiie"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD02B38CFEF
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117590; cv=none; b=iEZqZy6OG2rtwR+P8GGrm43Mfu1RHy2dyv5CnHjvBHheAwAj+2TP71OPsJktJf7Ns8Q9wfcZyKJvwyjT8b1G8CrGCkfOEh8mpFgOQxA0n20ItefhUfek9BCyTfZUemwfd9nhPfpw6mlyUp5wAUDrTezLt7qNbqoj4SIULs+Hxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117590; c=relaxed/simple;
	bh=2Vgt4FwV/ywCcnzC4wIvwNVr9Ao1/9FJteMb6sUe3RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLhNq34nQMCgW2nuD1Cd17zqWZntFmWQAP4ziMCgG9/8TtpRadQSg5jxVKK6cfC7S5yyuFeKCopLGL8A04oEf5UqbW/yoVKQmtp/afr855PZBmOMG1voIfLjNXdA5ucTq5HVBlxznwuqLUJFHfSnXvHUqweC/zHY81zGMRGie9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhcJyiie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7601C2BCAF;
	Mon, 13 Apr 2026 21:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776117590;
	bh=2Vgt4FwV/ywCcnzC4wIvwNVr9Ao1/9FJteMb6sUe3RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhcJyiieYDVQHpg82LtbzwRzo9ZqEGMjSl/eZKdbT3oiiAT0UeAIOhbA4TzfD8UPg
	 OLqHEb27js2ygKT/yxJtfyoWzma9MobSuPjDmd/3b8yPViusnphn5zz10p0rBmHs5l
	 /tN0kVBs3WqcI8us6UYuAOxwkj0AB+1O6okj3exoJ/rWEONScblxTnd5L+dWmv447M
	 7Nde5x5MqpiVu3FiQ8Xct+bx1+3xrK9COGcB3nZac8Oc4mBAkyoWgQVVIk+Q3NX7B8
	 +r8IoSqKmss91njAKWmpEghrf1yTbVh3kxczZoHbqM9rzJcj078Can6lQsYW82WT4O
	 NH2OwLXT3tn+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yasuaki Torimaru <yasuakitorimaru@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfrm: clear trailing padding in build_polexpire()
Date: Mon, 13 Apr 2026 17:59:48 -0400
Message-ID: <20260413215948.3711943-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041331-wiring-revenge-aec2@gregkh>
References: <2026041331-wiring-revenge-aec2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,secunet.com:server fail];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,debian.org,secunet.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237666-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Queue-Id: E74B93F3ACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>

[ Upstream commit 71a98248c63c535eaa4d4c22f099b68d902006d0 ]

build_expire() clears the trailing padding bytes of struct
xfrm_user_expire after setting the hard field via memset_after(),
but the analogous function build_polexpire() does not do this for
struct xfrm_user_polexpire.

The padding bytes after the __u8 hard field are left
uninitialized from the heap allocation, and are then sent to
userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
leaking kernel heap memory contents.

Add the missing memset_after() call, matching build_expire().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[ replaced `memset_after()` macro with equivalent manual `memset()` call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d9238e17ab427..58c61efe1d7b3 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3389,6 +3389,8 @@ static int build_polexpire(struct sk_buff *skb, struct xfrm_policy *xp,
 		return err;
 	}
 	upe->hard = !!hard;
+	/* clear the padding bytes */
+	memset(&upe->hard + 1, 0, sizeof(*upe) - offsetofend(typeof(*upe), hard));
 
 	nlmsg_end(skb, nlh);
 	return 0;
-- 
2.53.0


