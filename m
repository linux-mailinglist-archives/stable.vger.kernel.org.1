Return-Path: <stable+bounces-227015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sARHO4t9ummTWwIAu9opvQ
	(envelope-from <stable+bounces-227015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:25:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 158BF2B9D7A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7B4330B1026
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157EF31F99D;
	Wed, 18 Mar 2026 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq/ZEnsg"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09B33EC
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773829390; cv=pass; b=sXGopgC5xDiTtDHp7mhZTMdXgb07Gzcio/uCV0ZK3dUALi1LNT4z06lyQJGZZjHnjjKMkBbWRQcDIE1Ph6dcJuZPMYrER2BC7pNQsLZG1sAmnD/1M5Wlb8uFhvLqCmE49zdNCHWonGIxMgIOGQ/Q06Zu/47mEs2mk7LDGoHPpb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773829390; c=relaxed/simple;
	bh=ENwQeManTuDm6mPGlDcRm7HWgdloJUxdG90BflibYAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1aeGOtwUOpxN1OQ6cE6Em0+jkwhb7c2SsN1FlcDroK8NnCfJTwH538BShjJOZTBiIUlWgIqGDMHLUzxp/E/ffeY8gh80Dr2cGaQOfKPok3hGM9zqtb8+XqqxlI3p4QttrkiL3SYUAZ8xJ5MwV3cj7cboHs8ayB7pRPmWIL7I0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq/ZEnsg; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so6116996eec.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 03:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773829388; cv=none;
        d=google.com; s=arc-20240605;
        b=eACF25HEG4SPUb8kJWZkeKE2NzlaiWEbO0X9WUfpa8JOKwKs/hIVpJJxWkyABYXa7L
         vtNSxSijxOVPkUaqZkWHzhzGrAZhRZbqnCgKfMhtKBhOw3a+CCox+N3G3r5srfGlcyBW
         xOsI+M0e0pa/PnxLPzlWIXlFup1N/4fksnzqJHHL1P0wiajZC9uuymfAJiW80HHgI++v
         Bf9HMHABnLU+CGdXY/89I15SSNJXaSBSV3ka5AvJAdfTmRjmqLDFTDVCJzix+mxW31wa
         TPSHLsQyyi+0vddsvNM6LaebY5kH9lUjp2SBzdnAL4p80pUf4W8/1QFVmVd0ta3Sjl5H
         UJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wSUvo3fvAJ73zkjyzXJTKKPrpS2i7HGiWgN6P+tca4Q=;
        fh=W6lTXihOc0h//dWjnlm+MGcaqW4ZQFz4Y2RDGI4c7Os=;
        b=PfuqmQzDySd9mXi08SURNEiZZLG79skBxV5cZZVG1/sktC+7SvKoEsTAyxmqCZnpTD
         eZnttDG4ayK6mza/9memLgtmMy/dk/je4eALHgxAWhToNDFi4Ed/SkR1rMG2J/s4tTdc
         jpwMro0q5jGZ5XWLBEY3Vz0J4S9857LQ1WvgXzB9lpJ7JZb6MeH4QrwibFpsb9DNkC+Y
         UfLAHUw/fMnfo69zSbKFT2lju+TRso+abzflHbiDNG95KT1ksZ6IAOUeMsou3WslteOK
         wSKgV/m4BuysfHPmThQJmadn8M7elYuzgz20kmFMOyOpXxQeYuLAzsXBKLXDGk5WXLvF
         mNyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773829388; x=1774434188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wSUvo3fvAJ73zkjyzXJTKKPrpS2i7HGiWgN6P+tca4Q=;
        b=Tq/ZEnsg73nnEjuS+SnGpS7orj5YgpkRJtKhDiEkEt7tdwusYhIzxMrVqWtx0WR94g
         ZPEDf6SEtpnqFWxKxq5nk5HV6C9B0TdWiZ3drK01MUkdgo2R1Hqz5tCWB1V0nH3+exZ0
         9ayd4ClfnHcuQECYNe0cE6HKlzmja2gpEM/a1Ue/ABjFf7wYL+4lgWrS9sGHeLXACwoM
         dfy0kWo4122CLwWURYEaf7/u6+usCDoK9wan03/T/SfXQ5M9g8DfgqoOp5Hwv7c1ReKi
         D+e5OWFhq2Z54p3BUJM0FzP+sYnCwifJRNxBOFV4utwzBCVKvU/6ifK07J+Yw93n3ZsQ
         eD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773829388; x=1774434188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSUvo3fvAJ73zkjyzXJTKKPrpS2i7HGiWgN6P+tca4Q=;
        b=XmoSZ5ycniB8wTc1Vk2YHuwgiXifsDDP1RSsXXh2Co47OHiYvwicmvCw1GEazM63p0
         W4YfMlsMj5b2ZQ+pw0peDNIHkLRw8R49fUGwJV1Lq6V3abqzs/u4PI9i8YHZp+FeP1nc
         Mry8I3sMT7aZDCy8Gvq+ls1drOU7yuUBBV12jkFkYb51Dj+DUXsigFS02s+nAOz3cxvo
         iGo4Hh2l8PdZj9sIYGALFcGQgPRtk8kvgYqA9siQC+zBaVyKk3cRM0U7WYWC0HrWvliY
         g30MBNDnZaTMv3ymXJxff3VscvlhmS7h18qC/IP3y6ymeRVAKDTzhGCgSfY7UpxVzQKO
         wzmg==
X-Forwarded-Encrypted: i=1; AJvYcCXZe2BCynuTNbCy8XWSRIoYyrq2+UvmSZg68It/Eayoxo+AJlFrL3zNWzA+LbBM7riV5oWJwJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZkI5Ah/4lLuKb9++DkvvnQJqKTlntSbtr2s4Cm8HSCIfzLnW
	TsIfn73mTc1mvreai2cB4qsQvtTqyiLCjl0YI9ytptD5HgFAZjYTmTycT8l560SJOO5KtuKeTeF
	FJ1NLqcyJ71BxBKsdSifb0vSnSRYaD0E=
X-Gm-Gg: ATEYQzytdmrt3nvw+RdsX7t/CZciosmP9XSOcJJZnX+9FmCoHsTgdYw6yakcxn/FJqo
	4oaHiSYew2M+Yjyf/UVWqQRZBwk/l4cFBdNww6HB8PtfeR3NmdbNaVyZGgOczFSEVzJlzwNYLCH
	8w4SaTdN6blPasZbsGibn/9Qe+jyQhu+e+0rB3mFH6AkjrkoaOswkEv1JvmiYXRN0mPp+BGVfgh
	LuivLidjl/PVq8QQnEeT+xgocX4leJEvGroOlnyKCOLd3To5a2+YYormzY4uTvYFz15Gv35GyJj
	CeLNm31gdQ/KRBloPP0wj5S92R/QJRNQaKnaoiPOVRj1lvhqu9a+NbwTeiHWyxOn+enIshr+6m8
	Hem8uZYQuTRXjHdEYvBuAcQATR58y+w31VGHWi6n4+GYhVpTXjrDJI+3/sAa9TCl+zpu3s4L8+u
	vev27cBicSB+UCiwxZ9cz3o63Pqd0CNg==
X-Received: by 2002:a05:7300:6da5:b0:2b7:32fe:4bbb with SMTP id
 5a478bee46e88-2c0e4fbbe47mr1103779eec.11.1773829388074; Wed, 18 Mar 2026
 03:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317163006.959177102@linuxfoundation.org> <4f5e5f91-3331-4393-af81-c8e926423d4e@w6rz.net>
In-Reply-To: <4f5e5f91-3331-4393-af81-c8e926423d4e@w6rz.net>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 18 Mar 2026 11:22:54 +0100
X-Gm-Features: AaiRm52IwFr4aSsCDwI0Oi89qMelrQ-7rlbhERs_Jm0LGGf050mDvcU1n3SNt40
Message-ID: <CADo9pHidVcNCqqY+K+WK5OAZ2B41jmRDHQ+9JN4uTVFQ7eYUig@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/378] 6.19.9-rc1 review
To: Ron Economos <re@w6rz.net>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227015-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[w6rz.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,archboot.com:url,archlinux.org:url,mail.gmail.com:mid,inet.se:url]
X-Rspamd-Queue-Id: 158BF2B9D7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den ons 18 mars 2026 kl 10:04 skrev Ron Economos <re@w6rz.net>:
>
> On 3/17/26 09:29, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.19.9 release.
> > There are 378 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 19 Mar 2026 16:28:59 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.9-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Built and booted successfully on RISC-V RV64 (HiFive Unmatched).
>
> Tested-by: Ron Economos <re@w6rz.net>
>
>

