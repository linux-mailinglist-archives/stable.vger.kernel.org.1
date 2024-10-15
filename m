Return-Path: <stable+bounces-86036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973E99EB5A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C4A1F2504B
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681001AF0B7;
	Tue, 15 Oct 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WRNbmIPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D691C07DB;
	Tue, 15 Oct 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997557; cv=none; b=R1/F9IuOXzxUEYRWi0w3iQeI0QlANuwdnDjZhIf7cynCLIvkURQ8dQN/K+YoTNMgaRA/o2GK/yDTbqleZ/Tpx7Xdxdm7FStlbNdbFHEwLft4G9hkO8gkon2yDeSQimie7WnCFkwJD3dKZj+nzVnPU//1/jGMj7zaU4OWTl2WsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997557; c=relaxed/simple;
	bh=cnXFdI7IOVScnpJpXEVchSmfXkTbXLewjSmSMn6b33I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Md8V1GX4HYGCioHfuELhpZQs4DHW3daDqKmcHNErfO54lfGlNuxYAYFpmfVtmvlXyn/IayiHIz/nudWvYf6VOgICCDxfUdLozAn9Fn8jw06N6nAZMeISxSshcsbu5J4MgxZPtRMzcdxyXAhX250cA6NqXbSeLBkpiR1qznchEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WRNbmIPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B061C4CEC6;
	Tue, 15 Oct 2024 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997556;
	bh=cnXFdI7IOVScnpJpXEVchSmfXkTbXLewjSmSMn6b33I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRNbmIPIkewMaulN5CS9nUjlYWoPpQGt8JU5LU1O0u2WZI5YtPU1R1BlvosAK2fDy
	 lJZymIKw0pI8ZjTT0tw+LejH++k/XBFmp/hvaKs+E3ddmcLlHDRxjHzc8LToBytoeh
	 0lWRF7VrnrfRHbQB3/zZjC/Opyc9ecl+QtOknw9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.10 218/518] ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error
Date: Tue, 15 Oct 2024 14:42:02 +0200
Message-ID: <20241015123925.410829420@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit fcca6d05ef49d5650514ea1dcfd12e4ae3ff2be6 upstream.

Return devm_of_clk_add_hw_provider() in order to transfer the error, if it
fails due to resource allocation failure or device tree clock provider
registration failure.

Cc: stable@vger.kernel.org
Fixes: ebbfabc16d23 ("ASoC: rt5682: Add CCF usage for providing I2S clks")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Link: https://patch.msgid.link/20240830143154.3448004-1-make24@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/rt5682.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2843,8 +2843,10 @@ static int rt5682_register_dai_clks(stru
 		}
 
 		if (dev->of_node) {
-			devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+			ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
 						    dai_clk_hw);
+			if (ret)
+				return ret;
 		} else {
 			ret = devm_clk_hw_register_clkdev(dev, dai_clk_hw,
 							  init.name,



