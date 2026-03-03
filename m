Return-Path: <stable+bounces-222822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE6lJ3ObpmnfRgAAu9opvQ
	(envelope-from <stable+bounces-222822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:27:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217921EAC42
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0AF9312D1B9
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46462388E4A;
	Tue,  3 Mar 2026 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IFQBrGM7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E03388397
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526124; cv=none; b=LVoVNBEvXaTAekjxCPAe8A48YPWik/jx3mSkGX53NWbiQXjR1rzW3p+lgHI9nO0aui337QVk48DXdY27FYQqjtTXPdlGAwuWrVttRWxxAQZcXgLFt0/O7pHwg/CCrFvLGgPdeJt2qyxxnLf2c2UH6UXQzbIVZr1uobZOchty/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526124; c=relaxed/simple;
	bh=PUFB0NUQZXnYOsuV3qEWNxl3eeGZ5hBfVsFaZtUzQO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM11pNkWJgwBtqyUM337iMs0RWc1aAYwzgoW2sqklOPKDK5k8oCSSbPNfHvmid4YOa+vxspKK8GL63+9XwfFXCVPBbMPw8jIeGmPsQ81FYOv9T25Y894bugSdkSDgJvtpy0TubR6/JNoUkJ8kumn8s1U1epNBu5dnUSVBVQLaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IFQBrGM7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso36781045e9.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 00:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772526119; x=1773130919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=On50ef0D99xDSDSa3UlsoEDTxBrrk+dP52qqCJlGCsQ=;
        b=IFQBrGM72zkGvPdk3EFMkMHAVdlma68NoVpVb86mP8bQ7qht8l81RkEpu5rX6FRi+Z
         CX2geSVsJoiTOkAGOw4EGh6ngR/aRLA6l/YXJ63l7gyhJFnzlyHRjMpVF9lIxmL18+kc
         WsjxGf/DNP58Ses3KYh0ESCqbj6msAjKouW7vwQ15gnIsLYIek1sxtDbLp8238Ng0Mxx
         VcmRKswQJsbw/JQ0RW7tYtPRh8LqrAk7fyiHOxH3GFJFxH0BN7GfgQROtyiQBMYihWmr
         HgSoDeRhtbA5fx2eliz4+mhCaYXUTQIosVL6OBrbUBl4U8zR8lb+ltcgQb+yhzYJGhVU
         Uh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772526119; x=1773130919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On50ef0D99xDSDSa3UlsoEDTxBrrk+dP52qqCJlGCsQ=;
        b=V/n0UWIjt256hpzwZie6Ltvr0bnH1QrF0OEctoYeN0v3twPVz3uTLWcdzwP92mobuE
         iDG4wLpiTDrPS73EwwG9BVdaWv8UkujBvQbrzn6GuwxVNb5zn8Qvj/+HN77Xbf4EtccA
         rQHhthDJfQmxVPsEoHHmzA1MfPTEj9o1dUN9X22afrxTvanHK0/mGDk3LXK9a3+XYMTC
         dBECizZd1le3gAGf6rJt0ELqfDBZ0hazvYjtbBOYbLJTiundhMATsgGGqLNIHOzcPxfD
         aGyms7DCvLMn2LC+E7AwX2DiGTfT7hFRp0XcPLtt2hdYhCy+yENKZi9Svk9ar2OUsIyh
         693A==
X-Forwarded-Encrypted: i=1; AJvYcCUOMOaAE8FiCglk3hIXpm5cjSaFVFjy3KoeYGC6JOfUqacz3fBLwE/C6dii42ksWlI9h5gvwBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytr5kB+UXeVjcuwknGRJToa3oHg/gUNC6t+ywWUUSsyfDO9A1J
	H2DOCXvBjT/SV6uwQ8JTTQlkeY4zCaOB6U0X2pvdwuvU6mULJqwOGefQ6MczyeAaJCY=
X-Gm-Gg: ATEYQzwgcsOVN5pZpPDbZiQk7f99cv9VJ/094+Ix9gBdLiPvexcJww5QCfeit9lOEki
	6hHGtaZiW6Xmok1luIt/t5yfHyj8T7QvXzZhUWoBGp1v5G8p/bLJzs+9wln+2rLSNqM5CnXRvi4
	5zhUBN6oXpYP6m5CaBbP9JI65miYNDxwe2FCEYx5WuvX/DaEuDovXykbfrD1+DiWc7wnB/ILAuc
	jJz/yGzAvFwBoNsafSEJD2QzIiHMZCjo3Wa1jq8hkjFZFVAissE1WPKso7H7qn8zjJ4NDCB6cpC
	tvBW47gEg+/jf6EbC7U+uMCJueTZilfgCIpLhn6Hri7ger3pJtQf+foOtWIOav9QvWP2yhrxWPR
	rr3aPzPUzYgoLXmz8yfVTQ5JDeRP4A9kuNFXX4z+NOPL1ccxNRuEQ9TniK6XNC1yghEF6CwRPsI
	8rTV21UitN0Vb+SCkAqrE=
X-Received: by 2002:a05:600c:648a:b0:483:6fe3:bb49 with SMTP id 5b1f17b1804b1-4851370354dmr23706105e9.0.1772526118662;
        Tue, 03 Mar 2026 00:21:58 -0800 (PST)
Received: from u94a ([2401:e180:88b0:32b4:4c71:af95:b813:9623])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa806295sm13805656a12.16.2026.03.03.00.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 00:21:58 -0800 (PST)
Date: Tue, 3 Mar 2026 16:21:51 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/956] 6.12.75-rc2 review
Message-ID: <d3mqwnyunzez4fh5mtaevb7wau662m7kvzpl3ykwgcvdvulosm@al3hgsanxu7r>
References: <20260302160918.2520730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302160918.2520730-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 217921EAC42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222822-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:09:18AM -0500, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.12.75 release.
> There are 956 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:09:04 PM UTC 2026.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/22590800040/job/65447954928

[...]

