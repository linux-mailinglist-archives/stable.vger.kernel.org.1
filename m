Return-Path: <stable+bounces-68952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB0C9534C0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4744C28839D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72F918CBE1;
	Thu, 15 Aug 2024 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WcOX8ArI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540863C;
	Thu, 15 Aug 2024 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732191; cv=none; b=fh6kR3R5AFvl9QbVMWt9DWTGfOVgyFJwXUHmDp8XjtIVN+Uea5hYlV+3s6ZQH6RCZ3y4iwjeuT4cajt6kO8vN6RUjevLstnl44D6i6QkGjM0hZ//C++gGd2tpxYjT7mjAR+f1P4zsZO0uGTvGHKOqScYtH70Xfua54uydiba30g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732191; c=relaxed/simple;
	bh=b8T1K1HxuelbmE24tru6SenhPY+mZp/8eTgDE7w12jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgTetByLQKpVpglBj3Q41NJCC3/uBstoAYolP17Sm9Hgvg8Myi3VtDZ7R00BDEtLHW+bSuGnh//4TK+oTw2OzqYFUh9bKc8YcGDqOaRMV78xbtbkL7GHMEHRGcz3fBzAVdNvklxboHrEad1KEDAWbNuqbxob/fD/8lWx0YZbB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WcOX8ArI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11794C32786;
	Thu, 15 Aug 2024 14:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732191;
	bh=b8T1K1HxuelbmE24tru6SenhPY+mZp/8eTgDE7w12jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcOX8ArIPiLMz901BeII9k1x7KLurJUt0YvzutB9z3mIL0/YHlzPMtp81DeibaqE0
	 djy7ErfgHe2eVheFdnR4OvYAvVXc0zyz2wZx9W4dAmeCZGHcqHayNPZVCyUiUmWBzL
	 FtT34Qq1EhkhcR/6FqsqZ/XOZ2KjrE78hCEr/pOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 102/352] ASoC: max98088: Check for clk_prepare_enable() error
Date: Thu, 15 Aug 2024 15:22:48 +0200
Message-ID: <20240815131923.201195601@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 1a70579723fde3624a72dfea6e79e55be6e36659 ]

clk_prepare_enable() may fail, so we should better check its return
value and propagate it in the case of error.

Fixes: 62a7fc32a628 ("ASoC: max98088: Add master clock handling")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://patch.msgid.link/20240628080534.843815-1-nichen@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max98088.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index f8e49e45ce33f..a71fbfddc29a7 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1319,6 +1319,7 @@ static int max98088_set_bias_level(struct snd_soc_component *component,
                                   enum snd_soc_bias_level level)
 {
 	struct max98088_priv *max98088 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1334,10 +1335,13 @@ static int max98088_set_bias_level(struct snd_soc_component *component,
 		 */
 		if (!IS_ERR(max98088->mclk)) {
 			if (snd_soc_component_get_bias_level(component) ==
-			    SND_SOC_BIAS_ON)
+			    SND_SOC_BIAS_ON) {
 				clk_disable_unprepare(max98088->mclk);
-			else
-				clk_prepare_enable(max98088->mclk);
+			} else {
+				ret = clk_prepare_enable(max98088->mclk);
+				if (ret)
+					return ret;
+			}
 		}
 		break;
 
-- 
2.43.0




