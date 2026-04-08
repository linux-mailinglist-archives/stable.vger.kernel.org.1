Return-Path: <stable+bounces-234465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIdtIJae1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:29:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F207A3C0D2E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 610D53002D61
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3933D5647;
	Wed,  8 Apr 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wnC5fSGW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C072494F0;
	Wed,  8 Apr 2026 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672930; cv=none; b=kIKOiA+xXXMltd+ClSnNhVBX5FPFRQg3jPDonLobQH5WePI08QPN+iECfQ1Er+p7Lc0ozlsjOL1C0yFq8o+Mu+SA84A2Vnl/0GfldVzYLazldP/hQ+RIC3YhzA/iLz9z/06VsOCBiwwUJ6/Bh7RBR1ZPP5FBS+CJ3Q6I+R1ZPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672930; c=relaxed/simple;
	bh=Fa7o4+lpXBr9kkTvG7ijtPfWlgcuo8EgYmC6pcUB5g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rkc0ICkJWgL/4q6lp9Th8XIOR/cAGl47ICkU+xaEDzY0ryHEznV0Ce8JPS6xNK2psl84TO4XbQaI52xCaF82idAwTiOxPCedhaXD5AQcNVaPZE8S2yHtf3AI4jP4bGi6xtuC8MqR+Sb4LrNEJC6jnKqsVDJLIFlOrztLGHfPvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wnC5fSGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E6BC19421;
	Wed,  8 Apr 2026 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672930;
	bh=Fa7o4+lpXBr9kkTvG7ijtPfWlgcuo8EgYmC6pcUB5g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wnC5fSGW2KPnHE1HbQSfMaSlMg5Pfax57RGMVoGzBsScaz0JVpKmbchq/wkF/lOQ+
	 4JZCuqWe/rh8htlIyyQBm+V3hm3PNYJgMs5c9trDXya6bgVXvUIGEpCPui3rfYnoyF
	 e6In+t9T+CCH9EaMbOf0mUlC5/Z6CRsFwh1nXrCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yochai Eisenrich <echelonh@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 034/277] net: ipv6: ndisc: fix ndisc_ra_useropt to initialize nduseropt_padX fields to zero to prevent an info-leak
Date: Wed,  8 Apr 2026 20:00:19 +0200
Message-ID: <20260408175935.127625167@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-234465-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: F207A3C0D2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yochai Eisenrich <echelonh@gmail.com>

[ Upstream commit ae05340ccaa9d347fe85415609e075545bec589f ]

When processing Router Advertisements with user options the kernel
builds an RTM_NEWNDUSEROPT netlink message. The nduseroptmsg struct
has three padding fields that are never zeroed and can leak kernel data

The fix is simple, just zeroes the padding fields.

Fixes: 31910575a9de ("[IPv6]: Export userland ND options through netlink (RDNSS support)")
Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260324224925.2437775-1-echelonh@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ndisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 0fd3f53dbb52e..ded2d3a0660c3 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1209,6 +1209,9 @@ static void ndisc_ra_useropt(struct sk_buff *ra, struct nd_opt_hdr *opt)
 	ndmsg->nduseropt_icmp_type = icmp6h->icmp6_type;
 	ndmsg->nduseropt_icmp_code = icmp6h->icmp6_code;
 	ndmsg->nduseropt_opts_len = opt->nd_opt_len << 3;
+	ndmsg->nduseropt_pad1 = 0;
+	ndmsg->nduseropt_pad2 = 0;
+	ndmsg->nduseropt_pad3 = 0;
 
 	memcpy(ndmsg + 1, opt, opt->nd_opt_len << 3);
 
-- 
2.53.0




