Return-Path: <stable+bounces-189103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57688C00CDB
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3EE1A621FD
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B890930DEA6;
	Thu, 23 Oct 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="OW+yz1PE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F630274F
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219614; cv=none; b=gHjNFxLyyYbfV/Gf/Cd+FkORY2xEHf67MKmjPXNB9r5/aIb6HAkpRN1ZbwzzE7Bm+6O3L5b3fjDbvItoz3pXyfef2Mv6dyU8TG8MaAGkTf9J3nlf/oMf/uYFV9TuK4dPmlvHbyTphNI2yZ5NvA6RvHkecRebDFtxX/6zkrQ5T34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219614; c=relaxed/simple;
	bh=IT3WjTH4d0Z0+FkVbzYKvEpira6rnSrbJlwlbnTsXWs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QdNyN0qzoxTVe2HGR+MsAwO2nX6MqEWu3VYBcGj73yIhgATUCqUDnhThSZt/9YyAviX8yvUGSnfK3xNMi4QWodGpL4Ve0UOUxwTaKo6KAZctBwtnjRYBNDZh96wB57FMRhC44uVjKYdogJWGvMJTCpdUvo2pIDGggHk7h64V4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=OW+yz1PE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3b27b50090so139875266b.0
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219611; x=1761824411; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIorowqdv3EZF1HaFOt/PUP64NhVkRO5V6vLFAzu03Q=;
        b=OW+yz1PEas8GRNl7GSRRl0vFdpJDyVabSYOPsruazN7DxMxJ1TIBBoFBN8Djteq+GK
         k+x1HESydeLY+UIU34Az69leYeU6TWB1F7U4T2F94GCmBFuU6TDTrjA3XMuPVlJy6TqV
         G94W9u249zT4H2OEw8qhF103G6wuLOjrFNyVsn0XUzIuqIm94GydsKnpgQEFWm45iYRk
         0YTDCfH7xV8q3cu7LEdXMZsqGauF6wwjSR08z6RZrNkneuNTd4U3Sowv0BaStOIzpfla
         1UxiM1COLlr6JuewhZa1QqKk8/tqv2xuKM42F4Y/gViKatKqE4BeQta7+QvQXfGE7Pmd
         gv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219611; x=1761824411;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIorowqdv3EZF1HaFOt/PUP64NhVkRO5V6vLFAzu03Q=;
        b=pvl/agCT3JKTUKTtecJOkM8bADASXq1RO7JxlSK25QfoZBumIJSnU4zh/pQSRpiPiC
         GbV+c3PnVrZB22/qsFRv3A2e3edQKTCr6/HAlHs9rQdgYH3eR9nZO8tCmLQl6mvUe4iw
         Mo75wBMeVpYmaEBtMy+Do5hjEQbK/T/0qKGyAr/FzeqT6IcuaK0PUigrZ3rfm4zEwqHm
         wKjSt7S3BoCq0w5hD/RCjpeCvJR49sTiuvaZC82bof0wnMMfrOsv0/VNM0bX7I2kBUeu
         Zi3XRuE87/mBzzjsivzsuNAzf3zxaw2LPStx/KWM0+xik6zIOaw9lqfsI4ktSHhVOrA/
         9NDw==
X-Forwarded-Encrypted: i=1; AJvYcCXRyzk1XoGj7fhSe6Z1Qupe6+6DzgBbyc29dlwv79wVf9gy1G5cB6mg3qD/NGEzsy9AMP/Alp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG51UzHmwHIGguFnThpjQ+E6MVFlpPDQ80wJMN3EXKMi9OsfVG
	OqFHENv/VT2nD42yZ+m7Fkn1z0jgN1rDP/KZczZFX6Da2EYSP3iBBwMnZ767lUDq0ZA=
