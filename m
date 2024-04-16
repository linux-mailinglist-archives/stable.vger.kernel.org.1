Return-Path: <stable+bounces-40007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2008A68EA
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 12:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C3B2204F
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4661292C9;
	Tue, 16 Apr 2024 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMO1aXNq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2D128378
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264328; cv=none; b=KgpLHGy69TjS082ddJzZzy5WFc8sMzVEBzEExf6vi7Y1V0ux3riQmdZJluIT49GnHs5eAHoPnaNDSt9hWcNBR0A7LEOgt09AnhT/NT8JPZ8jGTxg9iADO4CQiooEjAHwr5hFBnLu1deH/v9IuuZfHRAX/1sBCqwaXIIgbiog5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264328; c=relaxed/simple;
	bh=/6p73t1vQBs60bTu8b+1GCgEu36ZH+1LONSsLqShnFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEPCG923OZh1MZmBV9JBoi3J0dRDrFMi8zEhZRhWgHS1hkfB2Fqy9R+I/ltdnw7cUnNO7HcN9pjQjkNkqAcoYAeN6WQ8CQbONMRXmFc2q+FFnZFGEAcPiTGgVZZVmSSX1TR/X+3XlCuvE6JhbiD/nQ4rbVbJZ6/tzqA5QuHiBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MMO1aXNq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34388753650so1905753f8f.3
        for <stable@vger.kernel.org>; Tue, 16 Apr 2024 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713264324; x=1713869124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0169n4vHsrlup9ubNFunAJmhMk888VjX3f7O4lXGgA=;
        b=MMO1aXNqlEDvIjLeGtewsFhLXn9NtgvtuLHRoVNKrIatofoTd1+cHmUXIOXq+vCpnB
         RTF74sYP/Bol0HIu6+EFR0GV0qvDMGKsu/6gZl3OuaXpEkolf5VVk5xT4yMJjPtIpFly
         Yx9M+HPA/qY3SJmqXzGKO5Uy8X0n/OM89qG55YZeY/qdohDeCK0zZVb8A4zc15JXm9lQ
         XMpfPzb0d7qeBy31ZS4jt0dlqBWFm9xUOdWM47hrGZso++rEmHg2dwEXAJnjMPL47uFC
         7Y9SJgTh0o0B+4iW2DNKMEAj7x2wqLeoMQD/qfwaN4ODWcE3TimQ3/FMppCKIAzESVhy
         ZHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264324; x=1713869124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0169n4vHsrlup9ubNFunAJmhMk888VjX3f7O4lXGgA=;
        b=rSFk9o8o6jUjdjef5u9PV+rk6Oefl07isIOMeUwwwEJ7mzBlLuLCDrUGcSR3t6ETeY
         /zlXu9Hke6Csg/u7I54Cs7CGP5nAMsGpOZrWbqbLgho0VPro4nCE5kCW816BwJRX8M8P
         hjil0h1hFU14phQI0rl7MlN+M8SHCenH+Vgb7w5PoxYlB+/pbVnMA0oSiZLnAhCNUu5E
         RXRMrFM3akmfM3beKKxANL9D4ezux147897i9QWG93bFrAHCi9Vaw5AiqN0vdqkVNGpJ
         1sbULevScLjl/JKyeUApyqFlyPGJUkBgQQi/fzCCJq5LBpAZtAC3diFkozg5PzNYqF4/
         QMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFTrSl6fdamFtPcC5sfkIwkrepmD92bS4jM99cP/hRdjpblBHfrX0IjAtUFLwTeSCEE1DadF0nOzJiXweTfTY16PySgapz
X-Gm-Message-State: AOJu0YxCjmQlYO0kUZpvkVx+JkUr+0Vk7tkRrGPySDwRf/E9sTjV0pCU
	9qvTqjRB07FQxpC8mVoP8mCX3rtLWtTd00vqKRf/TgE13iQGdtZxJPetwW4oxOo=
X-Google-Smtp-Source: AGHT+IGuOwdGbie/pxpSPz94XUUg9zfb//N0KACafx0VLdOJav+40VrZnhnexV6h1XjRB6n5HJzmOQ==
X-Received: by 2002:a5d:558a:0:b0:348:1fde:180d with SMTP id i10-20020a5d558a000000b003481fde180dmr1439589wrv.15.1713264324163;
        Tue, 16 Apr 2024 03:45:24 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm14470141wru.42.2024.04.16.03.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:45:22 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 16 Apr 2024 11:43:19 +0100
