Return-Path: <stable+bounces-73617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B7B96DD19
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A416F1C22D2F
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161931A01C4;
	Thu,  5 Sep 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bJZQH+tZ"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A15F9FE;
	Thu,  5 Sep 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548498; cv=none; b=gpZL/1atCSIb/xZXtlxwdFDNYYDNPIJ/NyncyRIbapxrAern4i3T7AX7bYO6mhHsIy+l1drmZfixZCe/27S1KiNyXmfo/bekwYjFYCH2CSUnqwPAFpISgh22Z/A/CygAdZD8zfJA9rLfxdAOhHeoSJpddwDWrzei6Wdy2ztUzD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548498; c=relaxed/simple;
	bh=QNX9k0EhkSftlSw+ytM9MDQn1V6rNjj0MEIlRIe6jfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kukXRy0BvPnHeUQ7Hj919W+qqjYEk7zWKTIIN2+jBk4UhzDRrnUwbmib6Grq8XO7kM5cjw6KCD3oOAw9wpnA0z5PnpmqwJaxhgxrTF6Hr5OaxOk79bIv7BYt86UXYmWCv597Ix3kpQx+rnD4oD8lfzujur8/vZ3FFq1n10nL36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bJZQH+tZ; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4X02cw45lSz6ClY8r;
	Thu,  5 Sep 2024 15:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725548493; x=1728140494; bh=QNX9k0EhkSftlSw+ytM9MDQn
	1V6rNjj0MEIlRIe6jfc=; b=bJZQH+tZu/QqGnFFgMzTAdDDl3J9cKWM9NqnX94B
	wKXOqrKa+8Wv7lgLJj+WckzNa85pDdLdmMIbdubfsjJF7A5UCGKDoW1KhhKoEZeN
	Fzt9QLpKwY2VN/IaWZj3G/d8wa/uDdkhfgg8867tmfU0TVeQRblBYwdfUX9Jy/Fz
	ql6EW8FECYessWftUJ+6zQjSNAIAvVhVpEKdlyJt5BQBNIRIUsuJBzDBpq32oI+p
	FeqFDQdbgEt24MkwsKjdDAHIzPozReaKKWayYm/Z16HSQmZyVM9j8tdr9C4r4eDC
	5WuKq842FV9pLOPWnUqzsXFAtjDUrm6ARZLyWskMovAikQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kuwDBuB_07RQ; Thu,  5 Sep 2024 15:01:33 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4X02cq4PYrz6ClbFV;
	Thu,  5 Sep 2024 15:01:31 +0000 (UTC)
Message-ID: <bcfc0db2-d183-4e7b-b9fd-50d370cc0e9b@acm.org>
Date: Thu, 5 Sep 2024 08:01:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: roles: Fix a false positive recursive locking
 complaint
To: Amit Sunil Dhamne <amitsd@google.com>,
 Badhri Jagan Sridharan <badhri@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, stable@vger.kernel.org
References: <20240904201839.2901330-1-bvanassche@acm.org>
 <CAPTae5+gX8TW2xtN2-7yDt3C-2AmMB=jSwKsRtqPxftOf-A9hQ@mail.gmail.com>
 <8feac105-fa35-4c35-bbac-5d0265761c2d@acm.org>
 <d50e3406-1379-4eff-a8c1-9cae89659e3b@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d50e3406-1379-4eff-a8c1-9cae89659e3b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/4/24 3:34 PM, Amit Sunil Dhamne wrote:
> However, I have seen almost 30+ instances of the prior
> method=20
> (https://lore.kernel.org/all/20240822223717.253433-1-amitsd@google.com/=
)
> of registering lockdep key, which is what I followed.

Many of these examples are for spinlocks. It would be good to have a
variant of spin_lock_init() that does not instantiate a struct
lock_class_key and instead accepts a lock_class_key pointer as argument.

> However, if that's is not the right way, it brings into question the=20
> purpose
> of lockdep_set_class() considering I would always and unconditionally u=
se
> __mutex_init()=C2=A0 if I want to manage the lockdep class keys myself =
or
> mutex_init() if I didn't.
What I'm proposing is not a new pattern. There are multiple examples
in the kernel tree of lockdep_register_key() calls followed by a
__mutex_init() call:

$ git grep -wB3 __mutex_init | grep lockdep_register_key | wc -l
5

Thanks,

Bart.

