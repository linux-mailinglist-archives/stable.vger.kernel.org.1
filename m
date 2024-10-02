Return-Path: <stable+bounces-79680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A398D9AC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DE9B22516
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152051D174F;
	Wed,  2 Oct 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UWxurx7z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91981D0488;
	Wed,  2 Oct 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878150; cv=none; b=IcXWJwPRImZUcsULqnhxyhPv9qg4Kia2OjJ0bpr6PBbQQjDigjDwIkImYbrsqZOSqkSqFwTRHSIh1u7dbBPhzZamuLrAqugqyRCJYe4UhhiOv2Buwy/I8w85cRQRg2rij42gzv8pPQDC2+jb4hH4vp+3a+ugSr9CBBRa9gHTAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878150; c=relaxed/simple;
	bh=XtfOYUd+m409ZrAZ/eRyC6pZaGJt7MAOtUbFDIunz1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAKt3RWwu3CT96OxZ3xah7FytIvqLR+RPoSsKkNW7HaWPqTqWcz1GjJWRreTBJASXhpdCnUA6lFihjSt0/RRVHuIxLA5In9adw2qupcyu2EnO1HaVzMmyZ0Y113fTEECkqNUe9cDuu6YcyXOotqWoA7HwJ76WZC+GiqDIl7plrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UWxurx7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C962AC4CECE;
	Wed,  2 Oct 2024 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878150;
	bh=XtfOYUd+m409ZrAZ/eRyC6pZaGJt7MAOtUbFDIunz1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWxurx7zMra62ZRjnK0A8anRn5S6EGl04ELdyQeoNtDniHE4gcsW5cSoViYGGWmnf
	 GkireSWJrKrT4XNrTtlnTzPzXvWqxHZI7N41TQG+9SfcEdw8B7XMu2UAz6v3FZEmwH
	 PUNMinOMj8I7oX1Gti2Jt47IfO0Krn5qdEPxSqnk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 319/634] remoteproc: imx_rproc: Initialize workqueue earlier
Date: Wed,  2 Oct 2024 14:56:59 +0200
Message-ID: <20241002125823.696250635@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 858e57c1d3dd7b92cc0fa692ba130a0a5d57e49d ]

Initialize workqueue before requesting mailbox channel, otherwise if
mailbox interrupt comes before workqueue ready, the imx_rproc_rx_callback
will trigger issue.

Fixes: 2df7062002d0 ("remoteproc: imx_proc: enable virtio/mailbox")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20240719-imx_rproc-v2-3-10d0268c7eb1@nxp.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/imx_rproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 3c8b64db8823c..448b9a5438e0b 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -1076,6 +1076,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
+
 	ret = imx_rproc_xtr_mbox_init(rproc);
 	if (ret)
 		goto err_put_wkq;
@@ -1094,8 +1096,6 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_put_scu;
 
-	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
-
 	if (rproc->state != RPROC_DETACHED)
 		rproc->auto_boot = of_property_read_bool(np, "fsl,auto-boot");
 
-- 
2.43.0




