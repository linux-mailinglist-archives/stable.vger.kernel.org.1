Return-Path: <stable+bounces-219715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNUzHNpnn2lRagQAu9opvQ
	(envelope-from <stable+bounces-219715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:21:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 958CF19DC7D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9148D302D6A8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78FF3101C2;
	Wed, 25 Feb 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkpQDd6T"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3230CDA2
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054476; cv=pass; b=hHZ/kHo2fri0rkonb1QzxkvQCHFwT0gjNXJcizPQmunpjAAxoVNB2b+tDOakW/ue+p0lY2K0YAejagOuewXdRtX29JvdK2NFWZMMhyK8T2FeLyE6ArjSWh6/yVFccPpOAVGfBI7hBzZuTf29y0L2z3WQg2w0gisPDfw5Gux1pro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054476; c=relaxed/simple;
	bh=r/whAqMLJHQRVvo7VfNz+0QkCZS17SRsP6ThO1PzPJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3teix4kx/A2j9RJhfFkWeJQ05L8wEPpe36JXGqPe1ODUnqmErV9EDiqjrnxYZEBwaUf7n84yzqgvMmJVZL2i6diCd0M2n4z+3vjUhipoTDtPCBmcm3zv3IqvEHIj8FLvtjll49GUALr0CvOOE8pmEdxHlanEfge26EAWponf+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkpQDd6T; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bd3b0bc201so282843eec.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:21:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772054474; cv=none;
        d=google.com; s=arc-20240605;
        b=E0dw3CPma2Gy6KLMnG8Dt+JF8Ly7dYnf/YaEdDG2KaghIxfWQSyZ45N4pg5B5l0V2O
         LxGK9mKVsosn7Oo4IUq8lEUGG7BBlaRSPVmZZQ7TikaqiL1WgPvVIFoX9oa2WBDBvhB6
         Fy/vimo3102nVmRoX5R4/id7IF6FwFq4Q9N0Y2ALI6IB1XuiuZ2McdRooIb85LedLxme
         dd5bHDuBkuwqE/EZ+jpXJJcpOv6bTKgDR24q4bJrPyEJ9dGrsf4efy0YZSmPLfNdf4Ap
         6qPFtObCFxeyF4YnCKRAIGa0LL5NMnkWArRJvU9hn2TGaH5VjRMoBlS5K+RD2E7F/lY/
         rHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=r/whAqMLJHQRVvo7VfNz+0QkCZS17SRsP6ThO1PzPJQ=;
        fh=gchfWHb4fpgtACaloBrkwruH7IduU89c4N/C/I08lLo=;
        b=e+/KB7m+H3+JRc3Kd/+b1zqhCenJfa0c6upQgv8Ouu6MHk2TXwHHmw83cmt06eRPul
         Ym+in8OSwyT9wQqh7aBwUxE02+S5iEB0qASYqG1Pyo/F7KuEDhC0Jq/2wJ0uCWhFfYTW
         musJnivzvxTLXsYh+WR0riaiEEnsKHHgC/B5c1JOTIpEpGJ5rXRsAaHzAt6JevSp41qK
         9wB6PrgZlbJQ33HeZ1YzDOokN/f6nbcMPob8ESES9tCdyB73+Tnfbokc9z/FcUf+XmON
         eGy6YdaVxLXBACEa+7e4K9R+WX14wWprO78O2D5fD8tQKjGWVCbh+anOimcCmCt52vmL
         v0IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772054474; x=1772659274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r/whAqMLJHQRVvo7VfNz+0QkCZS17SRsP6ThO1PzPJQ=;
        b=YkpQDd6TQLEaFpdZTnaEmAAhgxw4jWPDLgms8aU86K5aldXkgZ/tvfaXrDPBqE+82F
         KemG9uumQQwYwyTgX6a/AY5DPeAVlTwPtfCDp0JwHECmo8dsU1aXiQvDIyE2DGBRfrLq
         kORbkgJOb2JCYf2bdNWe9un9Z0buu32Dz1mCARYl6AO3Z6SO29puSXhidDTI7nC+JRT+
         A1GBPm1MziTB4mJ70oiU+agkC6PNl6mphdQkSfenuce/VgFdd6FuwgB4b1oMxuO465Su
         rn2Nd/nfAW1xyOjn4HtaKi96nQhKl9L6LB9qt3G+GfDjLWg6coEdBT09kXAwiwNhXVsB
         usqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772054474; x=1772659274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/whAqMLJHQRVvo7VfNz+0QkCZS17SRsP6ThO1PzPJQ=;
        b=WhLjH9yGWepY69xo78X+1x1O6LU9nMgnVqZqeOVNdjbHrVMEoelOZa0fbOM9m1A2AE
         fnmO/3sSQQ17cUETAY0IY9mo6LB4t3CVnpZxrOYIug1dtPLbAlMaYXfyhwDq5PILLoUj
         b0NHWOTud4seeiZHCx2cX6yDtvLaP1ilB3cg/a3CiJCuqHK8Do9wiiGWj4545v3OHUiN
         /y3ivOe0OGUqb6bsGDKJDZBDkZd+VinC0ysp9YZZwVSFlSW/mFFQYwLvr68M7zj/NXD2
         R+/aGQdUy6pJ6xBdMfrt0T5k7h1zNn0GabdThPlm0rqfYzT5QtBDKSYYKrP594e6kGY6
         o5tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAL7zTbE1FbAz+4Y7HFVCC/G5F+Yzz/Wcdm4H+6mCf1IS/MXRP4qCeVBJrlCIAmnywMGEN8Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL6j+yhh3U58ivYkqOmq4C9msM1eLNWpxzMEGmXctrVyc7cLlS
	ONATR+KjrkjthDfBKgM3dH3Nf02WVyXRZqGgdv8MTIJNpRY27x1J7tawTZ+CWsoQH56Uw/9rJEB
	ZDdPg3y/5xBUKhXG0ys1eBj6sXFhJXeo=
X-Gm-Gg: ATEYQzyXKH/sXRr+LHqLa/BHtUkZGhYAgYdPvoCckCMqAZPaV6tFDYDDqdKnlRi4hRi
	2k2uHaCunxFSIqpxuBWcSIKZ8Kcy8bodD2OGy8M3mv7c8aFswvYsx8JvdS/2IZE+exbGWL5VzWU
	D8SAHHSdtMOsvvV1oVwFVPfWz9rTcta+fZm2RvWtKyoTy5N+XIJktc9Ja89vVr77GbpdEGEeYJ3
	LD9raBeUX/spha/owwelRTN4IlWzPI+bje2X9PAM262dPKu3/dxKA7l6jimUA0EPQCFPFhL74/w
	cyzSxhxGz2UASNmf3umHcQNk213hsFSAv4EdgviAt+4T5qw8rf2nz8q+kmVq17XtDU71xB67xEF
	DW+Ke+TdfKgZpgpfFYk6+ZFjbQsrF/vPKO1/rTC/KtvfBt9i+mXXe+yZksflhU3AKi+1clEWjXm
	ys39b8rX5ljkomwlWEN84UMltRy7XDpwI+xHK5bVu12qH1dzRqhg==
X-Received: by 2002:a05:7300:df41:b0:2b7:1b54:6081 with SMTP id
 5a478bee46e88-2bd7baed292mr8035736eec.11.1772054474469; Wed, 25 Feb 2026
 13:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225155341.094945851@linuxfoundation.org> <35369c82-facc-46d4-86c2-a71fc03e299e@gmx.de>
In-Reply-To: <35369c82-facc-46d4-86c2-a71fc03e299e@gmx.de>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 25 Feb 2026 22:21:01 +0100
X-Gm-Features: AaiRm53eyhfFk9GPcvJQXt37by3yPQgMY5c1F-xkUJX0eO61Lvzy9lOns0cAInc
Message-ID: <CADo9pHjK8XB2K2oeNbLa2cc0CHhTf9=40_EGa4AZEN0-RZFZzw@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
To: Ronald Warsow <rwarsow@gmx.de>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219715-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[archlinux.org:url,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gmx.de:email,archboot.com:url]
X-Rspamd-Queue-Id: 958CF19DC7D
X-Rspamd-Action: no action

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den ons 25 feb. 2026 kl 21:37 skrev Ronald Warsow <rwarsow@gmx.de>:
>
> Hi
>
> no regressions here on x86_64 (Intel 11th Gen. CPU)
>
> Thanks
>
> Tested-by: Ronald Warsow <rwarsow@gmx.de>
>

