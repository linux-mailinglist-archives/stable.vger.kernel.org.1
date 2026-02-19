Return-Path: <stable+bounces-217468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIl4LElFl2lMwQIAu9opvQ
	(envelope-from <stable+bounces-217468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:15:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1831516109D
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F239308A8A1
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6734DCD1;
	Thu, 19 Feb 2026 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH7VRoc1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD7434D922
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521205; cv=none; b=NVbUR/9tVrrwC5Q1Nc29CouAAajN+tZHMoPXkH69i8yZDoRnLe+Nv6OFxIIRrSiHe3DbIqm0oRkpl+aDcN/TciZjUl8KLTnud7JRS3RyshqYapEwOQEfsVaiJHpdpoRGG1KFAWc3Zj9HydzJ2jDsxhHD0bOXBz/Z4UR+39J6gnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521205; c=relaxed/simple;
	bh=FgQfbLiyDT66S+sNI1wE/oslfO+pvzybNJFnYppNieM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PSEJo/gbYG4xX2iZye8SA+wkmlGbql6o/PSl7AKLRNNZatGIuiDgdZFmXdm54Af460rUNuLsiYrgSJ9uWdrSz1R+Hg70ltmbgbDMP9sBNeUpgujm3zvPfysDproBQhE3IY8nEIstp3I9ry3QXo2oPStpyFuE4AQ73iu9uRMpgmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH7VRoc1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82418b0178cso700779b3a.1
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521204; x=1772126004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=BH7VRoc1sc/CwuoO/dLbXTiwZb06cO+UinnRhpzQQzplqMSCxnzOaboHEfeop65UOv
         gnQq0L/DyPWVNYaIhlhQVQHYOtm5c0+THmf+fGS5kuWN3FDN+aBSVVp8mjRGBsZdvgNQ
         crFOQUGvnb7oW1aWIFOvtiHaK1/+y9tPXDM2Jp2TU5lFPW6MpfP2uX3DyH9bHKCR8P/8
         1rRElxM4+lpNEhFGPIUHnwH5uGPKbvasBRXchUGCj7NKeFNmK7E0tzbdY5znZ924KDIJ
         52eigSOJlS6C6njPOfINNVvBMl4St+KFab7fqraAHwRDDj7AaktvyRLhmD1BiEsaZJjS
         OW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521204; x=1772126004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=FF32HhSkxT23AHWqffO51tMdtjSse6Oh0Pg1ls9D4WwDZzPe/B9zSWTQV+2EgY9Y3t
         rM5g+6vZ0MUNrhLXNMgFj3FVoeMZMP3sy7zXfjoEicfhHI9pGswE8vP0XuCk2+xSP4bL
         0D6jbkEW/hYObQnn+G+GXLLLRNB+344v+ooKFWJDDmGSiOpGcX6+t+iquaEHlSk1Nxsg
         Wsc5Bs7SbMDWp1bFRJ3zpzItO5QjqD+lp8rrkdKhJQJ4Xpj3+eOxeDf3PQBVdz10mHZ/
         3h6oE7Czv5wguPhWV2U+qmIFG7Xk8L3PdapzTIOCqJ7aqM6Fykkb/LMGp3BLDYCVoz7t
         zvSA==
X-Gm-Message-State: AOJu0Yy2V2QYlmjC6O4+E9SB3SC2Ks1QCDS8kL9UAxvGQcspHuva2o18
	tiZviIZ+YwwgssopF7xEmEizoyOHwefz49yaXGyEpFla+HWnrNtAB+LL34a+tBP/
X-Gm-Gg: AZuq6aLOJmJX8pWuhKSfX44Hjif/dG6igLgF1k2Wuvu0wA8yPB2Y16Z6oc043jRevI0
	XpjxTOQYn7KOjf+VJM3moQRL5iVsvcaKg34wz0R+zRtZpRjSNktkE423CDCJbwOlm8qC77NIdym
	ruwoBcfuPodkprem1Gc+rwmaPuBvKF27kTbgGBFmq07pzXcAnInUz00AjU3uQObstexZaGz8TD0
	JtcGv09Tv604I4zKGLFSjEuPLlkWG/jWQJ2d3NBwkL4xk5zCOl+C1iHgipDQNinFmRHmgBs1oXq
	DrPbokc/AZc/xOnZS7VmFajmFjKTZpcsWCf3VY9xax6Z5ehBdgvToG2s05w8C6UXphD+qygfKxk
	cGnvDxe/0wDGEetN4cyVUSFs9SzfuRBZMmdKv8RRKFtlcX83pgQPoyjNydPFPHSsplICcCsBTaq
	98BlcM2+PBPsC3omNNoHascjy/MxUhqLKMZI1TY28mWep0u+e8OQ==
X-Received: by 2002:a05:6a21:62c8:b0:366:5332:466 with SMTP id adf61e73a8af0-394fc2fd726mr5605743637.53.1771521203784;
        Thu, 19 Feb 2026 09:13:23 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:23 -0800 (PST)
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
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.10.y 02/15] ARM: spear: Do not use timer namespace for timer_shutdown() function
Date: Fri, 20 Feb 2026 02:12:57 +0900
Message-Id: <20260219171310.118170-3-aha310510@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-217468-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,arndb.de:email,linutronix.de:email,roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 1831516109D
X-Rspamd-Action: no action

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 80b55772d41d8afec68dbc4ff0368a9fe5d1f390 ]

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions called
"timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to spear_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20221106212701.822440504@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.228348078@goodmis.org/
Link: https://lore.kernel.org/r/20221110064146.810953418@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.513863211@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 arch/arm/mach-spear/time.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index e979e2197f8e..5371c824786d 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -90,7 +90,7 @@ static void __init spear_clocksource_init(void)
 		200, 16, clocksource_mmio_readw_up);
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void spear_timer_shutdown(struct clock_event_device *evt)
 {
 	u16 val = readw(gpt_base + CR(CLKEVT));
 
@@ -101,7 +101,7 @@ static inline void timer_shutdown(struct clock_event_device *evt)
 
 static int spear_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static int spear_set_oneshot(struct clock_event_device *evt)
 	u16 val;
 
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	val = readw(gpt_base + CR(CLKEVT));
 	val |= CTRL_ONE_SHOT;
@@ -126,7 +126,7 @@ static int spear_set_periodic(struct clock_event_device *evt)
 	u16 val;
 
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	period = clk_get_rate(gpt_clk) / HZ;
 	period >>= CTRL_PRESCALER16;
--

