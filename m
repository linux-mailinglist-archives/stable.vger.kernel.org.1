Return-Path: <stable+bounces-264250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vhpiJ0l0MWr3jgUAu9opvQ
	(envelope-from <stable+bounces-264250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:05:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E4A691AD5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:05:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=OGyQuxm6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264250-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264250-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C1A430EECF9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30E39282C;
	Tue, 16 Jun 2026 15:48:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19C35DA75;
	Tue, 16 Jun 2026 15:48:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624937; cv=none; b=dg1N8wd6z+vb2K2rm2Kzy9+1GBzDQal1CPqPde/5a5NrqSos/WrhI+rOP2LKzO4hL+s+e80N8q2AIBv9FglAFVSY6viVt8OnCwWPFSfGGp64xKcZLzLZJNwaqcmh1MCG0Z5VUoaUJhRu0dFasJj12ePeLtZ2Mx1ZoZ2m3rRS96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624937; c=relaxed/simple;
	bh=tzFVCqKq+40BoxrHVhn57pqh6nlVcQ/W2jNffhbU9NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qf9N0bKZqNIG8qgT+HuiJPEktvRLoU2qY670rRTb8utAp9iaL2yPIqEt5npYQqZr8+gX+Lr6S2z+rDEHSvn6bLx9aulmt+t76cGLuL722JrUV9//2AG1mR0Tf3TmBvxWWT7h5up+bV6BEIR0etXMzBrd7vV5cQ1MR3rKPW/p1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OGyQuxm6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE021F000E9;
	Tue, 16 Jun 2026 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624936;
	bh=BhG4GAw7vL2UJiHOf88IzgyF4EsnsObu4y/AAKa+T3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OGyQuxm6wUlqZ5sMNduQr5FnKpw9/MGPrjv/rG23pRlF5PWhbTwYnaMpe2mn1jR3X
	 A+MM8bGyVGNEEV2JIDmXXDKZxiVSvjPaWDRiiZMtM4yp7bC0AgQARuYaczgAMnLj5G
	 s/Jhv6bS0rFLRkpC26LK9rqyHc2zkijwi9bNRKxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suman Ghosh <sumang@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 054/325] octeontx2-af: Fix initialization of mcams entry2target_pffunc field
Date: Tue, 16 Jun 2026 20:27:30 +0530
Message-ID: <20260616145100.389181154@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264250-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sumang@marvell.com,m:sbhatta@marvell.com,m:horms@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08E4A691AD5

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suman Ghosh <sumang@marvell.com>

[ Upstream commit 9a85ec3dc28b6df246801c19e4d9bae6297a25b0 ]

NPC mcam entry stores a mapping between mcam entry and target pcifunc.
During initialization of this field, API kmalloc_array has been used which
caused some junk values to array. Whereas, the array is expected to be
initialized by 0. This patch fixes the same by using kcalloc instead of
kmalloc_array.

Fixes: 55307fcb9258 ("octeontx2-af: Add mbox messages to install and delete MCAM rules")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/1780054625-17090-1-git-send-email-sbhatta@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index e28675fe189071..a0d2ed56186d8d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1932,8 +1932,8 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 		goto free_entry_cntr_map;
 
 	/* Alloc memory for saving target device of mcam rule */
-	mcam->entry2target_pffunc = kmalloc_array(mcam->total_entries,
-						  sizeof(u16), GFP_KERNEL);
+	mcam->entry2target_pffunc = kcalloc(mcam->total_entries,
+					    sizeof(u16), GFP_KERNEL);
 	if (!mcam->entry2target_pffunc)
 		goto free_cntr_refcnt;
 
-- 
2.53.0