Subject: [PATCH 2/7] kdb: Use format-strings rather than '\0' injection in
 kdb_read()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-kgdb_read_refactor-v1-2-b18c2d01076d@linaro.org>
References: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
In-Reply-To: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=/6p73t1vQBs60bTu8b+1GCgEu36ZH+1LONSsLqShnFQ=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmHlZrYDalepy0FpLWeF0EGeYOYWieNEdAFaX2U
 vqR3b0WOtOJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZh5WawAKCRB84yVdOfeI
 oUdND/0XUCjVwdM1VAk8s8wd/ywUnsHM53bbyB1U303aMdO3jiiQozqSV5yJ8dYsdA1ivsDvraC
 0ZGT4+QG15h+MvIfHSrRcQRd0dqi5rFnYZd2Rs0V0gSqZznS4Geqmg290iJRqqVfN906SZvgPyB
 7fDi3kg0RSgLM4/+GL6xgWn8GWaEiInEqljjhsZYsGQ3FnaTvyusQGdZPIyh5ZlU/zJ5iJOXIZ2
 G0Ckc1zvyy/+VIjuEYRNLSEDQJwqgfR3rI+7O3Veyos/5kQmJxz8ozXtgQ8nUWN0xIjYyFKbISM
 SctlwDlp0nYyqgVQP9ZO9kC1Vg4AOmYRUdmVye4OEIrjj2gE7bB06y5tWCPe1gj/ioMlE7n6KOU
 2mtmVb4KWEjeP4bij98eIoONCzDc3VLpsBC9E29SU+r+hjRdT6A44vSyfG2o5LG5LNn/tEjw/W1
 zdjw20kp5v5bbL/HYehx5ef+GTldZlp7FcZ0ySasBrUYHDxDBCJgae3y+YD/RO67DVEMbE1s664
 7dE5ToQQOyNlitD6E4/la2UA8BNzWLu5O9v7dpFBhYTQtMbLWPgteLNORNUEyKetqSnncI8jPiB
 2cAvuOyyUMSJ7p/gBjHUivzNJPud8/IVX+Pm0eluGhHa29mNrF/ygc2bX6FlRqffn5o9TlgsiKf
 462jIxIKGp5gONQ==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently when kdb_read() needs to reposition the cursor it uses copy and
paste code that works by injecting an '\0' at the cursor position before
delivering a carriage-return and reprinting the line (which stops at the
'\0').

Tidy up the code by hoisting the copy and paste code into an appropriately
named function. Additionally let's replace the '\0' injection with a
proper field width parameter so that the string will be abridged during
formatting instead.

Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug fixes
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 06dfbccb10336..a42607e4d1aba 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -184,6 +184,13 @@ char kdb_getchar(void)
 	unreachable();
 }
 
+static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
+{
+	kdb_printf("\r%s", kdb_prompt_str);
+	if (cp > buffer)
+		kdb_printf("%.*s", (int)(cp - buffer), buffer);
+}
+
 /*
  * kdb_read
  *
@@ -249,12 +256,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			*(--lastchar) = '\0';
 			--cp;
-			kdb_printf("\b%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("\b%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 10: /* linefeed */
@@ -272,19 +275,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			memcpy(tmpbuffer, cp+1, lastchar - cp - 1);
 			memcpy(cp, tmpbuffer, lastchar - cp - 1);
 			*(--lastchar) = '\0';
-			kdb_printf("%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 1: /* Home */
 		if (cp > buffer) {
-			kdb_printf("\r");
-			kdb_printf(kdb_prompt_str);
 			cp = buffer;
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 5: /* End */
@@ -390,13 +388,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				memcpy(cp+1, tmpbuffer, lastchar - cp);
 				*++lastchar = '\0';
 				*cp = key;
-				kdb_printf("%s\r", cp);
+				kdb_printf("%s", cp);
 				++cp;
-				tmp = *cp;
-				*cp = '\0';
-				kdb_printf(kdb_prompt_str);
-				kdb_printf("%s", buffer);
-				*cp = tmp;
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 			} else {
 				*++lastchar = '\0';
 				*cp++ = key;

-- 
2.43.0


