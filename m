Return-Path: <stable+bounces-161941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A268B05154
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 07:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D9E7AD993
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 05:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D862D3757;
	Tue, 15 Jul 2025 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mA5FHg6J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDAD2D29CF;
	Tue, 15 Jul 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558966; cv=none; b=q6jaYiZvxuPy5FHxvOZnZAfUN4E4U5WqXqR8ksUkvkA0kYUV3WXlZ9vBDaZqCH2tMr5JmDUrhRmZEjojq/zpufuzbpll5Sm2NXgfdAAQ2oVFbID2lFO6UBb02xv2VE96z0+U60of29JsDxszCVHhqBAK+RemPEdDEo0lu9ifh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558966; c=relaxed/simple;
	bh=Tm/bLrHAyjqlxAbci7zBwGiOLC1PnlncvMx9VRv6rwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdrLxlEGrmXVVpremlcr/GMEWrdPQvBUIVid+spBqo8FIF5ARaF0IC+GIMPC/CclPXGPfjHGvEC18hTSwOaO1n7gxqDYlL859SuSSDX5J/pRYqATH37Qkkh+XdvFrcm1j5lYaxYOMsZSmEJIghzoIduOg05h7l0/kwdVb10JEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mA5FHg6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB68C4CEF8;
	Tue, 15 Jul 2025 05:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752558965;
	bh=Tm/bLrHAyjqlxAbci7zBwGiOLC1PnlncvMx9VRv6rwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mA5FHg6JotJX7HnwrRSf2X4czKopA5D7yxKcDXLdKR2kpyIWHSIFdZRwEJlqIIYVz
	 +2DQvPQf4JxvlAjd5GrOwEIrPN2klA+ozkjbc5IHl2qAzLUs/QaXqT7qr4pxxeWXyQ
	 S0UuUEv8JciDdZsxmK+jATNRPYiqqI3+0VFlCPn0=
Date: Tue, 15 Jul 2025 07:56:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, andreas.noever@gmail.com,
	michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
	rajat.khandelwal@intel.com, mika.westerberg@linux.intel.com,
	linux-usb@vger.kernel.org, kim.lindberger@gmail.com, linux@lunaa.ch,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Alyssa Ross <hi@alyssa.is>, regressions@lists.linux.dev
Subject: Re: [REGRESSION] thunderbolt: Fix a logic error in wake on connect
Message-ID: <2025071552-drinking-moisten-5bf7@gregkh>
References: <20250411151446.4121877-1-superm1@kernel.org>
 <cavyeum32dd7kxj65argtem6xh2575oq3gcv3svd3ubnvdc6cr@6nv7ieimfc5e>
 <87v7odo46s.fsf@alyssa.is>
 <51d5393c-d0e1-4f35-bed0-16c7ce40a8a8@kernel.org>
 <2025070737-charbroil-imply-7b5e@gregkh>
 <bb98ecb6-eb56-44d9-8f80-3172f9e7de03@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb98ecb6-eb56-44d9-8f80-3172f9e7de03@kernel.org>

On Mon, Jul 14, 2025 at 11:35:39AM -0500, Mario Limonciello wrote:
> On 7/7/25 2:57 AM, Greg Kroah-Hartman wrote:
> > On Sun, Jul 06, 2025 at 10:46:53AM -0400, Mario Limonciello wrote:
> > > On 6/30/25 07:32, Alyssa Ross wrote:
> > > > Alyssa Ross <hi@alyssa.is> writes:
> > > > 
> > > > > On Fri, Apr 11, 2025 at 10:14:44AM -0500, Mario Limonciello wrote:
> > > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > 
> > > > > > commit a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect
> > > > > > on USB4 ports") introduced a sysfs file to control wake up policy
> > > > > > for a given USB4 port that defaulted to disabled.
> > > > > > 
> > > > > > However when testing commit 4bfeea6ec1c02 ("thunderbolt: Use wake
> > > > > > on connect and disconnect over suspend") I found that it was working
> > > > > > even without making changes to the power/wakeup file (which defaults
> > > > > > to disabled). This is because of a logic error doing a bitwise or
> > > > > > of the wake-on-connect flag with device_may_wakeup() which should
> > > > > > have been a logical AND.
> > > > > > 
> > > > > > Adjust the logic so that policy is only applied when wakeup is
> > > > > > actually enabled.
> > > > > > 
> > > > > > Fixes: a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect on USB4 ports")
> > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > 
> > > > > Hi! There have been a couple of reports of a Thunderbolt regression in
> > > > > recent stable kernels, and one reporter has now bisected it to this
> > > > > change:
> > > > > 
> > > > >    • https://bugzilla.kernel.org/show_bug.cgi?id=220284
> > > > >    • https://github.com/NixOS/nixpkgs/issues/420730
> > > > > 
> > > > > Both reporters are CCed, and say it starts working after the module is
> > > > > reloaded.
> > > > > 
> > > > > Link: https://lore.kernel.org/r/bug-220284-208809@https.bugzilla.kernel.org%2F/
> > > > > (for regzbot)
> > > > 
> > > > Apparently[1] fixed by the first linked patch below, which is currently in
> > > > the Thunderbolt tree waiting to be pulled into the USB tree.
> > > > 
> > > > #regzbot monitor: https://lore.kernel.org/linux-usb/20250619213840.2388646-1-superm1@kernel.org/
> > > > #regzbot monitor: https://lore.kernel.org/linux-usb/20250626154009.GK2824380@black.fi.intel.com/
> > > > 
> > > > [1]: https://github.com/NixOS/nixpkgs/issues/420730#issuecomment-3018563631
> > > 
> > > Hey Greg,
> > > 
> > > Can you pick up the pull request from Mika from a week and a half ago with
> > > this fix for the next 6.16-rc?
> > > 
> > > https://lore.kernel.org/linux-usb/20250626154009.GK2824380@black.fi.intel.com/
> > 
> > Yes, I was waiting for this last round to go to Linus as the pull
> > request was made against a newer version of Linus's tree than I
> > currently had in my "for linus" branch.  I'll go get to that later
> > today.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Greg,
> 
> Sorry to be a bugger, but I was surprised I didn't see this come in -rc6
> this week, and I went and double checked your "usb-linus" branch [1] and
> didn't see it there.
> 
> Thanks,
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/?h=usb-linus

It's in there:

$ git lg main..usb-linus
*   cd0f8649d0e1 - (HEAD -> usb-linus, origin/usb-linus, kroah.org/usb-linus, work-linus) Merge tag 'usb-serial-6.16-rc6' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (6 days ago) <Greg Kroah-Hartman>
|\  
| * 08f49cdb71f3 - USB: serial: option: add Foxconn T99W640 (3 weeks ago) <Slark Xiao>
* 3014168731b7 - usb: gadget: configfs: Fix OOB read on empty string write (6 days ago) <Xinyu Liu>
* 67a59f82196c - usb: musb: fix gadget state on disconnect (8 days ago) <Drew Hamilton>
* 9fccced2d25b - Merge tag 'thunderbolt-for-v6.16-rc4' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus (8 days ago) <Greg Kroah-Hartman>
* 2cdde91c14ec - thunderbolt: Fix bit masking in tb_dp_port_set_hops() (3 weeks ago) <Alok Tiwari>
* 58d71d4242ce - thunderbolt: Fix wake on connect at runtime (3 weeks ago) <Mario Limonciello>

I'll get this to Linus for the next -rc.

thanks,

greg k-h

