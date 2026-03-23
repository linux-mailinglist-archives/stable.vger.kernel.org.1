Return-Path: <stable+bounces-228374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GbFBctLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 804AA2F4269
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3685530DCE64
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC93B0AD1;
	Mon, 23 Mar 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="COFQyD+6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695EB3AE18C;
	Mon, 23 Mar 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274943; cv=none; b=U73fAjh9TYa+JA2HnYV2EnJq7Wcba5VIGlLKQ0T0H2w1xi/HwIJ/HdFDF8jnYoxz43P+YF2JpH4KblJGV2Sm9+awH96F7xb2LO5rcvnThxBYgXXq3t6uO5bRGub/dIDZHqcv2wp+k0FFuyPj+bPmtuWjIw5Mmpl1JVIgGa8dyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274943; c=relaxed/simple;
	bh=C7LyFwxtZ72f/usbSW5jayaK48ULsLcks4Db9WGOFOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQdgsSeuVGKpsQDScnxdMvgzXeH4G9CQKm1xBRzHuNlU2keqxgy54/2Kk/fU7j2D0Ukxib5jrKD+FR3eGZFQJ32f+L3R9ugo+VZexDmzGmjikwvZwaEu+EkaYNu2NnFpf95S4Jw0doiHCVaU/dapt2BvIYoMS02cag8SUegCkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=COFQyD+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA82C2BCB5;
	Mon, 23 Mar 2026 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274943;
	bh=C7LyFwxtZ72f/usbSW5jayaK48ULsLcks4Db9WGOFOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COFQyD+6QG5m23dhGPedwLdWhCmI+pcN4kstb7Yr900tjcahP9MlpPlnVIPRNzuo+
	 9k+eoappqGAJn/aTi3fsa7Zq/ZdNtJC4nNZTF8la/A50eDlzwbOFYWh/9IyVp4wqdG
	 tg8dQRtKKFvi/TK9ehDJL/Cph5z+8bGpcJfsSgiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wesley Atwell <atwellwea@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 164/212] netdevsim: drop PSP ext ref on forward failure
Date: Mon, 23 Mar 2026 14:46:25 +0100
Message-ID: <20260323134508.916705622@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228374-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 804AA2F4269
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wesley Atwell <atwellwea@gmail.com>

[ Upstream commit 7d9351435ebba08bbb60f42793175c9dc714d2fb ]

nsim_do_psp() takes an extra reference to the PSP skb extension so the
extension survives __dev_forward_skb(). That forward path scrubs the skb
and drops attached skb extensions before nsim_psp_handle_ext() can
reattach the PSP metadata.

If __dev_forward_skb() fails in nsim_forward_skb(), the function returns
before nsim_psp_handle_ext() can attach that extension to the skb, leaving
the extra reference leaked.

Drop the saved PSP extension reference before returning from the
forward-failure path. Guard the put because plain or non-decapsulated
traffic can also fail forwarding without ever taking the extra PSP
reference.

Fixes: f857478d6206 ("netdevsim: a basic test PSP implementation")
Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
Link: https://patch.msgid.link/20260317061431.1482716-1-atwellwea@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netdevsim/netdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index fa1d97885caaf..06446b03cd9bc 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -109,8 +109,11 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 	int ret;
 
 	ret = __dev_forward_skb(rx_dev, skb);
-	if (ret)
+	if (ret) {
+		if (psp_ext)
+			__skb_ext_put(psp_ext);
 		return ret;
+	}
 
 	nsim_psp_handle_ext(skb, psp_ext);
 
-- 
2.51.0




