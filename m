Return-Path: <stable+bounces-135947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54B3A9910C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4F14455ED
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5EB285414;
	Wed, 23 Apr 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="siXMo9Dj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC00280CF0;
	Wed, 23 Apr 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421256; cv=none; b=WeGw7XnBqTQgSK5pkwPGLCCSvjDOKOfIHZhBj0WhmoKRqgIOHrY8P8DFbqc4FYBL5a4Xc/7e1Dd51Q5T2sUtjj91eLtSV7rf59jxmCvplPRroKkzlos2NuB2JGV/dc29GmmNy4GoxPjnuoy3+bqcqWOUk4IzbrMpO2hKXyS8lec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421256; c=relaxed/simple;
	bh=XUe2rKZgFr5ZOBcfq9voVIGj2mymy3bSVf2atRaMbnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9Su49JptG22klfkhVHlA0tmwKIgRKoARAdaRchz72/ZhD/j+U3JEYmNkrY2XTVrexE97GtgE6vXbwmvV1T7anLFpKFOkrZiJSlwpx3w4j995UEhgIUU9aEPAQ+DKay//L/h/+pW2jYcF//uGZlnXx4EFOii7AdfffMK5o/T83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=siXMo9Dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCCFC4CEE2;
	Wed, 23 Apr 2025 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421256;
	bh=XUe2rKZgFr5ZOBcfq9voVIGj2mymy3bSVf2atRaMbnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siXMo9DjzNGUlQXvtdFaPcKRF/c1uT1K76h/0UpDWbFcA7dHA97SSm2R3xQYylUZ/
	 7rhIIfzywH2ow7MB/oAJCkfJll12n+y4Hp0K0gsZUB+svLJo84158NKMpTS13g3AHu
	 g+STVzOhc0ToCVF/cWFo6dJvvugGh4Hg9VKD7CP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 157/393] ASoC: qdsp6: q6apm-dai: fix capture pipeline overruns.
Date: Wed, 23 Apr 2025 16:40:53 +0200
Message-ID: <20250423142649.863026815@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit 5d01ed9b9939b4c726be74db291a982bc984c584 upstream.

Period sizes less than 6k for capture path triggers overruns in the
dsp capture pipeline.

Change the period size and number of periods to value which DSP is happy with.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://patch.msgid.link/20250314174800.10142-6-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -24,8 +24,8 @@
 #define PLAYBACK_MIN_PERIOD_SIZE	128
 #define CAPTURE_MIN_NUM_PERIODS		2
 #define CAPTURE_MAX_NUM_PERIODS		8
-#define CAPTURE_MAX_PERIOD_SIZE		4096
-#define CAPTURE_MIN_PERIOD_SIZE		320
+#define CAPTURE_MAX_PERIOD_SIZE		65536
+#define CAPTURE_MIN_PERIOD_SIZE		6144
 #define BUFFER_BYTES_MAX (PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE)
 #define BUFFER_BYTES_MIN (PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE)
 #define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)



