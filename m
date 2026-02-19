Return-Path: <stable+bounces-217338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDk7DL5glmkTegIAu9opvQ
	(envelope-from <stable+bounces-217338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 02:00:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8770115B4B5
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 02:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C7D03043BE9
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38A5230BDB;
	Thu, 19 Feb 2026 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="FsDLbjf8"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897424B45
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771462834; cv=none; b=ZyTHwU6bfDio9nxK85+liB9ZBfy1NjXa+cOx3Bo4zApmIkvpG1NMejWDdj438ksP+5A+dOpB6X7YB98w9RD6ZF0CcFkaIiQTDDAUuTbvpSGjpXXdiccYn8mMXMOj4Xq/a6jbouTkta7oPO2Hy9gK8lvofMXo0PA9kAscQDEiVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771462834; c=relaxed/simple;
	bh=CrYGpZOdgx/VVNb7ESrBhqeXHHh8DU7h8Y6OB7fQVJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFLkPXjPLYmYpLYLMlWOmYy5ymLyXM7c3Y2WvGEx/9V6bk/411iJG7/aaT7l3gFm4PoqE9e2I6HmSneQtJwscOI4W2RfpjXh5M1vGV7Z0t9Z51bKxhq2QpTUB/WROvEk0q9MesQ8h2Vsljo+E7VIWwC6MzrFJktXrPC2P/4zhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=FsDLbjf8; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b740872a01so1013948eec.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 17:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1771462831; x=1772067631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HflinJnhMVfy7OwrOiRm9fnxuy0ODdINIjIvT2Yjqck=;
        b=FsDLbjf84YHoSkDAMFfET/2lInrM/7A3xKOOpYYaRpO4W455sRkdc4yYqK0ryNvuLp
         n0sDxDEFzNrK/oyAq/ie4At/CN2o7+pX49PU66reTzkx3COmwI4bK6yK8COHA+c3KIY9
         jn8Nc1fQc+D0dEZGTCU4282XdF+I49ggpH7Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771462831; x=1772067631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HflinJnhMVfy7OwrOiRm9fnxuy0ODdINIjIvT2Yjqck=;
        b=aVW9akMKOi66E7Fff8uFhrWqPdXrtVEkZIuQXAZobp2OTZl6F+LXfUoSwKumrGqcwL
         HBDY951jqPPKxRkzhKqDv9zAEhQmz0PUWesrTY272M/YxRn82E4kDmLbGhO2gNWJMoQf
         0vt59w4dNRME2JgooU4wgA5UkH1E56M5BwlAYcfKlsZ+7yVHUiWaEhk/1mz270OF7olL
         TOxqPv3ft5iEBWAQOklbL4cWGhLQzmq9lX207eRtU7OKXqSrL2s2KYnY3Sbl6RLw//zn
         +N+F5kPDDHEb7rPYixIeC+DMusvkH83wHj/K3WTk2/0TIjQXVeTcyXONiENQVIRL03kD
         z4EQ==
X-Gm-Message-State: AOJu0YzaUEr00LTSyUE+ZjpGc6SYsbeYVcEZAbIeVrxiO2R0sP9D/hp4
	VYkozoRbEeoh7Y3L4C2fGZNrvijTbA64ZJnpT3FExQLZb6t8Hbpd+bl1ifBbwRlz+A==
X-Gm-Gg: AZuq6aLHMjFZ0U+I9yAun+IzWZbVq1kjR8gvtSmferKsRW89ZNiNcYGScGWMjEIvwT5
	xfBZrqHQTbK/qip/nWD136qfCBLCdHDq94YD7YUN/5W7t8lVdO+Dy4Y/QKqvJVmIwf9EXkTjnoa
	WH5j1zRxrsePQfHnP9jVouqeZZTL4Bwz2NRns85gOVWbtmGTYHJDNZCR62aULndNFh8PFi+mICr
	c6/QzzxxdlkJWan48kUE8/95/BQdMxk56nNJOqAfRhGxGg2mvTZyoHE67bR5MNxdq/piUfCzhlg
	NU20K3Q2WYv4DjhJl+rqdquLCgapnKVDfEnByP78WWUdaxShSmJto2n1fwn3FXGIXVTpVgvpmwT
	gxqIA/Ybm/VTCgSm8oKNFxMBS2viSOw0yjih1y9svWFoc1q2MYdjfebXkaMHRh4wMg1xwWqj9OK
	frEvLMHXmEuqUhxBnaZldd+qONxi0NTiu/GYFX7Xc3ALFE
X-Received: by 2002:a05:7301:6091:b0:2ba:a341:5bd6 with SMTP id 5a478bee46e88-2bd5015e9afmr2697034eec.25.1771462831121;
        Wed, 18 Feb 2026 17:00:31 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.123.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543d80sm22788030eec.1.2026.02.18.17.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 17:00:30 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 18 Feb 2026 18:00:27 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.19 00/18] 6.19.3-rc1 review
Message-ID: <aZZgqwq7gQ2zaDTx@fedora64.linuxtx.org>
References: <20260217200002.683975158@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217200002.683975158@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217338-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fedora64.linuxtx.org:mid]
X-Rspamd-Queue-Id: 8770115B4B5
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 09:31:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.3 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

