Return-Path: <stable+bounces-222466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAx5JQM8pGlnawUAu9opvQ
	(envelope-from <stable+bounces-222466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:15:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9F81CFD80
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31370300AD68
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87A3329C78;
	Sun,  1 Mar 2026 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OdlzmlSl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7F329361
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370914; cv=none; b=T6vz4qVi5m8kh5GXjgdyQtCDiZj4efdYu3DOE8N1P7IeiO8s2Eojllf8kJAJCuZAAjJsOYGHneM627mSvQVlPm/5REyWDCRh5OtIealTDDZFp1pI8mYADkSqDK+m9+nXZpjmTO3jBxS4veaX5fXpank2qEJ7mEOlPfYCIZ5n1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370914; c=relaxed/simple;
	bh=Yx1iWzXbketPlLS3CCBPgDy4YcUQx0fAEoEhNdJTfOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVnuPZvMHh+V8KH/u+r6EtZicWT1kkCvrbhqYJu6+B9hPMcvMGnj8VupIdd5T98Oz9zJK4JrxGWhF8Fj8W4nGUep2PvtD5/VBHcNmceouiwN/8XhDyKnA+48sjFvr6RGo6J303ooWjjDiM/MKp+0/5EcXBgAhgiSBQxmmEqM3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OdlzmlSl; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d1872504cbso1111988a34.0
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 05:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772370912; x=1772975712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJzjlOqnmdjDf8Tf1+clY7nIHTFcfOsSR1qI8ztRNbo=;
        b=OdlzmlSlXj2Y5lnEjJ2b6YFyHRFTuhlskT4vNy+RURmO0NPQa1YdvRrYqHXVgYvfSa
         EJRvE/BCOHyTJ5tXt7UU4+ebBxB+TZ0sKBsQgP+qTWNhBuR2WHEMfCbUazxaRKN9Bz3l
         DNQ+UsB2y0PQIXQxQNkIsxu56ZYjTy6vLe3W/CclH+dGFVBsVue8xNiSDHLqJgir0rQD
         cG6P1bYsCFCzsdER6NWWj9Dx6GUeL66XCIJ0cvtE6BMXdki8YIcgXkH3b2JDm6WhaomH
         u0NhJ8jzlNZiRrhwvXHTCbkb0drqvZ9HiSdWCr819ess/dmG88aWC0FUIe6nyE0LQxsR
         M5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772370912; x=1772975712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJzjlOqnmdjDf8Tf1+clY7nIHTFcfOsSR1qI8ztRNbo=;
        b=ag4rwx3UHsHoHSy8Hdc9cEIqxQ74Xg6pJjmHbufdNos+dM9Vb7o4vrepmX7pqRiBwt
         FHp4Xl8CnPvrnWvVhXd1KGozBEvciDqGjSWgWIYCWUcwqo3hIug26T3DA+u5ItEAy/3k
         dc3ozfMNkrBw00yr1ms21OWSV5MM8Mno/S5ake/Y5E/yUsyD54IkfjiPMOmdEM64/ioF
         rYCxytn//I0rDkVj25TrwvX+fZUChazkxed2iEsjFSnwAtCLAfkuiMG4GNzZ6PkStsEN
         jJlbREKIzXT9GwQ6Za9rJIIaj5Cs4yo4Euuu/VVYpoz3pA0OVdTWMhRPzN+wM3A9POxR
         9f6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJsb/WJJnsoNb64tyzEl9NCLhi3OtNadimW/JmT6kWHfHGZaJFFlGBGh5qmSwVWM8iOZzND+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFY07FJh9vGrFcZdb8PaUMQfyP6VAz60pso4PUKJ5+XGHFAgOF
	T6lL6Q+Ypbv552gFBPyK1v3MlYP6sAKrQNQXvdXr6r2HZvGmyMtu0MhXX7hUkZak4rY=
X-Gm-Gg: ATEYQzy9C9AnrP8hSODPgpEZpc8150g76QJ9xyrhPG05LG0kZg7NS2pWb/Y58W0dRZ1
	gBD3rVo+CfJk6DmVG54hdjg5/gisAWl+A1MFNmepuQzu56IBut29Wg5g0mKOsML+R4av+pFpuSm
	bTjN2FnmzoIiB99fljIZ3jWs09fKCzXAKjVoQWmGn2zTOxlaua7JvtEk6PkQZVxySCGBmfFLcG8
	2SHBEZKjt+r7ZR9gcvBB8HzrltPTu+zjCkhqwLE608CSYHMmHAcVYULl4TNPAziiEEk4hXK/epS
	AIOkbaPkE7ONG2r73rEOtPZPvJhDLiUBbQ1BLbGur1NSfRdzt5nIDTf4DasVQ8c0w4qEgqxfM61
	GB6ZxpkZCEvqJOuNL3KTHEKijiseOOfkZUNBo3JRgHtRteZge1NM1bs2c3zruR7CEADXLluFu8A
	RKJmST1/NCs0nTiegUm93ejWwiqofowt6KPbMRv3GDdVLJ86Qw6/yWjex6q1zPHCPWCXoyuB4Gl
	njABHrkTQ==
X-Received: by 2002:a05:6830:6583:b0:7cf:d14c:ca0b with SMTP id 46e09a7af769-7d591e52b43mr5376382a34.4.1772370912085;
        Sun, 01 Mar 2026 05:15:12 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ea95sm8487349a34.28.2026.03.01.05.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 05:15:11 -0800 (PST)
Message-ID: <eb41b6f9-08f4-4972-99d4-3340571830bc@kernel.dk>
Date: Sun, 1 Mar 2026 06:15:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "io_uring/filetable: clamp alloc_hint to the
 configured alloc range" failed to apply to 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: io-uring@vger.kernel.org
References: <20260301014717.1711200-1-sashal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260301014717.1711200-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-222466-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid]
X-Rspamd-Queue-Id: 9A9F81CFD80
X-Rspamd-Action: no action

On 2/28/26 6:47 PM, Sasha Levin wrote:
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

And this one also picks cleanly into 6.1-stable. Not sure what is
going on at your end?

-- 
Jens Axboe


