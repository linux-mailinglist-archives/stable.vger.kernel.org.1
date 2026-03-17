Return-Path: <stable+bounces-226157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHzOG7WEuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:43:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 031A22AE473
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BDC4309F1CC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B53EBF20;
	Tue, 17 Mar 2026 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z58wO7PU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF53EB7F1;
	Tue, 17 Mar 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765549; cv=none; b=ed62j2r0DFdFK33n6+KvsueKeRuFhCGExXyAiyPj5gFTY6ec0H9M1Ksm4+vVPNLgfu8b1+k5VuPOeEzeo4DKL4J4O8QmLGXUj8tgCaOseZtu3wYDugxp8+iHAjh6eSXkf+gnmLdlSiLSVmvUpQCmxzbB2LBM1VxDmJBikttEoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765549; c=relaxed/simple;
	bh=zc4yEEar0XbTS3qKtFGjfWmuijB4il1JLc+qAE66y70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6uz1Za7xkfftTQw8xd8Kf1dyRKSJGrMTbRFhbwb9F1RDtse3BaTo4ASKt/EFCjnlozfcTXwjz+h/osdxf4hhUPYI/+UsuIyc5AtIZb/b4MiV93HtGrGKpezk0/v2flK02DHAe8bLvUKUBM2GjFcQB+E+s2Uq4Sl3zpu+Oqw2UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z58wO7PU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B308C4CEF7;
	Tue, 17 Mar 2026 16:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765548;
	bh=zc4yEEar0XbTS3qKtFGjfWmuijB4il1JLc+qAE66y70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z58wO7PU7ZSmnI/hcWl38LfIKUHQFS8Nq4bUtJ4zvqZt7D1b+b1UhPa1VnaamW2m4
	 R1YFR5ct8Ec0ai/g+Pn4GXyTFS0dipYWMSiruJCR04zZQA4eLrLFBN9iu+YK4diYOU
	 Q4Tlm3q/NuFLtvVJrykMa3O6S9VSw50N49OkAeyw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 036/378] net: dsa: realtek: rtl8365mb: remove ifOutDiscards from rx_packets
Date: Tue, 17 Mar 2026 17:29:53 +0100
Message-ID: <20260317163008.312306595@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,yahoo.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-226157-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 031A22AE473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mieczyslaw Nalewaj <namiltd@yahoo.com>

[ Upstream commit f76a93241d71fbba8425e3967097b498c29264ed ]

rx_packets should report the number of frames successfully received:
unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
counter) is incorrect and can undercount RX packets. RX drops are
already reported via rx_dropped (e.g. etherStatsDropEvents), so
there is no need to adjust rx_packets.

This patch removes the subtraction of ifOutDiscards from rx_packets
in rtl8365mb_stats_update().

Link: https://lore.kernel.org/netdev/878777925.105015.1763423928520@mail.yahoo.com/
Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260303-realtek_namiltd_fix2-v1-1-bfa433d3401e@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index f938a3f701cc9..31fa94dac627d 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1480,8 +1480,7 @@ static void rtl8365mb_stats_update(struct realtek_priv *priv, int port)
 
 	stats->rx_packets = cnt[RTL8365MB_MIB_ifInUcastPkts] +
 			    cnt[RTL8365MB_MIB_ifInMulticastPkts] +
-			    cnt[RTL8365MB_MIB_ifInBroadcastPkts] -
-			    cnt[RTL8365MB_MIB_ifOutDiscards];
+			    cnt[RTL8365MB_MIB_ifInBroadcastPkts];
 
 	stats->tx_packets = cnt[RTL8365MB_MIB_ifOutUcastPkts] +
 			    cnt[RTL8365MB_MIB_ifOutMulticastPkts] +
-- 
2.51.0




