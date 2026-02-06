Return-Path: <stable+bounces-214589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDm+Oh1ghWmbAwQAu9opvQ
	(envelope-from <stable+bounces-214589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 04:29:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48408F9BF8
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 04:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E88C3034DD3
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 03:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6BB32FA3D;
	Fri,  6 Feb 2026 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtmCN5Pf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C034330679
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770348516; cv=none; b=EgzHbgBHWps13/SzFriXTqAtcQgpn64UVPJRwjM4ihULRBP2/lgYqHGXFjdxgFnQv+SQjZnG8TADQcs/J4Z/vPuqidYbjbMaHaJWToor6/eQbIRBRWeYBPqNqKuD4y0E3fjVT6DXbuuTJaOqX/GMxoGGh1Y+Tk/RduHOZj/qMzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770348516; c=relaxed/simple;
	bh=bJ5FyF++Qn0V/alJB5PnyERciNW/hsqnuYUYYtjjhrI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DZIQ2QXM+8I4vdytLsf/SHDGZJEZZ0dwEmYxBotehXlZkypDiCykw8dN00gH9juSREOjo90U00SrPNlIsTdEq6I+HiZChxfMT5/sEpBHxUsKWCUUem4TqE22Sfpxlb4S6mpd40UYKkn3OKE1SaymEbByLNf7mg1+kXohq7De/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtmCN5Pf; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c7120353f1so23926885a.3
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 19:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770348515; x=1770953315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLFKnS0Qz3BpsY1wE5tqNFwzwMS4WONoSx3uLhiGa2s=;
        b=VtmCN5PfhZmsWXm6ZRWNOGR4c8rm818vt+QUJJTeWpwzV/ZQpL5/z9PhImgI6mzz4y
         7f1DjYgkaifgT3z97eS6N4KA+FCwjbJhYQdRaVI7sLVyjFhiJTHo5fPcwYFiaJK74cnz
         SmcCFOA/hZShOWfeAqpa4PyIa9Jxnh77I9O8+5jmRigGFDcGIyXAJFVsVkfrpNmcCVOj
         IFZaRLFuV23BkhXewMqpDXw3Ku/TKDdFF+BLUs7p1qWHRAtUg237buYn+dt5kjiu4fFZ
         LevN0ncjk9ykF+CcAEqJdPrNIa0l2StKlO2HGXTIpx2qq8eeJzMsPrhV1j0mhDVLyClU
         hzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770348515; x=1770953315;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLFKnS0Qz3BpsY1wE5tqNFwzwMS4WONoSx3uLhiGa2s=;
        b=dUSe4WfT3O/h51B6PdpZtNLBYvEeKGXrtZrltEsyNrinpQnMD5BqzFFny7emFZASoZ
         Kvnvn2dieXvRI/E7SN5I8fh8KAsclQzbyZ8Q4dwyBNA3rDDftIfb5SV5BXCCETBjkX7z
         lmo25CIMYREEbpKmLEgExM7ulqS/NcSAjEAXTsIGJeZp4qumAJrTBYVwAeFByB5ngYxw
         ZtzcdzqZCZotgyoxc10O5gbJiN+6HHaJwhfPFfFy60GuPdAQo2cDKDI9IJBxgwlAlgmn
         iOap7Ul1EKTG5Rd5DRCnJrA3Vl7mOwOJDIoGbzSZVBxPIRsMJDM3g695boqrodk/QvkQ
         n8oA==
X-Forwarded-Encrypted: i=1; AJvYcCXmBt6jpJWDReQkyWJvRP4n3r/jxb36K/zeIbX8S0TRZaL1Ja1RKpp59L4GxbIFunBL2HqJC6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+sg6nNAun2OOxGpG8IW3Nx1aoVDg+OVkn+t4YF5X8MrL8Blt
	sAza7YN5WJT9pMl/wrZWMaGN9wrwxCkIesQ+NpOzcm/RcHd5IJS7Uc4=
X-Gm-Gg: AZuq6aKyl2EX8RNeTQr3M8PUOkU0LDPdarFzmilTKgvYFG0679Jzv+wcGKF9jb2aqLy
	lbsdcpmBhkFIqm2DsfocPhs90wbuXk8XyjAru62kd9nBoMdFwoTTzp8wSsgZ0X9u6Q/4AWUuBjo
	VQ2JIFzzsHlYkpzEX15PSbJ6qRUF3BEvPAEgO3OZZcZEBdBDH/Q3oW7J9zDkTrTkRi9oTYzWvFQ
	ffxtHih9vFmtGJLOlg7BSIlIluva88n3cg9+VjBvOqpOqNYyGC/sl4gN+ETNKKiANwYGOo5NtG9
	JVWBM5q9s9dkv6C/UUNAKg4Tix20ZAPkZKjnNvazbKcNVUo0gDqnw2j5hziNqsz0LS7hYh8Kv7c
	LyZY8NmhXfFdudjV9/K4n4xWziFyyJ4KWQWMP5bnd8ohL8pVxg+eVRVe6ICEdTgFCH/UaY5v3Du
	Ae/aPzl1Il3NRu/YG5MiJ3A516WnN4bIauuTCoz52LrJKQgY+FSg==
X-Received: by 2002:a05:620a:371c:b0:89a:2f9b:10d3 with SMTP id af79cd13be357-8caef409093mr169383485a.30.1770348514936;
        Thu, 05 Feb 2026 19:28:34 -0800 (PST)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f6c16sm71312585a.10.2026.02.05.19.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 19:28:34 -0800 (PST)
Subject: Re: [PATCH 5.10 000/160] 5.10.249-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260205143430.733102763@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <245e7367-8ef2-daa0-b856-540870e75254@gmail.com>
Date: Thu, 5 Feb 2026 22:28:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260205143430.733102763@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214589-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[terraluna977@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48408F9BF8
X-Rspamd-Action: no action

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.249 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
>
Tested a 32-bit build on an i386 computer. No problems noticed.

Tested-by: Woody Suwalski <terraluna977@gmail.com>


