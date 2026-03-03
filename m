Return-Path: <stable+bounces-222808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FHJKzCNpmnxRAAAu9opvQ
	(envelope-from <stable+bounces-222808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:26:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B311EA260
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F1A23125D64
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 07:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557A386541;
	Tue,  3 Mar 2026 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="K0sMrWmx"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1A38D
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522524; cv=pass; b=TEWSDUZGjTqbWGkhHMJAOABGzgFOua9ovMismSdmGUCuW2vo1LzBdwqNmYTSiBeFMZ/U48YVZMocVpFc7Le2QCzZ2kB9R8AwtsCmJJyOjhzhnF66QAYgg3zEhaG5ZoEewXh/ER6wUhfkzTNP1ueB1S91ti84R53ggudtl7iKaGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522524; c=relaxed/simple;
	bh=DaPOI1Mv6bKKrULXy2EhlDxH1FPw92QbA69rAURdUnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EACqB8gZCHeqC+AEyV/hw29OJrRU/9QNaGwnGE0JFjs95Fh5pllQh+IJqxZom5s6PNBMwNu2z1cPkN0j6erDEZWTK3wZqrUOcKYpxqylnufzIBZyfhPZzD/d2sAsSfWqOT4Twa0+W+obqhmoGdoUKPC722rZxNKxCM3E6Yr5Z5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=K0sMrWmx; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1270adc5121so6636319c88.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 23:22:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772522522; cv=none;
        d=google.com; s=arc-20240605;
        b=WqO/h7AGAZ94BtR2NcRxUll6aCbJEPyWT0L/3xy0cmqA9HgZabU6D2QnpXuHIjS0N9
         7zoWEUPx8s2UNew5rH/yyVb0k9uberDyuaYSOZ6VSeCBrN4onNdarrwG47JDKsJq+W1W
         ggiPq9B149qAdzNF2VK3zFqdjXQMdDWJ8PPs1i4pbjxXzuO5sc+W5yoIkWT0ct2kXLRi
         7ydTrtWVrKDldMLQUQ1cW9tSIJrtYZhsp2khUTCptUQ0zr0WYfN0bY6ee3kUEXd/093g
         09WSdG6aG+7GNYTJqc14pRj3QHHqqbmNpjviNU+fAPajQf616nq3ziRFyBnfWzilFuzd
         DxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GsOnAqebSbbx0Py4ZeW5PaPfQNodCzjWlp52P/rwY9o=;
        fh=f+9znhupU0PvSqf4qTz9AcuPyeXByLo2nlxeYh1jpAs=;
        b=ZUUCJV/nmlPmnKZcW8r24NTKkakGY/gQNX6tiRm1IAMrCdxegNVDmgCoUgXDii99oM
         sxN7eD1ZUUPI4hn7T7/w8sBHQXVUg8trCl6AIV49GQlnWyJC3+WKg8Eceic+8eosLRg2
         YJDn8qkCnMXrJJNvHNQ19cwY98DGBg/y/88YCyuo9ptnqUrV2AASrvFdsM34ZNjj6C6r
         qdJuchwx7ED8dJcT+Sc80sY/tWqdnNNFhpsS+xU5SYtz+jTsv0ViVcio2zG9njdfvQ6J
         JqVbIJdmhFVr09JbB2k4b0oHmOo4VmoxLJAwXcwBZYlo1aqucHGoSdhRn7yZBGMMNEwZ
         R+5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1772522522; x=1773127322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsOnAqebSbbx0Py4ZeW5PaPfQNodCzjWlp52P/rwY9o=;
        b=K0sMrWmxKkJOa6sSqXrt+Nvj5FXSj396GTcc8VMWAtk6273+mbgT8mLUBjs9zW6Wez
         Rgc+4DwI/OmrQUtF/aEGDg8DZTzzbOlDb1+X9h7PXhCLcYVEzF4JmdwMv86PspIZL5ov
         RoNGJquUKvt3ObL+xH+Et2819jePtmv+olxET8Cz3UfefRoMrp8gkPcTqzpijwZ/zu+S
         xn4XfBqMDrmY/BR3M+uhc0EE8fTObSK35iAfwXhMFnQBlU/iAB4sAmlSa08KBdxHU5P7
         oV4STKewmBOrlnwlQ5U5ETgF4w+S2dPwQz40aoGTf0h7ntcA5e7rzBBcXrFOsTv6xjtq
         IkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772522522; x=1773127322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GsOnAqebSbbx0Py4ZeW5PaPfQNodCzjWlp52P/rwY9o=;
        b=gchOb2Pyr2zeFAYzF6CZi5E7P7MqN9cMNSJSp1LX9HYxcg7Ttvxzp2RmHRz7dYDXxc
         SVFsNlxpXHYcEL5fMZMT0OhRfFkPnFlY/neI+BTnwtNKR+rt0lwPn04I7GpKBrNev51x
         C8Sz7eKk3KExjUlbp7dkYE3BDz5KZozWkyUiVuHZwd7zEobT8Z1fRcpominZiGoWLnao
         vCf/Xurdx3cZ29DDEPmcQzavy2e8Ew7p0C/156LH+ptkADY5Ifl2CoqpEPTxRqoH6nLZ
         099+FhzZTXyfmHWTkpe388kbycQGys+PPL66LN9pADoojrTTJgHFGT+6s9LKn5oFN7+v
         +8dg==
X-Forwarded-Encrypted: i=1; AJvYcCXj4b5bl1pLPwubU90pUcaG6zKOp70vxV3SKhMXTTdbm/R8luV/DKozOADQEBEciByffQ9uJVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYNfvxBEebcEwCPWj9vKgNhJKpLy6ULwKjNuKitxWOfDYVa3c
	tTrCeH8XFb6HRnv3Pu2o6pRh5g1rZFaV3IseYZAbs6z9N/q5Q9vmksUyKFp2BQrIsrPn/VSu/BJ
	uWQaG3WHUUL2yaYvNDOURi5v4rN9wJN7QB/K0WJDUIQ==
X-Gm-Gg: ATEYQzwr7j8c63gomoZ1ByEDYPwBOnrmHB/GUE/YZcVvAf47mRBQeccLwSQYSbWgF3f
	sHoqN9SLiywXWpG0wkKWTU54klLYUTesNppYQ9EzsRz8RhTlWTswlBg2bz/E/dV8HwqFkeYbMGi
	/sJr559VxmbHthVXCwoUMhVdWsiW9iaZmCM3axuLAu+oP5m4kFjnJWT326JZ8W32oguT2r3bFe7
	jBJn+N9tLjgNyANapewET3USc7r2eIBwrFNxtMlO68MGlfWwcUKCqYP66g1plOkbrSn50WZf+V8
	jzjuNRR/wLLboZzWhDenvJyW242DHVr/58Ifg2BU
X-Received: by 2002:a05:7022:4591:b0:123:2d9d:a90d with SMTP id
 a92af1059eb24-1278fc21264mr4699765c88.17.1772522522025; Mon, 02 Mar 2026
 23:22:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302160834.2518716-1-sashal@kernel.org>
In-Reply-To: <20260302160834.2518716-1-sashal@kernel.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 3 Mar 2026 16:21:46 +0900
X-Gm-Features: AaiRm539i4FiCURsUwOuA7oKH1UqWI2seltZqOWXbmwwDS1Si9xERFmvBVnq75A
Message-ID: <CAKL4bV4mzN=j-i4pDWp02bEMARUwf-uB3NKjAdt1MoS3QX5oLg@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/850] 6.19.6-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 49B311EA260
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222808-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,futuring-girl.com:dkim,futuring-girl.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,thinkpadx1gen10j0764:email]
X-Rspamd-Action: no action

Hi Sasha

On Tue, Mar 3, 2026 at 1:25=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
>
> This is the start of the stable review cycle for the 6.19.6 release.
> There are 850 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar  4 04:07:42 PM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.19.y&id2=3Dv6.19.5
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha
>

6.19.6-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.6-rc2rv-g6e57a110e7e0
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Tue Mar  3 15:57:32 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

