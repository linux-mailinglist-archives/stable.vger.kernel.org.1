Return-Path: <stable+bounces-129993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC96A8027F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803B33AFFB7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60787264A76;
	Tue,  8 Apr 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BnxDIMB0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D169227EBD;
	Tue,  8 Apr 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112530; cv=none; b=lKHtEIMZqajVJmS4S5m+6CcwGt6+IEzTBKCW9Cz/LiWZ10qkJiSQ7WieL7pet5vgaMxmGrm3rUlSwgtk1WUXc5pUO99RQupyV9mScaNTnvf7WgUe6MzNaOrQAQa7YkD5y4b3i2UIag7j9a/vtzf4p9KX8LHNv6ndN1sBU4opmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112530; c=relaxed/simple;
	bh=5t0SzrmJW93WDDrEDUHL9fK66m/M714F3e/khi51SLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeuC+KCYbhSc3pGwlgGPIIjg6k9cZixuG54WkI2bnHitpd6J38Vs/s+XVky38hODnx/gISZJ/XpOReiQiqUgzwctM+Svb3xglLWMOwLWhAg4rAfEUAQGJmhbt04NRiE39tF7g/N/6+36dZHFkkiIfmPxI/Qj9qO62NylNMbmQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BnxDIMB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA55C4CEE5;
	Tue,  8 Apr 2025 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112530;
	bh=5t0SzrmJW93WDDrEDUHL9fK66m/M714F3e/khi51SLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BnxDIMB0Gi0Qs/pAq9fvGG3iVqKgcywPeXPggcroG089mbc/m+Uok474WojTsy5/F
	 bsxTmm44EzUHokbNohST+hW1Dck2yNX8sUgXRdXWL3RPNoL2AbVtEETdzcYZcYRCha
	 rXL45MEP5dhY09cyvmiCHbEMIuo5+oVR0nqGf1zQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.15 102/279] batman-adv: Ignore own maximum aggregation size during RX
Date: Tue,  8 Apr 2025 12:48:05 +0200
Message-ID: <20250408104829.099909551@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -840,8 +840,7 @@ batadv_v_ogm_aggr_packet(int buff_pos, i
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /**



