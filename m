Return-Path: <stable+bounces-195049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE6CC673C1
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 05:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 274A74E2DCF
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 04:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103FC27D782;
	Tue, 18 Nov 2025 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="syNXDSwh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70F22DFA5
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439624; cv=none; b=TvQ3WZZiKxt18FuCyQotnPsU1tw6WAfr1+MsGJLe8RnJRq3jR/oOAdN753NwA9kkmS6Vonyjf3bBgNdQGkfj/xXbKA2NmNxGNMvLgEwsZMJRdFtKgo4COtH0h8KyIc1Dhf5SQWFkgVXnNobLo8e0JdNgZkjPZY2Fo3F0XoLEsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439624; c=relaxed/simple;
	bh=KqxIZBnrqFJni2oFg4oyAwbD+g+j+G4Q8WYHGqkvUp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYttUIFYtTQb+qx/uAXlgZzrewGirOqNAw/83HBMKzDHbLo4VJybMFxnEH//Z31eQ6GGPXtlThzxrsBiQ+Jfqz0ZgMf1bOH2V5pPr1JcFR1Y5ouC1oA/S6nQiOET+x4Z9/1RhLXBIKoP6KxnsSQAd2jcECU+yZiUqzHhF5q+XTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=syNXDSwh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8845498be17so3659416d6.3
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 20:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1763439622; x=1764044422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8wr2eViKfeD+vLkliXz6LETzkNnS8mTahP7nstQOmc=;
        b=syNXDSwhAr72va5rjwA37eovo/K7bHfYQVaHJgBrU8MqQzlfrN8dW40pVnX5nmjpjw
         JpHy7+/saKUFaoYOG8de/1iNjtX0PhKykM3tDrWYcC5IbzQFne0Br6twwK+DmpUaBCcI
         9gv/M9UIMHBP0mWMaOCj2KPyondfe/7G46nrTwu78BTHKwuQ69aEdwNDcRUkCTjS0feQ
         Ncb6r8HqTT5X0aJIyo/aBPZk+TzrvYwW0EFCWc5CgL8YcYVO7w4P3ogEaTQS8zU6nP9f
         E1ltJsnc5iP8BR1svyB5Nq1nanwRHrdOKesfLDpwvOuEU/a2+wq/by9x4xMBUUdP9aBt
         EgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763439622; x=1764044422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8wr2eViKfeD+vLkliXz6LETzkNnS8mTahP7nstQOmc=;
        b=DiZ0oTSlbxZIero5fpsZW6jFJjKirZ8khvSBAhFFausg5ducqwaC1xfkiRmUn+LpWE
         FmJ9z0hXRN3gpCNTSfShJygVp7oHE/HZ377NAKtilnedqyf3lWx8/YpEhQRLkxadF8qs
         md4D/Ai0mHrh9J0tVJsfgOwZYlL7Pi9BGZ8V96zP8grZjww4j1nEeZ1sdR/23uxbI3RL
         DpAs2Rs8u+K9h9BGy3lodOX9bCDwrln+kRdYle2msfR58ZyttHldy2fRFcvznsWLQMme
         JQHhnzSHkNfxCRnmww3R57IJozXebb8B+14BpEZ7JxS95u10XlDJ3aNzejd+DE+8XAZ8
         ZYMw==
X-Forwarded-Encrypted: i=1; AJvYcCU3dg2Si2zxE5IkxCBNI41LKOgqJDqwqAheQnheTT5WkBUXnnq77uzkv7mWH+TWMdUL2csSIWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzr4KF4tCaF0I4vPGFqTxnA47Up89XOOuLXJ0JRldhrQy0mMJ8
	utwbT4XaU34kh5fd+zZBj/ckWO5K2yXWmeT396QS9IBEcCkuydZ6J7uRm/GUl9RRIMy9YeKBsxH
	qQcz9hg==
X-Gm-Gg: ASbGnct9oXNJmWumdu/ItIkSpebahLvlIo+Alak0wXDgAYcmF3wKkGve5jFVm6Dqygw
	MPnueZs7qqZkhqywco6NUFmyBjvpQEmYSQgG33toAPY9YnuqTYACr+0O3MuqJ8Y219+MV1ELOtZ
	CAiUomtM8HlRg5+sF4KHbA/TgGluXR/TQnlrOZOHsMMBZjUcqrik4sBNp3sA3T3XScR7d0t2fON
	r3yjGslKQ7CGB+hyiuxZw/K6SyjZEPs9bgokgpubB6tybR11m2ZcRSl1PU65rz6bQo1htQ/hf0K
	WnubHy3Bu/foEYQlKyAY+LOa5kIpT8z6KLCRw37hgTVo8KvwLbwoEH01gwRfPXcw/Ji6W7UPZ0g
	YhQleYUihtlIKQ14LuimY08pcPjTf9gWoQPLxy82zpjyzZw7iNhB1/2q4yluHrckCpaI/Gxu1Zi
	sFBoQjs2V4Xms=
