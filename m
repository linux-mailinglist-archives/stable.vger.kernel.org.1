Return-Path: <stable+bounces-51697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C5990712B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24FD283982
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFF14265E;
	Thu, 13 Jun 2024 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iH/Skk4t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420213D244;
	Thu, 13 Jun 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282050; cv=none; b=aR32TKNsXAFZOaXWpVQYAet3Faf7HGwdhyiLv8ZbFnuYgGiiNQnYUNvv+YstQcA4QthP5JyVI9krmzYSzB8aRPxGWQ9y/UMeeNGfG54P84BMZDQe46qgTy3ohU+lItUFQ2QouupTHgdNIlfyhaq4e1bUDPIXq4PrxXwqtd7PPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282050; c=relaxed/simple;
	bh=areXCXlRWenAHaLn0eMjHqZD7S0nI/hhvIcrLFOmnME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGfy49xHxzAXxiGCoCjg2sWaBoy/39uI3+jZGQrdpvGqXygnPRtI7nFZjdRFnhW1xURc75PwJzggXLqDvLQWctvf5AGfiV3MbcHaK0bzEa7nQfSuhdz5gtmZgcM/p0UEf1AAuqP4cO/2B9wW1sHEm6lBuNai5k/AE/Fr8EAqZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iH/Skk4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129A7C2BBFC;
	Thu, 13 Jun 2024 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282050;
	bh=areXCXlRWenAHaLn0eMjHqZD7S0nI/hhvIcrLFOmnME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iH/Skk4tzTv6uTrt2rTWoUC1GYH8EpuPkVMv/nZBtg9pNB22OpdcieAVz/psrluNc
	 JkbWED/TUvo1N4wp2ln5vJzhYtyuwmGzAD7mY7t4zVeKXFcW8AoKIw3rQiUWNvppqr
	 ZHu0TBOswe+KhS4VKYKMXmTZwpvjZ8SungtV6uKQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	"=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" <nfraprado@collabora.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 144/402] drm/bridge: lt8912b: Dont log an error when DSI host cant be found
Date: Thu, 13 Jun 2024 13:31:41 +0200
Message-ID: <20240613113307.752459481@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit b3b4695ff47c4964d4ccb930890c9ffd8e455e20 ]

Given that failing to find a DSI host causes the driver to defer probe,
make use of dev_err_probe() to log the reason. This makes the defer
probe reason available and avoids alerting userspace about something
that is not necessarily an error.

Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240415-anx7625-defer-log-no-dsi-host-v3-3-619a28148e5c@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index e16b0fc0cda0f..6379d5c8edff1 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -475,10 +475,8 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 						 };
 
 	host = of_find_mipi_dsi_host_by_node(lt->host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
-- 
2.43.0




