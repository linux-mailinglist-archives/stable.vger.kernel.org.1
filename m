Return-Path: <stable+bounces-241657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PMwG1a58GkyXwEAu9opvQ
	(envelope-from <stable+bounces-241657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:42:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E2F4861DB
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FC75313BF37
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C91E3B19A1;
	Tue, 28 Apr 2026 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KliFUdeM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E612CDBE
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381462; cv=none; b=TKh4nspDMAgdgHc8r0zXqQzc5KwtSsNjTkeflFgZzEv1WjiNqevopceWw2JnbCGJ2IWSd1zX4xVyI9ebm3sLiV1i+lVWvo3Ex105yHQaG5Hr1dsrcK7gYb3uae4RW7ojq8uoH6tHTTBXSacOmdO6vHbaXZqiyNRFty9604UVx7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381462; c=relaxed/simple;
	bh=yvfWbNsf7kvzImbLhP8AA1uE2RBdkUT+264nPwInwps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+XIJXXVVX8dFKEcyhylCb0eyk9LHe2qWiziulKxhQm9Z2gXxdw/uMvKsbXbqSMh4tYHv455I9bfLoiu2w6Zaa2zMi819T/yKarxEMPvwT8j1LZN/YZH8wxj8KHCuDWRAN5mzx3fh12svziyBJ188Hlq133fpqbN4Ief2S50TGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KliFUdeM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67790429f71so5607449a12.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777381460; x=1777986260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvfWbNsf7kvzImbLhP8AA1uE2RBdkUT+264nPwInwps=;
        b=KliFUdeMkJ+CQ6Odbn4kNAS1DOmHwGlILKqT/xzQs6Tk3jXJZ3ssU44SCXNTVWOoQn
         2SYcdyU5OFNg9mHMgbWDVNPPl7fK9Qa7JfddxUZ4qq9TB3CPwMs3+G7YOiwqNQeq7xFE
         u6tHppJdtye+WKwnGTfeicjG+vHXWQtZcwcV3QGxiAQ8y6kJEZKuxd7+EAXR3hWpwhgj
         0A+0m9g8VTzJtI06q4gQ3xxFT7iLDOWRd7FqKYNN3vyLNh9NmF7UXGktIyPnintfhWRE
         KcgCd2U42DW/PvHSagJB+MpzJsXqW9Dg5nfJ+R3EP5mlIs04xeizaNkS/NHlVmWw9T38
         kuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381460; x=1777986260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvfWbNsf7kvzImbLhP8AA1uE2RBdkUT+264nPwInwps=;
        b=h4QjKsM7gK9BAAMuOpSO9czdH5mFsw9EwlA02Ume5LLjFkWZWJ2ZcyxDtgRDjG4e0z
         T6IBo/23mUUCUZL2pvT1MoStJbeHQzgcJeFjQrpPPBQ02YS2VJTY2Xqd8hcEK7qC7PJY
         tzTU/+kw/rlv0S+WEjzYbZaNG/IdhDCFfEg9ThFFKWnmXwGPyiLH4w7bRZDamc1RdYkh
         gCQbEaTwAJCG5X23tAYsZLNnx5ySt8W49SGEWoEmnPkQELMPU643cx7CVlu+X5UyuPhL
         9oWyifT8jCJZsmPEouGC70qyhYBbRCi7OsYd27WfX0yS3OnLRAJpoBLjUygcnfJbJwLE
         cptg==
X-Forwarded-Encrypted: i=1; AFNElJ/MeZowRmJAQuKfBhc0EAk+WlWGR5KLI3I17HEFKJZVZKajxc61ylIyPVcgV+RAkH8NqSMRL3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSu0oj9P39Sffc3AuHUlDlboMiES5kkl4n7SO1w7h6fPaV+cqq
	lqh92JkaoA6+PVq6zIE2ShR0/Fr3/4l/8ZVQTXoj8epIklnp4BlRuUJhpbGFluRUtJQ=
X-Gm-Gg: AeBDievlsH0pNm+3Q+J6eVigO5d9blIgFyvtVI+kcugz58IoLalHm7l+4eIAYmmZbqK
	uUUys0SY1YiuSwawvV8ujfUsXwwNE5vMp3foXJGd6hGEV44PHoPwcikHBvtdPRIU6GNWEzTubku
	D9oDJD1z7M2mh2uv8a9kCI1Xq1o3vYat07untYQnmeSFI9IiDNxpHX16uq+lcpl+hTwRDoEAesJ
	t+qAAdPEEJif2sJxObcKQE7Ud3tLh5er33sfQ4iYDGPgDNvCTx6nKV+rRMhY4B4YUsWerMJyHWo
	8zX7rP0xiB3jhHkLcRtElzU6RJer+4Wngpzvi4XFXllxQSm7w7n0BJYA9OET2BAGePnrGewQa+m
	S6mKYl22scZlfnRr4XpI44lSGMj2d+LWwJ3bfzLnnutUZyL+JgpZj4Bg8xcHM9gFnPqdIqnrLMA
	i1P07jsmnc+ZAoMQn1JeCoSqG46U7xvXmFscpzlg8qeVUv5GmT2pk9sA==
X-Received: by 2002:a17:907:9454:b0:ba7:e3ee:47a1 with SMTP id a640c23a62f3a-bb8018dccb7mr182160466b.4.1777381459520;
        Tue, 28 Apr 2026 06:04:19 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b685290dsm754196a12.24.2026.04.28.06.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:04:18 -0700 (PDT)
Message-ID: <60f71fd7-1079-4936-b4b0-9d45a2c112ce@linaro.org>
Date: Tue, 28 Apr 2026 16:04:16 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] firmware: samsung: acpm: Fix out-of-bounds read
 and infinite loop in RX path
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com,
 stable@vger.kernel.org
References: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
 <20260427-acpm-fixes-sashiko-reports-v2-5-1ff8de94a997@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260427-acpm-fixes-sashiko-reports-v2-5-1ff8de94a997@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 04E2F4861DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241657-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


FYI, I checked sashiko's review on the set, and I shall act on this patch
and extend the checks for tx_front >= achan->qlen and add zero length checks
for qlen and mlen that were read from SRAM. I'll do that in v3.

The rest of the review feedback doesn't apply, so together with the changes
proposed in patch 4/6 that will be all.

Cheers,
ta

