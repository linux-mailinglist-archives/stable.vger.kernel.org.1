Return-Path: <stable+bounces-58635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE3692B7F5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C897C284C52
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5963C1586C9;
	Tue,  9 Jul 2024 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jqnzuogg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DD158201;
	Tue,  9 Jul 2024 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524539; cv=none; b=fzJBF2+PERkPs1mMxI7kQGmGNeyPXJPa34O+QwIFfGyIuIjPbjmWCf9PtTbxk/tAXGYXHR84nhfHsNqnpyPxY/ARLmRNirq0bdfD1QdUxlo1avvbcZgwSwO/Hh17dFsA6okvHDHMsOnbHn2xISr4XMY0oFgNnfyIcnC0jCfG1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524539; c=relaxed/simple;
	bh=EJiGuGyJ4aRzoiFhAqPKq2PO+cz1NQp7DFSY3BMTlBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=entdhNsegpmGkNUxu3Kpc2/G14kSmFTbdbT9Q2R2lDdZA8Ja9BRT2sVnwlASluvdzYmEQ4fGYUcFYfANH4pWsGVdy7Yo70d/bLzRTy9O4ActOnJpv6vCnMvMED7uL9kf8esAyeipfixwiHLKOzCO3OwDgBdOzJ2Foi/nz4imkaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jqnzuogg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A18CC3277B;
	Tue,  9 Jul 2024 11:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524538;
	bh=EJiGuGyJ4aRzoiFhAqPKq2PO+cz1NQp7DFSY3BMTlBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqnzuogg2WRX2ES9rgTTgDTsmw7at4fhufwIbt77TV11qyGlrPOfpf2rFOsj70ibR
	 bLcPgGRKs5Iff8yXKokkUbwzJyHW4pvRaWWTk/2liiAnP0Ndlxa4U3HYD65c2Vv+IV
	 BR22STg8s82IDtI+RzrUQteCEtzmLuerO6wArJA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bunk <micha@freedict.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 017/102] media: dw2102: Dont translate i2c read into write
Date: Tue,  9 Jul 2024 13:09:40 +0200
Message-ID: <20240709110652.040462012@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
References: <20240709110651.353707001@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bunk <micha@freedict.org>

[ Upstream commit 0e148a522b8453115038193e19ec7bea71403e4a ]

The code ignored the I2C_M_RD flag on I2C messages.  Instead it assumed
an i2c transaction with a single message must be a write operation and a
transaction with two messages would be a read operation.

Though this works for the driver code, it leads to problems once the i2c
device is exposed to code not knowing this convention.  For example,
I did "insmod i2c-dev" and issued read requests from userspace, which
were translated into write requests and destroyed the EEPROM of my
device.

So, just check and respect the I2C_M_READ flag, which indicates a read
when set on a message.  If it is absent, it is a write message.

Incidentally, changing from the case statement to a while loop allows
the code to lift the limitation to two i2c messages per transaction.

There are 4 more *_i2c_transfer functions affected by the same behaviour
and limitation that should be fixed in the same way.

Link: https://lore.kernel.org/linux-media/20220116112238.74171-2-micha@freedict.org
Signed-off-by: Michael Bunk <micha@freedict.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/dw2102.c | 120 ++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 47 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 356fc728d59a8..0da3e83389d7a 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -716,6 +716,7 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 {
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	struct dw2102_state *state;
+	int j;
 
 	if (!d)
 		return -ENODEV;
@@ -729,11 +730,11 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		return -EAGAIN;
 	}
 
