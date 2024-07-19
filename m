Return-Path: <stable+bounces-60584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A710E9371F7
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 03:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4343CB2169C
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 01:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA41392;
	Fri, 19 Jul 2024 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MbfDLs2j"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8236137E;
	Fri, 19 Jul 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721352196; cv=none; b=TBTnRojTKc0wb2jlx2scCZAK/xiXcXWYpbqnr6maKin9D+Y+symVJapR4o8RaoGpc/0fDuDE7QlvuupatMqUa9ruTcRwIWc5Zd/7OSs2lrSHYOUPhoG8Du93t/m/urhMP7rlji1+OsIsO/eEl/AzcwvcMtvKtkrFfV9Ufp0SKog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721352196; c=relaxed/simple;
	bh=9slxfzWz0uwt61aR55Fa9G5Y5+hoR5YB70Hqbt/WEFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LvwQ583v0vGt7LCbxPqL3JZeAWqNv2xmTWJi31Xj6P7m1SywedbzkDyC6G8LLT8uPcUqFy6T/A8b8pJ22J0xKAYznf2a70snmeaoAGwjnU1evVRPL1NUX5qB2YwZpF3IQ6PD5lwHq+nNknjCCHEQsfNQ7TuPp7z6ACBBKuV0Xz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=MbfDLs2j; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721352189;
	bh=kks5Td3BcJE2RSambxKy4mn/i2Umcsqm6PazM0dpxEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MbfDLs2jhrxzlosqAldNpwILIjvnNJGzd0tmsec4SXfEz1RrVrP/1XZs0EHnBBIhZ
	 vzCu7L59n4+mym/xYHGUjXIEfr+fftayKQJaCXLz1qYkv43pZh6+k1jctSjfB1c1J+
	 9OlzCjWqkniw7UJYTy/9QWPXsThK3M0OsxZTTnMzLPd/6a23yF1G+kxFaS5B86P0mN
	 6m0DBVRkmTthHkG8lbc9W2/VEeFZ9fGWcoo4E7zAUMgfXw8mYFqpH1GTONguI7po0W
	 Clji9mgEBRVUBGC83avR6OjFcsWPY/xWrLln/vTgdx+VvmtDkfaOs3m40H33UQnzfk
	 cH+ftEuIscXJw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WQBkj0Cgrz4wbr;
	Fri, 19 Jul 2024 11:23:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ma Ke <make24@iscas.ac.cn>
Cc: ajd@linux.ibm.com, arnd@arndb.de, clombard@linux.vnet.ibm.com,
 fbarrat@linux.ibm.com, gregkh@linuxfoundation.org, imunsie@au1.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 make24@iscas.ac.cn, dan.carpenter@linaro.org, manoj@linux.vnet.ibm.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v4] cxl: Fix possible null pointer dereference in
 read_handle()
In-Reply-To: <20240716132737.1642226-1-make24@iscas.ac.cn>
References: <87y163w4n4.fsf@mail.lhotse>
 <20240716132737.1642226-1-make24@iscas.ac.cn>
Date: Fri, 19 Jul 2024 11:23:07 +1000
Message-ID: <87msmew4xw.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ma Ke <make24@iscas.ac.cn> writes:
>> Michael Ellerman<mpe@ellerman.id.au> wrote:
>> > In read_handle(), of_get_address() may return NULL if getting address =
and
>> > size of the node failed. When of_read_number() uses prop to handle
>> > conversions between different byte orders, it could lead to a null poi=
nter
>> > dereference. Add NULL check to fix potential issue.
>> >
>> > Found by static analysis.
>> >
>> > Cc: stable@vger.kernel.org
>> > Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
>> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>> > ---
>> > Changes in v4:
>> > - modified vulnerability description according to suggestions, making =
the=20
>> > process of static analysis of vulnerabilities clearer. No active resea=
rch=20
>> > on developer behavior.
>> > Changes in v3:
>> > - fixed up the changelog text as suggestions.
>> > Changes in v2:
>> > - added an explanation of how the potential vulnerability was discover=
ed,
>> > but not meet the description specification requirements.
>> > ---
>> >  drivers/misc/cxl/of.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
>> > index bcc005dff1c0..d8dbb3723951 100644
>> > --- a/drivers/misc/cxl/of.c
>> > +++ b/drivers/misc/cxl/of.c
>> > @@ -58,7 +58,7 @@ static int read_handle(struct device_node *np, u64 *=
handle)
>> >=20=20
>> >  	/* Get address and size of the node */
>> >  	prop =3D of_get_address(np, 0, &size, NULL);
>> > -	if (size)
>> > +	if (!prop || size)
>> >  		return -EINVAL;
>> >=20=20
>> >  	/* Helper to read a big number; size is in cells (not bytes) */
>>=20
>> If you expand the context this could just use of_property_read_reg(),
>> something like below.
>>=20
>> cheers
>>=20
>>=20
>> diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
>> index bcc005dff1c0..a184855b2a7b 100644
>> --- a/drivers/misc/cxl/of.c
>> +++ b/drivers/misc/cxl/of.c
>> @@ -53,16 +53,15 @@ static const __be64 *read_prop64_dword(const struct =
device_node *np,
>>=20=20
>>  static int read_handle(struct device_node *np, u64 *handle)
>>  {
>> -	const __be32 *prop;
>>  	u64 size;
>> +=09
>> +	if (of_property_read_reg(np, 0, handle, &size))
>> +		return -EINVAL;
>>=20=20
>> -	/* Get address and size of the node */
>> -	prop =3D of_get_address(np, 0, &size, NULL);
>> +	// Size must be zero per PAPR+ v2.13 =C2=A7 C.6.19
>>  	if (size)
>>  		return -EINVAL;
>>=20=20
>> -	/* Helper to read a big number; size is in cells (not bytes) */
>> -	*handle =3D of_read_number(prop, of_n_addr_cells(np));
>>  	return 0;
>>  }

> Thank you for discussing and guiding me on the vulnerability I submitted.=
=20
> I've carefully read through your conversation with Dan Carpenter. I'm=20
> uncertain whether to use my patch or the one you provided. Could you plea=
se
> advise on which patch would be more appropriate?=20
> Looking forward to your reply.

Your patch is OK, I'll send an ack.

If we want to refactor it to use of_property_read_reg() we can do that
in future - though this code will probably be removed in the not too
distant future anyway.

cheers

