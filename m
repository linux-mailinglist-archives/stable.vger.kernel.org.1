Return-Path: <stable+bounces-41364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E18B0BF3
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 16:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB3F1C22864
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB015ECEE;
	Wed, 24 Apr 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzED4HNd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F415ECC6
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967560; cv=none; b=eAxSp65aalC9baPnzywLtGgfOkVju8aHqY7KvjtBJvbb3dyEl9mUmXG+9EzA6v+fQG5sF+1l1bDRSDeh/KYIwfPRfrpFlt0I9TSx9jqylI2diZSloTohBxeHWIQt/xSzRZt1qbcBTvmsGnrc9dkRUPLVX+pu3F0rSpJVdaAYKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967560; c=relaxed/simple;
	bh=DD7I2+/OSFAuYPjbxmMle8pdnVsY53Td8fq7KEPM4QQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5d/lzGn7lpScOH+qaKu1VPcATXQPPm1BoM3I72efIYa+iCoicTS+SvHxrgeebcRHaNxRE7SWGgZnLzL5K40yGrErTaqtXO1Ts3nhNelK3z0PH/41BXNMMQV2Mxv7v6/1h/v0L0ms0dEcONm5I9eHk9lnb0oU4d0mSTcw/snlbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hzED4HNd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343e46ec237so5890354f8f.2
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967556; x=1714572356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdQ0ElNNjcpbQIpJ1xf2rchBloiiwlw1canEoGrpfWE=;
        b=hzED4HNdRtQ43j1TOJn/SCUtGzmbQ2wcRpxFKKEZJL3fdluHrbE7s2St1n0mZYBprT
         NlBpq4Y8qreXUR9nvWqay2WXP+1h419lQG3MzyM2PWkX8tGayFD8bItl6y9zqYPaPsyq
         pb5Nmihjv7k92XZ5ClmzTbnoMfbeyryHK8MZw0c3vK0ro6IK6Mc0rZg6MZN0pS7+x/8p
         uPZpRVup4RL3S3ksYEsyGXqpNB2RRK9dfvAuFyadnKOK6L+aL2AF94PQngTISu770mHd
         gGAMiFNNOrevksHScuifuquvv2jiZnjKM6raC8axudgJFVZpXrh9yRcNo9vbidZykzSi
         r5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967556; x=1714572356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdQ0ElNNjcpbQIpJ1xf2rchBloiiwlw1canEoGrpfWE=;
        b=UwkltWxXIVfwlFDtmqf42YD8C7W5cGeyHkpNaHxv89JijNJTnaWF/61QkVDkE0so3G
         OsRtGQEOtvgMEXxrv3ovByKgrXcSbo53o52n5PDVts9h9rqpQvDZAt/KblHpT3rhtQbI
         KQquzxiGNbZluA1ctbU+/Mzz+wOEqcvZry17snIZalbncYl2XXVkoNcfFYDMhAl69TaK
         fH142rAi3dDQs/HHw68eHYsQOR4Hhu0cXZpfqak4ForUOtP/2StHo/o/G8p3FbgUFKDc
         GK24lBIJEr72qm7L8bdMzcN3TmV+bPzhXnYo78c9GKWPjByPdPY02XbTq5nM7nyZXoxx
         jfvg==
X-Forwarded-Encrypted: i=1; AJvYcCW3fUtOrCWDj+DaUtnnxhWBrxiEep4WxZyPV7burGhvipMOIqOYTOSFoqrRuy6Pm08IsQTXAIJptzwG/2T5EhmM/GyX39DC
X-Gm-Message-State: AOJu0Yy62+HJYvnx6YFKi+Exvq8rPcZml2TkPEjGJZB1ccTLs5aI4vk5
	qOQ9RrJw0v5QE4LA+wdPACgWIwVpZwzFrlHEh9E2nmTsVH9jhkvUZIJI8yW0qPo=
X-Google-Smtp-Source: AGHT+IEbhdGUtN0Z8RrMf55UUZ1158vNt0de2JPc+rWO8Iun7mc3/roCSNL98rGwj3hJonYnIMLxqA==
X-Received: by 2002:adf:a3c1:0:b0:348:c2c7:efd3 with SMTP id m1-20020adfa3c1000000b00348c2c7efd3mr1635594wrb.17.1713967556721;
        Wed, 24 Apr 2024 07:05:56 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:55 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Apr 2024 15:03:38 +0100
Subject: [PATCH v3 5/7] kdb: Use format-specifiers rather than memset() for
 padding in kdb_read()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-kgdb_read_refactor-v3-5-f236dbe9828d@linaro.org>
References: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
In-Reply-To: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org, 
 Justin Stitt <justinstitt@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=DD7I2+/OSFAuYPjbxmMle8pdnVsY53Td8fq7KEPM4QQ=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRGUcB8O+iLmigr8T2IVW4HGG/L6tk+6pvEd0
 go9Kb3yjbyJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikRlAAKCRB84yVdOfeI
 offTD/9pWj5IWkhuuYbxzyB5xUws8ru2eJBhGkCaw1r+yP62FDECOfAGQUSp7rvl7RoSS5pNTl3
 95INKRg1m8mJP0tcU8Frwd+dGeIac+MbX/u0TlAlMyJNJ5P35RXFaXu1WjKEivlHJxH2AY/aL+o
 mQRdZAq7pr+wHaV1WipO3GlwGO2dcT/iql2hn5AOK4BG521yoFvVQ/xYkAVr/7QHTGRJt1ou8Pf
 PK6TxpAyXzjf4/315QqSCbtWDxb2TGnY9EKG/CerYTij7brpikOAl6VcZZY6PeC8rRTEdb4d6Pt
 ugny7/UdY3HjKVmXiG7QmEIh5m7b/yJXiJUHClRgNkvDXn8rS9xEFqvNmpBlNsNIOllT77q8/Ss
 PIF23Q90NV5bM9dMZf9aC4oMQyQI3Euv3N0Jeic4RQgF0uZ+v6MtckOK2P/LwRMmJwndgvXGOax
 VMfsX8ZNU6tUv9gLQPyBkRq7FZFjQs3jS2Mp1K3X04O5uOZXG5oxwDXfk1/demVrWz50RrLyNIC
 IinhwYB0zXjzoBEU+vFO2nHNev7MfK+hKsGWCZFGRNrhtCgpol3yNCA5QxE01fpHn/QmQ72U3Ki
 ZSpdyepm4L52ZAdmwgg0ju4ByKluyTh6PKBt1GIiS/nI0RoCwtDXgL7LIdoO6P2+rHdojpqCvk9
 prgzSR8mfHkK+2w==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently when the current line should be removed from the display
kdb_read() uses memset() to fill a temporary buffer with spaces.
The problem is not that this could be trivially implemented using a
format string rather than open coding it. The real problem is that
it is possible, on systems with a long kdb_prompt_str, to write past
the end of the tmpbuffer.

Happily, as mentioned above, this can be trivially implemented using a
format string. Make it so!

Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index a73779529803f..2aeaf9765b248 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -318,11 +318,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
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


