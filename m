Return-Path: <stable+bounces-156781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E925DAE5124
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED731B63591
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7F4315A;
	Mon, 23 Jun 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lV4iYRlG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0E7080C;
	Mon, 23 Jun 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714250; cv=none; b=rLheA547ruU2igixumYTRawV0/JxaTc9rD1cW2pONlYDiFlFqMOHTUa/js0gorc+Y5lJa3omXD19Z7I5xJjQuDAUh62Jy6dYnu6xweoB+3QOn7PBURT8xIAM0E6uQgjgT3fod7AlLvSSVF158JIwi62ocJSZL/DTkRBs2JQ0BoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714250; c=relaxed/simple;
	bh=OYF6JEeYmTovcQ2W+skiwZ8w8ggeh2HS49b6ixZmZDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3O9oTe8I7HwartXXQxb+LgKhc847foOgnxc37DhPg5yoIhsD7VJ9SiIujJvnkR0uCLqnq+aJltahtugicJ6LUGulIq4SJoogff5cvu05NZo75h7dNo2JaB7T2nNlIol8qwHpaUrJ2Q8r0xLkBn+kAIf4w0ThK8ePbgNT8cRfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lV4iYRlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5159C4CEEA;
	Mon, 23 Jun 2025 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714250;
	bh=OYF6JEeYmTovcQ2W+skiwZ8w8ggeh2HS49b6ixZmZDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lV4iYRlG3nZVtwpfpdjpzXc2o3rHOD1fQL9MTCfE72tz/7/28FNFan8Fb+YCX6Nps
	 zN+xS7rKL1bN/qE4PYRDU4EdV+nyeu+Wxky0EW/qSOR0+qgX5sFuoIOFPdFwFxacvj
	 25uaC2/PutfKLTD3/UnccVRyO6wNGH33l1Wd6wXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wan Junjie <junjie.wan@inceptio.ai>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 6.12 091/414] bus: fsl-mc: fix GET/SET_TAILDROP command ids
Date: Mon, 23 Jun 2025 15:03:48 +0200
Message-ID: <20250623130644.366649886@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wan Junjie <junjie.wan@inceptio.ai>

commit c78230ad34f82c6c0e0e986865073aeeef1f5d30 upstream.

Command ids for taildrop get/set can not pass the check when they are
using from the restool user space utility. Correct them according to the
user manual.

Fixes: d67cc29e6d1f ("bus: fsl-mc: list more commands as accepted through the ioctl")
Signed-off-by: Wan Junjie <junjie.wan@inceptio.ai>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: stable@vger.kernel.org
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20250408105814.2837951-4-ioana.ciornei@nxp.com
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/fsl-mc/fsl-mc-uapi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/bus/fsl-mc/fsl-mc-uapi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -275,13 +275,13 @@ static struct fsl_mc_cmd_desc fsl_mc_acc
 		.size = 8,
 	},
 	[DPSW_GET_TAILDROP] = {
-		.cmdid_value = 0x0A80,
+		.cmdid_value = 0x0A90,
 		.cmdid_mask = 0xFFF0,
 		.token = true,
 		.size = 14,
 	},
 	[DPSW_SET_TAILDROP] = {
-		.cmdid_value = 0x0A90,
+		.cmdid_value = 0x0A80,
 		.cmdid_mask = 0xFFF0,
 		.token = true,
 		.size = 24,



