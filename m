Return-Path: <stable+bounces-110997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29B9A20F9B
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 18:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217C4166C45
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8AD1D4335;
	Tue, 28 Jan 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="008Pfunw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293491ACEDF
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738085445; cv=none; b=LJzRIOsVBMkMRv84vWnCQBS/5CZmVJa5vsgGr+dlF5TuzHF1hHJhkTrjlbBCuPtFU5LTV/AoVzh1rhXqWCugl2Lsgh9YiOuaoFUB/rXwT9Xhg67tszpNVt8kcQnksYygLL8CZPKe6qR/g0S1ZXG1sGLgtS5/ybfurHud00uwhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738085445; c=relaxed/simple;
	bh=y8an0pAYmP+yxjG73kK47JSoHz9jfLNp8m3vGku4/9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1sFRIdSiyPA7cQw1P6jkJEcuFEmkhERtaO7WrhTZTlMlj/C+GUUao8ZHFSXIXxLhOkFueL1mYcbKMUKBQNxrfkASUOcHVyJ8CLB1edfvuYKLvPzgHR2D9pppb2NzNemh4m3hmY6+/70d5/jGb0H/JAdzZjLRtcpSSA/+QH9wIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=008Pfunw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407AFC4CED3;
	Tue, 28 Jan 2025 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738085443;
	bh=y8an0pAYmP+yxjG73kK47JSoHz9jfLNp8m3vGku4/9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=008Pfunw/eldLmDFq7w0sDFRXaNZyW9J7lU07kbaAD31+FF9eMQTbvR4Vd7MmZRYe
	 IdSz4BDTu3eKkFX0Xw+T4iwU4J/oHGcIuXK2zRF4FoRx+DN9EFBSX+3KbYdH+ryzd9
	 GqAAXFOPBjqEQjzi47oFts8mP6+QBXbKU422H9Rc=
Date: Tue, 28 Jan 2025 18:30:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 6.12.y] scsi: storvsc: Ratelimit warning logs to prevent
 VM denial of service
Message-ID: <2025012816-usher-discover-d252@gregkh>
References: <20250127182955.67606-1-eahariha@linux.microsoft.com>
 <2025012856-written-jarring-4843@gregkh>
 <185173f5-5f46-4c24-b4fb-86dab478ea02@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <185173f5-5f46-4c24-b4fb-86dab478ea02@linux.microsoft.com>

On Tue, Jan 28, 2025 at 09:08:42AM -0800, Easwar Hariharan wrote:
> On 1/27/2025 9:35 PM, Greg KH wrote:
> > On Mon, Jan 27, 2025 at 06:29:54PM +0000, Easwar Hariharan wrote:
> >> commit d2138eab8cde61e0e6f62d0713e45202e8457d6d upstream
> >>
> >> If there's a persistent error in the hypervisor, the SCSI warning for
> >> failed I/O can flood the kernel log and max out CPU utilization,
> >> preventing troubleshooting from the VM side. Ratelimit the warning so
> >> it doesn't DoS the VM.
> >>
> >> Closes: https://github.com/microsoft/WSL/issues/9173
> >> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> >> Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
> >> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> >> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> >> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> >> ---
> >>  drivers/scsi/storvsc_drv.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > What about 6.13.y?
> > 
> 
> Yes, needs a backport to that too, another miss on my part. :(
> 
> Would you rather I send it after rc1 is tagged, or now for completeness?

Whenever you have it, we can't apply any of these until -rc1 is out.

thanks,

greg k-h

