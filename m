Return-Path: <stable+bounces-222698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF4OGRPwpWlLHwAAu9opvQ
	(envelope-from <stable+bounces-222698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 21:16:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 666AB1DF377
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 21:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6256B300BE81
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731337703D;
	Mon,  2 Mar 2026 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFfiTmsr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5E3815FC
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772482573; cv=none; b=M3iaDqIFkV/S5a0AKi8f9lNDLxyfPNZ+lC1bgfKTH04DC6tDZz8sZQ1rlIyjWgHri5MF6JauqMPMHpcMRd2FM3BP34vyahWIHIsAm7d35J81ok7kjOSVYLdrz0DiIxleFAcTIkOli1E0ZdszyuynMTi7EcZ0kspicM4TKuEz3aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772482573; c=relaxed/simple;
	bh=QiZHOnA2eEBQfIIRE3IPtM7IP7P35q0D22E9DVanSgg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZPbhzqn6zYVyRNMTWttZabuyDGUdIEq3eNYsUM03+QFLIanpDsc4OtWYC2kPrd3ycDcBri4AGfBt4STKBE9anEjsl99ro2w5UT+8Gr6W0hXAmcbbIvfn1Y5RQLmTYjK40VCDIv6CTlfmfqHX/TynBJjR/yQIxjDRVcT5qGcLaag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFfiTmsr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899f5d337f7so16556166d6.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 12:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772482571; x=1773087371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rbwK3FD7LtGRl9qlEfWVEnZGUsD1TibT3/ibYFhrvs=;
        b=AFfiTmsri+Z1VVkbNZNAHXVTjOT2ncOho6hc4r97qJBZal95PYqjAJBLDXN771HiM4
         WYGFBLAS+j8TQUAu89xvjUbK+U1G8xbA98hXKk7zib4Elljo7Pp6yIOs1tSxBwE01T6G
         HDNhb9bDVt4fbuQdN7kwe2e96FDZ1/D1E7ApsgpfEY296YyZeaOvoKV2Q9XzKMvyX8nR
         uCW1sznTjdXL/LzMg5bvukwzJ3qOKLRNP9of5ltnxPWDrmwA+sSoJyihtHi4WWBS5UtO
         RSVm4RUR83OYT5TVrRMJZnIDn92dYevmHodfzZklCRA9Ov9Vz0Ob68PEqUzZKDeNvaA5
         AcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772482571; x=1773087371;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rbwK3FD7LtGRl9qlEfWVEnZGUsD1TibT3/ibYFhrvs=;
        b=raKRTu5rfKvYa6GU3tUm4vW7UwSoUykc1CO0cmy8oXMHAdmT+yb5BebKkOfRpJbbwJ
         LhWnyIAkP8OfOm8DiX9lV++HLpt2QTlkcbnZQBjq5dKsq4r25wqH8tC1BgUMy7cie5xA
         XnkI3A9GoR6DE4Dnuxg3+dcLSxSTvqp3mNGrD46g0fnH6TRplHuVXAkMlo4mozkvqKEH
         y6L5Xe2NejXerbqjwvtm6W5BJXYO6lyfq1r4KozXJOxCkXB8h6Xa9o7BOeWf/WQD+Kgo
         tsbhgyyRuZqjxohFPkoDwlqcO15LywIROMUmn3OFKtslpHAx5eo0VkjYpEQ+OJkEuW2l
         iAnA==
X-Forwarded-Encrypted: i=1; AJvYcCU0cB0bSdFvt0RHy6YsTa7hXQZLGnavOov+JV13ta2QvzzxUrFEgqeJIjJfd4fpl2CaPZ3M8Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPugKqkW+DUDlyL39L8E16iqfjRtbg5HhGzUQSXijPWyZVu5L
	70vE0LLyPXXKN86su0M/u/cAu6kxe5pnYp/PpMjP1vBiSS/DtaumscU=
X-Gm-Gg: ATEYQzwPd0SVB54A4mCm4651O2XlHkbFxaHVbJ2jkZdwLT3/QSIDSYLoVMikgHZ2t8m
	sCQd1UAGt1l8D73RcXhbqbXg2BjTPnXYCSRtR5t4hj5wUPtvEqU8lFbKQUxkUQX4xtk1M0J52z2
	sKFUgurR4QWx/ZEE/m84djHayYSAaNbeJPRCa4S+P9TlCaDCgJqTgR2WmclmBDQl+BR40VmNtoT
	gzvWKVswO+88Kl8Va3wn0KAhafacKMOlnfNAE/t8o8U0i6bt1kt4oMs3rJ9HMCG7AHaZbuKl2R9
	6FAZgCzfYIfjLiuTa43kkTw2aKisKf+Mn01SqnZatYdTuP2s6NqHkMoXjjDlSPE1Zwr2e83W0GJ
	EA0K2t3mnHsyhAQPQbKcFo/swUSi37aE7WzL4CxJeuurhdqRWF/WtU2ZeHz3fDPHHncE8t2ED8B
	6Rmp+nAordTpPuQ+XZVZij1TH11oS7+SzUfm/Yi+6+85UbAhc5o8M=
X-Received: by 2002:a05:6214:226c:b0:896:fe61:f79f with SMTP id 6a1803df08f44-899c6830c67mr237677626d6.33.1772482570992;
        Mon, 02 Mar 2026 12:16:10 -0800 (PST)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf658f70sm1212834385a.7.2026.03.02.12.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 12:16:10 -0800 (PST)
Subject: Re: [PATCH 5.10 000/334] 5.10.252-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260302161007.2523181-1-sashal@kernel.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <51684c7e-b6e7-698e-af2a-f36fca4a4a33@gmail.com>
Date: Mon, 2 Mar 2026 15:16:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260302161007.2523181-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 666AB1DF377
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222698-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Sasha Levin wrote:
> This is the start of the stable review cycle for the 5.10.252 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar  4 04:10:05 PM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.251
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
>
Built and booted OK and functional on an i386 machine
No problems noticed.

Tested-by: Woody Suwalski <terraluna977@gmail.com>


