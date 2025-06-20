Return-Path: <stable+bounces-155073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A473AE1833
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8E716E7BF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC227CCF0;
	Fri, 20 Jun 2025 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy5eFkUC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68187238C08;
	Fri, 20 Jun 2025 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412984; cv=none; b=NaziDEHL3fJa9oYc1Yann4kTrwSZHWtg9g/hRuVBKrKSlnj6qeXzeUvzVSmJ6qdLmFGQtfBp2fVa6Iih4i7B5qvnlw01JoZ6LxahFnWbXZiKRhumUgDvTdQ0zCTUWW8QrGhUXfAxf+Ai2yVLmOl1CgEetCg50gkGyB1gXYIZ5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412984; c=relaxed/simple;
	bh=qTnLGaYE4mSJe4XGJd9c1paMNelCcWBLch1kHcCtYSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U6Vtp29dtAwFGb3ctVR3JQYYelz7LIBpcTe/vyXA+aaN1jA453o9Pls4hF6BubUGYVULC4Fq+bWGDVQfxd34BA16T5wq93oh5GbQMSUN5uKHLTphq3Ds5qj4KYgt0x/7cGTlwzk/HOw/3u8BODFzfWz+veN8vRyiSUKTOHErzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qy5eFkUC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2350fc2591dso13450855ad.1;
        Fri, 20 Jun 2025 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750412982; x=1751017782; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wm9uNcsgLmLy2CTce8UTPVgm6JKmZNFE7FHPVZSoHGI=;
        b=Qy5eFkUCQbtRZPWkAJkbqb5xcXmIegciFmjgd7AhW/5Zt9UfEfQzFXG5V05T4Makpi
         32kC23OsZ/w7IbnaZF0kMbEeeDelPjc1HzI7Hmcwlbf5IfBIvkv9SZ+WtUUuGiad41gp
         MSoQ8l8MDkVX9UDwl/eK/xO4o+uM5jduWtQhocbJ/jbqeaDL8Nwy9sWgGJsqFqsLnuXD
         1FpkzaPOZYQb7HNvU7qipY2szK0lUq5gfrKixUuZrdMl2eg4qn2TfrLpEBJY3r7MqwSR
         eLMj0ktw2xHoCs2CCXmcyt4tYpWvSFGAoPbi7zBjbzmeUEtVfsq8Jqd8VegjHeIYVyUB
         NBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412982; x=1751017782;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wm9uNcsgLmLy2CTce8UTPVgm6JKmZNFE7FHPVZSoHGI=;
        b=ZBqF5vYtrFILMNbBqtLMsnz9uNvlg8Dj5P+q8BNmWkt9fj5CwnYuZp+W8RIYWFDeca
         m3Fx4CFL3rPgSVPe06pa59ujarhGhCPwcDcdp9Le2t/ja2QQwe1TCT1ET6Zg3jOCaOv6
         GXgpIwChzrFY6hy4axR37WJmQwD0PIbbV/yBcZWeE/PwfZud30OXqKLfYMSBxJpvvffL
         +Ky215KEughQK0pCvokI8vuzSPfoFCEojNXTzXzv/BGnSLbeh5heb3zGxXYbyyGxbxmF
         OIEdNnDs0f32McJwIvtJkjxYpX31Ral4WsQgvgyjzHWNlPZOu9zh0/v+pWtCbwWsVBSO
         ijkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPSrTo+ZCf+RXa9aOng6jTmWpuqvUM9u6r3HtAz60hfGq/kmDpTfkeeNoH4J2vNzRhPHME4l99@vger.kernel.org, AJvYcCUVcnKsujr30g0fwJIGqGgW3YiSPMqNa/vJ9A2tIGreFAvIWz0GqKmxkWAG6AI42zOyJIHr+G3B9W37ZZgM@vger.kernel.org, AJvYcCX5c6F16Y3uw5TTZzoXkeCZ9pwBxebdSlbxa/Z+i/z4UlqXfPwkzcVqwyrrdcAOIr+zB876Ni3EjtKL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzch1SEgJqTvMq9B3Fq5pHeddTp/LeqyIJPkbEXyo4dBx8nYbUG
	yPabS9fE3aZiA2r4HqvYElr2LY84txw4+P4h79QgFzgStr/PpWM+gytRG9lA6CKe
