Return-Path: <stable+bounces-234523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOXaAh+j1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:49:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E4E3C1A21
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FBAB316724A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5B3B19A3;
	Wed,  8 Apr 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sNpaq4KH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0928980F;
	Wed,  8 Apr 2026 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673080; cv=none; b=ePVaDyCgfWUOXj2Tq3TzfVDU8LeafsSanUjjQ0k7QgzTiDQBgUt7iWRZ14+YqKvVuAkR8HV/H9d0S7/oq/moFEz3dhhBIhrk7lA1WMaid3uhl2rzhL6W6mhLAs2now2Gd6+1nrHZjFkY9Eyg+pkYmm21IJVczUZwN2QmPPuf4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673080; c=relaxed/simple;
	bh=dPu0peIh/KM63CeAD6gs27Ep9hrtIXM3dCqr9NP03Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StyHSNOGsB3i2lj6xS8Cgw59RQ259LXq8lORsHoOQD4X1cBErlRD+s2w3Zfio6BCsO4ILChelK6NC2TT15+KIq6IGnvZOFODYoid/EUY659kxgzJVU9KTeJA1alVoOE0Lum2isU5vHpJRNxhCuce5O3mOoFC7WtP1SPdu5r2cjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sNpaq4KH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50933C19421;
	Wed,  8 Apr 2026 18:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673080;
	bh=dPu0peIh/KM63CeAD6gs27Ep9hrtIXM3dCqr9NP03Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sNpaq4KHPSVhDp7VprWTQ1JU8FNLWBTuJOtmRtwR/uJSi6TxfaBHldJ3ZP/6LTHh+
	 qCls2O17j1HIVD48FMBOswchBypWYtP67ucShQDY4rP7EM6kyIVPOo4SMYYbpMFX5f
	 Z4JDbIQBgnbyav3PBuCj8Y+604thSE2UG3lcIhL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 093/277] bnxt_en: Restore default stat ctxs for ULP when resource is available
Date: Wed,  8 Apr 2026 20:01:18 +0200
Message-ID: <20260408175937.346389960@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234523-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75E4E3C1A21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

[ Upstream commit 071dbfa304e85a6b04a593e950d18fa170997288 ]

During resource reservation, if the L2 driver does not have enough
MSIX vectors to provide to the RoCE driver, it sets the stat ctxs for
ULP also to 0 so that we don't have to reserve it unnecessarily.

However, subsequently the user may reduce L2 rings thereby freeing up
some resources that the L2 driver can now earmark for RoCE. In this
case, the driver should restore the default ULP stat ctxs to make
sure that all RoCE resources are ready for use.

The RoCE driver may fail to initialize in this scenario without this
fix.

Fixes: d630624ebd70 ("bnxt_en: Utilize ulp client resources if RoCE is not registered")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20260331065138.948205-4-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 04aa5d9eb8513..d02ccf79e3b6f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7991,6 +7991,8 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 		if (!ulp_msix)
 			bnxt_set_ulp_stat_ctxs(bp, 0);
+		else
+			bnxt_set_dflt_ulp_stat_ctxs(bp);
 
 		if (ulp_msix > bp->ulp_num_msix_want)
 			ulp_msix = bp->ulp_num_msix_want;
-- 
2.53.0




