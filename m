Return-Path: <stable+bounces-217302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEloFWTWlWlLVQIAu9opvQ
	(envelope-from <stable+bounces-217302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:10:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C750E15751C
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 214C33034658
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95BE78F39;
	Wed, 18 Feb 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+KMiHrg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC9330672
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771427397; cv=none; b=bgIchQ9knI2xF71LG/HuY7Flnk4UVOfV0Eo/pPpEXKaRfMVzWuRil4EpRGMoWPSfPXemn7uSmmePFV9IjKHJ6TjMWVj4eXrAJatUYJCnnPD8EfybiUs64i/UHqvb3ap8uZWfMNE4fQg9jsFVyXCcW4sLNbToF4y9C4shxYjyxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771427397; c=relaxed/simple;
	bh=nD2q10ThWeIvjvO9WzEUwgKZIjJ/JreIZj5OT5fabdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeUMlN6gDvJG1NVLn8AhXnuov+7A0/v+Kcte6MCzWhGsiDPP+GIpH7ph4M2GPNr1wx3uKwhXiVCXXNFgFCdL1n5YKjYhjAMjk109mKewJ+UBd+oI8B8B85fztibgTawc8wOMemq11xq4hcd0S/zUjje0NhnGEnnWOvby2aj2bMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+KMiHrg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48068127f00so57908645e9.3
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 07:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771427394; x=1772032194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiCCUrdk9XYqcbI+I7lzNNzu+GG7xW/ZdG+JQfCsf/M=;
        b=N+KMiHrgFWHEPKSZoiDJvWVFBaBSeygtPh2iuxwN64QKECidoiB0q+fP+FGNhcJAvD
         N3tmKKwsedRVpOj7hfyH8B2b+go6MP2cGhL/6aGBkOOpvutG88u1vuEbc5MDeVZU8oiN
         G2CaOoR0IoRu4mqjZOL6yR/xrOVixBOZ3XyCnCR6zqkjBtDBuL9Qjv2svWcORL/w5NtE
         7egE5nnsl9scsxbEoSrFpnSNC97KykE+u1tARGtLVTTzNpmIa+TCWzxEHGWY9iXSFU7E
         U8ipA/ftwkRvXnvueZt8edCehJPmTowBTa1QfjoTwjJrYLQLeBQWsw14BLyZQgqS3VWm
         1pWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771427394; x=1772032194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YiCCUrdk9XYqcbI+I7lzNNzu+GG7xW/ZdG+JQfCsf/M=;
        b=FMr7WaUuobrCzHvRLIbwjAOq6HmIdk/47D9AeHmXXC8d9Hx57ud3E5Itoc9u19Ey6A
         A8lR/T0TOZZkfXZ2LMqWk56EWwgya5UrPGan9m7TiM6+x4kaBda5cmXgpb55IV4yNMqP
         dPANBpQGxidoX8tjUTTbguQKbVfd6fzOm+xSxWG5R5DCC8Lkb2BP/3fHL42xeTkqVDOm
         9Qmqv+r6HmdS8PgctW6nFGjenXo3uuTN7MwBaRV3enldH2JNVbeZAUKeTG4bBjxnZga6
         bUZdYm2zJlu77DzZDRiD+rFhiQBj/J8+4jg5pqYybRfPWJMVo6gDO+bX+QgSoGs5cb5Z
         joyw==
X-Forwarded-Encrypted: i=1; AJvYcCWhB/05X4ig4GnmooWiPyaFxcuvyF0sJjz67LbGQ4tP9cPyg1tkZiXrCdbsUbFYV2UmbFm78LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdK/lmqTaCE9zFCQEllwCPC8fvDMyeiLXiaYZI2Fq4NBTqPb1I
	z50vNsU7WTa3ls3MSj28wr1+5xD7ZR2btJfDpn1R9O4bt1jVhJrrgBU3
X-Gm-Gg: AZuq6aLtdVY42IUoA/Yyrb9ipal8JibxOZpltbZgC3n2LCBpHn0e6jRjQIVgGEwNZkf
	jWVTslZ5AoPissU/HHKwJwOew62y6LiDWqLKO0ZAmZ5eLUhxYhaJFEAS0Wpe82csj5DuRoGE2Wa
	sGLMT9Qfh3BwMMBvB2Twhg/WAsy/t0WUS64hXdyiR5mELShjZi0pXuM8tLjWKW6csTYtgwzIYGw
	EcRZUsW3qL88g3Zbw47t7fneqm26fINWcP3waipxADmkPIFoZ/8vO3Qm5lxQGXeGy+LwBEDt1VN
	8qzXQXqeEhVOcQlthD1aMb8DhYo/n00dEOZ5Jhln+e4H9Ha5UBZGVWxxXmD8LJWT9CVp32qkpdJ
	o/kY20tJRiaX1N70KKiOtN2LEVx2bMbHDP2UgrGTJHb+ta/RRj+qWsWRbdt5WRhKcGZlAKdEN9L
	6Vi+aPwJaa4hQeKkCFV9LWvAm/mJj/5kuCAKFgBHAjYjXHrbIhbA0U5F4pjlv4F/axVcqHnrY8K
	njlQm7RgzgmukYElBXfWMmz3v7jhWUJFWrk7BCqgr8rE1Y=
X-Received: by 2002:a05:600d:13:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-4839b4c7242mr20986195e9.5.1771427393465;
        Wed, 18 Feb 2026 07:09:53 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac7d91sm44333116f8f.26.2026.02.18.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 07:09:53 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	stefan.eichenberger@toradex.com,
	francesco.dolcini@toradex.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after last read
Date: Wed, 18 Feb 2026 16:08:50 +0100
Message-ID: <20260218150940.131354-3-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218150940.131354-1-eichest@gmail.com>
References: <20260218150940.131354-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,toradex.com];
	TAGGED_FROM(0.00)[bounces-217302-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eichest@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,toradex.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C750E15751C
X-Rspamd-Action: no action

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

When reading from the I2DR register, right after releasing the bus by
clearing MSTA and MTX, the I2C controller might still generate an
additional clock cycle which can cause devices to misbehave. Ensure to
only read from I2DR after the bus is not busy anymore. Because this
requires polling, the read of the last byte is moved outside of the
interrupt handler.

An example for such a failing transfer is this:
i2ctransfer -y -a 0 w1@0x00 0x02 r1
Error: Sending messages failed: Connection timed out
It does not happen with every device because not all devices react to
the additional clock cycle.

Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/i2c/busses/i2c-imx.c | 51 ++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 56e2a14495a9a..452d120a210b1 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1018,8 +1018,9 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
 	return 0;
 }
 
