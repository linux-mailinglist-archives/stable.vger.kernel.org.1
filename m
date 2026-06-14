Return-Path: <stable+bounces-263074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WgPWEAnALmqp2QQAu9opvQ
	(envelope-from <stable+bounces-263074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 16:51:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D168151A
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 16:51:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=quora.org header.s=google header.b=Lsam92mS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263074-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263074-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06199300CE76
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574A73C5DB8;
	Sun, 14 Jun 2026 14:51:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BB3C5836
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 14:51:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781448700; cv=none; b=BHpA8lhPOA9OtCJF76imT58ubtGwVpK3NvBg1EyeX9ggTSKcLU2z/rZF/VJRvbISi9eLkLXG7c2jENj1Vy/VkUOxyo680ffLF13RRS1PdbGiL9Yp3v0/M8dxtzRKjpQ9Bo3JGXsW9Rmac01HuQxZNht/zGJ7ftiJE90DkmLYx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781448700; c=relaxed/simple;
	bh=Q0X/qpV6OiVig0rnFyHw8H0kYx8sjAI6G3zKCiw3d2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKkJM871iHPTmMobAjtxhewNvNj399hShmKESV7ydJCepmfP0Qft8zexhVNYw1GR5FG2QnOHRUxFtgpo5YYftzoL9mppmlUdvrbMLKqIb/ljiHLM9Vktq73B9rGtuCXFm8kMCtBZv5d/t0QYwvt6pJGLzkpdrCK8UZb0uuBHfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=Lsam92mS; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0b944f6edso27003885ad.2
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 07:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1781448696; x=1782053496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4soJXbEiJIWDYO1GkRrtkxYao7UqwnYefJpu0d9FEg=;
        b=Lsam92mSl0nTo27mMh8oeftkiUHTCHehN9A8aq09+rk5bHVEo15opw7svRzCmDkt24
         UjGovlhslnlsBpAdQ8iwWwCOPWZ4lyxcXIKsds+xqWe7jS4W4gpinyxc9lVbf2x2MF6W
         vly6y+DpFr2MoRn71Nse4kxd+RYGhgLIh/cAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781448696; x=1782053496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4soJXbEiJIWDYO1GkRrtkxYao7UqwnYefJpu0d9FEg=;
        b=XWpyNW7DhzHKjyrq3SKDeem/5AjXg+5dLhmORBicBCW4YZ6SpCLGngpQDs9WeQHgI0
         osMoPjstVQt3BWZ51Gdft6LoQURKaIBn5WHNKKtlI8RYLkqjk95fmLmMRs+tIJOdAAl2
         lPaw+HblzeQ2EyWxbdIFG+zWeOJ8708YaqD33Sj4Gwa3R8QMC7jW/GgH2topN2JBvuPA
         EJglhuPXO0BKrWb9FRm6IumbL5rHnQxlaZYYc7OyYOYoBw/kH2GJZS1DZ3sMh7aa0I/O
         /VH/v3G/sz1mGZQBCNz74SnaQWZ6c0Z6Sz1tVEmgh/aIVg9X6zi3Ovy4UIELftnZzPmq
         c67A==
X-Forwarded-Encrypted: i=1; AFNElJ++0e3DEyJdFL+YRIHLqoXORScrJJhEjjh9MByzV8+vF07/YSOHcj+96o54p4HDl61AerKrMxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYk1bshpHpn6D8eD+oLjqvSJDU+3LGYEACfTBZdG5/Nr1oi6GT
	55w5YMqbb5e3ku7k1YMi7zLZQV4CxUS54G+LG1FrmuBZGtBxJQCA0B3NdvYoW0z0Ung=
X-Gm-Gg: Acq92OHQSZJWIXW4Kfmqg68HMtkUBTCTXEoLUKsL7gMvTDO7/WgqcTe5jqSBdn+5aDh
	PLcpostiyVNUJgSbbJ0p8phvKpg580t1kR2283eWCo4fsBV84iblgyun2Zsl9EeMJit/YLtAxoK
	D7sRS4oiyhjQCsDSpH4bxH4dLsVVg8BDE5x7aizgDfEHC7L9gmtb8MluQdMaKkqaaxuWAFXdKw3
	7PftoPm8E3ju+SbxiQV7U688brW+8UaHVZItAoX55lY/Ta2F4DJ8VU1snwH7oQ23lF9am5SXgE8
	lWOWaFYyxTUMpFGbP1PwJE7B/UmPVDfkrBwSbnR3T6lXN54IucceZpDJtkN8KBjHA3W8ldIem48
	e5ZMOQcPGv+ZE82RaXKrrrg/IyuhSY+wTvv1DqbMymAlWvj/7x/glPeAOFVmdAKX+nZp+ljX/oM
	hDvPuptse8rBpn+HtQoqJFCVGb1rqAFtD73qTnfEVe9dYsqaVGerXtDjgN/laKxPYye+zLc4rqV
	o2HKUzQDWxG0hBvk4GQbZbFaEfcrousfh16OfYvfdKbXeA4rvPSon95mJNLhBP8uWnVTjYdxsUu
	SQoW5P61Qh6OnAsk5v+j3WuczGUw/f7TkEQTR1m38UUnbmgv3QLZRo77BY1YJg==
X-Received: by 2002:a17:902:ebc7:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2c664082585mr87995225ad.0.1781448696479;
        Sun, 14 Jun 2026 07:51:36 -0700 (PDT)
Received: from aegis ([2001:fd8:4d03:c800:f499:6f6c:fbd4:8f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327acca5sm66746385ad.51.2026.06.14.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 07:51:36 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: "Bryan O'Donoghue" <bod@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Daniel J Blueman <daniel@quora.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: media: qcom,sm8550-iris: Allow IOVA reservation memory-region
Date: Sun, 14 Jun 2026 22:51:11 +0800
Message-ID: <20260614145113.84243-1-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[quora.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-263074-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bod@kernel.org,m:vikash.garodia@oss.qualcomm.com,m:abhinav.kumar@linux.dev,m:andersson@kernel.org,m:konradybcio@kernel.org,m:daniel@quora.org,m:mchehab@kernel.org,m:stephan.gerhold@linaro.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-media@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel@quora.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[quora.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@quora.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[quora.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,quora.org:dkim,quora.org:email,quora.org:mid,quora.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B58D168151A

In addition to the firmware-loaded codec carveout, some Iris platforms
need to declare an IOMMU IOVA reservation (a reserved-memory node with
iommu-addresses) to keep DMA away from IOVA ranges that earlier
firmware stages have already mapped through the SMMU.

Permit a second memory-region phandle for this purpose, and describe
the meaning of each entry so the ordering is unambiguous.

Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
v2:
- drop redundant maxItems, keeping the items descriptions (Rob)
- add Fixes tag and Cc stable for the backport dependency
v1: https://lore.kernel.org/lkml/20260601041336.9497-1-daniel@quora.org/

 .../devicetree/bindings/media/qcom,sm8550-iris.yaml          | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
index 9c4b760508b5..5abcaee4101c 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
@@ -80,7 +80,10 @@ properties:
   dma-coherent: true
 
   memory-region:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Firmware-loaded codec carveout
+      - description: IOMMU IOVA reservation region
 
   operating-points-v2: true
 
-- 
2.53.0


