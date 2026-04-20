Return-Path: <stable+bounces-239978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBfbOhpx5mlgwgEAu9opvQ
	(envelope-from <stable+bounces-239978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:31:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E6B432E08
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 956D1302D61E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021D23ACF1C;
	Mon, 20 Apr 2026 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIlcHmwg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9283ACEE0
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709052; cv=none; b=ZpN6ZG/BniIrbNxBi7CGrOx28c+K1VwIZtqUz8IWx6UVXo6oviCh9xH2CmjOoQ6pEtX6EYc7m82PFB239J7VigFISGxzp1MMwh12cZY2Keq5+x6FfHQpsMfOOute/XvfCr3YfrSkoIyXH+uFVAGgmsaoa1JKTI9sXv0c+3TSU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709052; c=relaxed/simple;
	bh=V5EC+3U8AklyCgan+vJfwHlRkHMhPgczsTl3WMn/fDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5U13qxzjS5EUEL5wqNlDrPv0+dB3tPwBu3O29nhsyFNn6vcS2ZC70+8+6LSda0BE4iFpTDlUsmL/oR5vV7mow0fZcIDxmRfT69fHGnin7a58j2ywrwnjtPuwp8/Eifr4JGDHQaQubaY4pLA55OWLVoCluEjIxEzAdw++yDy8Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIlcHmwg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d424af6282so349848585a.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776709049; x=1777313849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lt/Z3RJdhJdXLDrfVQy86Oma13FPqwNnNxDceu5vR8=;
        b=XIlcHmwgLmJhmyueq5P+6fOVXu5Mq93+ZT4cdaaQNL5JtFq1cFuYNja6akSPDp7Ohm
         9uUMEyg022IbRmQaLXHfrV6P3VJ+df5Lr2YhQoQH3lxNEsE/GxrHx1RYO8PsD7iilaMu
         IDm6uW9ODad3RGTyHtwtk8ae3jEhp1jBuwwq3Vgv57ExI/tpLDts2SJ4x+11gNHc8O+N
         qUxmjqMYkTEJrY+al1UcK2HEKxXTL+2PaSAm3rqoDznJsIPW4hrYTmXs3qdS4sI7dm7E
         +iUGG/RzRcTOf8RVXTOeolgAVi8eSGHVyZoFP6AK0dR2ZKHj0FJQMNO9hSn2v0SRdRXc
         sLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776709049; x=1777313849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lt/Z3RJdhJdXLDrfVQy86Oma13FPqwNnNxDceu5vR8=;
        b=qa85xrPKQsKJbnwCbN5083kYyJ5ELhTZTJr7bMNWDUAM6gN3iY+mSxLLHrcvUK20HH
         S4IirWQIS6Jrd5/KPjZhahQRyS7Tu12dB+pq/GcKQjCYWbbAVvAA7SD6RB80Z84ATuX+
         2uEHKJ0KfymowO+7+QRgUV7GNJ4ccof6TpeUAhgEmzBpbHAXCU67uFRtch37oarJYdD8
         thShRKa7H06JR8RJOtmDSsF6hTw/bp2YJlkKKR5D4F2bZkqRKkCUK9Rdtl8dAdTt0TkE
         mG5DvErgzRFwBWlOxRNlNVI3Bi8Erl7XfhFsNVH3hSoS8YlWLqgEaAJ10mJWGzaTgBdp
         Ru0A==
X-Forwarded-Encrypted: i=1; AFNElJ/GmQvLxNXVQkUe+wybFEw4NR+a4WErBkfqzB0fdo0EOMCgx9s3QuidLnHpxOVyzm8BtbVLrPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVx0+3A9ik3EC/wD3jaMozd0nNWYgAjMQ/MwD00Sym6BnKNtR+
	hIJuD9FsUAUohbW4/uKA98or6A/KUiLw5/2Se/Irgln29UilNr4UIZya
X-Gm-Gg: AeBDieuSF78LEAkDO1ck2isfNmRJD2IRofj/mzBTVAkOAG9gwJSA83O7bCKQzqBPWq3
	WcTeaWwHHRQWcbMI1YusE9lqGWt1dtP17MHRrIkuSjamLfb7NrFFuLv+0bvkTAfix1KN7ckJM8h
	RXINdd+MztQlD0tqRc5YSe0pTk8LeVgwjrgMaXuEYX/Gg1ukjF/UtneMzdwzhOJMe2sa5CuNM4D
	hbUK3aKIoYCj1bR5B9rENQ0B5CSLiFZ7xUg2C5FV09PDcIsr86Xq2/1ifZzUD2cIn5iU7AoRYHt
	2rNplrAMxODZNA5qv2XIkMGWjVbqXfR/cc5dFDDx7KHd+OHGxCj8IU2bc0wFv4Z4xgrOtMrhoq6
	jJIoowZz6Qlv2EI4bz8h8jzgzK1/jo/rBahJUpYcKd9wnA5x+WKbW2z1sjBB5TA0Zoxm2IXwurb
	w7O1mVTCmlCD2lxn4VSHWwSAs0d6IiIEl3Qep6Af+4I6lj8lNirwHlAbvvBOSU
X-Received: by 2002:a05:620a:4554:b0:8ee:2c17:2ff3 with SMTP id af79cd13be357-8ee2c1733c4mr44142485a.0.1776709049110;
        Mon, 20 Apr 2026 11:17:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ae320sm990989085a.20.2026.04.20.11.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 11:17:28 -0700 (PDT)
Message-ID: <7cc779f6-3cad-42fe-a8a3-fcfcea581015@gmail.com>
Date: Mon, 20 Apr 2026 11:17:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 00/76] 7.0.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260420153910.810034134@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239978-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 27E6B432E08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.1 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

