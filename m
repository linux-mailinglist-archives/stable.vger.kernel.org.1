Return-Path: <stable+bounces-91184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361889BECD6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F621C23D71
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282891F7078;
	Wed,  6 Nov 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D9/Lasl4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93691DFE3B;
	Wed,  6 Nov 2024 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897988; cv=none; b=rUeQ8ayshWoVlimCYx2uimxqxUDy20fd4K4j1cXV2fl6ujQy077Z8L+IMQMbDfN2as7QcC56QdfPCS9yG1Wn4l5gncMVA0OhPz5a2zAabd1nVfWwVktcv6RaS7DzX8BtukqQEvLG9fVAfrJ6w05sFnDVpcHDCzeaxSjQXrODGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897988; c=relaxed/simple;
	bh=I6miTwGcIe/uNCGpOQCF1rqlWCLzlvFGhw6LcZhBESA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/QvzpMkgfgQvxbUl6dEzeTAC0/4QvuZKKAMt3En85upIyLRHxBehdKjKhdJ4Hndf0HbYLKBYq/hQjow1ZakGrvCPmFUWwBiwAT5A6WniatwxvO0UupZlH2JyGbpLtKP+oAGcd/A+J68Lc86F4fRJ08DGmokKvb8PAX5oqDxZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D9/Lasl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05459C4CECD;
	Wed,  6 Nov 2024 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897988;
	bh=I6miTwGcIe/uNCGpOQCF1rqlWCLzlvFGhw6LcZhBESA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9/Lasl4ghmVqtM82hk+I6Bj0Lw1AyC73Jjs0i+bSmGkU/ambpantsb+kw9b3RbUU
	 K06KQIesgHkDcxL4dOVF3VLSVdoiKQTe0Dr0OrmKBLOp7EedN9oQ9unt8hWaBbcWwV
	 t3LYJzYQ2mKBRZIbEBjAjBriXFDkpc0n2UkoULHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 069/462] drm/stm: Fix an error handling path in stm_drm_platform_probe()
Date: Wed,  6 Nov 2024 12:59:22 +0100
Message-ID: <20241106120333.213766832@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ce7c90bfda2656418c69ba0dd8f8a7536b8928d4 ]

If drm_dev_register() fails, a call to drv_load() must be undone, as
already done in the remove function.

Fixes: b759012c5fa7 ("drm/stm: Add STM32 LTDC driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20fff7f853f20a48a96db8ff186124470ec4d976.1704560028.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/stm/drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 5a9f9aca8bc24..c7203fd7c85ec 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -208,12 +208,14 @@ static int stm_drm_platform_probe(struct platform_device *pdev)
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret)
-		goto err_put;
+		goto err_unload;
 
 	drm_fbdev_generic_setup(ddev, 16);
 
 	return 0;
 
+err_unload:
+	drv_unload(ddev);
 err_put:
 	drm_dev_put(ddev);
 
-- 
2.43.0




