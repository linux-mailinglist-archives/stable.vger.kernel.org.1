Return-Path: <stable+bounces-214649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKBRFZHchWn4HQQAu9opvQ
	(envelope-from <stable+bounces-214649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 13:20:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F3FD8DC
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 13:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D24D8302C6D8
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E723A6416;
	Fri,  6 Feb 2026 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="bUn1x37p"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BC36403B
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380425; cv=pass; b=pkLn+pBvJyem4FlncSfU11afLR4iKpDeILJn/tIad5idjJeM/n8MSCmbdhAk5faA7v5EIoNtSatGVJ8WVo3rQx2epPXX04Beu2xhyzrSXtTXPpbGQqGRRWN5QaukyInIUnzzxEgpcqzgWYaTfmh2W0Za2p6ZMEd2c1YQP7//pj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380425; c=relaxed/simple;
	bh=9o8InaWTZb597Fi938SXKzY5rbjZh9U5efUq6SDLN+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLTGSJb/JQ5bw6Bv5/TwKhrHNcDc2NytpW1a8zrE4k/CO4fuFHsuVEadPaKC0jidteMcoYlBEShT45ZgU9dFXjbQcfW1fKBhAEUjpASEzg9YGWwvPnhQObrGMvBS/+Wi2wh5FFRARMgoQaliPd/af0CzNZt/hWHI5uRayEcT1Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=bUn1x37p; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b885a18f620so320271366b.3
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 04:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770380423; cv=none;
        d=google.com; s=arc-20240605;
        b=job/feH3wH98k+2ZBFu7Q3rraBDLi74bQLoUQtyt1xYbdoBVvDB5GqibI5b8PVMtrq
         ljtFLeUMOxJqz8S+bSz8ScTSq2pQRPIZrgJwWeGhh5sI4GpeyP5k4vln7NlkrEp+T/qt
         zOC48C2D8hPM5lWjw8YtheICmK3FOjYXyvUlF+SHurbcwaAYeyn0a2aJLMY984ftbzY5
         s3oQJApGqko96RZL+FyfE6s0cHgLEKq6SYTUEZX7nF8ccep5loW4liudn/n6kKsC2y+e
         3eF5o64qsbkDVX3RdN6x48Xj46AlXjRfbI5XYjUVXfIf1OWF5Fo7ja5dDkchwxBtepYg
         T2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ww3WAcYanjaqfuoWJvkL5Bn0TINg2QlY1NQwCBCryz4=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=NJDk5h7GhcNuP7dlLQzgawabrHSU6bgEBc4DwIMcoZNBLyj3fTgLRqrWLuLRME1a/T
         HB6FV9YDKquuGiaB5tS2DThvXsvk8QETfaidb+RQvRLRskGDXh/B5lHwuHuWAEYFPZTu
         +wChH4Nh7JAMhMHoH9GyxvgPhAq2f7wx3esj8nrBcOL2du2hCcyE3nim8/BmuadMnvN5
         G44FKPLpM4zgZpkFJ13lhzkjuNzovcWq2xZsJ2c3GiYZev3O1/Xbo9AkVnEsqlxn2ddY
         qFXxStifGhdu14ozDMRPKilJ4h2t2He4KvIz8kFg9gBnBO8tw6auL+UiCRROf1v7m/ZZ
         n+JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770380423; x=1770985223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ww3WAcYanjaqfuoWJvkL5Bn0TINg2QlY1NQwCBCryz4=;
        b=bUn1x37pRBFuBI0bqctSwH1yNGUN+2vgREhLxjAc2AHwMUmRTP49u1DTHh8uSNG+Jn
         FzzcRBLy1X2K6DXRe7gVf5+jlG9owxdvN82BYtJvuyKyJVeS5mWdCp459XJEXEBZjrO5
         ENXoj58yRT6uJm/r1PDAlBf/8316WZa324udV8pMldxZ4H1XFFq5fZEicwPk5z9fmxVY
         kMXc0Wz6yL3TXtG9lDDyaI45pk9juBtwFN+a1RC8nh8vbgYpxphYMNuYKkEn1U1DNuWv
         sZ3vw3SoH5vDl1u5f546o0sO2FJrqgAa/V0XRBmxIqv81MiOo8V0qiXA/5TZeLsGq+l0
         HMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770380423; x=1770985223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ww3WAcYanjaqfuoWJvkL5Bn0TINg2QlY1NQwCBCryz4=;
        b=hKBr0gm38wk5Sb91ul0LxezU7H5auTgZ3G/qcUd1mKa35t9ByTSU2IVDj1418RWipw
         3OyNlzkkAPEwfetX42CV3O4jMeQFF9uQX77MOeWAUQjCVeaikebEJuvun/iEUsg1BKtc
         1YaXlUNwNbqfhLaYtL87pEvd5uLlOTZjVQcv2Gj2UtyK0AF+nof1ynjQy3cXbtklWjvk
         hesrNbkObsfc9aGVbrJTl3zwInCr6dQkLUsDE8naodrqfQyQG7eQ4CfuFVlhSL35GsRN
         OhUMbLfkZZYS5JwnyP7npSHiDIhTzYTVHktPKf83D/CBhCFYHario1+/NvBDPd4wOTh4
         RLHg==
X-Gm-Message-State: AOJu0YxEsSmW6dQ3kZk/XU+rsCWNvLjQho2ambUabekGQlwmyssW7clG
	dj+7Bi2WFpZB5SDbb+UzUrP6jimpnj9dhQc5Spzlutv2vqWG7Mv7aqAUAUzpzz6lCVnKwIy+MsR
	gywD8GOYQWKPBQrPQAJj+DE60+FUxz5v5xq6EZEBE/w==
X-Gm-Gg: AZuq6aIjaZdlUl6KCMoHdJA7251GtYJ0lK0eB8uZgU8WJK1dAlaMRxH00bmePNdLHqq
	5qpWXGHdGHmiiOLHw5qH77xQiNdueHPWNDk5dHSUkluUJkAHf9HWBRHS/geBW0b01u9phsKdHJj
	brpGIH6pOaBBegWyMnzd9QvdOjBKsk02SJkej7nSB3poCMy1yys8a4Lj5WYUygHk36e/mYDVVnw
	eOb0m9xaB39bPZf7eMFQycRRBQQXSeojc3FYp6yboZn7VSvUHB4ZEn1D3M7pK++3jvLA13+2/9T
	iEI50N4=
X-Received: by 2002:a17:907:7f8a:b0:b83:1433:78de with SMTP id
 a640c23a62f3a-b8edf11f5e8mr150924466b.12.1770380423166; Fri, 06 Feb 2026
 04:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205143430.733102763@linuxfoundation.org>
In-Reply-To: <20260205143430.733102763@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 6 Feb 2026 17:49:46 +0530
X-Gm-Features: AZwV_Qj1YqeNbmMT3LsGVWGp0Sh4JCxHwdu6gLV0DjiIk9Eam7yGZ7WM-10DF8g
Message-ID: <CAG=yYwnDVbTB3Y+zX8yLATGRKeZzSXNu-eiU-ABReZhJ0vep3A@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/160] 5.10.249-rc2 review
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214649-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rajagiritech.edu.in:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB1F3FD8DC
X-Rspamd-Action: no action

 build error  for 5.10.249-rc2

------------------------<screenshot>-----------------------------
make[4]: *** No rule to make target
'/home/jeffrin/kernel/linux-stable-rc/tools/include/linux/compiler_types.h',
needed by '/home/jeffrin/kernel/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o'.
Stop.
make[3]: *** [Makefile:179:
/home/jeffrin/kernel/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o]
Error 2
make[2]: *** [Makefile:48:
/home/jeffrin/kernel/linux-stable-rc/tools/bpf/resolve_btfids//libbpf/libbpf.a]
Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:71: bpf/resolve_btfids] Error 2
make: *** [Makefile:1978: tools/bpf/resolve_btfids] Error 2

--------------------------<screenshot>---------------------------------->



Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

