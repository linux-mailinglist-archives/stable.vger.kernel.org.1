Return-Path: <stable+bounces-217339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MMyKttglmkTegIAu9opvQ
	(envelope-from <stable+bounces-217339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 02:01:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2943915B4C3
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 02:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C27C3023A5C
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 01:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781A230BDB;
	Thu, 19 Feb 2026 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="HNWCwC45"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E31C8634
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771462865; cv=none; b=oYCXv90Q00WIZEj4fwzhjlnadZhZwtre9/dM+f7t44KmafYnL1slvKatmSpn0akdKV+7X+qbBMTVDtBrfqQUWhuwRfg9R7CmeVDW5RFHP02f1JcvKUY9X75xyp+remCnkC0sNhLhReUooko9zM1sLVhsxKXsxImEKTOQzSiltv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771462865; c=relaxed/simple;
	bh=/rklSOklVShg1Ms1JBgLGjAYt0RDT457jMUSWB7x1yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrUcch/1hosORb7/ELo+tWwOumY7qMGRCBrWkl2jqE85y/ivrevahhUkA+RHocWUL3E3r1DTyeY92CbWYIWUOoxAFbFJ2gVOGbJPXnChLjINVbD8jy8sv1UTMBR/WF6nQIArF+2RNKBpyhsUyU3RcZtA09WiUkzFfIPPnPEM/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=HNWCwC45; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1275750cf9cso381130c88.0
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 17:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1771462863; x=1772067663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0fIigkPidDvjSh5Ky1RT8qWJY9gJmCvsoqlzOL20sI=;
        b=HNWCwC457m6KlmtEJ9vKCkfGO+JPXiWRRnpkPTlkMzDDROao7bsvFemNOdllFT2sgB
         quI7gokVcPPYaq6Lo2CCJb84q7HE66UmbjZ+xPqWUuQsnh+w40uFrfbwu+WEXzA9VGVD
         Gli8t4D+akqyRj4z3eIEj/qOCtNTX8h3DedvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771462863; x=1772067663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L0fIigkPidDvjSh5Ky1RT8qWJY9gJmCvsoqlzOL20sI=;
        b=wSvRw6/56LorvyOXC0ev8j+jJ+y3sXeqzReyRtfH/XXe9lEQ+DJuUnb2vMwrfE16nz
         QSo2hlM/wBCUeg0PV7Feuzqo98Q+6pP3DfCTQXMA/YEpcQBV4Jd3LGcy8Q8BQ1lPztQZ
         UVf6X0DyxgzI4Z8ljUnblWHHOsW5fJ8sKPTXGudcBkKMzDKv1IzQH1AAYIPpVBX11aRd
         ggyjPPUkk5LcMpR45Yf5NCXFzdLgYUAQq6yfAc9jg6HU+Ysu+ur8qsCcyhK1J1K1+ERG
         3W62Sz870luFW6Lmi2xEhc/oLEqZc4e04lydeqyq3ngUaMcEmV+kqbphB43WMEw844w3
         9dEQ==
X-Gm-Message-State: AOJu0YzZL213EAAcH/74uDbmocV6FGh0Rjb85nF6Qe1+xTDNjEB734rn
	xmJTdK6+UGI2DaWMLi27sshGkjgSZECCPhMxvDTz1jRSGySumEGyeQEGio/k9NwPoA==
X-Gm-Gg: AZuq6aKQlGYJ3GKDHRT+9pCIw3MLB0kpSs8LM9aW1nFdYgkhTTp0JycIqEOQF50kUAS
	g+88BcmRDe+80LjMv63QXNhyN0s5MSiVyREpelEC3VIKHud/A3SIiYGRdToftA85aSbybk/z2u0
	N9qG9Y37oB4stOaRGyvYiv6owYeTv8zSmnylIhJFBvUbvvyNJiCODKva9EC7A9SQcCR5wUrP3ZK
	ESRQ15FioVp4P1pEcXfFBQ/y2NyKw07YmUWpNB6gqCSt9BcbjIJO2L9E8DADN7UUyZYPoAsxZPy
	guYALOTw2erVIsJjA/G3SPMaybfEix1sF9p//YkYasKAq+5ZfDbC1ZZWd2RiyDofAvI2wvsqk5D
	rPWVGOWDA75fxpC1M6wNFmc74h5zjwIWtkoTfCAh4GLpsYWEqN5Epk1Q8wHp8NjB6Dlh2uh+Gx3
	3SPPNnOQKzq+VnTPbOvWIvq+kcFogY0apKsJTjgEdg42Hv
X-Received: by 2002:a05:7022:f87:b0:11b:9b98:aa4b with SMTP id a92af1059eb24-1273978ef67mr8632200c88.6.1771462862759;
        Wed, 18 Feb 2026 17:01:02 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.123.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c64282sm27112268c88.5.2026.02.18.17.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 17:01:02 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 18 Feb 2026 18:00:59 -0700
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
Subject: Re: [PATCH 6.18 00/43] 6.18.13-rc1 review
Message-ID: <aZZgywN8tickS007@fedora64.linuxtx.org>
References: <20260217200006.470920131@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217200006.470920131@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217339-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fedoraproject.org:email,fedora64.linuxtx.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2943915B4C3
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 09:31:40PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.13 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

