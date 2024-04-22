Return-Path: <stable+bounces-40388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E98AD1FB
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21431C20DA2
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39F15382B;
	Mon, 22 Apr 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYqAWoOE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08C153813
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803875; cv=none; b=aDzz319BSkcuFKujgyq9GsMQ8tT6nO5NejaJzlqdFvEMKz+7z2459J8vFOvlTTSs9EyHS+0K2N+aNmW1KhFbY/So2zzSrHMCSwum872C7LU7oYTwRnOBx+69IUdcjqPW8IOLDJGZ3/6nCO3Z2c7MzDYliBGpBVPmCiEJsfhnsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803875; c=relaxed/simple;
	bh=RD1vVQLp64mLJfhlSPCd/oxiYJDCACPe4enawcw/m+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhwLMpZy/vJ0KwWbdN2p7s9rAbUk2IfaLnz7gWnW4NciX2TFW3egSGW4pEbT3OcijT57rvzHZyWRlXbzjwhgaN5x2Ke5htOH8TE7i+1x94cAFu96EJNN8n7zWgvN0/1gRr0SRl8SPaRp0jWBQibV0LlXY0lYfSzmhvW10OqqMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eYqAWoOE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41aa2f6ff01so1111845e9.1
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713803872; x=1714408672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLlQJvdv0mXKQuHEFrLRmmeJdLfjSnZqxQsmnOGp71k=;
        b=eYqAWoOEEUe29EzqieoAMj8GOfdign1nkyU19vbXhHkdPX7XbqFf4pnvZyTpiqZuiL
         YAf0icfT74qxobJLA+sqzizR/rv5DoD7RU/v0/CCgOeFWkR2+KIOwuDhUEbs/pxlwtgv
         5pRhS4hHmcY3gV400Dj3588FnsLp5xLvjl8+p75o9GIrlzZWSP8eOvkCJZ5bmP0/5eaT
         063ErSVOj+sLjjMQLkvQavxcQ4HLQlVuA+A7Quxw+WhZ2JyUzbILwJo0ttD2Z6I8mQb7
         8x+bXMdrKTle8Ymf8JEmxvbVitmrx/HhRWAgjuqrLQRKq38tbYYYAuDFN/M9Oe6X9q5R
         6KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803872; x=1714408672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLlQJvdv0mXKQuHEFrLRmmeJdLfjSnZqxQsmnOGp71k=;
        b=iztVE0ReUswQ/OwDcjVMhHAmt0nvhdC5s+hbyGif3xVbJnqLZe+gza2iaAw8XnQM2k
         7zRfneS3DpEk8KmNxxDG51Znx9IZYHCylivPhhG5ob84PLaYcjN/Nn9UVBLmud0Ua55K
         I7cLuqPWjNrM5adYDFFPVQ0YG3fQ70L9faIbBMJFlIFvaF1ROG7jYNqBf1h8jtz2LKYA
         vTiuZSRyp1XDYv6yMJx/NyWFgdmTpINvA1BjR79+yVhJ4y//jPUBHLGaqNtKuPaRjRuO
         p6eIsNHwkdgl6HuTlT3pZAB+a/nsLe+QKpYe2EJWFKFVVvpFFMtzLBPKizCalbAhDrrW
         iWmg==
X-Forwarded-Encrypted: i=1; AJvYcCWyb0TikWkxVUTsib/a1w5dF3TeenYq+SFxxDL+kLbS3+TJXPN1yPI+PQuIL0dLPK/viqwrRprf03lJYTjlakAPuRKA8aGc
X-Gm-Message-State: AOJu0YwII8Y7auD1W98r4p37wJ0zQBoQhBrnMhHqdjtjt9nKc99s+TYr
	O4KHyXRLVk3+FEYLpz5lH/JpSXf2aXe3CGtI7EX7TS6NP1V5/WplEJzTJBK58FM=
X-Google-Smtp-Source: AGHT+IHHkVv9DQX/lIAuRVXKPDE+plq+CITnqv7QwHnCNH5XAeZdPI7izVuhMSryc6z8ud8SzuL6zw==
X-Received: by 2002:a05:600c:a01:b0:41a:2fd9:fc9f with SMTP id z1-20020a05600c0a0100b0041a2fd9fc9fmr3843899wmp.41.1713803871796;
        Mon, 22 Apr 2024 09:37:51 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jp13-20020a05600c558d00b0041a9a6a2bebsm433343wmb.1.2024.04.22.09.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:37:50 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 22 Apr 2024 17:35:54 +0100
