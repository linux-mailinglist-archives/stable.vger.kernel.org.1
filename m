Return-Path: <stable+bounces-229130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMEqEgFewWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:36:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D742F68DA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34BB53118A64
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC73B283FC8;
	Mon, 23 Mar 2026 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jKix/9cr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C4282F3A;
	Mon, 23 Mar 2026 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278155; cv=none; b=JqgKmeQxwt0v3X7K+NiwbDXzNV9lmN0yY6epCJ4y291EYF1JHPH6cNr0tg14LJ93j0ALQk5LS14BlqWXMVwwCZspePjrpzR30uuQI9uIkJZ0AylnGUFIM3wM7Zun8dJFTUxLzawcIcEa6JezgFTiiU7MOCVqkHhH4HpYsdR4hIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278155; c=relaxed/simple;
	bh=JoaO1/5oMoxA8ekyg6vRt3BYk6MMDAU0x7s6m5bqNF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCyQSzRtlEPzIv0oBNKDvn4BlKCsradazhK2lNduLS3tg64l06YazgHYZLaw61Gp6Xiqt6wjFsiFVGY9R8mvV/xRsF/HD3k5J29v3mIBWAZdfSu2QqbBR2Db0AhMctBfo4W9NvUWJZdo7a+StMlZ3QLLdMdYRzWeOD8dw+kW5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jKix/9cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AFAC2BCB5;
	Mon, 23 Mar 2026 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278155;
	bh=JoaO1/5oMoxA8ekyg6vRt3BYk6MMDAU0x7s6m5bqNF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKix/9cr5AvIwWVwT/LRbMp6SVIIvGsyCDpfEJp9NxYo7hbX1YwZN4ae2PnpbaGZz
	 dKrNmPy/6rZZqIg2LMTaz6XLCKt0uNSpsLUEoJy8mDBhki2bDC1eJtBMH5QNkWkL2u
	 BBiAczzLgtx3eu6fwc0u9paI0PDomsFKOTExOzvc=
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
Subject: [PATCH 6.6 217/567] net: dsa: realtek: rtl8365mb: remove ifOutDiscards from rx_packets
Date: Mon, 23 Mar 2026 14:42:17 +0100
Message-ID: <20260323134539.196810378@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-229130-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,yahoo.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 41D742F68DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 318eced8f0d34..9d59d93807825 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1482,8 +1482,7 @@ static void rtl8365mb_stats_update(struct realtek_priv *priv, int port)
 
 	stats->rx_packets = cnt[RTL8365MB_MIB_ifInUcastPkts] +
 			    cnt[RTL8365MB_MIB_ifInMulticastPkts] +
-			    cnt[RTL8365MB_MIB_ifInBroadcastPkts] -
-			    cnt[RTL8365MB_MIB_ifOutDiscards];
+			    cnt[RTL8365MB_MIB_ifInBroadcastPkts];
 
 	stats->tx_packets = cnt[RTL8365MB_MIB_ifOutUcastPkts] +
 			    cnt[RTL8365MB_MIB_ifOutMulticastPkts] +
-- 
2.51.0




