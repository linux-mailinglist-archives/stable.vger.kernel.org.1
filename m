Return-Path: <stable+bounces-80433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D8E98DD67
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74F71C22D98
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4757D1D0F43;
	Wed,  2 Oct 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ng72p6b8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B41D551;
	Wed,  2 Oct 2024 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880361; cv=none; b=I/THrzK5H0W8rFOnWBlt73n28PxceWp126tsOjf0keYMVaArkxc8u37meweHkwYpYIck2v0CmO9SiGpSlbXUhzTf0ps3be5zTtnzcVNjeSjIz01OP3I6nbzkPAwiMORNIE72Li90fcvgfY/cDllcVmXFBfiWINwz/4u0Sftz7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880361; c=relaxed/simple;
	bh=0NZxAJguEuNtBzlAH/plIsbZSKaFNzvgMtDETtRUsBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqV5L/5uHhTlEx5xT7OjInMZRqKknigxyPLhWfCpxnqQazPiTNcubfwQRduxNbjTL5a87p3YzcRI2f/xEIPsBN9Ytb9bkPKzGx7ut3xoZio4MA2O8OuBVbQLF0+MnBZlFDu1FCPnGahcz6dPbo3+QZJ0Vxdhdvs81h+h2hRZjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ng72p6b8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DDAC4CEC2;
	Wed,  2 Oct 2024 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880360;
	bh=0NZxAJguEuNtBzlAH/plIsbZSKaFNzvgMtDETtRUsBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ng72p6b8zPrAvnTmmAxHENyCq+JJehrxEpkj19MqR9wDO7SLkTgXw4qBb179zoJzn
	 1yzE0DialNuYOywiYAEyth4zGWV4ALzSiVWxDb4MJ7UDSmuuS4oVgUlGm8qil/uQIs
	 bKhTDpkxSB+4NaMfCx5sEruDygWh8pCQn3s4w4QQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 401/538] ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error
Date: Wed,  2 Oct 2024 15:00:40 +0200
Message-ID: <20241002125808.266792894@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2903,8 +2903,10 @@ int rt5682_register_dai_clks(struct rt56
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



