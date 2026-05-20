Return-Path: <stable+bounces-253384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLrRNCU+Dmqr9AUAu9opvQ
	(envelope-from <stable+bounces-253384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:05:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD859C88F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81D30335BA12
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA44376492;
	Wed, 20 May 2026 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="MiuU4rm7"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C915371053
	for <stable@vger.kernel.org>; Wed, 20 May 2026 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310548; cv=none; b=YvGmUn6ZRp5UuDxFhocwkTMRrUnYknyqU0ehunb3TyBpPnWZ4x/8SV472cJJIaKg3eVwBbqjoJ5592cHX/8am/xAwokXHy4YUkDEC2I12Nh2snzfudMW1JZQ66bZEVrFWYtCEhTX+kdkv9tOYP0kOiAh++gu40CDlsZZXpQvzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310548; c=relaxed/simple;
	bh=RNhi+VrJKeyp8QxPIcStj3ZSn3BJqKFpD9tswgBlpY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3GA1pFabEozXTR3pB3MjjeY8eJkqGwtPTKwXgGHKyHl70lZ+D/su4GYuolFmabISrAZGim4SIOuGXB2h6goFDm3mJSmq5eS84auV6QYTC4sodfbOS437KjHKOGDaKoXQaCeEUxnks00emaWxz1rESsPz/iDYMnGY4Wp+eQuJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=MiuU4rm7; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-132d1b2519eso12373893c88.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 13:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1779310544; x=1779915344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rf4adrALhwhE5Bg7Hir1wi5ddzsEvpjUUPdqrQb8HSg=;
        b=MiuU4rm7U1QPmbTAJn2xNHiQXPEqT6nuonFBL6Kjkzznu88hwaHGQXeK/jRZnCCqRs
         ZXvdJK76eKL0qwFgiTawU4tMB4GF8gAzpL+ivdCrT8nnnqk2n8FzX4AhEAZu+p7Eb7mx
         WL3rYwbsANVYS3bMMtBayy5P0ovMZIB+DN+pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310544; x=1779915344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rf4adrALhwhE5Bg7Hir1wi5ddzsEvpjUUPdqrQb8HSg=;
        b=qJkZq+eU+IvVR9Htu1v++HBlnAXWuBt7AdaFhgg9oXo6+9Wvw9x2f9mfCDpu1OVO+t
         zxnVawVn5Y4Wy/5YXP0HUi11OpzFzvTj0BIDNjRB7S54dbCGjOKdoljP/x40Ve/JzCs0
         HYSdYkE98lpGDtMzVaFzep7/wv82j9oFeB6VdteDfOGrsuBvUXSo+srmQFK+ygjpCig+
         iQ8/qpgsZlQKC/cVyoHtz5DuAR0w5uD3qu+ggRJFQJztnUrmiVS0lvILCZ1jtXsvHLHx
         gjSCnWCWN9jq64ExgytrSCBGBqqbFmtRptVzHfrLblgurF/IybuT5ofCSJz8GOSmGsIG
         so0w==
X-Gm-Message-State: AOJu0Yxaj4m2DQpl9qh9y6RMeSyOybcvFBGGrVbibxIs2mdxxkJ7lMBl
	eNGzQpLNPD7iN29EzXZzzYW+SXxR09FzfZc/o+hu1qNkfM2Q4dipTS/GBUxc0+nQaQ==
X-Gm-Gg: Acq92OEEhmFQxatgxDqYxkQxjn+yZFSGg+V6EM7fAfR3yfuvKxu3xq4xoO2v5UVy3km
	WfZdFjBK89T/2ZRNqzRnZwrePhmtZu7sVhguHMTmh54D8iWa/a6WyK7nGF8Z8I4NaL/BnRH2l/L
	PqsM8NPwuljN1N933ezo9m0ZqYptBiWFZ8+HJ6sqEU5J60AbzB0+qjgYEYyHDQWYVXtwZ7TQwKE
	XzopnqchA8vDlWFNspEI15HUjGgcG1v65alduapoO/iJROuJkb8ZEfSGJsZg7PNa39DtXCL5VVl
	SRVtDiM+XgxLz1jazQsPaxRaPGYN7ijDot7UXhhiNH6LgDhTiDF0flQ1mrXdxPhj6R/q1Qp0GHH
	njKG0iCQDnY5PlBsWb46ObEuTEI0TM+f+7APbhbt9djw2nbousyfYbierhHdLPc/S3LHPbFXJ9F
	dGsB5WKSsdakvzLW+pcFpOBykLuAgTqc3TWUlvhUldrE/A5z2htzAg
X-Received: by 2002:a05:7023:b8a:b0:12d:e126:b7c8 with SMTP id a92af1059eb24-13632a0824cmr128746c88.13.1779310544318;
        Wed, 20 May 2026 13:55:44 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.105.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm28204367c88.3.2026.05.20.13.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:55:43 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 20 May 2026 14:55:40 -0600
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
Subject: Re: [PATCH 7.0 0000/1146] 7.0.10-rc1 review
Message-ID: <ag4fzH2-dUdDHGtv@fedora64.linuxtx.org>
References: <20260520162148.390695140@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253384-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3ABD859C88F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:04:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.10 release.
> There are 1146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 May 2026 16:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

If I revert:
rtla: Use str_has_prefix() for prefix checks
rtla/trace: Fix write loop in trace_event_save_hist()

Everything builds fine.

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

