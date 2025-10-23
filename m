Return-Path: <stable+bounces-189099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA857C00D47
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 13:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276E43A4507
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 11:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C7307AF6;
	Thu, 23 Oct 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vtOjg5wO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA078F51
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219473; cv=none; b=rpIPzI8stOdd4HeHqgX0mYL0cdTGbF0v1nTnT73+OEdnqc6oj8eYG1FUiCH6vYoaeuZPjTB66kM03IO3xO+gJiSzzAPOOaF5WFDGu/SqACUBU0UkK5nozF4LFIy3G79+xNXeOmFavXU0kYo588iMX8WsIL8yjDfhfB48FdPwaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219473; c=relaxed/simple;
	bh=DWNX42d2o0p3UKA2TRUwPtkFgHSS6IWQH6Pd1wztGVc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tQ7b47xX3qReKf5ExTSqsUD6oZq8QUMCQGMh7b2qaav4rgvDIJLsAhLVO7I4ytDOF0D6noii8KETP9TqVnFuWKfv4HYDYhODAJUSm5t2j5m22uyU9jT75U11wOoe81Dt/EXBVGHrc3y3pcPZfoM6FOk/yzbe1zWhmAa1C3LGbAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=vtOjg5wO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4736e043f9so139934466b.0
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219470; x=1761824270; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VxMcMyLuAyYtT6gutxdzEE2BGizoE4ASkRahe6sYBf0=;
        b=vtOjg5wO1dAxjGa5P5ntjIceLEItalAgdpxzXGOn5ZsVLstRk6qt0lJh6qDDHmX4l+
         iQOuK0E1vN7t3vZM9Dptm6WPI0HgyU8ndhMPmtGrb2TfJCY54lP94GX4DWqFmW72sMra
         pXbYCl41Lo1qbNc1WNlyc2d2jJ7dX/jE2XcR2ZoMGn690kv3aH3LJ+ivwRPuDqt/HEmR
         n0ZuzUHEik5WxOrXjKg8cBs4qLpsmKmamnGr4/uAJiMEFL2IADzhHe3ZZU28z5hixPO+
         Qz3zN6gyqv2WKEm1IBWQdCxS+EWEU9VTpFuVA6Sn+CVzWArbxrHFoZcRv0q5f1C157Vu
         wikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219470; x=1761824270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxMcMyLuAyYtT6gutxdzEE2BGizoE4ASkRahe6sYBf0=;
        b=HA/oIOp3gCaF8vwmCVhG8mWYD616ZpltAn9I3x7+A4QlALeeCa9Xvgw7CxEQXovK08
         SRve7GdljjUq8qbAYbsprjImiQqiOXBLgMOLzkS/W/9vqFPdrsRs/9ZJsWmZfoE8wme5
         ewmnUZObaxrLIVk1R+sL4PkErQmscUwww7iH6VUWUkAZx0prnkaKIgD6OGZx4/uMX3yB
         zYOms77TDJBwFmFz+Z8VSN0V3FOLASQJdUeALfzQARtvDXrRRfSUhfNBSzvx8b9qlIxS
         6JKBbCfWeRdBPzGs20iP9O9sA+K9vdfCD7U7vicqtkZHA9q0uHqoWLtTEuYft3/erfwq
         +ICg==
X-Forwarded-Encrypted: i=1; AJvYcCWYhyvBKpPTpchLridJO0tLbd7RAuy5kekxT3/oXsTcnKh0kR0y/nJvyruZasHKrvoMe1Thahc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLs1Bz/CDGgLxo4iKwD4qDDnCYKlmKOz37WsOZ0/9sIP90yJS0
	i0XDmfPZWjHY/09Wat5MtKAKXinHcxEFDs6xC/2cfFabzi7DfrZfTQCQQ3c7d2TD670=
X-Gm-Gg: ASbGncsMCN9b5BHUZVSPi7x3bjri/e+FijM23zYVhMQc+0b86rLm4xetxcnlNgPya7h
	jvrFv9PG/kUIhJnEuoZku7wlQTmnYubBAIqZNzNqysHbc7LT6T8JAuusJZlk1J7bMNZm6rWAoRL
	ycAWxu4AFU75YqAhtiYkbQgfKjmZYcIrT2ErGfm4qVrb+IbR/SmU+kJCUNAy60O6/7H+LcZa9V/
	PNwOESeWMa+sfaXAG8noF0QbO1l0RvfMZr5m/4GlBYsRBQY8fw0IFFa/FfzbcvV7xCu+MAYNpeN
	IQbY5SpJSBnd18Yl81gzNEjQrJdVmTRmIesv8jGzm+hoGGOMfFJnmadQ4A9X58XnKzrG1WMQecu
	IEh3Fw8rWlsoZ4J/NnIdORYbWHNThGRnC0Q7zpGd+rtEYx+yXUrDrfmcNgJnpKx51i30eIFWjlf
	W3bbU3+AlwvpalLqI4JOfQYbl0/lcFTer9WDvF53Z59Yqexg==
X-Google-Smtp-Source: AGHT+IFFi0kxjJXcdhbKgL+sbBm/wBkqtVc9R3u5L/V+k7O/f9DsWz4cBNYXQNrlVhDEV4kqiqw0cA==
X-Received: by 2002:a17:907:9492:b0:b3c:4ebc:85e5 with SMTP id a640c23a62f3a-b647482d7a7mr2977703766b.59.1761219469769;
        Thu, 23 Oct 2025 04:37:49 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f8634sm194429666b.29.2025.10.23.04.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:37:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/3] Fixes/improvements for SM6350 UFS
Date: Thu, 23 Oct 2025 13:37:25 +0200
Message-Id: <20251023-sm6350-ufs-things-v2-0-799d59178713@fairphone.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUT+mgC/32OOw6DMBBEr4JcZyN/YqRQ5R4RBTFrvAV2YhtEh
 Lh7DPQp36xm3q4sYSRMrKlWFnGmRMEXkJeKGdf5AYH6wkxyqbkSN0hjrTSHySbIjvyQQCuje7x
 bNBpZ6b0jWlqOzWdb2FHKIX4PxSz29N/aLICDqjlXtTRGS/OwHcW3Cx6vJoys3U5FxM9Uvs2nh
 726hFDuI+Wm8rhk2B2CS1Ua2w+4N+y05wAAAA==
X-Change-ID: 20250314-sm6350-ufs-things-53c5de9fec5e
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219468; l=867;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=DWNX42d2o0p3UKA2TRUwPtkFgHSS6IWQH6Pd1wztGVc=;
 b=IueMu5/zmuTihJM5QLRB8Bas9Cu2sBN8bwvFfnp/k1+2y+VhxB5dubhVKv9BIN0vIf05Ow/gp
 YSmWl7IIFkKD3ARXHft+sp28/WHo7ipwQhJNnNHXZ7bJSVVqF4OoFs0
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Fix the order of the freq-table-hz property, then convert to OPP tables
and add interconnect support for UFS for the SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
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


