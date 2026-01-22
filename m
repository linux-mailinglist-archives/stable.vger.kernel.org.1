Return-Path: <stable+bounces-211207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOvEMSjdcWk+MgAAu9opvQ
	(envelope-from <stable+bounces-211207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 09:17:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE1862ECB
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 09:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46A797AAF72
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF90F481A9F;
	Thu, 22 Jan 2026 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNv42n/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D666480DC4
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069432; cv=none; b=TdFRl2Bcz8wHWJGbLSMOMvJEt3mUzDGl9bgWXZkZ07E3RytbNuDt688tvfKi5SW5v6JTlr7Xuk9JH3T5GfhJfTgyTwJPvQU27kGXalXEz1anK5l8nKc3qSfmQVR9zNBqxLcniCMli+wr/bw6cthzt99Q4i18eKrWSXPfMAhWcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069432; c=relaxed/simple;
	bh=IvOasZrut6PCd3af8YtoDpHpptDz9z7PgxcJbJl9S1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUYJfQp1BNt9Xgb/n9T6fcztYItvTumaQK+10XyVFRbOqCXs4TCOcdZ3mQpnwz0Rt9snrmTPPi3xLcseZpzRc+5J4vnn+RpyS1hMyaBBe7Xi6nhzPhzg+9rlCp55i9CYA01bostwlMqp1m/txpgvSozNhYiX75FceB6DNBsoL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNv42n/e; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so438610f8f.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 00:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769069428; x=1769674228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtOpl7xweHl0EFuZPJYt8DnqlAREakqhJs13CERid+E=;
        b=mNv42n/e1RFd1ldrDrgWz+L0DOvPdZzEYHP9lDBsrkuRW6Xon0MnbkCwc9Jvejm/sa
         BqdKbzXXkxf+dv4xmtDCaTq1Xnk1u3ZHsfslnVR0w93WfmjMrFk5Q57eHYA+o2X/qgVJ
         bDmFuWE8y9HlrCTmNB8IAkExWYBEwYHqcg3M9oqXQxz2+93x7mNBIDvI1pGIAhv2zqf5
         vVRDatPRKhHTtsoD6Gq+Kwj0A77/5FVOJfjS2p6ebcASxV02ZvNfyhYQJXMUladzhbBk
         8mYZeBwL+DmMNH3WqaKqLnikuBPRVst20IUUUQ+zWgryd7o+GuGCNfR74mXbGceE2zNo
         Bg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769069428; x=1769674228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DtOpl7xweHl0EFuZPJYt8DnqlAREakqhJs13CERid+E=;
        b=W5sqhNtBrn07Jh9KMiuuE6Nss8TMctge/rRl0zLTR9Xx+VeB4AQgAOujZ2jTvB1cQk
         1vriI0mUHA7S/a9GSEzKKVCjsj8xz50C/a9tMZqpft7hmtgd2LihrkvxSRPLxIGLatfs
         EbvE2iS6qJuVVlAyUMUSDYGwmBUWTX857QYuEGXMPRLDEiLRU9iZGvmr6KbG999lX8JI
         CJbzuY9+h3QEmecL8CAeN2YCKRHgH9dvegoF3XtWJkDjMpaWb+mfI5oea8ACMYyuG5s6
         WvDfvGkqbVbhvsuB745vwNyqA8AMKIUBIOVpwooP7jvEQzYnApKfoG+MJzNHp9aKwDOY
         FXMg==
X-Forwarded-Encrypted: i=1; AJvYcCWFUJqtX+iIdSvRJk7Ixx71JWYigu1R9+8ix8mp//jxwP6x7HNv16w5AEB+8/5zyN06vNrkrgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjlqBvDTazvYi8+YLyFtcWK3kFW9mC80gjbtLQL3ygwAQzDJk4
	ttUSiEtTnptDxjwC2Gn1fL+uZWIHuAxKkkVRrHudrvg1kCFudLFQP7uw
X-Gm-Gg: AZuq6aKm7HaGkisTUXuaKfDBngh/P1zgBRNmTQtTwt8bcxQEcQKwCCprqQLnPAbC0oE
	daUxTkatnZUR+/GNQXopWxhLMnLz8jn401pD2b1ogkamWP06FTFaNf3Jm8TEf06VhuQ6Towjmge
	aGI9Gj1gAV3bbMDu1bjKDqOZcozBI4F08SnqTi+Cmdf+/bUmIO+dynsqWEx2fi2288Xbt8Ljajs
	rnalhgXLJxzdQ7JbdgmrQcrEQoK7wlZ8lMM6oSRkuEjLgBeOA5XlyDOZECEFNvfLaBOl4+kQZsD
	wvrDhELYDQrKR/kIXuAT6xGsG17mAjs8wA3PmBRegW2ESGiDlKPcWy/rpK3XXi2N4wHU6puHMza
	Jz5Nh5mHtjl3Vq3XeCAv2+B2+LZuVMXT8JJnZ911VblFaCbteBmozU48qI2i+Pdw2Dmv72xpdhK
	Yaf8VeYi0oQayEAvcr8yIQNBUqTd4fsOJqT14PFrw=
X-Received: by 2002:a05:6000:2510:b0:435:9cd5:bb2e with SMTP id ffacd0b85a97d-4359cd5bc49mr9588007f8f.11.1769069428106;
        Thu, 22 Jan 2026 00:10:28 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:c606:9800:ea1b:9133:ab8e:bdea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997ed8bsm43766261f8f.36.2026.01.22.00.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 00:10:27 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	christian.loehle@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yumpusamongus@gmail.com,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] cpuidle: menu: Use min() to prevent deep C-states when tick is stopped