X-Google-Smtp-Source: AGHT+IGgyRHdLzIvhu3+KtSQVM+AoQX0mTXvbl+hNPzyx6Fzdqz66Pk9HyPua70YPmQ+r8otk8dlXw==
X-Received: by 2002:a05:6214:20ca:b0:882:401c:e37d with SMTP id 6a1803df08f44-882926d4dbamr203188756d6.63.1763439621946;
        Mon, 17 Nov 2025 20:20:21 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::5fd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865342c4sm105804156d6.28.2025.11.17.20.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 20:20:21 -0800 (PST)
Date: Mon, 17 Nov 2025 23:20:18 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Selvarasu Ganesan <selvarasu.g@samsung.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
	"dh10.jung@samsung.com" <dh10.jung@samsung.com>,
	"naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>,
	"h10.kim@samsung.com" <h10.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"thiagu.r@samsung.com" <thiagu.r@samsung.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Message-ID: <f4d27a4c-df75-42b8-9a1c-3fe2a14666ed@rowland.harvard.edu>
References: <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>
 <20251117155920.643-1-selvarasu.g@samsung.com>
 <20251118022116.spdwqjdc7fyls2ht@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118022116.spdwqjdc7fyls2ht@synopsys.com>

On Tue, Nov 18, 2025 at 02:21:17AM +0000, Thinh Nguyen wrote:
> Thanks for the catch. The problem is that the "ep_disable" process
> should be completed after usb_ep_disable is completed. But currently it
> may be an async call.
> 
> This brings up some conflicting wording of the gadget API regarding
> usb_ep_disable. Here's the doc regarding usb_ep_disable:
> 
> 	/**
> 	 * usb_ep_disable - endpoint is no longer usable
> 	 * @ep:the endpoint being unconfigured.  may not be the endpoint named "ep0".
> 	 *
> 	 * no other task may be using this endpoint when this is called.
> 	 * any pending and uncompleted requests will complete with status
> 	 * indicating disconnect (-ESHUTDOWN) before this call returns.
> 	 * gadget drivers must call usb_ep_enable() again before queueing
> 	 * requests to the endpoint.
> 	 *
> 	 * This routine may be called in an atomic (interrupt) context.
> 	 *
> 	 * returns zero, or a negative error code.
> 	 */
> 
> It expects all requests to be completed and given back on completion. It
> also notes that this can also be called in interrupt context. Currently,
> there's a scenario where dwc3 may not want to give back the requests
> right away (ie. DWC3_EP_DELAY_STOP). To fix that in dwc3, it would need
> to "wait" for the right condition. But waiting does not make sense in
> interrupt context. (We could busy-poll to satisfy the interrupt context,
> but that doesn't sound right either)
> 
> This was updated from process context only to may be called in interrupt
> context:
> 
> b0d5d2a71641 ("usb: gadget: udc: core: Revise comments for USB ep enable/disable")
> 
> 
> Hi Alan,
> 
> Can you help give your opinion on this?

Well, I think the change to the API was made because drivers _were_ 
calling these routines in interrupt context.  That's what the commit's 
description says, anyway.

One way out of the problem would be to change the kerneldoc for 
usb_ep_disable().  Instead of saying that pending requests will complete 
before the all returns, say that the the requests will be marked for 
cancellation (with -ESHUTDOWN) before the call returns, but the actual 
completions might happen asynchronously later on.

The difficulty comes when a gadget driver has to handle a Set-Interface 
request, or Set-Config for the same configuration.  The endpoints for 
the old altsetting/config have to be disabled and then the endpoints for 
the new altsetting/config have to be enabled, all while managing any 
pending requests.  I don't know how various function drivers handle 
this, just that f_mass_storage is very careful about taking care of 
everything in a separate kernel thread that explicitly dequeues the 
pending requests and flushes the endpoints.  In fact, this scenario was 
the whole reason for inventing the DELAYED_STATUS mechanism, because it 
was impossible to do all the necessary work within the callback routine 
for a control-request interrupt handler.

Alan Stern

