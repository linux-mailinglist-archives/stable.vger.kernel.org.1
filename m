Return-Path: <stable+bounces-215677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJZCISNVi2k1UAAAu9opvQ
	(envelope-from <stable+bounces-215677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 16:56:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E611CD2B
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 16:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 697A93037E53
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736D3859CF;
	Tue, 10 Feb 2026 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="CpZP/rmN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC853009E8
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738976; cv=pass; b=Ns/wJaal0Knf0R2tV6zBt4VF5aYR+mJuNV4wHJjF7716sD6pbTWeAmO+JHxFc/FqQTV0oS31IBZ77w9YABaCh23jyJQNdnt723bRAJGOtzjiseEJ6brLw8iG320oV66jxpXlcTZfAOwMrB1KDGegdIeGo4kGtr5NjsFZFqYChO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738976; c=relaxed/simple;
	bh=OAIEf0O+vVao9qslAHfoebqBUgeg/8PJahh0DJj5fLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaOk9nUfPdHwHf0knmzvaByHtqsa0UwORyv0J8VYUt4skogMt5RJ0M8wm0aAzbpLztuK4sLTJu+LMLf1dAwmiwMcV1/Mxf0iswZWyPjfklMx4Bn/1L5syV965nllqRmpV9EMvPaV8aEQmIYCI/qx8Wv3jU+sKT1bm4HACd8Irlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=CpZP/rmN; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b885e8c6727so709822266b.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 07:56:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770738973; cv=none;
        d=google.com; s=arc-20240605;
        b=YNtKetW0AcRpXt76LWXP+nD86CQegszJQx9BICEJGDFX6uaPH+D7boLucV8sgM7MfS
         Rm6pDGcqSY93qraDNs8IQaK4Yne6AlnyrJ1ytO8PWKIs51d3FglINcqvXCmFc5tLtADs
         gO1z2IWOAFk1RzhbGyqw/VmDk1DwrFVY2MhlTIM86LgxmXbembgYwgpXkOIbnsw7rg6x
         r723Gtjf35jxhSIKsMPHpn/mP8jOMcVwaiKFhm3Cn+I9+ONw2+sJhywACY050H3e2kUN
         8z4/10U/9QJJHLVd+7Xj0PY2OSDJfh6oevOoROTmNXj+Uhh3YT4fmfMyau63kA5gm/I/
         IEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RHNM3wxM8gq7b7JGa1HDs6bGHDU6U4Hwkp51bCUb8F8=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=KgxdV3aN/dpAOUcY3gtO3F5R/+qvU+Mj1Vz2cohdHhXFnY5YJAbmcrZ18K+yteDrfo
         0P11WqGw06J14b/PXSWQLnjerp25riP4zuRE+FxipEVCPElTUnh7/YZSWiiSTxBUp5lQ
         wZGsRmKscp1izVl1YY8oZvdfmhYVmdx0CUjPzyiLsSTrz11LsnIIS39+QjVBu7YOzvVK
         sfrj1e8e23tFL5Zblb1Vkcm0GqzMoO/ehoLl3guBHiwUVp4Obf2dHHmH3Np8R/wi2YQ2
         m04BchFJTIovb+QM3614JjJVN/oWExolQuti3/Oa4YvJRq2YbCeE2PYQsS8Ey1HzoMDo
         zXgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770738973; x=1771343773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RHNM3wxM8gq7b7JGa1HDs6bGHDU6U4Hwkp51bCUb8F8=;
        b=CpZP/rmNQFyPZjdmXf19mIFetkLPDgAtPyeVZBYyxtI69AdHdl4dvr05k89IJeNzqr
         fFKPHKnNE/Wge+p9GnFiZnK+FZr7JQqvB/XNd/9ZCwicxlVv3z3LvKESKGv7xzaCnvpd
         xtdxmsPQKT4z/RJ8F2bOfHbnqCVstKkxTjF+lsZwIpVojAa/N/2MLTZADzTSf0zpZrFt
         fKu1hJplPpSXftSOI2dDF4M7nSX74QjeNLLLxjF9NbFtjYb6fOAYcYFqy0r1ezruMc9r
         ofUCEligQicS7Rsrq8QbpUaQKQnan9Tz7m1W92zQLuK5NDmxnIr2h4yyCZAfyYwiuHLG
         cD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770738973; x=1771343773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHNM3wxM8gq7b7JGa1HDs6bGHDU6U4Hwkp51bCUb8F8=;
        b=sguSd5W2dag8SpjAleMVhgvBBITSAO36GqzU+s54L8hUTRctg7bCeT+bKf72TmTuDk
         1nMSBhxsBLeqFDpWOc0J/Mge8dqdoGVysAYbLnNH6qyd0ZsExfdF2HfCO6mrOcNRHTui
         GOtQ3L/gZyOdXSgE8u1sDiMRrMOLLskdtPwyuYPAPCU3mSaHNJ/7fQdZ3+NXlqORwj3T
         oKMcsjdB6fmRCyF3pUfn5kHN7kBMiw6cMqb0xEcoJ4FXWWlKG5o3Wilg5oPrZzRRbgac
         3hu933BOR24gTreNzVzii/OIAmWm59gc56Rcz3uyZ7qb4JomxP9jcPCUU0i8wdK/vsi4
         TIzw==
X-Gm-Message-State: AOJu0YxGMH1gjsrBIAQnpM5/1t7hHlLHvC5aF2DNVkRuOtes+z+77qD+
	Ofnc1uuwQuDCHfjMd3KoG60lTfsEiOBvXOfSvaMF85K0+TXxI9eo4r29nOXMjLiLpjz/Er0/ruu
	6Z1accG1gNnenAf9cKAaj13n4liL3l6KeVeNt3QFLAg==
X-Gm-Gg: AZuq6aK4AL2T4OjY+iXWYf+pOkFXbwMH7qVp6j0RT/l1+Fys1Tk2wWaXTh3LMzcJGYm
	qE7q8rAMcLsF0evM/sotxR68cQHmovUN5UscY9M6wSheqpJxaj+snLtSqYJ8KyFjcqwa8rH3UZS
	0NrrSc0FVedNbXvIg+/02jd7Kv2LBSpuO1wmTX5IDYOpAi6y8Emb8E/2BhJAC4RL/hHCnzTQiBp
	Oj4vdIt7Rfv0osuGtzOpbARe+4dkm7R7EMIaWziT/jXtwaPCyp4ZndVuqvISgy1RZYnXZO7ZDln
	sToVM+moQ6fcbJiC45tnRGl3ctQOB/YFiRUPy4IDwd3rEleRMKlBBWQtXQQ/Sx2GKpNeqg==
X-Received: by 2002:a17:907:968f:b0:b88:23f5:3cfa with SMTP id
 a640c23a62f3a-b8f50cba6c5mr174846866b.31.1770738973279; Tue, 10 Feb 2026
 07:56:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142310.204833231@linuxfoundation.org>
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Tue, 10 Feb 2026 21:25:36 +0530
X-Gm-Features: AZwV_QgUraP5QxouttC8DAmvBsk5r6YbfdwZIJudFIlSp0DiJPGvGCnq-Z06DDA
Message-ID: <CAG=yYwmDgTBF89qwFTYzohZGoypkETQ6n29CXqVzoO4vxTNp6w@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/113] 6.12.70-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	TAGGED_FROM(0.00)[bounces-215677-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,rajagiritech.edu.in:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rajagiritech-edu-in.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D37E611CD2B
X-Rspamd-Action: no action

 hello ,

dmesg Stuff...

----------------info---------------------------'
[   37.458874] evm: overlay not supported
-------------------info-----------------------

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology

