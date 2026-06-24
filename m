Return-Path: <stable+bounces-268225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SahxK5ZUPGpDmwgAu9opvQ
	(envelope-from <stable+bounces-268225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 00:05:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B59486C1AE6
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 00:05:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=archlinux.org header.s=dkim-rsa header.b=G0Wxt0r2;
	dkim=pass header.d=archlinux.org header.s=dkim-ed25519 header.b=rHA48A4i;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268225-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268225-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=archlinux.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C168300682A
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 22:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A839265629;
	Wed, 24 Jun 2026 22:05:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA1B2459C5;
	Wed, 24 Jun 2026 22:05:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338705; cv=none; b=PdcQI/gkgr40Gq3iJ+HPQJKX04m8+bYGIcIETWRHgx0ccVg+cgm/oediG+IMHxwxwdsL16uCXrrvNoRiqkodMJp0liWkouuzKmqwPmypQTrdEQ981PpRinhIreFHOJAVa2Ts1oRZa44J2LqDSOOgwisAGYRoCJoXeON6K4WmvF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338705; c=relaxed/simple;
	bh=DzsGDJlo0P6UfxfIIVwaI4Ge4r3irh7jrVqwbjP2kbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8zh0BU4HtSOGgPsPW/saHFl42cHyQoYUbwazZ/LERwCoQ/BO7mWlNsgI7moOqk7oLq9/Qwyxb0rYJTtqKdZFUffvtzA4Ea0Hc3YK0Nkx5FLCSjairqIiiFNsvxffp12YxtLehVkuVPnJxWGIdoT3e9eXluEk2G3wi1NHN7+C2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=G0Wxt0r2; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=rHA48A4i; arc=none smtp.client-ip=95.216.189.61
From: Felix Yan <felixonmars@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1782338701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRHXdpLz3bOfMCjFuHufEqTdHRjLCSuPmqyaKfN5Y1s=;
	b=G0Wxt0r20645tYPp6uRdYV4qaOMahAPpt9HIEZEhBJUZ9LvB0FRD4Nv7314wJIPfugc7Rf
	tFNq6CPbfDbHkjRjlPBeOTgzl/RF/toPHCNmRuNpRK5bc4+dLqA+i3Sa+LD8vuj6F50xJz
	KxHRme9PoF/TNfHzHYSJwaDjHSBTorQFY6txaMUiNd44grAIEIi32QqhL8Q8kA7yMVOUe1
	QCdvInGQwnzKT53O6Up7CdMkhIvcTNXxoxMGAdOebFw9NAzWrcjO+0Y07WIkEt5QHLowV/
	EUOZIWcXgdIDUYyvvtj1qxjwzEkBTIkTEshM4FxV5LrQ4qXoiOzIXvW9n0CK70SRcH6iRM
	5e44m1drrrfIOPjiX0XH1HSn1OV3V+EZpIhMW/bjqQPcVpTnSyeXYKqrdGEFijVV+Se2EC
	BvK/4ewxXjp0+yFE0VKd+nt4JEwRTwIY3FWFi7+egV80xo1+2bLUQ5qc+WoeGxSoOfT7pF
	xthcPBheysDSoRCc/xMYBtzuSV1013HjhQA6eI4kyKP++nGvZJByScfOXs4J/EzLagyWHG
	KuTSDY/GLnu8BHjF6a/57aVuKAllVv2H4EkdNlvp7qe58Neob0jB58xgbStpx6O9Kka3M0
	jzAWsSGnIaV4y2D+HsdEzRrMP/DT80ZGQ5LQS/rfVxxslJVuwrHjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1782338701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRHXdpLz3bOfMCjFuHufEqTdHRjLCSuPmqyaKfN5Y1s=;
	b=rHA48A4ipOYEPx6vlpsau0zfNunJTQvt1uNml7YWW3bqQlSRwEr/AuO9AlLUWNVGXnt++S
	P0IvDvf1UQDBKKAA==
To: daniel.lezcano@kernel.org,
	tglx@kernel.org
Cc: wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	indrek.kruusa@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Felix Yan <felixonmars@archlinux.org>,
	stable@vger.kernel.org
Subject: [PATCH] clocksource/drivers/timer-sun4i: Advertise a real minimum delta
Date: Thu, 25 Jun 2026 06:04:34 +0800
Message-ID: <20260624220434.4183732-1-felixonmars@archlinux.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CA+fTLhgLmTY+exGujKf8OYYQvcEW5X5NJ_5sLq2AYL6zER2c0A@mail.gmail.com>
References: <CA+fTLhgLmTY+exGujKf8OYYQvcEW5X5NJ_5sLq2AYL6zER2c0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[archlinux.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[archlinux.org:s=dkim-rsa,archlinux.org:s=dkim-ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268225-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,archlinux.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[felixonmars@archlinux.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:daniel.lezcano@kernel.org,m:tglx@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:indrek.kruusa@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-sunxi@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:felixonmars@archlinux.org,m:stable@vger.kernel.org,m:jernejskrabec@gmail.com,m:indrekkruusa@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felixonmars@archlinux.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[archlinux.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B59486C1AE6

sun4i_clkevt_next_event() compensates for the timer stop/start
synchronization delay by programming evt - TIMER_SYNC_TICKS into the
hardware interval register. The clockevent device currently advertises
TIMER_SYNC_TICKS as min_delta_ticks, so the clockevents core is allowed
to call set_next_event() with evt == TIMER_SYNC_TICKS.

That programs a zero-tick interval. With oneshot/highres/nohz timer
operation this can leave the next event stuck, which was observed as a
boot hang on Allwinner D1 after the clockevents core started reusing
forced minimum-delta events.

Advertise one extra tick instead, so the smallest event accepted by the
core still programs at least one hardware tick after the synchronization
compensation.

Fixes: 12e1480bcb49 ("clocksource: sun4i: Report the minimum tick that we can program")
Cc: stable@vger.kernel.org
Reported-by: Indrek Kruusa <indrek.kruusa@gmail.com>
Closes: https://lore.kernel.org/linux-riscv/CA+fTLhgLmTY+exGujKf8OYYQvcEW5X5NJ_5sLq2AYL6zER2c0A@mail.gmail.com/
Assisted-by: Codex:gpt-5.5
Signed-off-by: Felix Yan <felixonmars@archlinux.org>
---
 drivers/clocksource/timer-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index 7bdcc60ad43c..c2d04ab7cf2d 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -208,7 +208,7 @@ static int __init sun4i_timer_init(struct device_node *node)
 	sun4i_timer_clear_interrupt(timer_of_base(&to));
 
 	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
-					TIMER_SYNC_TICKS, 0xffffffff);
+					TIMER_SYNC_TICKS + 1, 0xffffffff);
 
 	/* Enable timer0 interrupt */
 	val = readl(timer_of_base(&to) + TIMER_IRQ_EN_REG);
-- 
2.54.0


