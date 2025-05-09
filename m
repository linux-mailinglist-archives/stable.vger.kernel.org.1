Return-Path: <stable+bounces-143053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B05AB1743
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9211C27C05
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D6C147;
	Fri,  9 May 2025 14:22:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA82110
	for <stable@vger.kernel.org>; Fri,  9 May 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800553; cv=none; b=d7l+faSDF4LVaju16iMKbJZgWWbiBhR2ek8kt34ZWPr2QQgqgBZeEi1Zq+2MXqrh3TXhA6dZgSBPe4XZMP3s65iwiI0r64k+LDccX26OdbBaTtB6j+FBc+fXYvjMplLMvrK0xi2CXruoL68oNy6TxtbwQRQ5WnnQNkBlgaCFlNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800553; c=relaxed/simple;
	bh=2zaQhErJPN3uZ2cg/gLpnbkL4EsK1rCm5F4ZAkxbU4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG+MAwSDP5qH89a0PO5sfMbrnen4jtSANaIkW4sOXm1NDbho3phnIBnYifUiMh8IQnfsqNRCM6mVuk/RVJasaNx3Pp0ic432RV+pUTWwiyOh5dZTRg0n5n+8FdJZIYqy63ZBGwUQBYrEj8rsCEEZWWL31vcx/TsFaTSjt9qSu0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 131E0175D;
	Fri,  9 May 2025 07:22:20 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 537163F5A1;
	Fri,  9 May 2025 07:22:30 -0700 (PDT)
Date: Fri, 9 May 2025 15:22:22 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] firmware: arm_scmi: Add missing definition of info
 reference
Message-ID: <aB4PnqeXehOD0VPz@pluto>
References: <2025050930-scuba-spending-0eb9@gregkh>
 <20250509114422.982089-1-cristian.marussi@arm.com>
 <2025050920-aide-squire-5a2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025050920-aide-squire-5a2e@gregkh>

On Fri, May 09, 2025 at 03:45:26PM +0200, Greg KH wrote:
> On Fri, May 09, 2025 at 12:44:22PM +0100, Cristian Marussi wrote:
> > Add the missing definition that caused a build break.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/driver.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 609fbf4563ff..3f3701ed196e 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -1044,6 +1044,8 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
> >  		 */
> >  		if (!desc->sync_cmds_completed_on_ret) {
> >  			bool ooo = false;
> > +			struct scmi_info *info =
> > +				handle_to_scmi_info(cinfo->handle);
> >  
> >  			/*
> >  			 * Poll on xfer using transport provided .poll_done();
> > -- 
> > 2.39.5
> > 

Hi Greg,

> > 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.

..oh...I know...but from the FAILED report that I received related to the
fact that the patch did not apply cleanly...

https://lore.kernel.org/all/2025050930-scuba-spending-0eb9@gregkh/

---
The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c23c03bf1faa1e76be1eba35bad6da6a2a7c95ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050930-scuba-spending-0eb9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:
----

...my (mis-)understanding was that you wanted some sort of diff on top
of that the bad non-applying patch ('git commit -s') instead of fresh new
poeprly backported patch....thing which, indeed, seemed weird :P

I'll resend following the proper procedure.

Sorry for the noise.

Thanks,
Cristian

