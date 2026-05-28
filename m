Return-Path: <stable+bounces-255934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFBkG02nGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6385F916B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92BB23004628
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91A3368B5;
	Thu, 28 May 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UM8Y/zby"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F325F7B9;
	Thu, 28 May 2026 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000288; cv=none; b=jg9FzHVHedb/dcmg01FPUJYfMOk9QO93WjWSIwfYiH8FfWfScDfdIGIfq94MhJdio0Bp2781XpYoOaOfhlcHPv+Ul919gKG+Z+9FOc5r6BWE69m2vKvI2VBXTbXPxhJ4k7Yq80zGFVQFvhpS8B7qxXQRC5VisCSoS7eACoJ/5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000288; c=relaxed/simple;
	bh=oSlqdqfNATOmtBPCQAZC8H3D/gU+n9ZDAANPZN35c2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/Hd57Bxe0BtNXcCHOuHbXbOcmJYADQCV2o3yQxMIW8pm0m6I7gDPyKH9NPTb2Nzmk5UY2WPCszATcFaezyBhwjDanOqnEGwPoq0w8ArrbutdbIx/yWNr5wyYlR20mxnQOHQoLTCt+rF/aEEntpQPZdDVYe+tsM6xW3IuUdvNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UM8Y/zby; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531511F000E9;
	Thu, 28 May 2026 20:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000287;
	bh=P8gT0hOtABW4A3AIcbRxWYQ8NyV417d6QDzi6sUdoM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UM8Y/zbyxF0U/e6T+FM3Q4bybK/kpjGqVjXb0OkED53FUXs5we1JkbAAtuzSU7tSY
	 /N5J5opJlDoz8Uu6yy87Vuy/bEX2tXzgLMHMnu2ao2h1MRj1ineeP93+MfbNHGAWlr
	 Ly8BhSUNmXfeyR9r0BaD3Os1t65xHBq+mXFfSKW8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geetha sowjanya <gakula@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 369/377] octeontx2-af: npc: Fix allmulticast skip logic for LBK and SDP VFs
Date: Thu, 28 May 2026 21:50:07 +0200
Message-ID: <20260528194649.111824814@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255934-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3C6385F916B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ratheesh Kannoth <rkannoth@marvell.com>

[ Upstream commit 9eddc819f00b5b74bb4ac91396f80bd35f5f3561 ]

When installing the allmulticast NPC rule, rvu_npc_install_allmulti_entry()
should skip LBK and SDP VFs (only CGX PF/VF may add the entry).  The
code combined is_lbk_vf() and is_sdp_vf() with logical AND, which is
never true for a single pcifunc, so the intended early return never ran.

Use logical OR instead.

Cc: Geetha sowjanya <gakula@marvell.com>
Fixes: ae703539f49d2 ("octeontx2-af: Cleanup loopback device checks")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Link: https://patch.msgid.link/20260520043036.1523798-1-rkannoth@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 8658cb2143dfc..e28675fe18907 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -837,7 +837,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	u16 vf_func;
 
 	/* Only CGX PF/VF can add allmulticast entry */
-	if (is_lbk_vf(rvu, pcifunc) && is_sdp_vf(rvu, pcifunc))
+	if (is_lbk_vf(rvu, pcifunc) || is_sdp_vf(rvu, pcifunc))
 		return;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
-- 
2.53.0




