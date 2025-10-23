Return-Path: <stable+bounces-189109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BE8C00FA2
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33215505CB2
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE6230F805;
	Thu, 23 Oct 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCucqQbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9FE30EF9E;
	Thu, 23 Oct 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221131; cv=none; b=T5Kh7B9YpX1u1rSkY1Pnw4NbZSQLXuP1lL1/CBgOYwj+7SiqM6TIFyfbUoZ/OGkNWJgMgw+gZI1bm6GOVs7fTX2aeFGwXBN7N03TTzUWncpAaeaRZl/ox7GPRqNm3SBJnBZmTNnP9/l4yEC5538ZLJtakzv9n4dBC1vvS4Ckm8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221131; c=relaxed/simple;
	bh=zZuQXSTIkvfO+rEfdYOWf8tCjPjJZkwTd/3fAJkapCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCXP4eS+aMh4Skp6Jr9aOSKvEZj2IHBT+1uKvC3e+v4chZPhEoya2iSXNgbbeFuehajEPVAJrDy47yVCPD5n6+P3g8Yer0M5G8kmzf4Ll+dQWGVS8Kmux0lUZIJbK7B0JEo/UNKSln7EtCzANEQZKiviPcRD50JbV3h0PgljfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCucqQbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F82C4CEE7;
	Thu, 23 Oct 2025 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761221131;
	bh=zZuQXSTIkvfO+rEfdYOWf8tCjPjJZkwTd/3fAJkapCE=;
	h=From:To:Cc:Subject:Date:From;
	b=sCucqQbNIW0hCXaOQIzqi181nZXFIgKvHtqsWFsvJUnGa+i7fLZ1bn6lmrLKxjHTn
	 /fINNTcf3UHx73XFSwNwpmdj4t03U6y9S5Qsu2ZYL5PektTCn4Vg0NcYErGGVVBcVL
	 xJb8zfQfiBH++Hp5QaStXs2lbvRwTY8RaB7c5faQ4lnGvtLX8HX6V+yuZ2Pr34IkeX
	 FuUzjvUCzO0F8fcfDoAFhn743GVxsInYBpyNrm61l0zZsZ+VU44Lf+JOksQBGjqAbO
	 ZqV6ZxgzYVfxJ2k46cDqz487hdeqGzymut932V54i+z4va4B2wicbi3ch0zxy7z0CO
	 GP9jeC7SLPSzw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBu4X-000000001Tz-1noL;
	Thu, 23 Oct 2025 14:05:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: rfcomm: fix modem control handling
Date: Thu, 23 Oct 2025 14:05:30 +0200
Message-ID: <20251023120530.5685-1-johan@kernel.org>
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

Changes in v2
 - fix a compilation issue discovered before sending v1 but never folded
   into the actual patch...


 net/bluetooth/rfcomm/tty.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 376ce6de84be..b783526ab588 100644
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
@@ -1055,10 +1055,14 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
 static int rfcomm_tty_tiocmget(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = tty->driver_data;
+	struct rfcomm_dlc *dlc = dev->dlc;
+	u8 v24_sig;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
-	return dev->modem_status;
+	rfcomm_dlc_get_modem_status(dlc, &v24_sig);
+
+	return (v24_sig & (TIOCM_DTR | TIOCM_RTS)) | dev->modem_status;
 }
 
 static int rfcomm_tty_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
@@ -1071,23 +1075,15 @@ static int rfcomm_tty_tiocmset(struct tty_struct *tty, unsigned int set, unsigne
 
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


