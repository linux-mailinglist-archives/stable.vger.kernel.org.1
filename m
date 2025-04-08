Return-Path: <stable+bounces-130133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5739A80316
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE97817A368
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8001226461D;
	Tue,  8 Apr 2025 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LR84IVGu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3BA94A;
	Tue,  8 Apr 2025 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112905; cv=none; b=EVaPC9/CxosRPx5VzAcFaaJfp6aSm1n0fNUeNNkgq8gGwyrCkWpAat6Z3quqnhhQpGh6hMEsv8k4tjJzYL5Cjso9HhBUyilcqyPMSqiI+j0SkRG+1G1Znix8MwysghZLn8cMW3yCZhsuMVLIG9naqQ7rReIViTppgYcfEYX5/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112905; c=relaxed/simple;
	bh=cOo0ZvJ2WnvD32zgYiE6G+aoRYpEW7H8/iQ9QdXEPho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM9PIr3kqkDO1IRKMBWfgV2veDo164lqjCw1EX4LqpvKwq2QB8xzRyMw06P6sB0Ty8TNXJGJfXWGYDNDVHWTn7x7MExdMVLSznOPlhjaNNWITbNiyhoYbaIjgTYoxjp7rT64Nqq6WuNGRlSZtI1nycehk43gP3xup6qnv9Bj1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LR84IVGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E3FC4CEE5;
	Tue,  8 Apr 2025 11:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112905;
	bh=cOo0ZvJ2WnvD32zgYiE6G+aoRYpEW7H8/iQ9QdXEPho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LR84IVGuioffQwRcVOCaAy6jp2J2RPst/7X9I0gn3xvy2zLJ30CpeZR1PFsjZ0Zgd
	 5SedHnUe14GNdt6M/kpJKEjOww4uuZ1F9m/8VgjvpGZ7crKrXEgtrr95Orvbx2FLCf
	 2MsaJrJIP4etAjr4WuxYb85s0d1nl1ZNmJrU4ORY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henry Martin <bsdhenrymartin@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 240/279] ASoC: imx-card: Add NULL check in imx_card_probe()
Date: Tue,  8 Apr 2025 12:50:23 +0200
Message-ID: <20250408104832.863338313@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit 93d34608fd162f725172e780b1c60cc93a920719 ]

devm_kasprintf() returns NULL when memory allocation fails. Currently,
imx_card_probe() does not check for this case, which results in a NULL
pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: aa736700f42f ("ASoC: imx-card: Add imx-card machine driver")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250401142510.29900-1-bsdhenrymartin@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index 223234f6172b2..2b64c0384b6bb 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -759,6 +759,8 @@ static int imx_card_probe(struct platform_device *pdev)
 				data->dapm_routes[i].sink =
 					devm_kasprintf(&pdev->dev, GFP_KERNEL, "%d %s",
 						       i + 1, "Playback");
+				if (!data->dapm_routes[i].sink)
+					return -ENOMEM;
 				data->dapm_routes[i].source = "CPU-Playback";
 			}
 		}
@@ -776,6 +778,8 @@ static int imx_card_probe(struct platform_device *pdev)
 				data->dapm_routes[i].source =
 					devm_kasprintf(&pdev->dev, GFP_KERNEL, "%d %s",
 						       i + 1, "Capture");
+				if (!data->dapm_routes[i].source)
+					return -ENOMEM;
 				data->dapm_routes[i].sink = "CPU-Capture";
 			}
 		}
-- 
2.39.5




