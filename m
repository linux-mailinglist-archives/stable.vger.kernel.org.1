Return-Path: <stable+bounces-228869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHyzOeVpwWnVSwQAu9opvQ
	(envelope-from <stable+bounces-228869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:27:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645182F81C5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E057313C23E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0110023E33D;
	Mon, 23 Mar 2026 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mQCWA1f7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BE242D9D;
	Mon, 23 Mar 2026 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277355; cv=none; b=Wbr19kaaYo0CfuYkcN9SdRXxJH0ZdjAiz4jOvui2ld18jRCtWYTaaBFtDT5PtnHgSmxJNmZS1j0Oz7p61pGfzngIPwhnJUM1lnhCx4Dl77bb1jq3P3hT4pN+rNwOo9xUqNvxoVJ40zeNBarXg6tjiVH857yqUJ9dy0QBfvQe3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277355; c=relaxed/simple;
	bh=Z/HE2h61CNGjyY4687FSitJ9MS37AhaoVQM0skkZLXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEFP4oVG/x/OU1efFkq0hJe9X9JsjYB5MZY8CDr5DbZlq78mq8OrYFWUrI9+kCM7BGfz1I4WOrO0BH+meCb14o5ZXqN8KBRFVHLI0UWqG7yghBZTSLN700LpJOOzxXHMqHHKuWs6pR7rf7lH+2IHz6yT1kKFsnuMyzBm3zwQkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mQCWA1f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B75C4CEF7;
	Mon, 23 Mar 2026 14:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277354;
	bh=Z/HE2h61CNGjyY4687FSitJ9MS37AhaoVQM0skkZLXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQCWA1f7CTjYgbRW2+gDgCNJeistIW9v0kNjJBVhoOakFWjogfi5K4QoGfmxNH5sq
	 8niBysSMub6SPs+0xyNdAmx4MLtK+8LIb9pBmQgEOuzpSKb+BkDrTvnypwG86QX2HJ
	 EsNMrxykmOImzBC73aUa4b8BVGK6CNIKp4+Rf+Q0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 408/460] net: airoha: read default PSE reserved pages value before updating
Date: Mon, 23 Mar 2026 14:46:44 +0100
Message-ID: <20260323134536.582249397@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228869-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 645182F81C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 1f3e7ff4f296af1f4350f457d5bd82bc825e645a ]

Store the default value for the number of PSE reserved pages in orig_val
at the beginning of airoha_fe_set_pse_oq_rsv routine, before updating it
with airoha_fe_set_pse_queue_rsv_pages().
Introduce airoha_fe_get_pse_all_rsv utility routine.

Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet support
for EN7581 SoC")

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241001-airoha-eth-pse-fix-v2-1-9a56cdffd074@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: d4a533ad249e ("net: airoha: Remove airoha_dev_stop() in airoha_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 20cf7ba9d7508..6aa764b542eb5 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1116,17 +1116,23 @@ static void airoha_fe_set_pse_queue_rsv_pages(struct airoha_eth *eth,
 		      PSE_CFG_WR_EN_MASK | PSE_CFG_OQRSV_SEL_MASK);
 }
 
+static u32 airoha_fe_get_pse_all_rsv(struct airoha_eth *eth)
+{
+	u32 val = airoha_fe_rr(eth, REG_FE_PSE_BUF_SET);
+
+	return FIELD_GET(PSE_ALLRSV_MASK, val);
+}
+
 static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
 				    u32 port, u32 queue, u32 val)
 {
-	u32 orig_val, tmp, all_rsv, fq_limit;
+	u32 orig_val = airoha_fe_get_pse_queue_rsv_pages(eth, port, queue);
+	u32 tmp, all_rsv, fq_limit;
 
 	airoha_fe_set_pse_queue_rsv_pages(eth, port, queue, val);
 
 	/* modify all rsv */
-	orig_val = airoha_fe_get_pse_queue_rsv_pages(eth, port, queue);
-	tmp = airoha_fe_rr(eth, REG_FE_PSE_BUF_SET);
-	all_rsv = FIELD_GET(PSE_ALLRSV_MASK, tmp);
+	all_rsv = airoha_fe_get_pse_all_rsv(eth);
 	all_rsv += (val - orig_val);
 	airoha_fe_rmw(eth, REG_FE_PSE_BUF_SET, PSE_ALLRSV_MASK,
 		      FIELD_PREP(PSE_ALLRSV_MASK, all_rsv));
-- 
2.51.0