-static inline void i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
+static inline enum imx_i2c_state i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
 {
+	enum imx_i2c_state next_state = IMX_I2C_STATE_READ_CONTINUE;
 	unsigned int temp;
 
 	if ((i2c_imx->msg->len - 1) == i2c_imx->msg_buf_idx) {
@@ -1033,18 +1034,20 @@ static inline void i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
 				i2c_imx->stopped =  1;
 			temp &= ~(I2CR_MSTA | I2CR_MTX);
 			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-		} else {
-			/*
-			 * For i2c master receiver repeat restart operation like:
-			 * read -> repeat MSTA -> read/write
-			 * The controller must set MTX before read the last byte in
-			 * the first read operation, otherwise the first read cost
-			 * one extra clock cycle.
-			 */
-			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
-			temp |= I2CR_MTX;
-			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+
+			return IMX_I2C_STATE_DONE;
 		}
+		/*
+		 * For i2c master receiver repeat restart operation like:
+		 * read -> repeat MSTA -> read/write
+		 * The controller must set MTX before read the last byte in
+		 * the first read operation, otherwise the first read cost
+		 * one extra clock cycle.
+		 */
+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+		temp |= I2CR_MTX;
+		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+		next_state = IMX_I2C_STATE_DONE;
 	} else if (i2c_imx->msg_buf_idx == (i2c_imx->msg->len - 2)) {
 		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 		temp |= I2CR_TXAK;
@@ -1052,6 +1055,7 @@ static inline void i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
 	}
 
 	i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+	return next_state;
 }
 
 static inline void i2c_imx_isr_read_block_data_len(struct imx_i2c_struct *i2c_imx)
@@ -1088,11 +1092,9 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
 		break;
 
 	case IMX_I2C_STATE_READ_CONTINUE:
-		i2c_imx_isr_read_continue(i2c_imx);
-		if (i2c_imx->msg_buf_idx == i2c_imx->msg->len) {
-			i2c_imx->state = IMX_I2C_STATE_DONE;
+		i2c_imx->state = i2c_imx_isr_read_continue(i2c_imx);
+		if (i2c_imx->state == IMX_I2C_STATE_DONE)
 			wake_up(&i2c_imx->queue);
-		}
 		break;
 
 	case IMX_I2C_STATE_READ_BLOCK_DATA:
@@ -1490,6 +1492,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 			bool is_lastmsg)
 {
 	int block_data = msgs->flags & I2C_M_RECV_LEN;
+	int ret = 0;
 
 	dev_dbg(&i2c_imx->adapter.dev,
 		"<%s> write slave address: addr=0x%x\n",
@@ -1522,10 +1525,20 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 		dev_err(&i2c_imx->adapter.dev, "<%s> read timedout\n", __func__);
 		return -ETIMEDOUT;
 	}
-	if (i2c_imx->is_lastmsg && !i2c_imx->stopped)
-		return i2c_imx_bus_busy(i2c_imx, 0, false);
+	if (i2c_imx->is_lastmsg) {
+		if (!i2c_imx->stopped)
+			ret = i2c_imx_bus_busy(i2c_imx, 0, false);
+		/*
+		 * Only read the last byte of the last message after the bus is
+		 * not busy. Else the controller generates another clock which
+		 * might confuse devices.
+		 */
+		if (!ret)
+			i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = imx_i2c_read_reg(i2c_imx,
+										     IMX_I2C_I2DR);
+	}
 
-	return 0;
+	return ret;
 }
 
 static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
-- 
2.51.0


