Return-Path: <stable+bounces-219721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMlsIzpzn2mScAQAu9opvQ
	(envelope-from <stable+bounces-219721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:10:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930C19E2D6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 662D53029624
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995222D595B;
	Wed, 25 Feb 2026 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="gO/WmqVo"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5906A23EA8D
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057395; cv=none; b=nmi7gD7fRVNKQDPGu8213Q0KagKSTpq550qSpayh63TQgZN3hMDazzlQPdMWSq4xWzeNrKUHgRk2XkIngYVKdeQeLiHYAK4rvPZlGwVOT5WLostsDHc77+awfM10wdGSIuWXTYUt2JlbS+racD1hfoj79IEh/AuEgrMWzkmszTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057395; c=relaxed/simple;
	bh=+aqDKHQIoIo8BphXqOLU6XY00maoVWIt4iFouXDlyLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKbPky7WN3P1g6zYdzTYZiSUNDJzVTY3djLCEkWDzVg8CoiQDtRSEyaKYFb9mzMPfGk/bNDk9HwP3QmEWyVw+93V530lwgmaTs0iKxP2mLTqTULMjBC2NZqqcI8LenCYQYHfplWnnwT7ub8ScMRmwRO5Ps1WEu8vL7xbdtZEQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=gO/WmqVo; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdc8db07a3so181078eec.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1772057393; x=1772662193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G256DX+1yT0GNxn1ErCWSygmCOMRR9SHISAAw40zlyo=;
        b=gO/WmqVoKm/cDQEwwYN//z7wT/5pY0GasTGqgM6VTXGLzVVr1hsIu80PzjdK3HyLDu
         gc9HMJ4iyFg0pIsQNnDbglMg0LCP7JLILFyIWMB3HQpz1KzD4z/Zd+dCkMQs7Ud7k/Yx
         av3xPoc9l6c49IXe+kdsT6cYJofRkuFFm+A04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772057393; x=1772662193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G256DX+1yT0GNxn1ErCWSygmCOMRR9SHISAAw40zlyo=;
        b=mPPLrerJxM9R3yFlcioxaKnJnETVCjvJisz/ukYFpG9Tsm0F6DOpFsLfHH2oeQ3IdF
         PEC35e+Yf+cCMzWEhOpGCHCtvS0ipdR6IlnArsWVwqItkpBxVoSbZa4nkp7kEENx1bK8
         vDv1BGHBo3ST0P7x3/ZwNHZEmNGqzAsrvuIPYpvJo7SC9k2j4ItCXqjGpNT2qcmHc2pf
         vJxUUQ7E+VIZF+O1J8MsQ/nhR4WN2O/agjHv8tv/szN/dHHTA2+/OdeWOkaiPvC4Yo94
         2r+Fk0uI6EvVC9IZ48M27xR96RTX9lUJ9w3yCvw7HYP4CKDzB7MguPh8wcjEzCdFk99O
         32mw==
X-Gm-Message-State: AOJu0YyDVxYidwQQKagUAL76SbCNVA2bB5aRAacsSTcjU7h1zQPBY83J
	P1KrVtRoDu0kN+p7kSlm55zvkxUbrp6PNvsH+VPMHVh44PXc6uzHu73xe1q5zpdV2w==
X-Gm-Gg: ATEYQzynLsqNHsFCjKOK1iOGW7BpA+Cxynj6h1iU+CMfrYTtIB60gGbVOmkd3peJ/Rp
	tZMnWagXoAv2dV90MOphBiLPaJNRM4OUo53Oql8Cf8mZB8QXB6ztraFDp7TlRVUqi+hdTjvgFP0
	Znt51wKEYBD84BJlzezGmvdOZc6JkWzvp5hfB/7eihOveleoo8SWSsPx13ckgEpt7zKWKChMLsP
	Q0ZIYf7jOgQzzaFbnC0uP7vvPXggimp45CNChPzmJChYLDJRyuLBwCLxAXu5CMojAWp/pHFJxXb
	Tqt2miXdk3stLXBW9nL6yZq5YOOrKTZyTaVVI2zOoCsJ8e25zWxiiEj+itRLxLsRX3XrPSUj82a
	wLEon34+DXR3/7awG9gAFCrpbmJAblwLs1hZs1KblgruSl4dTMcgU82TcMTyvUI7IGMwutAogSr
	pZosnYSj38zQaahVmgNHG+N/vLU2rLF1POdryyELOmcYOP
X-Received: by 2002:a05:693c:2288:b0:2ba:9cfb:2744 with SMTP id 5a478bee46e88-2bd7bd3a027mr7903431eec.30.1772057393503;
        Wed, 25 Feb 2026 14:09:53 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.123.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c3csm304755eec.17.2026.02.25.14.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:09:53 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 25 Feb 2026 15:09:50 -0700
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
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
Message-ID: <aZ9zLoO44ER0uDLx@fedora64.linuxtx.org>
References: <20260225155341.094945851@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225155341.094945851@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-219721-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtx.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0930C19E2D6
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 07:54:11AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.4 release.
> There are 781 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Feb 2026 15:52:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

