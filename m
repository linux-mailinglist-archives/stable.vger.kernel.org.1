Return-Path: <stable+bounces-218700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMZWE4tYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD5190752
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B18B031D175A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834911D5141;
	Wed, 25 Feb 2026 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bt5bcPei"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7726463A;
	Wed, 25 Feb 2026 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983560; cv=none; b=D7i4EIyxaIUyEqyP1LbF8R0EgArqEjHkKMN6VASbs2Ku+D+8TzpYv5l4QT+aWRAn4rndWYLqyRphzZaCdrXIqTgt9lxICINsS8km6DxCvdQ++cGE4sHSkDSJ12CfijwCK28er5E8kx1+fPj8yl4Iezb4irOLf8DoEWcOytL+df4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983560; c=relaxed/simple;
	bh=ABKhqKn9hioNNi7/qr8aiAI9HezAuZ8VZcdKZZYQNes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjSdhLSjuCDve0W66BxwYEL3IE+WHKvMfsSOE5Bg+o/SNcLRJj0cVYBUInt9wTodstONFgWg7i0YuOcy4Ew74Zx/PJW3AUQxkLQYwXqeAKYo80nOKhuqBy/4tGKE69M2EBp7wVetGzPqEHVhip7y3MQFU9cbf5am/OxSYptOVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bt5bcPei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016DEC19423;
	Wed, 25 Feb 2026 01:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983560;
	bh=ABKhqKn9hioNNi7/qr8aiAI9HezAuZ8VZcdKZZYQNes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bt5bcPeiGVfxkxWzssLIeRTxyo57x/vofDZdT1Urdf0JpLjcDi0P3aR5fPdeivtRM
	 CMkh9B/aI4g1U3j8ksElNz4RdrzrjnCmlbNN7pYAzQoSZ3kxhDyQr+gfOpCaTIIwtM
	 3I3JrGfQu4SAra6EsCf0Ju9nElfmEPZMTvFw3pCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksei Oladko <aleksey.oladko@virtuozzo.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 659/781] selftests: forwarding: vxlan_bridge_1d_ipv6: fix test failure with br_netfilter enabled
Date: Tue, 24 Feb 2026 17:22:48 -0800
Message-ID: <20260225012415.951107988@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218700-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,virtuozzo.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: CAFD5190752
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>

[ Upstream commit ce9f6aec0fb780dafc1dfc5f47c688422aff464a ]

The test generates VXLAN traffic using mausezahn, where the encapsulated
inner IPv6 packet has an incorrect payload length set in the IPv6 header.
After VXLAN decapsulation, such packets do not pass sanity checks in
br_netfilter and are dropped, which causes the test to fail.

Fix this by setting the correct IPv6 payload length for the encapsulated
packet generated by mausezahn, so that the packet is accepted
by br_netfilter.

tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
lines 698-706

              )"00:03:"$(           : Payload length
              )"3a:"$(              : Next header
              )"04:"$(              : Hop limit
              )"$saddr:"$(          : IP saddr
              )"$daddr:"$(          : IP daddr
              )"80:"$(              : ICMPv6.type
              )"00:"$(              : ICMPv6.code
              )"00:"$(              : ICMPv6.checksum
              )

Data after IPv6 header:
• 80: — 1 byte (ICMPv6 type)
• 00: — 1 byte (ICMPv6 code)
• 00: — 1 byte (ICMPv6 checksum, truncated)

Total: 3 bytes → 00:03 is correct. The old value 00:08 did not match
the actual payload size.

Fixes: b07e9957f220 ("selftests: forwarding: Add VxLAN tests with a VLAN-unaware bridge for IPv6")
Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260213131907.43351-3-aleksey.oladko@virtuozzo.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
index a603f7b0a08f0..e642feeada0e7 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
@@ -695,7 +695,7 @@ vxlan_encapped_ping_do()
 		    )"6"$(			  : IP version
 		    )"$inner_tos"$(               : Traffic class
 		    )"0:00:00:"$(                 : Flow label
-		    )"00:08:"$(                   : Payload length
+		    )"00:03:"$(                   : Payload length
 		    )"3a:"$(                      : Next header
 		    )"04:"$(                      : Hop limit
 		    )"$saddr:"$(		  : IP saddr
-- 
2.51.0




