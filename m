Return-Path: <stable+bounces-106765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A496A0197C
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 13:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664893A2BB0
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598CB15380A;
	Sun,  5 Jan 2025 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlvikKcJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2601369BB;
	Sun,  5 Jan 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081597; cv=none; b=QisdaV3MfnMDpYXw/gzN1cImpjKSffcEjz4qnZ0RGV7Nh7ogiEu1GO0T3PgUGX8lhqclckX3nhca5TfhBWY3TUM4QqILOUVOLbq3q6a0JMC+hVyWJpFtyIHyo8Mhq2x+Ymm4XSDv5WLTzK2Tina0qGn4/PjimgUSiyqwzrCkPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081597; c=relaxed/simple;
	bh=+3JsqT2PT5LDLTSdsDhEQ3hAaOsBooERDeB7M6zX/ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LdQilsyOoT22Jhzmcu2pQe7yWpEcpvJh53TeHVr+JTMj+oFVC6hVIarKBh/hakkK7t8pWKynnvhE5KNK4sSUtqPrS2Ba8ZK3vFcquexRIYvDwY5QtilgN3udXFz9ECTZ07m40JyOA2xRsQQhhXT8mGdCGNj+72z5Zg7czmdHnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlvikKcJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216281bc30fso222189725ad.0;
        Sun, 05 Jan 2025 04:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736081595; x=1736686395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QRbjaJEp8cV3Ft2gL1ts0IV/EAIwviozX8YLzCpkvz0=;
        b=KlvikKcJFm7A8M1gdz5tmHFGyApBTrsYxGQ6+3GSHsDlPNBI+1ND3PmsxsDnA8+XSq
         uOZfYi+yPSSnS/x28mVngCrYVtquaaWyZYB6+NVwTpI6JpLyLZggSNvHc+WEt9gJ3IFl
         G/G/7CNxa6RIOtjL+Pr0/kyvvW+/0vL0Zq2P6DEMI2j60eAQ2vLYRxLvRiWMelfjQEAb
         x2sBthATSV9hOrBZULYWifZQXAGKpdhlyDSKxVsDZuruyUgjvaZXA9fsAmMlHz1PpDfI
         nPCSFAhjNjuuokRL5opEJxE2I0pdwBJwbSRZlJ56m7CaNvFoWECHvgKL6s2X7McOkoOU
         2T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736081595; x=1736686395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRbjaJEp8cV3Ft2gL1ts0IV/EAIwviozX8YLzCpkvz0=;
        b=TbI0WuwAIKgZdRhmEYpYntCbSgb9PH5YoU7Wa/pMcKWhtKAgeDUy2HSPranCPTBNzf
         mZvrZvYyoKLhspIGUvOs17uxKxHy2ZAuovj7Cl6Mo9OS0YYZYB8RmTLCKaSBSoYwf2jS
         in5xq4o5PJjubbBPyG5TsW4hLIvzJgDn118z6z3sJPiPCz4QiP/71YhX6lRAySX1ohKx
         OLrPKXwcP73ChzNdomDHRHlh+GKeilN8ZfNE+sXelVD65IVA0G4FE5o7oNQX1hzc7MY0
         OiXL9RumZEYNNPIhrnLrbwvKxzcPGwHRLZkpfIgS6vE0HgW57wZD9Fzd8p8lf6ntS7Hr
         NNow==
X-Forwarded-Encrypted: i=1; AJvYcCVCRiwEPcKUtuM69B6rUU9E9PO40sYeNyidGA2dsBXV/QOe/Mx75zeMZX9p67iL2tZXI6uo5Rybb2XHhI0=@vger.kernel.org, AJvYcCX8XiPz2HBaU23ebNQyPmkC5RvAaD/2ZnMle6Gn6+dj7Nfw9SEl/6HTJyULKSN0OcL7yFhJHHak@vger.kernel.org, AJvYcCXOfzHW/IUfPrmw7PCbgxBVYd7+idiku9qZQnOI0nv+8FP+VQdRvlZ7IE3CK3sZ6xDkq5tel7WYkok/@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYd9PnO7ulH+xym6u1ZvdMCpxkLj53h2JZZMvDqRfFjzdOpnh
	W314QEeeDEh2T/ZhngQfwGiPdlLIVIl/34iFqU8D97zwARhPyO78feMXUsci6Uk=