Date: Thu, 22 Jan 2026 10:09:39 +0200
Message-ID: <20260122080937.22347-4-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122080937.22347-2-sunlightlinux@gmail.com>
References: <20260122080937.22347-2-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,vger.kernel.org,gmail.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-211207-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunlightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AE1862ECB
X-Rspamd-Action: no action

From: Ionut Nechita <ionut_n2001@yahoo.com>

When the tick is already stopped and the predicted idle duration is short
(< TICK_NSEC), the original code uses next_timer_ns directly. This can
lead to selecting excessively deep C-states when the actual idle duration
is much shorter than the next timer event.

On modern Intel server platforms (Sapphire Rapids and newer), deep package
C-states can have exit latencies of 150-190us due to:
- Tile-based architecture with per-tile power gating
- DDR5 and CXL power management overhead
- Complex mesh interconnect resynchronization

When a network packet arrives after 500us but the governor selected a deep
C-state (PC6) based on a 10ms timer, the high exit latency (150us+)
dominates the response time.

Use the minimum of predicted_ns and next_timer_ns instead of using
next_timer_ns directly. This avoids selecting unnecessarily deep states
when the prediction is short but the next timer is distant, while still
being conservative enough to prevent getting stuck in shallow states for
extended periods.

Testing on Sapphire Rapids with qperf tcp_lat shows:
- Before: 151us average latency (frequent PC6 entry)
- After: ~30us average latency (avoids PC6 on short predictions)
- Improvement: 5x latency reduction

The fix is platform-agnostic and benefits other platforms with high
C-state exit latencies. Testing on systems with large C-state gaps
(e.g., C2 at 36us → C3 at 700us with 350us latency) shows similar
improvements in avoiding deep state selection for short idle periods.

Power efficiency testing shows minimal impact (<1% difference in package
power consumption during mixed workloads), well within measurement noise.

Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 drivers/cpuidle/governors/menu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 64d6f7a1c776..199eac2a1849 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -287,12 +287,16 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	/*
 	 * If the tick is already stopped, the cost of possible short idle
 	 * duration misprediction is much higher, because the CPU may be stuck
-	 * in a shallow idle state for a long time as a result of it.  In that
-	 * case, say we might mispredict and use the known time till the closest
-	 * timer event for the idle state selection.
+	 * in a shallow idle state for a long time as a result of it.
+	 *
+	 * Instead of using next_timer_ns directly (which could be very large,
+	 * e.g., 10ms), use the minimum of the prediction and the timer. This
+	 * prevents selecting excessively deep C-states when the prediction
+	 * suggests a short idle period, while still clamping to next_timer_ns
+	 * to avoid unnecessarily shallow states.
 	 */
 	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
-		predicted_ns = data->next_timer_ns;
+		predicted_ns = min(predicted_ns, data->next_timer_ns);
 
 	/*
 	 * Find the idle state with the lowest power while satisfying
-- 
2.52.0


