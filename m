Return-Path: <stable+bounces-134142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBBAA9298E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D45A464B91
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABBE2571A1;
	Thu, 17 Apr 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iscpoUGI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173073594D;
	Thu, 17 Apr 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915223; cv=none; b=uP6SfAzLn8v0t97KIxrvUJtR/2GnJA14RgMqt2l/zcuNbv34QlEzt3+gkaw2Hf8nvC5P5jKISGwwTUiN9xrESAbaxhj4jHswAwPckJiUbY2IlYxJfDH+0EDb3t1UBa1AG+aV43Ubd160OcwlSOXPkkLG+0Lnz2Xeo7DGzgWxVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915223; c=relaxed/simple;
	bh=JDg/L1j6BAjcc9oSkhbiRuOWyNgH+xr4mBR29Tq7+jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwCXKI88DLZqrtyzVY8e2bOZnCgDdDkWjSTiYxFiVsGOv8S+7T1Y65OIvUv4j5Rkm+407o+EpJSVUQKicKHx9ypVyPST1v0TiFPSyC1y5kVKCON5g/jKY/pAfhoj0OqQRHPYuO35fp+HHMVAgwaZujB24KM27CeiLhXSJ3Q+QHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iscpoUGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6030EC4CEE7;
	Thu, 17 Apr 2025 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915222;
	bh=JDg/L1j6BAjcc9oSkhbiRuOWyNgH+xr4mBR29Tq7+jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iscpoUGIzc3ztvWPk7S+/pzLVzBU7acRTNYVdbOSAeX/Ux8nzYdKizUwNAb9buX1B
	 eVWs9wuKEazSkjZ9zgCHCaOPsWUoLOI67bDepAxY8pdsoEnyeSJUs13l5HhKL3+tBZ
	 7hxGeIwpESVHwk9QBlyWb08mpBvYiTpQ8Dk3f/rA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 028/393] net: libwx: handle page_pool_dev_alloc_pages error
Date: Thu, 17 Apr 2025 19:47:17 +0200
Message-ID: <20250417175108.725434729@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

From: Chenyuan Yang <chenyuan0y@gmail.com>

[ Upstream commit 7f1ff1b38a7c8b872382b796023419d87d78c47e ]

page_pool_dev_alloc_pages could return NULL. There was a WARN_ON(!page)
but it would still proceed to use the NULL pointer and then crash.

This is similar to commit 001ba0902046
("net: fec: handle page_pool_dev_alloc_pages error").

This is found by our static analysis tool KNighter.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
Reviewed-by: Joe Damato <jdamato@fastly.com>
Link: https://patch.msgid.link/20250407184952.2111299-1-chenyuan0y@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 2b3d6586f44a5..71c891d14fb62 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -309,7 +309,8 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
 		return true;
 
 	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
-	WARN_ON(!page);
+	if (unlikely(!page))
+		return false;
 	dma = page_pool_get_dma_addr(page);
 
 	bi->page_dma = dma;
-- 
2.39.5




