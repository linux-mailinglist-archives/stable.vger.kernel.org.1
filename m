Return-Path: <stable+bounces-232223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JWsNYr/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7548036DF24
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 023B5305F662
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ED13F8E04;
	Tue, 31 Mar 2026 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MKZu4zOI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8443A4F34;
	Tue, 31 Mar 2026 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976194; cv=none; b=ms7gw0JNcYEZjyhxtEET+NTytet9gCWy/LKI64Osv7Fr7aA5g9KSqqVqWFbjw2Eg7Zp/iL0VUqPp5Z1BW3HDC0e1hrsnnDjzYvL7FoINMkMl5AfUnuOUlCvH1xzGS22FZ2tT7dKYBKv9C8aSpmH0RKxF1nfoMm5I5DqX2xY9oyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976194; c=relaxed/simple;
	bh=SoduhwDq6vOH2BYNUW8e9HSbKRRT4Es1fd7h1JrI8Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7YGYrK00uv6O5/WsjQauxOKjl5TUUvWKXPDCDVGsoVdxkKlo5pfMQiZ5sJj81GaIeodc+nT7xbeOZldWCGUvuNQ97i3J4nFpVesEN/qDcT3VfiVfgZbrNAgs0vz9eQtwdVt+uO/JE/kB7qP+Rkw+tpVZfs+S+gg1FQEcmLgJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MKZu4zOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1375EC19423;
	Tue, 31 Mar 2026 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976194;
	bh=SoduhwDq6vOH2BYNUW8e9HSbKRRT4Es1fd7h1JrI8Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKZu4zOIicnEtImA4CfXoydOggfJWlt4MllmxILM32m/+I4kG8wyXW+vaaTOKYqJ5
	 v1KdGoUjiJn17rKRsV2+saJ4TG2tuYzZl47/ZQI2maFzTUtLgCSaAmb3XyOHYT7/wz
	 hsRItBH896NXvTSuP1abTrxGyOhuhsxEuYr0Zg0Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 242/244] net: bcmasp: Restore programming of TX map vector register
Date: Tue, 31 Mar 2026 18:23:12 +0200
Message-ID: <20260331161750.695582965@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232223-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 7548036DF24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <florian.fainelli@broadcom.com>

commit 18ff09c1b94fa1584b31d3f4e9eecdca29230ce5 upstream.

On ASP versions v2.x we need to program the TX map vector register to
properly exercise end-to-end flow control, otherwise the TX engine can
either lock-up, or cause the hardware calculated checksum to be
wrong/corrupted when multiple back to back packets are being submitted
for transmission. This register defaults to 0, which means no flow
control being applied.

Fixes: e9f31435ee7d ("net: bcmasp: Add support for asp-v3.0")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20250718212242.3447751-1-florian.fainelli@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -815,6 +815,9 @@ static void bcmasp_init_tx(struct bcmasp
 	/* Tx SPB */
 	tx_spb_ctrl_wl(intf, ((intf->channel + 8) << TX_SPB_CTRL_XF_BID_SHIFT),
 		       TX_SPB_CTRL_XF_CTRL2);
+
+	if (intf->parent->tx_chan_offset)
+		tx_pause_ctrl_wl(intf, (1 << (intf->channel + 8)), TX_PAUSE_MAP_VECTOR);
 	tx_spb_top_wl(intf, 0x1e, TX_SPB_TOP_BLKOUT);
 
 	tx_spb_dma_wq(intf, intf->tx_spb_dma_addr, TX_SPB_DMA_READ);



