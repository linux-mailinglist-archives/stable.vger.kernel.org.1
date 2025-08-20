Return-Path: <stable+bounces-171906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A443B2DF4F
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367157AF74E
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED87E5680;
	Wed, 20 Aug 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X00QGjMp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F8274B42
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699980; cv=none; b=QE+0ejl8omzddroNXu37qcQT43J+FWvPYlQUFkp51QdJw52vSSbAL7qNTdA0osa8AL2C1P2/rwxRqDO5UVld3f5rV5WibyO3E/2s5P1viRTjHRg0YCtEZExihAjEVARRYwNvAFFCPrO10tbJxsxTcIaxlF36SeNpWht+hyRBBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699980; c=relaxed/simple;
	bh=CUNayZcyCD6Lz6wxz+nl7hopr6y+3GZCyAePDuInqkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nY0qvTQfVR2ovfOt4bEof+77qXfbAr6PD18LaBm/wtiWfl/Y3oeV8nOWqYQ9d9WiPwciI+UWVDfyJefO3Mai1xhVJ53yjDKlhe3p2VFWeBQr4E+E9rqYiP5ZJYXgurk424KS+2X3LFC6NfYtsfOJAoIRrMiuEg2QUI4iuRqufoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X00QGjMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF88C4CEE7;
	Wed, 20 Aug 2025 14:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755699980;
	bh=CUNayZcyCD6Lz6wxz+nl7hopr6y+3GZCyAePDuInqkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X00QGjMpt+6JrmNG3ey+Oepjpz/KxGpvBT9b2NGGUyp7vvrA+NuNLxcJVJ7C3C9LB
	 sIOB5/Yrzdfd+3XOFN1efep9MmWjRsB2Zf54RNOLH3bwJ2VVVCuQCvwkEdlXl9ArhF
	 FsVryJyU5M/KBdMCejw/tbWltqKvME23rEka3deE=
Date: Wed, 20 Aug 2025 16:26:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: stable@vger.kernel.org, "akash.m5@samsung.com" <akash.m5@samsung.com>,
	"thiagu.r@samsung.com" <thiagu.r@samsung.com>
Subject: Re: [PATCH stable 5.10] usb: dwc3: Remove DWC3 locking during gadget
 suspend/resume
Message-ID: <2025082051-circle-state-e38e@gregkh>
References: <CGME20250820141146epcas5p1a87653e56e5a9e6ce844330a94e76eea@epcas5p1.samsung.com>
 <8c68604b-2775-4d70-a0d6-18ecb979c797@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c68604b-2775-4d70-a0d6-18ecb979c797@samsung.com>

On Wed, Aug 20, 2025 at 07:41:44PM +0530, Selvarasu Ganesan wrote:
> Dear stable team,
> 
> 
> Patch : usb: dwc3: Remove DWC3 locking during gadget suspend/resume
> 
> Commit id:5265397f94424eaea596026fd34dc7acf474dcec
> 
> This patch fixes a critical bug in the dwc3 driver that was introduced 
> by commit 
> (https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/usb/dwc3/gadget.c?h=v5.10.240&id=90e2820c6c30db2427d020d344dfca7de813bd24 
> <https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/usb/dwc3/gadget.c?h=v5.10.240&id=90e2820c6c30db2427d020d344dfca7de813bd24>) 
> in the 5.10 kernel series.

But that is not what the dwc3 patch says it does, how do we know it is
ok to backport this?

> The bug causes the below kernel crash (Added usleep in atomic context as 
> part of above patch) under dwc3 suspend/resume scenarios.
> 
> 35.829644] [6: kworker/6:1: 68] BUG: scheduling while atomic: 
> kworker/6:1/68/0x00000002
> 
> [ 35.829946] [6: kworker/6:1: 68] CPU: 6 PID: 68 Comm: kworker/6:1 
> Tainted: G C E 5.10.236-android13-4 #1
> 
> [ 35.830010] [6: kworker/6:1: 68] Call trace:
> 
> [ 35.830024] [6: kworker/6:1: 68] dump_backtrace.cfi_jt+0x0/0x8
> 
> [ 35.830034] [6: kworker/6:1: 68] show_stack+0x1c/0x2c
> 
> [ 35.830044] [6: kworker/6:1: 68] dump_stack_lvl+0xd8/0x134
> 
> [ 35.830053] [6: kworker/6:1: 68] __schedule_bug+0x80/0xbc
> 
> [ 35.830062] [6: kworker/6:1: 68] __schedule+0x55c/0x7e8
> 
> [ 35.830068] [6: kworker/6:1: 68] schedule+0x80/0x100
> 
> [ 35.830077] [6: kworker/6:1: 68] schedule_hrtimeout_range_clock+0xa8/0x11c
> 
> [ 35.830083] [6: kworker/6:1: 68] usleep_range+0x68/0xa4
> 
> [ 35.830093] [6: kworker/6:1: 68] dwc3_gadget_run_stop+0x170/0x448
> 
> [ 35.830099] [6: kworker/6:1: 68] dwc3_gadget_resume+0x4c/0xdc
> 
> [ 35.830108] [6: kworker/6:1: 68] dwc3_resume_common+0x6c/0x23c
> 
> [ 35.830115] [6: kworker/6:1: 68] dwc3_runtime_resume+0x40/0xcc
> 
> [ 35.830123] [6: kworker/6:1: 68] pm_generic_runtime_resume+0x48/0x88
> 
> [ 35.830131] [6: kworker/6:1: 68] __rpm_callback+0x94/0x420
> 
> The patch(5265397f9442) for this fix was originally merged in the below 
> commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/dwc3?h=next-20250820&id=5265397f94424eaea596026fd34dc7acf474dcec 
> <https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/dwc3?h=next-20250820&id=5265397f94424eaea596026fd34dc7acf474dcec>
> 
>   Please apply this patch to the stable 5.10 kernel to prevent this BUG.
> 
> Additionally the below patch also required to avoid dead lock that 
> introduced by the abovepatch (5265397f9442) in 5.10 stable kernel.
> 
> Patch:usb: dwc3: core: remove lock of otg mode during gadget 
> suspend/resume to avoid deadlock
> 
> Commit id:7838de15bb700c2898a7d741db9b1f3cbc86c136

Can you please submit a backported, and tested, series of patches here
so that we know that we got the correct ones, and we have your
signed-off-by on them to show you tested them?

thanks,

greg k-h

