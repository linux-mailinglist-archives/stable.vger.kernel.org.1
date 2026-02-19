Return-Path: <stable+bounces-217481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJqEMnZGl2m2wQIAu9opvQ
	(envelope-from <stable+bounces-217481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:20:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D691611DB
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F9BE313AD61
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECCE353EF4;
	Thu, 19 Feb 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTSVdSNV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D034F27B
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521260; cv=none; b=eXMEIUrFvwP8GuSuaKQXc7zls8nOvoVzwvjlJKV8QW9hdJs92/x6qGhkdnyoCfRAo0QfrlPaBkIkHU1KIGRzqMYQ6Vc/L/WRhCiQ9fTJtwEjz2hmWStWv7dFBFiWwIKRqt6wUln9LHx/eApTsC3RGEpJ/Cc1ushkLU5kYGDjJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521260; c=relaxed/simple;
	bh=Hkj+3H7Z8a3D2Y8tRX2SbgMdeMF/kuGLJMd704mftHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNcc+FexSl54He2jm7r7S2wPEj8+pJgZE2oOoLb4kkMkULsYqQ3sMsZplOjUcO6L6BxqM/4qdQ9WgX1J672Djl9Xcdc4hcg80/VQDmEVtNpadC0lS2qk9I2TczCBHC7+jGco8lV7R4qRpJK5TqyR0xI9+VicYg4vm30Nm6vY5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTSVdSNV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81df6a302b1so1193843b3a.2
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521258; x=1772126058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKKfl8PT/GCaUO5UcTwQ5MiYDnn0Vh3veSo7jvr1Ic4=;
        b=OTSVdSNVuwBDyXp3D/0mYMOlcZ/IMRRwNikzboDFnxJPVV2zhMW7RKKZgUclNIQXDg
         7jzvPDlKIG0kRzsfa8L3IwpnM7wnF1+XfsxKv2pAgjANZ9fv1qDdOdfUPT95aLQCorng
         ZSLElhkX3S6L28YVBEnvfkIg3Ynaba9hm34SBOrqeNcxQ1zlxrMfkxyiu4Vib9ydiIV0
         +Dpz+Kyn2QHw0DeC1yjlpg3wtvrVEUbKlC0V9gmjVIccqXbqjL+2d5sV8ZuYpREEnEZO
         5EMcqLTixUWA0UKXvNBQ7VS81ZCKuv/pS4dlgKcMqGCY1+/1AB4Ssj1HAZn8kKdodPPc
         1i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521258; x=1772126058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKKfl8PT/GCaUO5UcTwQ5MiYDnn0Vh3veSo7jvr1Ic4=;
        b=A32OJ34YFI2PdRTsPQyH3oJc49d90JD+YEaNNiG3CsHxUEfGA9O74sVGUq2crsi+su
         Hi3EJqOXpkUpFsxPv2ce4b32LcATOvVZlrMOQ2Gk02MjyhrPC9HT09Yc+IQPElGkRwDl
         zuS4QvFTlTs7Q811e58iE0h9Vt3mj1oSUrkhrbPyJ2Flf1WdohJbVDi7UeTsl+DNcpCp
         +zv4G3sahbfJ480NOC1T62wKFyTqs3+OfPfqR4zNQNJN6v/pGu1usZvvbf0ged4W3PAT
         IBAqD2uTsJMNGI8gRjAFqVUd+GYeBzS5x/LbuJnwDOmi64pC40dv6UY/qvePD0GWDtSm
         QeUg==
X-Gm-Message-State: AOJu0YxWiHA2Uym1bGWLG47RJ6eIRSB2OiFlE467g8E/j+gsM4GxO6TM
	peuzQ6CbtrfHeyrmkVwFuyPjqsHTzCB/GkTw5bq51vucP7nAHdIFYAoUw2j4Pcmn
X-Gm-Gg: AZuq6aJypIJ85yj+KXYJzIKxsr5fzFDQ4WofIsbjboehiHrpLbKOAKW+vbCTAA697HC
	P2kPf93KjxZ7Wzxq0v746VZ2MYYCs0+SCWmDBnpPbc9A8PaXvntHwB8OfbPvIX88qNrKYTWbOn0
	Z4bBt35UuJPyvIKrYCFRhcmj1PLG61xBtG943yF8mrWCJ/ga3vL31KTGQ7QtGk6yBcK5QlYEMgU
	ySxxIuhiWqGaoYO1O6FcBvsDPO/2zRY3nVJyYCx7KPoAsr7q0OtRtobiBzt5b9AnqOgKt9c3vM0
	okuOciztvjrFn/j45fbxfy09AXy712gi5xg70Gl+i7ibV0VZ6e8rHvZB0+ifrqQnD0+mW4Al3BR
	Jvq51PEKv/S2VzPb2cHx/6ncY6+STjJgu5qPEBLgNCjOVGxEScda7dQxe3l1ybGYGSMyGGhTPRt
	/+sU7UCSFTehLjcpPanTwfEfRKPVwu+rKNbbwebMb+lrVrXALSDg==
X-Received: by 2002:a05:6a20:cf88:b0:361:28dd:a9ff with SMTP id adf61e73a8af0-39483a5a85dmr17158114637.38.1771521258512;
        Thu, 19 Feb 2026 09:14:18 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:14:17 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	zouyipeng@huawei.com,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev
Subject: [PATCH 5.10.y 15/15] timers: Fix NULL function pointer race in timer_shutdown_sync()
Date: Fri, 20 Feb 2026 02:13:10 +0900
Message-Id: <20260219171310.118170-16-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219171310.118170-1-aha310510@gmail.com>
References: <20260219171310.118170-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217481-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 15D691611DB
X-Rspamd-Action: no action

From: Yipeng Zou <zouyipeng@huawei.com>

[ Upstream commit 20739af07383e6eb1ec59dcd70b72ebfa9ac362c ]

There is a race condition between timer_shutdown_sync() and timer
expiration that can lead to hitting a WARN_ON in expire_timers().

The issue occurs when timer_shutdown_sync() clears the timer function
to NULL while the timer is still running on another CPU. The race
scenario looks like this:

CPU0					CPU1
					<SOFTIRQ>
					lock_timer_base()
					expire_timers()
					base->running_timer = timer;
					unlock_timer_base()
					[call_timer_fn enter]
					mod_timer()
					...
timer_shutdown_sync()
lock_timer_base()
// For now, will not detach the timer but only clear its function to NULL
if (base->running_timer != timer)
	ret = detach_if_pending(timer, base, true);
if (shutdown)
	timer->function = NULL;
unlock_timer_base()
					[call_timer_fn exit]
					lock_timer_base()
					base->running_timer = NULL;
					unlock_timer_base()
					...
					// Now timer is pending while its function set to NULL.
					// next timer trigger
					<SOFTIRQ>
					expire_timers()
					WARN_ON_ONCE(!fn) // hit
					...
lock_timer_base()
// Now timer will detach
if (base->running_timer != timer)
	ret = detach_if_pending(timer, base, true);
if (shutdown)
	timer->function = NULL;
unlock_timer_base()

The problem is that timer_shutdown_sync() clears the timer function
regardless of whether the timer is currently running. This can leave a
pending timer with a NULL function pointer, which triggers the
WARN_ON_ONCE(!fn) check in expire_timers().

Fix this by only clearing the timer function when actually detaching the
timer. If the timer is running, leave the function pointer intact, which is
safe because the timer will be properly detached when it finishes running.

Fixes: 0cc04e80458a ("timers: Add shutdown mechanism to the internal functions")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251122093942.301559-1-zouyipeng@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/timer.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1360,10 +1360,11 @@ static int __try_to_del_timer_sync(struc
 
 	base = lock_timer_base(timer, &flags);
 
-	if (base->running_timer != timer)
+	if (base->running_timer != timer) {
 		ret = detach_if_pending(timer, base, true);
-	if (shutdown)
-		timer->function = NULL;
+		if (shutdown)
+			timer->function = NULL;
+	}
 
 	raw_spin_unlock_irqrestore(&base->lock, flags);

--

