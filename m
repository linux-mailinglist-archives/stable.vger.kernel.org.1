Return-Path: <stable+bounces-29248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6D1888429
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 01:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6113E1F25CD7
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9615013A409;
	Sun, 24 Mar 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLlhN5aV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017013A3FB;
	Sun, 24 Mar 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320220; cv=none; b=lz0k8ctY0s9LG+aRdZi87kwjZOUhl6QwxYCc4fEstkpIP3PJBLfik6QSWqKQ/ck/0cbI9yXhjJGivC3BseO+B+DIYcs4ckLXZwktdK+XHkS8k+H3dguY7Gcg7yznniQycI9AVKDcRDK3CvkX5+zcYJbn0yDX4FDIPAVRsHYJESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320220; c=relaxed/simple;
	bh=4PlkdmqB6yZ6noXjc3qFkk6SADhbWCGGBO9b/AhRtr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Es5Iqf0NbnpCJiI3R8rLq5BHLI8RuE68Ow/sjenyWh9GRoeTfKvXJt3SvobxSBdaoIz9Kko3pXIEZIrryeQakQ7e3RIZ6xJxfo6CmUoPDZbQF5+LtMiQmmp8HrhLN/RbnQcsGABPYi1peCF+EQOKwNwrcxgbF43LBkKfMnYIcvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLlhN5aV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46266C43394;
	Sun, 24 Mar 2024 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320219;
	bh=4PlkdmqB6yZ6noXjc3qFkk6SADhbWCGGBO9b/AhRtr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLlhN5aVRBctvJ1lJCvmlHpIXGFSERkduBqOHT32YrrPbk+vt1bC2l75N/JUpbJZj
	 Dk+NrxC3/Yis3fkx/79GtAjU6MApUH5UTbnh+r1mcWaMA2hPGXUfhjfiAMUTPRuQpg
	 ZiJG3qpVxX+5s88xpaZFevUNjyaInTDAGK/NQwpdzlCbtiJqDWyXTnOtH7xUBvGtc6
	 CjBglfOymUCUpKvco0uWXm28gmCRRZ4UA5QL6rdL2OjLN77fVb26eSLjBts3vstnJP
	 JXShkWLuljrHYoSqpl2tUoRU4Ov0XCCCdmdMBPzHAasZASsTDYsCmFhx4Etp3j6i4j
	 PfQPfw3BrmOTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 527/715] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 18:31:46 -0400
Message-ID: <20240324223455.1342824-528-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel.thompson@linaro.org>

[ Upstream commit abb5a5d951fbea3feb5c4ba179b89bb96a1d3462 ]

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: 0f59858d5119 ("backlight: add new lm3639 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220153532.76613-3-daniel.thompson@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3639_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 5246c171497d6..564f62acd7211 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -338,6 +338,7 @@ static int lm3639_probe(struct i2c_client *client)
 	}
 
 	/* backlight */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = pdata->init_brt_led;
 	props.max_brightness = pdata->max_brt_led;
-- 
2.43.0


