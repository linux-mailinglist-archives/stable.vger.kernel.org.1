Return-Path: <stable+bounces-216321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLN6CMTIj2l9TgEAu9opvQ
	(envelope-from <stable+bounces-216321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:58:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD0613A36E
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 364CD30428B6
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC470217723;
	Sat, 14 Feb 2026 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="k/CCz7ih"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC56211A14
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030712; cv=pass; b=r+xklusC4+Gnm1+7CJ8d4ZYH9N8tRauJuwrt+UfpDylsGgTO0YOp2dY760wlRXmUNT1mshq2Lq6XouxhOjNxMMyN0SUxic9128s4RCWvR2R/7e1Ubt4X5Ka1tfosxSnL2oLa67xbyNzS1Me0WaMaAAC45wBEdowskBO8sVJiXhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030712; c=relaxed/simple;
	bh=W5nbte4rEtcfLm2iuE6VcT6d0KIL0jGVnJcfbmeUqg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPUafFqh/BX3quDO1OUJC7+VqBjFh6R+WNbZBnqf9vUd6quj0scrEUqvGmU+pFo4mxb09sJ+kCS2nk8kYM9plUXtpBZl/i2eWScwfVXPXE2kEyp0bLHCSOTkWweNqHWrp0ShQ3IlscnyO+Kr9KjYri2VzdpUpOFp5d0pmjKZBFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=k/CCz7ih; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89577f866d6so20915476d6.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:58:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771030710; cv=none;
        d=google.com; s=arc-20240605;
        b=VVvV6LewCzlzRf5yrLtVaTmA5QMLGfu5HLj0ABmfr+OVNjKtEtSqKBy/XJtmDPJ2Tw
         mugvKzRc4in7HqD0efBvKlgDEGLYnc3n320k48HLlMv3Jx0Qzua3Hyccvl5aoWcDkM+H
         /t73Q5E0NcwoI83l6FajWKARkEmBwW8Ts9ca0YQ5gM81fOC5NnNqe4hgmVHD+hp5DoVk
         wssrp3jXRpy3cwUgmrEzhQJYu10cQ9EY81bHk495GO+8etpU1vF4/BUJ4Rb7rrE0uXkS
         yf/K+OtgOxQ/ZIyHOUaYpjC1iINwmKUcKX5TaRtjJ6un0snnOMHSdHZC1J+XdQa6I33m
         UcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vYrvYeGNl+ocSwonqior1WpZBamB7LqsZM5+HaM2xJA=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=bCtt7444z2GrcdcVnC5DfDoA56BWoQBPRIpv+X44GhHXaYsVOFo9vg8Xq6gEPUZUdn
         6gU4Dq8XaR7NBgxyec7EcOB8O5KB+VRSCDnmNkL2iZJ5Sl3l3j3Xu99Xz1rONT7IRG9D
         GGHF6TwUZXA9kdtFcGujFTEVRoWsZe9JQkXUdQZQO7o0orE7ImarB3/dQ1w4kbLUvbid
         DJPB5P/bGsiS+tk/6Z+mNgqzpzCS6MSs9khmyCs4Egpgh1rGE9ZNMJEummO7+GlaM9k1
         JSB62uaXsmWZl0S9V9o9n4fkno6qIqGZcaA64Rq3sUL482t0egYnYSI00vB8SIg2z443
         KltA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1771030710; x=1771635510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYrvYeGNl+ocSwonqior1WpZBamB7LqsZM5+HaM2xJA=;
        b=k/CCz7ihpm8Pt2sBsMg1NrhWIM48h1HutesTQmVEWvkMoE32EDinOH15J5JAhPI+gG
         Bg5iLX/4KAu18k6rxiChq9EIjj79fFWNg89ZcKfyM4v3YaDN91JzyuwD+9v52vt9GK4u
         5hyxmSZAtBWy/szykVGWNFAQ+4v9oQ7g4Clp+7IFd5u1N+ZiiTMLOGmtCj20JKq17+Fb
         5JPDNAP2EPf4SMpy34Z+KqrBxDKe8S8AF/RZBDYvwXMuZXYX86eW8+/HZNGGdHqZJ4N8
         JiCvNw/G8VIwWqWKJ6aFtxyZfgeKPBdgZfNL2nqbg+kR6YO8bQruwmgICWvx9W+jsOk6
         VHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771030710; x=1771635510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vYrvYeGNl+ocSwonqior1WpZBamB7LqsZM5+HaM2xJA=;
        b=rGOnPxO/+JvvbItFM38qj9gZZB5p7CGR/2tpUCr9GTCmgoZ6bfhCLfrfjCQGX8TM+A
         0lM1Jr23oxmPNm/+fAaETFz+VIVT46YomMRR3o+xkKcXjHwPgThU/WFrURxl8GlMGdDA
         ym+yhR8vcKzgz9pyjMVpWd7HdKTD5FydpSWQaoJLJqXBBOEtnv7pirc3o9T8HD5PtWOY
         igMwCEfjyOiotPSO98Ul4X/9wEQO+qYsOnFyMbCE6xG6/aDx0z8RzYo/abYA1sn2oz/L
         8d69nspeASZzeXvGWlV+qHQfJ0sWWOI7Q/KM2ZDcmxbadqxKRFP99rbMUFPrDR362giB
         EkqA==
X-Gm-Message-State: AOJu0Yx5FIn07Nxyt+Aal+6OPv+TyK5MPxaFLyfGHg/K5+OSU5EmypHZ
	hnIxgzW/ErxleIB1YwnUqpe3nC6UGYmX2509EnGHvgtTtuFf35Uq9SyMhd5jSQN8LmfiQ9TGnQ1
	a+Tbmwl2joBWsY5DakXqzW28XWUvb7aUDV2KCAuMdEw==
X-Gm-Gg: AZuq6aL5qK4KwmOs9Q5hGOMjJ60nixGEO8qHRnALTNA0Zc2jgCcBqlnSIPSx0vylsUo
	PB9RX7bZi4OAEC1W25ajCh+u6VxGv1f7m8WSwNv+A33sPHbLpp5fG80gssQebyOV+JXPiMV4cEi
	YtQDTvV1aGJpNmxVgV39vrgSHrPA0GnSeUMDYao2ng3Eic8o99ljKrb5s47cGwbbj2yjB8LUTe3
	hLcdabKBSAhvI3Gjk2z83XiyXeFbpS7Y2OldU8eBFsDr2x0+nZjeFoNJU7gsv1cnzoFKRb82Pog
	O6vG3ziz
X-Received: by 2002:ad4:5f0b:0:b0:895:4bec:b583 with SMTP id
 6a1803df08f44-8973f2fc9d7mr34071586d6.18.1771030710504; Fri, 13 Feb 2026
 16:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213134704.728003077@linuxfoundation.org>
In-Reply-To: <20260213134704.728003077@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 13 Feb 2026 19:58:19 -0500
X-Gm-Features: AZwV_Qjxj_PxbKXdyVWfsxa2vYjhA6CGoymxMpj0QhV6_8TaKXsloLhpNNGb3Jc
Message-ID: <CAOBMUvhAxqz=oyyLPUugqP9sP4bo0OB3izJ0oJTZCOemavWBvQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/24] 6.12.72-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ciq.com,reject];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216321-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ciq.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ciq.com:email,ciq.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 8BD0613A36E
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 8:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.72 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.72-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Intel Core i7-10810U

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

