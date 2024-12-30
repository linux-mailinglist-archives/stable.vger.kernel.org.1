Return-Path: <stable+bounces-106450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8FA9FE85E
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29AB7A14AA
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7B0537E9;
	Mon, 30 Dec 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MwHxCImp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A115E8B;
	Mon, 30 Dec 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735574016; cv=none; b=nXGCp0sU/dz6xKYRMEnk6qDZyRq9eJHXwKgP4rLuv+7MdR6wGitoAZnQtWik/l5rAwElg1pyC0sx7hQU6R9/BnEexgbLaavr5KuoYf6swjbrsagyBQjmBRh3zu0tfiUxPZi47LL2oBjKvEESi0G45Wyak8SxmlCetkivRXL99+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735574016; c=relaxed/simple;
	bh=0xXxb2D48wJgi7aV6G9EGlgnxi6ryiZq0kthFBsJ6Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3YGEqlY0KmBJcWcCuMiXQ+SXijtkTM3rjQfD5WaoFWdwfKTpJ8H0vega8ZArS+caOn6RaYL3DS90PWI7+OGpKNj9EvRqi2Bs1Wd4MCRXYwZq3h+SPYPoEm5zR9qOF+CYjsForV4ENFfMUsCeFhtFsbFLuy2WnbDt3PKAnHrcKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MwHxCImp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D2AC4CED0;
	Mon, 30 Dec 2024 15:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735574015;
	bh=0xXxb2D48wJgi7aV6G9EGlgnxi6ryiZq0kthFBsJ6Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwHxCImpiH/ZToEUx6F3nR/xK1wpqMuKneF7P0Fo3+vGeO3lYlUAyWiA4UCcGO6K4
	 Nz5CVUEUeKEXPz5c1sAJoxGCls/B/e3O6nFIdZYhgfNgmTxLt/SC+CKA0PoI/Pp3lY
	 Jib7GqWM+n3Q5NwZHD/lOmgTiOsCT/aA2V7lwqRw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zichen Xie <zichenxie0106@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.12 015/114] mtd: diskonchip: Cast an operand to prevent potential overflow
Date: Mon, 30 Dec 2024 16:42:12 +0100
Message-ID: <20241230154218.646018404@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>
References: <20241230154218.044787220@linuxfoundation.org>
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

From: Zichen Xie <zichenxie0106@gmail.com>

commit 9b458e8be0d13e81ed03fffa23f8f9b528bbd786 upstream.

There may be a potential integer overflow issue in inftl_partscan().
parts[0].size is defined as "uint64_t"  while mtd->erasesize and
ip->firstUnit are defined as 32-bit unsigned integer. The result of
the calculation will be limited to 32 bits without correct casting.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/diskonchip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1098,7 +1098,7 @@ static inline int __init inftl_partscan(
 		    (i == 0) && (ip->firstUnit > 0)) {
 			parts[0].name = " DiskOnChip IPL / Media Header partition";
 			parts[0].offset = 0;
-			parts[0].size = mtd->erasesize * ip->firstUnit;
+			parts[0].size = (uint64_t)mtd->erasesize * ip->firstUnit;
 			numparts = 1;
 		}
 



