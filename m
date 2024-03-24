Return-Path: <stable+bounces-30541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA258890E9
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9CF1C2CD15
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0C26B82E;
	Mon, 25 Mar 2024 00:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGDZwUzC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB708273DAC;
	Sun, 24 Mar 2024 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323330; cv=none; b=GbkaKhOx0SruQASoj62HHOHIzj6u7RzaJp/zsrjQG+SRfT6cSZVKS00EfW33RcadQCEifReKSQOIekSfukgQ61QRtM1DR0JonE2eJPrLjrB3lXEJAUv6Q5kccZuhQ7ZY50r+HbDeOz1ZdX6TyOBsBsL7rQhI3RNVRF3WHXMD0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323330; c=relaxed/simple;
	bh=/13Qo09rKfsJMout/fQ36Ue7hQdaUBOKwc5wkddezjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBhmwqyGiVO+TfawHW9sgPjcCLHrY8XplR4v42Yoe+bloVbjqNkU10XDO+IfRqiFMXdUqDwjqBqxYV/QsOicih+6UmGKwB6/17yLl0xEKvJGA7O2Ie0U465nlR0jdV7X54gGwUjmvW9iQRRR0aHqAYMkXmVzpfmO9+A6st9eHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGDZwUzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1751AC4167D;
	Sun, 24 Mar 2024 23:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323329;
	bh=/13Qo09rKfsJMout/fQ36Ue7hQdaUBOKwc5wkddezjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jGDZwUzCek4YOaK20sH7K/ag6ZrvXlk1tD0BZk+keIUdw6BWIK3GG8VZfrSh2972m
	 sY8/7ArB0OpyRRP7YPoJc4Vs27fpFOMUbZ/sA2EV/vBvbw6lmSLlutNdn4xZWJ8/K9
	 jZsn7rs4ZU4E74p+P3KgmnpNBUlp1agIrpAPowOMiM4mOvX+kkOaGRmkBtzLN2Diwm
	 bTvJ2bh7HsSGOqZ9HdcF2nLF+eoTh2kLjzIZzvwPbTIWwf4yViAh4Qce8eNltqGdBQ
	 5VPtT/4K3kYaJ33J78wpMaUw3pJCFzwsxQjTnQ2KCncF64bM5GxZBAX8/gjWbipOo7
	 4zEthU+cvee7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 030/317] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Sun, 24 Mar 2024 19:30:10 -0400
Message-ID: <20240324233458.1352854-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 96e202f8c52ac49452f83317cf3b34cd1ad81e18 ]

Use source instead of ret, which seems to be unrelated and will always
be zero.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-5-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 897f38758a230..b5a35999d8dfa 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2920,7 +2920,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0


