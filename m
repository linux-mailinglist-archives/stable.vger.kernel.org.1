Return-Path: <stable+bounces-45486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD528CA9F0
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 10:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34F71F216C2
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC5B54F8D;
	Tue, 21 May 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMzcLzl5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F04643A
	for <stable@vger.kernel.org>; Tue, 21 May 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280231; cv=none; b=Om7Sgx5gc9P+ktox8uVrEr0sp/Ov9z2GDBMuBYca5jAVTWzv1ouX9JSgnfJsJxtniHkxwmKQyW2/ATcoktUBFO4t7hDIZ/xEK08WrdU/Dn5Dx6tYO9n8nAyGdLDN4ySiH8eyk6uII+vQl92M3LBcJzkFMBX1Nw5qMJp2kqec60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280231; c=relaxed/simple;
	bh=13gYofko46IZMmpvH5qkx1agAyFYwqb1N2f3GxAXerM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8RRjI+WjdEziPV+Ql2USQGdw4NCTzKyF+IauChlWwsduwXqfYMpiooaDelbVXhTIQ6j78O3BbNRDfrlcEbgWhLIl2CiU/fCHv0k1wlx0hyTms7nd7HHNGRMXaGxCLh1MM1+om2QPpfii1OVWvwU7HoaC1QBHOpxRKLeXbK1hsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMzcLzl5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34f0e55787aso2728254f8f.2
        for <stable@vger.kernel.org>; Tue, 21 May 2024 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716280228; x=1716885028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrA786U4KPavR4LnBySZw2GdS7HLYmlFSbgJ1uOdz/o=;
        b=tMzcLzl5cu7NYEQg5pJPzYCI4K5OZDVcL16E/F3vL88fwZywPZt/ZrzrhI1r95+IgL
         K4tFmaWw4OPhB8swgw/5moMKLe5ydhPfsrbkJccq+PS2CmwKULnRKY2Z7mouvqlPMZaP
         DrO1EfGJ8KTsNChnrK83j7uIAYnyFZ64eZyK2SsqnFFgss9MberQ+Rp3MeR1hQMsRMez
         5aEAYtQa6YEuIHpAZ3VCyHpTeWvp1L+OoqiRQ2itbOzQ1Bsgs03mMODbjgPfNvFcbP5N
         e51HaHEbL4TOa3iYQlXVoGyGqxidSB+mAykYGhOp3QthJ+3C8nIsnodItIAQPTI4cZDL
         nQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280228; x=1716885028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrA786U4KPavR4LnBySZw2GdS7HLYmlFSbgJ1uOdz/o=;
        b=jEmtFzMX4clHHimRRPwMMHmguQLDKqhNqY/2az0iGIZC6e3bTmMqSUZt/sziPf0dIE
         dgQxufhuzD6bT/neG+otrdSH0mZ0uq6pw67ESn8ikqN6h9e32OfdU0vEABxn8+Ahc4KJ
         N6iQbYKzqKgAWENjx/QuvKT4c6p6WeSWn4jft3iQ3xPC6TE7Fl77aeBZfhp+PzyyZ7Lu
         TMqOq5hNpHfWnvqXt0ZfyBPHjRGgSbm8JzetvnlsknPAJONJEmHGGlnguHSHdCZq0Ej/
         TDz5EI/mmicZKgm9Z9uqfio1JY01At7QEX688ibed2gSnd1en8o3WSZuSKImWWmhjXwA
         iAtA==
X-Forwarded-Encrypted: i=1; AJvYcCWwsNhEDgRWtt9YsE5GS67N9UefW3D8deduA+EeByVqj6YzMVvAfioi3b6iyyT0Pff52Vh6UPpZSlvhfVRqRpSqV+GSbFK/
X-Gm-Message-State: AOJu0YzcBNz0UtICL3pZQUIeydO4VFyBf2pCjJWL5Cl0incUhHk+JSgK
	5rp3LLVv50PEBXU4E/9FCCN5lRG/JvOCSEXj6p8mGIysSMtH2minBziqT4irP30=
X-Google-Smtp-Source: AGHT+IHVWqYYv8hCOa92k+zWOJjeMXITMTd7bwD6mQcIHDreBv9G4RztpYp+KuIYeogkzXFxDXyW4Q==
X-Received: by 2002:a05:6000:12d0:b0:34d:a719:4e09 with SMTP id ffacd0b85a97d-3504a96866cmr21533641f8f.45.1716280227892;
        Tue, 21 May 2024 01:30:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b897e39sm31282433f8f.48.2024.05.21.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:30:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: fsl-edma: fix dma-channels constraints
Date: Tue, 21 May 2024 10:30:02 +0200
Message-ID: <20240521083002.23262-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma-channels is a number, not a list.  Apply proper constraints on the
actual number.

Fixes: 6eb439dff645 ("dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 825f4715499e..9ef99eb54104 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -60,8 +60,8 @@ properties:
       - 3
 
   dma-channels:
-    minItems: 1
-    maxItems: 64
+    minimum: 1
+    maximum: 64
 
   clocks:
     minItems: 1
-- 
2.43.0


