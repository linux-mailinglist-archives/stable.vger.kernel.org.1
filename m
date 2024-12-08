Return-Path: <stable+bounces-100067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9339E8589
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 14:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138C21649B6
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220EA4C74;
	Sun,  8 Dec 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiYYhRh1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248861482E8
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733666009; cv=none; b=SDBdmxaIDiuxJ5BPnZZhN3B1Uqw/C/UdHZpuc1WGBSIFvyyraPlxX67QEqezI8kkKvNdI7M0UQ6LpA1lDmJ0S7lXbThtUO0KljvobWo9MTxdUu2mnpy0IHTPl4kpXubnco27IscQ6BvAygoe4bx3jnLpamK57MOo/BafS5vX5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733666009; c=relaxed/simple;
	bh=6vmI2rNzZbPbg2XeKr3Oe5TOFkJlJ7i4jg3roFC7Oqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMpULxaBzHinNC68hIhSEe9532qXpWpEp8arHIEh2XKa6owIVG8VCRmh3F7bwWlwt2yFchzJtnvdxbaBDpbs4qLczj3bvZYZdzH5gomzu5XEIIm/7WC1TnFtBuXQ4HXOL0zQ9fUjCN5Cf1w/If8EWN8RnYjqcRn48JW6ei5tiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiYYhRh1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733666007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=effItv+T4ngQBiRIY7XZjYM5/CDQslMyXd/pUoX0ZDs=;
	b=OiYYhRh1DvNgwST7PW1oW6sit2k4wTTypdTJX6R37WnFlDgrMv1NTlzVH1eRXOFw7eyNiE
	w2IepBNUsLk00GQlEIHNRAfvrDp9YO8S5/eRi+65T0iRFLDKib2FZwB61T8O4/LbZLskFf
	qLvTSDk0dIn4W8z12MDJABtLikEUGpo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-u6EY12fbMjmouQbUJuYTlw-1; Sun, 08 Dec 2024 08:53:25 -0500
X-MC-Unique: u6EY12fbMjmouQbUJuYTlw-1
X-Mimecast-MFC-AGG-ID: u6EY12fbMjmouQbUJuYTlw
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d3cdb9d4b1so2429098a12.1
        for <stable@vger.kernel.org>; Sun, 08 Dec 2024 05:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733666004; x=1734270804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=effItv+T4ngQBiRIY7XZjYM5/CDQslMyXd/pUoX0ZDs=;
        b=fv5KnCc9CnB2MJWuS8RIyiJ4N+GBcGEFvkHwFn1/aDQniftOBxE1OxMs/n1mYXEDX4
         MP/rAOMJitdqXSfpd6bANY9IhLY+o5ro9mHtqVLsX10vJRA6zDGqW/MrIwQVZpFFrPY4
         oLkq3AJTwgwncn82Klq+eqJP3Ho3E00iupLmpg1vtR2T/W7f3/hYsjjUxnMuuwkSrDTn
         R2x1ZlwTG2UgXkY0sgfp1cfUgCJdjZkLz9NxlhoQyfmTmyJYMne5AtXUuNegGkKPDRCD
         981N1/ISNcY2mpzO3T7cARKD3W0kxqKBKPm1dcN7q2oGJ1ZRCro9WZLlcoWw9c+xxdVa
         uuUg==
X-Forwarded-Encrypted: i=1; AJvYcCVAH2kQFCVy4H9h40XNxWnM+7biVBW310MdSRNwEzSqbpY+LYl9atPi33YDnyHMlBNH6LorvvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6F+DAQd/bzd2bZMWIm89u7fz07w0XdOqTEqesY0iQNy6OkCYT
	fPyrsEhJH+eHM8mDm4scaroUpyrQcDuIU9//+iWEftaQ+4lfmiaFcYK/echKX+eHmpd2X92LccN
	gtcuwB+/4FZn9iluEGrotqCcq2XErwdFb/nDGGQT5NEflxJFvuj9oOg==
X-Gm-Gg: ASbGncuog8oIuubWHPIgjA5zjuOwMbiQokxynYkLhroYvSrJCb+eW/PPE0Gh3uFGxbk
	5XxJfkwnX4iVWclkBhI5Pt7QT8tbb210H3crQPeHuUlKbC6yp3Tqgt1ndHIZWw5BzBj+DtIIa8S
	r3wjzZQmFQ2Kv+3M7kuMnSEv+z6bhRYB/a1FhLEWpbw6dqDD9zPM53rVWuJ07G4KP6UcUMB0fn0
	17t8KMw9sNJD5VxTqCrSkRhsDeX3gNzdPF/07dfVHE0yfuBUg4taYAwCcBs+DEq3D+ZRnZ5Q9Ie
	0P3F7jYWCctbuBFQ1cjzlGWi2RBIJ7pc94b2H1LJTotdJ8WeHQccb3/KLwQGMyqL34+vAnLvt+Z
	ObkzTyFnGYxKKNBK/rkH4vxzO
X-Received: by 2002:a05:6402:27ce:b0:5d0:d06b:cdc4 with SMTP id 4fb4d7f45d1cf-5d3bdccdb54mr9000815a12.15.1733666004586;
        Sun, 08 Dec 2024 05:53:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT6Q+gAyU4Hw06qKdr07+MmMs8jMXgZWk7VUDrfXYZHJ4HC8iwAV1xJFoNInSvuusyWJSJdw==
X-Received: by 2002:a05:6402:27ce:b0:5d0:d06b:cdc4 with SMTP id 4fb4d7f45d1cf-5d3bdccdb54mr9000794a12.15.1733666004181;
        Sun, 08 Dec 2024 05:53:24 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d20c032csm2944939a12.36.2024.12.08.05.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 05:53:23 -0800 (PST)
Message-ID: <094431c4-1f82-43e0-b3f0-e9c127198e98@redhat.com>
Date: Sun, 8 Dec 2024 14:53:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
To: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, stable@vger.kernel.org,
 Peter Robinson <pbrobinson@gmail.com>
References: <20241107140833.274986-1-hdegoede@redhat.com>
 <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Nov-24 3:23 AM, Ping-Ke Shih wrote:
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> The rtl8xxxu has all the rtl8192cu USB IDs from rtlwifi/rtl8192cu/sw.c
>> except for the following 10, add these to the untested section so they
>> can be used with the rtl8xxxu as the rtl8192cu are well supported.
>>
>> This fixes these wifi modules not working on distributions which have
>> disabled CONFIG_RTL8192CU replacing it with CONFIG_RTL8XXXU_UNTESTED,
>> like Fedora.
>>
>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>> Cc: stable@vger.kernel.org
>> Cc: Peter Robinson <pbrobinson@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> 
> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
> 
> 31be3175bd7b wifi: rtl8xxxu: add more missing rtl8192cu USB IDs

Thank you for merging this, since this is a bugfix patch, see e.g. :

https://bugzilla.redhat.com/show_bug.cgi?id=2321540

I was expecting this patch to show up in 6.13-rc1 but it does
not appear to be there.

Can you please include this in a fixes-pull-request to the network
maintainer so that gets added to a 6.13-rc# release soon and then
can be backported to various stable kernels ?

Regards,

Hans



