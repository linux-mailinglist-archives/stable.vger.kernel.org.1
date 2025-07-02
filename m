Return-Path: <stable+bounces-159241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90539AF59D5
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 15:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6E51C45890
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E261B2820C6;
	Wed,  2 Jul 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejB0/v7S"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6AB280CD5
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463729; cv=none; b=V0B5bmpy85VHGSUi9HKopfYxDX8aEobU5YYOfGCxHS2MigB/arUyNXWx/2cSYnxaRCrxjZYkz+TSp4GqsBMxQ0EVVvG88XZ4KBBN666EmWALP8qni6JFa2nB2LJNHLQFMEqtrP1yfJ8cLsMIfEHOjrhSvgYpDKagp6jgUJPAxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463729; c=relaxed/simple;
	bh=8jJX77fMwFm/xUmCW0r+3HoujzaMaMtZTgzsXj/A7Do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ouce1wKRygJwE4np5lwjkmSxhXF6ypn7TcjCdNxlfyO7+lbKXfic26PojUxUMYXfV1synijr+BKDaxuG+kNVHUnPewlhk6LlVqy4QOzr0YXpjUsjJXxBQIiqq1Lq+d8fN/jlURcLzGkXAh01ER7Dlcql2ZBcUZRh/mBhzyMcQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ejB0/v7S; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a52878d37aso896779f8f.2
        for <stable@vger.kernel.org>; Wed, 02 Jul 2025 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751463726; x=1752068526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nxbw21eCjvigwTkxmQkjUBGSZ6O2pE8KYrbWd2bLkaM=;
        b=ejB0/v7S+X6O9bvUs71USS3sU9mcRalgBkEDUcePST1JR5JhhuuIJOP96QILKmL3QK
         LqnIuXwNuvfVzmrehO/JuhRvOprouBgKcj7wIXLweTITmcRJqJLaLMSCErC42Tev1U4R
         9+AE3oVhLek2YzREQPfH65NLyZz3hGjDQdbxNRCsGvexRQg/CWvyYdMFHAIUCX5ZGWXL
         kYFtvx6Wel1Mc2ReoR8eRHVMOnfh4iabJ/m62CruHUhynVfgVXQ/GqR3rCjuXvxzx06y
         H9CjumJIaho6yDUflLazJFD8FO0I5MaX9e/64XnTJpHAvGkB7iy15WGx7Kbgf+dLpuu8
         8u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751463726; x=1752068526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxbw21eCjvigwTkxmQkjUBGSZ6O2pE8KYrbWd2bLkaM=;
        b=XP4u4VdAz1J1gc7ve5RmfY+pRlScZqtHL5R9eAk7P0HIRPUBHevHCU+d4trYeqNNHi
         TgRtardqhAP1R2zvrwKYUL/auOKGkM+jDiPDLq6kDd9MCF+FqMnfjOycGN96a69EnwQ3
         EHmf34MZaU114hCk7jGnYtIEoRX4cmVPjTpF6MwfkXykl84qmWNGApX7W6O+bUe1hBAF
         Y+q96pF7n54XUI0dhm5yyqW8460oefKqc3ioe3HEgva5Tr4iIAouXO4jM+tYZbMQyzQB
         TOs0xZCOA6f+yqioLq2kzy3OFJKCBT24F5XupZs6XnlgoCoE6SKQB/5ZfOHtE69mBWnM
         QSHA==
X-Forwarded-Encrypted: i=1; AJvYcCUFa88NY0H30AqB/V3n6dnDsxhpqE+gcfsoOUd6593RVOy2XlhzlVtXM/baqkGVLRX4RRe1/1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPfURTupSvMpriz0uu2exJa5vUUaO8ahLAgEfHSBpbOgDxOpBs
	WbPVhnTnfdWBWN6y1B04XdE/NNhbLJuASg7Xl1r1JtqCCw4fchiQ+Z7SsMPLuo3EgBc=
