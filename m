Return-Path: <stable+bounces-13439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32124837C12
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFAD295443
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DAF3C0D;
	Tue, 23 Jan 2024 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uuF4Obmz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FE42114;
	Tue, 23 Jan 2024 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969493; cv=none; b=Y1G0VVu2PyR2ScgkZo2+e7Mwhkw/Q95ptwwPDUJekztUEWUbTQ4MtFk0g9dYmv7IOKlj4GtWKDLRLHYm8KQQheEkxjYj35a/qMQ2wTxSErjZj88XEWxr7Vy2nbEiQF6hluEsWDVOhFOh6mNSViN4+9tuNLZAtOMFkpErSjDpzrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969493; c=relaxed/simple;
	bh=bYr5SI3DL8Pi4VmQJnTkmGcW+Xc7y8sHf2jVWKpy22Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+BHZtvck54PeVlMq4oDFDdK96Qb0DeHcwXl553HBXLdLpwaA76bstDvfOSBvE7pWohrNY77q4htLumlELaccrX44L2qAm5ng86G2+V7L0ozzVUwEo3guVmaIRqKmPM4grSZO2O8LyZU3nS/KVfc2+GpEOtM9hdhfOjq+FFDdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uuF4Obmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC059C43390;
	Tue, 23 Jan 2024 00:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969493;
	bh=bYr5SI3DL8Pi4VmQJnTkmGcW+Xc7y8sHf2jVWKpy22Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uuF4ObmzLjeHItjmDkm23/vi1z04N7W5BR1F9zQotJTQosuHhQ7AmFzobknCybzcf
	 PO12JPhXNCr5XgTttKn4lhnFbs8qL7HG6KWVYKWGa19iQjYQu5TcKzIJPTZsEeFRzj
	 IWwAXx7SWTtGm3BfLNXmGMA9dJlFloIkKxhtVKbI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xin Ji <xji@analogixsemi.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 264/641] Revert "drm/bridge: Add 200ms delay to wait FW HPD status stable"
Date: Mon, 22 Jan 2024 15:52:48 -0800
Message-ID: <20240122235826.188201133@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Ji <xji@analogixsemi.com>

[ Upstream commit af3145aa142c92409d3b123ff87ff0b5fd0bf849 ]

This reverts commit 330140d7319fcc4ec68bd924ea212e476bf12275

200ms delay will cause panel display image later than backlight
turn on, revert this patch.

Fixes: 330140d7319fcc ("drm/bridge: Add 200ms delay to wait FW HPD status stable")
Signed-off-by: Xin Ji <xji@analogixsemi.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231120091038.284825-1-xji@analogixsemi.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 8f740154707d..51abe42c639e 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1464,9 +1464,6 @@ static int _anx7625_hpd_polling(struct anx7625_data *ctx,
 	if (ctx->pdata.intp_irq)
 		return 0;
 
-	/* Delay 200ms for FW HPD de-bounce */
-	msleep(200);
-
 	ret = readx_poll_timeout(anx7625_read_hpd_status_p0,
 				 ctx, val,
 				 ((val & HPD_STATUS) || (val < 0)),
-- 
2.43.0




