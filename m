Return-Path: <stable+bounces-159129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B57AEF3EE
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 11:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB23BE0A1
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 09:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15526B778;
	Tue,  1 Jul 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJsAi6n3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828871E570D
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363580; cv=none; b=ojDPQITKM4eGz7UBPradYIaWT+0vWbqjB3KY0R6PcqJDiineZZcI83yzOzrHMUyeYNeV3iPs6MokCCJDhNAMQCykzr4rq49lhek1nl7dxOWx8AyICh7kjoBNc9pFSSDLy1K9SCsJc2moWPo9wL5iwG/29ywXyu93nvGwOddEgf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363580; c=relaxed/simple;
	bh=Y6Bt7vYqzIddtJaGwQ+/1XfNpiStkL0hYIpIeBMBUOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KtbnMfoUMMFCX/vQk6Q0rVuSazYLGJlJkDB4E3+Rf0/MfwnPzazpKlmDbRiS2JvKHC3jjRggTwLrpyAkKNtji3ej8An+DopSWw/ewKrY2aRPl31yey/omM0j49wN8LjFgt5ZZTr7jY0DAmZIV2bWJr7b3FBqdMMmDGK2uBTz8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJsAi6n3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so24428475e9.0
        for <stable@vger.kernel.org>; Tue, 01 Jul 2025 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751363577; x=1751968377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AsO4MNbP6/LHgR7nHvgKu5wEJwKc2jZzt2g+cQIzNfE=;
        b=DJsAi6n3fybeLBAQOnoKzk29BUPNchoF8/xnU/8mODXPTCxJKPSRNKJSIvG98QTIqI
         PmPpBPODIP3Wqxw+v8zG0BofNzyABtmmY2iBUClu6qfMZhoJwPoFbYhf4adm7Fx4FBSz
         aonQ+GrmFdLie/8i9WkrnWMwaZ7+NYsp/A5ahCmzJMT60DhUG5LbOT/jlTwhRE6zuYD0
         zkUjd0XMP1HQSDN/q3GVn3UFwBdtTOiDzI0oN/oDd4tHqsH1OssP6WYXl2XLi6yhH/tQ
         SrzU5N+AXSRBLLN151j1XKoDLNOA2LvDJDH4UwSs9iEl+JRfDlmKb5gWeMN0r1yDNoba
         wPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751363577; x=1751968377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsO4MNbP6/LHgR7nHvgKu5wEJwKc2jZzt2g+cQIzNfE=;
        b=wQlPfVM8aSn8A4Z0ZG+ZPqGgZbjhZccGRUiaPmorpx0T5h6hsQa7jU/Oct+3YrP/u6
         bl+ABvzutUyZeuxKDq2ZbUVIzJmFg3bZvRJQpqlB7/2nFfHIZNnrYEWmVkRbsJNB/vnc
         v8fNZM4JYS07mduCB7lAG/SYtjn3AGYsrzEW35lSoJJJsOhFm6YkR7M4S8IV7b1xjb64
         1DXAznedHmS4JV/UfMjnQdtKsHYcf+A1Al+Y9YON+unQLz3rzAHvfULU8ge7GBgRfCMJ
         bWKJSC05GD/QX4gJxMnRkzsb5rkLm10EYjgrTAfR13Rf5FRIwXn2feZNd6ng+3hJ/m3o
         Q0+g==
X-Gm-Message-State: AOJu0YysAwbGNtLTJaabY/Ic6IH3CsxQs8v8PYOQIunYMXivP8MLhVWx
	pGuq50HzZVSEX+jqSjb6zo8S2jwLL7im8wePg/kJFspx8nwqwRRygGjeLj5eSWP9++hI9V+N1Vo
	2Qbn9CM3tfbuX9g==
X-Google-Smtp-Source: AGHT+IFvqQhgygm6Ns7DmopGcnlkaCqQTFJuAvO9MrADA3egshrgy5Yzka4HTdvu9aa5pUh3EkhdD3/3DmWlVA==
X-Received: from wmrn33.prod.google.com ([2002:a05:600c:5021:b0:450:dcfd:1870])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fce:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-45390259d15mr141264015e9.6.1751363576854;
 Tue, 01 Jul 2025 02:52:56 -0700 (PDT)
Date: Tue, 01 Jul 2025 09:52:55 +0000
In-Reply-To: <2025063054-abridge-conclude-3dad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630-ipmi-fix-v1-1-2d496de3c856@google.com> <2025063054-abridge-conclude-3dad@gregkh>
X-Mailer: aerc 0.20.1
Message-ID: <DB0MKNAAHYVK.3V2BN2WP3C7ZI@google.com>
Subject: Re: [PATCH stable] ipmi:msghandler: Fix potential memory corruption
 in ipmi_create_user()
From: Brendan Jackman <jackmanb@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>, Corey Minyard <minyard@acm.org>, 
	Corey Minyard <cminyard@mvista.com>, <openipmi-developer@lists.sourceforge.net>, 
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Corey Minyard <corey@minyard.net>
Content-Type: text/plain; charset="UTF-8"

On Mon Jun 30, 2025 at 6:10 PM UTC, Greg KH wrote:
> On Mon, Jun 30, 2025 at 05:09:02PM +0000, Brendan Jackman wrote:
>> From: Dan Carpenter <dan.carpenter@linaro.org>
>> 
>> commit fa332f5dc6fc662ad7d3200048772c96b861cf6b upstream
>> 
>> The "intf" list iterator is an invalid pointer if the correct
>> "intf->intf_num" is not found.  Calling atomic_dec(&intf->nr_users) on
>> and invalid pointer will lead to memory corruption.
>> 
>> We don't really need to call atomic_dec() if we haven't called
>> atomic_add_return() so update the if (intf->in_shutdown) path as well.
>> 
>> Fixes: 8e76741c3d8b ("ipmi: Add a limit on the number of users that may use IPMI")
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Message-ID: <aBjMZ8RYrOt6NOgi@stanley.mountain>
>> Signed-off-by: Corey Minyard <corey@minyard.net>
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>> I have tested this in 6.12 with Google's platform drivers added to
>> reproduce the bug.  The bug causes the panic notifier chain to get
>> corrupted leading to a crash. With the fix this goes away.
>> 
>> Applies to 6.6 too but I haven't tested it there.
>
> So what kernels are you wanting this to be applied to?

Right, sorry for the ambiguity.  I've just applied the patch to 6.6 and
booted QEMU and it worked fine.

I have not reproduced a crash in 6.6 but it's pretty clearly a real bug
(it decrements the target of an uninitialized pointer).

So if you're OK with that then please apply to 6.6 and 6.12. Otherwise
just 6.12 is fine, I will send another PATCH if I ever hit the issue for
real in 6.6.

