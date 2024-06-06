Return-Path: <stable+bounces-49184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8118FEC3A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1C7B22B58
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1D1AED36;
	Thu,  6 Jun 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xi4bxkOU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE72198A06;
	Thu,  6 Jun 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683343; cv=none; b=mXnAE606iRQ1nl9EszpUi1YUp0ptFQ2pddT1QBAeRDUoe/I0qUHf1Z6HxuqG4zdEir5V35kLYR1ZdmoEbX2X+SyjtSmLggcgppHzcb6ptuN/V76HjDq8r27B5/76/TQTG9GCb/mScZdeMG6FyvFsrt8ZZeoyJ/T/pRvA4TR57bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683343; c=relaxed/simple;
	bh=JDVi9UerHbg/eyVj/uYp5RqTPNTCiUfR/Fc9gt/rwAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1q+bWvaNI6CxfM2eTGJCtfO8dd4/3bBidNHLq7QG9ZRuqJ7NJW8YbdF1gEgEWRzLWtOPfTZOVnWQKBnj9MSbT5IonZdqWX/aj6L3K7LBj5xiDUyggnVF0qPgMPUe0CGm8h8owXdQ6WqUdCKGgf2I+b3JY6qcaZgRuxA8UOHnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xi4bxkOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDA0C32781;
	Thu,  6 Jun 2024 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683342;
	bh=JDVi9UerHbg/eyVj/uYp5RqTPNTCiUfR/Fc9gt/rwAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xi4bxkOUsEhT0WQRL4IoKY1eCZXSc8hJLx9kQ854ASRrxraqObO8+uuDIKSYOrjYM
	 ArKRX/woVr4oXMoU6E4DNMIvchpUqX+YvPo+pg/biRqPEmM5g1PW0BDldHYXlknSmI
	 rifVD44XjR0+/lRFPTxw67dtPYVvxIXLQK6/yi0c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	"=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" <nfraprado@collabora.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 224/473] drm/bridge: anx7625: Dont log an error when DSI host cant be found
Date: Thu,  6 Jun 2024 16:02:33 +0200
Message-ID: <20240606131707.288060753@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit ef4a9204d594fe959cdbc7418273caf4001535c8 ]

Given that failing to find a DSI host causes the driver to defer probe,
make use of dev_err_probe() to log the reason. This makes the defer
probe reason available and avoids alerting userspace about something
that is not necessarily an error.

Fixes: 269332997a16 ("drm/bridge: anx7625: Return -EPROBE_DEFER if the dsi host was not found")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240415-anx7625-defer-log-no-dsi-host-v3-1-619a28148e5c@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 77a304ac4d75e..193015c75b454 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2077,10 +2077,8 @@ static int anx7625_setup_dsi_device(struct anx7625_data *ctx)
 	};
 
 	host = of_find_mipi_dsi_host_by_node(ctx->pdata.mipi_host_node);
-	if (!host) {
-		DRM_DEV_ERROR(dev, "fail to find dsi host.\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "fail to find dsi host.\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
-- 
2.43.0




