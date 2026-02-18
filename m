Return-Path: <stable+bounces-217213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCH0A0g/lWnBNgIAu9opvQ
	(envelope-from <stable+bounces-217213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 05:25:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ADD152FA4
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 05:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5E473043D5F
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492142FBDED;
	Wed, 18 Feb 2026 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jeeI91dj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E172F744C
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 04:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388729; cv=none; b=BRRsqoN3v5eVp7IW8DmLz2Ieu5t5VuVaw1lwG7L6OsmnlVjLS3vaFIndnwhXqHzg5ZVHW+51TueWCj64avonG3cvw5YyJjdNT/D8u4LCRFYBa8HejMtz0rvJsmaKLREq6DJQB7wZggqLnD9+hA+19/cOEL/g546EVFdUicErpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388729; c=relaxed/simple;
	bh=K7UGgyHiqsjGzNipfuJaySEfDiIRk067pWPJgz/VZFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aK2gy7KF1d+2dxDfPSTcpiotN5FJ5hHxOHmFY7EGXyss68nIoPWM4tMDM6Jlz4fYhOn50vvhXO15zis7gtYMPAXyIKyt/bUEutBsallP/Uzhl0+H8tS86x797Q8BWsYbfyL6Q3m77a33NKtakn1gNGZweX8AmEwou+jmaBjnU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jeeI91dj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48370174e18so31481685e9.2
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 20:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771388726; x=1771993526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxYkdkpfCuLqQUe3oaFgMp8zU8CGCCigXFsjkMzyrV4=;
        b=jeeI91djTEX4nz04Tl1tnbPy7DGdc+icuTQ2swUWPle9j0DgqYFG9PTLOreQxobEwM
         roNwHXi+eOfj7hpEWtGC82X5fWSjY2AZUKrk350Arz1lLgksyjM0ntz01eaRBhUefLP9
         9J5HlVtILeOiOGqtD2Eyeb5sx6dtNaVDwbicZ0CubGmWhZKpfDzOE4DpwX8RcajpTREn
         7AZ/e8GuZBDCk/uxl8GMJf6N2kJx7HXxxU2u/eaWK3eSXmQwsJrkikCjtOlljc9U5KQ0
         kGMC0WpKqkcPg2cp5VTRIWG6/HDO4UjBkRi3zysiizDUk03UfIX2gkQDxLc7R3jUM+xc
         gINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771388726; x=1771993526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxYkdkpfCuLqQUe3oaFgMp8zU8CGCCigXFsjkMzyrV4=;
        b=FJuNLlvFJ35AsFknud77hblf/2K/ezUrWvnCoNSuqwyJAfW2p2DZRj16vVR2pefZTL
         0QUDLMoa0jGVts35IpV8SWwgm9Hs0Uj8SKHfQ8NqG4mxHMxkgWu0aktsGH1RBJQ3K5Hk
         zZhU6D3fIGDW/64Dtlh54eTK8onzgVhELg5wOnDinqcHM/GFdJZmFvUaiCP22fiVKuox
         FSLmHUWovv0rQ42/GYH/kCA6dKB1mLH5i7LqgYFBM84EqbXYUS+QlIHvqxAf/wTjaBxa
         XmMuimESqaFtTHW/tg6RH8RFI8BEO+6JJuHYYPpqx7BTYPfevkpwFPrydqfZrS12Nxsh
         hBfA==
X-Forwarded-Encrypted: i=1; AJvYcCX0FC3ZPq2Ot6jVQYFPZuS4e0WjXPYfKJYgHCthk1W/c2dpZ6TYun6nIOL/DoRXHX1lV38Za84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzPflOZIv3q2WnWmYpOkNziLULObtB3Z+Oa6N9aXlm2N0UK8tW
	jdyoiZ7Ygf+lU8kTItzDVVYwd6jriLackHMDZEn9r7YGrHmCpaDBHA0=
X-Gm-Gg: AZuq6aJMdNH0Pz9rg9bs2TorWLVO7l43pxqg7aFa2o5bzpjrccaF5FRBPG4fUDtXNw3
	oS3sLoGwhJA69gwyGqykFmNeepKIRnv45B60r+UkSg/Hj2EdDSc/uHXzN4nAHkCfsO+aWydckpb
	/4YJAyNRFi2+TPQ91aSNRROc05dBq2zppBC9BnRG6qBlwSaEe60C635rxtmNzm6F1JOB+yp9eRT
	dEtgJWgaWNbaXV8CKX+GxXiXmtMzegDz4B+TAobBiN2TG4gS4rC0884Klu83xPJcDdDIGbvxouF
	oB9BzwknUBJPWD8+/EOTn+hrE00ODTFdzV6MHXMDP0xNW8fOgVx7g8MyeUYj7NDHHPln00k9qM6
	DsSY78OpA39a6jEtOxHh9/p1wEAFwIdyxj59YRr2Il+pWjhLjDF9h0QwpSLI3WTW5EsWFXA49CU
	jpLY15PsKcoG6ar3bDGj0DXEjm9xmhWVtmRebm7D8FdHJqLAkM5gbxNcMRF2I1aiMNTR8r04ie3
	4I=
X-Received: by 2002:a05:600c:c095:b0:483:7f4e:fef6 with SMTP id 5b1f17b1804b1-4837f4f00f8mr171570925e9.26.1771388726011;
        Tue, 17 Feb 2026 20:25:26 -0800 (PST)
Received: from [192.168.1.3] (p5b0574ca.dip0.t-ipconnect.de. [91.5.116.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1bfsm40127691f8f.13.2026.02.17.20.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 20:25:25 -0800 (PST)
Message-ID: <46c36fe0-77cd-4f2b-a121-7439efc37ae2@googlemail.com>
Date: Wed, 18 Feb 2026 05:25:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 00/18] 6.19.3-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260217200002.683975158@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260217200002.683975158@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217213-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: 83ADD152FA4
X-Rspamd-Action: no action

Am 17.02.2026 um 21:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.19.3 release.
> There are 18 patches in this series, all will be posted as a response
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

