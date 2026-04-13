Return-Path: <stable+bounces-237639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KPhNQ4/3WkubQkAu9opvQ
	(envelope-from <stable+bounces-237639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:07:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2A3F274F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C91A6301152E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B42D39099B;
	Mon, 13 Apr 2026 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMjQYVoQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498D36E493
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107168; cv=none; b=TiKV0neJhsPsEMLuWvUn5iyLAn7i7Pd18Lj01FsUleDKhIAtqLdCgfxthgPNhZYTXMYTwGNnV1uh6k7hGpI/bpoD9O5Dfl49tlGHrAc7BVNJ25FblAz/6EgM7oxaUDe+NwXH9XdeEqQqzDajzOdvABKUtEmjth64nQ6G2Fc1gOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107168; c=relaxed/simple;
	bh=DHvTbgVBW3hw/f0a//QlChJQ2MhY8ExqMLSzgMSMh1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jqi5JlB5cnaaDl9H+FxWsVGGb/YLCkX8vmsLexlLVQmrJLzGzF+QwdqOdNj0xpn+qCAdxNeVdJ7Ow0nd8BnIxvg6nuLB50UPwQnSzaIkuKirx5UX/V+SNXzpWG9LX7hlPTouseLEooP8SYRG4Em1oRU1TSIKEd29EQrBlQIfdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMjQYVoQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4888375f735so46662075e9.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776107165; x=1776711965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+CMGgVpbGSFYrtIdzPvzmGJsZQ3Z4zuKxslghksSgw=;
        b=PMjQYVoQvJS0lEJXD+gduttFbpf9YGCLB+jqy9chm5CX0lbGKs79Vk67stAZlJ4ol1
         72lv2NbplJWcHBWPX7OSQE4Jv+Hm8R92uWGg1e3bk3Q/gt19QIAg8fATCY/b6dgipneH
         Lki7TNIJhGNEHhzmdkVXnPS1jA5UKrfN1if9mwbQUCFnGG8/TP5n1i5+Nu/DfAtMEaz2
         rPzTuS9uAZsIwOF4qIvxHTU9SxXmLwLt5pfnmBndokQy0hC+7wrgmkh3fsrc8mGklTX9
         hqmdguNwWyzh+W+fLCbR4p/RGnkgI2iZyhU8V7NaCaR5kh3oeRS3yYBCJtEvsMfPJA8l
         iFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776107165; x=1776711965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+CMGgVpbGSFYrtIdzPvzmGJsZQ3Z4zuKxslghksSgw=;
        b=CW5+rzQBc6va/goGjH3nhA3HxyL9v5BKriF5rAIr3gb6nv6jvLl5VNVxkTsTSBksxz
         +3FT7Yj300udKNURMrRDIWVd82sD8Z3YwlDx35O4aZVVi3Y6DQd1TFU2Eiuft//4YO0V
         TeGm+S2PTx2sX4Ygsieut2cQz3wEnas9Dtvyr2/oA+qom6zFOAHXDVGsC5KpbvRFT6Az
         bdwA8OylHPcuItjC8T700wfte5mudH/QpFPee4SBZ6PrUundBJYCiRuV1gYjGbeuA+7k
         peX5wjAV0uEzZQQrLs8CEzU+C5V48O1u6IY1C5T4V5IANbYZndFLsxQUG1p75pJXqsEt
         kusg==
X-Forwarded-Encrypted: i=1; AFNElJ8aoI49efVZeIocgIdgtC09//zZnO2uPA2w1Jxczv/ByOoGLAAYCSPyo7VA60eRb9nO9hk5zzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+E2g6SNzR+W/yc+JVb8lK6ldWi6d6K4AfbVHR38XyDYSG8WEg
	iWRkxWIfuc3E535cnWzO1cbfq3RCA95E2RuRbEppoYgzM4aX4D0h42vm
X-Gm-Gg: AeBDietPBBYMCLmyZUMltPtqciBKL15h9aXCXlovMDL3pCIK2UZr0YlR5wjMUNZwKTS
	2BVoUpJvNl75IyNKdYDWYotugFA+mmmXfN37P7Y5NkUG8Ii2hkMq7apQLPCAXjiQ93pMWhzGR4n
	JKAOiWcaSLrVP2f3M1Ie8WDbzB57uRu+j9X/JxC+AcrQrsvNeewtlDBa9dptX4e/e9jHjI0xT2H
	4vBv/d1WaNHJTCCcUCyzgybjSCSLnfv3jVzlw1nbWtbRfgN8F6FbKfZxjKYM1tvLiWmAtD9d3Tq
	tY5GpDAM5t+5gixrtJ552Em5T+41Rgzs1tzpLFR8jsAWTL3sRoqXO+osm57dXs9IiJW9+U0Ys7W
	LN8JRhMz87klmN6YYTX57G2F9S2X/Nx9rWq4QqiEXsPO9Qx520Gd+gLAOUawCS7brDRMYP7BAN/
	v9w8Mzzg+F8c85wod3ANrbqlen4dCYZPeSQls941NNBt8oz4HFxGb5IdOAQOgjNBNW3k38GLELp
	02swGz0LW9h
X-Received: by 2002:a05:600c:3b96:b0:488:b098:b653 with SMTP id 5b1f17b1804b1-488d67f0a8amr202216175e9.13.1776107165068;
        Mon, 13 Apr 2026 12:06:05 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d538c39bsm309952685e9.14.2026.04.13.12.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:06:03 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()
Date: Mon, 13 Apr 2026 20:06:01 +0100
Message-ID: <20260413190601.21993-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-237639-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4C2A3F274F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a tracepoint goes through the 0 -> 1 transition, tracepoint_add_func()
invokes the subsystem's ext->regfunc() before attempting to install the
new probe via func_add(). If func_add() then fails (for example, when
allocate_probes() cannot allocate a new probe array under memory pressure
and returns -ENOMEM), the function returns the error without calling the
matching ext->unregfunc(), leaving the side effects of regfunc() behind
with no installed probe to justify them.

For syscall tracepoints this is particularly unpleasant: syscall_regfunc()
bumps sys_tracepoint_refcount and sets SYSCALL_TRACEPOINT on every task.
After a leaked failure, the refcount is stuck at a non-zero value with no
consumer, and every task continues paying the syscall trace entry/exit
overhead until reboot. Other subsystems providing regfunc()/unregfunc()
pairs exhibit similarly scoped persistent state.

Mirror the existing 1 -> 0 cleanup and call ext->unregfunc() in the
func_add() error path, gated on the same condition used there so the
unwind is symmetric with the registration.

Fixes: 8cf868affdc4 ("tracing: Have the reg function allow to fail")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/tracepoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 91905aa19294..dffef52a807b 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -300,6 +300,8 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
+		if (tp->ext && tp->ext->unregfunc && !static_key_enabled(&tp->key))
+			tp->ext->unregfunc();
 		WARN_ON_ONCE(warn && PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
-- 
2.53.0


