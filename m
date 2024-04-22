Return-Path: <stable+bounces-40392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF488AD209
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 18:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652E7287271
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 16:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAD7153824;
	Mon, 22 Apr 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5St/K84"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52695154440
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803882; cv=none; b=gsdPFTYD81wDDDSCHSU72ayoJG/4QIzLnOu8ADktrrEiamcnNN6n9HzpoiqohhuxGq24OFqUL+brJX0duvCnWH6XOIyEDD0k3E9IIrSzvqAI5it0kL5C/5IQYM6aEfWH6nzJH803PaHTUN+GtAcSKTKVEfFXnWf34FqZdV6pSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803882; c=relaxed/simple;
	bh=EKbL46mJOaKEQMG7PnN0H6MYhOBkih3jmYcm08ayvmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHC3YMtKs0mRMU5xX2Dni7Nbpo9GEFsTIuR9+C6FpxI+MCy2YW1TvQ0uLXDIJROHkHM5rXAV+YUD0p3my+NhNd4BGNVGYNXlM9HA/pLFCbw3QMExbw0qiNdRvbrkGtj3tLS/PFwZLmo7K0bOxpaaaeB5X9+avRPf7lGX90sooZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b5St/K84; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41a7820620dso6451895e9.0
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713803879; x=1714408679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IaPzC1YdTbbmXVhdYLzIcA/Ug78Q+VkMF3OmhCOncvQ=;
        b=b5St/K847dFrkjjE7Q98iTlOeWDun6tiMDDvmC8kvGFHZaZV/HwYxCkaS/oUvB/dzc
         X42mnyFdTcrlW0U/84oJLz/OkLTODRwtHfIS4BoZtVZiLD3CS1dVUutcXM1ThyYFuy+F
         51YGZ43MBHMJrj/QEB861FcypHMhp+9/PC1e7a4uM297t7jmcjknlTGWMGZP5MyN7u1i
         nxPPpp0ciFxkRE8sstpmHm5Ef+gwr8JXlcY6jMYZBi6r9LiYe4zzcvXF3zKL+qFkIuT2
         Ggnrlc5nSHoCUFKmz3YmxsMlEIglcSQxJ3P1BQ5XJJ4w18CRLhZfTWYgJZyA1Vm58/fH
         bZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803879; x=1714408679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaPzC1YdTbbmXVhdYLzIcA/Ug78Q+VkMF3OmhCOncvQ=;
        b=XRwjn8vzJX40S0s+x6sbeEfPflarVDRPURPvKUuOYjyz5+5Jc/ARgudDyJILPeJwW3
         mX1jEfCbmF7IREyBzCJ2dm0cOGddCZ8ixsqHc6AzPBsKFTLvRsDHRRBhBFi6ifk+K8g8
         6IUiQtg8yhs0oi9CUDUzz6VrfYQZaAYWCOyKF3PdaB9tHD4ZaMEQMS/LSIvs0dtre1Pw
         hpgScfNWPcwiuNZzYpNztlVRUileVnJWSKjYCScTFvDsrwciWoTiwO42TVYy6Bm7IXlz
         Ke7ibRip+M0z9Pjezw8NoybKwQxxbW36Efu0JD0muuCQk0dlRqVTNjuVjIB+PVdzhNxo
         uq0A==
X-Forwarded-Encrypted: i=1; AJvYcCU5FEVpGBM93iUQa3zkYzD4zIfvPbQjYWGtEVJTj60tv2uA3GPxUtEos5WJ5SeP1M6trQ+Lq2Ryqhl4zhR0tfEokpoHoivE
X-Gm-Message-State: AOJu0Yw77VDkY7WPIdg6SI/rI+0gFyISCNH2ji7/OvXC7EK1cZEk4bHN
	RM46WfSIsQIBmg3xjIMg8IZjZKxAyqkU6EdhVFMRJNW0bhKaa4Ma+/4tH5pDxg0=
X-Google-Smtp-Source: AGHT+IHIey51AWtx4VQyISLIZOC+vyssMRjF9SgVnb/8KezLsfOHB0E7atrtdgz2hjexSrkqhw1I3w==
X-Received: by 2002:a05:600c:524e:b0:418:fc73:c0d3 with SMTP id fc14-20020a05600c524e00b00418fc73c0d3mr7093929wmb.24.1713803878838;
        Mon, 22 Apr 2024 09:37:58 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jp13-20020a05600c558d00b0041a9a6a2bebsm433343wmb.1.2024.04.22.09.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:37:57 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 22 Apr 2024 17:35:58 +0100
Subject: [PATCH v2 5/7] kdb: Use format-specifiers rather than memset() for
 padding in kdb_read()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-kgdb_read_refactor-v2-5-ed51f7d145fe@linaro.org>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=EKbL46mJOaKEQMG7PnN0H6MYhOBkih3jmYcm08ayvmY=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmJpIzc+qxB+38dGrvf11xB/JwP24/5iyxfzXnR
 7S9uLz9qIaJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiaSMwAKCRB84yVdOfeI
 oaVID/0VfTx+yaeruOa+2ykO35gx+u7NUo2WoPk0OF4mLglbzFwFCAFYEixVj0oZa2Qrvxi/7Zl
 Vg/X68oSztt6j/GiPZ28PTMgUH2F8CBg76ByY3EkKJRk+II13lqZXKldZV9vujuFr77rGBrnFfQ
 BwS3BEv4ne5B1QSbb572bByM6z8ir/cT0bC6b5231gZkxnh51sIEQxt+7ZvbOq33xsAaU4Z6xkK
 83Nrt5ayJuolqgwtyuoFdPJB6u+ybUojj7MNE5Cd+x0zqRDtq4WYDPsbJzIG1ZVAjYDDULJnEom
 lCuxbBcTfbJtqtacC35zqD7XqcqLjtJBpvN/3Zj+I3ZbzsX6X3oSe6EdLm4uusxjKM0HXu+09Yz
 1Gh0TwxPbaMvOrD3cijWo6CtGNXe5xLCnIgn3CvMHq6OpbcoZtQeM/L1Bd3UQnHh7O7mULCai+N
 fO7rrFexjVMwXnPAkeBA9+3pDbe5dITuKEwNSVBCqHhsfm47I0Q+w/5MzmUntEh+mbmFksyNxCy
 34Aouq8LuayIGXynacVyDo1ORQ+YtyNyvwczP3zoTyFZo0pA7SszISNFTbPlzjU8k411CDYrTSW
 abYYUkMtPLM+TpNDxSrc8cb0U1bMVoGbo0PmPdOe8BPY1z6qasGJ6OSesjBergm3AiLEOV1FL+s
 BnSw0TsuHftAgzA==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently when the current line should be removed from the display
kdb_read() uses memset() to fill a temporary buffer with spaces.
The problem is not that this could be trivially implemented using a
format string rather than open coding it. The real problem is that
it is possible, on systems with a long kdb_prompt_str, to write pas
the end of the tmpbuffer.

Happily, as mentioned above, this can be trivially implemented using a
format string. Make it so!

Cc: stable@vger.kernel.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index f167894b11b8e..2cd17313fe652 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -299,11 +299,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		break;
 	case 14: /* Down */
 	case 16: /* Up */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
+		kdb_printf("\r%*c\r",
+			   (int)(strlen(kdb_prompt_str) + (lastchar - buffer)),
+			   ' ');
 		*lastchar = (char)key;
 		*(lastchar+1) = '\0';
 		return lastchar;

-- 
2.43.0


