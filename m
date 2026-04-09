Return-Path: <stable+bounces-235408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFZ1Ku2g12kUQQgAu9opvQ
	(envelope-from <stable+bounces-235408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:51:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7F3CAA15
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33EE3055D68
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E63CE4BC;
	Thu,  9 Apr 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="Zaj2EkXd"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3793CD8C7
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738875; cv=pass; b=upS+KkHXg/8X5toihMero49/QtCubag0x1FovCgYCmW/qPKAmfhtj9q5PbjGFvSSs0HUarT+5iZwk7hBI+Kd9JDtLezg4W7tMrMkrIclPzQBeFt5gOeQTOzsjlysD+HQRWX9cAHJakAv3L8qOzG1hNva9hB3K9rvQyb1eL7Nla8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738875; c=relaxed/simple;
	bh=gp844TgNbVN4Boctbpe1hqdTAmWlS0VRvFZ6t8UR8qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz44lxe2+Ecfaw2n7+VWRFIoFDTy2r4TwPgJ+SKYl9+MFsITAFGVQGRZuFYCN9SDkF9+oW0Ya9NJ9wSOud9u7/t6HMe7xXtL6kSckBzlPdnXsgXU8aaM1GDXT4jmdjQwXyr/PYCtaCAJDSNI3vOjAX/8n14TGenGNfSWweeo6WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=Zaj2EkXd; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c1fcce8f8so4400265c88.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 05:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775738873; cv=none;
        d=google.com; s=arc-20240605;
        b=ciqHK5IU13uQJ7m4jl3W7rlBJ7D8FbGjrJH1d/d26XXxJvvpQsU+P/rdDWBP8GIa7J
         RyiEhn4odkboszOCNqNoq6P8AGZl7v3VB5ml8aodrH+TjnQDMdWtUrTs7qHBTckrsNeo
         CG6YT6QI63zQBUY4YdIE+rckQML9Ll1+IzpuIFpbJBt79X0jcZjF3fOG0qCNwxAj65XG
         Hvh2q2nuMNTYahwa+xJZ6P/GtDukjSbh9Yrws8Jvs+kXq0adhT1qMDewQzZ50P8jk0Et
         2+WOzEEOYy5x9rp6mXsed+g3mAc0AKr/EBhOQkDC3PJqjgk48Xf5k8MYD/ksZDpq3Gkk
         kZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=clF8G1qfvN08Sp4J/MPRuZGu4kx06Gnjll/MPTIavwQ=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=RkSxlWY7ADw6AgKbwDRWstfO3cLZyjodxy9C0X1zXL9fVZvdVW/3xcn255k4iMupBJ
         oh+Kf3WCh/hb8DUbR5k8s6jVTFqpfkPaolQTuB0vKM93ZcIKeWgcCtupRaw6PAk5kNXw
         1vFGLGY4LRVGyyDoAf/Y8BYap+nNmCIZdONUsjJ4bbTBhS6h9gJTe9A4ri5MBpcFIx7F
         P4urkvYJ5KwypEMR2UIdlkzbRCMSvMPYa4vag45lpvm24DKOK7cqFQluYic/MvYuu51i
         9PQ7rPHQEWAjCfn3/jD9eMpnWEMrmqBa6VAASduRD4rSTtAkGm00KsqLSViSH9gP1RGm
         KuGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1775738873; x=1776343673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clF8G1qfvN08Sp4J/MPRuZGu4kx06Gnjll/MPTIavwQ=;
        b=Zaj2EkXd6bW+B/SmEj5OTu4/UjrOO0uh1p6PdckSIvEBK/azBmDw/3l3yhEWSJRqLp
         bkRUV1k6eeAhWsdFyLxBSFDfPEmsfTAqEXsWinWpdQOEq4l56TrfwQsHdku3fRWGERCx
         MccrNXh1s3OhPoz+woAEEg7KWmi+HscK1q62dcYr6mDNXfvST/oqT2n0zK498RzVPHcp
         /qYFHhDR4sfFoIBdADUbeFuQAVxXo0a3ns8enIkhPFijsba5Mx/WzFY0jmt/dNfgm5jB
         lo6E9R+jIO4WwVts80tRZcXmh9isXcIN2OgBboM+0H+ShUQw9UPo7/mP9S2efbsBPl+d
         rGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775738873; x=1776343673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=clF8G1qfvN08Sp4J/MPRuZGu4kx06Gnjll/MPTIavwQ=;
        b=DelodIjTqS0oZAM44VLHSB/n0eEQk/EzTbQjSkmPsJJlJEZuQq8JjYqu+KKSwJZl/k
         M6lWerDIXhi2jA8B971+jGXtZ4Zt9vYN2GfgTYzI+vKWnMUSgZWN8EfgFJEKFpUqomSI
         io4fR3S5QOfX9RjnH9LuPgOl5GXWBTzaV4IV9lPy0YEX976mc9HzB65Ydi0IcjzAvIXh
         MY8ksFWzmf7DC5FAlrbqNDtGzv25iy+22fdtdSkbnJOztkzw1ZZjMmhBvKPjghMF40BC
         Y1YK+OtNUcHma1U1NjdwpYibp/N+L3owPG8oEAeFSNLdxgEggpdl2hOyfIZ4QvdAVY7Y
         UJFA==
X-Gm-Message-State: AOJu0Yw5X+0UKf6zLonEhuG1LFiTPU+JIZaAuPsWZwU/u2xYgVaMdG/G
	TFPPpi0TvtN8XtzP8ZXlTUngP0v1IO2ikqdnXpFnkxYfbmQEOekElTctm2ET7X0qjQKcdgpiAi8
	wKdvJncBFwPjZNTdmgMnhHBm041ZVHkuNbi6KRNMhFj35CUWtlwvzQPw=
X-Gm-Gg: AeBDievmZ8VYZIrNcbVngET2OJESjePpZid1qRa5viGn6bWQfTa0Z0AyNejzMtB6/++
	zIh3yMlvW3uaRuK9xGWZAIu7aaZSm4SVdzGG0ruvy+4hPtvw4DYWJeqOXoEG44JcomKDgsN/gom
	t7HXEBwvESQbf/x5NwWbFrh2L3oa7yjST0mBhliqp56TDm/83VdBmpanEBqlKSnyaLLPNYGPHMg
	z8TI3OOuiVI8HtVdp0kVmUzbGnfiDI74HI+hHKBB4ZT5041h7iB8uMM5z5ppKyrVSF6NF4HizWX
	NyS7JulH
X-Received: by 2002:a05:7022:ec14:b0:128:bae0:e03c with SMTP id
 a92af1059eb24-12bfb765c2emr15030680c88.30.1775738872880; Thu, 09 Apr 2026
 05:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409091742.514769762@linuxfoundation.org>
In-Reply-To: <20260409091742.514769762@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 9 Apr 2026 21:47:37 +0900
X-Gm-Features: AQROBzDpesM5rBlFRlPesY5ydN6kgOYpzmgUph8X1hZLOKx52MExGMjSyoyKCmo
Message-ID: <CAKL4bV6JjJL-z9-k-2gPAm+JkfDq_a0j6WBzdnFdtw4wbyhJoA@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc2 review
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235408-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid,futuring-girl.com:dkim]
X-Rspamd-Queue-Id: C4C7F3CAA15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

On Thu, Apr 9, 2026 at 6:34=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 11 Apr 2026 09:16:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.12-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.19.12-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.12-rc2rv-g0d57c706dc2f
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Thu Apr  9 21:18:43 JST 2026

Thanks

