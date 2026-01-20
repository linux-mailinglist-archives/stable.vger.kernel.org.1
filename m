Return-Path: <stable+bounces-210607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBKkHsf1b2m+UQAAu9opvQ
	(envelope-from <stable+bounces-210607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:38:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F16994C62E
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80108B06E55
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC1425CED;
	Tue, 20 Jan 2026 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhUUf0n9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149F421EFC
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943852; cv=none; b=VUQ6ANWDPtqmNyRFK7ulbLoNYT7c3O7Pyz5XUZelknuNQF9dyB3hsIQIJdBNMWRTuqBDFq/LML/M8AvrjdqkFIKiaM+J5BldeX3P23WUXNtLkZeHRbHNdCBpz1FIQmQ030m9JfKzOiukwdHslS/GJWMQjDs8n530aGIE5N5PZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943852; c=relaxed/simple;
	bh=wSNBtjMm+V2IMmq80iy1SYwdosKesmUsLxmEQ8W4CfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPJPL+86Rm6py8BHIik1TVRi38oWVTHQzwlPgzLT7niNKQWVh8gg7l56212TiExgZoiQ35Zld8OR6ZGlLf+qlq8y9n6os0yAskDo7BCjrC/dRDZAicEaRxq5QPipaYnlE3UP7Y8c2NfsYblN+XmZ2afnH5hKSlfqqumrF82LEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhUUf0n9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so32131535e9.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768943848; x=1769548648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD+qh96BuStlVCr6m9cgS9Z50cJM3b7YbGlN1ubHWWY=;
        b=hhUUf0n917x45y0PUHXNQCb6JKigOyr7PIpiMiE/1W4vLvKLmAVVCO8c5rosGGZMAY
         xvyA4PoFchSNa59ayvA3aqhEX9uQroi1tRsFP/dLOoyPPVVk7xA0iJ8AGSEXlL40mdHd
         IhbMJsb2HEcT9/jgzkuiG/zHJ65GYiV2LozkMPI16t05Euz6biDNMichHhr1+EcHhGHK
         AaA0WSl4yEk3iYx/wFvwAPI/l4osEvDCKa6H6IVmGrjo2VN7D+wamNAPHxr/QDZtvGFA
         7TUwWq44uBwUHv4T9nvQOj+k1sFq/y8J4AONng7KQ+WcSegnj3tVDALmGq7zuMtV89NM
         mCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768943848; x=1769548648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GD+qh96BuStlVCr6m9cgS9Z50cJM3b7YbGlN1ubHWWY=;
        b=Idgr/5fmmB9ZQkFkHwrGTcjkVdQj67rDe4XXcE7gwRErC6JUSqhAMf9C0y5nrhIyM4
         ESn++TUZCob2xHva4VAc5yH8UALBq/GbWN7eQmT8g5n+k68NFYIN2bU9+pgfB26eL741
         9CVsir2Y8n1WIQ0VVwND6gPxrrAwDdYpQM6KeWd2J+47O3nvDEARyDzHXIQhL4jWs/eo
         WmVLs6qYmhOMQYMwDjNwmSXdQX4mSqYjjdpBGJnGZcfbMQBjEb/Bb+FEekbNjCuZeMvN
         kiiiiTIhAOyQPzIKIcb+p/IDD3XpCSJi/x+AAFwwAWaI9V35WYMr6LzOkUkhE407jz4B
         WBPg==
X-Forwarded-Encrypted: i=1; AJvYcCWp//zTI+NeSEBBfXGSoeVh1IUAQtH89zuHr2b9ZBXZxTfp5w1jQswvj6glxA0231MkgOBkMFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMz58vQefq8+HECDx2c48hsNWsod7DzERRJSNL8FzS7oYp3km3
	BSZtHGbdHrpCT+NY8XDnpd2fDpqysoW72sOhtUCXWnS7BgSAQ0LsYwow
X-Gm-Gg: AY/fxX5LDP0M/je5SEbxk944py75AmO9pG/V4unXJz9xrNwkxhLgFMndmMi5DcBA2Nf
	xue7Gq+oNz0uoHA7AfFDdZf5bJVTBdwITjnf7IM2CZ/X+RcJKLL45jHFi8/kHV+BcAv1dxxYylj
	RACH4QtRelfCSGRcJKDxfNAQZDI8WSHiLn0K4/on4kX1xwzq6bvNR6Dfh3wqt8UEjum+wG+9yQ2
	rTJwBGKuzQtalbRmEqytDPwwHfv0DG8tHmNvKldDjEiPJAahjQtcbEyvoitCs5jYJVKmQ1EfQaQ
	6DGgHErgi/nCQFoOhzU/bNs/YpPwpHp2z18ay5K3fB/bFZVN1lBHC4lcU/mnbjGREZaDnXYL4gB
	aU8s5DZtHdBZYJY2mn+oDkbfJupkhDxMB0f0Zdo+r6xyYbkshFCBk5NVoBCCRteekmOGlWLzqy5
	N7BHX14MUt8PQvaEASyRVymolGypzioIVop45272w=
X-Received: by 2002:a05:600c:811a:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-4801eac0cfcmr174219805e9.13.1768943848296;
        Tue, 20 Jan 2026 13:17:28 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:c504:d100:f54e:1a6b:fa97:f3ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2672d6sm329104325e9.14.2026.01.20.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 13:17:28 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: rafael@kernel.org
Cc: ionut_n2001@yahoo.com,
	daniel.lezcano@linaro.org,
	christian.loehle@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/1] cpuidle: menu: Add 25% safety margin to short predictions when tick is stopped
