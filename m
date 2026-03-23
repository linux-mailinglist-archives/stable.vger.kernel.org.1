Return-Path: <stable+bounces-228871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKhRByBUwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:54:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9BB2F566A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14D6E301B79F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48B26A08F;
	Mon, 23 Mar 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lDQ0foln"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1538F927;
	Mon, 23 Mar 2026 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277360; cv=none; b=oGSWNQTVfFdReMzdu3S+VNWbxRId2nu+rBaY6/QPlE/L4oLbo9wx3NOfpaIW7s41VOK81RSKC/4kLkyXIXgAjytRx9qUYqn5VRA9L//j92llmVwIGo6fgyp1t6RFyQp67BmuZY4gU4sNy376igcUJ9NLDgaDKTXklLp3Wv/l5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277360; c=relaxed/simple;
	bh=wQaVGCXTkwFlQWmZqWaXjfhIw5UEWC0EssPf01Pu2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwcEv4DoWzs8944I/o1RyFNH0gtpz0wPG96wSMCPoWfe+tgiBIsbtKYkNzo+R+9dbYnAgBl49BLErDF8+MyVCGWykMB6Tl7R9GVOPIJvAUfA0rySQXOLh56zKXue8KBFbmrxjFJXuNzf9luqtQY+UB1WP5++4auM+ZMEubd/Rb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lDQ0foln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E741C4CEF7;
	Mon, 23 Mar 2026 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277359;
	bh=wQaVGCXTkwFlQWmZqWaXjfhIw5UEWC0EssPf01Pu2gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDQ0folnMDMGR6D+/ILRo8eKhAAX+DcnUSXAWqe6FhTvies1usnObVqRXhYM0Div9
	 Tyr8/uERK2Uz3rD0XZH0cNYsYPdL/e5cZ3wwztB3su52cByfWYrgY4XL6dU9VAwlAo
	 lcZ4Te+zNY2NzanXXXZLgEUp62fleEoeDZHQG5Ik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 409/460] net: airoha: fix PSE memory configuration in airoha_fe_pse_ports_init()
Date: Mon, 23 Mar 2026 14:46:45 +0100
Message-ID: <20260323134536.604569485@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228871-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BA9BB2F566A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 8e38e08f2c560328a873c35aff1a0dbea6a7d084 ]

Align PSE memory configuration to vendor SDK. In particular, increase
initial value of PSE reserved memory in airoha_fe_pse_ports_init()
routine by the value used for the second Packet Processor Engine (PPE2)
and do not overwrite the default value.

Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet support
for EN7581 SoC")

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241001-airoha-eth-pse-fix-v2-2-9a56cdffd074@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: d4a533ad249e ("net: airoha: Remove airoha_dev_stop() in airoha_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 6aa764b542eb5..cd2e888a8c52e 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1172,11 +1172,13 @@ static void airoha_fe_pse_ports_init(struct airoha_eth *eth)
 		[FE_PSE_PORT_GDM4] = 2,
 		[FE_PSE_PORT_CDM5] = 2,
 	};
+	u32 all_rsv;
 	int q;
 
+	all_rsv = airoha_fe_get_pse_all_rsv(eth);
 	/* hw misses PPE2 oq rsv */
-	airoha_fe_set(eth, REG_FE_PSE_BUF_SET,
-		      PSE_RSV_PAGES * pse_port_num_queues[FE_PSE_PORT_PPE2]);
+	all_rsv += PSE_RSV_PAGES * pse_port_num_queues[FE_PSE_PORT_PPE2];
+	airoha_fe_set(eth, REG_FE_PSE_BUF_SET, all_rsv);
 
 	/* CMD1 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_CDM1]; q++)
-- 
2.51.0




