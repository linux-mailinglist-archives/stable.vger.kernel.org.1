Return-Path: <stable+bounces-126358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26727A70109
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C245919A6531
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBAA269AE9;
	Tue, 25 Mar 2025 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fe3yqY1a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3125BAAA;
	Tue, 25 Mar 2025 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906076; cv=none; b=F0bH8Rarj0TqGc066Fx5h6ueTsnePVWckIiwScFJUT+oAssG8JwPHIC7mHGgww+zZlMioCkF02zzzJrktJfaMZ1MC4/7+FXd5A52VfJlxPYxewj7U4qJCeiYnn5WW8RyUmrT1B/MzD/JHSj8ymu0avZihf0UsFyF7MmSYnIioB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906076; c=relaxed/simple;
	bh=lo3qOCPVnM08nK5szSzen9UaWrQ5O/Ja2UwNIRSAfew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ywf7vjYXQA/GRDQH9OB35/PVo/8MJCo6RfplAl4F+u8kTKjmbk2rEYKxEHDDZHm2QvlrbFxe0HkDztX7aTHwRQWIefa+cgLoJrVrvhXk8sX+zrNcto+PSpQIIrM5qxHJKgGYlata1w91wb7MO/yDS2TeHbPAiUzy95/jf68lsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fe3yqY1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6318C4CEE9;
	Tue, 25 Mar 2025 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906075;
	bh=lo3qOCPVnM08nK5szSzen9UaWrQ5O/Ja2UwNIRSAfew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fe3yqY1aNWa7g/OMSKtxZYL4Go9ja7RPuQ5/CnuroZu2H0/uveISm1y9mNpNLVYG9
	 bgV6+8hHXb7ee+77uHgIABS4HeTlg96ZoRmMIrcmtkWWEI9o3IjJcX7fL5vzsFrHSy
	 gdsk/EFSHYaZQn1WheSkDoQGSWBgnBKYzzMWgf4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 6.13 091/119] batman-adv: Ignore own maximum aggregation size during RX
Date: Tue, 25 Mar 2025 08:22:29 -0400
Message-ID: <20250325122151.384808627@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
References: <20250325122149.058346343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 548b0c5de7619ef53bbde5590700693f2f6d2a56 upstream.

An OGMv1 and OGMv2 packet receive processing were not only limited by the
number of bytes in the received packet but also by the nodes maximum
aggregation packet size limit. But this limit is relevant for TX and not
for RX. It must not be enforced by batadv_(i)v_ogm_aggr_packet to avoid
loss of information in case of a different limit for sender and receiver.

This has a minor side effect for B.A.T.M.A.N. IV because the
batadv_iv_ogm_aggr_packet is also used for the preprocessing for the TX.
But since the aggregation code itself will not allow more than
BATADV_MAX_AGGREGATION_BYTES bytes, this check was never triggering (in
this context) prior of removing it.

Cc: stable@vger.kernel.org
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Fixes: 9323158ef9f4 ("batman-adv: OGMv2 - implement originators logic")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_iv_ogm.c |    3 +--
 net/batman-adv/bat_v_ogm.c  |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -325,8 +325,7 @@ batadv_iv_ogm_aggr_packet(int buff_pos,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /* send a batman ogm to a given interface */
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -839,8 +839,7 @@ batadv_v_ogm_aggr_packet(int buff_pos, i
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /**



