Return-Path: <stable+bounces-162994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9478B0639D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42C357B7336
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9D23A9AC;
	Tue, 15 Jul 2025 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="XQYyvOng"
X-Original-To: stable@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDC1F95C;
	Tue, 15 Jul 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595036; cv=none; b=Hr5LfIbuaprHsjKzTx0w4IJhmoQvUm1RmA+UTuJZYPCmn+Aa+zC04LmzWcF+rHpkasoVRhCtVP+Nvn3D6FxbfXzpDVGGYbHEtlJHuyykMNSeQ+5ci8zLL68JPXi6YfQa6Ar/yTl4IpCw+16pX49u3NsnvvUKT02DEwoctPa0OhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595036; c=relaxed/simple;
	bh=RM/DyyvFCuoPR2G/1M3cnV1rKEC9pgRNGVd1be7JIwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOKVt5ztGIfV5++mrxXVMk9CNRruZMP6cKpFQQjH8RD8C3isoyL0adfEc4sTI6UOBJYcdhnF0g3y0WDWlbqbkYQqNH3mhnRMCOyWF6+1Us5HB/n1VxTNv4n9AlYkqoE34/nmFFjkfauzOOJdFAKxDtj5tB3VSwc4axPBBTd2xeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=XQYyvOng; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=doj9c5g/LNoQwpGFEmtof3iDbmFEpLN+TDB7ER9gFC8=; b=XQYyvOngYyoXQ77q6o2//O39YZ
	lBi+/iPp/GzUge1LzhvV/XPl1Wt/AvZ9X7UaFL1H44JLFbZkmrltF1tsxKMWpYl1uJxvXTrnG7XRt
	tC0tynTQDpW+loiHViK7PUvNgS7ARdUH+v2RlfsVyJE/UEoam1GnbmSU88phk9ELF+VF/Pha+XU/0
	w0D9GMsQm0yJAojHI8Hm0IprUuotq7xsohOztr5ym0/2stYEQrwO9E9TLuCcOMuRMZrPgwW3SWRmb
	KDcK8DEnFbbtdi4vrehRD3Rj/N30uDsUZxOfgAcMJuurXvb1eFbgHuXIXu5jbIE5qs/DSf4MWO51f
	k8OIGWSH7/ykRcrhTOmTjFk+/REMQWqnWOjHfeFtqU995hNkI++Sjw7psQilpcb66RfYfCvgMZegR
	cSpy5IcZhyKgymkcH0vF2GQYCnuftkWW2Zq5amqf7qDGUQ54SDOF1utZcrA6VimgluhTBAXMeCtSP
	8Mf7IKFJqFYACRxTQRBFDP9s;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1ubi1m-00FUBc-1n;
	Tue, 15 Jul 2025 15:57:10 +0000
Message-ID: <28fde5eb-42d0-4e41-b048-d5b6f1593bcf@samba.org>
Date: Tue, 15 Jul 2025 17:57:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "smb: client: make use of common
 smbdirect_socket_parameters" has been added to the 6.12-stable tree
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Stable <stable@vger.kernel.org>,
 stable-commits@vger.kernel.org, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Steve French <smfrench@gmail.com>
References: <20250629142801.1093341-1-sashal@kernel.org>
 <e3d3d647-12a7-4e17-9206-25d03304ac65@samba.org>
 <CAH2r5muFzLct62LPL-1rE35X9Ps+ghxGk=J0FQPfLXwQeTXc6w@mail.gmail.com>
 <73624e22-5421-492c-8725-88284f976dc9@samba.org>
 <2025070824-untreated-bouncing-deb0@gregkh>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2025070824-untreated-bouncing-deb0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

>> any reason why this is only backported to 6.12, but not 6.15?
> 
> Looks like Sasha's scripts missed them, thanks for catching.  We need to
> run the "what patches are only in older trees" script again one of these
> days to sweep all of these up...
> 
>> I'm looking at v6.15.5 and v6.12.36 and the following are missing
>> from 6.15:
>>
>> bced02aca343 David Howells Wed Apr 2 20:27:26 2025 +0100 cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
>> 87dcc7e33fc3 David Howells Wed Jun 25 14:15:04 2025 +0100 cifs: Fix the smbd_response slab to allow usercopy
>> b8ddcca4391e Stefan Metzmacher Wed May 28 18:01:40 2025 +0200 smb: client: make use of common smbdirect_socket_parameters
>> 69cafc413c2d Stefan Metzmacher Wed May 28 18:01:39 2025 +0200 smb: smbdirect: introduce smbdirect_socket_parameters
>> c39639bc7723 Stefan Metzmacher Wed May 28 18:01:37 2025 +0200 smb: client: make use of common smbdirect_socket
>> f4b05342c293 Stefan Metzmacher Wed May 28 18:01:36 2025 +0200 smb: smbdirect: add smbdirect_socket.h
>> a6ec1fcafd41 Stefan Metzmacher Wed May 28 18:01:33 2025 +0200 smb: smbdirect: add smbdirect.h with public structures
>> 6509de31b1b6 Stefan Metzmacher Wed May 28 18:01:31 2025 +0200 smb: client: make use of common smbdirect_pdu.h
>> a9bb4006c4f3 Stefan Metzmacher Wed May 28 18:01:30 2025 +0200 smb: smbdirect: add smbdirect_pdu.h with protocol definitions
>>
>> With these being backported to 6.15 too, the following is missing in
>> both:
>>
>> commit 1944f6ab4967db7ad8d4db527dceae8c77de76e9
>> Author:     Stefan Metzmacher <metze@samba.org>
>> AuthorDate: Wed Jun 25 10:16:38 2025 +0200
>> Commit:     Steve French <stfrench@microsoft.com>
>> CommitDate: Wed Jun 25 11:12:54 2025 -0500
>>
>>      smb: client: let smbd_post_send_iter() respect the peers max_send_size and transmit all data
>>
>> As it was marked as
>> Cc: <stable+noautosel@kernel.org> # sp->max_send_size should be info->max_send_size in backports
>>
>> But now that the patches up to b8ddcca4391e are backported it can be cherry-picked just
>> fine to both branches.
> 
> Ok, will do.  I think I might have dropped these from 6.15 previously as
> the "noautosel" tag threw me...

Any idea when this will happen?

Thanks!
metze



