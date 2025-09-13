Return-Path: <stable+bounces-179418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C811B55EFA
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 08:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DC71C8830A
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 06:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609C22E7F07;
	Sat, 13 Sep 2025 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJQZunZz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1C2E7BAB
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757745695; cv=none; b=qBpl5kv57RQD/VMgDMTy4+9RGEdIKtErC/vx76qbi2uKK0v6itFTz9AFFKUoNB51KfCvvkpleqlaeNcatup3xNma4jMnGCAlSZONB+K1XRfM7bHvOE2SN71SrdcN7SdK6iPH7zZE0PYzxuslyNykhxY+VM5ojG31JjnjXv88SXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757745695; c=relaxed/simple;
	bh=b4u/3r8EbbEWIWFxBt9+YcYVVzC+/qin113CQAU/g5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xgb5uMUlm+VprgCX4s+sYkJhaf4Gz7x6PkyiTegrgEbb792FOi0fnWMugyfLzWH/LuZ7hbCyVCS6AkXEHF1m+eLcaOk15mCb/0HEvyCXdU5nkJrVWQJ2F6Ax1QsAolL47Jl974sOigg0Dc+d5CLK7/r6NYYbgz0bxNQ+4WZjCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJQZunZz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2570bf605b1so24578975ad.2
        for <stable@vger.kernel.org>; Fri, 12 Sep 2025 23:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757745693; x=1758350493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+9gSbQhTkyUKu4oc46FN0yP83tgnQ9EveENpBOiA0w=;
        b=YJQZunZz+Z3KjLKM913jEadZLnOuK6XkCvNGtjDKJYuQvXCeWyAKlRceC/SYVcLBTC
         ha4La7ce1PBvnhIYrt0puzT97DoAIE0VSdpsiXCH9swN+4qjCAseUl0boKlUPfZakSvT
         6eD+cVH5PJQANKcq/55jWe4zGvhC5RwAisRKw/CcGt6YHkLmyFcrT03JGiPEsonvSS00
         IqH7RnBkeua2QRM9ZElQ99/o6BOEj8joeMqL1zzeuCWY/qw5vQ1nTLVPnGPFqO6Dx8vX
         7b1NQmlrqXQwDvNIa+3E8Gsyf/mC7jGn7FSdCipkLjyzJJJtxiRR16UIpANndrLHJBhC
         vQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757745693; x=1758350493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+9gSbQhTkyUKu4oc46FN0yP83tgnQ9EveENpBOiA0w=;
        b=urDhUhnK7aA848TjvkQcWI6LxQo/ukDzg5Qov+zkWk4kVjWthmB2uFhIOP+NGnrGVA
         IIOfIJU2B9N7oqYRhWrwalTX82IRhll4dCQEBLMC1YUAMkPqWO+3794oAJw+OTlqURK5
         DEVJGk5S17T8Li2p/s9gR6becyCFiXA3Ddt0uMLhnQFe8app9K63zugW30HCa6GhqeDx
         5bqT7YcDHVjSl6vj3XOQfcW3bhAaAP02njXkP5c76l1LKoxT0uNzg3OyABVpmmji8hXp
         wK0E+4lGf2pBPpGYV+pkRxk81cfxTFKBeb/g0rFPKH+U4a8fWnn1R/f3zvySkfnlCneT
         ygUg==
X-Forwarded-Encrypted: i=1; AJvYcCVOQ27yIlfB0nS2rXV8hNDu/Qf4AcIxbmvjUFDbUhvHvAVezWwoiVLvZS3bg7uXCIQAF3wFOiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYktLayLOUGqoauhBTId/GWWarNmITmhHUq/4pj5PZjDZ4fLhJ
	tfo0aXyuFSf1zwDwEtgGS2wPk7pks2awy25ff5OvqQTYvpA7tXTwKkiQ
X-Gm-Gg: ASbGnctsX7zhNUxOThIvtNsKshCQu/RwAH+d2hVAvL+Cx/cK3+tfTTAr47EGMpjnqnu
	VxsBrjrtIvYzkeNoOW8GFeIqbdRMmW4HhwAzK1NuT0/SI+BPfKG6c1MzIhj9bCdovDxMVUDnElQ
	bYoVqlqQa8N7reYb8w2glp823VN+Z4nH0E19kV4usgkZl52C7kvxJMyomTFau3ylonjpJuyeeJK
	affaPYhftBHgeizWofYKjTub0zi2iYwQ9XT7ClZEvbmujGA9ZbwQUZcKFy4GYb+xkBEjDfepYvw
	2y2dJqp+2ZtMG/aQJjCd2y1Jav0RQAsAJMFVx2+jHZhg87XCoXnRN82XO/E/vmgz2T3Iix0YaH7
	i4ZicHOR3SpmlUaRUZ/ZO4rtZ8iKH5rLMbjHtzp6a+Kk7+oNhjnWpmn8Ul66f2aRxcQ==
X-Google-Smtp-Source: AGHT+IEPMOXqhtSRG3ommkdDyK73YAd9aNroh5EmvYiCkuWeEel+Gu02hYUJwz3pnEOvbev7iIXNag==
X-Received: by 2002:a17:903:1666:b0:261:cb35:5a0e with SMTP id d9443c01a7336-261cb355f8dmr13755645ad.57.1757745692902;
        Fri, 12 Sep 2025 23:41:32 -0700 (PDT)
Received: from fb990434ae75 (ai200241.d.west.v6connect.net. [138.64.200.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c341aabafsm69525245ad.0.2025.09.12.23.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:41:32 -0700 (PDT)
From: Tamura Dai <kirinode0@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tamura Dai <kirinode0@gmail.com>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] arm64: dts: qcom: sdm845-shift-axolotl: Fix typo of compatible
Date: Sat, 13 Sep 2025 06:39:59 +0000
Message-Id: <20250913063958.149-1-kirinode0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Message-ID: <2d41c617-b7c7-43ae-aa90-7368e960e8a5@kernel.org>
References: <Message-ID: <2d41c617-b7c7-43ae-aa90-7368e960e8a5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in the compatible string for the touchscreen node. According to
Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml,
the correct compatible is "focaltech,ft8719", but the device tree used
"focaltech,fts8719".

Fixes: 45882459159d ("arm64: dts: qcom: sdm845: add device tree for SHIFT6mq")
Cc: stable@vger.kernel.org
Signed-off-by: Tamura Dai <kirinode0@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 2cf7b5e1243c..a0b288d6162f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -432,7 +432,7 @@ &i2c5 {
 	status = "okay";
 
 	touchscreen@38 {
-		compatible = "focaltech,fts8719";
+		compatible = "focaltech,ft8719";
 		reg = <0x38>;
 		wakeup-source;
 		interrupt-parent = <&tlmm>;
-- 
2.34.1