Date: Tue, 20 Jan 2026 23:17:25 +0200
Message-ID: <20260120211725.124349-2-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120211725.124349-1-sunlightlinux@gmail.com>
References: <20260120211725.124349-1-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[yahoo.com,linaro.org,arm.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-210607-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NEQ_ENVFROM(0.00)[sunlightlinux@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: F16994C62E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut_n2001@yahoo.com>

When the tick is already stopped and the predicted idle duration is short
(< TICK_NSEC), the original code uses next_timer_ns directly. This can be
too conservative on platforms with high C-state exit latencies.

On Intel server platforms (2022+), this causes excessive wakeup latencies
(~150us) when the actual idle duration is much shorter than next_timer_ns,
because the governor selects package C-states (PC6) when shallower states
would be more appropriate.

Add a 25% safety margin to the prediction instead of using next_timer_ns
directly, while still clamping to next_timer_ns to avoid selecting
unnecessarily deep states.

Testing shows this reduces qperf latency from 151us to ~30us on affected
platforms while maintaining good power efficiency. Platforms with fast
C-state transitions (Ice Lake: 12us, Skylake: 21us) see minimal impact.

Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 drivers/cpuidle/governors/menu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 64d6f7a1c776..de1dd46fea7a 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -287,12 +287,20 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	/*
 	 * If the tick is already stopped, the cost of possible short idle
 	 * duration misprediction is much higher, because the CPU may be stuck
-	 * in a shallow idle state for a long time as a result of it.  In that
-	 * case, say we might mispredict and use the known time till the closest
-	 * timer event for the idle state selection.
+	 * in a shallow idle state for a long time as a result of it.
+	 *
+	 * Add a 25% safety margin to the prediction to reduce the risk of
+	 * selecting too shallow state, but clamp to next_timer to avoid
+	 * selecting unnecessarily deep states.
+	 *
+	 * This helps on platforms with high C-state exit latencies (e.g.,
+	 * Intel server platforms 2022+ with ~150us) where using next_timer
+	 * directly causes excessive wakeup latency when the actual idle
+	 * duration is much shorter.
 	 */
 	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
-		predicted_ns = data->next_timer_ns;
+		predicted_ns = min(predicted_ns + (predicted_ns >> 2),
+				   data->next_timer_ns);
 
 	/*
 	 * Find the idle state with the lowest power while satisfying
-- 
2.52.0


