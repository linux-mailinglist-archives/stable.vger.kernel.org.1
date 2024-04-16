Return-Path: <stable+bounces-40006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02598A68DE
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 12:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C12828B03E
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4ED12837A;
	Tue, 16 Apr 2024 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuhSy5WI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A482127E36
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264325; cv=none; b=pILtD1SDg6sAMjW60oCRLOXAiE9abTBBu7LZWE1I1mLWPeJiSzBDiEVLvIO/CCrIkxJxXSaYFLSnx4qYiU+cAgTStDBNKre1jbVtm8hpDxrBbtNH846MQ//OQL0DMfvMiVh0Vynyy7b4qnEKTCYVd9f57giwmEAbBC5b0Vltxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264325; c=relaxed/simple;
	bh=7fVDMBM5xVV869P8MZlUPmDuxIwrqax34KtYB5UCsHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DaeWUj7NirVZ1piFRDvhpLAiRtIPrm5AEds6hb7TiyLlBjr89Djk0MAW64KTmajGJNvjeskkmmNAZEbblUy/dgGyesMSDlpFYoDttYhctyppeBzqz2n5uC/LK2hVLjwt+BLiDkz5diwzguwKuAPUwPytXWK57+ZVE9gLnhMss90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CuhSy5WI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343c891bca5so2761954f8f.2
        for <stable@vger.kernel.org>; Tue, 16 Apr 2024 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713264322; x=1713869122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kQx7z6+Ldz5XYyh8xXwCAcDyA8gIafLtX7+rdECU0g=;
        b=CuhSy5WI7u7OfgGCzX+mrnGlxQjYsZ5MvOGSAcmHux8uqlPNuwprjkUfUrVRwdKs1S
         JsuTr639YdEQaW8SJTEhSkYIewU1hVbgEAoUcejU2qjTM38bMLd9+UHlICxegqOs+1jv
         Qy0npnuonsvF6DL/kQKnUcC0vKezjAWXN/fo3afBVVcT+XMhNIRiSij3EgfegiuOKhTc
         glVcXphYU/3pLVRQzWqyGxdeygbxbK6etmTbNmJT18y/HH0kEUUzK6YD+rcxrLQeXARn
         WeNPpIO7iZO0EOwJpXLDALf/jQDWkIN45P8g+1UsEYj//ETvaPFiBX/A9smH2OPqe+PV
         rIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264322; x=1713869122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kQx7z6+Ldz5XYyh8xXwCAcDyA8gIafLtX7+rdECU0g=;
        b=nZfKFgTPmYaADZkLhTOzMQ+9I9xJSanvxpbODeHmtGW1LMlP5ENkw3b/KlU4nLXWRb
         W9mKRVsx0s5o81pcGjiUG/8CEw/7Ui3kVFT9Zl1nwi3BFYaUZyDSqRcgbjraCFMjEzgK
         WHif8ttvbyImNjp+fohXMbOWjvH2zIEtZJNKRIkG25C5NlHGEYBF/xVLrb4pyn8Kaper
         f7UCwI8pQCGJCR3VklVFcQkxpXzj+pYq9EHsSBvgIr47HCyvHH0wpn2BnT95/YTCcLRV
         e4hvu2g/6x/82QP7pSoc56fL5e+JpbXiU2kDPAYjzju1dn/3EpNx+pmh18cSrjBUct/c
         16Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXVqRnt3A3PyI5540SF5msJ7MFAGzahdBbaZYxsR1AefnkJp8aBCbBCagjxyVqZudhtuGu1ifVAzNVSXNb1wnkNK+6UfdKV
X-Gm-Message-State: AOJu0YzX0c3PG2tPnW5hh2vW584H6Id1Cxpj+0A/huOEbgMsEjSHeCn3
	JI4yi6B5bfL6MOqmf4DvH/uOGtCkvWu19ms9cMbL1HckfKLI3MBuy79ZlBBlVYI=
X-Google-Smtp-Source: AGHT+IHTtRNyS7RiqQutDLkv4RpX5jb9ZLT6VAbYyVqY0HwbgVW+ohpwd874WyS5frEK6yACKIVDlw==
X-Received: by 2002:a5d:4d03:0:b0:346:c6e6:b7a3 with SMTP id z3-20020a5d4d03000000b00346c6e6b7a3mr9009266wrt.27.1713264322473;
        Tue, 16 Apr 2024 03:45:22 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm14470141wru.42.2024.04.16.03.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:45:22 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 16 Apr 2024 11:43:18 +0100
Subject: [PATCH 1/7] kdb: Fix buffer overflow during tab-complete
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-kgdb_read_refactor-v1-1-b18c2d01076d@linaro.org>
References: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
In-Reply-To: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=7fVDMBM5xVV869P8MZlUPmDuxIwrqax34KtYB5UCsHY=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmHlZdkGw9HMU6ZyFyNTx1wTmdr5u+FzJGQKx1C
 oIc1CdCUlqJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZh5WXQAKCRB84yVdOfeI
 oWYFD/kBz8MRqROT8FtLzkp2dOxoxnKkbbpva59PSCF6knfFq/AA68i/AWI6/Mjb+eX8qqX6HQw
 a0KVrKuWSTVhPxOEoo06JMZfqEwzkyVjOGWI/35UGd4EvCaCuK2YG/gATjyCqtRtttGPVXcy07R
 Ay4ig0syDAd4DKcvehsyKXCxfws/iRt+rKm3bmHWQ8jKP7eqXj5i6+3fZoRXQbuWB+FfhygjMHo
 OWmwkrkDkn9QLJXugOxSPStsjjcw2MgI+WgSms2EbvOBzy8Wcub706dkOK0zci4IRYHpMqRu7Qa
 2xeDDHbv8yWc9jDoZMjfqbRgHMLGG4ASdlYReKyLmz/C6pZLrQd3ITBy4lA31anDfsqUgj3SszZ
 aL/XTepchju5K7H/0tSMkaO0zooUkWZhu1N/79JSMvjDNJYFfV/iO+MK2YZKDwO2/m7XMEHwi+S
 kfzHOF2NIC8eMctYV78EkjPHqMbkmplyD+ELvvfJBUPrIhNN8xIMlw0t/KGkpvRkYwV5TOSN4rD
 PIMfXV7x4NKLR6f145VA/pleGtVVc1H3KAOPM1lQywUDFDa7FDhHUVW3uTgvre7kOoAVNWHY8k6
 CLsvNDvUwvjb8/5IsAvpyp7Glo6mD932aohrcaNX41X6ofAC6MTnVU8ylZ5vTh0RIdI2c3CR0Vw
 BfwqwWE6PK+i1SQ==
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


