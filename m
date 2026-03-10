Return-Path: <stable+bounces-224542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMd1JtRjsGloigIAu9opvQ
	(envelope-from <stable+bounces-224542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:32:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A70256707
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38138305D6C7
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873162F9984;
	Tue, 10 Mar 2026 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="rEStjnJE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E731714B
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167564; cv=pass; b=UTv5X68rZ9xG0zDgJMndeTPyzGs7HGCl0tTNn9imelOmtkjevT2DiiLnOowNAFOPLh7EBGoPUu6+RH/IxxliNtiC7g3FRPGAdsJZt1mZ8ln2iNHgO92i8tRC9CICclSgjroZJDik+0dbT83F40YtYO/o7TqpayJt8lE3C0VLM4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167564; c=relaxed/simple;
	bh=QxOhPlnUOuK3QwdNv3ft4dB/+yyWxAMuJNP/nIf7nLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvUCqUAQKvIMDJrEE1bF9TtKS6Uhpls0iM8B6o1W2xVJjQdUOCHA4vLmOppM1TB9LHQlGIBwpM6hVmUSCinnwZICK+KF2psXL6SznVhgBd+xcYh6AsYYEhEHh5tVGE4opetiK/NFspFw57roZCtDysPqzkgfApgdpQYVJ9tmqXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=rEStjnJE; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-662c6aca253so1875208a12.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773167561; cv=none;
        d=google.com; s=arc-20240605;
        b=BPhpavCzHYoNbo1we2dungFl0+U4iTK+4QtES5s9WoeM9pStRKuaUKOMw1QQdhp8XW
         BVwZKBYIiyz/a7c8ErST3Td5W2a/zLJY44etHd4xJpi46TvAOHST7lrlUx+ebXBYyxn6
         wDCA1VdasGJCmwA2yZQQ5uyLCvkdQZg1rhO6W1mO0nQuG93UxOJpBqL0bCgHh3SnVJbB
         U2H9RVanPc/osLJs13vEZhE+3zNNYbSxRxLHtJf6X6DQGgVwgyWoP0KCM/7WOjovpk0t
         xCEXNuUPO7XP6WBbGwRVjWGaztAfOA5qFwHmIFcQvFr9wqMWwXcdBMEK10DeR6U3jmxU
         fdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mbo0dPoMaaSWkMG5s+u6BGZf/LQYpArCpui3vZDgH9I=;
        fh=2C6zH3IYoCiBEhuPaIInoY1uUU6ennfhdnMSULgKgkc=;
        b=i158HRmIsMX+BEvTb+DY/bOWLUuDsHc8QT7sO3Vd+OTk+gTB+ApSxi1V73NyBVx1zy
         eIR6NAf2qRHKKHBEipHp/xy9Xl0ta/RYtoIp8QgYiyiyMAEeluZpIufmU999CgZzOT55
         sOPXTHBrTvsQqfu6lMLJC4x2mtLt0RfPigsVJAyPQspZDjdsN9uGwW1eyODa2VyU7yl6
         uo6+N36PC+nooB7qFAENnOSdHH1CamSt8DBDpCBSz8/yPYqINHCVX8GSUxOLCCFgZmTR
         qoi4v4NrGEb9FXsZG4TioTGBcRYD1pYJcdEqGa1HPN7YPDADbWqp2YJg3Erlq1qEAJ+p
         x2HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1773167561; x=1773772361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mbo0dPoMaaSWkMG5s+u6BGZf/LQYpArCpui3vZDgH9I=;
        b=rEStjnJExyjsGG+VDdxoT3kr2v0Mb28nwxu3+u4bUakBIu1T71aWrrL1fVjZyYZrI/
         XUjlIdyCmMVSCmd0OhSBlaIE3+gwZ70fW+725h99s0eMIWesT7ezBuEFkaylZANQZcpv
         S7dv6JFb8wMD3oBBPCnjAPdm2SMlzJRSBfDcNnok1k7t4RT/UsZ4B+xw31TBfQJPq/UU
         2ydp9dsFGIiH73eAAhPXH+TKvgTTQIGqrlS0bGnsGwPhDRfdHBwuzNFDaI0vIsuw4Kmt
         X0Mzslbl7598d6/vue2J+4Urn9PbhYPHdTuTZ+AFUUY9YrYHejz6+mKCoaKpdkQ5k5O7
         TAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167561; x=1773772361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbo0dPoMaaSWkMG5s+u6BGZf/LQYpArCpui3vZDgH9I=;
        b=hJQ6ewtcZcn+9v77tIy/+PlgQiA7O4b5xl2kzDBPxSbwLrjGj2DdUCpU336ojQLUBq
         jkxABH5L1XOTnlwpfvzNRrg/HwBZdDdF5G+qzo40q1q85BV0dPbn/58aqji9u0rOhU1H
         ssVVLLbM/uyhmb+JulmKck7x6YSIELbPcC9bPIfJ5BP70ghAVWP5Nv9eLBr8vw6p8uJz
         RyiYctSMsVfTozP0sNCrUmWchJyGDhtbzF4ZL4npQX5i+OYrmBf3vXt6R53cHRYpM9qj
         rqiMsr8TsRPl5CJ5+1fErAHi/yVwfVEzQP6TAh30qk0+OiaySlxptHldEhmTalvDRWLh
         8veA==
X-Forwarded-Encrypted: i=1; AJvYcCWgU4uykyyBERkpiLhUayHzU11W7hbXujFv1Qzf0CWYUf77rCVRjCYIN/Tqn2YPvgMHs1h83F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVUB3jcG53+17cnIFai8ZyEfZ5D5jdPMpWmSiHqEtlKI/bIeT
	Jgs/pmACqatf3dQ4r4XzW2nPj40+v6ngR8XPJOYnL8UP+dgq2zJUWwSqRhSt2sEP0KuxLDwpXZT
	EfBj8T0dbo7SpLlj7R4hKyRqyJVRul0a2ie1RfrSb82VTNlRkHg1lZFNyWA==
X-Gm-Gg: ATEYQzy8gwojOSQZ2pZLVA/DZ+zDazXW+NGPNzW3bxpI3R3x0J4TPKu9NlfhOrTh0cL
	BhPQqJieK8G8ESiaSz1b8quOvgRZYVAeOeRlrjc3nISbCkP62DlvKsdYKyvoWTzMvvTT3thx9IW
	sDe4xoOKU6y7a+vZOPVqzvx7PtPAX7KoPnk9V5FoQrRX1PhlfAcfCZaBk+3IN/SGuliHDGG02vC
	NE6Xl1jyWpOw8LoHywFcFVcgFJ97bv3R4Sdyhntgm/5Dc2f5kOUA6ezyPjWkWPlvcKGvibHqDGP
	VUmzRoLz8/gnH2DqD2w6UlXx5Lp2zuihJ86oqRt68fBs6j5mepcZmIvo0aR8gcDwNcCmeQ==
X-Received: by 2002:a17:907:97cc:b0:b94:1722:fe4c with SMTP id
 a640c23a62f3a-b942e0b51aamr858980666b.33.1773167561195; Tue, 10 Mar 2026
 11:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773141554.git.sashal@kernel.org>
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 11 Mar 2026 00:02:04 +0530
X-Gm-Features: AaiRm50wJbO78u3xD_IDjgs0AvrnuKVl9tfImWNR0N2-rU_nei9UoqVAU1J6em0
Message-ID: <CAG=yYwnHhuWoszJrQzjVdsQ8jOnynO98O_KyTZGXyN-Z5TNY4g@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/314] 6.18.17-rc1 review
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
X-Rspamd-Queue-Id: 14A70256707
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224542-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

hello,

 Compiled and booted  6.18.17-rc1+
No new typical dmesg regressions
.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology-