X-Gm-Gg: ASbGncvL7cxiusBW/4kYrlVaiJNdENyb9L4vWFbkVr+YwzIwE1GljPejSBDzBw+4GkX
	cRn9E/VMWVW0KWpgmAZr0t20hswoq9WopAUhWnburjW3l3W4A1CoAhikh0tsCaUFdvtamZc5LOh
	PTMlnviiHnYoHTMAOa+E6hgIoMIhay2fsilBZFO7+5D494PBsr/8sRh0gmtbbYPxGBWAiB36nJc
	DPI7ukPFvMh244fQy2jq+k7DfZ0i5+Qpb/0nyAB4RNtXaeThW9VCPR4uww0ex/HPRt7Ka0Yc4G2
	G4bQKLBx1ChC9teZA2oPrkaY8kXbUZbxYD1yIA/oDKLIh3CSWcTtwHrrdLRRQjbplBhIAfVDV7i
	Og+prLeIp1GLWs5sO+3yEPXbO9xjHyZLh4Dq9KyVAS6o8oJ79J40mN8nfijNlLTZDKQkQFY+vJ5
	4hs26yUWdgQNix56/HEg3exO/C8LFlLN4YSHmxKpKgJE+CUQ==
X-Google-Smtp-Source: AGHT+IF9HVQ0oKyBqFvpuJlw2FMI9pRLVIxFWml173tZ1CwIycKjF8srbTzahjeWY+MF7ZZe1M9wig==
X-Received: by 2002:a17:907:d08:b0:b32:2b60:f0e with SMTP id a640c23a62f3a-b6473243c5dmr3059050066b.17.1761219611013;
        Thu, 23 Oct 2025 04:40:11 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144cfbcsm192518066b.56.2025.10.23.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:40:10 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/3] Fixes/improvements for SM6350 UFS
Date: Thu, 23 Oct 2025 13:39:25 +0200
Message-Id: <20251023-sm6350-ufs-things-v3-0-b68b74e29d35@fairphone.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0T+mgC/32PzQ7CIBCEX6Xh7Bp+pLWefA/jodJF9lCqQEmN8
 d1FjR6M8Ti7mW9mrixiIIxsU11ZwEyRRl+EWlTMuM4fEagvmkkuNVdiBXGoleYw2QjJkT9G0Mr
 oHluLRiMrvlNAS/OTudsX7SimMVyeEVk8rv9oWQAHVXOuammMlmZrOwonN3pcmnFgD2KWH4rgU
 v2iyEJp2rbXrWjWjVDflNuraMDzVDanV1t26CJC+Q+UNpXHOcE7ozhud3sCMu8tAQAA
X-Change-ID: 20250314-sm6350-ufs-things-53c5de9fec5e
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, stable@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219609; l=1028;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=IT3WjTH4d0Z0+FkVbzYKvEpira6rnSrbJlwlbnTsXWs=;
 b=we1oHYRq3VFpjv7U2VuhgIidnVWT72Wm3H7lgX23Db76yrigFfFD2OzgQ+7lojxUv6aKyllXK
 xodWGevdr4hDnQUMCHGSTH8VyVe7udUcBV7rMJqw2sPMssvVjgRwuXT
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Fix the order of the freq-table-hz property, then convert to OPP tables
and add interconnect support for UFS for the SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Actually pick up tags, sorry about that
- Link to v2: https://lore.kernel.org/r/20251023-sm6350-ufs-things-v2-0-799d59178713@fairphone.com

Changes in v2:
- Resend, pick up tags
- Link to v1: https://lore.kernel.org/r/20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com

---
Luca Weiss (3):
      arm64: dts: qcom: sm6350: Fix wrong order of freq-table-hz for UFS
      arm64: dts: qcom: sm6350: Add OPP table support to UFSHC
      arm64: dts: qcom: sm6350: Add interconnect support to UFS

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 49 ++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)
---
base-commit: a92c761bcac3d5042559107fa7679470727a4bcb
change-id: 20250314-sm6350-ufs-things-53c5de9fec5e

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


