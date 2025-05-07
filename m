Return-Path: <stable+bounces-142707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED7AAEBE0
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2BB527163
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0E828DF1F;
	Wed,  7 May 2025 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="roQ30qBU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7F2144C1;
	Wed,  7 May 2025 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645082; cv=none; b=WOUZ8MfwFt0D7fECuat7OUsxCsrTTqzIG1QFJH2vQATiRfINzmvzGcqj9HgUiqMs+dw++nJxSokzcgI4bLmLPu8SWOfZuC1SAL8rc2mMewY+rYZQibCoSRlc61TRYztdY82Et7Um40xlqU/5u2SN3QZbDWnJ2ntQ1RIfj0Rpp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645082; c=relaxed/simple;
	bh=iMUA3LzpM1xILteA01QfAxe6LXCtt5Y69Y2rA80RTGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYqgbI7haT57/t4siITQovj1UCw1eDTve42m8VvzXEwDImvaENhX2QkC5DyRMyubctag5dk41q+KLqWYR+1NeTE2XjLu8oydFXeuIZUDQAah9qu9Ql+iKTP+XYoWaBPI8BJQxyjE/8gxV14Ip9aTg+yZZJB43pBzxHmVKiJrQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=roQ30qBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99534C4CEE2;
	Wed,  7 May 2025 19:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746645082;
	bh=iMUA3LzpM1xILteA01QfAxe6LXCtt5Y69Y2rA80RTGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=roQ30qBUDiOtWYUiWRL7rpO67fPj/WMzEnqPi6fijmR4zGNs85PRYLveMsMwi04C5
	 TtH3M2HMVdXiiVRLu54cRFT/ZQ+CIpdBg37tJZisDHnMxC3S/Wuq1tXvUFZK7LSK48
	 HiBRWWOOQ82bLSaWlvFx24F2HfHcpDelxMut/wN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 058/129] Bluetooth: L2CAP: copy RX timestamp to new fragments
Date: Wed,  7 May 2025 20:39:54 +0200
Message-ID: <20250507183815.882637906@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183813.500572371@linuxfoundation.org>
References: <20250507183813.500572371@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 3908feb1bd7f319a10e18d84369a48163264cc7d ]

Copy timestamp too when allocating new skb for received fragment.
Fixes missing RX timestamps with fragmentation.

Fixes: 4d7ea8ee90e4 ("Bluetooth: L2CAP: Fix handling fragmented length")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d4dcdb2370cc9..72ee41b894a52 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7386,6 +7386,9 @@ static int l2cap_recv_frag(struct l2cap_conn *conn, struct sk_buff *skb,
 			return -ENOMEM;
 		/* Init rx_len */
 		conn->rx_len = len;
+
+		skb_set_delivery_time(conn->rx_skb, skb->tstamp,
+				      skb->tstamp_type);
 	}
 
 	/* Copy as much as the rx_skb can hold */
-- 
2.39.5




