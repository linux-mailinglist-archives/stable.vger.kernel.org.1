Return-Path: <stable+bounces-232577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HUgEaY2zGn7RQYAu9opvQ
	(envelope-from <stable+bounces-232577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:03:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F0D37151C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B2E4305E402
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F763F787D;
	Tue, 31 Mar 2026 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LQXq8Cf0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4882F9C37
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991002; cv=none; b=dXvQ+dln2tAYnUxzPAmGzdBOcRUyTciR246nuy9Ld60ihJfNBHEdAI39JKXrD1gfI9JoMJpHcdTSFOFUeQmQZmBT2JTZzn5bEbc4vEDR6tAEekDm/z2g8Qj0kJJJ6FMKveuTWxIaMc+X++31Ggga/s6Zl/EpCQQ+/S6rAVZcWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991002; c=relaxed/simple;
	bh=Gt3u96Z/RHWT4uSpKJTe+1AoRa/kukWjUHnXg95ZC44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5UbnyaxIb88rghXEiLQSa6QzEnScTTIbkqgstQ0N38I/7Kvgc2I3DfMuQ0QS7TjjfmJnZlateugrIZ2W9d7ajWH/VZGRoLouWp7hm/kyQvvPkKKFySxEPM+FtyIYgsdjrb3bRQHluQWl+M+NfCQLl+NR8UsOgmg14SyDCQyx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LQXq8Cf0; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d55b97f358so3821133a34.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774990999; x=1775595799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1ynKJA2ZMz+n9z+laV/KWasvwjgNqFlNU3zkpu9Lp8=;
        b=LQXq8Cf0o00ceLn+KhlYJuoQKNomXwMZlpaNyT1a5kr04yAs1ojNUz4Ix7ndT1exW3
         DSeLgdM+jBgEsMBxJHpt0jveGjtSVVFv2YuJmDQD4S8+FJJlFuGbxlOLRDV3u7XO/J0J
         gpp7z7gkb7Y2anhLCogPVzyqBpmUuX8uSUxW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774990999; x=1775595799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1ynKJA2ZMz+n9z+laV/KWasvwjgNqFlNU3zkpu9Lp8=;
        b=KN50I7c7WSk71+NlACQzAg9G0KKgvVzL0PiSkP5vVZtY4jNaKODY1D0k2D3jEwiUzQ
         pAaOqdQXcJSDkuUCcSBj1tAn+RZoG3GCqUzwmSKIgnP0eDYV0OxM+fmQoJTwTiLzVuoG
         SL24powJCZiznM6acALlk645vfJMAEZPJwGwn8DeKm/OQUF1beYwiy4vfTSi9vIWF907
         xhAuYRj9f3C3lb002EoRTYxKtynT4/466NmwTr3x0YViyqdw7ahGFmAgA+2qFceeO1uX
         WBzWVBDOO6gBMUHFHk1OtfP+DRnT7sRQvu350HYayysKIauEhYGsKVxfWU06Dylo3Vvy
         Yc8Q==
X-Gm-Message-State: AOJu0YyJlxxFy43z2xyDOrGXHKm3qW8peHIMV41bt/CzIsFEhPe+dm3z
	CdibXwCMonsI5enLMmoWTovbrwYkBaCVE17Ct0WQBPBbXC2J/woXqQHWNJMC46u1bcK/ScBI4Xy
	sTbnnaMo=
X-Gm-Gg: ATEYQzwVBa0T4Ra1emn/EBhvQohiwpbvjOxRx8xPA1mySNdihcmYa5cSbGUTkCotR03
	70bHVggVu4JIWRuY2hxqtWX8fSG87kLKzfcl27+WRsxBMziEB5Ja4Xs2UVToW/Jp6WbepzXfOK0
	jEsbEVVR5+e4bntS51M3MefcYH8kvSoW0EGVEOuM2ndSRGngQSjkBneHzemJFVs9hYUoKm+CNn1
	Bz/fqacBdXlDCk3549Gy8E+P+K+y510xbA0K8Iy2nhn7Erth/lTdDY8lr+4ty1pZIc+9HzqIcWp
	1NVfVVvDYqUIhrcXDkGxyPtt3tAEcY6uum4s1Y4jJZWAN0R56MYSrB0KwFoOTrG9kwthbN/MInc
	CfwdO/q7z/BvNEGOox8D1WBW+2Iy6FX0wAUeMLNSuIics+lgP7ijLMYdCQb8HLSNdVJ6I38mPD5
	L8ieKb9rCR+DC9hi0t6mOr3TsJXyXyN0xVo5U=
X-Received: by 2002:a05:6830:67f6:b0:7d7:fba1:c767 with SMTP id 46e09a7af769-7db9942cec5mr900953a34.32.1774990999564;
        Tue, 31 Mar 2026 14:03:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a7b45basm9162649a34.17.2026.03.31.14.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 14:03:19 -0700 (PDT)
Message-ID: <0bcaa85a-7b7d-4295-9b48-afd983e7641a@linuxfoundation.org>
Date: Tue, 31 Mar 2026 15:03:17 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mqueue: Fix incorrectly named file
To: Simon Liebold <simonlie@amazon.de>, Shuah Khan <shuah@kernel.org>,
 Simon Liebold <lieboldsimonpaul@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260312140200.2224850-1-simonlie@amazon.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260312140200.2224850-1-simonlie@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-232577-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[amazon.de,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0F0D37151C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 08:02, Simon Liebold wrote:
> Commit 85506aca2eb4 ("selftests/mqueue: Set timeout to 180 seconds")
> intended to increase the timeout for mq_perf_tests from the default
> kselftest limit of 45 seconds to 180 seconds.
> 
> Unfortunately, the file storing this information was incorrectly named
> `setting` instead of `settings`, causing the kselftest runner not to
> pick up the limit and keep using the default 45 seconds limit.
> 
> Fix this by renaming it to `settings` to ensure that the kselftest
> runner uses the increased timeout of 180 seconds for this test.
> 
> Fixes: 85506aca2eb4 ("selftests/mqueue: Set timeout to 180 seconds")
> Cc: <stable@vger.kernel.org> # 5.10.y
> Signed-off-by: Simon Liebold <simonlie@amazon.de>
> ---
>   tools/testing/selftests/mqueue/{setting => settings} | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename tools/testing/selftests/mqueue/{setting => settings} (100%)
> 
> diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/settings
> similarity index 100%
> rename from tools/testing/selftests/mqueue/setting
> rename to tools/testing/selftests/mqueue/settings
> 
> base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c

Applied to linux-kseftest next for Linux 7.1-rc1

thanks,
-- Shuah

