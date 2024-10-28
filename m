Return-Path: <stable+bounces-88274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0D59B24BB
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB423B21632
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 05:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4618CBF1;
	Mon, 28 Oct 2024 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TDJUOSk6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BC1885BE
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094933; cv=none; b=aUZKNThzV5+441gBSzb8Tb5SINU79mVyB2Tnw+l6bzGxH2qzurTsROW9n3crCcsVchQ3QI1HUx4iHLPm/fbTLDNqZFXBZnyq4cgfTeeXwKrumqqOzsLLo6Vj/KDB9dWhcmb7E2fwk1gJuDVrz/oAagmpr2D3M1ILpqdxJJXOrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094933; c=relaxed/simple;
	bh=IVt+K4s9birnleSZYPmltVXoy1MtsNXdfXn703Iv91o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvK/uWSIdMv/swPvlw26LoArQHDptqeEZZCamQUKg6icuHcaVZ1usrx6OmJ9HDJXXGDsgOudtgESkSclDVW9/2zzAIhpWDSetbr+x1YbOhNjflupe2Lb46lo6tUo425/bks4r6fKcRoXQAK6R0zDmW225+sKjPdK2GaOwe8+HAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TDJUOSk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C342C4CEC3;
	Mon, 28 Oct 2024 05:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730094932;
	bh=IVt+K4s9birnleSZYPmltVXoy1MtsNXdfXn703Iv91o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TDJUOSk6wJeBEVyhfROCwSKVlvyhuktX8uSNH8Bx3z670LcKsWybejANFHmOqYJkO
	 dxlXGKOtYICSQDIJpNLkD9mWXTjUvOLh2G1/HqyZ/kK40gjAa+rE1DIJUnveJX4N2s
	 QJUuRy9zFphzUSp2rcqC2jUpDq+KSnKQaj+R7MTg=
Date: Mon, 28 Oct 2024 06:55:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: stable@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	irogers@google.com, kan.liang@linux.intel.com, tglx@linutronix.de,
	gautham.shenoy@amd.com
Subject: Re: Request to backport a fix to 6.10 and 6.11 stable kernels
Message-ID: <2024102805-urologist-proven-215a@gregkh>
References: <fb8f9176-2cf8-4bdc-a8f9-a1b96e49c9b6@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8f9176-2cf8-4bdc-a8f9-a1b96e49c9b6@amd.com>

On Thu, Oct 24, 2024 at 10:34:15AM +0530, Dhananjay Ugwekar wrote:
> Hello,
> 
> The patch "[PATCH v3] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs" fixes the RAPL energy-pkg event on AMD CPUs. It was broken by "commit 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")", which got merged in v6.10-rc1. 
> 
> I missed the "Fixes" tag while posting the patch on LKML.
> 
> Please backport the fix to 6.10 (I see this is EOL so probably this wont be possible) and 6.11 stable kernels. Mainline commit ID for the fix is "8d72eba1cf8c".

Yes, 6.10 is long end-of-life, added now for 6.11.y, thanks.

greg k-h

