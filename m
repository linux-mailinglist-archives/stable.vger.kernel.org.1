Return-Path: <stable+bounces-230196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H3nLv25wmlilAQAu9opvQ
	(envelope-from <stable+bounces-230196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:21:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFB9318E89
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C1CF302C77D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675CC3CEBB8;
	Tue, 24 Mar 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="RKCGuvGn"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7139FCDC
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368730; cv=none; b=kIGxIEi8j26l3CpUC9CvjWSa9ZJrpfdCvzUa1QP7n6ZxOm9yFfuH/EPPmkHdtr+vlfy3/0m8KQHxyMOv8VGb+qWi5+LrmqI5toVf/XxSD3TKoyE33VwMvYoYL00NPwqHYJmndwH3c3hqZhwDDw4F6XSb24+TYIKmXOciLOZuWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368730; c=relaxed/simple;
	bh=FFak1H4vTrYODr6HytvqfvxQsQSUO+A72jkTFuEIXug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwBHrj0vivNsQU7pCA0ikFQ+4mSZKLpIxtSUAZFDQMcV84FMy5ZEVnZV1/Pl64hRdNFa3enffOi9wCItXVgCERTTygQwayzbpnNAytPDcqXMmJnOou78r3OXmV5z3KMs79xbP0wl1ODGj+OgKGCJHn7ZIfnjYnGt7T3Z7nEOG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=RKCGuvGn; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12a80c36350so2937317c88.1
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1774368726; x=1774973526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jtDWzT09fCJ+yIjaQ2CpchtZ58KONQW/85NrqKfgrA=;
        b=RKCGuvGnx6dixgTSVRrlp6SosEK8fnntcTABQovR7cCI9fawRUq9PNmlh5xwJ2D/z+
         RwlOZCz3k4EopdPi2mxoj25O5qC8QjXdcn1t2reQCcLXnRNSPUqE2bMuOgOF8CtJML+L
         lVCoF+jwh8srvgv3W0lrkNVWBOzuE/UBVolU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368726; x=1774973526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7jtDWzT09fCJ+yIjaQ2CpchtZ58KONQW/85NrqKfgrA=;
        b=H8Wi0ZtLCBPwfyEJuZMda9/aFEML4gJoYL+QL84njg/5BAqd4BSLT28q/CXGaBTgSa
         AzTrtlH7I0jxXT30xHuOO3xaDys6UL5p8E9sAqjCeEMzkCOUqiOuWugKupFgAV2Tmmxm
         NmgvhEm9W7pNtydJ4hlzKU1+Q5D5mAaWFJ6xdfkUyiG2HM8mzGKbl7wMEW6fTt9EZfbj
         ulE/12D34HKuLqbChsauj6718unMvqdDEV4kkFaHe40a1YoBX+18hhSOG4s/w2et2Udp
         xt5pucC4pDmNM/C+iKjy1ov5Dfg7c1vYv2KyqgnXXXIZR7qPrM8iujJx+UC3iLhO/WFT
         cxhg==
X-Gm-Message-State: AOJu0Yx/dARY8FQxATmt98M0Lx/qK+74y1NrlWA8GTqQtvYZuHxdeehe
	qjAbNSRtFd3uNailmFQ7GpTW1Ei1SM5Oa2+idh38t6uVamwxyaclaVRgKoIqDy13vQ==
X-Gm-Gg: ATEYQzxXWZW7NNhK1cBSAfwh1RH5q/2xC7k2gLnPilssCsOdJpsI+cgEC1pO7NUGqS1
	HJ0pdoOuErH5xwlDVWcORkwHRoCfpv6ZCaUh3YYjTZ9m1y03QlYl2fHiV9injM7IC1klCzbEklZ
	MBzTtV791ppIvnxyD3e7DAjLIm5soFDxmGgoIHOZGbbrtZc/5YI5fW8vZmYHeIBMMO2MWVDS5Xd
	Pa/n8sR1+U1Gn9hSGUlFAAUZ3Ob0y8H/ZNfB/UEok6iKgvU7rbVh9PjoI7n0qxznGKVMjbIIOCJ
	1SF7mF1ox6Pd0xfIOIbrH8ZXbs6DkoyPFvUiySWFthZ5sfLCYabGkqWvkE7O+MtfzH+p8f7KuwE
	+wdEusMC5aqHepckmQGaG4ZHKgT5DKZeIFynQWHsPta3tzjFbvpeM6LeZ82tLhlNqZDCLHYOFNC
	7E+C+apPOpF9cIzX9Q1p06YM9FSFkN+LxvY5knvbDjowT3Vxf5Uh55UIM=
X-Received: by 2002:a05:7022:ff45:b0:128:d51a:5157 with SMTP id a92af1059eb24-12a96f09443mr36464c88.33.1774368726341;
        Tue, 24 Mar 2026 09:12:06 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.122.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a734bbb57sm11608018c88.10.2026.03.24.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:12:05 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 24 Mar 2026 10:12:03 -0600
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
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
Message-ID: <acK307B9c6KcJD_a@fedora64.linuxtx.org>
References: <20260323134504.575022936@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230196-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtx.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fedora64.linuxtx.org:mid]
X-Rspamd-Queue-Id: 2DFB9318E89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 02:42:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.10 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.10-rc1.gz
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

