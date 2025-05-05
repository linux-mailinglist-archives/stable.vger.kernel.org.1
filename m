Return-Path: <stable+bounces-139579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0EEAA8C06
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 08:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90EE168770
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 06:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1501B9831;
	Mon,  5 May 2025 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sk6gG+ow"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE761B87F0
	for <stable@vger.kernel.org>; Mon,  5 May 2025 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425017; cv=none; b=Ny+BPIXLXsuxXpliI/+hmpnRmaNM2UyIXOW4Mm9xjn2wnlVbVNIIarUnSC9hDBQlA5BCbCx6SfiEa/zbVq/fh9AVYDDXUt+bC4txRFm8o8GOtgCBQ+0VdPCFUi6p1p7CBLjtWpHN7xRVS5d+rlUjg2PYV+ZotftHKIXAEPNtcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425017; c=relaxed/simple;
	bh=bS/dGnef9HnyGYwDIHVg2McepADnAmOCftEwqSriqYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAdcjmowcjBGCAmUhSswpC1p402BZIiej0b8SDZqKTQEcMT5QaB/n5kL8zwSNJyab108hich68TXlxLKiBz6GQWtLApRmqHF3A1/Dch75zG+0OplNd01buSE/OwvALgoWxPWKX7iSYg308dqhLXalYZaoaWbCOnj9SJz2eG48+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sk6gG+ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC32AC4CEE4;
	Mon,  5 May 2025 06:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746425017;
	bh=bS/dGnef9HnyGYwDIHVg2McepADnAmOCftEwqSriqYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sk6gG+ow54KaLUbbMczFu7EtAr/CB8FVvnbC21UvOyBCuUFGgRo2xEd4EdQBxuRIN
	 0z5j5+Kxlzl2r0l6jIjGFVGSrHZZyVgQCVBsgBSxI/s40qNy+xds3S28dlPQ/GQRmN
	 Ri0uNQ71CA2PpVEaMoF0iWD91jTJyoGN0bD2mnTI=
Date: Mon, 5 May 2025 08:03:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: stable@vger.kernel.org, Karol Wachowski <karol.wachowski@intel.com>
Subject: Re: [PATCH 5/7] accel/ivpu: Abort all jobs after command queue
 unregister
Message-ID: <2025050504-change-ignore-e99d@gregkh>
References: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
 <20250430124819.3761263-6-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430124819.3761263-6-jacek.lawrynowicz@linux.intel.com>

On Wed, Apr 30, 2025 at 02:48:17PM +0200, Jacek Lawrynowicz wrote:
> From: Karol Wachowski <karol.wachowski@intel.com>
> 
> commit 5bbccadaf33eea2b879d8326ad59ae0663be47d1 upstream.
> 
> With hardware scheduler it is not expected to receive JOB_DONE
> notifications from NPU FW for the jobs aborted due to command queue destroy
> JSM command.
> 
> Remove jobs submitted to unregistered command queue from submitted_jobs_xa
> to avoid triggering a TDR in such case.
> 
> Add explicit submitted_jobs_lock that protects access to list of submitted
> jobs which is now used to find jobs to abort.
> 
> Move context abort procedure to separate work queue not to slow down
> handling of IPCs or DCT requests in case where job abort takes longer,
> especially when destruction of the last job of a specific context results
> in context release.
> 
> Cc: <stable@vger.kernel.org> # v6.12
> Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-4-maciej.falkowski@linux.intel.com
> ---
>  drivers/accel/ivpu/ivpu_drv.c   | 32 +++----------
>  drivers/accel/ivpu/ivpu_drv.h   |  2 +
>  drivers/accel/ivpu/ivpu_job.c   | 82 +++++++++++++++++++++++++--------
>  drivers/accel/ivpu/ivpu_job.h   |  1 +
>  drivers/accel/ivpu/ivpu_mmu.c   |  3 +-
>  drivers/accel/ivpu/ivpu_sysfs.c |  5 +-
>  6 files changed, 77 insertions(+), 48 deletions(-)

Again, this is different from the original, so please document it as
such.

Please fix up both backported series of patches and resubmit a v2 of
them.

thanks,

greg k-h

