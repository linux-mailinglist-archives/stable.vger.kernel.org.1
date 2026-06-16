Return-Path: <stable+bounces-265999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uQkIHWmUMWpInQUAu9opvQ
	(envelope-from <stable+bounces-265999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:22:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDDB69413B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:22:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=BzBEQFiX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265999-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265999-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DF6F318B44C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB73BFE5A;
	Tue, 16 Jun 2026 18:22:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099AF3D45CB;
	Tue, 16 Jun 2026 18:22:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634128; cv=none; b=jX9fmIJMQ4Ppo0j1U9zOb0Zq6MD1QeZ8kCoNAJhZqVdIlU/ft9sVZmHtyydReluYOVEGE4RtlA+LaEGp5uO7OZmz3lAaEW6HsmgdN0MUKHlXswbrfb/Rc/sBfGZwymwcM2ZZLZDTzdHhzJffh42F2/OIzhejsHHrtT52yMJr9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634128; c=relaxed/simple;
	bh=snBSwDDT+SZQnME6+Lhg3dPrQiNb6ipVUCpvN6zhLkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUf6Nwioyk2DfL+ifgwXMgZhdc4rME8y9UP01BiRLZx6kQfggVpdy0Azz7dpSgrQsVgn+0fNE+daiIYOlHxl5npcrwp4eP8vYtZzADN3eggenQfH1vMxXokh60GmHL2gdRn5bp+iy60VBGC22xZOP3AIcMaV7FczuldLD2t+nYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BzBEQFiX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FEF1F000E9;
	Tue, 16 Jun 2026 18:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634126;
	bh=ZIB2KhVKilm79dO24XOSGGXgHR+hZJaYEvpBPVeneGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzBEQFiXBraeIFfNadPpgDAmWCGbwqb8kzlfJOgVlQWIsAo/WoBfEX9p2XcjqQkv8
	 JOadooBfHjkr5Sw5oGGlu6Gac/DPDRtedRnBVkR2Sj4b7JOf6Zzhxp1H079IHczFDV
	 nPofTrAPehuuXLn68T6sxEzv2THcuHhvxApFEDeA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Til Kaiser <mail@tk154.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 196/411] net: mvpp2: limit XDP frame size to the RX buffer
Date: Tue, 16 Jun 2026 20:27:14 +0530
Message-ID: <20260616145111.138506486@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265999-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mail@tk154.de,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tk154.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDDDB69413B

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Til Kaiser <mail@tk154.de>

[ Upstream commit f3c6aa078927e6fe8121c9c591ddee8716c5305a ]

mvpp2 has short and long BM pools, and short pool buffers can be smaller
than PAGE_SIZE. The XDP path nevertheless initializes every xdp_buff with
PAGE_SIZE as frame size.

XDP helpers use frame_sz to validate tail growth and to derive the hard
end of the data area. Advertising PAGE_SIZE for short buffers can let
bpf_xdp_adjust_tail() grow a packet past the real allocation, corrupting
memory or later tripping skb tailroom checks.

Initialize the XDP buffer with bm_pool->frag_size so XDP tailroom matches
the actual buffer backing the packet.

Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
Signed-off-by: Til Kaiser <mail@tk154.de>
Link: https://patch.msgid.link/20260607134943.21996-3-mail@tk154.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index ad6325c80f9868..d8a2268b88187a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3978,7 +3978,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			else
 				xdp_rxq = &rxq->xdp_rxq_long;
 
-			xdp_init_buff(&xdp, PAGE_SIZE, xdp_rxq);
+			xdp_init_buff(&xdp, bm_pool->frag_size, xdp_rxq);
 			xdp_prepare_buff(&xdp, data,
 					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
 					 rx_bytes, false);
-- 
2.53.0




