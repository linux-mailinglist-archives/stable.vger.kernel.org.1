Return-Path: <stable+bounces-271032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BleSLMGWRmpqZQsAu9opvQ
	(envelope-from <stable+bounces-271032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:50:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 372286FA9FD
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:50:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ikCN+DP8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271032-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271032-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E35D63086D53
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1396D3B8139;
	Thu,  2 Jul 2026 16:41:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0480330C60F;
	Thu,  2 Jul 2026 16:41:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010497; cv=none; b=iROMltSiiEEq5TwJZ/9KqEz+lWTGi+uej3sMgQDWF3xT21bRFKIcR1Ty77HExk/4+G96OUZNRNLJy7D73rg0gTFJumEnOFnqfFgLwDgbOAMYKNnaBFzdKAsIJ83OKcvLnkKHTZahSxS0RAnQLHTpnoyghGIZ0k0xxTIhh4Wkyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010497; c=relaxed/simple;
	bh=oIjTtdrSsiLrc/jBArpfI9dboHuJc2q2xciFUxCwZdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IggwnWv0mgRl61SdbI8ktnM7cidMtsJLirLmbZL9KQwjUU9oFXYo1Kf1Ju8T+IUd+lF+oP81GahFf6nIeUqM7yLnlVeJZJ+Lae1t/fJprb3a4zVtadGl5dna9ztXAJqhiDPjrevKSVjpF0rrNPBJn5oNtTKzshqtLRI5eZ9In/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ikCN+DP8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70B11F0155C;
	Thu,  2 Jul 2026 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010490;
	bh=sImg1cN9ax5nEUDCye+lCL2DvbzgM7tEjBKR/2wQsOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ikCN+DP8t7/Yytj++48UrkGW5rfGodK1NpdP+qjMUvPgX6BGFs6XZRR0e01aa56rr
	 AOQcwufyEpfjlPV0R6J8Kx71cFfndwqnvqUR/0Uf1UGtNutAwoLcaIaR0WNhxHIGbw
	 awnFrgmtGUeXY6ua8F57/uxgRVkBOGIDwmG+0Nfw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jungwoo Lee <jwlee2217@gmail.com>,
	Wongi Lee <qw3rtyp0@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 129/204] ipv4: account for fraggap on the paged allocation path
Date: Thu,  2 Jul 2026 18:19:46 +0200
Message-ID: <20260702155121.361628729@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-271032-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jwlee2217@gmail.com,m:qw3rtyp0@gmail.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 372286FA9FD

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wongi Lee <qw3rtyp0@gmail.com>

[ Upstream commit eca856950f7cb1a221e02b99d758409f2c5cec42 ]

In __ip_append_data(), when the paged-allocation branch is taken,
alloclen and pagedlen are computed as

	alloclen = fragheaderlen + transhdrlen;
	pagedlen = datalen - transhdrlen;

datalen already includes fraggap, but the fraggap bytes carried over
from the previous skb are copied into the new skb's linear area at
offset transhdrlen by the subsequent skb_copy_and_csum_bits(). The
linear area is therefore undersized by fraggap bytes while pagedlen is
overstated by the same amount.

The non-paged branch sets alloclen to fraglen, which already accounts
for fraggap because datalen does. Bring the paged branch in line by
adding fraggap to alloclen and subtracting it from pagedlen.

After this adjustment, copy no longer collapses to -fraggap on the
paged path, so remove the stale comment describing that old arithmetic.

Fixes: 8eb77cc73977 ("ipv4: avoid partial copy for zc")
Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/ajFR1eLAIs42TN3g@DESKTOP-19IMU7U.localdomain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_output.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0d0d6ebdd3a849..41031c5c430334 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1118,8 +1118,8 @@ static int __ip_append_data(struct sock *sk,
 				  !(rt->dst.dev->features & NETIF_F_SG)))
 				alloclen = fraglen;
 			else {
-				alloclen = fragheaderlen + transhdrlen;
-				pagedlen = datalen - transhdrlen;
+				alloclen = fragheaderlen + transhdrlen + fraggap;
+				pagedlen = datalen - transhdrlen - fraggap;
 			}
 
 			alloclen += alloc_extra;
@@ -1166,9 +1166,6 @@ static int __ip_append_data(struct sock *sk,
 			}
 
 			copy = datalen - transhdrlen - fraggap - pagedlen;
-			/* [!] NOTE: copy will be negative if pagedlen>0
-			 * because then the equation reduces to -fraggap.
-			 */
 			if (copy > 0 &&
 			    INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
 					    from, data + transhdrlen, offset,
-- 
2.53.0




