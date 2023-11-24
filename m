Return-Path: <stable+bounces-1739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4887F8122
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B424B21BEC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD3035F1A;
	Fri, 24 Nov 2023 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L46QQcTD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76933E9;
	Fri, 24 Nov 2023 18:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C391C433C8;
	Fri, 24 Nov 2023 18:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852154;
	bh=VSpk8DEcCh9Hdzu/oQK54rAfPJUhDFtvoH0NQYxFJxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L46QQcTD86Tc0nZfoC/cUmiI9GQ8klNE2VmY2Ui/tANQ9eusNXDh2CTFAYzNDLkG0
	 jB0neMw32Op7te3CwrPZ5uZsVmKxb/N6rClvo7yTW7uWdS1OYdGUmVgJheNDqbNVxP
	 MTPkbX5D5P0Sbjeg+GmYlg/pPanIr1TPtlBPhshE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 241/372] ASoC: codecs: wsa-macro: fix uninitialized stack variables with name prefix
Date: Fri, 24 Nov 2023 17:50:28 +0000
Message-ID: <20231124172018.561984845@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 72151ad0cba8a07df90130ff62c979520d71f23b upstream.

Driver compares widget name in wsa_macro_spk_boost_event() widget event
callback, however it does not handle component's name prefix.  This
leads to using uninitialized stack variables as registers and register
values.  Handle gracefully such case.

Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231003155422.801160-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/lpass-wsa-macro.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1682,6 +1682,9 @@ static int wsa_macro_spk_boost_event(str
 		boost_path_cfg1 = CDC_WSA_RX1_RX_PATH_CFG1;
 		reg = CDC_WSA_RX1_RX_PATH_CTL;
 		reg_mix = CDC_WSA_RX1_RX_PATH_MIX_CTL;
+	} else {
+		dev_warn(component->dev, "Incorrect widget name in the driver\n");
+		return -EINVAL;
 	}
 
 	switch (event) {



