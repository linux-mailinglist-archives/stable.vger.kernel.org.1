Return-Path: <stable+bounces-189108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F20C00F6E
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F39EF4E682E
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3B30FC13;
	Thu, 23 Oct 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brD3sytZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654830FC26;
	Thu, 23 Oct 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220941; cv=none; b=eP0nQDiYeQnLYItHAS+ZWTEvmFe3CXjfuD2yT6D1H4a6sewT3/1j/vPAy9DBTLaeUKQ4SS7Hgtzm1Ghkr6FtwOVcAQ6fHH0zUqj4vZ3SoTcxpVplAXthOK3VdgwfFeZ92oBbqtRarxbZyJSmORaFJAnWduFq+r0fEJIayc+S4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220941; c=relaxed/simple;
	bh=X/bXVnsFFX1j7l4iVi5d7uJN8XifBcvgqzfoAZ2C+6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M6wed6tTncb7R7ob9WzvfNm5MpBtD9p35SNIe4N0UL5PNL1n9T8VIUDDSJdTpUZzyX8obUBda2JmZJPprp0ccL49Zg7tRHixJH/NxqqvpovcpSkW6pPb1Dt6G87TqUSNuBrXCfzcUXVP5tCXxTMpI/wyRZY2/LM8ScuNKvDv5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brD3sytZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B3DC4CEE7;
	Thu, 23 Oct 2025 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761220940;
	bh=X/bXVnsFFX1j7l4iVi5d7uJN8XifBcvgqzfoAZ2C+6Q=;
	h=From:To:Cc:Subject:Date:From;
	b=brD3sytZ88/Ns+kX0HInEWG538O3lWrl4HlPfhOmJ52HsdF/iYwhR5wmV7Qe7bMrR
	 aUSb11ibHqwT7KHFOsGFbjtdpN6uCJBGZ7tnNtdA3b7ZNJTvGJoFIhzXlWAJhv6F2D
	 kCNbqRPkpROT6XuFpAuPRFj40mPNx9wPiTW1r5ZU4G5xYNWvlGk58uDMYsmWnGW+pC
	 7L23Ywnd9D3hPnSbYJtmZJkouktYnUvwN6GDtiyAs0vNRRQ9X5aMBDhswdXyrX6XVg
	 KQZCES4iAMRgBYF6vj/yD3Fc+ARvzbEvPs9ue4gkhDqply+wYYdkvvDh7EmiQSSplz
	 oCRBonbOfvkfA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBu1T-000000001OO-1IXG;
	Thu, 23 Oct 2025 14:02:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: rfcomm: fix modem control handling
Date: Thu, 23 Oct 2025 14:01:26 +0200
Message-ID: <20251023120127.5274-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RFCOMM driver confuses the local and remote modem control signals,
which specifically means that the reported DTR and RTS state will
instead reflect the remote end (i.e. DSR and CTS).

This issue dates back to the original driver (and a follow-on update)
merged in 2002, which resulted in a non-standard implementation of
TIOCMSET that allowed controlling also the TS07.10 IC and DV signals by
mapping them to the RI and DCD input flags, while TIOCMGET failed to
return the actual state of DTR and RTS.

Note that the bogus control of input signals in tiocmset() is just
dead code as those flags will have been masked out by the tty layer
since 2003.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 net/bluetooth/rfcomm/tty.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 376ce6de84be..f20f043cc9b5 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -643,8 +643,8 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
 		tty_port_tty_hangup(&dev->port, true);
 
 	dev->modem_status =
-		((v24_sig & RFCOMM_V24_RTC) ? (TIOCM_DSR | TIOCM_DTR) : 0) |
-		((v24_sig & RFCOMM_V24_RTR) ? (TIOCM_RTS | TIOCM_CTS) : 0) |
+		((v24_sig & RFCOMM_V24_RTC) ? TIOCM_DSR : 0) |
+		((v24_sig & RFCOMM_V24_RTR) ? TIOCM_CTS : 0) |
 		((v24_sig & RFCOMM_V24_IC)  ? TIOCM_RI : 0) |
 		((v24_sig & RFCOMM_V24_DV)  ? TIOCM_CD : 0);
 }
@@ -1055,10 +1055,13 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
 static int rfcomm_tty_tiocmget(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = tty->driver_data;
+	u8 v24_sig;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
-	return dev->modem_status;
+	rfcomm_dlc_get_modem_status(dlc, &v24_sig);
+
+	return (v24_sig & (TIOCM_DTR | TIOCM_RTS)) | dev->modem_status;
 }
 
 static int rfcomm_tty_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
@@ -1071,23 +1074,15 @@ static int rfcomm_tty_tiocmset(struct tty_struct *tty, unsigned int set, unsigne
 
 	rfcomm_dlc_get_modem_status(dlc, &v24_sig);
 
-	if (set & TIOCM_DSR || set & TIOCM_DTR)
+	if (set & TIOCM_DTR)
 		v24_sig |= RFCOMM_V24_RTC;
-	if (set & TIOCM_RTS || set & TIOCM_CTS)
+	if (set & TIOCM_RTS)
 		v24_sig |= RFCOMM_V24_RTR;
-	if (set & TIOCM_RI)
-		v24_sig |= RFCOMM_V24_IC;
-	if (set & TIOCM_CD)
-		v24_sig |= RFCOMM_V24_DV;
 
-	if (clear & TIOCM_DSR || clear & TIOCM_DTR)
+	if (clear & TIOCM_DTR)
 		v24_sig &= ~RFCOMM_V24_RTC;
-	if (clear & TIOCM_RTS || clear & TIOCM_CTS)
+	if (clear & TIOCM_RTS)
 		v24_sig &= ~RFCOMM_V24_RTR;
-	if (clear & TIOCM_RI)
-		v24_sig &= ~RFCOMM_V24_IC;
-	if (clear & TIOCM_CD)
-		v24_sig &= ~RFCOMM_V24_DV;
 
 	rfcomm_dlc_set_modem_status(dlc, v24_sig);
 
-- 
2.49.1


