Return-Path: <stable+bounces-186187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9815BE51B4
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 20:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81EB44E7D81
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 18:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7211FAC34;
	Thu, 16 Oct 2025 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="hzVxhEMf"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1EDDD2
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640619; cv=none; b=hXIgIVzVkUSSAzOf8e+tmw/5EneYbJZ21F9ytFtCySaYFaJU5cTd/oF7waBJcfbfd6wGuerU5XsXyi7/gPMl4L71qaSQ5MjdfuGc/oLvpzNH0y+IquA37u0SdSC+MBhOb5p29d5CIV0LbsxxplaDcQ7vNDeRo5SkZTIHPaP7Nus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640619; c=relaxed/simple;
	bh=L0eWR5TY+nZOp1/0LKW/gqDqfJUjhJtw4qNaylcWcqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYTrhHivz5Ymn44mU7Luepc4or33cqr2Wk0o4mDnEp0uwROA2EbBay9hHgh05pC7qBjgT6mD1IadoK33ru2p9ucLXF5x0Niq1hIcaOx5n7/e/fBE7fdAACsA0bIKTwY2jeO5FGCRUrmDlkbGAavyUTYeqg+5ns6fVb+pX9VoUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=hzVxhEMf; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3c978f55367so513343fac.3
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1760640617; x=1761245417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYYHUcUtHwikCZxA/xU59OTKSJ+fWqTfkEhB7wF4Gu4=;
        b=hzVxhEMf3bjyKV1l6SuXZLVs/GW/jKVGrAidwlEg2zS0X371U4Rd2extJQRZ5tV+Il
         FgD39+SdTYopvmd3YxBKntCBYZA1GxbVS4psU3lndxkW01BULd6SIAJYq/epv2miLygM
         ygZ6S+ClncIk5cBetNKJgm1eWjn1z9ce35Nh6Cw/5wz22gDrFaI55Egk7BIkot29c2lh
         97wDJczi2bAkT6WS1gtkZrL8n5g1Rr+ztKEd6+84rTLSljNQr26E26t0tZP9J0wbWDQv
         3iQ4B2kINXOOJXRIkYUtbRYgy5ODHiBr/rDDIYH7kCZzNUh4BwqGSGj3+MCJvV7dLlY6
         enNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640617; x=1761245417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYYHUcUtHwikCZxA/xU59OTKSJ+fWqTfkEhB7wF4Gu4=;
        b=U2+va2DMtGmGKMlGik0G7JeBrXGNjeDqHx5Y5kB3+pPpejxihhRLoVpmJZjWT/uJGN
         1qzPu4ru6SpavYertZaQ7Lc6CW1+iz1jItArxEIq/mX9iXX+rC6Z22HDpK59ndETABdd
         DtULY2xjzaSYt5I952kNVQoGmQy1yPBl1zsqelotwGMLfOYunRlU7EpLsveHRrkeEkJi
         gGIEHumY+QY4OocitC9zibVkWTBuLTBP8mI5Z/VGSw25Vebjfrm9lj4J7lEEjaqDqbZK
         qErrz4rT13Xfbgpi+tkAxEctGF2vcc5gaXwkbBsvMyyOwWl4357B7qmO9FgqYnU/TDec
         vYvQ==
X-Gm-Message-State: AOJu0YzK4oZlWbQx79eIE0HmXqT62ozL37XzMOcZqK5LJK9u3HV+aiHq
	Tj+pA8ugoTL549ncLJJ0K3Jr9PyziQhFFnSI+02LOuKH9q0nsVA/judQPkNVTCo0+cC/oHeq9BQ
	Poq+r
X-Gm-Gg: ASbGncuB4K5lVjNHemaBJp+oz5H+qF4y9QEx4rXnlgnoD9mZW19cpXRstaIsGq8KDrX
	RujfgCxRKiBKEArIip+rjrO3umeoaZZLE8MaBPSGYcDlPlIQprVVr7/xKEO/S6IhOkV/X1qfT8K
	C7uIB2QJwiY6vXf4MGVMvmjyhQwm7PzzQRSCd+q3d71/k4iwGE+GUUwbHjz6boDLkW2w0TI8n6F
	cP9M+ZP0F6TdD8eJtr5u4AdOqbmx80w1Hj8gvEt43qj3ROd6i1XNp5yaXWSwah1zFNWQ0zukkBx
	ppPVJOzMTt7X2zg496+kThD3lYbpJGh944Kuph5Y9s8HdO0udUrYA927nE4WrGtoSJgiLCKad0k
	JWdbtJhWuUPQDiYyhruAg8qpqdRwq+kcBkFh9zL7QRq61W4Nh9J/DwkUeoaPTMyaPkLInDw==
X-Google-Smtp-Source: AGHT+IGIIcZy8LhtHyRPWwObhMGgEp9R5p82AMxeAMWB7dWXZ33nwKwEoei7qAfvAWD/t2bV3b83ow==
X-Received: by 2002:a05:6870:3b19:b0:3c6:e17f:193e with SMTP id 586e51a60fabf-3c98d0df9c4mr419720fac.32.1760640616681;
        Thu, 16 Oct 2025 11:50:16 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:fbfe:2b7d:e6e9:975e])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-3c8cc4d3f55sm6399957fac.3.2025.10.16.11.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 11:50:16 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.6.y 2/2] ipmi: Fix handling of messages with provided receive message pointer
Date: Thu, 16 Oct 2025 13:50:06 -0500
Message-ID: <20251016185006.1876032-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016185006.1876032-1-corey@minyard.net>
References: <2025101647-undated-train-2b88@gregkh>
 <20251016185006.1876032-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

commit e2c69490dda5d4c9f1bfbb2898989c8f3530e354 upstream

Prior to commit b52da4054ee0 ("ipmi: Rework user message limit handling"),
i_ipmi_request() used to increase the user reference counter if the receive
message is provided by the caller of IPMI API functions. This is no longer
the case. However, ipmi_free_recv_msg() is still called and decreases the
reference counter. This results in the reference counter reaching zero,
the user data pointer is released, and all kinds of interesting crashes are
seen.

Fix the problem by increasing user reference counter if the receive message
has been provided by the caller.

Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
Reported-by: Eric Dumazet <edumazet@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Greg Thelen <gthelen@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20251006201857.3433837-1-linux@roeck-us.net>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_msghandler.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 7ad17c5b8966..b7d8bf202ed2 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2311,8 +2311,11 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	if (supplied_recv) {
 		recv_msg = supplied_recv;
 		recv_msg->user = user;
-		if (user)
+		if (user) {
 			atomic_inc(&user->nr_msgs);
+			/* The put happens when the message is freed. */
+			kref_get(&user->refcount);
+		}
 	} else {
 		recv_msg = ipmi_alloc_recv_msg(user);
 		if (IS_ERR(recv_msg))
-- 
2.43.0


