Return-Path: <stable+bounces-83743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41F599C2C2
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7745F283D29
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0478C9C;
	Mon, 14 Oct 2024 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhVE+X0/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF420142E6F;
	Mon, 14 Oct 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893730; cv=none; b=b6F81wVR9mZXNE+iosC2aoQps9KFHmdph/LnEX494b2KXSLgRrAjJ8VyEOOLLWe24eAKQESZKP3I0y5TtYZFv/+1xdg02cVsd4tamdAYV6gf5A+cctqJZiIAPwVFhgA3sH1RWHYj+2KdZOmobbDREY22JyLmIVPAG4psK6vTpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893730; c=relaxed/simple;
	bh=8Gx80y35qTfAir4KTu2n3X3gMfctxpJYjy38z/yGr90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grvzKBCfwO17MzuA6L3wsss/QM+lc6Y9UmuVA9RN+qmW+MMPXPdBNzwEh3GtGhPFm3IPv5EaF7gjrHReGQv0da3xir3F9eetwwiwT2A3RlO/m4hSSM3q41vTQnFts+ba1z1R+3buod+vgrJrTvcMccFC3aklIKR3F9zwqIh6lOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhVE+X0/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99ffeea60bso167425966b.3;
        Mon, 14 Oct 2024 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728893727; x=1729498527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLHbrNZ9fuYWvLmMDbXY5r3ERTKyfWb6Phhkc4ckAZY=;
        b=NhVE+X0/Ya55LjwkZPH2nP/Vd1StlIqgUkCtzmvoD3tD25LBfSpb9ZmByC//QaSUkS
         MNk8I8nttmbSo8uHML3gDQ1eEvp4jT/hYRAWxcexLHO5JynbYzFxEDN2zr959h2oPGwq
         I2F3SXOdia8bchgYmOPXGhEwyFSN241LrTe/o5qjHx4PVBlay4o0U7/FEXNwPmjhPMj1
         dz+qCY+FqpqLj5D3tQfwg0hfkREDuBe2m2eZoOHUsewcYGIwwRfU26Jg6RoNFGIIX7X6
         mq8k1BghB1k0v92ewtNNW6vS8l3ArLyZiGIgNeNe0Dy4DrG/3LjPtu5hvhNmQ4cy+98a
         iy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893727; x=1729498527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLHbrNZ9fuYWvLmMDbXY5r3ERTKyfWb6Phhkc4ckAZY=;
        b=OP6mI/9lzM4V/WkQ0iHBWW6j2385J0lbRG3U+2Rrv36yTbVqwzATmpCxZBZH+FQPrr
         Afu+zfSrMMCs8c9GIxm3fr7bMU0Ve2QuAZSxeqI2gFldz7xc/fr6MRQMNUGBuZYqCVYQ
         sMa8Dw39XHRlFWIuzsg4pT2fTL47+bOKUDU+HLOxido7eK2OmAXCj074GUTCQ7KJH4t3
         mNzd/RMy2Ukqxf4RveGEgov7ggC9HaPNpoZ0wc10T3CKOzXYuTwYQCJr3QUERVMsN73w
         qcz6YIS/DQmFES45fqoLHM2IC7gFKsjA8MfKn1gch3zVENank/6koF/CqymXPvUvSRjb
         qmcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnqXSMSby5AUgVGUsfRzFQsIRQD9EVT7M76hEzG7Ap2J4qCrgQJBduDm1l4m5Sw6kDXkxhPaEQPt4GpGE=@vger.kernel.org, AJvYcCVMMtJsYW3ycluvT4LuHCD4jhgqC27oIFjI9cf75hvcuC06NkDcC3PyxSM5cnZtVRjkWTQy/lxS@vger.kernel.org
X-Gm-Message-State: AOJu0YzVolaFX4PUdryjtqVlcl4XwYjdpT6FAAOyS0gFIFzo1Xu32gIM
	72p+XVIUhCrLnEZdi+sUh3zI03N8KTkW/OTYpimVEzwcN7kFL8/C
X-Google-Smtp-Source: AGHT+IG1/kIZFqniO178bhOM6QqOcHYjCO9xJL/7Kh/8jtK2DzEZpIJSuygJsgbTa5nRzV3LTGqryA==
X-Received: by 2002:a17:907:360c:b0:a99:499f:4cb7 with SMTP id a640c23a62f3a-a99b940530bmr988563366b.23.1728893726778;
        Mon, 14 Oct 2024 01:15:26 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a15e0b150sm56219366b.57.2024.10.14.01.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:15:26 -0700 (PDT)
Message-ID: <8c0bbde9-aba9-433f-b36b-2d467f6a1b66@gmail.com>
Date: Mon, 14 Oct 2024 10:15:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
 <a4283afc-f869-4048-90b4-1775acb9adda@stanley.mountain>
 <47c7694c-25e1-4fe1-ae3c-855178d3d065@gmail.com>
 <767f08b7-be82-4b5e-bf82-3aa012a2ca5a@stanley.mountain>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <767f08b7-be82-4b5e-bf82-3aa012a2ca5a@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 10:12, Dan Carpenter wrote:
> On Mon, Oct 14, 2024 at 09:59:49AM +0200, Javier Carrasco wrote:
>> This approach is great as long as the maintainer accepts mid-scope
>> variable declaration and the goto instructions get refactored, as stated
>> in cleanup.h.
>>
>> The first point is not being that problematic so far, but the second one
>> is trickier, and we all have to take special care to avoid such issues,
>> even if they don't look dangerous in the current code, because adding a
>> goto where there cleanup attribute is already used can be overlooked as
>> well.
>>
> 
> To be honest, I don't really understand this paragraph.  I think maybe you're
> talking about if we declare the variable at the top and forget to initialize it
> to NULL?  It leads to an uninitialized variable if we exit the function before
> it is initialized.
> 

No, I am talking about declaring the variable mid-scope, and later on
adding a goto before that declaration in a different patch, let's say
far above the variable declaration. As soon as a goto is added, care
must be taken to make sure that we don't have variables with the cleanup
attribute in the scope. Just something to take into account.

>> Actually there are goto instructions in the function, but at least in
>> their current form they are as harmless as useless.
> 
> Yep.  Feel free to delete them.
> 
> regards,
> dan carpenter
> 


