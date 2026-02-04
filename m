Return-Path: <stable+bounces-214366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABAbAsS8g2kgtwMAu9opvQ
	(envelope-from <stable+bounces-214366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 22:40:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D7ECCBE
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 22:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28799300E397
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7899A1BC46;
	Wed,  4 Feb 2026 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="TUOXtWYG"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3739525A
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241175; cv=none; b=lZq1V38wHCIz3t1sBY2/hd5aljN34CWa/kvZIJuoZKWmW/IRFB2fEJnt4AndnOcIJNsGk2XXiXnZRvIf4vpOlQ9pCIU3MPwyKtXhBbFojYeMGzo1h3tETEVWjEevFSEFoHUIy6cYeHeSPyRxCd/kkXTLkX0vlyBWn4zlTtevIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241175; c=relaxed/simple;
	bh=yIyBO22gdX+03XlD2vJu6z0wiYLNMKGiocjqRG5zoYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttMXAV7kH7TLGjJGzk/uvW46Er91biMfQJrxAoqDVD0dwMugg8h+DZsUf2ab6p1cYYlaAOMYrZrfiYkNbNFRKBm4Y8fi8uXjk5mFFwiPQ2ZS6b4SNK7aKPRMl1Fk0I4873MwpkX5g5FmQMHEpMY4xbifiW9KNHarD0m8baVpTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=TUOXtWYG; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b740872a01so404513eec.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1770241174; x=1770845974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqdmuWK6GfCtv8Zt1a9cnHoLg2M8wAjxRFOas0xgkbY=;
        b=TUOXtWYGucn22iZtWaz8mC/5eJ7QrJvcUmAdYCiiguTazKdHvhxdJniZ4XckjLgcJT
         7IjJpNagHZWtxo79bhYCehv2JRHNL9AcVo6792cU6RzpwIhMlQfElLV70p/7YBtdSh5F
         ROKqq8i7LOZnYWqBFNFHLrgP6g0PsPmKAcXqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241174; x=1770845974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IqdmuWK6GfCtv8Zt1a9cnHoLg2M8wAjxRFOas0xgkbY=;
        b=kwqwRhPyvnMfVowaZHip06EkSCoYvdLEG8nl3pJTquUBSk+iS0Ucfej1kzgU95OUQz
         0PfOfODPflnC/YIlCEOn54E7bQOFpOcgiIwD0soxB8xtEvgtRGvqaNQXI92w/2K0Tbmr
         bHKCNlTd6YObLX0BjgWSaZjXlx+wRbt0p8FqLPg97DIXuusptXUgXxsRMm+8uvt9isHv
         ASaOrDwGUzpndehJ33MEPbcTBCY5xGJzP5cx6Nc5nGhTQinMD80Dl+Xd865vdN/BRTzQ
         gk9f7JCE7qINAbhi4LtqDo4kCAU5EM7G/61Ih2cYmNYTDr2949xU96Ghx5bQeWZA1bOg
         s7fQ==
X-Gm-Message-State: AOJu0YzW/OxB6es3q4CXiHW2Fm+/ZrT+Dyv0C++fT5YQdXpVj/W/1fss
	cvQDmqYvvRqgURVGj+Vhkj+L0DBx5b80m+oI3vk7dWq1Ap4gzTM2DKObWg9AA9rNXA==
X-Gm-Gg: AZuq6aJFZmTU0B977oOu7KV2uzpUsw6f6UreoE1hOgwBDbhE1CELCVtFa1JqaZcEtH6
	kMVHt6jq3/cDeGHC9zEnJgOlM4KLoLlfPwGCZSXc9/NUsNtD1FTFMIBK2MEOATQExIxe9k8E6hy
	hSEhOAr9w8X8Qc2Ydpd+5H3BP7Na+5guKJASDJqPaOW42QqGaH1xLFUPqFHz+2PwkoVR9pSw31k
	F40diT0h0SOepB+V4pvIlPvo229tv6BauIS3yIh+DOMvShN9hhW/81m0eCUxPQm+WUlg1VVi3ec
	Q6e+m504L8VV5ByNQRy3PmECjR8tWKbm0O2ydK1sOceYZLhZy6T9x18IbqGWDoAwl6cVavnT3pv
	NsLqHeOp60ucMP8DQYyi4AxsaoBMAN7pMClqtu7+5vuPI8wcy9PkrOslAuhzv+qgsAO8/8E8Wgv
	bz6SiWzqB1hO4AblxGuFNYoEtUWsk+6Qc=
X-Received: by 2002:a05:7301:4b03:b0:2b7:e2db:4a14 with SMTP id 5a478bee46e88-2b8329dfacbmr1949567eec.34.1770241173961;
        Wed, 04 Feb 2026 13:39:33 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.121.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e1299bsm2540989eec.6.2026.02.04.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:39:33 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 4 Feb 2026 14:39:30 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
Message-ID: <aYO8ki5ZSu4ff-2T@fedora64.linuxtx.org>
References: <20260204143851.857060534@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-214366-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fedoraproject.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtx.org:dkim,fedora64.linuxtx.org:mid]
X-Rspamd-Queue-Id: 622D7ECCBE
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:39:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.9 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.9-rc1.gz
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

