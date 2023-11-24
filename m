Return-Path: <stable+bounces-2333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4137F83BC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7FC1C24B60
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80386381CB;
	Fri, 24 Nov 2023 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CNua7lxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C6339BE;
	Fri, 24 Nov 2023 19:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDBCC433C8;
	Fri, 24 Nov 2023 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853623;
	bh=3EcB/3ubyGGjFwBasAvhrpNgystd5x2F2DGBxet6C8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNua7lxhQiT/lMZV81CYOIYIFvKrY7nxGQAx4c/+na4dMp9Ut50LFnXKcRPDXt3uT
	 HfkTH+q+zvrUcXCxCh5pqSY6/97r1Fycb/M0qzAe7kzfvzBP0XQRMXo7H6GYY/2Zlu
	 UmGOZ5INSKe3a3tbDKPuwpvqBAtUicUqiQT8dk70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jean Delvare <jdelvare@suse.de>,
	Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 5.15 262/297] i2c: i801: fix potential race in i801_block_transaction_byte_by_byte
Date: Fri, 24 Nov 2023 17:55:04 +0000
Message-ID: <20231124172009.327147508@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

commit f78ca48a8ba9cdec96e8839351e49eec3233b177 upstream.

Currently we set SMBHSTCNT_LAST_BYTE only after the host has started
receiving the last byte. If we get e.g. preempted before setting
SMBHSTCNT_LAST_BYTE, the host may be finished with receiving the byte
before SMBHSTCNT_LAST_BYTE is set.
Therefore change the code to set SMBHSTCNT_LAST_BYTE before writing
SMBHSTSTS_BYTE_DONE for the byte before the last byte. Now the code
is also consistent with what we do in i801_isr_byte_done().

Reported-by: Jean Delvare <jdelvare@suse.com>
Closes: https://lore.kernel.org/linux-i2c/20230828152747.09444625@endymion.delvare/
Cc: stable@vger.kernel.org
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-i801.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -702,15 +702,11 @@ static int i801_block_transaction_byte_b
 		return i801_check_post(priv, result ? priv->status : -ETIMEDOUT);
 	}
 
-	for (i = 1; i <= len; i++) {
-		if (i == len && read_write == I2C_SMBUS_READ)
-			smbcmd |= SMBHSTCNT_LAST_BYTE;
-		outb_p(smbcmd, SMBHSTCNT(priv));
-
-		if (i == 1)
-			outb_p(inb(SMBHSTCNT(priv)) | SMBHSTCNT_START,
-			       SMBHSTCNT(priv));
+	if (len == 1 && read_write == I2C_SMBUS_READ)
+		smbcmd |= SMBHSTCNT_LAST_BYTE;
+	outb_p(smbcmd | SMBHSTCNT_START, SMBHSTCNT(priv));
 
+	for (i = 1; i <= len; i++) {
 		status = i801_wait_byte_done(priv);
 		if (status)
 			goto exit;
@@ -733,9 +729,12 @@ static int i801_block_transaction_byte_b
 			data->block[0] = len;
 		}
 
-		/* Retrieve/store value in SMBBLKDAT */
-		if (read_write == I2C_SMBUS_READ)
+		if (read_write == I2C_SMBUS_READ) {
 			data->block[i] = inb_p(SMBBLKDAT(priv));
+			if (i == len - 1)
+				outb_p(smbcmd | SMBHSTCNT_LAST_BYTE, SMBHSTCNT(priv));
+		}
+
 		if (read_write == I2C_SMBUS_WRITE && i+1 <= len)
 			outb_p(data->block[i+1], SMBBLKDAT(priv));
 



