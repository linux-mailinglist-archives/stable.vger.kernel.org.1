Return-Path: <stable+bounces-163897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE8EB0DC30
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC357168531
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08604C92;
	Tue, 22 Jul 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Tls3MW4L"
X-Original-To: stable@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0543A4B5AE;
	Tue, 22 Jul 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192570; cv=none; b=kwNYuS4juk40F/Pm9NebAmS8ggNNMg4jB8fcmfwYYLQ+QJSf9sx3u3TekAQ5o0NLR1zC/1RWY+WKxXYzSItg1/KfSksm4tkSsMjjcRj3bGp3C7QUhksUtLhi/IQVLAfasTv9WGkzy6mYVkT8JGZ0jDn0QBmm1cDX+4GY3Pzey10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192570; c=relaxed/simple;
	bh=gpBpR1FQJuMX2fCgh1OrU9q5t8muJ9mBoj4RMwsEWCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qsjx+zgoYqwAvTptgH9MyNYOOCsMn5aFjBVUabbKcc64q50n4M57E96IL4hSEedn6otHvmhx5qf1xab9e4yDpKRt6rIXlzXYsCyFyeY1nsU+Pyd2c/TPX1UQ1yq5XBGxQiA48gBjswFW19sZUk3PBhreFj+27RbFZv5juk1XSoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Tls3MW4L; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=GQZLr4XwiDz5xfx84lAnARvwM3D+8L+rLV3Ib6Syes0=; b=Tls3MW4LZ5XgTdYHPqjYubEwWo
	Ga15YddQY09dVVDhMNRNrALimO7mTBG971vklz0IumgauBTePDX/jjMfi3Kzt75gAbz0xNqXnupmh
	EKnIQrqFbDZJ47XmNc5G2Csio8Os/gz2xPIjXS99JE5FSninzVd0SWMmYXAw8AhJyxu3CVNS7Pgqb
	vce3/zD9PxLIVgyaqH5SoHrX5cjvjz20vAMONLIKqsOgJtZtgwRUeUYXmhyRDyOoTOEhaLGFaTT4z
	YTw2/H70aShZtmKtnGmP5fN3urTblY1NStQ2Ab6Y7ZdfIFZRyphCHQ++Bcsg4WA/ZBV8Jth+jv/H+
	0gTPO3Yyvkl3qFsbC0N+GoqsF80qr6QP/4S2KzNPKRoa1DYULr8UJaOEn9iJbQseIKcGyvGPkFMuD
	IQX2JjR7XmstoE9Clpm42jMZMPy1pSrA3Fgxjd4n20UqbUlEUpnzcxD9hTxEg0rjOvps2Sel6qBxi
	XXzBKuMzWJggijiuN6Kof7IA;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1ueCxa-00GSXN-23;
	Tue, 22 Jul 2025 13:23:10 +0000
Message-ID: <2f980e55-f9bb-40f0-88dd-f96dc45bc4f0@samba.org>
Date: Tue, 22 Jul 2025 15:23:09 +0200
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
 <28fde5eb-42d0-4e41-b048-d5b6f1593bcf@samba.org>
 <2025071523-recant-from-b56a@gregkh> <2025072253-blend-fondue-a487@gregkh>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2025072253-blend-fondue-a487@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

>>>>> I'm looking at v6.15.5 and v6.12.36 and the following are missing
>>>>> from 6.15:
>>>>>
>>>>> bced02aca343 David Howells Wed Apr 2 20:27:26 2025 +0100 cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
>>>>> 87dcc7e33fc3 David Howells Wed Jun 25 14:15:04 2025 +0100 cifs: Fix the smbd_response slab to allow usercopy
>>>>> b8ddcca4391e Stefan Metzmacher Wed May 28 18:01:40 2025 +0200 smb: client: make use of common smbdirect_socket_parameters
>>>>> 69cafc413c2d Stefan Metzmacher Wed May 28 18:01:39 2025 +0200 smb: smbdirect: introduce smbdirect_socket_parameters
>>>>> c39639bc7723 Stefan Metzmacher Wed May 28 18:01:37 2025 +0200 smb: client: make use of common smbdirect_socket
>>>>> f4b05342c293 Stefan Metzmacher Wed May 28 18:01:36 2025 +0200 smb: smbdirect: add smbdirect_socket.h
>>>>> a6ec1fcafd41 Stefan Metzmacher Wed May 28 18:01:33 2025 +0200 smb: smbdirect: add smbdirect.h with public structures
>>>>> 6509de31b1b6 Stefan Metzmacher Wed May 28 18:01:31 2025 +0200 smb: client: make use of common smbdirect_pdu.h
>>>>> a9bb4006c4f3 Stefan Metzmacher Wed May 28 18:01:30 2025 +0200 smb: smbdirect: add smbdirect_pdu.h with protocol definitions

I see the above in queue-6.15/ now, thanks!

>>>>> With these being backported to 6.15 too, the following is missing in
>>>>> both:
>>>>>
>>>>> commit 1944f6ab4967db7ad8d4db527dceae8c77de76e9
>>>>> Author:     Stefan Metzmacher <metze@samba.org>
>>>>> AuthorDate: Wed Jun 25 10:16:38 2025 +0200
>>>>> Commit:     Steve French <stfrench@microsoft.com>
>>>>> CommitDate: Wed Jun 25 11:12:54 2025 -0500
>>>>>
>>>>>       smb: client: let smbd_post_send_iter() respect the peers max_send_size and transmit all data
>>>>>
>>>>> As it was marked as
>>>>> Cc: <stable+noautosel@kernel.org> # sp->max_send_size should be info->max_send_size in backports


But 1944f6ab4967db7ad8d4db527dceae8c77de76e9 is still missing in 6.15 and 6.12.

Can you please also add that?

Thanks!
metze


