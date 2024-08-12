Return-Path: <stable+bounces-66495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6616394EC7B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FE61F21B29
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98B179970;
	Mon, 12 Aug 2024 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MMju6fgu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB09178378;
	Mon, 12 Aug 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464713; cv=none; b=H2WbcR1ob5VEga2U6GcsRu/Hf3w1biHeUpxrpZPpUKfwb2Bok6Rz85GR2vPbr0gALu4asMQ7GmiocgDSF1F0wm86h7LMa8BKj4XZSEMVvocEQUTP5JV/FRlCfygl6Hw5F2Lo2+tritct3MeaY2ct4kaX+d5KbSn776gG3yKy2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464713; c=relaxed/simple;
	bh=U3BJflhY7WPD1IxSWU1W91AcK1N2c18oHaTsBoI6ENQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp8CGA5zK/fGvYwuAaX6ShUsUBQnNmBjFM4IDdxbz1098DsqA4LS1gByKOrIA1ywRb81okk/z3X9bBTL70LmjQbOz33DCJ+DMN9JbyCynWrH+xTLl2Yh9rl4gX3kIqcNmeWjlVttuEMR7WR80wxExzRwRyfeqtw4BVcch3rwh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MMju6fgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708ACC32782;
	Mon, 12 Aug 2024 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464712;
	bh=U3BJflhY7WPD1IxSWU1W91AcK1N2c18oHaTsBoI6ENQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMju6fgunQZUV2NyRavTOI12WQBuPbckj0+mY+pqqfM3LqsIP8RwmWeYVGeeGSiuz
	 Z95B8in+1IxnoQZ/M0I/MO4OMTMKLEfo/E0BzJnw7UgDSmO/cQUXLzODjc5Z9v7/hc
	 gcOG7oYYEAT7EpAyuJfZoLwxE+F2gMAkLxbm2fR8=
Date: Mon, 12 Aug 2024 14:11:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Thomas Lindroth <thomas.lindroth@gmail.com>, stable@vger.kernel.org,
	tony.luck@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [STABLE REGRESSION] Possible missing backport of x86_match_cpu()
 change in v6.1.96
Message-ID: <2024081217-putt-conform-4b53@gregkh>
References: <eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com>
 <a79fa3cc-73ef-4546-b110-1f448480e3e6@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79fa3cc-73ef-4546-b110-1f448480e3e6@leemhuis.info>

On Wed, Aug 07, 2024 at 10:15:23AM +0200, Thorsten Leemhuis wrote:
> [CCing the x86 folks, Greg, and the regressions list]
> 
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> On 30.07.24 18:41, Thomas Lindroth wrote:
> > I upgraded from kernel 6.1.94 to 6.1.99 on one of my machines and
> > noticed that
> > the dmesg line "Incomplete global flushes, disabling PCID" had
> > disappeared from
> > the log.
> 
> Thomas, thx for the report. FWIW, mainline developers like the x86 folks
> or Tony are free to focus on mainline and leave stable/longterm series
> to other people -- some nevertheless help out regularly or occasionally.
> So with a bit of luck this mail will make one of them care enough to
> provide a 6.1 version of what you afaics called the "existing fix" in
> mainline (2eda374e883ad2 ("x86/mm: Switch to new Intel CPU model
> defines") [v6.10-rc1]) that seems to be missing in 6.1.y. But if not I
> suspect it might be up to you to prepare and submit a 6.1.y variant of
> that fix, as you seem to care and are able to test the patch.

Needs to go to 6.6.y first, right?  But even then, it does not apply to
6.1.y cleanly, so someone needs to send a backported (and tested) series
to us at stable@vger.kernel.org and we will be glad to queue them up
then.

thanks,

greg k-h

