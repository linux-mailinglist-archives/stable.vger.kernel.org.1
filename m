Return-Path: <stable+bounces-227362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG0ZA7U8vGlxvgIAu9opvQ
	(envelope-from <stable+bounces-227362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:13:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FBB2D0A4B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B8013005672
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290DC38F632;
	Thu, 19 Mar 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anz4oiC3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E03F0754
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943982; cv=pass; b=PMQMyaTk3mEqJ7eigLvFDJe/uBLqsXuuWlXYxsejSCM4RzFdJc1qIe7SVfjSfXg13wOU8SnnboPeyubdk7KPZqAUzmpA/0pLGJXJCX5XbBxcHY/s/aobMzxFWCU1CmJ7uelIzlNGl6dVjBLZJzdpA1vP40tiQFXPBp8HQSGEac8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943982; c=relaxed/simple;
	bh=fVXpKfFbS1NA201vpH2gm3whwcE7r9au/YcVO/S80us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IN4Ug5l2EX1zt3+wVO9pyuYP/O1R81Hr/xXmyJ/PFdxMJKMcoDdwTQzBdeQjttqX+eGDfxYDjMo/Mca3Xn31d0OnDHVu0rSDpSs55KnfSORWy4TcdvIS4AoYSBo9TIC68I07UClZ3HYzeiwBChdVPQJ31Zrd4RGaNrUFn4Usnjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anz4oiC3; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c0f754e756so1028052eec.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773943981; cv=none;
        d=google.com; s=arc-20240605;
        b=AzHcsXbu4OPuH7Hw3kJFphQrDVjpFUkbc5Alu4qocgVyBWT7t1uOZwvGDBHUHrxQtA
         PGXozxWXuawzhiDZ2ElcESEc983XjRuUZr1r4p/ZLkoSZlQe1oWiJPvxHgwpZfTx0g6u
         qxrOAmnRnTYIxooY22PjZIpOIPnsmujakGIWkEXNh+aS29TKypouLZzZr4JI9qD+Pk9r
         8Y5E/Y3jdofePC1ABvA8MsQbveVZoDPs6UyMHfZpS8xHRy/f+DdkxSG05tNONVIDxMXJ
         p6qw5GfqWOEzZ/1Na1lGKbdqUjlnBz1ryAVKu9trKmh9aRs0/NuwzrCBRHALCUDOwR7O
         PRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qteTQcOugr4VV4wEDV6SAPkDNUqZE7Yr0R+JB4MUJqs=;
        fh=I8b78hqFc5ajVQ6cVTbtehLdR73aSPtXiceA8SXy1go=;
        b=i+ZXIvraD1eHVav2LFQPKqPRZiNkL6HQ1AmbhdbaUX53duQZBKZxD9/G5B3tirJWaZ
         PT07gQ2LEtYnH54w3QNUlLXYD1wZNj4dGOvT319WTLQpn9VuNQsK2pPF0VPNahVQoMdI
         9jDjooxoge0Mdf/x7q4RDCrRg9jWvR+ozhyyNwYblB99d0a+MrUAIPg04U9oigP4Ls+a
         S59IUH3wcbOE5lySd3ikNANNpt46N6M9+HaVuteV3srhqSgEuRJB/Bi6DPWc1FLRZLqB
         IbIvyl4AOzgoAnlb6PFP6jMkA4EWOf/faIb5VbScADtQn9X/UavH898Qc2iNVPpT7Hs6
         Z2JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943981; x=1774548781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qteTQcOugr4VV4wEDV6SAPkDNUqZE7Yr0R+JB4MUJqs=;
        b=anz4oiC3/zwCBZrG3D716Le70ckKZxTSP6Hd1YOOxeG10wlwojfww/MmfPFZwwAhGY
         LRQs3UOrpTTHFOEMvz6nt8YEMj2LpcuOx6p6B7AKVsvhLMbDiH6vBy4XHGc7z2KlNJ/K
         vYowGsqr3rcxnx6WhbDQQYoA0TXYXw+ujQjd471gsR8WAwzDC2imLpp5zmdINLUsIUDO
         cUS8p9rGn15JjWr9bd3976y5B+y3tAky5qjKyrSKTdpo3TIWntwVgSsSE11yRiqgoOi/
         lMBPKJtipWyHh2b68eYKycGdmXeVhIgaesLwtXaAnlDClJeaSa+4SkTVnM13o2QWW4s0
         p+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943981; x=1774548781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qteTQcOugr4VV4wEDV6SAPkDNUqZE7Yr0R+JB4MUJqs=;
        b=i741+qdcuEBIPFuM6sA11gIQtKssjqGQMFa7wyUIT0CX3rdtaktmPgiTXjb2160yQn
         MztwwvaHRQSpandU1FGErDSweNSJhglLR8AJSVdBvVShNUUPf3c5O2pC+3BXXq4Z24uv
         PAHzZvNJpW7s9u5iZ1py0U+/BBNGXu7UbSYfyFogomZ1xwPjrVd8ruMjv0M05LtD/EAi
         RP4stI+0wSYN6rsmdw6kUp56l7A9CTpvQoLadqybCmedRr7BYayQ7KGeV95ah9mtQ8bq
         a9JHiXHoOKymV6wvy3WQ7OPCSix+S71ng/8WSuw4d4ns0CctxPi99JYXzGLnV84LrQWM
         DKwA==
X-Forwarded-Encrypted: i=1; AJvYcCVw0a+AtE0OcogKWDZ2SIDKXDiiiQ2zbSHrFOr2b8fXZ0zYIXP/zDeozW8KtvmuTqcLrDE0kZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIn0yj+t5sfKzF7PLl5pMrHf3RShN/N93brse+yYU0ECqcQkaB
	ONdO9g8pXcZcAR7fg5nO/Mb7ZOsRaEGgawaDgPK6uAE1Vj2N75lTSU6yCfN8mqIJ5WnhxBhEP82
	uwdg6NonE2Y2IjO85z/Eqttlodc5r/Io=
X-Gm-Gg: ATEYQzxLhk+MidMZjxiwjM2W5SAFrhyCqC72+mrUcEG7KoCnGaiJpFsn2FoQ0onDu19
	GnJT0C3LmRT9EmcEtV3FvbFJlkZK8WE1YMXJmhsmFqvJqfkrDA9ZGQXaC7jQCrjyoyqjieUhmER
	sYOE9S+A15mPCctpzyq0xVHyyxooxjLWnuPhNXj4zZX46WSRKzX1i1efl041K9UhXGcAaf12y2X
	8E3cq8SMOnevWJwkWw3K32S3AWZcYYw3uuZV9XEaToXBf38y+vrbkcpWAbli2MI8zwVLpTe3rjJ
	wI2eJ9a2NkPpfgebFKjy4yygo20LNP9lDNmApnvObc2HoTSiuuMC5QJIOjs274MB4V9e2H581w1
	76sh/6w7gh/+bG+LLSe95wZsdkSs8oMs8DJ+eUOZggyo1izZ4GgDf2R3dsDDLUyGYjupequE+tE
	DHq48CkzbLYvBMWA8JuEk=
X-Received: by 2002:a05:7300:572a:b0:2be:80c4:2c89 with SMTP id
 5a478bee46e88-2c1095a60camr221530eec.6.1773943980470; Thu, 19 Mar 2026
 11:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318122547.233850204@linuxfoundation.org> <9f7e4bd1-ec3d-4181-a677-156e6f58e537@sirena.org.uk>
In-Reply-To: <9f7e4bd1-ec3d-4181-a677-156e6f58e537@sirena.org.uk>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 19 Mar 2026 19:12:48 +0100
X-Gm-Features: AaiRm5007LB-oHxdFSkTZyhDYCjaojvToDY41lTtXPdllLqfxF3U365nWh9kJzY
Message-ID: <CADo9pHjpdgr7HG4WjcrOKAy8+dGy+jgNdmAMY=nPqfxRaHsi7w@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/379] 6.19.9-rc2 review
To: Mark Brown <broonie@kernel.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227362-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.717];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,archlinux.org:url,mail.gmail.com:mid,inet.se:url,gigabyte.com:url]
X-Rspamd-Queue-Id: 74FBB2D0A4B
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

Den tors 19 mars 2026 kl 12:50 skrev Mark Brown <broonie@kernel.org>:
>
> On Wed, Mar 18, 2026 at 01:28:05PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.19.9 release.
> > There are 379 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> Tested-by: Mark Brown <broonie@kernel.org>

