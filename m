Return-Path: <stable+bounces-100604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB439ECA83
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 11:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C9E1881CA4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62134239BA6;
	Wed, 11 Dec 2024 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gIDfvjkI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF8239BA0;
	Wed, 11 Dec 2024 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913795; cv=none; b=JuHLkodoWrvoVM1JOCvcAFb9z0caS/2sW09CqhT7yDz2KT4DR6xkHRYi9BHedVzN1aLCgtL/HCCnzFyZXCDcb62U6xnQNY2NApL+okjsVKVcN0GxA5C4tYT8Nkcgjm5h4Z47uU3vdkWX7pNdYdm+wi1NhXUX+4IP361SGWAC14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913795; c=relaxed/simple;
	bh=Y2onpIYfnxTdGcfcUHitnBJHbfPbQ09F7UwohW204Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeRu7jOmzEbe6hsSC2ID4Pvnhom6ulhRx7H0f/cUptl4VBGlwVLAim3QRGF+fdclq6I6fgfoYsIYM+3vXapuhQZ3rH+VoBeYkWazboHe4eyJdmMQphjrVH/t5hwG7InkexR+bXzl55+kzlDwK6kvDtnYLilyAu+Gtg5KgXiBBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gIDfvjkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C0AC4CED2;
	Wed, 11 Dec 2024 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733913794;
	bh=Y2onpIYfnxTdGcfcUHitnBJHbfPbQ09F7UwohW204Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIDfvjkIU04TjAjU6tA84/uZHauY8gAhsFZ9JqkquvQtjQXQdZ8dm2fyS1JlMGN3Z
	 ueYfRgK4Qdfvus+SKg4pm53m7dta5URIh34ryHgW3W8Xr81Ittu6OAmBKtWEqIFRVM
	 pxnLXtK0X/w5b7SF75gudAjpDOubPI8qRlBAzY9o=
Date: Wed, 11 Dec 2024 11:42:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Nicholas Bellinger <nab@linux-iscsi.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Homura Akemi <a1134123566@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 00/28] usb: gadget: f_tcm: Enhance UASP driver
Message-ID: <2024121147-hamburger-enforced-5db3@gregkh>
References: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>

On Wed, Dec 11, 2024 at 12:31:30AM +0000, Thinh Nguyen wrote:
> Apologies for the delay; after two years and multiple requests to resume this
> series, I squeezed some time to push an update. This series applies on top of
> Greg's usb-testing branch.
> 
> If possible, please help test this series and get this merged as my resources
> are nil for this work.

You have many bugfixes in the first few commits of this series, but if I
apply the whole series, those will not get into Linus's tree until
6.14-rc1.  Is that ok or should they go separately into 6.13-final now?

thanks,

greg k-h

