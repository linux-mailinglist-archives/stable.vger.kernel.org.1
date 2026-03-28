Return-Path: <stable+bounces-230779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENFOEVu3x2msbAUAu9opvQ
	(envelope-from <stable+bounces-230779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 12:11:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5134E250
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 12:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A27C303BB17
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917B378803;
	Sat, 28 Mar 2026 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MMZChxae"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AC387562
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774696105; cv=none; b=IC+r4NZivcOwYkvYXWYVIgm++qaRsPVpwf5ehIKhAMRiFwW9uYhrDbxErlGAyTmSmrF5DduMr0Mlq1knxIXe3xteImDqfaRD+hiBIbYzSFb2U7nbUElCz5cnEvZHgcYDBWhxpomViXmnqiWnLtyBnG3n4FJ/w5eSr3Ay6Hesz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774696105; c=relaxed/simple;
	bh=Jc86y6vosjJg43sZQ6yoIOzTYidLgFRcyXlsjXkBL0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LR174ZgjKd0nfkAv6eOWlxOYm4pVq22pi6oPSob7x96+iPjlYwUFWV6hoJphseFRUZ3fPgCDKJ0M99N+kXagnndLHIBnJm08ly+o8gXM6cilXLHoy+ukMtWleUMkht1wuUEYtF8ljdFdsJqhRxKHEG0DQbEIJZgsxJApFd8902s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MMZChxae; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-41bfec86420so689887fac.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 04:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774696102; x=1775300902;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BLF/+iTQ3iATILhR5zIsR9RzOGZ7FQ8p8aLXTNannDE=;
        b=HHKk9X2JBSax60vDNtYwE1Mx94LunRc6IW828j+IKRFHfm7ZMTbTMwjg+ulkwZhVmW
         t1ThV+aTlbPjDYpFZXJpIuzWv3GD89glqqekl1nb3gToU3NDHH+vDdcujha7echc0K/E
         wW4YY89minsqlX/sjMrY4l5CRcno47HEfLcNni2ZfBMc587Ori7GB8myLzDNKCkKbRQ+
         Rlv6FBNmgWM+kq642+u/yADgOEPTRiLC/geCTvGsh0o96WI6v4DdUPKv2Pigjg0IJI9Z
         myDjP8V+UOaSG/r8+PLXPmbyMVzlSKm8XQiT1atLRsis/qeY+1VjJtpc5vJl0K8y44rl
         Tm+g==
X-Gm-Message-State: AOJu0Yw6CpxxwwcgWabpHz3oFiDmy4IFtjyYATQ3t6Ofu5J7diaXqVy1
	OL92BT/6zPp/vvURvBu1vWXyeuYRtwYQ7A3liaHsj27C5A40f+ukf7cen960eacfXw5dHcoThMj
	kecp/8WUt4qE4a+IKPvW3MOkbRPpTB+GSO+SuLwfq0AjSatUeCLFkTnIgQ4WkAl6tUfrtocs7hN
	+Ltg/UaQbLDJUfmxxJ65rPWczU74C4i12yYvJtkNJxPnRBKR+zKnnRlmD+MQ0hBzxHCUxrh68q6
	7nde/1q87O2x3E=
X-Gm-Gg: ATEYQzzQoXB9qSCxxSA9fwIUa7p7P+fHYR/cQgsU0pl8PBhPcESC0QRCqMZmcZdoI5s
	gnxBATxIi1XUA8wCNJM5/u7Uwiz5/H33r6dAmjONBl0fDWBtWmeg863ORJI9IPs2g+GyI9gdJz/
	9HknJb3o6fDlymRqYw5WuBV6qRUTkbAfc5h24EAFQRe8ma4WPwyR9gEYkkUEQUf3mMxW3Tf3aKm
	5rZ+8vo2jG69RzEmHKyeAAx/JzxdvbhM5p4nqhbEQbqseOdBfPNdnoRWQwT/7Z6FadaSHvoylMp
	JQp7oYp/+IXw+7HLH8p+B6VZb5ZJNfvJOITP3Q6Wtgbvak0OwpCKFfLIqwTz5DmhKK4uRemWILP
	ChjItKwe7nAhOs+pyxI5qdaORZmfqLQhCdtjIJZmXZJRuLW2Ute3EtwOoKBA0zuOlbYnbXfcain
	ozH4rGaKM9
X-Received: by 2002:a05:6871:5206:b0:404:31c3:9b8e with SMTP id 586e51a60fabf-41cec0f6c1emr2905162fac.16.1774696102102;
        Sat, 28 Mar 2026 04:08:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41d049c0459sm341450fac.5.2026.03.28.04.08.20
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 04:08:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b941d4b7f2cso384513766b.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774696098; x=1775300898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BLF/+iTQ3iATILhR5zIsR9RzOGZ7FQ8p8aLXTNannDE=;
        b=MMZChxaeWRlm55HlSzZGZnz9wnYJRolYkroSB2qMTeOsVl7zUxZHM1ZlH87jK3OsiK
         WDSeORGgS3kdgol92j7XHhr7mWpt7MP4yD8NIjoHUA3sliUdfyeTdxM3pgGY0bW9DjCc
         xLAdHgrAp7jM9DOgs6K19fbR9xEWzMlqKxiG0=
X-Received: by 2002:a17:907:1b17:b0:b93:9ac0:7913 with SMTP id a640c23a62f3a-b9b50569823mr422290066b.35.1774696098004;
        Sat, 28 Mar 2026 04:08:18 -0700 (PDT)
X-Received: by 2002:a17:907:1b17:b0:b93:9ac0:7913 with SMTP id a640c23a62f3a-b9b50569823mr422287266b.35.1774696097499;
        Sat, 28 Mar 2026 04:08:17 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1e438asm64253066b.47.2026.03.28.04.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 04:08:17 -0700 (PDT)
Message-ID: <fe3859ec-c799-4b05-bbb9-897765269252@broadcom.com>
Date: Sat, 28 Mar 2026 12:08:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: brcmsmac: Fix dma_free_coherent() size
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 Simon Horman <horms@kernel.org>, "John W. Linville"
 <linville@tuxdriver.com>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org
References: <20260218130741.46566-3-fourier.thomas@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260218130741.46566-3-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-230779-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9AE5134E250
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 18/02/2026 14:07, Thomas Fourier wrote:
> dma_alloc_consistent() may change the size to align it. The new size is
> saved in alloced.
> 
> Change the free size to match the allocation size.
> 
> Fixes: 5b435de0d786 ("net: wireless: add brcm80211 drivers")
> Cc: <stable@vger.kernel.org>

Looks good to me.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

