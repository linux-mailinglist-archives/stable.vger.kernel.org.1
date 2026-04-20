Return-Path: <stable+bounces-239468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFcXIqxL5mkgugEAu9opvQ
	(envelope-from <stable+bounces-239468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:52:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC042EAAB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C45A53001FEC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3041336896;
	Mon, 20 Apr 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U+denBTD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B3330675;
	Mon, 20 Apr 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700330; cv=none; b=AMfNIN8UwhLGlB1dKvbcR6c5/qctg9P0J+3W5TDC3XtaKmhAGNBhwknY1BQPRM2SseG5dhoQf+D6XSP+em3pc2zd26WQBujzPtOIXoByRj0Ua/rwNkunYsO8jOdPXdazDBh6UYjANCDp+4pIuM0TJ2ALNPIU2aml9Vmki9zh8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700330; c=relaxed/simple;
	bh=cTCYzLavO2bTZ04m7erBS+mb15ZeaKEiwVTsbHLQX+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2gFHSrZzSUHsSKLxZcWS5EG6Wb4oeTaWUQIIJso0tuu9YVPmqO9Pr5eFcHkLaS3y81HOp8c1Cek7m4CQPXBp31N5ZM+aWegvl74FOjHDarEOEXftNxa2D/2aDjP2Sw60XK0OkyR6y54/bVXbCr7fLS902m1yKVsAR2R0bOOSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U+denBTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B84DC19425;
	Mon, 20 Apr 2026 15:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700330;
	bh=cTCYzLavO2bTZ04m7erBS+mb15ZeaKEiwVTsbHLQX+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+denBTDuA/Rrdj93wEfJkZP0hSQDz6DiqKCidMYSbwhVjdfY4Rd3DjnIvbMCwYj6
	 wU7A+8i/EXWL6fRZgYvo9dW2piIwCKY2BkFT/lZRIHESofubHUm25NbvHp44tXNDhA
	 v21cPDcqm4R7ZMB210MPO9swC/SaiGUm5Lna6wJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Koskovich <akoskovich@pm.me>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 130/220] net: ipa: fix event ring index not programmed for IPA v5.0+
Date: Mon, 20 Apr 2026 17:41:11 +0200
Message-ID: <20260420153938.709502383@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-239468-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,pm.me:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 69CC042EAAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Koskovich <akoskovich@pm.me>

[ Upstream commit 56007972c0b1e783ca714d6f1f4d6e66e531d21f ]

For IPA v5.0+, the event ring index field moved from CH_C_CNTXT_0 to
CH_C_CNTXT_1. The v5.0 register definition intended to define this
field in the CH_C_CNTXT_1 fmask array but used the old identifier of
ERINDEX instead of CH_ERINDEX.

Without a valid event ring, GSI channels could never signal transfer
completions. This caused gsi_channel_trans_quiesce() to block
forever in wait_for_completion().

At least for IPA v5.2 this resolves an issue seen where runtime
suspend, system suspend, and remoteproc stop all hanged forever. It
also meant the IPA data path was completely non functional.

Fixes: faf0678ec8a0 ("net: ipa: add IPA v5.0 GSI register definitions")
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260403-milos-ipa-v1-2-01e9e4e03d3e@fairphone.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipa/reg/gsi_reg-v5.0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/reg/gsi_reg-v5.0.c b/drivers/net/ipa/reg/gsi_reg-v5.0.c
index 3334d8e20ad28..6c4a7fbe4de94 100644
--- a/drivers/net/ipa/reg/gsi_reg-v5.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v5.0.c
@@ -30,7 +30,7 @@ REG_STRIDE_FIELDS(CH_C_CNTXT_0, ch_c_cntxt_0,
 
 static const u32 reg_ch_c_cntxt_1_fmask[] = {
 	[CH_R_LENGTH]					= GENMASK(23, 0),
-	[ERINDEX]					= GENMASK(31, 24),
+	[CH_ERINDEX]					= GENMASK(31, 24),
 };
 
 REG_STRIDE_FIELDS(CH_C_CNTXT_1, ch_c_cntxt_1,
-- 
2.53.0




