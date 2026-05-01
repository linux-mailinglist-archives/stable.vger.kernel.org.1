Return-Path: <stable+bounces-242448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDOiCTu/9GkDEQIAu9opvQ
	(envelope-from <stable+bounces-242448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:56:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB44AD6EE
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61DAE300EAA2
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF7F3CC9E2;
	Fri,  1 May 2026 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="BkUf9Y6p"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5872DF126
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647275; cv=none; b=MCauFsGyb1h1suu9+oBY23r4a/WBOiUoAC4115SX1kt5zrAfPJXzIqQ6HubYwTk8aPhkM+vUozRKbJctt8yfuQN1zkWGtaaPH/0iyliQOwQezZMw3qY8XrclK4nHAhH2b7Lo/GbtEV/ecDD7piqQNpMtog5pBUZCiFuWG2XkPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647275; c=relaxed/simple;
	bh=tzUv27qJf57BI8W2F8P/toFyWICC2M/3h6JmHSIb+ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rz55LbEu5+jU8fqFWooerAPCTbHXKt9PYNwPNAzsbvI/BuZ5WaCZkxGUMdIMHoZmPtlb82Xw1PO+u4rpbUWIH/DXnhg2icEEqo7uWM2Etcxt39nyY0l9ntu/8JlXZZyoB9o/7NM0FfB2tJfqElw4iNI1wnZVh2d1QgCHaZE5nAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=BkUf9Y6p; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-42fe552aedeso547776fac.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777647273; x=1778252073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3RanNELOgVu3qUpfVwvN+gLyjlVMJzkyaaexBgkVjA=;
        b=BkUf9Y6pZV8bC3OPPZwXnOvffm+7LWtF1dBZNehuZG0gTsrnjjUknpKHI4E4rTK9ch
         cjw3X60AvLeriVrFcylAdVE/2F7HUltq1Dy8yjA8Fw8YwRhCGGkNnBhftm7xYmcwBQ82
         CAcRdapLKjAxb9rmp5lT+/VvfLksAk//l9gryJQxJqjd4hz+QrFahpz2Ac7jCdtn8ikN
         exhxzTnvmMSCT74i7pFCg8EWYTmFDm5G6zMEjh1jKkOx5034SxejR4h6Qmr8DH8ndi4s
         Ay2Q0lZ1fKRXIVVVEJXobUjYC4+uh/vHxmWEbaMnd5qC/uxg/ULnGTViQgGxGNhj2OW0
         Rahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777647273; x=1778252073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3RanNELOgVu3qUpfVwvN+gLyjlVMJzkyaaexBgkVjA=;
        b=LBLbnL80pWdjnJxE44DZxkBr0KaDxaqAVyWbhLpnJCRkUu40X1q16MkAWHIhQHkdRn
         S0NNnw0rU+Ys+QTLQJqngF8IY+8zuJf14YfJphF/BgVJpLZpB74+a+xQlUcAR8CYKAH3
         ewsvnEHJJwdfayRZsX4y6YV0z3P8MOmLtvY/pkWzBs+2pA52ottj9JN0iVGHlkyl20tZ
         tWufe06QNqUpgJ3CGixW5w4D7WFrukmKZI6+fElLoMa+iG9cK5VywQaGkKFxu2DdaPU6
         GJmaAhEWrPQDLFySWDzAsX2Rl7GxR2GLObQN63ay4nYdb4PXlkCAjJVxVqJIr4wXIKcA
         ITqA==
X-Gm-Message-State: AOJu0Yzpilx1x4m9J7TYW7p7JGRYZifrrWVaD8UqX5bVtHMT4BSKIprq
	Zn5cNtaOCSo5YSOV44ZYOWDSEyNT6TM1KWPnLj1rl6XiJcjlc6MUfuuiuDGZfYjm4uWHZJBwXfr
	FYLAb
X-Gm-Gg: AeBDievdv7mxKwZP7bycYO+TkBSkTzxwqm78Ldg+50lW6NXPadWwjNAHRJE1TXLaNvC
	Y8hDZmDqJ1bA67GxBM1USaP2hMGZLaPT9dtTrj+ponH+NAaSxjieHNvgtULc74eLw17NR8CdxpM
	C7oUPCKhRzim+EUqTQ48oJQbrYVaae2TCz3vqxpJzA3+eAwyGD+/DRPTJ7++CCgjWU36I5No5HM
	q3giGGsPCZDKCH8+pdz/rwXXA4iuZOLdRyd169IM/VtUyJ1d8Z+oW2OPquQ4fq7VJhHZU+nN1//
	2o6DTx0GjpbcOk6KGIK4X6jgCPkZyWI0vBnp3ShVItcIagHDE5rqpfkRJ8tz/oDMYPP+K/HY2iK
	Nd5PWM2SPubBNA83x+0yBPO30Tw3ThNiElvPqF06sfvfwiynlpMRj/s37W0MkgYI2CYPJjlI8pE
	F6J/1BhZoafoUMViJOMMzA6ba7AdV60nZzYNq61m7cz1ob1M5PvYNf4ygixsSTf4C6+sYn2i75l
	/7QYIJGne+KpkA4
X-Received: by 2002:a05:6870:9610:b0:417:47a8:9f4e with SMTP id 586e51a60fabf-4345c5830bbmr1480831fac.38.1777647273164;
        Fri, 01 May 2026 07:54:33 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4129:1360:1c90:7857])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-43454d35e5bsm2805443fac.15.2026.05.01.07.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:54:32 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 5.10.y 1/2] ipmi:ssif: Fix a shutdown race
Date: Fri,  1 May 2026 09:54:26 -0500
Message-ID: <20260501145427.900030-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050148-irregular-kite-7f24@gregkh>
References: <2026050148-irregular-kite-7f24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 94CB44AD6EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242448-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

It was possible for the SSIF thread to stop and quit before the
kthread_stop() call because ssif->stopping was set before the
stop.  So only exit the SSIF thread is kthread_should_stop()
returns true.

There is no need to wake the thread, as the wait will be interrupted
by kthread_stop().

Signed-off-by: Corey Minyard <cminyard@mvista.com>
(cherry picked from commit 6bd0eb6d759b9a22c5509ea04e19c2e8407ba418)
---
 drivers/char/ipmi/ipmi_ssif.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 30f757249c5c..22074f23c06a 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -487,8 +487,6 @@ static int ipmi_ssif_thread(void *data)
 		/* Wait for something to do */
 		result = wait_for_completion_interruptible(
 						&ssif_info->wake_thread);
-		if (ssif_info->stopping)
-			break;
 		if (result == -ERESTARTSYS)
 			continue;
 		init_completion(&ssif_info->wake_thread);
@@ -1279,10 +1277,8 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread) {
-		complete(&ssif_info->wake_thread);
+	if (ssif_info->thread)
 		kthread_stop(ssif_info->thread);
-	}
 }
 
 static int ssif_remove(struct i2c_client *client)
-- 
2.43.0


