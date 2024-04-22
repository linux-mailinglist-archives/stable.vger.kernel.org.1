Return-Path: <stable+bounces-40391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652598AD207
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 18:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965601C20BA3
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E938B15443B;
	Mon, 22 Apr 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHfxEBFA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E57152E05
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803879; cv=none; b=BM/f343mrzC+j5rF3WEfn8YK7sOnepeH8hQJ6vP9Za5BiI2BvSP6pKZP6lGd+qoTCjmi243r9Tqxg8pOMhwdmVrX3+EsPtn40n8xU/owJVfpHbx48cS59+QIC3OU/c2lR+y8yAX1bOUxdaElr2X9OH5sh5rOcPIB47QZ0j02cfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803879; c=relaxed/simple;
	bh=6LfmSdx/1tWhrPN9tMn/IBWgdpfapqTqrf1F8jgiXeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdsmFC/jGIPJ39+Fbj7eTyrSy4QS1V9J4+CkY4HgWhePmXJd6BKqwYF4SRPiGLuyT34/WQIdpjNrlzraGZWIyDdkcBuMkyF/9nn+C23fN0LHoKfK0WE62WymBFLlU+vP+zUMESYc793bhsm+lIkrC4pMYm2cSUlAmDJOLbghc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AHfxEBFA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a4f291f60so9233345e9.3
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713803876; x=1714408676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nk5QmCkWRIrgsvRQxugPUqs3aSht8TynNH4Q3EEiYLA=;
        b=AHfxEBFAq4hzwPz1UNg949kQyrF0CuN6WlCaK+VlP1J8ES1RYf3vaEunvdTxjX/MX0
         MhASTXwYTh68UbissuX3I9CeE1ZHKB2J/k9/MKtljPr7HoxBWL7QRkjfdZjDkEH+z4w7
         kEvH35C7kZEyEWvI3RGw/iE4i12cSIh6/tqLg213QaYnBdiBxURqn4XiFbrZgeZPM0h8
         ec+YaFAPgv/SxVHe4Sw1ChJ32PsqrYskxVztbOSjuuDIkB4vjwYHO5sKPpjyDKA+AVr7
         PUVlMvQvod3wOi8aWQwlQPclU2/BiJsAIVmT51MR2Knng6CKmBR7ok1T20E8jOPbEXtv
         9TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803876; x=1714408676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk5QmCkWRIrgsvRQxugPUqs3aSht8TynNH4Q3EEiYLA=;
        b=cRInR5uDdYZb+MfxfnyZ3RFhCXCPWj0XeuEPjT6NmA5Fin73VzHJbwchL8EmZt8foj
         FU3Qid+89komUWCBdqBwFToq+QCwTuVha9nulGOU9CdxrcheW5H3x6lrAqCwOIraTL8N
         eJhQdM37lBUM4olAK4Vj2I6SpWMW35v99c+UvvIKIqVS6Pqh7XrSg64OfUw6DnT1FkrP
         J1+Fz7T/DV8DECRt/5FHAUys6rho/9lBnIx1JKqW5WbR/oMaXAAudvdF5cYoDInCmOuA
         u19CcDC/FKb7SoLp1VO8oTWJiCt6I7wvlPdLEs/jF+dNNhwac+Eip0+x0GF4bLc0i7tX
         28gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQQAuHGrK8DLvQpIxzRZ/ZlHB+lJJXMJ9T5Lj9RZ2QX9ojek5qjmioahKpnXUDKPGQ1cw/LQ3JfmHiX5kaC2SfjGEqEp54
X-Gm-Message-State: AOJu0YxPbIYpomOxZEInT9Blv9pdDJ20R9ZQOhWSvApeyIh4gbZISy0i
	ttrk+ozkzALb1Zpv5e+VdL7zbd021qH8hz0a3u5C3yEG2SwNwswqno/I7EAD0K8=
X-Google-Smtp-Source: AGHT+IGdbZ8ROPEXmCAeRFFCE1IlKVnfn0ElcoTrib1PzzWJrx4X84g23yKrGfh1exX8j/noBOsw+Q==
X-Received: by 2002:a05:600c:4508:b0:418:95a1:1975 with SMTP id t8-20020a05600c450800b0041895a11975mr7465378wmo.20.1713803876595;
        Mon, 22 Apr 2024 09:37:56 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jp13-20020a05600c558d00b0041a9a6a2bebsm433343wmb.1.2024.04.22.09.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:37:55 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 22 Apr 2024 17:35:57 +0100
Subject: [PATCH v2 4/7] kdb: Merge identical case statements in kdb_read()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-kgdb_read_refactor-v2-4-ed51f7d145fe@linaro.org>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=6LfmSdx/1tWhrPN9tMn/IBWgdpfapqTqrf1F8jgiXeI=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmJpIkax3nnA8BhAmdwQ+q1JJXdXciyaK0wRTdp
 ze988FFBCSJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiaSJAAKCRB84yVdOfeI
 oR5fEAClOzm3rSzOJIWjtF0ie6Zo4S6K2VgsbsQjG1WYduTN0xhNl8G86G3XNOCAmkJ7AKx2ZMW
 812W94SHSmJhU3wdvG9Ntr9TV3MBRsyLsxysGx0ybN3lzrzkL9MqdEKvg4ggwJ0Aiof+k/39wam
 xKydldkAjYsz7a+2DggOpZKP81AX+E0FERXmwOac3VKvpZfpYszCIqcOEV6U+ImwMeGgnM0Cyef
 xA4uNDcbmnqgOhbOoENorBYREX5cJf5uanSD0NSl5gCHTiAlLZf4DVC+cDFvss4XpNoKu1YmulQ
 SPFgFT6TI/ml4YX52jcsiIY//G5prGPg6TC4SIL98ivTCMHN0VaYDWfLoXCb4ScMctSjYs4SNPS
 bOZbKCJcjj4B5W4AjFaHhHWTMn/0cJlBunXUTgnON0xoA64565OeRMtX4bBrBEpTlnT+EE67f9n
 mP7xzNYfRL5I4nYyMDCTePpaXfGai+LTQCeM/fFUIuDxD8PweAvQlYJd0Glp0vygcKbTA7pqDuw
 UvS5kUcZ6p2XZ9ovgZQVApXUT0JtAmKOUBlbQdJN6Zc/GZ0fm9Q02b+2oSAMC7pWPmtnrTxbwBH
 2EMMW5g0z5lfdGROq83V6O0H75DAQi13UlIxjCWO5VoGJyr9XQCf1+oir+bpHE0VoFQ1sNNBEj2
 pI39upZA9fQFO5A==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

The code that handles case 14 (down) and case 16 (up) has been copy and
pasted despite being byte-for-byte identical. Combine them.

Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug fixes
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 69549fe42e87b..f167894b11b8e 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -298,6 +298,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		}
 		break;
 	case 14: /* Down */
+	case 16: /* Up */
 		memset(tmpbuffer, ' ',
 		       strlen(kdb_prompt_str) + (lastchar-buffer));
 		*(tmpbuffer+strlen(kdb_prompt_str) +
@@ -312,15 +313,6 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			++cp;
 		}
 		break;
-	case 16: /* Up */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
-		*lastchar = (char)key;
-		*(lastchar+1) = '\0';
-		return lastchar;
 	case 9: /* Tab */
 		if (tab < 2)
 			++tab;

-- 
2.43.0


