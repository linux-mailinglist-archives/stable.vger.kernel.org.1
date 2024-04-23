Return-Path: <stable+bounces-40730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08338AF415
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBF028EC31
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BAB13D254;
	Tue, 23 Apr 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sIy91RX3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477B13C69A
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889681; cv=none; b=HsOaC50IcWxqJEO1/kvzf6mZHJNhjwELnoOR8CqPTn0bXwKlj8Flh8XrmSUw1MrdE+I0q8003ahxn0WX22BTlTlXwg+7smkGk+I7iDTWneofdh46YWh6sehIWVYcqWuY1iBcNxfDWY/GdEFAQL0DMY2ag8+X0EcOPNZVjHA67xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889681; c=relaxed/simple;
	bh=c//38313nrYbr69vb+Pn0k7ZNclux/i6z5pIVY8yAyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoTBawn73qN09Q/rbDdaVMq4zZ/7YA0nG5lCRFN6yBgFRsZUbIhzneeG1Xq0SyPzJf2pDdflfAFokTay2Dh3s3S5nrofXlfbF8o7sL1u3440YulEyBiGPrCoRmy/kGH6VUFIlngljK41wT75mVj8KcTl56JDXzre9gSik5sER28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sIy91RX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA96C116B1;
	Tue, 23 Apr 2024 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713889681;
	bh=c//38313nrYbr69vb+Pn0k7ZNclux/i6z5pIVY8yAyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIy91RX3myY4CLXPtB6aukY8+S3ei7Eq0VDPY4gkvtkUx7rcBocgts9cCZ0xYCQFz
	 Rr3moEeTF/AL0KbeRCYU6fDIVHkEPUqnVD11Sn/z3fr1umCtTxex2iH+tBkzNVqcae
	 nV+OLATN8db0J42AVTuUAe1sjxXJL+QDBBO7JoZw=
Date: Tue, 23 Apr 2024 09:27:51 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: stable@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 0/2] Please apply these MT7530 DSA subdriver patches to
 6.8
Message-ID: <2024042343-jaybird-handwrite-1c92@gregkh>
References: <20240420-for-stable-6-8-backports-v1-0-4dafb598aa3b@arinc9.com>
 <ff6e71e3-9c76-4ac1-bf34-4803c4ef48f6@arinc9.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff6e71e3-9c76-4ac1-bf34-4803c4ef48f6@arinc9.com>

On Sat, Apr 20, 2024 at 02:19:46PM +0300, Arınç ÜNAL wrote:
> On 20/04/2024 13:51, Arınç ÜNAL via B4 Relay wrote:
> > Hello.
> > 
> > These are the remaining bugfix patches for the MT7530 DSA subdriver.
> > They didn't apply as is to the 6.8 stable tree so I have submitted the
> > adjusted versions in this thread. Please apply them in the order
> > they were submitted.
> 
> Please apply these adjusted versions to 6.6 as well.

Both now queued up, thanks.

greg k-h

