Return-Path: <stable+bounces-195150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADD2C6CACF
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 05:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D12A84E6F2A
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 04:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF212DCF43;
	Wed, 19 Nov 2025 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="tfHycg37"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96262271A9A
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763525377; cv=none; b=gHagw+WvNpTD1GYkTyUbIJ0xFRLnF+A/xCby2esU/UG3OTw+kTTl5bUWgrajc54CswNnmCJ4G4t6r5bbrkf50qsF4Y/EE6q6EK9KUtKTxaCU8j7ueuDk4jf7dDTxq5w855NO1dGBj92U6XUZORlNNiQMotOU2y21y+KwYSdkqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763525377; c=relaxed/simple;
	bh=HgC/efy+sZRCqXS6s9L8AlS/v6ijUSAiHNJR1aHlUqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4h76xyxSmgLRD6iIVk7pqnROnauIWgzYXuRp1TyGw5h0D2wNqT8OpEDM6A3VkSAp2nJ3tX9R6zKLWxtDpMvwUljWK5OQ7nsAHnCO6b07maYxXaGaR/sIjugqoFQQZzcz6Hb6Oxahzo3ZljtohKtRGcdOYyJJ0dWtC0813Ytzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=tfHycg37; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-882451b353fso42283256d6.1
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 20:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1763525374; x=1764130174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pyos3QdG31i05Qnv8lN51cvzL0YrYJwG7uMU7FrbGgA=;
        b=tfHycg37d29EeqoCi30XnlW/wvmmzOWfRvobTHeV9drcuAhlAUB815L7pKkm+4OZq1
         vj21VTwA3jAlHH5ifVJZ28kZBqYMFNCk4ZPHe/keHTKIsQ3zSxz4yu082qsbq3ZvVHOi
         x239I0aGiHuCTls4SL49hbzSKR6CVaBtZ+9l11bcWk7s6lYEjMcTlm7OdSGbZL1L0we2
         RFi9KNQCPtNBOrSssDkEwq/fihHr4EzMovj0m1Qf7p+gc9/5zyYfje/99jyJh7oy5Bd5
         UTKj6jHI+x9O7jMmlF90hfIejuVcswvq3K+HPOSzkHLG+IcwCq6UA1qjQkcT2yNGgx6k
         tkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763525374; x=1764130174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyos3QdG31i05Qnv8lN51cvzL0YrYJwG7uMU7FrbGgA=;
        b=WodYSDYaMMTN5IHC+YJyfSy798imLZ5hnu21t3sS5+o3MVz7TRW2QeE1vCMgPch/ps
         dR466LYzhl/Ed62h06SiUbf68GT01PPZ6byQfcduYZ8dnSMczv5hAn/mFaUYwpk26VN3
         P4ot1r2LQoK7X7uUoRltL3UOWLdDpQ+EeMY7Ljy8XpIoWh1kpn/FmhfxWnXSc52fy7oc
         Zqmxb0HMrpB4E48C7SBZzmNl9Sbx4N8xBHALU8haMC9mZFojNDxcO9KHDuicnB7bgnFl
         Bwm3qq5LFfeimK0nGIPGHg3YgynJC1saB6JLnToJq923hZdT990vilArgyikop0H5rdq
         W5ow==
X-Forwarded-Encrypted: i=1; AJvYcCUeoFtMwM/5Nsjzqdxp7kztSXteQ4IP9eH7tJ5gd+E6PvZ8blz9kL/H08i8uadPehr3GAedzf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dCfImUsTJeuYTCQfz82GxfReyuf6gb0IkEpszRhIkZgC6GeH
	bM9aunSsrYTF+xjXbjayqzUiU3tcmy4hOln3SXKLHGwaTT+gpwnWInI9m6qEx85Z8w==
X-Gm-Gg: ASbGnctkUePHrUYHeSTs3D1G+7lha3DudrWVxTcgHwXX1SuCbizMJtAK+LZcsZRVp6h
	wa/goVxzIRDpQ3fdgzqvxUYtuedFTxYwWep/zCQ2JqegwD6rjUYqFW0RoU7FeUr/Es8KlzPbD9X
	/u0Rk6ywQHGAZsowXGsBOG2jvIMaf+rO2YvwwcbA59bQhzUabn1he3b5h4E2rrsZq2FYF+pTGo4
	A4AszYlUhF63rEiKJwBpwNuDzeo/njlMDrsz9SrfWlu2NYJtqaYIZ97vvDOZd8MjUMUIsgwhXTI
	fQ8qn8Gq6z2sR9sIndNFmAymft2EipObTtT9pViofZ0dKlC0a0m/2EgsZ2AMaue7VolFhJAzpOF
	HfaQL/xmKNyQDogHzslhCTiAQKJDk45kSn0FFWYYoIRqKY8eIyiGBHIQZjA/9o5o/8u5yEdtoIV
	uVfRBg4wg6sZTx2mFxTqT/l9w=
