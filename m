Return-Path: <stable+bounces-242463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aONfBLPR9GkYFQIAu9opvQ
	(envelope-from <stable+bounces-242463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 18:15:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BDA4AE030
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 18:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA333007F7C
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 16:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FE93FD156;
	Fri,  1 May 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="lCJYcWIz"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007503F65EB
	for <stable@vger.kernel.org>; Fri,  1 May 2026 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652061; cv=none; b=AJh0/57p1u4rmwTp8R1DTHnKe1N3GGbQRgeheSrf7p8r9S9EuW2EvmVwzPGN4lENuTk2mFNHFVgZHRXnZ0KKGK4X8I2YZbvb9Uq8fwTymtUOIsb2btDTGz7YEFGIqDq9DV3QrJCrhfTOPe9ug6S4Tl1ehb3IfCwujNsNGqFz0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652061; c=relaxed/simple;
	bh=QApkBbYLZjF+Dahrn0oqfzvCJsau4GVqPBa4GH0ge3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3MQbSMrrlAgir8C1bsjIYEoW3++DOj+xcSZg4+0hD30DMZrjU1V15oaKJP7X5ksognL13TNJ59xKi14klQkjD6SZUBvu8oo9pyi9J8rLd8kjVKyFKf47/2qY5Ns3QTUOJ2T7a22pxkhL5tQQq8QGgwB4YjNDpjY9cR2lcbyPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=lCJYcWIz; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4645dde00a7so2347700b6e.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777652054; x=1778256854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsQBpKRgkvCDgE8xa4toBX6WP10+bx0bhiRSWGplw4o=;
        b=lCJYcWIzuCAsUKiS2txE6r3KeAs5BOLf+j2hjySAgq9mNBUn+Kf8o9pO2oz+c1gDXW
         YjM6Bp1ccttEPgelAEeYsVUP4XOrLyV/mc6i6x69nqlpWdJeBVDoZrnfoEenzfLdMgKy
         mhV4MzGeu2hdgqXBYTKtQmSK1XM123Ne+7NoCfYHENzfVtFee/KVI9S2MgT/2tcOxmNQ
         pGSgkoiHRula0Q+VzqPQwg3/tuOGGc5QmeoaKtO09aS+mKS37NV2erMajCE3oHe+ODHZ
         qA7wrAQKotURDhVroLUr4VzoF70g7vs+8CC0uGy5yJJEm/4RxXPSK+eYZttDcPdEb+RF
         VtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777652054; x=1778256854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fsQBpKRgkvCDgE8xa4toBX6WP10+bx0bhiRSWGplw4o=;
        b=kublpQSdqp9LXqEieqPWbg7FMfSrfS9A6Bbrnf78Pjsivgkco1hxxShPTNA6rUj3/3
         fAnsi+AP5imDltKeyC/h7Zx1CU3Bk+x0jRg33mquG+9S686xme6b8Own5rd4mJcl3673
         +c3zA/Vy0v8rA4OzV7yuZqOrSFHEzbKjIvuxEAB2AuSwizCE6Xky+pnfgBWW0FZ5GG4W
         hOkh5EO58iCPFo7Jjclqcyv1xumSzNgh9Jx0ffMi1/srP81GuXUx746DzGwYpCig3GXe
         q0CnDjb2YttGJflKSdLsno7GZ/eADIcyJBXUiZX6ABon2EdTxHj0Yln3WkyUsUAEHkRt
         SGQQ==
X-Gm-Message-State: AOJu0YwQmSVQKAk4EZajvdHz7k5d0vrhO6g752NOnrqd7JCZ6Rwas26/
	oMWrFv1nZvd2tw5R+D9juzuTxe4PQJPyH9M6w4fTm7G91v7ZM70j2/yNsU6WGxZX5xMiOSFlW3U
	JSkSI
X-Gm-Gg: AeBDievouEWg/IxNDgEzxChMfVQ16z7ZijUmH4kOdBLegUPUm2/FrnrZa18+DYo0eF4
	cTQMbE3tZOGyt0LYS09s1Qrm23M1hGN5ERwKG8t4nWbyuuY52fILOQw46JLPbus0W2567Lnb/B7
	TF0JPjWfuG/POmqWEKSwsQQJdCyo1Z/RxJjHg/6+q2WHS9sUeKEB6gtE28lzMAZlo86IIT7jOiV
	rvDMM53zoSdiGbQHA/s3p5N2jdF7x6nnhuXv7UQgyfg7U9idJoIjnxYD0VRTivz22Uno/fOq8gZ
	TSjX+mTu7FYdpbJWF6YdAgY6USg0/UTgX49wJO+/zj8Sf+R5OMYLpP3GaddwF8s5EC01sOKNEea
	XYY9EPtjZwls0mqRbxAqi2Wj1eHdPrLZYwnr3J0FORo+tH2UOusp2JY8IX1D5DqiyT2DtcowUXw
	175tNJDCMSL/KJAXxX0c4lz/Q7tXse/0tBmfQJLebWitZbAoPFuPfElHh0W9Tt6v+8DDsYV2w82
	F2BQHbXqhApP8In
X-Received: by 2002:a05:6808:179b:b0:467:e3d5:8389 with SMTP id 5614622812f47-47c892aca88mr72972b6e.20.1777652054541;
        Fri, 01 May 2026 09:14:14 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4129:1360:1c90:7857])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-47c763b2c87sm1568531b6e.4.2026.05.01.09.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 09:14:14 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.15.y] ipmi:ssif: Fix a thread shutdown issue
