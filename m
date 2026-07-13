Return-Path: <stable+bounces-273645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aat6EQfHVGpbSwAAu9opvQ
	(envelope-from <stable+bounces-273645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:07:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 920E674A23B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:07:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=AHazjOTx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273645-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273645-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7768B3052B52
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300C0381B01;
	Mon, 13 Jul 2026 11:02:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E236BCDA
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:02:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940569; cv=none; b=B/rKqgl58aua9ERhfH2TIGwmbvYPjaFbUiQzVjIWcctROnVOM1igRyF3JS+grHQKG9XkeExBMTLYVQ1xHGS6qgV/YthmIG6P35RtaOeZxgII/7I32kFmlxIeq7KFZMb50vHNI1zx21cerplytJEMB5MtBMgZ0tuE1tMwHimdHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940569; c=relaxed/simple;
	bh=GH6CWop3wfi/VJkvt4cMc0bNyzCTH1KmyzTlNjCz/68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6+cXuxlZX/rJ6rQci2Z1WYGGIUCgm0hk3YcnA9GN45lZw7QPX/ymxn9erTTWuZyQ126LQJHe5/MtXq+UtD1z67MFkIpgjkhoPUjxEIC+E8PzpDDA5Syeq3aDHIFO8bfYIzYsIEJb4pFWNI3pk8jtS6XNOFgFphCKHMocktsmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=AHazjOTx; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1342268a91.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783940567; x=1784545367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWk91/IxILRwPoM0aUwUrJJrk3OrtAhlG6TmoK3LV2g=;
        b=AHazjOTxZXhs+0eTkazPjKH1+t7SKypGWHx0dKqpGI1DoctrYPpWB8KkXGqoVGqp9y
         4JU951f8j55I4rB5GlouCvpAUZSnXRCz1+X2Lvg1UemKndz5mYQIK2j2n9wq77Pb8IhB
         qcw43pAZAUc5RkcrODQNjhKN8lfu6FqHgRcKyIGPA5tlfK53k46Rhp1jZaaTNRAuBaHj
         lWSFKKAZ4cvD2jU9pjJR64LLRIWkSnsM9tj31LyWYwrY5hFnWf2bSMeKHzNnyiVFJrb1
         OijaweVRePRg0tgX0okuuAddUxy9fujbKEl5HWnDzEDxi1HFStJ9XNTNpA9iuWd2KOWY
         aSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940567; x=1784545367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWk91/IxILRwPoM0aUwUrJJrk3OrtAhlG6TmoK3LV2g=;
        b=XAwvyLplVI+/ZbSLLNkD9bmhSsPEyhurc2f5Bkwr+XWpGpMnJbyqrKbGN1MhqKDesK
         C86oj4iiP5Tm5S0G8LnDiE1D87ou2Y6o+Ruyl6nv58iTe56eg7UbjoqJU1luDKo8NJLL
         3xCvD1c5PkRJlY+MJ4D4KOHb4So34G//ENc+52MX+Br4vnyVStrq+NgejKgVm1HwBw8t
         YTV4ZMiNsoe6W6IgneDZjmc4IOBq9Zybrqq9D3C5beErR+jOO6M5KJu/+RNzOWyaoabW
         JGioOj5+JP1arH5NuVG9DZSO+RvrmLM6YKWFwa6tFc/Pj47uYXX7dS2GOx2Z060FGbqH
         r2mg==
X-Forwarded-Encrypted: i=1; AHgh+Rp89Oi6wDG3HmMzEz7xf7/CfndPW02dGQDjSqUfmsmAhYbKUhmEdvvmPJy0QuyjaA3Flf1rQIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49UiL2ZvgFvsSB+tkrKkLuzKBc0pODlaQ8Q3TraIkCA9PYQBq
	vIvOwQp1AfPJgS+c9xuVHxfBhPrlFZfs+aGQxVRdgHO9q8kbaCny8QGX2NKYXQk21ZI=
X-Gm-Gg: AfdE7ck/BWe4Wo23OqUt91JIsEncrA8+d24BXFob9l0XA3b1QVOWjMUDSOAQGFqgxDk
	9eTbXXoCA6uq5EyhqNEI3jJoBkjkqx+h1gLA3ZDqnJzazeQLjieyjUpDFziK6xS3oJkshh+XLCC
	/hB3/1cJIdOo+g6OZN1Ynud+Duo503B61hoyXSq4rLiPF0Lc/C/OSQtDFCZcsdGtZ1o8jigtvkh
	b5dbOiDOaUV22oOZfA24689JHseRW1MHhY8QhvKrqy0bOvQWP+Ymkfw6S9TrfU32JP89u6c3W9W
	7TcrKe5BNRLRVXRLgbG9nid37diNtZa8COn2sRJoQAIkEbY3qWFflWQXFj30AeYmMiXutm0qMxW
	fI1LXfOeGl1UE0/7Qhe2qe4EX+HXp6KztXhyWKZQB3dk56OVrCV80m+YDkNyX2iBkmAZVpxIN/z
	D8iYpKrWStFxW1taYMt2j2LUKzJ96xSMdTcn6Q+DraokB51Bs0DDOVkPJJz/9N934qgPDP4sELA
	Scz3iF/FPTpBuyJhzwUce6/pdzZjj3giLM=
X-Received: by 2002:a05:6a20:7491:b0:3c0:9c1a:893e with SMTP id adf61e73a8af0-3c110f7f4e5mr8654866637.70.1783940566955;
        Mon, 13 Jul 2026 04:02:46 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm52249087eec.22.2026.07.13.04.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:02:46 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Mon, 13 Jul 2026 16:32:25 +0530
Subject: [PATCH 2/2] platform/x86: int1092: Fix info leak in
 parse_package()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-platx86-v1-2-c8991bff03a0@cse.iitm.ac.in>
References: <20260713-platx86-v1-0-c8991bff03a0@cse.iitm.ac.in>
In-Reply-To: <20260713-platx86-v1-0-c8991bff03a0@cse.iitm.ac.in>
To: Shravan Sudhakar <s.shravan@intel.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273645-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:s.shravan@intel.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:nihaal@cse.iitm.ac.in,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse.iitm.ac.in:from_mime,cse.iitm.ac.in:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,iitm.ac.in:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 920E674A23B

Sashiko reports a possible information leak due to a non-zeroized
memory allocation for device_mode_info. Fix that by switching to use
devm_kcalloc() for allocation.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260710052806.100107-1-nihaal%40cse.iitm.ac.in
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Newly added in v3
---
 drivers/platform/x86/intel/int1092/intel_sar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index 7263114f0b3d..f506155f35d4 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -91,10 +91,10 @@ static acpi_status parse_package(struct wwan_sar_context *context, union acpi_ob
 	    item->package.count <= data->total_dev_mode)
 		return AE_ERROR;
 
-	data->device_mode_info = devm_kmalloc_array(&context->sar_device->dev,
-						    data->total_dev_mode,
-						    sizeof(*data->device_mode_info),
-						    GFP_KERNEL);
+	data->device_mode_info = devm_kcalloc(&context->sar_device->dev,
+					      data->total_dev_mode,
+					      sizeof(*data->device_mode_info),
+					      GFP_KERNEL);
 	if (!data->device_mode_info)
 		return AE_ERROR;
 

-- 
2.43.0


