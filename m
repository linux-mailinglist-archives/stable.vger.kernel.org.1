Return-Path: <stable+bounces-236825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APRTHEoi3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-236825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:05:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04C3F0AE3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E7723164FDA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6759238D27;
	Mon, 13 Apr 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qws6nfZi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29C233722;
	Mon, 13 Apr 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097888; cv=none; b=EhCGwc2clPXkJxUv+cvH6DOBq5Q1H3FoRSpHkLDdFh3tL4RzxDvFjL/9NTL3yLyNDUNZkOVpYXFjf1JdfJS0kkQpkTp/xUHnngIpkbsio6xMkKaK5bgGRSYM7aNMO8ohfnCSJEQWGxwUw8gjskzZdQ+pLg8PyzJc8lb3jSLvbsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097888; c=relaxed/simple;
	bh=I19+Kkfky01kxUhCMfJm1pVN+sO16dmKGslztdkfE38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz1gyAo4aNvnSi7elPvCIC6YpBEWDSTxNe9Boqgy3otbrCGNXgBpAEKAy5UXFYM1JYvN2xP+o9LOXvXSsn3l/esTR6jra7fVQ18QjgxG0lxxXxJ65/AgttqbdL1EgSqrb1ioE9H9MXItvdv7a3v1QW5s++dBI56iwLyCWJ2FkVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qws6nfZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404EEC2BCB0;
	Mon, 13 Apr 2026 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097888;
	bh=I19+Kkfky01kxUhCMfJm1pVN+sO16dmKGslztdkfE38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qws6nfZi/4ke6UqEcFltUEKjP3oKI6lSPKKkIXlgU6GQV8itNsUP68CQEhivJH3r+
	 3F9Zq4mkrZcTTX5yhjjUEQfNu4tBctioqy45/is5/ODrOFb4nQhsSQ38DPvyEKkGgp
	 19LyBtAndloaWHtnE6QMiY+WlMmHs2P7icRchi6E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 312/570] xfrm: call xdo_dev_state_delete during state update
Date: Mon, 13 Apr 2026 17:57:23 +0200
Message-ID: <20260413155842.183825093@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236825-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,queasysnail.net:email,secunet.com:email]
X-Rspamd-Queue-Id: DC04C3F0AE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 7d2fc41f91bc69acb6e01b0fa23cd7d0109a6a23 ]

When we update an SA, we construct a new state and call
xdo_dev_state_add, but never insert it. The existing state is updated,
then we immediately destroy the new state. Since we haven't added it,
we don't go through the standard state delete code, and we're skipping
removing it from the device (but xdo_dev_state_free will get called
when we destroy the temporary state).

This is similar to commit c5d4d7d83165 ("xfrm: Fix deletion of
offloaded SAs on failure.").

Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 54ae99f69f25f..f7f568bfb93a8 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1770,6 +1770,7 @@ int xfrm_state_update(struct xfrm_state *x)
 
 		err = 0;
 		x->km.state = XFRM_STATE_DEAD;
+		xfrm_dev_state_delete(x);
 		__xfrm_state_put(x);
 	}
 
-- 
2.51.0




