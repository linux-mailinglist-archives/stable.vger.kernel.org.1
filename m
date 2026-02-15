Return-Path: <stable+bounces-216642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKlxDi4ykmmjrwEAu9opvQ
	(envelope-from <stable+bounces-216642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 21:53:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D42613FB51
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 21:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBAA930379B0
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 20:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D33283FC8;
	Sun, 15 Feb 2026 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MyDr4+eu"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474B265621
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188770; cv=none; b=c3cb3+K5/vEXm1XQyjxS9KgVzk+q7JHhv3Dt58xN/bZy8GW5RZNSMn0RMhzclnBA6oGR6ahCkvZKLMRYrh3OhMBCucwQCkyUZZB5QK3mEJTUal8GMwbAizsfEuUxzbszDosnk10/3cP7Pi9yhZXeDsTyHW1aKiA476Vm3oSRHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188770; c=relaxed/simple;
	bh=IaRfvG8hmQqdCiU5gHdwwHAEt2t/xdCLu/2rHPHDMBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6wLNk2Y9CVJ0goOrMiMFTJDLjzE1+hpZVWw/AcdIcn+CDQX30ujlJJXFDsj8UNvCd8JxVLGP8UuE3SngFgC+a3lY2Hj2E4v+q20VMWVN/es8IWCkQNhaJIl/aa9SgWAwYTsVhx7HIFI5h4UTIV+OmIKqG7stgaqJfTqWXIEKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MyDr4+eu; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771188757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y4yLFGf0HuJyxk3nhKGUWRxXjLXHz3M7orS/XBgijeE=;
	b=MyDr4+euL02IC4+VXxYcvssTN0X0GLTlmegXORHSNzzOSyvjqXycitdGbS8kjNWcRdWxz1
	eYUleSUGyg/uhoEXwIkjtopdVJyiPqvrnP/JHY+I7QhPWaqEW0QRJWjbzJsCUsMIsh1wq3
	IadfEfh2clOZk1Xz5e38pTRw7TEQ6GM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Lothar Rubusch <l.rubusch@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: atmel-sha204a - Fix error codes in OTP reads
Date: Sun, 15 Feb 2026 21:51:53 +0100
Message-ID: <20260215205152.518472-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216642-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,microchip.com,bootlin.com,tuxon.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 8D42613FB51
X-Rspamd-Action: no action

Return -EINVAL from atmel_i2c_init_read_otp_cmd() on invalid addresses
instead of -1. Since the OTP zone is accessed in 4-byte blocks, valid
addresses range from 0 to OTP_ZONE_SIZE / 4 - 1. Fix the bounds check
accordingly.

In atmel_sha204a_otp_read(), propagate the actual error code from
atmel_i2c_init_read_otp_cmd() instead of -1. Also, return -EIO instead
of -EINVAL when the device is not ready.

Cc: stable@vger.kernel.org
Fixes: e05ce444e9e5 ("crypto: atmel-sha204a - add reading from otp zone")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Compile-tested only.
---
 drivers/crypto/atmel-i2c.c     | 4 ++--
 drivers/crypto/atmel-sha204a.c | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index 9688d116d07e..ba9d3f593601 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -72,8 +72,8 @@ EXPORT_SYMBOL(atmel_i2c_init_read_config_cmd);
 
 int atmel_i2c_init_read_otp_cmd(struct atmel_i2c_cmd *cmd, u16 addr)
 {
-	if (addr < 0 || addr > OTP_ZONE_SIZE)
-		return -1;
+	if (addr >= OTP_ZONE_SIZE / 4)
+		return -EINVAL;
 
 	cmd->word_addr = COMMAND;
 	cmd->opcode = OPCODE_READ;
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 0fcf4a39de27..6b4e2764523e 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -94,9 +94,10 @@ static int atmel_sha204a_rng_read(struct hwrng *rng, void *data, size_t max,
 static int atmel_sha204a_otp_read(struct i2c_client *client, u16 addr, u8 *otp)
 {
 	struct atmel_i2c_cmd cmd;
-	int ret = -1;
+	int ret;
 
-	if (atmel_i2c_init_read_otp_cmd(&cmd, addr) < 0) {
+	ret = atmel_i2c_init_read_otp_cmd(&cmd, addr);
+	if (ret < 0) {
 		dev_err(&client->dev, "failed, invalid otp address %04X\n",
 			addr);
 		return ret;
@@ -106,7 +107,7 @@ static int atmel_sha204a_otp_read(struct i2c_client *client, u16 addr, u8 *otp)
 
 	if (cmd.data[0] == 0xff) {
 		dev_err(&client->dev, "failed, device not ready\n");
-		return -EINVAL;
+		return -EIO;
 	}
 
 	memcpy(otp, cmd.data+1, 4);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


