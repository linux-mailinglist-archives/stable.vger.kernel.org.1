Return-Path: <stable+bounces-111059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE05A21379
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 22:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B783A13D9
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 21:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9001E3DF8;
	Tue, 28 Jan 2025 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="KdByt2Sd"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3E1DE4E0;
	Tue, 28 Jan 2025 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738098511; cv=none; b=BdKYIH4JnazDs1AJ6OmUYueZphdJSy5sPEoDoimw7HmB20SjlY4cfxaDyORjBPPTcmpzhIc6BVexf9PzLz1WNFoJXLfbycPGh5G1jbEcipx0ui20NGXHqpb9zC1yfdzB1lUz+ao1QSIdWge0MjRluqNWG96mavg4Mhy8gqkLhFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738098511; c=relaxed/simple;
	bh=1WAfUZypPU5Sv9+N2pCHJbqOmPXgv8u++eozdGIHbh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VuqIYpZvjYhdZTUWAiR+tt0IYo8KBHnGt5rHBgnuvT7/ws5a6HmNOe23HnmyAXLTSxZOO+aBeRji4OWMxgjTgS11Ei2D9JGq6gfsWKKBAEbQSLRiUQLhFcCVVlAchkCBCJYkn2Or5k1s7cF61xID7xEYM3bJTl69qgkCm1IMZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=KdByt2Sd; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id C400940777C4;
	Tue, 28 Jan 2025 21:08:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C400940777C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1738098505;
	bh=fVNhuvRBwi7LipVeQQAxSGExIb2oIhiRBE03sQnVxes=;
	h=From:To:Cc:Subject:Date:From;
	b=KdByt2Sd6+0D6C8bBbIDgbAjVtKtIo0MMGN4wtzjSfdRM0yTOrgpeLsqCrDpvkTQh
	 L4iTg5wvRAha31bTbwoDqVAzDHhI1AhlQEg+CvBxmyFCzVEdzKJF3e6hUxPlu1FieD
	 C701spO6m+/bkPxvLEjKgJVMrpeP32enDeJuXCAU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection
Date: Wed, 29 Jan 2025 00:08:14 +0300
Message-Id: <20250128210814.74476-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the possible ways to enable the input MTU auto-selection for L2CAP
connections is supposed to be through passing a special "0" value for it
as a socket option. Commit [1] added one of those into avdtp. However, it
simply wouldn't work because the kernel still treats the specified value
as invalid and denies the setting attempt. Recorded BlueZ logs include the
following: 

  bluetoothd[496]: profiles/audio/avdtp.c:l2cap_connect() setsockopt(L2CAP_OPTIONS): Invalid argument (22)

[1]: https://github.com/bluez/bluez/commit/ae5be371a9f53fed33d2b34748a95a5498fd4b77

Found by Linux Verification Center (linuxtesting.org).

Fixes: 4b6e228e297b ("Bluetooth: Auto tune if input MTU is set to 0")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/bluetooth/l2cap_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 49f97d4138ea..46ea0bee2259 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -710,12 +710,12 @@ static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
 {
 	switch (chan->scid) {
 	case L2CAP_CID_ATT:
-		if (mtu < L2CAP_LE_MIN_MTU)
+		if (mtu && mtu < L2CAP_LE_MIN_MTU)
 			return false;
 		break;
 
 	default:
-		if (mtu < L2CAP_DEFAULT_MIN_MTU)
+		if (mtu && mtu < L2CAP_DEFAULT_MIN_MTU)
 			return false;
 	}
 
-- 
2.39.5


