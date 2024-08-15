Return-Path: <stable+bounces-68256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A977953161
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F60A1F22D1C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048C1A3BD0;
	Thu, 15 Aug 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sAcMwkp9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E81A3BB6;
	Thu, 15 Aug 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729988; cv=none; b=MyZPz53Auo9w3pQ5NBbRBYHTnLxkl583XgAy+813W6FCgxv/rjekq+Ta2qWQ20MsRS2vR0OQ5cnLkK8V7DLsIXU4MmUgutiiiht8Vj5QcBxUQortR++kibNIPLc9qO4LCq5saPnjCUrCLqr88YA6qQLmmp3x2hgndNzjBtv5bWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729988; c=relaxed/simple;
	bh=5zudftEUisga17DSOZoRgmYwCzgIQAhkqHVSXaxud8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjjYOwZf9HazQrQNGx6tTv1B5gbJh4DYTi3+ZditvFXx4TNEqoUaQ42Qu1fsDbemGb/jkki3DhPw0TzeqfN6xnIk8xhWHpAcFTsYp+sF4hSfWh8jsGw0oWDN3qnNMBIsjCuAoc6qWSlIyfmN5aWYSyEX0K+fk9pRLaGEgNFoTyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sAcMwkp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD5BC32786;
	Thu, 15 Aug 2024 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729988;
	bh=5zudftEUisga17DSOZoRgmYwCzgIQAhkqHVSXaxud8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAcMwkp9tCmZDiGh20ZvCbQMm5zBEFqW8+RcHx9nTPCquPg/jqge7Ees9sfgyC6Rs
	 w2cbEsK+W1qJxVMvJeRPMDkl8qHy4XpE5zKrjE/7cPyb0gBo4ltmb3Cx1xo148TD6q
	 96FaQXWj4dqdKXhlYM2b29ZCuLEBXSoWG6pMBRSo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joy Chakraborty <joychakr@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.15 238/484] rtc: isl1208: Fix return value of nvmem callbacks
Date: Thu, 15 Aug 2024 15:21:36 +0200
Message-ID: <20240815131950.598411456@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

From: Joy Chakraborty <joychakr@google.com>

commit 70f1ae5f0e7f44edf842444044615da7b59838c1 upstream.

Read/write callbacks registered with nvmem core expect 0 to be returned
on success and a negative value to be returned on failure.

isl1208_nvmem_read()/isl1208_nvmem_write() currently return the number of
bytes read/written on success, fix to return 0 on success and negative on
failure.

Fixes: c3544f6f51ed ("rtc: isl1208: Add new style nvmem support to driver")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Link: https://lore.kernel.org/r/20240612080831.1227131-1-joychakr@google.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-isl1208.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -743,14 +743,13 @@ static int isl1208_nvmem_read(void *priv
 {
 	struct isl1208_state *isl1208 = priv;
 	struct i2c_client *client = to_i2c_client(isl1208->rtc->dev.parent);
-	int ret;
 
 	/* nvmem sanitizes offset/count for us, but count==0 is possible */
 	if (!count)
 		return count;
-	ret = isl1208_i2c_read_regs(client, ISL1208_REG_USR1 + off, buf,
+
+	return isl1208_i2c_read_regs(client, ISL1208_REG_USR1 + off, buf,
 				    count);
-	return ret == 0 ? count : ret;
 }
 
 static int isl1208_nvmem_write(void *priv, unsigned int off, void *buf,
@@ -758,15 +757,13 @@ static int isl1208_nvmem_write(void *pri
 {
 	struct isl1208_state *isl1208 = priv;
 	struct i2c_client *client = to_i2c_client(isl1208->rtc->dev.parent);
-	int ret;
 
 	/* nvmem sanitizes off/count for us, but count==0 is possible */
 	if (!count)
 		return count;
-	ret = isl1208_i2c_set_regs(client, ISL1208_REG_USR1 + off, buf,
-				   count);
 
-	return ret == 0 ? count : ret;
+	return isl1208_i2c_set_regs(client, ISL1208_REG_USR1 + off, buf,
+				   count);
 }
 
 static const struct nvmem_config isl1208_nvmem_config = {



