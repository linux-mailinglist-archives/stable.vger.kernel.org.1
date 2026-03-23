Return-Path: <stable+bounces-229101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE/tLatswWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E122F887F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4ACC31C2A09
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B761A3029;
	Mon, 23 Mar 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lK9YouxD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08035959;
	Mon, 23 Mar 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278063; cv=none; b=nNNTq7ShteRpmrL83uFRI3cni+4ZYldlExNupHS06AKktLwwz0opb1Up2ICF6v3R4teZeE1bM4rGI7qMX02sInyuoPvk/FQhh94kWw+DHIadeG1zsM51N1LOlx+WGhbaLQt2RDVRVh7bZCn2A47nG50g63jDsjM8OjIJnnu4doo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278063; c=relaxed/simple;
	bh=nNS12mTq3a7z3/InwXC4IA4EsFEfbL46O99wlcUuHX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvokFpxuu5a7epgmxrCCeMQYqn8Da+syxTOpPPZsAMqrYIJwSDd/7kcioMSZuO97XUJOyGlPAvV+cUP5zpySHNZomB4MH1fTkJjVkTdhEITraoO/bk7EgTD5vkCmBrUZctfqO4+f/049oLJRnzwndEOKWYVapsgojvmoBXnEv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lK9YouxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729CCC4CEF7;
	Mon, 23 Mar 2026 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278062;
	bh=nNS12mTq3a7z3/InwXC4IA4EsFEfbL46O99wlcUuHX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lK9YouxDZi2o40IRSKu/i3VhhR98IXsMFQWVdgQRW4iZEW6X6KeFjGYb8qLC3bRIz
	 18X23Wyy5VJgGjGC/qtu9wY4uidNQ+/1VQ7T3lYLh0cOK1hJJ5nUgwg0omLA787yfq
	 WBKlaJ4Clc94pnT+A7MIQsiXD1tSvB/Ylb6G9zjI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 147/567] net: dsa: realtek: rtl8365mb: fix rtl8365mb_phy_ocp_write return value
Date: Mon, 23 Mar 2026 14:41:07 +0100
Message-ID: <20260323134537.468439630@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-229101-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,yahoo.com,lunn.ch,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E4E122F887F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mieczyslaw Nalewaj <namiltd@yahoo.com>

[ Upstream commit 7cbe98f7bef965241a5908d50d557008cf998aee ]

Function rtl8365mb_phy_ocp_write() always returns 0, even when an error
occurs during register access. This patch fixes the return value to
propagate the actual error code from regmap operations.

Link: https://lore.kernel.org/netdev/a2dfde3c-d46f-434b-9d16-1e251e449068@yahoo.com/
Fixes: 2796728460b8 ("net: dsa: realtek: rtl8365mb: serialize indirect PHY register access")
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260301-realtek_namiltd_fix1-v1-1-43a6bb707f9c@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 41ea3b5a42b14..318eced8f0d34 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -766,7 +766,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 out:
 	mutex_unlock(&priv->map_lock);
 
-	return 0;
+	return ret;
 }
 
 static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int regnum)
-- 
2.51.0




