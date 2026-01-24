Return-Path: <stable+bounces-211442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IjMGl1tdGkx5gAAu9opvQ
	(envelope-from <stable+bounces-211442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 07:57:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE997CC33
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 07:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 572033009F90
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 06:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938B42417E0;
	Sat, 24 Jan 2026 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl/IPlre"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1603B1BD
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769237848; cv=none; b=H5aUTHZy60o7l4rYk+z58PWSs1iYGYt+QkrsrySmAJuFJWrR7mVWKbJf2sdsbs2DL6rjFKFfNXf/HD1wNgejdxeziZPhrNRYx1tDMnHuIuZ5YNzfi6hnY1YYB55lXneegr9aPguj4rRA5/BEzQXjkAW+8icWPBo9FLTAol+QJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769237848; c=relaxed/simple;
	bh=cC6e1KioY41c91yijmGbSSfZ61Ovdtzrqxzxhm4vNOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJMvG2+OeCK2CBYRSyGVjtMYB6ISL/Tq9SKRlwgqSsY7VLVonwMcDsMPmg469NgXOoGShn88M1z89znhuV+tsgmtG6bbHXgX1kQVHhBth9CFwCPHL0gYBvGry2lPP1bjVq4dGiwOyan7qsV7Wbov2bV9/6+a/dxzycGtkqa2E6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl/IPlre; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4688158eec.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 22:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769237846; x=1769842646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zUgdI+AQs7RFvCShWYLUQ2AaO9+6oR78cTHkGs6KEk=;
        b=Cl/IPlre8xHPIRfyps4l4tcTCHh3y09WS04WUM3o8GqmAQkgUl2ARQrqE3ITu1oBK1
         xZwrKlTlWQbWM8LofeXevhQeStf2vMl4qsNUt4z5QamzP1Bv/RXyUakpV2BpQ7t7d5yO
         N61UsKR0SlgD6e9Gd7373afiOcH6sm5vBRz4V3nD2ZxY/9QiEqn3+VZXjJu2KvZvqLs2
         8w4KDb3xBi4ok+qqy65zIupoBchINi8q0aIfNH5CIS6JBgJ09d9Hic1IN8eSsyjuCImF
         uVClqdZFNq9htSZaZhveATPIRWa8LVN894tYagtu1FbMMK1I+rL9U46SMRmK1zbB8GPc
         0kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769237846; x=1769842646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zUgdI+AQs7RFvCShWYLUQ2AaO9+6oR78cTHkGs6KEk=;
        b=NYVCgbFg+4b/HHpxBhfoQR1CTRyEK/RtHdEHB3jPLlO+XJkc2kO3g4pgupDJC7ZXaY
         8ofcC8+QfHvDKK9/E9XxdN4MGk0Om88uDdj3b5zhp/GAoqc5JsKv2Rac3GV9FTVwRo/2
         im3HanHTxx0lfY+YZbV7PM4ZKJrw+ks7RfPuucx7H1t6VY9ts63dAL3uzZJZOmgR2uLP
         cKmGzA6x8FC3v+LTyfTievbWRFd45L2uzQA6velD1TQPnu5xkmYc/hPnEBNowUoTn5Lr
         9CpWjRD672f88BbaIskFj3fsucLSVhgnWixrL5HwmNA6KWaKLsqbHbFOrqvhUNKCSzqG
         9MHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7fT+kbiNZeF1RkWY0Mj7kNXQW8FxyG5uhwb7KkmdL2Sv8FYDnjTP3aem5vO+StrpWybbgKxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQiOakRWBOIApZDER2PKckOSPMXjDGj2PISiiY41ykJX1YbPb
	3cPz1mxRNlJgqZWVI1dTX2uGS7M8UQixntqFMpC0R2YBXn89cOxPUH5G
X-Gm-Gg: AZuq6aLnM0TMpAiMYoFXOkjskFn/TsgVdeoUYBekU7DsTR7QX9CKqzOssrUqg44rHKv
	7i2g8XzV+fkpXNwMxE3Q+c1y5qoZ7Lvt28OjN+KCYa4cdJ/UBm6RqVbUJqLsMCw0FdPdSurIv/y
	HUBrG67FKY5XIrV/3EONCJNnS/+/+z3BJZosj8TKXLJFVXEo9w/kWDEcPmy4R6fp7X3qc9PDa0g
	XrFJ3HoGYNuahrjHNteOTGQZw3tXPc0OT1iP20P90uaVVTw54s8CVwwr4Fj7b2laAngmpBqldkx
	E7+YM0QLQ6+Zp82SspmYXdoHKvJ23iQnINJkhvhdw1pixDfFVv8H//js2Dx0xmyYB22CT6XuK+d
	g+HGxPNq8RMwehGMqEwQOuZuXl4EoGdqANl0lj4vd8HGB/HHeQrz6GL2W8bkto4Mt74cvAttPd+
	9csh0=
X-Received: by 2002:a05:7300:e60d:b0:2b1:7910:b0f9 with SMTP id 5a478bee46e88-2b739bd0c1fmr2553928eec.42.1769237846080;
        Fri, 23 Jan 2026 22:57:26 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6c47d5sm5852866eec.10.2026.01.23.22.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:57:25 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: dianders@chromium.org
Cc: akpm@linux-foundation.org,
	lihuafei1@huawei.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	mm-commits@vger.kernel.org,
	realwujing@gmail.com,
	song@kernel.org,
	stable@vger.kernel.org,
	sunshx@chinatelecom.cn,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	yangyicong@hisilicon.com,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn
Subject: Re: [PATCH v3] watchdog/hardlockup: Fix UAF in perf event cleanup due to migration race
Date: Sat, 24 Jan 2026 01:57:19 -0500
Message-ID: <20260124065719.805144-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAD=FV=WHWrKS_LVjod6nhnPdEk9_ZqeubGpft3PJOUJNMbBxfg@mail.gmail.com>
References: <CAD=FV=WHWrKS_LVjod6nhnPdEk9_ZqeubGpft3PJOUJNMbBxfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,huawei.com,vger.kernel.org,kernel.org,gmail.com,chinatelecom.cn,linux.dev,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211442-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDE997CC33
X-Rspamd-Action: no action

Thanks for the detailed review!

> Wait a second... The above function hasn't existed for 2.5 years. It
> was removed in commit d9b3629ade8e ("watchdog/hardlockup: have the
> perf hardlockup use __weak functions more cleanly"). All that's left
> in the ToT kernel referencing that function is an old comment...
>
> Oh, and I guess I can see below that your stack traces are on 4.19,
> which is ancient! Things have changed a bit in the meantime. Are you
> certain that the problem still reproduces on ToT?

The function hardlockup_detector_perf_init() was renamed to
watchdog_hardlockup_probe() in commit d9b3629ade8e ("watchdog/hardlockup:
have the perf hardlockup use __weak functions more cleanly").
Additionally, the source file was moved from kernel/watchdog_hld.c to
kernel/watchdog_perf.c in commit 6ea0d04211a7. The v3 commit message
inadvertently retained legacy terminology from the 4.19 kernel; this will
be updated in V4 to reflect current ToT naming.

The core logic remains the same: the race condition persists despite the
renaming and cleanup of the __weak function logic.

Regarding ToT reproducibility: while the KASAN report originated from
4.19, the underlying logic is still problematic in ToT. In
watchdog_hardlockup_probe(), the call to
hardlockup_detector_event_create() still writes to the per-cpu
watchdog_ev. Task migration between event creation and the subsequent
perf_event_release_kernel() leaves a stale pointer in the watchdog_ev of
the original CPU.

> Probably want a "Fixes" tag? If I had to guess, maybe?
>
> Fixes: 930d8f8dbab9 ("watchdog/perf: adapt the watchdog_perf interface
> for async model")

Commit 930d8f8dbab9 introduced the async initialization which allows
preemption/migration during the probe phase. This tag will be included in
V4.

> I'm still a bit confused why this warning didn't trigger previously.
> Do you know why?

In 4.19, hardlockup_detector_event_create() did not include the
WARN_ON(!is_percpu_thread()) check, which was added in later versions. In
ToT, this warning is expected to trigger if watchdog_hardlockup_probe()
is called from a non-per-cpu-bound thread (such as kernel_init). This
further justifies refactoring the creation logic to be CPU-agnostic for
probing.

> I guess it's implied by the "Allow migration during the check", but I
> might even word it more strongly and say something like "The cpu we
> use here is arbitrary, so we don't disable preemption and use
> raw_smp_processor_id() to get a CPU."
>
> I guess that should be OK. Hopefully the arbitrary CPU that you pick
> doesn't go offline during this function. I don't know "perf" well, but
> I could imagine that it might be upset if you tried to create a perf
> event for a CPU that has gone offline. I guess you could be paranoid
> and surround this with cpu_hotplug_disable() / cpu_hotplug_enable()?

The point is well-taken. While unlikely during early boot, adding
cpu_hotplug_disable() ensures robustness.

V4 will be submitted with the following changes:
1. Clarified commit message (retaining 4.19 logs while explaining the
   renaming to watchdog_hardlockup_probe).
2. Inclusion of the "Fixes" tag.
3. Addition of cpu_hotplug_disable() around the probe.
4. Refined comments.

Best regards,
Qiliang