Date: Fri,  1 May 2026 11:11:41 -0500
Message-ID: <20260501161407.1106914-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050148-politely-tabloid-3059@gregkh>
References: <2026050148-politely-tabloid-3059@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66BDA4AE030
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242463-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The kthread used by ssif had a shutdown issue that was fixed by
6bd0eb6d759b ("ipmi:ssif: Fix a shutdown race").  That was backported to
an older kernel in the process of fixing another issue,
2105b70be84d ("ipmi:ssif: Clean up kthread on errors") as it would
not have worked correctly without the shutdown race fix.

Kernel version 6.1 has a fix to kthread stop to cause interruptible
waits to return -ERESTARTSYS on a stop.  This has not been backported
to older kernels, and that would probably be a bad idea.  But not
having this means that the completion in the SSIF driver will
not wake up on kthread_stop(), thus the driver hangs on unload.

We can't cause the interrupt before calling kthread_stop() because
the task stop bit need to be set before causing the interrupt.

So re-introduce the code removed by 6bd0eb6d759b ("ipmi:ssif: Fix a
shutdown race") but add a wait at the end of the thread so it
doesn't exit until kthread_should_stop() is set.

Fixes: 6bd0eb6d759b ("ipmi:ssif: Fix a shutdown race")
Signed-off-by: Corey Minyard <corey@minyard.net>
---
I realized I hadn't done an unload test on this on the older kernels.
But why wouldn't that work?  Well, it didn't.  One more patch for this
on top of the previous two.  Sorry :(.


 drivers/char/ipmi/ipmi_ssif.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index ce0f20cac88d..b884bfae7fa6 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -487,6 +487,8 @@ static int ipmi_ssif_thread(void *data)
 		/* Wait for something to do */
 		result = wait_for_completion_interruptible(
 						&ssif_info->wake_thread);
+		if (ssif_info->stopping)
+			break;
 		if (result == -ERESTARTSYS)
 			continue;
 		init_completion(&ssif_info->wake_thread);
@@ -511,6 +513,16 @@ static int ipmi_ssif_thread(void *data)
 		}
 	}
 
+	/*
+	 * The thread can break out of the loop if stopping is set,
+	 * and this can be before kthread_stop() gets called and thus
+	 * kthread_should_stop() will not be set.  This can cause
+	 * spinning calling this function and other bad things.  So
+	 * wait for kthread_should_stop() to be set.
+	 */
+	while (!kthread_should_stop())
+		msleep_interruptible(1);
+
 	return 0;
 }
 
@@ -1278,6 +1290,7 @@ static void shutdown_ssif(void *send_info)
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
 	if (ssif_info->thread) {
+		complete(&ssif_info->wake_thread);
 		kthread_stop(ssif_info->thread);
 		ssif_info->thread = NULL;
 	}
@@ -1916,6 +1929,8 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		 * it to NULL.  Otherwise it must be freed here.
 		 */
 		if (ssif_info->thread) {
+			ssif_info->stopping = true;
+			complete(&ssif_info->wake_thread);
 			kthread_stop(ssif_info->thread);
 			ssif_info->thread = NULL;
 		}
-- 
2.43.0


