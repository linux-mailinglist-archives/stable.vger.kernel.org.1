Return-Path: <stable+bounces-160343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E342CAFADCA
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 09:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F2B188945C
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C24279DD7;
	Mon,  7 Jul 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1pWZxct4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0B1A0BF1;
	Mon,  7 Jul 2025 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875038; cv=none; b=bUbk1FC8IXCTfzq5/xyQI88RtNBJlHLr55ggz+U2dLZlDVg+88syp8KehrFtkDAfUzE1t9inL8Ua8+aWn8bRpSOEVkkfv++2ExrXaykZGR047QFDnL4ZGcwygnH+NMmMEtMLuFFm4wBJht1QV4mUq37CmzR2KwH6fMbwiQiANQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875038; c=relaxed/simple;
	bh=clixo0WX7xiieK6BB2BUIJIDIXXL6gQ+H7kdA9xRXJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVq2+wYTCST6HlJq+Qge5qd/FNZS64nTJhWQ1556KvLek/vU6qMEk2jESOXXHiCRmfjBnqrvDvdXPPz/1B3SZiOzJcE+P6MLwfIQdm+zcbbtpOrUlp3KxqkFJREwh1u3LYWqz02PurN8IqKaOwmlWW1sw8MFVeMdcU09IKt45zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1pWZxct4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB6DC4CEE3;
	Mon,  7 Jul 2025 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751875037;
	bh=clixo0WX7xiieK6BB2BUIJIDIXXL6gQ+H7kdA9xRXJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1pWZxct43kpoiYEX6qfUlU+4ZrJQntDmlyhs7OfKYvtMFuXRh5zesOQpq/9z3jNqm
	 bxOd1moerKqEQ6zr6T5w1vOC3AUxMM4/IH5nXP075cXSxUFSDKCZvs5sBm6/Y+kLmQ
	 3cyVHoO6k5NtdS5vfBFe4shpB1ru0qmOcBGtVnQM=
Date: Mon, 7 Jul 2025 09:57:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, andreas.noever@gmail.com,
	michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
	rajat.khandelwal@intel.com, mika.westerberg@linux.intel.com,
	linux-usb@vger.kernel.org, kim.lindberger@gmail.com, linux@lunaa.ch,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Alyssa Ross <hi@alyssa.is>, regressions@lists.linux.dev
Subject: Re: [REGRESSION] thunderbolt: Fix a logic error in wake on connect
Message-ID: <2025070737-charbroil-imply-7b5e@gregkh>
References: <20250411151446.4121877-1-superm1@kernel.org>
 <cavyeum32dd7kxj65argtem6xh2575oq3gcv3svd3ubnvdc6cr@6nv7ieimfc5e>
 <87v7odo46s.fsf@alyssa.is>
 <51d5393c-d0e1-4f35-bed0-16c7ce40a8a8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51d5393c-d0e1-4f35-bed0-16c7ce40a8a8@kernel.org>

On Sun, Jul 06, 2025 at 10:46:53AM -0400, Mario Limonciello wrote:
> On 6/30/25 07:32, Alyssa Ross wrote:
> > Alyssa Ross <hi@alyssa.is> writes:
> > 
> > > On Fri, Apr 11, 2025 at 10:14:44AM -0500, Mario Limonciello wrote:
> > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > 
> > > > commit a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect
> > > > on USB4 ports") introduced a sysfs file to control wake up policy
> > > > for a given USB4 port that defaulted to disabled.
> > > > 
> > > > However when testing commit 4bfeea6ec1c02 ("thunderbolt: Use wake
> > > > on connect and disconnect over suspend") I found that it was working
> > > > even without making changes to the power/wakeup file (which defaults
> > > > to disabled). This is because of a logic error doing a bitwise or
> > > > of the wake-on-connect flag with device_may_wakeup() which should
> > > > have been a logical AND.
> > > > 
> > > > Adjust the logic so that policy is only applied when wakeup is
> > > > actually enabled.
> > > > 
> > > > Fixes: a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect on USB4 ports")
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > Hi! There have been a couple of reports of a Thunderbolt regression in
> > > recent stable kernels, and one reporter has now bisected it to this
> > > change:
> > > 
> > >   • https://bugzilla.kernel.org/show_bug.cgi?id=220284
> > >   • https://github.com/NixOS/nixpkgs/issues/420730
> > > 
> > > Both reporters are CCed, and say it starts working after the module is
> > > reloaded.
> > > 
> > > Link: https://lore.kernel.org/r/bug-220284-208809@https.bugzilla.kernel.org%2F/
> > > (for regzbot)
> > 
> > Apparently[1] fixed by the first linked patch below, which is currently in
> > the Thunderbolt tree waiting to be pulled into the USB tree.
> > 
> > #regzbot monitor: https://lore.kernel.org/linux-usb/20250619213840.2388646-1-superm1@kernel.org/
> > #regzbot monitor: https://lore.kernel.org/linux-usb/20250626154009.GK2824380@black.fi.intel.com/
> > 
> > [1]: https://github.com/NixOS/nixpkgs/issues/420730#issuecomment-3018563631
> 
> Hey Greg,
> 
> Can you pick up the pull request from Mika from a week and a half ago with
> this fix for the next 6.16-rc?
> 
> https://lore.kernel.org/linux-usb/20250626154009.GK2824380@black.fi.intel.com/

Yes, I was waiting for this last round to go to Linus as the pull
request was made against a newer version of Linus's tree than I
currently had in my "for linus" branch.  I'll go get to that later
today.

thanks,

greg k-h

