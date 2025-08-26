Return-Path: <stable+bounces-175289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6572B366E8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7782CB61C5C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615B34A338;
	Tue, 26 Aug 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aZQMH0Z4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6622083;
	Tue, 26 Aug 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216643; cv=none; b=mwL1LiHgoIFef8nOiRbb0D+hfz2X/uH6aQXN22RQ4IEBSZOjZiN+MdxCTgRnl4p6bhRoQdx25CAEzHt1956FNysIJBKKpM2Op387gEZgtu4LYKR5XxWNaU63yvsdnuOIHoIzuiAg3a594reu33rUD/WU+dJ1hllW5SZc8zNP2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216643; c=relaxed/simple;
	bh=j4sOscvmNWqyPtTojTsa64lXIwrjNmvjcFPKQJkqcmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/C6ML5oaZ549EmETuo+dB+msVPtwY12rsar75a8oe4QmLM7GKNw46ykwcCPMC949LgcmpPRvbl9AoakqQ95vuUOf5+i86tk1RHPPFSRuyvaKMqymuMCTc7brMhlyX+xdHBN11QJ89YOsSWbxzcRY/Zq8Qojt28fUKqI/y+ljsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aZQMH0Z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2962C4CEF1;
	Tue, 26 Aug 2025 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216643;
	bh=j4sOscvmNWqyPtTojTsa64lXIwrjNmvjcFPKQJkqcmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZQMH0Z4mmQ9s74cOWy3KdgwutHJ6/gMuAnQd5CaVtXFLMnusV5Y8te5ldXA2F57U
	 8Hl2LqrRKb+lJJd8BXzzV66eA5ej1p4UjdvZmgsDn1S1Xv1OiyCrvRO3xm/2QL5l6G
	 fMuWgFiJ8+GCnOsAPkHgR8yKxkr6DibEXi3W/T8Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <haoxiang_li2024@163.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15 488/644] media: imx: fix a potential memory leak in imx_media_csc_scaler_device_init()
Date: Tue, 26 Aug 2025 13:09:39 +0200
Message-ID: <20250826110958.584419119@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <haoxiang_li2024@163.com>

commit fc5f8aec77704373ee804b5dba0e0e5029c0f180 upstream.

Add video_device_release() in label 'err_m2m' to release the memory
allocated by video_device_alloc() and prevent potential memory leaks.
Remove the reduntant code in label 'err_m2m'.

Fixes: a8ef0488cc59 ("media: imx: add csc/scaler mem2mem device")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/imx/imx-media-csc-scaler.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/media/imx/imx-media-csc-scaler.c
+++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
@@ -914,7 +914,7 @@ imx_media_csc_scaler_device_init(struct
 	return &priv->vdev;
 
 err_m2m:
-	video_set_drvdata(vfd, NULL);
+	video_device_release(vfd);
 err_vfd:
 	kfree(priv);
 	return ERR_PTR(ret);