X-Gm-Gg: ASbGncv8SQZvoreAN1JmhZ7cEKIlUV2alB66gPPbIV6vrnRg5Fvh9r6wvisESvT5pvr
	D7Oj53CCv1Xbb2auNYwTr496NAy5LFEg/L97VJkMptDUX/npiMYp30D2eUwhnV7Ts34gleaStbd
	2SDjqt0RwyWBWRsZRvXNFnPJZvCJnJnJbxT/cc7+KDhkrFZgaNJTyYbgh+Pb+RfhOjYBc/rCWMt
	j3TOA6s9Z90yfnOS9gxR0fxrDa4EOI4AOLQ/Bx7+eiq9K67ZJBff+mhzfrKkVgARxuJo+OEOLlg
	rNCSzRi80OzWltjJ+Jn+fHG2qM40Idmo8HemOSpB2+D6wnX88pKO4RAaLLk2wPj3Q2EhE+8UBMY
	=
X-Google-Smtp-Source: AGHT+IGv3cNHYzlxR8z+2wi0VwPFwKxWuKoNTeM+XJGhBONAP5AO5viuU1uDZTJIBZ8gfcjyNdNDvQ==
X-Received: by 2002:a05:600c:c11a:b0:441:b397:e324 with SMTP id 5b1f17b1804b1-454a37325b6mr9016165e9.9.1751463725959;
        Wed, 02 Jul 2025 06:42:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453a85ab932sm34501915e9.0.2025.07.02.06.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:42:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] media: iris: Call correct power off callback in cleanup path
Date: Wed,  2 Jul 2025 15:41:58 +0200
Message-ID: <20250702134158.210966-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=8jJX77fMwFm/xUmCW0r+3HoujzaMaMtZTgzsXj/A7Do=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoZTcmIxPfZouqTdHL40xqaJC9jb8l0tBbdCO9d
 MDDmwLZIWmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaGU3JgAKCRDBN2bmhouD
 1380EACX+G21CH2i8gcOLwT48jxrhqbSIa1xmnGJTgN9en0VFj2iquKAvw8Mi14okHzwJ6tbnjS
 xGE/38rchqAyjmN8PApxTcPwOD4hvDBqoQlpou2p4JhygUmN7HINLO7yfaUfd8IQ8V+xe7474zS
 ZbRMvfWtMPkpqqwYLPNeLrYjvmpsDcy7KjhRAsTROAHjK5DQwvuiiKMX8UzhdoHwcGYoXuoryWo
 A5X3/IrQKcHuUljUqOxZZ5utjjY3F9ZAxPvMm/yD0yP1fiTMEgCVt/mvAK1b8g4zIVw0mHmifJ8
 2ciQWA7TJw0F6uG+8q1MX2WvM3sQYm3PMF1z4DnksU4OaL+9lTDk1BBnTvVCglP+Ksl6oAJs3JY
 CEHseCXtyMmvA4aUrw21u8ycY3wMpsdti/F5KXk16lGwAPRAWKUH9SwNdYlPJNSy1Zt0+/2SpHF
 fL97svpN7IWk4jTL79jbGr10ZDVv5fPDQSmSxpGsSW7C37+CE6DAuTPIC0ipvsqwIhz+zc/dWu7
 nIX12Xu9xsID33ZgylyrRKkREbmn2m+IAcubA1TjhV7rcxmE+2uriwI0kThNik+oGYO/LwikPHm
 z3F8KcwvqBKSrrmJlpv8cv2zM3DnbEQGWw574YNFZX+AGgqh4+Mg+JtoZ1bFbbMTPk/B1pSQCSY ELndQ2z1yTLoYyA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Driver implements different callbacks for the power off controller
(.power_off_controller):

 - iris_vpu_power_off_controller,
 - iris_vpu33_power_off_controller,

The generic wrapper for handling power off - iris_vpu_power_off() -
calls them via 'iris_platform_data->vpu_ops', so shall the cleanup code
in iris_vpu_power_on().

This makes also sense if looking at caller of iris_vpu_power_on(), which
unwinds also with the wrapper calling respective platfortm code (unwinds
with iris_vpu_power_off()).

Otherwise power off sequence on the newer VPU3.3 in error path is not
complete.

Fixes: c69df5de4ac3 ("media: platform: qcom/iris: add power_off_controller to vpu_ops")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 268e45acaa7c..42a7c53ce48e 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -359,7 +359,7 @@ int iris_vpu_power_on(struct iris_core *core)
 	return 0;
 
 err_power_off_ctrl:
-	iris_vpu_power_off_controller(core);
+	core->iris_platform_data->vpu_ops->power_off_controller(core);
 err_unvote_icc:
 	iris_unset_icc_bw(core);
 err:
-- 
2.43.0


