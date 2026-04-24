Return-Path: <stable+bounces-240744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLJhOepx62ndMwAAu9opvQ
	(envelope-from <stable+bounces-240744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:36:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF2545F37A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D70E33023E24
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E853D5251;
	Fri, 24 Apr 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vpzzl0Bv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E6179A3;
	Fri, 24 Apr 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037724; cv=none; b=Aul6ik2PJ+qvN2NdfJGb1ot4yVdKnHiVRh8/8Je+eCtiKs5siltZ1qUlq+db/gNbir4FL3GhFkwUBgKELC+bUipDxLqGatrTCioZ58oBqm0ofelt+OlVUlwJ1avKRzfWBq93XpkRFCV/WARhcGndRzc516rMuZ14c+gdVshvcho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037724; c=relaxed/simple;
	bh=WrVM/XwGYBhp/Op+50ipoaHezSuEJcWF7XDhBDXvuxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IB26gwIaiqeYgHziYD1WdyWk6u/NFKE9xwIim5RyPSlkeBrs37o4WhcmvtuUEGTl3kV5BYUT1KbClG64kH3RWYFd96qw8TphFypWfLuq+Cam9gfYa/0tIkyBvoceFPDU+wgwH/mosqvNNkvz2CzXxAMzaTjlPjcPJhTLyF5rBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vpzzl0Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B726C19425;
	Fri, 24 Apr 2026 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037724;
	bh=WrVM/XwGYBhp/Op+50ipoaHezSuEJcWF7XDhBDXvuxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vpzzl0BveWmZmqYv8L+Agge8wfhBOd1o0N2/WcaGFkgP30VWVxivJnqOOxRWS0KAx
	 Jl1H/rIA0JODzzCyC02YDXBjS7R83stAbeGN9ynQevsVgMNAUDIYvR94Sko3ZFgQ2V
	 3DrJuxy0wGzNNFmRAAVmCe0JjNVqyI9bjOsRYs+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 044/166] xsk: tighten UMEM headroom validation to account for tailroom and min frame
Date: Fri, 24 Apr 2026 15:29:18 +0200
Message-ID: <20260424132542.077981997@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7BF2545F37A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240744-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,fomichev.me:email]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit a315e022a72d95ef5f1d4e58e903cb492b0ad931 ]

The current headroom validation in xdp_umem_reg() could leave us with
insufficient space dedicated to even receive minimum-sized ethernet
frame. Furthermore if multi-buffer would come to play then
skb_shared_info stored at the end of XSK frame would be corrupted.

HW typically works with 128-aligned sizes so let us provide this value
as bare minimum.

Multi-buffer setting is known later in the configuration process so
besides accounting for 128 bytes, let us also take care of tailroom space
upfront.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Fixes: 99e3a236dd43 ("xsk: Add missing check on user supplied headroom size")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Link: https://patch.msgid.link/20260402154958.562179-2-maciej.fijalkowski@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xdp_umem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 06cead2b8e349..e3c3bab76a5d0 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -196,7 +196,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (!unaligned_chunks && chunks_rem)
 		return -EINVAL;
 
-	if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
+	if (headroom > chunk_size - XDP_PACKET_HEADROOM -
+		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - 128)
 		return -EINVAL;
 
 	umem->size = size;
-- 
2.53.0




