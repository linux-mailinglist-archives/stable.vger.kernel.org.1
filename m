Return-Path: <stable+bounces-240003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFqGJZ2W5mmLygEAu9opvQ
	(envelope-from <stable+bounces-240003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 23:11:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 120DC433E71
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 23:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E5C9301F4BB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16973A6F19;
	Mon, 20 Apr 2026 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="T/Ht0bk4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD663A1E6C
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776719491; cv=none; b=QUJH2fV44zzAoB1S3JmkyIR7Cl7ebERfpxAidJLNk5hS/I/pYgpcfipRPlwxKC5PdA24GiBEZoy/E48SfFOtSlI58Uok51mxNU4CCY3Hl4kHKNktRDxX5otWRoSyB1p1Tr+T0hOl7SOhSVmha8d1RTquXxgUc+IjNG36Kld4Dvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776719491; c=relaxed/simple;
	bh=gdzTnvS9DmWAOPRcBV/I51nbRld7uOjeUjuYv6BYRqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYx/ljwAOx+Gtz28BvrbIIRfFxA+zrMwLn/mKXRsir6MRBOjQG+2hdmRKQ7rYwh1XAF48z4GI9hg0NV37MrMBUF2BHqAAff0CgcayCPTJYSHNLAlo5OlB2mQm4ZsUa6ydtJjFnCsZ2daVke9R8CPDkY21PowoRVMDIz/tu4kHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=T/Ht0bk4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d77f60944so2859116f8f.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1776719488; x=1777324288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SYHR/pFJErvzIVkYe1WxM4A01QV2snUewU47c9pZOY=;
        b=T/Ht0bk4XQwt2QVM5zK+KC6wAGPBtLLEtDtm8JSnazXQPoYlG82Q7g2BgQHogvvHXH
         67l+dA80Y/+gRHTtMRneztFQdK1aEJdsVZT9z8X5nXbAGT9URZppi0GjXMAGN8Ac06Tm
         e68qh3J4xUU5R/xk8YvsGgDqA1AZu+fTrgCxyVtAl6t17fXpRNHEBN7Kt/vkg4E+JqRI
         dhYMKpxdtPAbd/hPXHWtJ5CifzrLS4SmkDQLhU5dbflaTpNyYsrN25cI+i17iPtOyz2E
         JD3FXVcOlJz+7Y5aXkxoRDTyz776wZaPRf33mcFvnkPv25Yz7eZj3I+8zDVap66/NZCT
         941g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776719488; x=1777324288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SYHR/pFJErvzIVkYe1WxM4A01QV2snUewU47c9pZOY=;
        b=CC6KqeK9Y6/dy3oQr/O1EDi0wzK7Xjf700/kXiV4lFcC52UGO2sJgcHVRmHhiljOwK
         jKrWUeSX2EfCx1rG21FaM++gcrsSNXTK6hjSauVYAb6CAhT2SmTvH8P5JcT0FRKFYc2m
         b+PuBSxWSp1D5+HnJq4/RIBD1xn8hruGD+5OAH1DAKn1pxOmbdSYddOCnm3OaoXEFCi6
         FuRWWCnEGuhX23LvFcpNRLvHnMO1LGar7KSaiTISUY5x5RPQezPQUauV89fmGaL6WZFv
         f5AC9CameAKBeiRnoD9k17SomFtMjD6VcQMhmGF7EavdfYFqklRe/RX0iYybRJ6xwHmC
         yb1A==
X-Forwarded-Encrypted: i=1; AFNElJ9qJ7AdYDVGsg/tpXUEFtPQ4lHVJjikxnjns6zHSzUq1NB9Ie/QUqw9Ef/LAmlc6IFELvvzZBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0A2LvoL7liLDlO1G3B++Rn19s9cz6/NkDXICI4ZOOJCscovja
	TOUsuen5PCoebxJqc2nsa1CfRcuPnHEtmuns2pE5++8HkJBmO+e/0Qo=
X-Gm-Gg: AeBDiesKwU8VrCEPaGjx4f5Rqfa1I4WuLVWE/VH2PSo7Ekc5UXYa1UIs/RU30qkxi3p
	wt3sJ+eA+xRtbLiTfOQcyGS9alF3Z4CX6k64yzoAXiQHJ2hoewOe+Nla+anK8M8FnZSrZa2AxbH
	6ueSfL81VtBxcY5ms6o4kS8hKJ6SAyu9jr0UECgzGBzYB4FnwBSBJHzAVsUexJi4bvKbjVq09As
	MQoBcE35d6YNswkT+0z3FiqX+Yu1JwRPq7lYn1NUDSM2V/G2MrFWZUl95JvyPMudESwWypwYGkO
	zcTDec2+/vcRKRi9/P3Owwg10Ocg80Gfj+rmHIar9Hov/aXJsTZHrsJxzoJtXssRj2E/f2ubY64
	J5GOI23MJMQXyijzhqti0y+XrlV2wf79kjlDdHUp3dipEj/RXg2kyK3KPEnhR2OGryhsR7u4NOB
	l2i28uo4wRpfYA6dBTLjZ4q5NDPw0UR6juKQ9AR7qwIgkQ5RhkOXShHd2T+2E3E4t9ZA4ZPzg2t
	MMR1cfu0HAuSEN/VQ+ib37Z
X-Received: by 2002:a05:6000:40dc:b0:43b:5672:efe with SMTP id ffacd0b85a97d-43fe3dc7acemr22745537f8f.9.1776719488305;
        Mon, 20 Apr 2026 14:11:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b42df.dip0.t-ipconnect.de. [91.43.66.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb11b4sm32675843f8f.2.2026.04.20.14.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 14:11:27 -0700 (PDT)
Message-ID: <78d77bf7-7b06-4c69-b876-63871efd058e@googlemail.com>
Date: Mon, 20 Apr 2026 23:11:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/198] 6.18.24-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260420153935.605963767@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240003-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:dkim,googlemail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailvelope.com:url]
X-Rspamd-Queue-Id: 120DC433E71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 20.04.2026 um 17:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.24 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

