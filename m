Return-Path: <stable+bounces-39072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873738A11CC
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0A41F2162A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E636BB29;
	Thu, 11 Apr 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0QuvJp2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C9146A70;
	Thu, 11 Apr 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832434; cv=none; b=uMIXy+xLo6rogMCkzVL1N80PyfBhdho1prkLHc2oin2mke1LlOp2RaE4KpX9Jn5wAoroniaaZ6FhCaRnn80e5BWlCSwyI+ntAvh1/QsZE0RYEWGu4MBRiZIjxbZO9j1WkEGpipP6rFlQfjts5WC+RFG19VWp51x8gNHSLY/j6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832434; c=relaxed/simple;
	bh=lyPRnNt63idDpn8/p9hTPGAuThXomLEiCoH4S6Lev/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzcYz2tkhGrJH1pRYfeFjRvWe+5U/vzJJ+FKi714+njsmDiLtqz/VrghmJO0z82kL3qASPzlSixZNn/xPeA3ltwQxfKjd0WjcgbVhiFBI6N94Jp+EZ/F7lDE3/eLLXTdEBT17zHXIl1ZYgU5n2c7zoFLpLRGDJ1LgoBFnMi2JBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0QuvJp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2B9C433B1;
	Thu, 11 Apr 2024 10:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832434;
	bh=lyPRnNt63idDpn8/p9hTPGAuThXomLEiCoH4S6Lev/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0QuvJp2SmQjxKrguLO5PPjKYDvatjxknEMp94rqUoDiMqaQX4hutKSvmB6q+tbFu
	 tTX91XZWyEYsfuP8SE05EnqqYFNE3kdQIsmzMIXqLGm4Fu/Uvg1k5jqDWkt0yvej6E
	 pcVTkSStcrI6s6b6pxAtsV5EUuDCGqkcb+chteF4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markuss Broks <markuss.broks@gmail.com>,
	Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 48/83] input/touchscreen: imagis: Correct the maximum touch area value
Date: Thu, 11 Apr 2024 11:57:20 +0200
Message-ID: <20240411095414.130071223@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
References: <20240411095412.671665933@linuxfoundation.org>
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

From: Markuss Broks <markuss.broks@gmail.com>

[ Upstream commit 54a62ed17a705ef1ac80ebca2b62136b19243e19 ]

As specified in downstream IST3038B driver and proved by testing,
the correct maximum reported value of touch area is 16.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
Link: https://lore.kernel.org/r/20240301164659.13240-2-karelb@gimli.ms.mff.cuni.cz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/imagis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index e2697e6c6d2a0..b667914a44f1d 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -210,7 +210,7 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
 
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
 
 	touchscreen_parse_properties(input_dev, true, &ts->prop);
 	if (!ts->prop.max_x || !ts->prop.max_y) {
-- 
2.43.0




