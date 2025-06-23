Return-Path: <stable+bounces-155952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB2AE446D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6CD1799F9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694FC2571A5;
	Mon, 23 Jun 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cc9BRD10"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD7256C8D;
	Mon, 23 Jun 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685764; cv=none; b=SjrRHM9h9Va1R0uJshp+OgcI2wbmg1TL6F08ccbvZocRuOXguYfDi6Ad4+p3+byl1nSuCZsrB10scRLmz6/bunx9dtidoOhPwjbyahYtaJfM/MMXk8deDa+dbQU5qAN8SgPrQelH91RfB3bujZyepETcxJQTkSnwd2Pmllirqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685764; c=relaxed/simple;
	bh=oyRZX8RIIe+3qm+zurqCUnxQBNyxURmjuEYz0od87Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgAaqpRLK3DPmZ5SrAv+jVZEXcM7+uE0a0/Ys3sQnPLIhTZSsLy3lRYsMrYAp9oBHHCBXKACtatSyW3DfsZJUQ2zL47A50oeVXN64s6UVZ/Bo2CXWPE5uX4tk4P5I3jnr/UMaD7tdR2oACXLSNwQ77Ao+m3CShlC7/i3lDe9cdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cc9BRD10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9161C4CEEA;
	Mon, 23 Jun 2025 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685764;
	bh=oyRZX8RIIe+3qm+zurqCUnxQBNyxURmjuEYz0od87Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cc9BRD10Ocb3k90anntCT+qKFPeyHmawoiGkeK53UnTfEZ2tdKX2zsaKCJ/RWxpru
	 EGFbbioyW426u9H0rd7F1CLnh+QlcVUxji5pWGZT9aDFS1u9pFzdYKDAZuaTBkzupL
	 2gslxEhPUbwelyTd7IfAOMbFgDoZ8L0r6f4wdCOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.6 025/290] media: ov5675: suppress probe deferral errors
Date: Mon, 23 Jun 2025 15:04:46 +0200
Message-ID: <20250623130627.741327435@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 8268da3c474a43a79a6540fb06c5d3b730a0d5a5 upstream.

Probe deferral should not be logged as an error:

	ov5675 24-0010: failed to get HW configuration: -517

Drop the (mostly) redundant dev_err() from sensor probe() to suppress
it.

Note that errors during clock and regulator lookup are already correctly
logged using dev_err_probe().

Fixes: 49d9ad719e89 ("media: ov5675: add device-tree support and support runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov5675.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -1339,11 +1339,8 @@ static int ov5675_probe(struct i2c_clien
 		return -ENOMEM;
 
 	ret = ov5675_get_hwcfg(ov5675, &client->dev);
-	if (ret) {
-		dev_err(&client->dev, "failed to get HW configuration: %d",
-			ret);
+	if (ret)
 		return ret;
-	}
 
 	v4l2_i2c_subdev_init(&ov5675->sd, client, &ov5675_subdev_ops);
 



