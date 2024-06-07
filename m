Return-Path: <stable+bounces-49985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57539008D0
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 17:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FD71C22047
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDFB195F23;
	Fri,  7 Jun 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZApM5A/M"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183A194C68
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774016; cv=none; b=Mjr8mI1FoYF3adeh76D2z8EXL8ixnJGIMVtJdbofHQ7g+F3TeoyB/OQIUkPYVsR0PyxYJLJT1+wFyy3urZgbYp2XFNlaA7i4mQM/ZWQ3u6SyMsbYQe4Rvt6t5T3GkvMGX6iq/hz4SSD8HuqctDJiRiuhZbmhl9DtOpfU/bDKNNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774016; c=relaxed/simple;
	bh=rOfg24Dcz8QAnnEvfYvkHk1NUSiHhQLDhQ0iBZ8jknA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VixyA3X6qTjxgdR1/u3fRksReRnihzjGAHpYBeTdY0lD2lXJPDV6OXFxmyeU5mxZ4Y3fIClziWD77sZ5vn5k3bzUEY3gBRMwBhOTTOHLSfJFmzDbE6M/A1hL9BZNGAX/nmjDnfEfFDHkxR7CMPdqnwIuBb98ivB2lmYjsrV0Xa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZApM5A/M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717774014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D/A+3bwK+p1bXr6ecFnn0y362Acz3/hUX82Z0aoQCc=;
	b=ZApM5A/MngQyva/wmOk/b1ts+WbaDzbtahPMRong45yMe2ItdBsQ8rCAd/JUdLSIEaUTHE
	G3SeIu02XSQzUutq8fDDRXootINEF2/1RSOAUAe1svr7T6jLoefxEMrpHdEuo6df02PPfv
	jTIXaZXqJBKhD+RywIssR6ECzuE1P68=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-VZAtAOTfNbWHCQk8iDQu7g-1; Fri, 07 Jun 2024 11:26:52 -0400
X-MC-Unique: VZAtAOTfNbWHCQk8iDQu7g-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57a2fb28a23so1784856a12.3
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 08:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717774011; x=1718378811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D/A+3bwK+p1bXr6ecFnn0y362Acz3/hUX82Z0aoQCc=;
        b=rODTkPTpqFKZ1JV+q5wwZ6w3nffUswLixlTR6GjrbjaE9uNPmMW5nZwrIvYNrJ0R/H
         bnpOBm2yqqsoTKrnltATNM1DQa87LjUQd5DNI/tYHf/rnwiGZKxfSm8qvDpNovk+IZVq
         aXtaPfd0ky77dpQb0j4GDzsbG2ZoXYPXHaASHB23D0HQv+MOtPKWvwhZmetPbc7ntrQg
         ETgx32J57FziytGe6a0iFHyUwkHdh19+hdvYR2I/zgQ8kb9CbdGVIqP/iQKI+LMNc39F
         +K/xLk1bcg5rwZi0ySEeD9OOwC3VeAOTk3D3guEF9oIT2eFNQgAq3NVLQkLhNyXMKx0M
         0CFw==
X-Forwarded-Encrypted: i=1; AJvYcCWrw1pwfZ8sB2btkENy0+lWxxNcohpiwVx3SW7NSvDliaKfuV73ookY/rKXTlyL5O1CXCfG8q/WX3LL9YaGfukxu8fI0jx4
X-Gm-Message-State: AOJu0Yycuu9x5lxN21tZmbfh+z33SyW8r83jt4fJAJVOILKYn2Wwh54G
	VcX6YISpgx0shABj4Mx/Br/49caJiL/dRMtlg0B14vIXowMq5C+aH6Ejq3KZaoksUINYNMDd/nO
	MUxkS9JsURWrNY/XWBDQ+tl3ts8yvEc6HX9ns2P1g0cOb/ZXiDOaggQ==
X-Received: by 2002:a50:d69b:0:b0:57c:6234:e95b with SMTP id 4fb4d7f45d1cf-57c6234e9acmr471798a12.5.1717774011363;
        Fri, 07 Jun 2024 08:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0/6f7Ed+Q3P9FkVIMtn8/uS5MhDHOHU8/MO14CZu0SSWzQQpCvt+kzKfAK1hlK24ChuIRgQ==
X-Received: by 2002:a50:d69b:0:b0:57c:6234:e95b with SMTP id 4fb4d7f45d1cf-57c6234e9acmr471784a12.5.1717774010889;
        Fri, 07 Jun 2024 08:26:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadfa3c47sm2925666a12.16.2024.06.07.08.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 08:26:50 -0700 (PDT)
Message-ID: <7a73693e-87b4-4161-a058-4e36f50e1376@redhat.com>
Date: Fri, 7 Jun 2024 17:26:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: class: Revert: "If no default trigger is given,
 make hw_control trigger the default trigger"
To: Andrew Lunn <andrew@lunn.ch>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 regressions@lists.linux.dev, linux-leds@vger.kernel.org,
 Genes Lists <lists@sapience.com>, =?UTF-8?Q?Johannes_W=C3=BCller?=
 <johanneswueller@gmail.com>, stable@vger.kernel.org
References: <20240607101847.23037-1-hdegoede@redhat.com>
 <6ebdcaca-c95a-48bc-b1ca-51cc1d7a86a5@lunn.ch>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6ebdcaca-c95a-48bc-b1ca-51cc1d7a86a5@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrew,

On 6/7/24 2:03 PM, Andrew Lunn wrote:
> On Fri, Jun 07, 2024 at 12:18:47PM +0200, Hans de Goede wrote:
>> Commit 66601a29bb23 ("leds: class: If no default trigger is given, make
>> hw_control trigger the default trigger") causes ledtrig-netdev to get
>> set as default trigger on various network LEDs.
>>
>> This causes users to hit a pre-existing AB-BA deadlock issue in
>> ledtrig-netdev between the LED-trigger locks and the rtnl mutex,
>> resulting in hung tasks in kernels >= 6.9.
>>
>> Solving the deadlock is non trivial, so for now revert the change to
>> set the hw_control trigger as default trigger, so that ledtrig-netdev
>> no longer gets activated automatically for various network LEDs.
>>
>> The netdev trigger is not needed because the network LEDs are usually under
>> hw-control and the netdev trigger tries to leave things that way so setting
>> it as the active trigger for the LED class device is a no-op.
>>
>> Fixes: 66601a29bb23 ("leds: class: If no default trigger is given, make hw_control trigger the default trigger")
>> Reported-by: Genes Lists <lists@sapience.com>
>> Closes: https://lore.kernel.org/all/9d189ec329cfe68ed68699f314e191a10d4b5eda.camel@sapience.com/
>> Reported-by: "Johannes Wüller" <johanneswueller@gmail.com>
>> Closes: https://lore.kernel.org/lkml/e441605c-eaf2-4c2d-872b-d8e541f4cf60@gmail.com/
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> I'm not sure i agree with the Closes: All this does is make it less
> likely to deadlock. The deadlock is still there.

I agree that the deadlock which is the root-cause is still there. But
with this revert ledtrig-netdev will no longer get activated by default.

So now the only way to actually get the code-paths which may deadlock
to run is by the user or some script explicitly activating the netdev
trigger by writing "netdev" to the trigger sysfs file for a LED classdev.
So most users will now no longer hit this, including the reporters of
these bugs.

The auto-activating of the netdev trigger is what is causing these
reports when users are running kernels >= 6.9 .

> But:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thank you.

Regards,

Hans



