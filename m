Return-Path: <stable+bounces-242443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IACJFZW29GmvDwIAu9opvQ
	(envelope-from <stable+bounces-242443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:20:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C024AD2C3
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 699B6300B9D8
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8943C5DA1;
	Fri,  1 May 2026 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="CckhYMe9"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA89E3859EC
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645202; cv=none; b=TRJjdIUl3sZFiXb4fWxt99AYGBYMuDU8Fak9NpcpbxoSjwwT+WhO75cqd3dkPbr7tZ63HWl9fP7eEac0q6nVSB5F2zRkmKd8Jpdu2hq7RHnAOjnyT91xH/u+QHQbmXCI/124w6ce8S3EGyGwheVXpAQTgKJ9VIsdufpKhX2AkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645202; c=relaxed/simple;
	bh=70Qp8M/nzmku2exjgphqVrMkunZB8ZQrQKRXsawzlNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPZoQZBhx7Y6G6ZOf4hImC0W37+x5f2Ghw3vjM1C8E9rtEZRX3nGep+F9KwLd/zlqG67pm6npSMR9nxoFk7VL7A6ZYot1zUbbE6rIZTASjQU6ENEwQxakPRHd+OSYqavmS59hhQ+2bLIbLRAvDpmlPggA29cZg9FuIlX0K8PrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=CckhYMe9; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40ea36b56b7so1608047fac.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777645199; x=1778249999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiTHCwqwjAXLnH/QjLRl594eo+ZhFn5ILGSG1fc+p8Y=;
        b=CckhYMe9o+0k39cC8r66E8iZCOzAn18W6Gy5NjqQmHHcmH4L+CvvfaG5AoYLWVPEAG
         929aNv+DCoPT7cn/hzw5hfqGWGtaWMIJuhX6RfzKobQ+hXpDYVUY/knqGx06mQW3PSGS
         QcLKZ6ZcF9rXQc+pBmANUPkqthzQe08RFwFrqAgHRnh03APeTqVFOBVXnsREyyB9yDrt
         LJHySjNBfGKDBXl+jdU+msFBTJWKwP6s+c9XN3ohizT9nxYdAEWHdRtJCk07ujBP7olw
         GdhAm1R61tXep4dGoW3xbEKB51p5uaIesGFST59knL8Ep2wtH3ezcDx2Xl1a5WWLI5v4
         8IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777645199; x=1778249999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiTHCwqwjAXLnH/QjLRl594eo+ZhFn5ILGSG1fc+p8Y=;
        b=ndZesK7o0oXW7kFQc01Vt/wc1mQ5j0jWDFuC93ZbdKxgN7/7TP1nddlzr+wUBbalg3
         MFcme6rC+BoZRFtpZ3ov9C5CZaXRSUfDiYOQ4lyIsd4vF+25lVDplKMubU17C4/bDkqx
         vFwVUs4imsreuryqDgscPeNDqdrfbx4sDn+5LV0ttZe3/Ckt3vOsYh39PT1QJ/Z5OYBz
         qoLxLtaQQtgwdTLdk4M8tAP6eRAy574i75L+EVj6MKVnbYo/QSUkZDHSAwpalxePlsaR
         RRkiNiwjgDQhwN7uAF4cxriY+Z0dZxKRvCmYUtvAUxNc7bq7r+iLcoa8B47RzcJ80smD
         DiWw==
X-Gm-Message-State: AOJu0Yw0+uIle6x/uc7ozCklorz3LZXqe8O/Tuu4Vrdxj/t+ZgnduNd7
	uk61+3gS/7Xodps+Q7tB8qyqzttBkUkcktgtdl6FNCiayl2kHqdk61j9zTNRzqxOjs0REAEjDHI
	G48DK
X-Gm-Gg: AeBDievM9xDZ9kZ/guq6nvup15y2lisbxQExv/dWHmf6ftxTfIrwlOQh2BDwtFxBzWs
	bJRbDFdMD0cIXgqtCtSnQQJ5f1r9pj47l+Do/jRvCFlQwSU5B2KrbfdKyZAlhTJ15WFRc9UQ5tb
	8qb4FXzbtTctH0gtHglru1C2ivrtlrMJFnNJjnb4iHe7Mjv4iBrNlq2j9wCazAguPanR14STywV
	dEOykxeiQBm2M3XKQCCoqFLvwuLMyLEhaULGCYjByD67zk/Eoq8iOt/9cks28DiFc4H07mfJF0y
	2Wt1Ec3TMVWfx7d2KXyVNjqcv0uKzWf1uJs24bNjVPuPH6rSuPE9qqINKJ5hbzS8G6dPYuFVsaL
	rggf2WRRX20PUOIqshE1XMptuWD/8vidP7LiWq6tEzh/hW2Xk0qbnHVAuzCYhmdqGBtyr8iRYFO
	uGUOBWHGC6gtxkDpyijg8/4plRuaEHj0fusHOE0Cm9X06r1IdZOoKH8LR7nHsCvVt5BB4eibI6U
	9JmxRa8RSqMWp7i
X-Received: by 2002:a05:6871:6d04:b0:36e:8381:db00 with SMTP id 586e51a60fabf-4343377d161mr3893759fac.9.1777645199060;
        Fri, 01 May 2026 07:19:59 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4129:1360:1c90:7857])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-43454d324a4sm2796558fac.14.2026.05.01.07.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:19:58 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 6.1.y 1/2] ipmi:ssif: Fix a shutdown race
Date: Fri,  1 May 2026 09:19:52 -0500
Message-ID: <20260501141953.781781-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050147-trio-dangling-a9ed@gregkh>
References: <2026050147-trio-dangling-a9ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A7C024AD2C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242443-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:dkim,minyard.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mvista.com:email]

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
index 248459f97c67..fbc870ffff6a 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -481,8 +481,6 @@ static int ipmi_ssif_thread(void *data)
 		/* Wait for something to do */
 		result = wait_for_completion_interruptible(
 						&ssif_info->wake_thread);
-		if (ssif_info->stopping)
-			break;
 		if (result == -ERESTARTSYS)
 			continue;
 		init_completion(&ssif_info->wake_thread);
@@ -1270,10 +1268,8 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread) {
-		complete(&ssif_info->wake_thread);
+	if (ssif_info->thread)
 		kthread_stop(ssif_info->thread);
-	}
 }
 
 static void ssif_remove(struct i2c_client *client)
-- 
2.43.0


