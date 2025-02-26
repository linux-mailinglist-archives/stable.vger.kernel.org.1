Return-Path: <stable+bounces-119742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF39FA46B35
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07E21888FE9
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B723906A;
	Wed, 26 Feb 2025 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIJAa7Jk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E4216F288
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598610; cv=none; b=dbz2ImOr99uFwIeU8FG/tJDVuHs184xxNDzm7nCe+k30Ort/D35B64qoRa+LuywLxtsOJdiB4WudnqjUJFT799gDbe9dXHF3Gr638iTpUalYePImTVWy19LFy7B9WUiwfFsh8UmZaZNPS678LNO7LXTCcI10Xv2THN1OlFeZn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598610; c=relaxed/simple;
	bh=y5zH1cT90eivCL0FnxWS2uLpWtALwIhnyHLHGUOR0Og=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R208ncaOukQ5q2Lwo6hwaptTP2WR3xOoJiQhJdE/Ef93fo3e9s9IlYmGZT4G/R9B4V2+1UBK6XmAatyE06UbW6HWGkFf4rUcPvxgpmh3u/lXXwA/edMO2akbMkLstzl2zd9ACiImz+yofrmHDCFYOzRNW1+cQXVzWZqYl/xwvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIJAa7Jk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso1235505e9.3
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 11:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740598607; x=1741203407; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5zH1cT90eivCL0FnxWS2uLpWtALwIhnyHLHGUOR0Og=;
        b=mIJAa7JkSz9SauTEQf7Z0TjU1AeTyA3tO7vMrteQvl2T3H7vpT2y41nOR+brI4xVsv
         WDjz2FTVSooY1Zy1hu3NqKzVF6mM/2VrNCtajiw5Q8CU5oYkVNcrGicndVvE6mhy1764
         XnMVpcmvZgT2sy9SI3VCu6kV0ALPrDTn0bOE4iGsetPoI8hJ/jmerh3uNRjVFwC8PYFj
         CtSmuWaXYFO+azAcOL65aQ3BIyt6dpEEJ9h2oPkKNxsUoiNS3woWmeO5TDJhuwH927QE
         FlF8mpigI2sB2DogAsk9pkr0lvOAAQfVAFJdNCBHknJv/EUWel0P+w2Ta4/oj0fY4KWC
         u2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598607; x=1741203407;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5zH1cT90eivCL0FnxWS2uLpWtALwIhnyHLHGUOR0Og=;
        b=WzfL2yQorK4MkQ+YslKO45sa5+cxrjoXcELr9vUeeilN2lQ/b2mYr+D4EuFBRAdttq
         VigXiSqKT8VOBUf9KOgeFlHDf7QmWKMRY7cRlE1Lik5L94w27/nzxaX9JHIWlm3PJe3w
         AscaorChFEsjgxjf0Uj7qL3jnPBmXQRtpHjyRiHy2eAT4CE/tSMV8psosEvl8mo5g2nN
         SS4XDTJod9xQ+aASuo3m8N6tqDGCpc0I8yH45O9txdVmxIV9x97wxwpit0U2gb45ERXs
         XA/0sdot5aCO3nVy8LszeKPrgvrMfm/hejacGJiFHev7eJQJMJcIIHt7epe/CBr3V8Zf
         b7lg==
X-Gm-Message-State: AOJu0YzYYaIUVZArnlVezp0EZWotM15B31MLKSuryuAZfgIpSCNw2RRE
	Kd1VAMry6pTNX5edBJRSptdKIDVyl+obbrOw9LbKATcodOdK6eQo
X-Gm-Gg: ASbGncsqBHNKr6+7zo/Ycjo76lHJgT+JcGxrRU02JeWWmjjzRVMaINJHfpNYCcqAe+K
	G8WAQCzulpf36Q51iju7Z0+Q6/L9/CS5BBAPx+yYWWgnAFugPbx/keKFGxZxGMxbe0vIEP8kI4j
	BoT5C85BAvLC7z0gVMVJRFcYF1EezUZOkvYEV1KW9MD4vzOSWqEJOGa4pqmUniGQi4iRl7lCcjg
	S/hr/Abzw2SJTwQ8B8CNrJ7H4TYb2fMDhsQJd6ooE39io+LPw33s4sdw4aCw/3+xL0M4zyMF6rk
	1SkL0czc/1el6fyC5GjOemWzsznmmD2uv5/HOOMzVtO011fppW9Ryh9TTeY=
X-Google-Smtp-Source: AGHT+IH3uBoDaDh7eXwfAhpp73ASnzrBCCBiIuFn3qpxul7tJGOVZO1mFjtg2/GuHjmZLooYGGBu5g==
X-Received: by 2002:a05:600c:3589:b0:439:8cbf:3e26 with SMTP id 5b1f17b1804b1-43ab8fd1e12mr43763375e9.4.1740598606731;
        Wed, 26 Feb 2025 11:36:46 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5396desm31191715e9.20.2025.02.26.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:36:46 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 167E5BE2DE0; Wed, 26 Feb 2025 20:36:45 +0100 (CET)
Date: Wed, 26 Feb 2025 20:36:45 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable <stable@vger.kernel.org>, Sergei Golovan <sgolovan@debian.org>,
	1087809@bugs.debian.org, 1086028@bugs.debian.org,
	1093200@bugs.debian.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	debian-mips@lists.debian.org, Ben Hutchings <benh@debian.org>
Subject: Please apply 8fa507083388 ("mm/memory: Use exception ip to search
 exception tables") (and one required dependency) to v6.1.y
Message-ID: <Z79tTfjD-rCIa6EV@eldamar.lan>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	Sergei Golovan <sgolovan@debian.org>, 1087809@bugs.debian.org,
	1086028@bugs.debian.org, 1093200@bugs.debian.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	debian-mips@lists.debian.org, Ben Hutchings <benh@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg, hi Sasha

A while back the following regression after 4bce37a68ff8 ("mips/mm:
Convert to using lock_mm_and_find_vma()") was reported:
https://lore.kernel.org/all/75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site/
affecting mips64el. This was later on fixed by 8fa507083388
("mm/memory: Use exception ip to search exception tables") in 6.8-rc5
and which got backported to 6.7.6 and 6.6.18.

The breaking commit was part of a series covering a security fix
(CVE-2023-3269), and landed in 6.5-rc1 and backported to 6.4.1, 6.3.11
and 6.1.37.

So far 6.1.y remained unfixed and in fact in Debian we got reports
about this issue seen on the build infrastructure when building
various packages, details are in:
https://bugs.debian.org/1086028
https://bugs.debian.org/1087809
https://bugs.debian.org/1093200

The fix probably did not got backported as there is one dependency
missing which was not CC'ed for stable afaics.

Thus, can you please cherry-pick the following two commits please as
well for 6.1.y?

11ba1728be3e ("ptrace: Introduce exception_ip arch hook")
8fa507083388 ("mm/memory: Use exception ip to search exception tables")

Sergei Golovan confirmed as well by testing that this fixes the seen
issue as well in 6.1.y, cf. https://bugs.debian.org/1086028#95

Thanks in advance already.

Regards,
Salvatore

