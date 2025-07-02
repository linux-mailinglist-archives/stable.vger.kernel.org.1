Return-Path: <stable+bounces-159191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096BAF0B69
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 08:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448EC16A45F
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340F21CA1F;
	Wed,  2 Jul 2025 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJ6369++"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3861D5CDE
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436949; cv=none; b=JDFIWkmPPAOJ6D35I5Xr7jz9fj0IGq37qsZOcLD3F4mGMGBw5rGyl27+syMx5OhOY0+edrp0icW7IUT3k9/rGviZwI5oSK98QVh77kGzxJ6W9IQaQfXEc11iYsrl0FOfQNKaA0OC2Hyo2pgmL4GIyouR3wKDs9mubJJuv1LbPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436949; c=relaxed/simple;
	bh=FLaVe+H/5henra017IcfsYJhyAcqrChTySMeW9rIE0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1iD/9vQFBQqa54AnkDEgrpJJbm5DCPFNWvyyO4grjUkym1w7GC/U6qMq4axu644dmLOEchdf/6Yh9xdj9045DtDzKhUXXTyuu5K9h/ObcgknlVWQoFgLJcowE61P4yoyKJZYqCQ6z29O+upHEHYj8lkRAeJIg8iobQZmVMpc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJ6369++; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607780f0793so1351240a12.2
        for <stable@vger.kernel.org>; Tue, 01 Jul 2025 23:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751436945; x=1752041745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdbxkzgHI5luNqjYHdBnybrZHqg71IzJUJvornOEViE=;
        b=xJ6369++LBOad34RRGY0C2Nk0CXdZ7B4q+usTwNHrGPBCKT+KgKilHhkP7vIT4x4cS
         TuPWcGsJ6bRhH/M2c7Vt3xpekRRq2og2g/+srFYQLbD37As9QyH2x2KsDeIH0UdCnXVi
         lQmOdWI5hjiSvmVysEUsNhlft6QU1OLiq0by17ioqT75EQjQXLGEGXgceNHOGhfvaeqd
         FEW+QEb/p3RmBIHEgmyDOppldL8VEltnnwpRAptjwmq+Y+cA6kpY+aJOxn+w4dexjOyM
         k5qnOgs5IMdfbTn7wjL0N1Bkcp142LRh14GGSW5+kcktdHDlx4hwI27D/iNUad2d3ZU/
         M8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751436945; x=1752041745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdbxkzgHI5luNqjYHdBnybrZHqg71IzJUJvornOEViE=;
        b=HEdY/Q63fxLxlKL7RyHEXnENFY5iZGFyzcQoA2SpWC7kYzw+yHn0+B4LGwIlo27D5+
         uvR8/k6F/KTkWfHJq49fA86r+1RrVSbYOU+2Fcm9SxyEdqK3qVzvkNtMB49+O/ZRMxDn
         II57vHt1k872MR5YGu7R/rTZ0bFWe0noGFoRioVjrjClWRvTfbMb1ZatJuVKSiq93G7w
         v/+IqC8VkzMvpOMIS76ALUQbms7LtGeFGqBH4vqlgRON9IluWGPMa19pfMwgkXYzgq73
         2nipvD0Ydae3MPomUQ0qj9o907Xw8cGAoKwinKLR71fkq0+wL041EHVQheqJbry2LwAZ
         Q6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXouOk4iIycGz+79u3FUsUTPiziZs4yvUKg27I1+mRbVWTVgOuQwAeUaV3uPaH6h7JmysBlmII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9B23E8pjSqFqKC+efLCeeU/OXZVSoA330EV2ArhTGPf26Dhi
	UD9451uGdl/RPxXpPvNuBxE9IaXmARNiu5cpVeYuv0m0ydJc9TUX1DAdpzCezAz2QnQ=
