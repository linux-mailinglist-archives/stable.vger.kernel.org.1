Return-Path: <stable+bounces-73105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9065A96C96D
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 23:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8C8281CFF
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 21:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0D316C69F;
	Wed,  4 Sep 2024 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0UzoVCUg"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30213B7BE;
	Wed,  4 Sep 2024 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484539; cv=none; b=Ve5PuxVTYS3t4RqT2JxHetZtJbcNK/f0p2OL7G8i+e1pU3nx7r+PD/XiZny/Z2N92iwoL8KzttJ72qBAOP7JaOutt9F7DTx1fdZ6fwFWJhA4f6n5ewm9Eh4tiIPsxdnwjSM/Q5N5KOW3xRtIxc9MC7S63/qHlxX7zVS5j6deUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484539; c=relaxed/simple;
	bh=0mf2sOICvR37qlpEb0StE7Dg6D5eD0OHMGownOtYVNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BU9tTSTAovzpjdmGFhDJ6OHBnyJ/KoawdcGmVHa2DuDZdg3cgD08T56t9Cbf1slPT6mv94Px+oe+K4g5WKB3xOZi41erQAACCBSScC+n8AMF6gYa1pIYNh2xumBlbsCfT3bJ4vuNeEM/TV2ros4WniPikGtPzQFAV+bIhSNkfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0UzoVCUg; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WzZyw5gTgz6ClY8r;
	Wed,  4 Sep 2024 21:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725484533; x=1728076534; bh=PTn7uCqr87nKGbsl+iekTpqH
	Ya4PCS8/oEzxgwQOmZ0=; b=0UzoVCUghDvPlnDLptJ5hlxAyC1oIBPLCHk8A6mB
	UH5tdR2gsNKYMZKLntppjSPyJtGIvHs4JxM2Pgq02M4u2rs2JTPIupb7LI9NFWoJ
	DujqorQCY4S4lu/R8dpm9B4cBSqbwBfwAynesb3gMSimyoSpCOJPM5EHKVQAnvLq
	Aetw6NT5mbPXJOnqvQucacugUoav9wvPxaxCMEjdXJxvqy5Wv7Sq07HjQr1N/daH
	GintJ+BB0RQgFBzz8uT6A/QiTwXPbm6m09mBun2DKqx1V+lKRSkLUM4S3W7iXMIn
	vHarNPqrp/uzl67NQDYS4p+ZSlOuyoMpcZ9eXVIyfjbKAw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OmQzftKipDjf; Wed,  4 Sep 2024 21:15:33 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WzZyq61hVz6ClbFV;
	Wed,  4 Sep 2024 21:15:31 +0000 (UTC)
Message-ID: <8feac105-fa35-4c35-bbac-5d0265761c2d@acm.org>
Date: Wed, 4 Sep 2024 14:15:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: roles: Fix a false positive recursive locking
 complaint
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, stable@vger.kernel.org,
 Amit Sunil Dhamne <amitsd@google.com>
References: <20240904201839.2901330-1-bvanassche@acm.org>
 <CAPTae5+gX8TW2xtN2-7yDt3C-2AmMB=jSwKsRtqPxftOf-A9hQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAPTae5+gX8TW2xtN2-7yDt3C-2AmMB=jSwKsRtqPxftOf-A9hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 2:00 PM, Badhri Jagan Sridharan wrote:
> https://lore.kernel.org/all/ZsiYRAJST%2F2hAju1@kuha.fi.intel.com/ was
> already accepted

Thanks, I hadn't noticed this yet.

> and is perhaps better than what you are suggesting as
> it does not use the internal methods of mutex_init().

Although I do not have a strong opinion about which patch is sent to
Linus, I think my patch has multiple advantages compared to the patch
mentioned above:
- Cleaner. lockdep_set_class() is not used. Hence, it is not possible
   that the wrong lockdep key is used (the one assigned by
   mutex_init()).
- The lock_class_key declaration occurs close to the sw->lock
   declaration.
- The lockdep_register_key() call occurs close to __mutex_init() call
   that uses the registered key.
- Needs less memory in debug kernels. The advantage of __mutex_init()
   compared to mutex_init() is that it does not allocate (static) memory
   for a lockdep key.

Thanks,

Bart.