X-Google-Smtp-Source: AGHT+IF7DEPCAC+BGqbJKSk4IPt6GQ7vQExhSx5RGt5NZqaXxsTrtRBDCBmfMPe8p1ctavjJf/1hmA==
X-Received: by 2002:a05:6214:2623:b0:880:4bde:e0cb with SMTP id 6a1803df08f44-882925ff072mr246281336d6.29.1763525374380;
        Tue, 18 Nov 2025 20:09:34 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::7632])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314656sm126013906d6.21.2025.11.18.20.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 20:09:33 -0800 (PST)
Date: Tue, 18 Nov 2025 23:09:30 -0500
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
Message-ID: <d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
References: <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>
 <20251117155920.643-1-selvarasu.g@samsung.com>
 <20251118022116.spdwqjdc7fyls2ht@synopsys.com>
 <f4d27a4c-df75-42b8-9a1c-3fe2a14666ed@rowland.harvard.edu>
 <20251119014858.5phpkofkveb2q2at@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119014858.5phpkofkveb2q2at@synopsys.com>

On Wed, Nov 19, 2025 at 01:49:12AM +0000, Thinh Nguyen wrote:
> On Mon, Nov 17, 2025, Alan Stern wrote:
> > > Hi Alan,
> > > 
> > > Can you help give your opinion on this?
> > 
> > Well, I think the change to the API was made because drivers _were_ 
> > calling these routines in interrupt context.  That's what the commit's 
> > description says, anyway.
> > 
> > One way out of the problem would be to change the kerneldoc for 
> > usb_ep_disable().  Instead of saying that pending requests will complete 
> > before the all returns, say that the the requests will be marked for 
> > cancellation (with -ESHUTDOWN) before the call returns, but the actual 
> > completions might happen asynchronously later on.
> 
> The burden of synchronization would be shifted to the gadget drivers.
> The problem with this is that gadget drivers may modify the requests
> after usb_ep_disable() when it should not (e.g. the controller may still
> be processing the buffer). Also, gadget drivers shouldn't call
> usb_ep_enabled() until the requests are returned.

No, they probably shouldn't, although I don't know if that would 
actually cause any trouble.  It's not a good idea, in any case -- 
particularly if the drivers want to re-use the same requests as before.

The problem is that function drivers' ->set_alt() callbacks are expected 
to do two things: disable all the endpoints from the old altsetting and 
enable all the endpoints in the new altsetting.  There's no way for any 
part of the gadget core to intervene between those things (for instance, 
to wait for requests to complete).

> > The difficulty comes when a gadget driver has to handle a Set-Interface 
> > request, or Set-Config for the same configuration.  The endpoints for 
> > the old altsetting/config have to be disabled and then the endpoints for 
> > the new altsetting/config have to be enabled, all while managing any 
> 
> Right.
> 
> > pending requests.  I don't know how various function drivers handle 
> > this, just that f_mass_storage is very careful about taking care of 
> > everything in a separate kernel thread that explicitly dequeues the 
> > pending requests and flushes the endpoints.  In fact, this scenario was 
> > the whole reason for inventing the DELAYED_STATUS mechanism, because it 
> > was impossible to do all the necessary work within the callback routine 
> > for a control-request interrupt handler.
> > 
> 
> If we want to keep usb_ep_disable in interrupt context, should we revise
> the wording such that gadget drivers must ensure pending requests are
> dequeued before calling usb_ep_disable()? That requests are expected to
> be given back before usb_ep_disable().
> 
> Or perhaps revert the commit above (commit b0d5d2a71641), fix the dwc3
> driver for that, and gadget drivers need to follow the original
> requirement.

Function drivers would have to go to great lengths to guarantee that 
requests had completed before the endpoint is re-enabled.  Right now 
their ->set_alt() callback routines are designed to run in interrupt 
context; they can't afford to wait for requests to complete.

The easiest way out is for usb_ep_disable() to do what the kerneldoc 
says: ensure that pending requests do complete before it returns.  Can 
dwc3 do this?  (And what if at some time in the future we want to start 
using an asynchronous bottom half for request completions, like usbcore 
does for URBs?)

Let's face it; the situation is a mess.

Alan Stern

