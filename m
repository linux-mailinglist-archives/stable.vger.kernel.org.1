Return-Path: <stable+bounces-244343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPaKCWT8+mnjUwMAu9opvQ
	(envelope-from <stable+bounces-244343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:31:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D214D7E6B
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BAD83030F53
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355183E51D6;
	Wed,  6 May 2026 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJv4/28i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F23E51C5
	for <stable@vger.kernel.org>; Wed,  6 May 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056167; cv=none; b=A7V5p4S/r8h7Sbl5TIx+Lj77Q+QlNlknFZ7PlA0SaMFUaRb/ytEJga2b94guoH4VqHyACIGBsMG1nJv84w79LQNQ16f3ntpibf+Pz35055RcPhJhfndMF7erha86RWLyI/Cu2YJT21tof/IJQbhW2TI7nCUlY/+AVtoc+9x6te8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056167; c=relaxed/simple;
	bh=KNjDpuu2hwLIB0IxXf/2OHG10BiZJ+z4qaTrgnV6E6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dva6NxCbdXruZAEzlxyKw4v42YPIXQBaQkRuYjPXlS+7Ua6MwY71mZhaRlMjYFMyO5UrKkd0UPbJPkOmSCgb6rx+iDlxdQzkbve8kb3YKwVthqoYXluefTosDVikTwLA6rYWRngjwmf+xpIW3fEhcKeiK4mFCAhan2l+B0afe4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJv4/28i; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so57955425e9.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778056164; x=1778660964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNjDpuu2hwLIB0IxXf/2OHG10BiZJ+z4qaTrgnV6E6Q=;
        b=lJv4/28iUAmR6XxtA83Vk4dtDk4H7X6xPtswT7GtfKb6jVwsqklUGK2RYGO1DeyKXx
         U5rt05nn+YsQnqq9rj3DmRfruC9YYuHVrTgwugjj/GONJNcPSRkSU/YosBB7V4y265bp
         W5gaXGDe/NTSHeKp/r51YR36ifoiK8piRD/ikUUrx9sRhAFav+qWf7/rql3xs4gukLpd
         BGE1PzRkgrl5NYQdyIeCyYW2X/tac0nWPxJ9xhztctkYx3AIyUuwuIySJs3pjuCO1fBO
         Fi4i2cSpD7FRwKdQkAu8Au3TL5CWDP1TcTs/Vrjf8ayg9d+4cPQWxgrRSkYFKthPw3Il
         Z+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778056164; x=1778660964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNjDpuu2hwLIB0IxXf/2OHG10BiZJ+z4qaTrgnV6E6Q=;
        b=iAiLHZCt+8RxeH/I6bxXSp7sxd3Ej9+6gyTb05XzFMfWGalJQU/PaPtXRpoQy7ePkL
         PXCCx6vbnTc7jCRwVIvHLaSNXCFK2fEO4SoFXq6XbZsWKa0ylEr10Vd3wHIahUBbDx1K
         6j3YFS9/zGZ+VwdvqEdw7IlQRIWLIlPDkVpab5fC/tqDKrECQYMoq4H0RLDjqUpU47UE
         tzYzX5jC0hhsR7NHPwvmIld7DOcKipqPrDDndXFrGebxuSOnfRhh1llGqQxte6Su3/Fl
         UT3d4cQvkuwMEyWtS3sY/lqdjVGBcIgBlhep279BfIcJv6CFbL422kVnE+6zX6z0xkSB
         dHrw==
X-Forwarded-Encrypted: i=1; AFNElJ+1ryLdfWhCkTuOAWMulcMRWgMNo7GHVdYA+QzTgSlIJ8fkCv6KlvGGb1jmzjUlks1o5IlKv0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmBk1y6gaAbTReWyABS5kqGgKh67i4+fScW4wLSrq0BXjcU2/
	xBMyYOgXSmr/KXV69KDnV/Nehx8PEWZXcpoZUWsrIbxyXGBHdNfBxfUNQ49lQyfwRmU=
X-Gm-Gg: AeBDievFsU1hTZAfaG3WENzmKnP8+0QKLoh4Sf/CspyUnJz5Pz6Qsns8f9B5xEcHf0r
	ueBDwrsZqC88maSn0qfqXZVfe+dvAih8cx+SpVmIiLsBhVijLkdyFuvU9Yzej9Be/pp5M95RJlB
	l5l7n5NhR3g/mnMwv2hyt0Ejc6bSy+5xeKL4DMbf0rxoZ3+I6QqdBkGIJe4NDes4E4Bra2Pbwk3
	Egh/IFzCf46/ZBpUJ+hEFI+HIoyEKoj5KqYZDgG82Droov135vI5wFMYe8R1DHpvh9zQhI+UqmD
	lqUBTIIahXZBM2RvinkGKkqeEMqqmBZgdVL6EqRPdhHxjD+JvUoPQ2BdbkIn3pXiurwguysGuOM
	gMcPCUFDLOy7ddsv7m+vGGDD+gPfto5RuxTrjQGhEitMANurJHkR65+nZDtWXRSCi1HdQsYLq2j
	nPTbNxgIsosdNbRRPMKNDqgVmG63d9Y9wVy7pFVIzt3QM=
X-Received: by 2002:a05:600c:354b:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-48e51f32a7amr41967685e9.17.1778056163955;
        Wed, 06 May 2026 01:29:23 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02abbsm10276212f8f.18.2026.05.06.01.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 01:29:23 -0700 (PDT)
Message-ID: <8dd42c4d-2cf4-4118-b2ba-99670cfc94ed@linaro.org>
Date: Wed, 6 May 2026 11:29:19 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] firmware: samsung: acpm: Various fixes for sashiko
 bug reports
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com,
 stable@vger.kernel.org, Titouan Ameline <titouan.ameline@gmail.com>
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 46D214D7E6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,linaro.org,google.com,android.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_FROM(0.00)[bounces-244343-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:mid]

Hi Krzysztof!

I checked Sashiko's review feedback on the set, and in my opinion the
set is ready to be queued. I'm going to send the cleanup and the
ACPM TMU helper driver patches now.

Thanks!
ta

