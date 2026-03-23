Return-Path: <stable+bounces-228127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG+RG5tJwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:09:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6B92F3E88
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C0E302A07B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E683AC0E6;
	Mon, 23 Mar 2026 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BOzlPIZc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A953AC0C2;
	Mon, 23 Mar 2026 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274205; cv=none; b=Bj54vbKgEJibgwGD7b3jV7VicaF+evUqiZVqVeSDeABLHKxMKGW+f9ihLt9IpKsYyA8PgtzYFFyNNMh+ThW9mQz1g0s+DdUz64ws4eWl6eDbviFxjWsMa3QQtXL15vOI9oovKw4hJrLlr805xZA8GwCNbD/23l+35XADAG+CPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274205; c=relaxed/simple;
	bh=p6G+Fr/FbnNRrqirKrXcT30zTCSXdJzF2BBzqBN0R8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNVn3jJNnh0m650oYXT+KNNU4qVbJZWzfWFYX6a4iDWrr01rsXncr9lz136u+T4tlJ+Z3OSQgk8UXij8lzSGMNAUi0kZtyP5yYq/hoT9Md/N8wVp8G3tBwERrjQhugpNLk9WfXniL+h1/zXq4T7QerLwEBWAraOD2pKS6au4fuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BOzlPIZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B98AC4CEF7;
	Mon, 23 Mar 2026 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274205;
	bh=p6G+Fr/FbnNRrqirKrXcT30zTCSXdJzF2BBzqBN0R8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOzlPIZcGQsTj+zz0iJhY5JdQJCRTrui6aiqsZHCEAfm6AgeYbNrXFoa9iL3vbRJN
	 UgswvgyUHoJ07vWRx0rKnlCdIy3TyVzcRJ/O7D512Uw4DaKJQpfK+jMgZoGPCfXfXR
	 GRTlyv+VBxRQJxJFa1d4/Xv9IbTm0pE8homldvZg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 143/220] net: bcmgenet: increase WoL poll timeout
Date: Mon, 23 Mar 2026 14:45:20 +0100
Message-ID: <20260323134509.078701088@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228127-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8F6B92F3E88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justin.chen@broadcom.com>

[ Upstream commit 6cfc3bc02b977f2fba5f7268e6504d1931a774f7 ]

Some systems require more than 5ms to get into WoL mode. Increase the
timeout value to 50ms.

Fixes: c51de7f3976b ("net: bcmgenet: add Wake-on-LAN support code")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20260312191852.3904571-1-justin.chen@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 8fb5512882980..96d5d4f7f51fe 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -123,7 +123,7 @@ static int bcmgenet_poll_wol_status(struct bcmgenet_priv *priv)
 	while (!(bcmgenet_rbuf_readl(priv, RBUF_STATUS)
 		& RBUF_STATUS_WOL)) {
 		retries++;
-		if (retries > 5) {
+		if (retries > 50) {
 			netdev_crit(dev, "polling wol mode timeout\n");
 			return -ETIMEDOUT;
 		}
-- 
2.51.0




