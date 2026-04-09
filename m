Return-Path: <stable+bounces-235473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAYxBSHo12n8UQgAu9opvQ
	(envelope-from <stable+bounces-235473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:55:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 885AB3CE5BD
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D93301F9FD
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C5D3CB2D9;
	Thu,  9 Apr 2026 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="WynbcZNl"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793363CF039
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757319; cv=none; b=YxIIyTw389hPW/kkkbo1MGH0uyuDuQqJwDXBrvLS/I7ZLqawdM7awmS7RCkaxnOs2yQIJ7Zs6Yq8UOoPLCUZvpq3tmWVUzFg4j6kCHxdGzUipqA+E5pukhLxldS8H2Voqm8m2hYP97G2pwWXriGb70DAk+ezIOk1dr3218BPGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757319; c=relaxed/simple;
	bh=f5PyRVbJZI//kUwko+7eCqrINzwuavbpM+Zd8kr8jqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcIwBx2Yk68+klIwZEYWEHqHHbAEqGVhR1gpnTJzHJYSAcH6k0KtTBPPDFru0kd3a5IFwsBeR7tAhBPurloG856x7bAOMZSgcyBat4yQT8jGq9jg/mbPDYWETZAk5xEDG+75Fxtgw6ROHpKZ+NLTlpOuuEP0lQ01WlPW4BO1nLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=WynbcZNl; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so487489eec.0
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1775757315; x=1776362115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJhkquUSXHzHGdyZEwzkMnyXvUHdO+dXNf5X5Zxo4YY=;
        b=WynbcZNlQ++nGlRlqEekHgeKSg0yXjsxXhRxiAjRp6raNUffIPpCXYqu5YjH2tD17i
         i1a9xFK09Box5837DLsxttjgWbcGh4x5CwEkhRAObdfFwPGUB3YIJL7vx8fkRgzrH8Qx
         XuXBf8d/7Ee7ORVhHwwtsgSSHsG50YVZTTaxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775757315; x=1776362115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nJhkquUSXHzHGdyZEwzkMnyXvUHdO+dXNf5X5Zxo4YY=;
        b=Mwo62KdP9oVhj+Rl7tgGptdpZaSfgGTa7KlDMxI1KpzSdRjrWeTB18w7G5NcHbzhSe
         /AcLVQgWbADHVkbktv8t8InHWoozYDiiGAUAmCgJwqvrdNcSvgSnazjMX0FVsGnHd3JN
         hzIHPwLr3D0k/doIj2bg7pk9YRp/Ez1Wh6+o1JABH+FO11INDBwsKNdFSIfV9FTnVnlH
         bD0jg7QRxoB52W7W39QD/aSUivCXChu3emZ3QLvcgPFncIfnrW7tEp/US65osT624dTE
         gLjYUTcji/NMUQrAAtLo/vZ6hvNkMq/x+IlcyoAIBmhHxtaE2hGHmHPJOyPXet/8qNai
         WxqQ==
X-Gm-Message-State: AOJu0YzCzhEd5jJA9dj3+gWe7h/M2sFxWCnM/5E9UCmmEENFvnxE3yaW
	tC5+0/8HhpVaLW3UnqJ38/YrPGnWCsfnmJQPInwBv1orKDWUlNUh3Nu1Eoy+hvCXbA==
X-Gm-Gg: AeBDiesezfu6/eBQoKZwBvxgWCTSH9P4O45biVW8NyXhD87DixJiJiAbLbgdHjdHnR+
	9cuCknSUfVVQj8AoVzNOcQ6q+Hf4qqXfUzvqOyPUmQUiFEHQsXvma6hQRH1H7/oKkk7d6W5XHSK
	lFDAw6rxtxzMNxm6qof6htgduEz05VwqgCMJeO8mbtH7BrsfrSiKRmqD42SvnI8BVnSbrFAfgQ3
	s+3G/M02KcsjMoOV5uusMG6fnqbIStYCgCbM4HY8M34s2zc8Gvgqce2tr1KDzUHc572knKIiskJ
	IdajcU+ABkg8Sm/1DQMsPYXYkUAsrw/s/wmvBoqj/PfV0MUsRZQCIUTxtgDxkIgVisbeIKso55r
	+912ExpVs2SFG/RAvQiracQKYBo6RwIvgw+ugqSI9TsBHIe6pbBlH4gzpsDomL5WpUHxwew6zY9
	Zlg+wq6geu99ObxZW25aGeD5uf+QIDYDeqYOSgVnl+RQ==
X-Received: by 2002:a05:7300:8606:b0:2cb:88b5:a93e with SMTP id 5a478bee46e88-2d588e8584dmr21942eec.17.1775757315416;
        Thu, 09 Apr 2026 10:55:15 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.107.103])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5629b31f5sm578108eec.24.2026.04.09.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:55:14 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 9 Apr 2026 11:55:12 -0600
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
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc2 review
Message-ID: <adfoAFwzb7xfh4NC@fedora64.linuxtx.org>
References: <20260409091742.514769762@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409091742.514769762@linuxfoundation.org>
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235473-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 885AB3CE5BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 11:25:28AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 11 Apr 2026 09:16:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.12-rc2.gz
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

