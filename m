Return-Path: <stable+bounces-94388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 144539D3C63
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85706B2CCC6
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3196A1A4F12;
	Wed, 20 Nov 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfDRXgBJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F71A0BD6
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107892; cv=none; b=STv2c1u7BrvaSQjGL4UsPFkE1pj2mczwvukr6QSsJrk0m8sO5xHNumAeblwqzYfY1a0reVlS3v3Daip9tVHmq2m5/onqKriUiJR2oKQDnqVkodsF34p+2Br4tTwlTKjqbYwctjJC/NKEPaicfizl8mPgjcoEdH4Q3C+/zl5qVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107892; c=relaxed/simple;
	bh=YRlRW2dr/X35MbMORERt540JIGotj+fIL5Rws6l+Iqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwVOqo7gt1pRdLMK8e/AX36pOt4KUTKZl4ISfd5ugpkC9pmpw+ejKeNNM5sJ+kFa+XiIagjO1lbw9mp6QGFCdLtEC7lB/flYyRV0QtxSGVx3sdAxK6F8dG1ZRkPN01M1JxOggqCAu7z4bTTnJ0auw79TsSY6NdNwt//3ghc5198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfDRXgBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E74C4CECD;
	Wed, 20 Nov 2024 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732107891;
	bh=YRlRW2dr/X35MbMORERt540JIGotj+fIL5Rws6l+Iqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KfDRXgBJZ1JCM3jTaYITJxvtGKy5KeJtYXpDgaYMhUY7MnD1ElA0agUZ8uFpS7m4X
	 b99T7YVgq7b3Mj+xT/1Ck7oKNSxPw989phpr2WiIkGd8jZDA45zgLs/dRiDXTekB1k
	 beuvZD6uzZSN/duICE0HzpRLuXQ/oG5zNkcUM9IvnaMkjoraxJlysWRv97ICO2y5ue
	 49MRUsJXQQHvzNuZjzWVQ+oAS2bQcbj8YgOw4fH+C9J8N/Eqejqxg5WtP00WHmXsru
	 SjVCAECFc/Wqhud8EQlzRrFFz/++g7M5tQ+IzR2xfqxRaCZRX9VInxWBcANAgzWLCI
	 8+10p0BnySKGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] char: xillybus: Prevent use-after-free due to race condition
Date: Wed, 20 Nov 2024 08:04:49 -0500
Message-ID: <20241120080303-16fc19393c62f43c@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241120060352.3115727-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 282a4b71816b6076029017a7bab3a9dcee12a920

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Eli Billauer <eli.billauer@gmail.com>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-20 07:57:09.359392384 -0500
+++ /tmp/tmp.xddhwSQUsX	2024-11-20 07:57:09.349600178 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 282a4b71816b6076029017a7bab3a9dcee12a920 ]
+
 The driver for XillyUSB devices maintains a kref reference count on each
 xillyusb_dev structure, which represents a physical device. This reference
 count reaches zero when the device has been disconnected and there are no
@@ -41,15 +43,16 @@
 Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
 Link: https://lore.kernel.org/r/20221030094209.65916-1-eli.billauer@gmail.com
 Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  drivers/char/xillybus/xillyusb.c | 22 +++++++++++++++++++---
  1 file changed, 19 insertions(+), 3 deletions(-)
 
 diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
-index 39bcbfd908b46..5a5afa14ca8cb 100644
+index 3a2a0fb3d928..45771b1a3716 100644
 --- a/drivers/char/xillybus/xillyusb.c
 +++ b/drivers/char/xillybus/xillyusb.c
-@@ -184,6 +184,14 @@ struct xillyusb_dev {
+@@ -185,6 +185,14 @@ struct xillyusb_dev {
  	struct mutex process_in_mutex; /* synchronize wakeup_all() */
  };
  
@@ -64,7 +67,7 @@
  /* FPGA to host opcodes */
  enum {
  	OPCODE_DATA = 0,
-@@ -1237,9 +1245,16 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
+@@ -1234,9 +1242,16 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
  	int rc;
  	int index;
  
@@ -82,7 +85,7 @@
  
  	chan = &xdev->channels[index];
  	filp->private_data = chan;
-@@ -1275,8 +1290,6 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
+@@ -1272,8 +1287,6 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
  	    ((filp->f_mode & FMODE_WRITE) && chan->open_for_write))
  		goto unmutex_fail;
  
@@ -91,7 +94,7 @@
  	if (filp->f_mode & FMODE_READ)
  		chan->open_for_read = 1;
  
-@@ -1413,6 +1426,7 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
+@@ -1410,6 +1423,7 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
  	return rc;
  
  unmutex_fail:
@@ -99,7 +102,7 @@
  	mutex_unlock(&chan->lock);
  	return rc;
  }
-@@ -2227,7 +2241,9 @@ static void xillyusb_disconnect(struct usb_interface *interface)
+@@ -2244,7 +2258,9 @@ static void xillyusb_disconnect(struct usb_interface *interface)
  
  	xdev->dev = NULL;
  
@@ -109,3 +112,6 @@
  }
  
  static struct usb_driver xillyusb_driver = {
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