X-Gm-Gg: ASbGncsE3gjdstqNK8KU4aQOlvsDh7ahKwxXSOF9Vol4TPBfOluC8//5O6g0N4h1Qei
	SAK6YTiwW4CAZ4Fso5tSbvbAkWB64+iXMoUtaMvc3AAbSBAp7n85ZFxVGAgEHbcmg1ja4A25FP5
	tGgjVRP7G7qlDNJfE4jQEVhhl6yxwXhbowUvEm/CE1HTWiwHiefhqcicWAvh93sLPqfUTqZaBpG
	G9/mjmF6NjmRiDFoGkEKlGtiVdr8Mt5e6iCxucLNnnAS5rFop1P/ipEIOT93Oad51TCPSJQPKen
	F6uXKp+uscQXuVUtljXCXGDZ2zKvFCJXO7dWQ4tk6evpzlb0BEGoMoTVCvymjikLlsyJMUBjNRI
	nXjbdXUl1lOs=
X-Google-Smtp-Source: AGHT+IH6Be5gP3+3exFSkxm22vF5iZh7JCUxNtdjaBLajdekU8Xmj0n59/agYpsJTUMoVM2m4rUZ0Q==
X-Received: by 2002:a17:903:32ca:b0:215:a303:24e9 with SMTP id d9443c01a7336-237daf6593emr27765085ad.3.1750412982159;
        Fri, 20 Jun 2025 02:49:42 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d86ef88bsm14167885ad.219.2025.06.20.02.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 02:49:41 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 20 Jun 2025 17:49:11 +0800
Subject: [PATCH] arm64: dts: apple: t8012-j132: Include touchbar
 framebuffer node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-j132-fb-v1-1-bc6937baf0b9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJYuVWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyMD3SxDYyPdtCTdFPMUUzML8xRjc4MUJaDqgqLUtMwKsEnRsbW1ADN
 YMSFZAAAA
X-Change-ID: 20250620-j132-fb-d7d5687d370d
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=qTnLGaYE4mSJe4XGJd9c1paMNelCcWBLch1kHcCtYSY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoVS6zKNgfrxDu4IxQuG+XErH6r6Vm9rzm0pebd
 Z3LpvEPtguJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaFUuswAKCRABygi3psUI
 JHJoD/0c+i2KQVhxj9K7upj3umunHHR5iGCOEG7jxFTtrsE+9UuVngAG8qtLOrYp/X9GUmrrZ2t
 YjB8zqTSrGCkMZgDCQSvVnYq7RApDSyigQQ36SWV5Lh0zMI7tuF4rx1m8MgENCWOqRwZKEK64UX
 MBz8IOTYYDcFK+G5Dj9SL2QLI9HQWxAjpS13aSuYZ6+jT0s4U06FeLHcrPlOg8V+5os/NVVo+/q
 Zx4GZs+Gtry/8S1DKD3+TARaqvlCXS5qZiEvnGwCEOochN2Xh/DHTQqUlrjhAVL3XQn1DiN1hMQ
 EBd2Feg6UYw+iXnzywYNLUJZYcYGpD6SGYjwnxXBpJ1iN4izrVDbcXaSYfcrzlLhLBPyFDU1MQE
 oKCoPZco6WkgKXu6Ocnj1rMY7OqrrvGYT4ii2JrimT3DE1hf2BkIwfb1SIh5+aElTHTR056aGOW
 YIy7brULuGRblckBPK5MZZfsKFNaPgrwNN2BEj1C152m/CZgQmFouQG2X3BQZjdMLNtksmVCQ16
 SnmdffQVXD3VCC8cK6iALZdxHjRAhAFBCbTaRGg76wX/Be4wEiOniKeQAwHSAXi17FE+cjwdL3q
 luHN2WxpWowukCRgX/7ADKFDgaLOUxVo95rtVpeUopwEB4llG89OR/eUN4QiImlW+nfZ2mvXQ5a
 1taNYho8VbNMnHg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Apple T2 MacBookPro15,2 (j132) has a touchbar so include the framebuffer
node.

Fixes: 4efbcb623e9bc ("arm64: dts: apple: Add T2 devices")
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012-j132.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apple/t8012-j132.dts b/arch/arm64/boot/dts/apple/t8012-j132.dts
index 778a69be18dd81ab49076fb39ca4bc82f551e40f..7dcac51703ff60e0a6ef0929572a70adb65b580f 100644
--- a/arch/arm64/boot/dts/apple/t8012-j132.dts
+++ b/arch/arm64/boot/dts/apple/t8012-j132.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "t8012-jxxx.dtsi"
+#include "t8012-touchbar.dtsi"
 
 / {
 	model = "Apple T2 MacBookPro15,2 (j132)";

---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250620-j132-fb-d7d5687d370d

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