-	switch (num) {
-	case 1:
-		switch (msg[0].addr) {
+	j = 0;
+	while (j < num) {
+		switch (msg[j].addr) {
 		case SU3000_STREAM_CTRL:
-			state->data[0] = msg[0].buf[0] + 0x36;
+			state->data[0] = msg[j].buf[0] + 0x36;
 			state->data[1] = 3;
 			state->data[2] = 0;
 			if (dvb_usb_generic_rw(d, state->data, 3,
@@ -745,61 +746,86 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			if (dvb_usb_generic_rw(d, state->data, 1,
 					state->data, 2, 0) < 0)
 				err("i2c transfer failed.");
-			msg[0].buf[1] = state->data[0];
-			msg[0].buf[0] = state->data[1];
+			msg[j].buf[1] = state->data[0];
+			msg[j].buf[0] = state->data[1];
 			break;
 		default:
-			if (3 + msg[0].len > sizeof(state->data)) {
-				warn("i2c wr: len=%d is too big!\n",
-				     msg[0].len);
+			/* if the current write msg is followed by a another
+			 * read msg to/from the same address
+			 */
+			if ((j+1 < num) && (msg[j+1].flags & I2C_M_RD) &&
+			    (msg[j].addr == msg[j+1].addr)) {
+				/* join both i2c msgs to one usb read command */
+				if (4 + msg[j].len > sizeof(state->data)) {
+					warn("i2c combined wr/rd: write len=%d is too big!\n",
+					    msg[j].len);
+					num = -EOPNOTSUPP;
+					break;
+				}
+				if (1 + msg[j+1].len > sizeof(state->data)) {
+					warn("i2c combined wr/rd: read len=%d is too big!\n",
+					    msg[j+1].len);
+					num = -EOPNOTSUPP;
+					break;
+				}
+
+				state->data[0] = 0x09;
+				state->data[1] = msg[j].len;
+				state->data[2] = msg[j+1].len;
+				state->data[3] = msg[j].addr;
+				memcpy(&state->data[4], msg[j].buf, msg[j].len);
+
+				if (dvb_usb_generic_rw(d, state->data, msg[j].len + 4,
+					state->data, msg[j+1].len + 1, 0) < 0)
+					err("i2c transfer failed.");
+
+				memcpy(msg[j+1].buf, &state->data[1], msg[j+1].len);
+				j++;
+				break;
+			}
+
+			if (msg[j].flags & I2C_M_RD) {
+				/* single read */
+				if (1 + msg[j].len > sizeof(state->data)) {
+					warn("i2c rd: len=%d is too big!\n", msg[j].len);
+					num = -EOPNOTSUPP;
+					break;
+				}
+
+				state->data[0] = 0x09;
+				state->data[1] = 0;
+				state->data[2] = msg[j].len;
+				state->data[3] = msg[j].addr;
+				memcpy(&state->data[4], msg[j].buf, msg[j].len);
+
+				if (dvb_usb_generic_rw(d, state->data, 4,
+					state->data, msg[j].len + 1, 0) < 0)
+					err("i2c transfer failed.");
+
+				memcpy(msg[j].buf, &state->data[1], msg[j].len);
+				break;
+			}
+
+			/* single write */
+			if (3 + msg[j].len > sizeof(state->data)) {
+				warn("i2c wr: len=%d is too big!\n", msg[j].len);
 				num = -EOPNOTSUPP;
 				break;
 			}
 
-			/* always i2c write*/
 			state->data[0] = 0x08;
-			state->data[1] = msg[0].addr;
-			state->data[2] = msg[0].len;
+			state->data[1] = msg[j].addr;
+			state->data[2] = msg[j].len;
 
-			memcpy(&state->data[3], msg[0].buf, msg[0].len);
+			memcpy(&state->data[3], msg[j].buf, msg[j].len);
 
-			if (dvb_usb_generic_rw(d, state->data, msg[0].len + 3,
+			if (dvb_usb_generic_rw(d, state->data, msg[j].len + 3,
 						state->data, 1, 0) < 0)
 				err("i2c transfer failed.");
+		} // switch
+		j++;
 
-		}
-		break;
-	case 2:
-		/* always i2c read */
-		if (4 + msg[0].len > sizeof(state->data)) {
-			warn("i2c rd: len=%d is too big!\n",
-			     msg[0].len);
-			num = -EOPNOTSUPP;
-			break;
-		}
-		if (1 + msg[1].len > sizeof(state->data)) {
-			warn("i2c rd: len=%d is too big!\n",
-			     msg[1].len);
-			num = -EOPNOTSUPP;
-			break;
-		}
-
-		state->data[0] = 0x09;
-		state->data[1] = msg[0].len;
-		state->data[2] = msg[1].len;
-		state->data[3] = msg[0].addr;
-		memcpy(&state->data[4], msg[0].buf, msg[0].len);
-
-		if (dvb_usb_generic_rw(d, state->data, msg[0].len + 4,
-					state->data, msg[1].len + 1, 0) < 0)
-			err("i2c transfer failed.");
-
-		memcpy(msg[1].buf, &state->data[1], msg[1].len);
-		break;
-	default:
-		warn("more than 2 i2c messages at a time is not handled yet.");
-		break;
-	}
+	} // while
 	mutex_unlock(&d->data_mutex);
 	mutex_unlock(&d->i2c_mutex);
 	return num;
-- 
2.43.0




