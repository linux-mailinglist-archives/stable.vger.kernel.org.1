Return-Path: <stable+bounces-228538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENoxIIJPwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:34:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DFB2F4C4F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1998319961A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C3A3AB29B;
	Mon, 23 Mar 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="URPcP5of"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D2823DD;
	Mon, 23 Mar 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275396; cv=none; b=sINK5Up1vrTdjcvyCTtV1k+yUaYFoxIXKTmbbmd2IbuooGsOMI+FgiPrZV8+CjpYWY8WYZjFBI6sqs3F9euY2nG5EIUexZihm/hqMDze67wUVNJ07GrkrVpL1E4a9/zZb21x53e4uzJrUdLKEFNLSZkRm0As0Qtn4IkmRnC1C1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275396; c=relaxed/simple;
	bh=xPOjjCfFoCOuPC13auCUOjXX1nfq4bgq98XQuMLCblE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faBLRVd+aBd0aGNW1hTIFbJSIRpW39Jg/d32dmf6T2iOhy9RlJU9d4Ht1LsmL9hQUvZfRCVEa+ySWcQoZUZWf3OHBYZubOan/kC1JJdin40A86/zordinF17ayHorsTgeciy70OTiStKB3edr98u1YAuLIhTqdyD/Fn44Z93Ru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=URPcP5of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A9DC4CEF7;
	Mon, 23 Mar 2026 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275396;
	bh=xPOjjCfFoCOuPC13auCUOjXX1nfq4bgq98XQuMLCblE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URPcP5ofUAf4Ao0LOwZQY6Qp/KB/ig8Cn26TjfZh1psZzkjy3E3MDxR83CfLxbPeN
	 pNtCBXMgFjLpbUphL/Gc03H9KvoTzWpxMa3IBb30hfs7ir0OZoL3GMzOmLjJYVwnYj
	 HDKF+7f3Uk4EneB+LMcAPDqTSHX1BYz9eHXVIqxA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 083/460] octeontx2-af: devlink: fix NIX RAS reporter recovery condition
Date: Mon, 23 Mar 2026 14:41:19 +0100
Message-ID: <20260323134528.718578229@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228538-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 17DFB2F4C4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit dc26ca99b835e21e76a58b1463b84adb0ca34f58 ]

The NIX RAS health reporter recovery routine checks nix_af_rvu_int to
decide whether to re-enable NIX_AF_RAS interrupts. This is the RVU
interrupt status field and is unrelated to RAS events, so the recovery
flow may incorrectly skip re-enabling NIX_AF_RAS interrupts.

Check nix_af_rvu_ras instead before writing NIX_AF_RAS_ENA_W1S.

Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Link: https://patch.msgid.link/20260310184824.1183651-1-alok.a.tiwari@oracle.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 06f778baaeef2..79ab91de90e47 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -475,7 +475,7 @@ static int rvu_hw_nix_ras_recover(struct devlink_health_reporter *reporter,
 	if (blkaddr < 0)
 		return blkaddr;
 
-	if (nix_event_ctx->nix_af_rvu_int)
+	if (nix_event_ctx->nix_af_rvu_ras)
 		rvu_write64(rvu, blkaddr, NIX_AF_RAS_ENA_W1S, ~0ULL);
 
 	return 0;
-- 
2.51.0




