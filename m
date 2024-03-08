Return-Path: <stable+bounces-27194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A63F876CAA
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 23:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4651C20EDB
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 22:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0025E3A5;
	Fri,  8 Mar 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7epss16"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D665FBA7
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935715; cv=none; b=nAJc2mf/CKemRvzCvdL6l7DqakrkEPb1jZ+c1VZSk29uAGMMBQ1B1ocoJSh99Y+1kAmUTm1acAAWhFinKMG7nqW3u4TAGdHLCaAeJ+40dni3URvBmIIm3g8hyUG8h2oiN1rEFNhB3U1kiPI2Ma6FS4GQChvteyMtmt6QlW+WQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935715; c=relaxed/simple;
	bh=6hqLrE2kGzcpPPlaLbbol8vDLZeqtCffaioj6zahxA8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V77C654xCTdiprwlU6ZEeY+RAw8VDWqf2JZspoe4UeDsjedqS+mCZefP03+Cd2uqtIDVbOssGI6B/sNBh22X5l7ZWIJayXIWwgmMf+1BMxOkhhye+ly+kRu0uLZpCf9MLNgkgrj3j+K9dv/RSneFrvYtslowORWg8DGBvAJh0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7epss16; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5132010e5d1so3676351e87.0
        for <stable@vger.kernel.org>; Fri, 08 Mar 2024 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709935710; x=1710540510; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=444788bR8YBECKjRiKnANVI+jwd9C5/5ss16HCbJeCs=;
        b=W7epss16OhMlSxauvCOCN3QjqlDzgzdrYthPdAIi58ucs4cZQd+BHwMgUElrUyB3Hc
         gExBPBHj05CUly/jPcZ848GB8cM8TOssgswcE0C4h8890xFhJdMl1YScRplnHwMor19b
         +7lJRHm3ERoLD6lUXaD7WFhiKAj7yUmde8I0seTiz+jCr2YDQXeMnUOQf7bfCt85y4mv
         il9FK2d4Q36bgpvocxPLrIM8mYETklD+XKU2dR5lGo9ZKmR/rwCf5f0eRhJgpZnhHP4b
         GPDeQq0HBx7NTVY3/NgLCxyof3XFGhxxAslGIHJR7iQN0a4tLnRH1Hd9iz4YSNkOO6SV
         Lzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709935710; x=1710540510;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=444788bR8YBECKjRiKnANVI+jwd9C5/5ss16HCbJeCs=;
        b=cpfiRE6TnscKQ0zndmsdA/PZAc+Ocms3TlI1xwwX1NJSBZR3qxtbHu69BbLr7hxrNi
         eFS/XsqxMwNSSr+Y31+v6eh5x2cjbN6P7BikJHk7AuDLvn43P/W2A+fm3wr2U9oCWeOz
         3L3+P4XQCFleEh3i6BhPA9smpdp1KiT8PgJEZLUjLtuTRSIpdFF+XzOsV3oWAC065j6n
         p2pWFU6cRpGOAmNuHz+iq/OlpZrI+e/rcU68V7wuhDsP2krvOqYuvK5YfXX81aNnAm1e
         KzPyHQ6VcFappz1TfJFdrTlDsBMFWJqdoUAPColg3gEeGR8HgT9iIAU4oik2KXjcam6b
         3aGw==
X-Forwarded-Encrypted: i=1; AJvYcCVBVHr0fIkzSDcMVULDbqlL7oLMoreNsq3phVoGpBAkP74NIN8gh8dIpGnvK0SUEdAE5AUUCbt8qxGuBI6iYADrrO4l3Cmx
X-Gm-Message-State: AOJu0YxaUlUkWuqVEP2anBh3R8ZurKR+puV9VtU9MT91vifSanmDHnqC
	uKD88ul13bIlNLpBN9Xz2e3UN5pt70toaHe8VW08NQ5+XeuE+IxfR3CPzqUQAko=
X-Google-Smtp-Source: AGHT+IGfdV0sn6fso7vz9UOJkRQBSyomE8U61mJRksNWd2WuskneuQ8WFl+tp7BYBYK96WxWaFtgLQ==
X-Received: by 2002:ac2:5bd0:0:b0:512:d575:4745 with SMTP id u16-20020ac25bd0000000b00512d5754745mr222889lfn.1.1709935710464;
        Fri, 08 Mar 2024 14:08:30 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512020e00b005130ff68b87sm78241lfo.109.2024.03.08.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:08:30 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] QCM2290 LMH
Date: Fri, 08 Mar 2024 23:08:19 +0100
Message-Id: <20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOM62UC/x2N0QrCMAwAf2Xk2UDa9UH9FRFpu8wGajdSFWHs3
 xd8vIPjNuiswh2uwwbKX+myNAN3GiCX2J6MMhmDJx9opDO+l1UyanKP+iromOYQKI8XH8GaFDt
 j0thysap9ajW5Ks/y+09u930/AGbD0iJ0AAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, stable@vger.kernel.org, 
 Loic Poulain <loic.poulain@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709935708; l=807;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6hqLrE2kGzcpPPlaLbbol8vDLZeqtCffaioj6zahxA8=;
 b=a0axESlwZwu80bUuECyc07XfWyvUNwVbZgVKdTsfIs74EWLuM+j4lhtnGG5ZoJ8T/oa+7Ed8C
 WEN6GC92xCXDcwyiBqcfRG8tfAjyqhBfZEsuaXPDebvLzxH5pT/XrdR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Wire up LMH on QCM2290 and fix a bad bug while at it.

P1-2 for thermal, P3 for qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: thermal: lmh: Add QCM2290 compatible
      thermal: qcom: lmh: Check for SCM avaiability at probe

Loic Poulain (1):
      arm64: dts: qcom: qcm2290: Add LMH node

 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 13 +++++++++----
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
 drivers/thermal/qcom/lmh.c                              |  3 +++
 3 files changed, 25 insertions(+), 5 deletions(-)
---
base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
change-id: 20240308-topic-rb1_lmh-1e0f440c392a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