Subject: [PATCH v2 1/7] kdb: Fix buffer overflow during tab-complete
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-kgdb_read_refactor-v2-1-ed51f7d145fe@linaro.org>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=RD1vVQLp64mLJfhlSPCd/oxiYJDCACPe4enawcw/m+0=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmJpH6kqjNS17dkmKBXEHPrV0RK4mr41OpljOyn
 f1xQLXv9tuJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiaR+gAKCRB84yVdOfeI
 oU4pD/9KY2d7fqfBxeIVIKTM7DBkMfKKzyOvuLFcAAvoyUCVc7nzcmUXMIvxo5Lhr5cWaUVIEf1
 aw65pCUM0sJzZaXSuhIU//iHoootW9Rk51sVMg2GMtcCazJ1mCl3itLI6bDT3hnhG+ifrnfxCV9
 c7LK+Fvii3VzhAJ4B+aStvFDm4PNtKOCA450awbfG95y8AuBL474ZcUbaM+XE7y/JJHFt1OzOsm
 JfNcRL3bMJ7z4/UM4h5NJRcwGfEHucDLHB+zfJdRG27gxNQCZfcsH8jWdmDvAWfeLPGdGS0hBRJ
 lyqYqLi1C/jUVzV83DVD8LmPH+YZgdcZFXiSrzi6v5ur2Lxe8OOgq5Xl8hHiY8oXsKwbXuXigsh
 Zx3KNGS0uxGj65O4Q929ffAVoi4caDLBntCdah0q+rarBuonRLt+NjRZFYmGpf0NO5ely06Hn2t
 P1BiA6ffo9tfrRO8c5iDs/dcmoeWpEDIZ/Sr0q42Lcs6F0vbOSy8+/4Jhx7vrpbv7DPaPZ6wTZ9
 qE3lUqD2tRgS3Y8fjH9bWHvl849maqDqPSbkQHPRQ4eYtoBWGFuNzU0FFN2i/24c25BAmlbnaqZ
 T+r2VWFvbLClrFTHtYVqFeGMl2NvE3y7Apg/BvBVsGcjUr5FXaHRbmIXOTck7X6FJ+APD6hO8G+
 YDpTFf1NnTNpucQ==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently, when the user attempts symbol completion with the Tab key, kdb
will use strncpy() to insert the completed symbol into the command buffer.
Unfortunately it passes the size of the source buffer rather than the
destination to strncpy() with predictably horrible results. Most obviously
if the command buffer is already full but cp, the cursor position, is in
the middle of the buffer, then we will write past the end of the supplied
buffer.

Fix this by replacing the dubious strncpy() calls with memmove()/memcpy()
calls plus explicit boundary checks to make sure we have enough space
before we start moving characters around.

Reported-by: Justin Stitt <justinstitt@google.com>
Closes: https://lore.kernel.org/all/CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+LqvC8deA8GziUJLpw@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9443bc63c5a24..06dfbccb10336 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -367,14 +367,19 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
 		} else if (tab != 2 && count > 0) {
-			len_tmp = strlen(p_tmp);
-			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
-			len_tmp = strlen(p_tmp);
-			strncpy(cp, p_tmp+len, len_tmp-len + 1);
-			len = len_tmp - len;
-			kdb_printf("%s", cp);
-			cp += len;
-			lastchar += len;
+			/* How many new characters do we want from tmpbuffer? */
+			len_tmp = strlen(p_tmp) - len;
+			if (lastchar + len_tmp >= bufend)
+				len_tmp = bufend - lastchar;
+
+			if (len_tmp) {
+				/* + 1 ensures the '\0' is memmove'd */
+				memmove(cp+len_tmp, cp, (lastchar-cp) + 1);
+				memcpy(cp, p_tmp+len, len_tmp);
+				kdb_printf("%s", cp);
+				cp += len_tmp;
+				lastchar += len_tmp;
+			}
 		}
 		kdb_nextline = 1; /* reset output line number */
 		break;

-- 
2.43.0


