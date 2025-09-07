Return-Path: <stable+bounces-178069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E719BB47D1C
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1197AFB23
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD18284B59;
	Sun,  7 Sep 2025 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ba+GS6WI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63B22F74D;
	Sun,  7 Sep 2025 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757275665; cv=none; b=Khyty3XNX278PlJZlcjCuHqMqwQryWKwZ/s3okROSSrFHwuXukRRit3lUgWJZESOOrCrn/e9qOyKTPeMPZdTjukD0FrQ8i1hwYlpQ3DgQzbhbw+jU9vkjFogPQ1EnuSR2Xl8wGvB0UmRD4s03518PVZPb2eHEpIiH37DQb5hk4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757275665; c=relaxed/simple;
	bh=WThjMvazsoflfMpWqmpix0/eb4Rqt4RVP/OWVwNTOFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBMAoHkWSyrbHQ/xB5vySOoJCqb1xAa50580QGb4Hov2REwrVbvxrN2UMo2zScWU8B8S+GFuue+RRXXa//Ij7QBRKiIKIZuj5u7NTXnO63BeDas4VnDGhVp7y2uEpTT3+ICxDSmvVpCsk82RllnDvsidMdSZSX0VGosLKdH/4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ba+GS6WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B911C4CEF0;
	Sun,  7 Sep 2025 20:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757275665;
	bh=WThjMvazsoflfMpWqmpix0/eb4Rqt4RVP/OWVwNTOFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ba+GS6WIv9KYPgRzGlufZs5Eo1XzfjRi6gF7yvLIJT8XSn3eLmaT7gyX39nyV+wGF
	 Pyv6SkUBo35a7xQ424L0x+9LViejOBi6yu6i4vH1R0UKZJ5CVs1mK2eROldGnlri4v
	 1yqlTlZXcCgWi8TGw7Y6utLfsd8YsQrKX41SvAfw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanislav Fort <disclosure@aisle.com>,
	Stanislav Fort <stanislav.fort@aisle.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.10 25/52] batman-adv: fix OOB read/write in network-coding decode
Date: Sun,  7 Sep 2025 21:57:45 +0200
Message-ID: <20250907195602.725469429@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195601.957051083@linuxfoundation.org>
References: <20250907195601.957051083@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1700,7 +1700,12 @@ batadv_nc_skb_decode_packet(struct batad
 
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



