Return-Path: <stable+bounces-119659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71676A45D11
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 12:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96AF37A60E7
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2278D2153E6;
	Wed, 26 Feb 2025 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWJoRuqt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCA215172
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569363; cv=none; b=YJC/DTifkVDvuBGKBPFii1BfHGZaAahb8UNAe1mRm/wQ976Y6VE6a8TUv+/6311NxQJm2zCXzr0jRZ6tE4O2ATxmzSVof5mQ54O4Xy/l2u4tdYfKc32aWV7aNfaHl0xJVhehUXXO4W1KBFrQ7aRE25p8Cfb7ByNXvZ4wGIwswQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569363; c=relaxed/simple;
	bh=aKWtbob+2RSm5JyDWJSTEd1XNxeI/gXvLID19u4dptE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZJwLU822O8VOAmex1a3/6rciDJ7qPa45XePaiz+Jwqfmc8MjqrUx50WVHbWOGeGGBWf+GxCaB9BgHjRJfg3scRb2Rx/xpQrunt/kclvepM+CBlRv8uBMyWchuCPk1wAkgs9lIelXI4sTvzneXMhLwgdKgj/RHyfvLjyWVtxnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UWJoRuqt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dc5a32c313so1338340a12.3
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 03:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740569360; x=1741174160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQWD29wnrAJlObQ2+b6JbHQHIRXSBf6Z16/xLVUUT5k=;
        b=UWJoRuqtpufSJ1eEwtIyOqn2Ffii8q3WfxUQoiW3l8eK1jfy8sO7ZSqSwzU+mewwwN
         YNtCuoVEiQVFZLeH/a5zy3/LaQ13c8NVi7/429F7iSlAOXqTy0IPyPnjblh1a4blN8SB
         b5sWXJgsFucLibb3IDcTiYsMaV0HAHplVBiLsqL2JLzbg35Q/ufYdBldLq0McgO6Za4f
         7+5rh1Ihoszr4Hg9AMyBbjd/M54uOmWeWRvpPFfQXxMdepwv09zKFB7ldlpZtMKFkwbj
         tCDmT29rjbw2WyHEBNi+n4xyX/HO33y0k0UVlgj2IHuTL8yl5gyYWloOkznjIxjCDl46
         GDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569360; x=1741174160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQWD29wnrAJlObQ2+b6JbHQHIRXSBf6Z16/xLVUUT5k=;
        b=gTelBzxZUuEf6oJXdEWRT12Hkzm56G/ZqPZw5abUl/ElPsPnSLxw3jHrxRvqHlZwBI
         kfsdm5I6FXoT/SvQXAoH2sB2A0rs7VB+HpBeRkUMReClnegC/tgjgi12EL9UpmaIM4xk
         CNrrjfPkjd+1kiEAlehHqTbC5Xr1g+LJm4Bcay3AWjjApTiVnoRXLw6E0rNVleu17u+P
         wStfMVO8uHwpP6KI6rV86E4KVYxnV3vm9rBK0sIv4XVcRkPOn7/4CQtKBo8rWdJu18IC
         GiEV9QQ/VaC87q7dozgOIZbdzOAyApo/Fp2i9bSLkHmE9L6rLOCa+sG2dHcOjozka9Up
         rxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Q6MYsghE64bnAGEj/bJSfq1CAU8Txc0xR9qZyRYtHSHfBnImDsm3nlsVDzM/+1T0jPIVJ8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTj1kqPA3W4FG3yoQQHw0Rabf/kjany9qSpzylbErVIFCyy7K
	0kaZfwFeZhb5hc4Ul4NMVvIfMmAUO0QuxtPVqgqCLOdJQkbz7ZHVk8vQIWX/d+M=
X-Gm-Gg: ASbGncsbYMAjkLSNA8P2EFkM9LDl/xnc5jzfrXFrH17McQ8AE97UENnfY8Ip5aGZ30i
	RHLqvhWBcgHkShymT/ky9TTe36OvNtLIqupbetIgtj7ywKH2H1bDvVbvRttymnHDIvZsYWrRHEq
	S6cmi19cG1XIznyFEtt1wjZNuVz2uLwMWkSDT9ZlhyO+Ygs6gSpPR4fDGYZPQAfwxoteAeoV5hz
	rQAyA2u8jCgXHi+IIu70ac8pOY4eLwTZ4UsSGorjwBiRSb/WDJBURddMSwdGBDNfnzbigHM5XFP
	Iwk8Tj93x1mypxLhrL6TRnEl2kJoFocGNr4QxOKJg/DkYiszevgigVnGGDO4pNvqQFP4UhW4Lik
	=
X-Google-Smtp-Source: AGHT+IGUGEs167MMU50Z/gsJMetu4k7d/Wn5NbBN1LtAChUhdquWuXdeMtmsG/KUgqB4AhKanou3/g==
X-Received: by 2002:a05:6402:430c:b0:5dc:7ee8:866e with SMTP id 4fb4d7f45d1cf-5e0b70dadffmr7109591a12.3.1740569359899;
        Wed, 26 Feb 2025 03:29:19 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45b7174cesm2610049a12.34.2025.02.26.03.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:29:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mao Jinlong <quic_jinlmao@quicinc.com>,
	Tao Zhang <quic_taozha@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: coresight: qcom,coresight-tpdm: Fix too many 'reg'
Date: Wed, 26 Feb 2025 12:29:14 +0100
Message-ID: <20250226112914.94361-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226112914.94361-1-krzysztof.kozlowski@linaro.org>
References: <20250226112914.94361-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding listed variable number of IO addresses without defining them,
however example DTS code, all in-tree DTS and Linux kernel driver
mention only one address space, so drop the second to make binding
precise and correctly describe the hardware.

Fixes: 6c781a35133d ("dt-bindings: arm: Add CoreSight TPDM hardware")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 52ba5420c497..74eeb2b63ea3 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -41,8 +41,7 @@ properties:
       - const: arm,primecell
 
   reg:
-    minItems: 1
-    maxItems: 2
+    maxItems: 1
 
   qcom,dsb-element-bits:
     description:
-- 
2.43.0