X-Gm-Gg: ASbGncu2KnnyNZd3DRlCKO0i8FZkI3meXf0Zrv7ANaTnFDCBaMlEbazDGU5G3KXq23+
	9G2EUxZN+cYhO4sja/v/0aLFVzApEpKRDYY3W/9kbBRZUw8eCi/jszI/0qiBxpxktHmPLlHqXeF
	RkxepVxZGFyx781sbUFsn8y9rR8UdDEi7lj1ORx9MvuXdOO+bfNBnE4WwGCudAUcOjp8PCbXuc+
	EVvccrUC2Ku7D7OcBXzaoS/m42u3h3+xZ/NJq7KX4yHy8JRc4H7JdiizUBEG3cbZjWUtxeE+9vR
	ictGysqyjm+WQmng7vTiUd70+pxNhMYY/5UTfcpjAQeN68hmQHlBuvhHRnKbN0oWIOc00AjX/lo
	=
X-Google-Smtp-Source: AGHT+IErFVGqx+MRKEZaebOZjF4D23rbEptzUG6EzmIWEtxVkYTOzvHdOzM7YlWZTcHShTlbIrQ4og==
X-Received: by 2002:a17:907:608b:b0:ae3:5d47:634 with SMTP id a640c23a62f3a-ae3c2bbf645mr51321066b.9.1751436944411;
        Tue, 01 Jul 2025 23:15:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca1cc9sm999481666b.168.2025.07.01.23.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 23:15:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] dt-bindings: i2c: realtek,rtl9301: Fix missing 'reg' constraint
Date: Wed,  2 Jul 2025 08:15:31 +0200
Message-ID: <20250702061530.6940-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=krzysztof.kozlowski@linaro.org; h=from:subject; bh=FLaVe+H/5henra017IcfsYJhyAcqrChTySMeW9rIE0g=; b=kA0DAAoBwTdm5oaLg9cByyZiAGhkzoKiUOc0gOXXpRG0YAdx86FUIPvNYKTA6UqMG80O9BNt4 YkCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJoZM6CAAoJEME3ZuaGi4PXXQoP/11I xG+8AWFlDNGwVQygvf9SDD4ogj0uCRqQ6USLs68GBVCj7TYzTWe+1aQJZorH0GU9rSjDu5yTyNt BeN41WWgx3kvVeYJ+jtgAwbuZaeDyhwQCMyKiN98vDa+5iFROeEcw/thYyH3HDosFPZrnToKcHX 88ZA2/eo8ZDBZhneiz1x9DjWQi5cNTqNdOdEPgv1QyEGpCEuzCQQVPfubFHLzTFVLft26PJwOA2 PUUk8NEXnMSEN1AR2MRdSBFONJ6ndEd+XRWtpwjLnLJPHp2cXuO3VF8tgeGCrEWdLz0N4l5Eo0U GNDscua89/DMnuRYWtnF9hHCynS3PKIuoew8RXSnorsYmsFoDFk1ihSQUxqoJ0Y6zUyfQ3e3hi4 5OeVIefWWTGw7jzSVXhEXtMDND3BZ2j3A8CnD6jNfEL4OqtG6IN3ut7Cj+8XQZ14Wdg4g7vQmmS +hFcVBND6LZ4bPpM68TNd1cpVX/s+k5ngdqtblBa5izzC3fxF5DONI981ahjKyfv8x3vH05PElU tfwyVd13DUWQtxrwG5hP6r5GAunb1d2PAF5SSJt/Vv9hSW6da/UqXtjZAxcUZSUWPVjBAx4s54n /MaToZmtpdxN8E5cE2Y4/H8jgCJ0bAcsW8u77w6zs+uWGBGKzu+Lmy9S/yZV988+7TPxmunyHgn ub9yQ
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Lists should have fixed amount if items, so add missing constraint to
the 'reg' property (only one address space entry).

Fixes: c5eda0333076 ("dt-bindings: i2c: Add Realtek RTL I2C Controller")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
index eddfd329c67b..69ac5db8b914 100644
--- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
@@ -26,7 +26,8 @@ properties:
       - const: realtek,rtl9301-i2c
 
   reg:
-    description: Register offset and size this I2C controller.
+    items:
+      - description: Register offset and size this I2C controller.
 
   "#address-cells":
     const: 1
-- 
2.43.0


