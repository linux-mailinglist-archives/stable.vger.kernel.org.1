Return-Path: <stable+bounces-22415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E1085DBEE
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870CDB21337
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3B073161;
	Wed, 21 Feb 2024 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dzj312aO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C94D5B7;
	Wed, 21 Feb 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523226; cv=none; b=bDW+qz2r1E/l+UF7CPNIDM+9FWq6VTrFqabrwzIpNxJrk9Z1HG8kN9VV0UU/WxqM8RhEczljLWQQPggQLupqE79j9SDOCOmtMnWkuGVRU7nYP/MijXYJqYLDJsmPHtKVpAfcKx3vkd4boDG5w07aZKkjM1KJiRNVIiMT/8L+lCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523226; c=relaxed/simple;
	bh=Lbu0tjWT5pJU9Z6b5yOjqCaB+cEZF4SAlP6XSsABSFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+Dpi0WR9yXad4B8YYiBox2BVShbCuV7PctQBg6cxLOyJLFuBCJk6DfQquQfyicGUgzJdoNdSuLgkkbOvjTE7v7Hd1+etoLGklDcni6pawa9zucIQMntZnC/JyH93OI6DC+VWFSQgjjrCec/PoFxepWQ618h9fmMVXA/azPZaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dzj312aO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50923C433C7;
	Wed, 21 Feb 2024 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523225;
	bh=Lbu0tjWT5pJU9Z6b5yOjqCaB+cEZF4SAlP6XSsABSFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzj312aOgHLtEUja5EXpDWGOSassBUtwgZBwqiupwNs5F4irDcUTXwN8eYNLda2cK
	 M6sMYuWDUQo5CdztCEOJ15SXwpIjY6q0OYgUuffzrCSgY7Afvd3su0xFFaQ3c8twEy
	 21za6YMIG+QLrKjhdGARMbs1s3nYGdH1qPRpmzM0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jean Delvare <jdelvare@suse.de>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 372/476] i2c: i801: Remove i801_set_block_buffer_mode
Date: Wed, 21 Feb 2024 14:07:03 +0100
Message-ID: <20240221130021.778800241@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

[ Upstream commit 1e1d6582f483a4dba4ea03445e6f2f05d9de5bcf ]

If FEATURE_BLOCK_BUFFER is set then bit SMBAUXCTL_E32B is supported
and there's no benefit in reading it back. Origin of this check
seems to be 14 yrs ago when people were not completely sure which
chip versions support the block buffer mode.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: c1c9d0f6f7f1 ("i2c: i801: Fix block process call transactions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-i801.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 30b725d11178..8ecba1ca9236 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -519,9 +519,11 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
+	/* Set block buffer mode */
+	outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_E32B, SMBAUXCTL(priv));
+
 	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
 
-	/* Use 32-byte buffer to process this transaction */
 	if (read_write == I2C_SMBUS_WRITE) {
 		len = data->block[0];
 		outb_p(len, SMBHSTDAT0(priv));
@@ -747,14 +749,6 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 	return i801_check_post(priv, status);
 }
 
-static int i801_set_block_buffer_mode(struct i801_priv *priv)
-{
-	outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_E32B, SMBAUXCTL(priv));
-	if ((inb_p(SMBAUXCTL(priv)) & SMBAUXCTL_E32B) == 0)
-		return -EIO;
-	return 0;
-}
-
 /* Block transaction function */
 static int i801_block_transaction(struct i801_priv *priv, union i2c_smbus_data *data,
 				  char read_write, int command)
@@ -783,9 +777,8 @@ static int i801_block_transaction(struct i801_priv *priv, union i2c_smbus_data *
 	/* Experience has shown that the block buffer can only be used for
 	   SMBus (not I2C) block transactions, even though the datasheet
 	   doesn't mention this limitation. */
-	if ((priv->features & FEATURE_BLOCK_BUFFER)
-	 && command != I2C_SMBUS_I2C_BLOCK_DATA
-	 && i801_set_block_buffer_mode(priv) == 0)
+	if ((priv->features & FEATURE_BLOCK_BUFFER) &&
+	    command != I2C_SMBUS_I2C_BLOCK_DATA)
 		result = i801_block_transaction_by_block(priv, data,
 							 read_write,
 							 command);
-- 
2.43.0




