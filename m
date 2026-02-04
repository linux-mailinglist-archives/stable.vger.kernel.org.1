Return-Path: <stable+bounces-213862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPTHG41lg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:28:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 280BFE8A32
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 646C43064926
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA0429823;
	Wed,  4 Feb 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mt5PpEd7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09140B6FF;
	Wed,  4 Feb 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217762; cv=none; b=GhNFu255sVHvuXHDKYQ5iLBEr1PtTZy0OdobyA7ugGg515kk3GPUs/ulgxMS16cIRJHNBJEayaxdQpuuSsPBbVzHhfLCdoKmN9JlCgjgco2pN/909OwAnWDYRz8TQJoKdxNaDTAhV53/0+Sq7/0f3b5ebkxwgbcqz0WG7kNq3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217762; c=relaxed/simple;
	bh=tMu4OhRANmMgZLVZP2Nsd6UwrFRvEfA6xkWAeRrwqzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRV9Dcpe2lJR4KR6H5ujAjcx8Q9ZNNTjkLfDfCutoaHd3GGax2aPSYT7894So8b7r3NX4oNU44GJ1wITp2oF8c6KrArYL3qiWueP45BDFihnN/lV9n1/PV3kUaXuFMBZtt9GFeFZxRfT/YdhOayihbBNQ5mjUPVoBDh8juP2z+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mt5PpEd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ED9C4CEF7;
	Wed,  4 Feb 2026 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217762;
	bh=tMu4OhRANmMgZLVZP2Nsd6UwrFRvEfA6xkWAeRrwqzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mt5PpEd7uEXSHzGE/xlqHphGO365DE8W3s3GIr/zb1Vuqy5AnuvLLTK4cV2WoYMck
	 Su1cqOdKZVAQBueKuLX7LqmXFSOwTo44oJ0ZrYbXP47i05vMbstNEjo7ckr1vjesFo
	 ZL/K0DMFAWOwWaYM9D9cyvFu7kJT14h25itq+AFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 111/280] octeontx2: cn10k: fix RX flowid TCAM mask handling
Date: Wed,  4 Feb 2026 15:38:05 +0100
Message-ID: <20260204143913.639426310@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213862-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 280BFE8A32
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit ab9b218a1521133a4410722907fa7189566be9bc ]

The RX flowid programming initializes the TCAM mask to all ones, but
then overwrites it when clearing the MAC DA mask bits. This results
in losing the intended initialization and may affect other match fields.

Update the code to clear the MAC DA bits using an AND operation, making
the handling of mask[0] consistent with mask[1], where the field-specific
bits are cleared after initializing the mask to ~0ULL.

Fixes: 57d00d4364f3 ("octeontx2-pf: mcs: Match macsec ethertype along with DMAC")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Link: https://patch.msgid.link/20260116164724.2733511-1-alok.a.tiwari@oracle.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 6da8d8f2a8701..60425e6ce0767 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -265,7 +265,7 @@ static int cn10k_mcs_write_rx_flowid(struct otx2_nic *pfvf,
 
 	req->data[0] = FIELD_PREP(MCS_TCAM0_MAC_DA_MASK, mac_da);
 	req->mask[0] = ~0ULL;
-	req->mask[0] = ~MCS_TCAM0_MAC_DA_MASK;
+	req->mask[0] &= ~MCS_TCAM0_MAC_DA_MASK;
 
 	req->data[1] = FIELD_PREP(MCS_TCAM1_ETYPE_MASK, ETH_P_MACSEC);
 	req->mask[1] = ~0ULL;
-- 
2.51.0