X-Gm-Gg: ASbGncsL6sc+H5zegJKCIElH5/0RcM+fgeY5gcU5mPLBI1zFjrDuDcDzb3w70cly8vn
	rLRd6DfMSKYj0+L3f5aFAZqsAk+1fOIeOGgarbi5aAAS9waErLJIWA/0EUEqkVqXcieSG98yxBW
	M1b0Rfrrqt36PwBh0JjRodRzAfJ4fKaVY95kv0zlJHF1wvwsVvhTekZ6AbDE0IwiLhfOpgoZRS2
	Uf+D88tuTdzIRLjM9JjI2ywkiy9UPBOtaRBVLkYZErkK0Ay6Zf0BdcIl/Q5Nw2rWg==
X-Google-Smtp-Source: AGHT+IFeGXTW44QkXwlyHFMl5hMhOcCiMPa75peNPRVKIOjO+aFFROoveEk0E1JTUgIaNPmOnRSV3A==
X-Received: by 2002:a05:6a20:7f8b:b0:1e0:be48:177d with SMTP id adf61e73a8af0-1e5e043f2eemr85244616637.3.1736081594703;
        Sun, 05 Jan 2025 04:53:14 -0800 (PST)
Received: from localhost ([36.40.184.212])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842ddb09b2asm26999258a12.57.2025.01.05.04.53.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Jan 2025 04:53:13 -0800 (PST)
From: joswang <joswang1221@gmail.com>
To: heikki.krogerus@linux.intel.com,
	dmitry.baryshkov@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] usb: pd: fix the SenderResponseTimer conform to specification
Date: Sun,  5 Jan 2025 20:52:51 +0800
Message-Id: <20250105125251.5190-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jos Wang <joswang@lenovo.com>

According to the USB PD3 CTS specification
(https://usb.org/document-library/
usb-power-delivery-compliance-test-specification-0/
USB_PD3_CTS_Q4_2024_OR.zip), the requirements for
tSenderResponse are different in PD2 and PD3 modes, see
Table 19 Timing Table & Calculations. For PD2 mode, the
tSenderResponse min 24ms and max 30ms; for PD3 mode, the
tSenderResponse min 27ms and max 33ms.

For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
item, after receiving the Source_Capabilities Message sent by
the UUT, the tester deliberately does not send a Request Message
in order to force the SenderResponse timer on the Source UUT to
timeout. The Tester checks that a Hard Reset is detected between
tSenderResponse min and max，the delay is between the last bit of
the GoodCRC Message EOP has been sent and the first bit of Hard
Reset SOP has been received. The current code does not distinguish
between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
This will cause this test item and the following tests to fail:
TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout

Set the SenderResponseTimer timeout to 27ms to meet the PD2
and PD3 mode requirements.

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable@vger.kernel.org
Signed-off-by: Jos Wang <joswang@lenovo.com>
---
 include/linux/usb/pd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 3068c3084eb6..99ca49bbf376 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -475,7 +475,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_NO_RESPONSE	5000	/* 4.5 - 5.5 seconds */
 #define PD_T_DB_DETECT		10000	/* 10 - 15 seconds */
 #define PD_T_SEND_SOURCE_CAP	150	/* 100 - 200 ms */
-#define PD_T_SENDER_RESPONSE	60	/* 24 - 30 ms, relaxed */
+#define PD_T_SENDER_RESPONSE	27	/* 24 - 30 ms */
 #define PD_T_RECEIVER_RESPONSE	15	/* 15ms max */
 #define PD_T_SOURCE_ACTIVITY	45
 #define PD_T_SINK_ACTIVITY	135
-- 
2.17.1


