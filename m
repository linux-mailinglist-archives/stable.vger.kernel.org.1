Return-Path: <stable+bounces-233156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGqHMHl8z2mvwgYAu9opvQ
	(envelope-from <stable+bounces-233156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 10:38:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B49392323
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 10:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BBF0300F503
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753236681F;
	Fri,  3 Apr 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9YaLMeR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92C3537E3
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205205; cv=none; b=Ensz/N2q9pIvAh1fS6bKqMExtEHoPDoQBJdVmsRc9K7Sg1bTQJgPwC08YUBKPDnjnYp06T/mp2yBxZpSo5ZG87rHkbkN5nxzgGoBadmFdhKLs4PpS4J027kHwJV1pt3ZDkEsVZpI/IHCbEJLVf+p9tMj0KzgzNFRtjUh9HvECNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205205; c=relaxed/simple;
	bh=DLsbyElg3cqs7sB8NU6Lf6TtGjjSAtMF30jU9YxsTkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbeJrkuRnEsBnNA9qI46rx47YYoX6dyzQKZ0+Bn+9XrW9WlmWCUEEBJGMgmla5PgvqMeFXaWHD3DaeulJchk1eum3Djsb83Uv0nMKqWcqNtb27fKXEQfTcVYD7cfTrYXFrLqF/0n7VMvJn8NFMHh0Vo2+/D6jmm0nFPP0qW/q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9YaLMeR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b256a4c6b5so9959475ad.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 01:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775205203; x=1775810003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6bWdEuhaXAxPBHptBvlmQsfSLSE+qPqms2g9XHTbnI=;
        b=X9YaLMeRTrbr+oSntg9OM6zwhHWxIlNHEalrr98Vm7bADf4G0/u1b7Nv7fOOjHXxIN
         gQXSQSYYdmlaxn0Jc1TiVkkseGknuzJ//h7rZfJfmLCp0PrGFTNONHkyG4DhYKlhBd/1
         O4vol7unmtCvxMEMSXzBxUAKJUXpY0RYPkL9fczY2hNClZfg6Rv0KcZogG8RDRZFty14
         o+9PxPOMZjgbGIEuDUNMvSZch6U86DLr3wjkvk3bD9N1T/a87IC6qFGNVYT1X2p7nsAl
         LtUaw9ZX24SrIUDQEfgZ9xs5jRfnNO7vsn0zPzeoP77c7eeaz4BE3tBnkVzTBGC09/bS
         Yf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775205203; x=1775810003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s6bWdEuhaXAxPBHptBvlmQsfSLSE+qPqms2g9XHTbnI=;
        b=MnWITFgbvo5lZ1g67mdHccIumD8AAqbHp8Z0f5ujY2kBZoc4JkxXHvHian1pINazb7
         txLZ6lGI3G11rM5Eql4Thh9mbZGPuYqdJC1B5bT5PA6viEkJtMgkJMSiqScCLsNIm3M7
         HanbP2+LFUic2cFM4uHIMMMhgdS1qkoP79iZjNd17yUbrsgaM+zpsSkrIwMZtz8sJ8+E
         Dk/nFSqOQmFkbq80AAuhKeSAGh4Ju9bTyGeyh9oL7p3FjrD7J/H13YUWl5ov4eSjNUI1
         gJAz2eE0CyLetGwXlZUlDcrcg8rETZ2VohK4YoVvR1Tf5qIGpz5kukwFxzR/DTU5NpuG
         hUTA==
X-Forwarded-Encrypted: i=1; AJvYcCUH82vWTI9GfZHxa8FV62KfjVivwq3y7N4BKpqiuSLLpndocOYLfmvmyjbQoo/GGdW+2PENFO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHWp36Rj1owbI7zelEvDworPni2kGzVgAykfxYsWWix8kZZH4
	2GILRXT2UQ3yPLh6ySgPCknraww/CYvxPOO5yf6dlRWVgaMPppk5o23i
X-Gm-Gg: AeBDieunGTvqgecvPSdr0yW/SHMlyyh/rlI5mUkRisndLKC/SV8N6ikZN78NALiRjeO
	1LgPE1V2s9JnScK75+7/P8eBLR9lZokNvs/yTkGFLL9IdQm1Y8+ES+X7p1t2NfaWa4lZzehAnLx
	svuylbgzMOiKoLjGs9/bK0gdaWr97+1Hun7AB/WMKMwEorzqrh4uMgNYfOGkyEPG8XstbkD+ZYJ
	Gw/GBD9Yq2GLZ3+wHCmHc9AjCf7Vl5nDU2evaEEXHb3WyyOWhsPISGh1gG69KkzR5W3NMz5HtGL
	uKlo2gih+5lNEzBnBn1kFDtA5rv/VjiMBgOZpB+VU83G/sh6ePWvx3iucgQZHA6La7KLbduEuEF
	pyjcz77BevnSUmnK/kYh3GfDQ5PnnCz+nPPp+CB954UrAN+4B8RjUB/G7zeEiZnieSS/LwUYWHI
	0MkNr1NB5wYOQhPqIqk8jMYEH9mGKl9tjOicQ6yD0/USP8gfVYouY=
X-Received: by 2002:a17:903:1aae:b0:2b0:4a57:e480 with SMTP id d9443c01a7336-2b2817da2c3mr25467465ad.45.1775205203471;
        Fri, 03 Apr 2026 01:33:23 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d646sm51793865ad.5.2026.04.03.01.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:33:23 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	stable@vger.kernel.org,
	yanquanmin1@huawei.com
Subject: Re: (sashiko review) [PATCH v3 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 16:33:22 +0800
Message-ID: <20260403083322.5852-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403052837.58063-3-aethernet65535@gmail.com>
References: <20260403052837.58063-3-aethernet65535@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-233156-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aethernet65535@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 29B49392323
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260403052837.58063-3-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 28b6de17622e17753e02ff606413650ad898f09d
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/reclaim: validate min_region_size to be power of 2

This commit adds an early check in damon_reclaim_apply_parameters() to
validate min_region_sz and return -EINVAL if it is not a power-of-2.
This prevents kdamond from unexpectedly terminating due to late
validation failures.

> The damon_commit_ctx() checks if 'min_region_sz' is a power-of-2.
> However, if an invalid input is provided via the DAMON_RECLAIM interface,
> the validation failure occurs too late, causing kdamond to terminate
> unexpectedly.

Is the root cause of this unexpected termination in damon_commit_ctx()
itself?

Looking at damon_commit_ctx() in mm/damon/core.c, it sets
dst->maybe_corrupted = true before running the is_power_of_2() check:

damon_commit_ctx()
    dst->maybe_corrupted = true;
    if (!is_power_of_2(src->min_region_sz))
        return -EINVAL;

If the check fails, it correctly returns -EINVAL but incorrectly leaves the
running context permanently marked as corrupted.  When kdamond_fn()
observes ctx->maybe_corrupted is true, it explicitly breaks its main loop,
terminating the thread.

Would it be safer to fix this regression by validating inputs before
mutating the maybe_corrupted state in damon_commit_ctx(), so that other
callers remain protected from unexpected daemon-crashing denial-of-service?

Also, does the DAMON sysfs interface bypass this min_region_sz validation,
allowing kdamond to run with invalid alignment?

In mm/damon/sysfs.c, a user can set addr_unit to a non-power-of-2 value via
the sysfs file. When turning DAMON on:

damon_sysfs_turn_damon_on()
  -> damon_sysfs_build_ctx()
    -> damon_sysfs_apply_inputs()

The code calculates ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1)
but lacks the is_power_of_2() safeguard. It then calls damon_start() directly,
bypassing damon_commit_ctx() entirely.

Since DAMON heavily relies on ALIGN() and ALIGN_DOWN() macros with
min_region_sz, could a non-power-of-2 value produce corrupted mathematical
masks, leading to overlapping bounds and memory corruption?

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da147786583..2747eef5919d1 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -204,6 +204,11 @@ static int damon_reclaim_apply_parameters(void)
>  	param_ctx->addr_unit = addr_unit;
>  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
>  
> +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (!damon_reclaim_mon_attrs.aggr_interval) {
>  		err = -EINVAL;
>  		goto out;
>  	}

Can concurrent modifications of damon_reclaim_mon_attrs.aggr_interval via
sysfs cause a division by zero oops?

The global parameter is checked here, but it can be concurrently modified by
root without subsystem-level locks.

Subsequently, the function calls damon_reclaim_new_scheme() which executes:

damon_reclaim_new_scheme()
    .min_age_region = min_age / damon_reclaim_mon_attrs.aggr_interval;

If a concurrent sysfs write sets the interval to 0 immediately after the
check, could this re-fetch trigger an unhandled divide error?

Further down in damon_reclaim_apply_parameters(), the code calls:

    err = damon_set_region_biggest_system_ram_default(param_target,
                    &monitor_region_start,
                    &monitor_region_end,
                    ...);

Can a data race on monitor_region_start and monitor_region_end bypass
bounds checking?

These global variables are exported as module parameters and can be
concurrently written by userspace.

When passed to damon_set_region_biggest_system_ram_default(), the function
validates the pointers:

damon_set_region_biggest_system_ram_default()
    if (*start > *end)
        return -EINVAL;

Without READ_ONCE() wrappers, could these values be modified right after
the validation, satisfying the forbidden state where *start > *end?

If this happens, the invalid boundaries are blindly assigned to addr_range.
When the region is later sized, damon_sz_region() calculates
r->ar.end - r->ar.start, resulting in a massive underflowed unsigned long.

Could this cause an unbounded OOM loop inside kdamond_fn(), where the
region split condition while (damon_sz_region(r) > max_region_sz) executes
infinitely and constantly allocates new structures?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260403052837.58063-3-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260403052837.58063-3-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail

