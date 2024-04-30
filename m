Return-Path: <stable+bounces-42829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F838B7FAA
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 20:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3D31F24F8A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01819181D15;
	Tue, 30 Apr 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TKB7n3DB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CE1802DC
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501666; cv=none; b=hhQRhVQ8b5rL6ApGi1mrHCBnzigFaHbc+k37oeIx/W7WununHmkT0PHM6JjiBi22LosmjWhsYzF4LmEMHOEFDUpmQeCF0YWSCX7UKCc7NgBpC9Do3mgbrYho8HyJcEycdE6Kr/YbBaqwEDrh1AHyqUpN8zzoXdTu0IY38nNHYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501666; c=relaxed/simple;
	bh=SvjH0c26sxOD2mBwzoAlfZVTwGTUe/ZWoTX+hXmg13M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooba1SqpNAw4K9ikLC5BiSck8RtaDaBUAs+QNojpoRrtZN+HEXI78/9aB/8PPziYFMx5fvIrUBz5GLQ2wo93Un9hMnlGqHlROmMw8tVOmUgwaizQ67vJM1qdz/QlD+2IenUmtVS4B12SqLVH3oSgJ0HcC78iutOTeKFi6CB2AYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TKB7n3DB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A08C2BBFC;
	Tue, 30 Apr 2024 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714501666;
	bh=SvjH0c26sxOD2mBwzoAlfZVTwGTUe/ZWoTX+hXmg13M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKB7n3DBG8WzJVtksuti3y0C3x71HFB9lzfjIS64Sv3m0W5j/5cGSwsQa1oglhdBB
	 zbg+F7pwtNn9VXZX49X9bvZr8vHl9hj2dh8ROwkCODn2ufFRf2osyKww8ZZSsaRyyj
	 UKT3+8I8ODqFGEwrBcM8SN5glhEXmD6HMPw8GRFc=
Date: Tue, 30 Apr 2024 20:27:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: vanshikonda@os.amperecomputing.com, jarredwhite@linux.microsoft.com,
	rafael.j.wysocki@intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ACPI: CPPC: Fix access width used for PCC
 registers" failed to apply to 5.15-stable tree
Message-ID: <2024043030-divinity-cube-9d5c@gregkh>
References: <2024042905-puppy-heritage-e422@gregkh>
 <24df5fe0-9e1a-4929-b132-3654ec9d8bf3@linux.microsoft.com>
 <2024043016-overhung-oaf-8201@gregkh>
 <3693107b-054d-485a-9e1c-c23c683db590@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3693107b-054d-485a-9e1c-c23c683db590@linux.microsoft.com>

On Tue, Apr 30, 2024 at 11:05:06AM -0700, Easwar Hariharan wrote:
> On 4/30/2024 10:41 AM, Greg KH wrote:
> > On Tue, Apr 30, 2024 at 09:05:28AM -0700, Easwar Hariharan wrote:
> >> On 4/29/2024 4:53 AM, gregkh@linuxfoundation.org wrote:
> >>>
> >>> The patch below does not apply to the 5.15-stable tree.
> >>> If someone wants it applied there, or to any other stable or longterm
> >>> tree, then please email the backport, including the original git commit
> >>> id to <stable@vger.kernel.org>.
> >>>
> >>> To reproduce the conflict and resubmit, you may use the following commands:
> >>>
> >>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> >>> git checkout FETCH_HEAD
> >>> git cherry-pick -x f489c948028b69cea235d9c0de1cc10eeb26a172
> >>> # <resolve conflicts, build, test, etc.>
> >>> git commit -s
> >>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042905-puppy-heritage-e422@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> >>>
> >>> Possible dependencies:
> >>>
> >>> f489c948028b ("ACPI: CPPC: Fix access width used for PCC registers")
> >>> 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
> >>> 0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address space")
> >>> c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not supported by firmware")
> >>> 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the _OSC regardless of the query flag"")
> >>> f684b1075128 ("ACPI: CPPC: Drop redundant local variable from cpc_read()")
> >>> 5f51c7ce1dc3 ("ACPI: CPPC: Fix up I/O port access in cpc_read()")
> >>> a2c8f92bea5f ("ACPI: CPPC: Implement support for SystemIO registers")
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>>
> >>
> >> Hi Greg,
> >>
> >> Please fix this with the following set of changes in linux-5.15.y.
> >>
> >> Revert b54c4632946ae42f2b39ed38abd909bbf78cbcc2 from linux-5.15.y
> >> Cherry-pick 05d92ee782eeb7b939bdd0189e6efcab9195bf95 from upstream
> >> Pick the following backport of f489c948028b69cea235d9c0de1cc10eeb26a172 from upstream
> > 
> > Please provide a series of patches that I can apply that does this,
> > attempting to revert and cherry-pick and then manually hand-edit this
> > email and apply it does not scale at all, sorry.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Sorry about that, I'll send the series right away. I'm not quite sure what Closes: lore link to provide, could you please fix it up?

There's no need for any "Closes:" link for stable backports.

thanks,

greg k-h

