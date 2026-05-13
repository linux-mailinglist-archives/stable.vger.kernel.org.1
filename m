Return-Path: <stable+bounces-247039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLAiOiT0BGoTQwIAu9opvQ
	(envelope-from <stable+bounces-247039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4009653B341
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C87723031813
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E683C9899;
	Wed, 13 May 2026 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="AaX1y2Gx"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D793C9885
	for <stable@vger.kernel.org>; Wed, 13 May 2026 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709538; cv=none; b=NNWzMyORmiHqh7A5PkgKFwPQYAgxeIakFKN/Kbs/Eiq4Lpa3syQ3qSCxOxQfroIw29lFON0lARtYKlUA/IvO4DQsXJ9UgxzCTNqSwDxIgC78QLCHG9mrXsgG2A4ejB8cm7kFhvae9VlZqnX0w1wbpKkBmxM5Ih01fG57/Qv+4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709538; c=relaxed/simple;
	bh=S/LePRUV5aauwrD2/aCKy5ZB6QqFqRXKBlmyivFUPpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGnLhDFlanO0kuS3bR1+fPiejMOMWe2JZuEXYKSv7pD8c76xJ2zwnm4vADO8stCW8Ybsy2XBEjTWo7PDyxki+apRxH3CrDFy5Tm9CiPh7J+Gf5DDYD15QKFRxqp5djCrmVxMuqTBxE0MxmTkIQEjqtux6BbxNds3dmVP+lu63u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=AaX1y2Gx; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ee990e8597so12441899eec.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1778709535; x=1779314335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTfDsttXTXW7TlK3rMWi2LRQ6SPJ5zcQ74dCRudTTV0=;
        b=AaX1y2Gx+zdVMSEuKM3WClkMwjJGH3bZZ5fyNTZu3M50vfBZkQsd2ucZVbjVpu3gFZ
         SpEqwSQxV30gC22KwE2Phrq9BFHXUTM4PpAhQQvAPZ3tb4PBjb9IEBN0O/astrS06Mlc
         mPEjzAJUR/J836DmH4e1ot24lRLiC9H9Sb3VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778709535; x=1779314335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NTfDsttXTXW7TlK3rMWi2LRQ6SPJ5zcQ74dCRudTTV0=;
        b=TcjV33JlbP1w78Cyy3Q5FJT27T8oxdECfMJtfazvRL/40c3ziF8ilgUWspwj2BvGNS
         s2zyGXUmZV9ozNj22z5HBGYc3OeycGQFXvSXsd/J+LRRLiWTyVPJlA51QnPbI3ywhrBF
         7XW2k1v4InlhSyteXI5Hyk3tETFIAjyyqyNNUFEocRy05JnnumOxIgon1agn7Q8Y0oF2
         mwJCbV9Tws5mAI3t7v/5wEktb43sDrsQOUL9CnHm6wuxUOIEwxFMX2s/iW3GUXZFygLD
         ulQNKMkztDM0eUHiZb5JQD59YQhkZzzENliK9jI3CVFEEGIxUiHj6xD7sQ15U3zeeaID
         4kYA==
X-Gm-Message-State: AOJu0YxxZdCMOXr053O5r3a/+h29e9zKlWCsb3E6XEkJ5XmKfOi7Oh2L
	wIkpEUbyK1grSScvH8eEtfbuc3IGkLip3LPZ5epJKB8WKkoabvHRiEgT9z9tk4EZDg==
X-Gm-Gg: Acq92OGP9zKefrLb4Nq30kebtF/vN1j4IWaDgpuCL3KAd1j5ZM/Px4FP+TQCQLpjm4Y
	jxoCWQ+aCxZOwaVnwS32Tt+R5LJNA6jg6XNdNGXBpZBOUAptttfpXoqfKN9ASUzpFOj2WQNgiwr
	V9MLEMGVJF5PLZl1axfEJGWK+VN8GK36YJk4sdRB+Bl8jP6XK2zPh3KtpQ2NgUbZlDSHqbTS+eD
	Gqt0qy/TpEvV/7RdbvFkm6SzP0fltw231nUzbfOClqOkPLuSP62g7Yn6RWCzf0KwK1/b0rsrSQD
	Mc9stCEr2VzuBkLS5Aw1OsvehChyETBPb79eVtTvK4sZL/iLMJ4oWC/FBoo0soqycuqVefOpKA/
	s/T8ruOBlukSH3ZODjfPv4/iFki4X8+gigSJJxQKZ84DhXM00Q8aijwAc1m3NfFu5v1flYzTLu/
	qjzVePa7fwKuy205Uo8zl+IIkyG/Ax8DIxLtfjJd6z6w==
X-Received: by 2002:a05:7300:e105:b0:2f6:811e:c840 with SMTP id 5a478bee46e88-30118daa1f4mr3316321eec.18.1778709535579;
        Wed, 13 May 2026 14:58:55 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.105.111])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcc458sm804611eec.18.2026.05.13.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:58:54 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 13 May 2026 15:58:51 -0600
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
Subject: Re: [PATCH 7.0 000/305] 7.0.7-rc2 review
Message-ID: <agT0G1B4cLWB4UKg@fedora64.linuxtx.org>
References: <20260513153754.934923793@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513153754.934923793@linuxfoundation.org>
X-Rspamd-Queue-Id: 4009653B341
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247039-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fedoraproject.org:email,linuxtx.org:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 06:17:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.7 release.
> There are 305 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 15 May 2026 15:37:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

