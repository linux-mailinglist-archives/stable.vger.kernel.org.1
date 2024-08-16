Return-Path: <stable+bounces-69329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B67C954B81
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 15:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCB31F23868
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2401BBBD2;
	Fri, 16 Aug 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUNgIjoU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6F198851
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816652; cv=none; b=VVaI9HTOLMd7/VNQlC9S372qybIsCteozSoxyKVRUpgVgcTqLS6ZqXz+Nbxmh23VSRPv+xXeK/M6VEVZ8QmiYqpJ89IELzJMlQfBExQdDaQ46Duv46Miuv6j7l47SBbpvZ8Ocn7cH5UeNHaDBZbRkORRBYHoSEegEsQqj/Xs8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816652; c=relaxed/simple;
	bh=bhKl8LrqSNNy1pCMzfb2la/HnUfCqWNtqkdVM7XHdW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GI5eNrcXedSFRD6BHDvnZyDOiCjbfA7jstiA5vdINcuKZ2slvtRVZ7VNlItUb4fib32qlNWQJ8VTZ4daQmN4y7HFom/ZpFPNPqijvCIWJQKQxa3Jo4ekVO4zaGDIRbc0fcoHPVB+hGneaAXoXSTTv7KdNSBPInlT2cyaZje7cp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PUNgIjoU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428fb103724so16212505e9.1
        for <stable@vger.kernel.org>; Fri, 16 Aug 2024 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723816648; x=1724421448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUFNUXrgokXIwMs6WyuldKV0ZX1UE+1k07OmPjO8LYM=;
        b=PUNgIjoUp4E6BcHv/9txKXtLNQH6UnoJ8vYc79mK6ktExzy4vFH0DVKEKUMbiBHqFT
         Lud8vllDmLRYVeelE3zoOl14JcUqK6aF5L/5HbtKMtZOGbMBfFBGvM2YeULzkA3Y5kMK
         eVOUIDsDgV0Xd4iXAriM8pRNB4D18/O2UZ+o0yXjbQ3F3U2zDoLCJ10jnWWTteLbOeBg
         RLuxURTBUXfDK/fWvETtdSNkyMcyHeZ1F0tTdxgsvmAjObYmr7CKUWsma3pqdvDTneiN
         2vVqypBE+XGAPHsNTxpet4VjPOH9guXxDxCaQVFlvv34/Tb/T56jCG5nccj7rfGHw29N
         Q7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723816648; x=1724421448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUFNUXrgokXIwMs6WyuldKV0ZX1UE+1k07OmPjO8LYM=;
        b=JBzgq93dnFyJBYzlDRDickhAw/Ah60F9GA/L72oIR657PF/MA91vtQDEogxBjalZjx
         jzo3wXZnHspd+48BstC4TPsIVSlRTEMpGiqls4JKa5EL2ia2IWxHjsfT7zcLbtXh8ZY2
         kPgATZb/RFRb8TOGFS5pylzJAyju/AHc0yP7+/EtLziDyXFDQ/s1lQx8wBfU4lsfaBVq
         H/2qZikB8rGPyaSvuMG7iMjTACXo1vfvMbfKN2ivdmJpDrK0k+l2UteXKlZgzidtoiuf
         eHlp7NMmLBcysBu82sUcGPMRfEMNEd+9sYKlw9NdVlWImW+IGI2o2aQ9DOI2djYmyr1s
         aHuw==
X-Forwarded-Encrypted: i=1; AJvYcCXv/BSCVBuzXPjiZk+5P8VuQOHbS19ubQVWsqFJCxLZ4ENy2YIlj9xJy9dKbUtUKWQMVCIfKLGIxJZA12vOdDsWxGlEr0Ve
X-Gm-Message-State: AOJu0Yzr0YWzgD0ijzNRwXdR5ZcGkzxcwL0xGX0SZtQkNd5EDKqEfEgp
	UkdM1nNDaCgyuF5JpQMEPRZwVYFw7DmF0PYA07B+NzdYfDvER7JmXPcFRpFjwmY=
X-Google-Smtp-Source: AGHT+IFd4s3kymirxsu7ePVn8TcQO9UzOm0dQNnvzYRLs823Sud4ew3QO74mnMOX7OeGvHmgZRcr8Q==
X-Received: by 2002:a05:600c:450c:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-429e232b8a0mr48393265e9.6.1723816648319;
        Fri, 16 Aug 2024 06:57:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded36a95sm76183995e9.28.2024.08.16.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:57:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Timo Alho <talho@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] firmware: tegra: bpmp: drop unused mbox_client_to_bpmp()
Date: Fri, 16 Aug 2024 15:57:21 +0200
Message-ID: <20240816135722.105945-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mbox_client_to_bpmp() is not used, W=1 builds:

  drivers/firmware/tegra/bpmp.c:28:1: error: unused function 'mbox_client_to_bpmp' [-Werror,-Wunused-function]

Fixes: cdfa358b248e ("firmware: tegra: Refactor BPMP driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/tegra/bpmp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index c1590d3aa9cb..c3a1dc344961 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -24,12 +24,6 @@
 #define MSG_RING	BIT(1)
 #define TAG_SZ		32
 
-static inline struct tegra_bpmp *
-mbox_client_to_bpmp(struct mbox_client *client)
-{
-	return container_of(client, struct tegra_bpmp, mbox.client);
-}
-
 static inline const struct tegra_bpmp_ops *
 channel_to_ops(struct tegra_bpmp_channel *channel)
 {
-- 
2.43.0


