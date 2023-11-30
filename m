Return-Path: <stable+bounces-3217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BDD7FF02F
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45B21C20CC8
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4547782;
	Thu, 30 Nov 2023 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLvKxT2g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF738F9C
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFC3C433C7;
	Thu, 30 Nov 2023 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701351083;
	bh=2pcOXvzZqt99ol0bXKfGt5Q9Mv2VOxWlHn1rJ4yJawE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLvKxT2gGIlIiCrBodQzNwH/jv8QD8qDIAZQxp1N2kyKH+s8lk6npR6PF/Fgd2F6n
	 /BykEECfwxsgDMSuqJZDhOH3Av+dWhXTHtG5YhmKvr3xlcIOS4pyuk/de0yua69eGl
	 epINQxiRMABfC/3V9FxBZ+8MpHwtejh8xwW8Mz9c=
Date: Thu, 30 Nov 2023 13:31:20 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: "Nguyen, Max" <hphyperxdev@gmail.com>
Cc: stable@vger.kernel.org, "Nguyen, Max" <maxwell.nguyen@hyperx.com>,
	carl.ng@hp.com
Subject: Re: [PATCH 6.5 153/191] Input: xpad - add HyperX Clutch Gladiate
 Support
Message-ID: <2023113035-destiny-vibes-0313@gregkh>
References: <MW4PR84MB178083997D411DFFD45BEFCDEBB7A@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
 <6b2973c5-469a-4af8-995b-ee9196d0818b@gmail.com>
 <2023111814-impeach-sweep-aa30@gregkh>
 <9c3e4b65-4781-4d45-a270-f1b75dfb48d3@gmail.com>
 <8b130415-4f70-495c-85dc-355e3cd2db17@gmail.com>
 <2023112205-viselike-barracuda-f0c6@gregkh>
 <3d7d9872-e569-4821-b0e2-39c8c7be53c9@gmail.com>
 <0d6f1468-e10f-434c-aeb8-53b1c06ed289@gmail.com>
 <2023112300-static-encourage-1b8d@gregkh>
 <b13aca58-e598-4f39-b07a-b814aff9f318@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b13aca58-e598-4f39-b07a-b814aff9f318@gmail.com>

On Tue, Nov 28, 2023 at 03:37:30PM -0800, Nguyen, Max wrote:
> 
> On 11/23/2023 12:59 AM, Greg KH wrote:
> > On Wed, Nov 22, 2023 at 03:10:39PM -0800, Nguyen, Max wrote:
> > > On 11/22/2023 2:18 PM, Nguyen, Max wrote:
> > > > On 11/21/2023 10:39 PM, Greg KH wrote:
> > > > > On Tue, Nov 21, 2023 at 04:17:54PM -0800, Nguyen, Max wrote:
> > > > > > On 11/20/2023 3:52 PM, Nguyen, Max wrote:
> > > > > > > On 11/18/2023 3:32 AM, Greg KH wrote:
> > > > > > > > On Fri, Nov 17, 2023 at 03:42:22PM -0800, Nguyen, Max wrote:
> > > > > > > > > > Hi,
> > > > > > > > > > 
> > > > > > > > > > We would like to apply this patch to version 6.1 of the LTS branch.
> > > > > > > > > > This is to add a project ID for Android support for a gamepad
> > > > > > > > > > controller.  We would like it to apply sooner than waiting
> > > > > > > > > > for the next
> > > > > > > > > > LTS branch due to project schedules.
> > > > > > > > > > 
> > > > > > > > > > commite28a0974d749e5105d77233c0a84d35c37da047e
> > > > > > > > > > 
> > > > > > > > > > Regards,
> > > > > > > > > > 
> > > > > > > > > > Max
> > > > > > > > > > 
> > > > > > > > > Hi Linux team,
> > > > > > > > > 
> > > > > > > > > We would like to have this patch backported to LTS versions
> > > > > > > > > 4.19, 5.4, 5.10,
> > > > > > > > > and 5.15 as well.  The main purpose would to add our device ID
> > > > > > > > > for support
> > > > > > > > > across older android devices.  Feel free to let us know if there
> > > > > > > > > are any
> > > > > > > > > concerns or issues.
> > > > > > > > Please provide a working backport that you have tested
> > > > > > > > as I think it did
> > > > > > > > not apply cleanly on its own, right?
> > > > > > > > 
> > > > > > > > thanks,
> > > > > > > > 
> > > > > > > > greg k-h
> > > > > > > Hi Greg,
> > > > > > > 
> > > > > > > Do you have any general suggestions or instructions on how I
> > > > > > > can create
> > > > > > > a backport to test?  I apologize as this is new to me.
> > > > > > > 
> > > > > > > Also, what do you mean by the patch did not apply cleanly on its own?
> > > > > > > 
> > > > > > We found that the patch does not apply correctly to the previous LTS
> > > > > > kernels.  This is most likely due to addition of newer devices
> > > > > > over time.
> > > > > > We will be sending separate patches for each kernel shortly.
> > > > > Why not send a series adding all of the missing backported patches?
> > > > > That makes it better so that all of the supported devices are now
> > > > > working on the older kernels, not just this one.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > Hi Greg,
> > > > 
> > > > I am planning to send a patch for LTS versions 4.19 through 5.15 since
> > > > the single patch can apply to all of these versions with no issues.  I
> > > > plan to send a separate patch for LTS 6.1 since this patch could not
> > > > apply to the older LTS versions.
> > > > 
> > > > Is this what you had in mind when you mentioned series?
> > > > 
> > > I resent the patches as a series as described in the patch submission
> > > process on the kernel webpage.  I reviewed and believe it should be
> > > formatted correctly now.  Let me know if there are any issues.
> > No, I mean, for each stable kernel version/tree/whatever, send a patch
> > series that adds all of the missing ids to the table, not just your one
> > specific device you are asking for here.  That way the trees are all in
> > sync proper AND any future patches will also apply cleanly/properly to
> > the older kernel versions.
> > 
> > Does that help?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> We only have 1 device for now as our other devices should not be known to
> public yet.  Do you mean missing IDs for other company/brand's devices?

No, I mean the missing git commits for the file you are touching that
has the list of the devices in it.  That is out of date and should be
brought up to the latest version with the full list of devices, right?

thanks,

greg k-h

