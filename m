Return-Path: <stable+bounces-63964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9521C941B79
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66C51C2122D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64F81898F8;
	Tue, 30 Jul 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZglTuaZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B31A6195;
	Tue, 30 Jul 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358526; cv=none; b=ktCi3mUZcgblQ7ksoucIoESWDcEi9f+iOSbGGguO1FMZvT0Zzb0GGkCxh8VtSqSb98Y8sd6De2vKrpAHMlaVOo+m/dJNaBlCcaeCqhJ1gyAZdchyf8oMxtcYKz8zkt3CmBCNsh03qEDrIbL9lCwdLZpfZDM8pwpdZQe7c3ljg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358526; c=relaxed/simple;
	bh=kCnHrEHIo+M62bUDUFfM+FUFjI//s56qPAcvGAPXTas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu5dF/z0fXbspbHPu83wEpt3E3dC7pPl852exYZB7+C5mpZaDXk0I77DaU5v9uIkZCagNma4f/OW5SPmx2TwAEr3CujLpTpGonHm1cFsaILrivIk+tLYuYKY+eA4ig6OCaEeq3fRIOYyuax+cf3hGAP7lsBKQZGiq8qkPxN+4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZglTuaZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5001C4AF0C;
	Tue, 30 Jul 2024 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358526;
	bh=kCnHrEHIo+M62bUDUFfM+FUFjI//s56qPAcvGAPXTas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZglTuaZ6rim+KA/qVF2FdZz1FVl4+xJdNr6KjICsT4LVqT+mxkVKkGsKAlSs3iim0
	 tf3L8zgjj18EErkfvACFkIibHFfPZYacUeWYOLqHpCitmsVKlMWHT4awRgKsBwkSWx
	 17vdtebfj6+tMSLFYvcsz9pPzpa6S3YMQ5y7Um9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 349/809] drm/qxl: Add check for drm_cvt_mode
Date: Tue, 30 Jul 2024 17:43:45 +0200
Message-ID: <20240730151738.419639956@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 7bd09a2db0f617377027a2bb0b9179e6959edff3 ]

Add check for the return value of drm_cvt_mode() and return the error if
it fails in order to avoid NULL pointer dereference.

Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240621071031.1987974-1-nichen@iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/qxl/qxl_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index c6d35c33d5d63..86a5dea710c0f 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -236,6 +236,9 @@ static int qxl_add_mode(struct drm_connector *connector,
 		return 0;
 
 	mode = drm_cvt_mode(dev, width, height, 60, false, false, false);
+	if (!mode)
+		return 0;
+
 	if (preferred)
 		mode->type |= DRM_MODE_TYPE_PREFERRED;
 	mode->hdisplay = width;
-- 
2.43.0




