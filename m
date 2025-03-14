Return-Path: <stable+bounces-124469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C06A61890
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 18:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39E91B62869
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB9205AAC;
	Fri, 14 Mar 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r86B2yOL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7200204F98
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974523; cv=none; b=mfnfs5CCOa6tYM3b5xLEY0DyGFvzSzewMa9WjEYxzUHDcJMliawHu3OFsXNBvjGivqXFd+kasL0eYC851xD2pkuPc21G9n1rWDPaWgGjNNiI3vBBvjAD8/KWJhLoZ8TAzHLk5JGH3MNAH/C0CSKUcIYi7DSQm6wfaubRabYP1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974523; c=relaxed/simple;
	bh=WZz3v+vsHhPD1tXnM2Sgca+yquBEKJ/qJRDwgWjeJjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q07bgabaEbklpn7oMm49g74mWl/PKUA/Oiv/wyauk8ygUeJgV0PGYda7RxL5b1pjJwWM4US9scdB0mEW6Q6XhK1oXcVhqhUOPeSrGIvX+6o4/9NDQeXV07LXdFV+OBkQ5+etj71UDN2pKXVWxk/CwGx4HMG+eKUg0jcX2mTIN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r86B2yOL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913fdd003bso1274761f8f.1
        for <stable@vger.kernel.org>; Fri, 14 Mar 2025 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741974520; x=1742579320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/0LkOzwwvJNcYMQhvQr0pJ6M6A5VssVoqwJh0FipfI=;
        b=r86B2yOLrp5ovBL+sphVOm7K+tIjuBHFQSZ4+WqizlY5llipVKCrSY84Wk8kFSlOwa
         jxc4o7LZHP5h1wT9oIiUfYqMwCZetBrYCywa0qOngkxNwfbFD8SEwMePLXaT9oUUldAE
         2vaHBFec4+lgB+ri/yRit/iclJ7YC3JNFIcdNQTWFfeyBvJGu2+uDOJO++VKsUgsYuLU
         gFSxpIBnvExg5ozA1LOC3LiDKy0rwzXM56xLvGvRKYWsdzKDC/ty8XxivYvWWs+ZH4ae
         7W4gYAk/tNYVWRcsTh6DDqni1hhWfg9cZuLHrrKyfcCdlZcaIpG71ftPZUhxUkgj+/BO
         FgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974520; x=1742579320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/0LkOzwwvJNcYMQhvQr0pJ6M6A5VssVoqwJh0FipfI=;
        b=WO9LFu1KVDWOPq7OcfDlUdeCgg66PBaMJ5wIOHm/dcvaAvErvCxi2nI/98j8mS0BTX
         pbHgqbBdDJ6JlzxBVvy0l1LOKfNBQTJsKteqic7X8ITm8WU6qFuxQInKWK/yV4PCUbpT
         7DNXWUq5g1OL1iq1EX06/Mb5szsgxj+UlRu8BeCaAV8U5VAXrsvIl/qWor2FiOhzBfHE
         p76Z4qx+SOo+6/8oRT7Q+ur9cuRIsgsSvDdX+NuqiZU2XLF3LA3bsVViFXvTItQ3+5oI
         Rp6VZlYoX+guWFbxFWtSRPxKqCuKmVOTLdoiICOOtnAUmUj6vTBe7Oq+m4XEW/XceN+3
         l34w==
X-Forwarded-Encrypted: i=1; AJvYcCWJqqdwFVQ4Zox6bGpP5kL0ZKRAFuftXxM2A/yRBo2iqVWyq23NegZnm0Mm0CbNR/aCb7Fw988=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcTHCFqoZGzhKPoMRE6721fmoYDZ0j+bo/bDv9kbeQIPlmrkab
	PvCqNMo5xMFl56ZNN8zhnxlFpGtmXagBpnLX9xHHh0OxNFkrgNRkd5NeV9v3IMI=
X-Gm-Gg: ASbGnctxAHhywjq3Lp9uqa0HwXsaK4J6u1+gom9Hv+pd9HF2PJwC5HeF3EXML4KUcz/
	3NsTwARxrItnap5P7LXuKauAg5LXORKA/pKY3HZgXF5CKAXTZDABuep2oUKSObUJPSAG/fHjclE
	c0B5ncTP1+gLv0ZMVI92J3c/FhuxrH4SorCaOM/FCoBPjIlYqDOxqRSH/AhBzEtrjdFmJGCvkdH
	xhCK/LuXpqYKaRCHNRWJy8jQjJW7QI7UnI9J3B06eeEKy64ZPdRPl2/RSHKOuoxQ33qOuIfx+Bh
	jilI/lbzx5U9g5v8U//H5p2+7YfzVjauQZM0TRIF4MB0k9nLGDYD6dqDIHf6zcMXJnmtTVI6uED
	fF+Pq
X-Google-Smtp-Source: AGHT+IFSURXCATif01r54d+KQHoWw2qah8uuJQ120su2MkweaWrQyfg3Zuqy7P/UA//iCx8NnbbY1Q==
X-Received: by 2002:a05:6000:1a8c:b0:38d:ae1e:2f3c with SMTP id ffacd0b85a97d-3971dbe80bemr5173220f8f.25.1741974519796;
        Fri, 14 Mar 2025 10:48:39 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975afesm6117243f8f.47.2025.03.14.10.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:48:38 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v5 5/5] ASoC: qdsp6: q6apm-dai: fix capture pipeline overruns.
Date: Fri, 14 Mar 2025 17:48:00 +0000
Message-Id: <20250314174800.10142-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
References: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Period sizes less than 6k for capture path triggers overruns in the
dsp capture pipeline.

Change the period size and number of periods to value which DSP is happy with.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 180ff24041bf..2cd522108221 100644
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
-- 
2.39.5


