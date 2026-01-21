Return-Path: <stable+bounces-210952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL3cI2sgcWmodQAAu9opvQ
	(envelope-from <stable+bounces-210952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:52:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF9D5B8E5
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D21BAEEDDB
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C9387359;
	Wed, 21 Jan 2026 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RYdXubCy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800236BCF1;
	Wed, 21 Jan 2026 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019937; cv=none; b=q/l5t2xiP2sIXkD+l05wBhHuwJuLtq1uvESHvbgeFQLrl0ai7tAhPitUj8hqtAzkoYii7EWswVNbVHXqU7dwJiaXMrGhdE+zLkn6FxFEK6dytmpGJO6XC0dYEfJBYqcRHf/OyydA2EZVeYI5vRUvUbQrwO8C7CYB9FzVmUhZHDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019937; c=relaxed/simple;
	bh=f/qm0POUd/ZS7l/CtRWE2V2myasX9Js9jeyamrSq7T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggG3ZKwURt4tWgxGsbDGNNZSgpm01YsVzjbTC3yt+1nlkBfnd7a0ydD5GqrEpI23f/rItsUnuYOFwWZLCtk6HBDfXlMVshkpsftM7rwznQWKuWfme2fnR/5NcQrFIvjku3PwFTyhmP00Nm+FTGPQI6CB9XOvc2uejSAsz6man20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RYdXubCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FB5C4CEF1;
	Wed, 21 Jan 2026 18:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019937;
	bh=f/qm0POUd/ZS7l/CtRWE2V2myasX9Js9jeyamrSq7T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYdXubCyU2atxpX62405TXMo0Q6IYSPj41fX91jtnrp38SkRNRtD9CSoyyzAvLVNN
	 dZcCCG1PiPuVx9Jhr44B+RndIJpfjT2rBfZzSsXu5k/OA98n80BDXPVvXa8jOHuLCR
	 0QMU91CnWJunQCVrPO00kQpGwU+J1kyaf+LO4l6E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 012/198] xfrm: Fix inner mode lookup in tunnel mode GSO segmentation
Date: Wed, 21 Jan 2026 19:14:00 +0100
Message-ID: <20260121181418.989691672@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210952-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,queasysnail.net:email,secunet.com:email]
X-Rspamd-Queue-Id: EBF9D5B8E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit 3d5221af9c7711b7aec8da1298c8fc393ef6183d ]

Commit 61fafbee6cfe ("xfrm: Determine inner GSO type from packet inner
protocol") attempted to fix GSO segmentation by reading the inner
protocol from XFRM_MODE_SKB_CB(skb)->protocol. This was incorrect
because the field holds the inner L4 protocol (TCP/UDP) instead of the
required tunnel protocol. Also, the memory location (shared by
XFRM_SKB_CB(skb) which could be overwritten by xfrm_replay_overflow())
is prone to corruption. This combination caused the kernel to select
the wrong inner mode and get the wrong address family.

The correct value is in xfrm_offload(skb)->proto, which is set from
the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
inner packet's address family.

Fixes: 61fafbee6cfe ("xfrm: Determine inner GSO type from packet inner protocol")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/esp4_offload.c | 4 ++--
 net/ipv6/esp6_offload.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 05828d4cb6cdb..abd77162f5e75 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -122,8 +122,8 @@ static struct sk_buff *xfrm4_tunnel_gso_segment(struct xfrm_state *x,
 						struct sk_buff *skb,
 						netdev_features_t features)
 {
-	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x,
-					XFRM_MODE_SKB_CB(skb)->protocol);
+	struct xfrm_offload *xo = xfrm_offload(skb);
+	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x, xo->proto);
 	__be16 type = inner_mode->family == AF_INET6 ? htons(ETH_P_IPV6)
 						     : htons(ETH_P_IP);
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22410243ebe88..22895521a57d0 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -158,8 +158,8 @@ static struct sk_buff *xfrm6_tunnel_gso_segment(struct xfrm_state *x,
 						struct sk_buff *skb,
 						netdev_features_t features)
 {
-	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x,
-					XFRM_MODE_SKB_CB(skb)->protocol);
+	struct xfrm_offload *xo = xfrm_offload(skb);
+	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x, xo->proto);
 	__be16 type = inner_mode->family == AF_INET ? htons(ETH_P_IP)
 						    : htons(ETH_P_IPV6);
 
-- 
2.51.0




