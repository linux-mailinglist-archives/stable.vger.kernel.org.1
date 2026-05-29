Return-Path: <stable+bounces-256452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL3cI7XZGGpDoAgAu9opvQ
	(envelope-from <stable+bounces-256452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 02:11:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 344C55FB9F9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 02:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C85A302624B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5528E573;
	Fri, 29 May 2026 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="KLbUjLxL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9DF14A8B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013487; cv=pass; b=HiaBIrwcYftPKDqvb+dpkIl/AsI2yJg1ChZh7XzFbHSwYSehIEBGlatSY01z4GsSBKM05WFB/u9DyavZLsiL8JB30A8KUWdTdSbHPTtYPcCMfeO7DEEIzUvNNix+O4ILGL/YUg+c10+TrZDgJJxa2LJ0EI2neWT0nj4p6dLza/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013487; c=relaxed/simple;
	bh=ZjnV868NV+lqhcd4MsChwouvTGC+VvZdX0Apwr7c6jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVAe5K3jzbRJNkEIYyTUl8mn+kQQHgyh1e9H4ri1NYQy/6VG/pTOMkLlvuJZK5DUpgE0ITcc6nk0584GrI5dqbCnV/tm1a39DrSv3VrBJtXY/5RWMerkQ5LsMThgNNCG/hBrQ3/lGzmNP+2SDV3rzo8kiJQHAQQMFTHFDYYQMCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=KLbUjLxL; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-132d1b2519eso9365882c88.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 17:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780013486; cv=none;
        d=google.com; s=arc-20240605;
        b=FBnNE5hDk/sGy9eDhyord+P/AUYEhKbyq8GDQCc31pc8FxiXFkN26w/Cvt0pKZxpeV
         1FtjVxfnST3DQFlXhj7KKpt2qsU5ZOa8B8LslrxslWRl6QVSe3WVvVJHonMHrEBTBEXF
         +hNLaa4n/pJHjdrNBX1j1WzcvXBLb0R5jXSm/TvkT4Zdo9d3dtoz2kHtYg6hO8MvEc/i
         5U1sFRrOGqRyYYJi0WJ0cjIqPXvGEYjyGPv+ajpangfNM/I9Wijvmpdzt4D7CPT9cJKr
         mp83iyNQ7fWVE5tOnION0emxjEiO5aTE6R/DHNJhUsvRcDuYEWlswaB+eefU8l2hxRKR
         cCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dU6gEEGgnU7lLGrcMuRY9/3fx3otqDmeJHRSgiwmTMc=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=T1TzuIHt/pk8muwuZdrhLBxnBHbRNUnyagW/CfaMbZwiDM/OJvTFtA/f8zPifQZSp+
         MBnWY/+CutLP9vaHyELxyUcz/XhQwETOqt8NJEXRHWtYziERIqXVRdVXI8LPbYfNNkm+
         szt6nsess5DpOuygFlGe3fzsNRNw0oh06ukHR6Sw/s/bSeFQetQhE9fNXJ2l8AfiLdn/
         5VauKWBNtXN/RPc2jgfta46cXO875k+7o0OTa7R2hU904m1x4oGEd417xnx65Hoh9Ber
         /yxUrAgfFGBgiisfjjx7riNMZYqWSB1C7k1mPpVawqwhGZgxmyTxl6ikKMWhcGptvIkx
         jCiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1780013486; x=1780618286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU6gEEGgnU7lLGrcMuRY9/3fx3otqDmeJHRSgiwmTMc=;
        b=KLbUjLxLk5sFsUeI0ZjzMXOJ5HEqdMmCCZykSik7QaEtWLFvQnS0AWM5YY72XYiLYm
         I/iCfmIBCVHzuBNIIrIU8aXNIbrV7znF5K5V5P0aUq67uMigi7O0BMKwpmHywP/atgQN
         tu40Gc6NKRLaIWkxWNaGYLnCVB8oM9916r5WrQ/LRexklUDF+uxx871m0ee4YuNAlbe3
         ZaUu4fpchIbQ9cxd4GxaiTRsepuNriqZGToOHHSYeslTQIKwZl+m8fmVjvsaOySLj4mg
         VeQNTaOCac3M1ZK805yCkTvCJpx2srFn50QxpgQ28yZhY8GtXFVF1rXWBX09V53TXxwg
         5kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780013486; x=1780618286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dU6gEEGgnU7lLGrcMuRY9/3fx3otqDmeJHRSgiwmTMc=;
        b=rNcFW/ZsZgZXgyxmSM8zdFCT21o/7KM0uXpl2KRaguQbbHC/2F4TOmXL/lBDKjoeme
         MI+WG//vOGa48RSs5yO5H/78EFKRGR4MUcFJqqgOf6eqT/HQIZhKY/MHRiljh9kdqpCa
         IoLVHY4Od1LuKzZuXfwEks9FupWkI+gLiC1aOKHFOKTbtrigoe3iz7MWj8zjFfpgqKnT
         mKOANWX4b9r8rVVXADhH4cazht5iETxefYgvp8T5blsiglXYO8d7D6bWmiQSIl0eMAmY
         2YPPepGDJ152675iRD5gWKmE6UWwZSDjWe2qODxE7JIJaCQ+40IkXO+sNRdeXfddKZIU
         H/3w==
X-Gm-Message-State: AOJu0YzbER/1LoHi+ufG1Xwu4sz67YAOlkWJ2qSwww1zBscFRllzjM6n
	2EA/wysvQ1eB8ESGCZ0Xoe8rxenpyij7M8AdUDiF68HJ5eZiRwvITfUD2khyzCwr39TBrVbSMDs
	eVlxndHiZKmgCH0Pl4rWqO1pfRgfehyj1wq9HprSN6A==
X-Gm-Gg: Acq92OGo/PmRxo+v4tY7jfTPHe2LwmmV1vD2PF1msvU1vudnBugxAvpTkFAxeqm8HLj
	F7MAuGo95b6XYmFM31/p2pFTSsw11aVJ4lCw4DUzTGluN2LHdTCuMu0He6HCT58frhG2F43hIBm
	nIDxojScWkCmuaqNr9udqKRzFJnDVNUNpX5MWeACGd3tgVUb42yW2jWdJLqWPLv9dUBd39lPz5p
	SlWttyXIkJkdzcOJWQXmb+YhdlV9b3R74IbHA5De8GIyF8Xk/aUIVepsLBPjnSxHCmKq7W3yUmP
	sO338yL4sVUrXPMOnZU=
X-Received: by 2002:a05:7022:e06:b0:137:1ae1:bc19 with SMTP id
 a92af1059eb24-137af011e25mr244319c88.5.1780013485477; Thu, 28 May 2026
 17:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194646.819809818@linuxfoundation.org>
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 29 May 2026 09:11:08 +0900
X-Gm-Features: AVHnY4IjvGF0iXwroJOxaXpDNkWnqugRN30z4Z-UYDG5Do0PqSqa36fDKSG9L8w
Message-ID: <CAKL4bV73k67Qg1dfhPV18S7_yTuVzkVsBLO0sMsdESoDZnwLcQ@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256452-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 344C55FB9F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

On Fri, May 29, 2026 at 4:56=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.11 release.
> There are 461 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 30 May 2026 19:45:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.0.11-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.0.11-rc1rv-g547c0212c36f
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260430, GNU ld (GNU
Binutils) 2.46.0) #1 SMP PREEMPT_DYNAMIC Fri May 29 08:35:15 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

