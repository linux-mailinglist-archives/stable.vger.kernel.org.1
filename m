Return-Path: <stable+bounces-2297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1737F8395
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B9A2887C2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB8F364C1;
	Fri, 24 Nov 2023 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MMNYfR58"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CECE33CC2;
	Fri, 24 Nov 2023 19:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B87AC433C7;
	Fri, 24 Nov 2023 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853538;
	bh=USK+q5gP56JFZICMEzDoHG63Hm77YIewjAtWG8gnosA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MMNYfR58bT2luXVt0cPvGyyq2RBEOS1xzhHLjFiR+Dvileh3w8trcAdHU5uM/rSea
	 2zDnT/csEcFYtmBoACKjbyOY+ct7VRK/HBfCmPZCNhfpkZNcqQPmz5rsfpJjaofAT5
	 XGNT4/VtSg2NJCZ0MsHp8WptO35sF5fzEb9NndFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 211/297] ASoC: codecs: wsa-macro: fix uninitialized stack variables with name prefix
Date: Fri, 24 Nov 2023 17:54:13 +0000
Message-ID: <20231124172007.606361180@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1678,6 +1678,9 @@ static int wsa_macro_spk_boost_event(str
 		boost_path_cfg1 = CDC_WSA_RX1_RX_PATH_CFG1;
 		reg = CDC_WSA_RX1_RX_PATH_CTL;
 		reg_mix = CDC_WSA_RX1_RX_PATH_MIX_CTL;
+	} else {
+		dev_warn(component->dev, "Incorrect widget name in the driver\n");
+		return -EINVAL;
 	}
 
 	switch (event) {



