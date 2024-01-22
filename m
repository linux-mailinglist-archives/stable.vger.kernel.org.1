Return-Path: <stable+bounces-14019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4C837F2B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDC11F2B968
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFAF1292C5;
	Tue, 23 Jan 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HPTo2z1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CE7C0A5;
	Tue, 23 Jan 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970979; cv=none; b=IwKPX8M1Dsq0PH+43wv5wmYuTI//p+ilB3V/EaLi1UCIYaFx5AUkVa17ZW3lkQ7mT9drLfuMz43Ld3fTCFg4VK5+RrZejDtHRzvE8Tdx497gBUGOpaSl3Ux8lH3p2MS2VqG5NEpJRkGcl8LkQhSQqAKVL+3sPjAk5KoIgKsmzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970979; c=relaxed/simple;
	bh=zR/sE9iT3EQv8tWiqo5cutfO4QZCJtB/hUdrlafCjcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6Yo3c6ZkYu7AbdiTs+gBr4Rce6tAO34XyKOnhSwOIUPhXuYowVm6I78F6KpYjhtndq6oVvUM39duOGZ9NzLaZwrlAAh64jIVP7YbmzoM8fZfyYZJOr6mPm6E8KxAzUcMkbwi2aKzJwrW4TguLHMSlNiy5Czlh6JnmqPTJL45wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HPTo2z1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F333EC43390;
	Tue, 23 Jan 2024 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970979;
	bh=zR/sE9iT3EQv8tWiqo5cutfO4QZCJtB/hUdrlafCjcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPTo2z1vzsxrzoAR+vnZ7xQPqmvPHKglP4DKj/bRtKcVbLhNS8mPuU5ypVd82APYS
	 dB7n6KBmc43qY1UhNI7UbVVnB7VRCSGdbBv18XC8o2Pc0T1ZqT7dcvO1TgY4dX+skw
	 013eAWblQKx8wx2wadU8RAYrPHPH26FLSmm0d5HI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ronald Monthero <debug.penguin32@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 062/286] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response
Date: Mon, 22 Jan 2024 15:56:08 -0800
Message-ID: <20240122235734.413176244@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronald Monthero <debug.penguin32@gmail.com>

[ Upstream commit 923fb6238cb3ac529aa2bf13b3b1e53762186a8b ]

Under heavy load it is likely that the controller is done
with its own task but the thread unlocking the wait is not
scheduled in time. Increasing IFC_TIMEOUT_MSECS allows the
controller to respond within allowable timeslice of 1 sec.

fsl,ifc-nand 7e800000.nand: Controller is not responding

[<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0x4a)
[<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
[<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
[<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1d0)

Fixes: 82771882d960 ("NAND Machine support for Integrated Flash Controller")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20231118083156.776887-1-debug.penguin32@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/fsl_ifc_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index e345f9d9f8e8..fcda744e8a40 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -21,7 +21,7 @@
 
 #define ERR_BYTE		0xFF /* Value returned for read
 					bytes when read failed	*/
-#define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
+#define IFC_TIMEOUT_MSECS	1000 /* Maximum timeout to wait
 					for IFC NAND Machine	*/
 
 struct fsl_ifc_ctrl;
-- 
2.43.0




