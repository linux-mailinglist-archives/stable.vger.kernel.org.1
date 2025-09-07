Return-Path: <stable+bounces-178214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C8EB47DB4
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1BA17CE70
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADB21D88D0;
	Sun,  7 Sep 2025 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q4dzW3wD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECA14BFA2;
	Sun,  7 Sep 2025 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276128; cv=none; b=jvZcCfLvaL3w545/16W4qGoLXsViRudXNBERuDS1JPWEI53EIra3WQOmH6nu6GJhVzmpHvcwX6hCurbnsujICC7iCatJhGupg23P5Hz/P9+AaqMVLnLnB1/ZrYPmV1n9bry9yw4TGVxkOy6bn9/0+A3DzVhu9mFtSk1HbWO725c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276128; c=relaxed/simple;
	bh=8+9s0FBpG7JNtgk2c2tGRI1U+5+OXPWUUAnuoeaIN1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go85LASM5P3F2nIV8IJjWtjQ2JRMU8ygkWD4zEvDrq2OTPRkEM1XMrhDbhSPdnDKxTq7ttSt/t/1Csw8z/QCjtUUZl5KuNonsNV7T5FdhY1rP1eIdxG7aKn3tpZv0y6uXZ+2AvaVsbT8/56qpblYKb+0j8ZEreoK5CySOM9wMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q4dzW3wD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE348C4CEF0;
	Sun,  7 Sep 2025 20:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276128;
	bh=8+9s0FBpG7JNtgk2c2tGRI1U+5+OXPWUUAnuoeaIN1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4dzW3wD7ftWlQvYGEzqWWi/sep/mH1pyAHkqnxwseSd3bvAnDXnYi3D3m7z03vqm
	 4O22rq+6KiL70o30twlG3xul3oeXbTkkVtbBdJ80QRQ9NqYfLNbg8sL2SkclHLXfaW
	 fE6UAHezmdljY6nwHbrJiscsJxhBV3FuUEZerCf8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanislav Fort <disclosure@aisle.com>,
	Stanislav Fort <stanislav.fort@aisle.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.15 36/64] batman-adv: fix OOB read/write in network-coding decode
Date: Sun,  7 Sep 2025 21:58:18 +0200
Message-ID: <20250907195604.401040965@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
References: <20250907195603.394640159@linuxfoundation.org>
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

From: Stanislav Fort <stanislav.fort@aisle.com>

commit d77b6ff0ce35a6d0b0b7b9581bc3f76d041d4087 upstream.

batadv_nc_skb_decode_packet() trusts coded_len and checks only against
skb->len. XOR starts at sizeof(struct batadv_unicast_packet), reducing
payload headroom, and the source skb length is not verified, allowing an
out-of-bounds read and a small out-of-bounds write.

Validate that coded_len fits within the payload area of both destination
and source sk_buffs before XORing.

Fixes: 2df5278b0267 ("batman-adv: network coding - receive coded packets and decode them")
Cc: stable@vger.kernel.org
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <stanislav.fort@aisle.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/network-coding.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1691,7 +1691,12 @@ batadv_nc_skb_decode_packet(struct batad
 
 	coding_len = ntohs(coded_packet_tmp.coded_len);
 
-	if (coding_len > skb->len)
+	/* ensure dst buffer is large enough (payload only) */
+	if (coding_len + h_size > skb->len)
+		return NULL;
+
+	/* ensure src buffer is large enough (payload only) */
+	if (coding_len + h_size > nc_packet->skb->len)
 		return NULL;
 
 	/* Here the magic is reversed:



