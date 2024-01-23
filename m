Return-Path: <stable+bounces-14103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D09A837F87
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610C21C290FE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A730633F3;
	Tue, 23 Jan 2024 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j6ZsmyMD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA0633EB;
	Tue, 23 Jan 2024 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971176; cv=none; b=rSBwRkykSD4OFXQbOh6q7LcDEkgfhN7CqHSxQ4AatMIkohR38QgelVbKicKU6dcMrT3swrq/cuczwB/hylkh7FDOnARwX2FU6YgDHvXz+r4ntyUXauS+Swzp/rxL5RiTFZgWAUxjNdz3PM13atHqm5ED9p5QSdFi8qQQUzFN9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971176; c=relaxed/simple;
	bh=DCIBPb8AgUdr929znAQdJaXhC7jZ5GPwWxWgxYXianA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE5QZAe/P91HLhn3yV3G1y5YObNOK90lJFaFiQ6aG9tUHv3VT7tTF/+aKEv0cscqgPz8WvNPdLcjQYtmr1H1Im/ZcOw18LrcJFqcDBQreb0IxJG0T/KQyuxsHALkh82z5T48Mq9BmtiZahXBGVykkeN5MbOmo4hpmnxSpcqM5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j6ZsmyMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA6CC433F1;
	Tue, 23 Jan 2024 00:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971176;
	bh=DCIBPb8AgUdr929znAQdJaXhC7jZ5GPwWxWgxYXianA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6ZsmyMDMVLDEfM/Miw62d+/399vVlxjwmqT9to25+uR5jzi1NUoc5aZJJrpnGg1d
	 DQgY+ZTzNxpgYKvNmitkaswe+59cQzjQC5tjZs3hxoXJtz7wr7OiJOmgoNFC6LFyyI
	 wIFfQbs73RiRzSMW/9f9oODHcarjJqeQMvui7bbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 197/417] drm/panel: st7701: Fix AVCL calculation
Date: Mon, 22 Jan 2024 15:56:05 -0800
Message-ID: <20240122235758.760332770@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit 799825aa87200ade1ba21db853d1c2ff720dcfe0 ]

The AVCL register, according to the datasheet, comes in increments
of -0.2v between -4.4v (represented by 0x0) to -5.0v (represented
by 0x3). The current calculation is done by adding the defined
AVCL value in mV to -4400 and then dividing by 200 to get the register
value. Unfortunately if I subtract -4400 from -4400 I get -8800, which
divided by 200 gives me -44. If I instead subtract -4400 from -4400
I get 0, which divided by 200 gives me 0. Based on the datasheet this
is the expected register value.

Fixes: 83b7a8e7e88e ("drm/panel/panel-sitronix-st7701: Parametrize voltage and timing")

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20231208154847.130615-2-macroalpha82@gmail.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231208154847.130615-2-macroalpha82@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 225b9884f61a..54b28992db5d 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -288,7 +288,7 @@ static void st7701_init_sequence(struct st7701 *st7701)
 		   FIELD_PREP(DSI_CMD2_BK1_PWRCTRL2_AVDD_MASK,
 			      DIV_ROUND_CLOSEST(desc->avdd_mv - 6200, 200)) |
 		   FIELD_PREP(DSI_CMD2_BK1_PWRCTRL2_AVCL_MASK,
-			      DIV_ROUND_CLOSEST(-4400 + desc->avcl_mv, 200)));
+			      DIV_ROUND_CLOSEST(-4400 - desc->avcl_mv, 200)));
 
 	/* T2D = 0.2us * T2D[3:0] */
 	ST7701_DSI(st7701, DSI_CMD2_BK1_SPD1,
-- 
2.43.0




