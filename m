Return-Path: <stable+bounces-186184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F2BE51A8
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1357353916
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 18:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1A221D96;
	Thu, 16 Oct 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="OiX693zi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94B814F125
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640567; cv=none; b=D/NJAXHSDZfekQ1Hb3CETbqZrlUdaZvnH9d3581H74YtYwT7liwfVaB13UCipY5gV5pTRvJgtRSJsr/D21/Cqjr9iWljZzP0p59c/xVClChg8G5gnK+mnx/cHF4Br5I7jML2Dk/U4ar6Nd3dlRMaRsMb+XLAtbmOyHsfLyhgeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640567; c=relaxed/simple;
	bh=RTkeFEbIFlEFxgpLaQKY0FPgbrHhfOtIleMNx/DLEaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYpBwR/QCaAQ/znfIUuPPvSS89yjiv/gAY1+PxcVk+3C0ivovufyNSKl8v7446jUiFwQxolSZSmYSn3womJgBDIbfeZ2vBNdUjmM4cKSC8zo48tJJSvIV0tO0sPY4IkrOwNJ/pFnb4au/RKtlulDGxCj8qn8VeDE+qDPGLR4IE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=OiX693zi; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7bb79ad6857so574702a34.0
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1760640565; x=1761245365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEYL7hEbD7XQxXOhHSpEI5JrXeXjbha19rlCjzBMaiU=;
        b=OiX693ziOZvcQShPwlG1G2HZssJbSK1ytLywFnnSD8J0KdwfOeLSTBNIvqv3tyN4MH
         HT630YPbNyFsDAGX2uJeyyPGprsDW+GfdckNKxFhWQv8BMzUiEOTmIycXG+qLAbepyOu
         wplXJdTJhnNhAEN9H77MuedlNZy6agMMtenozVmGink/+mxV8pH1mfktUVX7faaNH6zP
         i6yEa4t6R5lWQcYZu5PnX18cAX4gQCngwI0wdfN9QhZARcIDc04RMvXfYnT7PF5N6qRI
         8VWzpqDyGMpm6CQFbuHlV9JJecd0p7oMKeSaVZukBjswqM5GnF8ZadMQOdBDEqB49Xpk
         ZEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640565; x=1761245365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEYL7hEbD7XQxXOhHSpEI5JrXeXjbha19rlCjzBMaiU=;
        b=PhFaLwEwRuNPEtZQCRkO2C89raJ5YNjRM06x2IT4HweJbHswT/Hv3XZxaLIj0K9LZs
         b1Y7P62MFV2/5LBTaZpV2qZjky+1W/rBLbS7ynzyKoIrcAgblqvypGuMOVn5lCFFDfl9
         MBlYoZGaMIBqNLgs5j/R9kKQrJggEKT2TD1Oo+HVd1CM9Mddg5o+yA7H5/aBvrPu+6d5
         ePXLec4L75ZxbIcWYTv496BC7PTJuJTMY4PfpMsTwfpOuuq5akVifi5X+aJC6mauWrny
         0NmI6h0SC+A9ljJlWFbg9s5DNqVZ3dbvj6X7kULHI9XvgtNcjkPeJMKNf4zKu6FiLd4f
         ym6Q==
X-Gm-Message-State: AOJu0YyeMlRm3OabGEGQIq50bcPR44SJ7YylNaLw0sBEL6mIFpjDSmBf
	OaJrfvJsaU1d0vlMkUu+RAH4bPzsee0oqWMOs9Bu20wj2wm5/++8wVxo4T2YuIzOhAVTekzB3dU
	hltkm
X-Gm-Gg: ASbGnctB0n2KdEalLutjhmEz+xq9QpdEx3lvZ34mpoGDWH54wrJ8Jo/aWKEs1Hglw5Q
	v27qKIzqwAZzC6sl/sUcU1+rY6jBsj0mOWig5E9e9YZMWxCvC90hDhU48sm+EhaA7vUSlYVS2te
	MxYp3wwSXBlYF0nSj705pdBl2pHVvz0L0iT6q5VxUWB7tfms06yAs66E7DeYv3/6dYUxc0XvANw
	I7jD/rhdxnF943PA8iaxwFz7IUZPsqXXaUdlo0Qa/HWFMDI7DzeoK3hvomi5+dHV6zvdqXHLGQ7
	KsdpOZc4Gze5l5iMVjp4pV7v9oiqJJUlJ1COFaJ16TM/0cB+U2SOTN0t18dmdUpJlJmYbRXZhYm
	4HvlQLmsJUr/5zzgp3pp1N2C1QFv4GlktLFHGilnR1hqzl+QlzD2kZLvO0m1rSUc7WA4nK9IXcL
	at1+G1
X-Google-Smtp-Source: AGHT+IH/Xvkll1/fwL4Ksj1vCIkhNKE9GiWUjEEqi6lRv4h/9j7tkMPkXKxgFQjmNCZppNbboTvA4A==
X-Received: by 2002:a05:6830:34a9:b0:7ae:d3d:f7cf with SMTP id 46e09a7af769-7c27ca741afmr448696a34.16.1760640564882;
        Thu, 16 Oct 2025 11:49:24 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:fbfe:2b7d:e6e9:975e])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7c27add8752sm320953a34.0.2025.10.16.11.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 11:49:24 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.12.y 2/2] ipmi: Fix handling of messages with provided receive message pointer
Date: Thu, 16 Oct 2025 13:49:17 -0500
Message-ID: <20251016184917.1875857-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016184917.1875857-1-corey@minyard.net>
References: <2025101646-stretch-gyration-6815@gregkh>
 <20251016184917.1875857-1-corey@minyard.net>
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
index 6fb8210879bb..99fe01321971 100644
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


