Return-Path: <stable+bounces-139578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165AAA8BEF
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 08:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346241891585
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 06:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1D1A8409;
	Mon,  5 May 2025 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/8kLDHh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBE18FC89
	for <stable@vger.kernel.org>; Mon,  5 May 2025 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746424940; cv=none; b=SQZBr6rP+M4KbKROQuUKyJ+UKzNOfr/VnafZIcnIktl1pzm6xSea7jU0AW2dIZijJNNaAvrAjjBZU534Vg0K1uVSyDXOxNUYc7SYXpxeisG5vQCP+s9WaSbx083KAj8u5+bcp70K18FVeIZTFkMQ5gbpV1NCiQE9/DoxmBj1gQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746424940; c=relaxed/simple;
	bh=ia7KddwdDlYZGqqrlKs6k+UBCXMGsTOG8jQMZ/jIqc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irTYhQm6cTxQvUIGzS4OjpWx2js+s988EAgULqq1rcHZ4ehJ6nRi4dPQQZ04Bcfiavwt7Uh7U1942PJotvjQtlgAcMdGbPOWWoWyqj0K/UESVj8fa0QVpgZer7lM7+u/O45JIg/SQNXnNCKeXlZtcEQ3Opc+MvLrbalm/irGxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/8kLDHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6052CC4CEEE;
	Mon,  5 May 2025 06:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746424937;
	bh=ia7KddwdDlYZGqqrlKs6k+UBCXMGsTOG8jQMZ/jIqc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/8kLDHhsMgM167lUXRfXisxUw2hzCs5CWqK2tJxW0L/KrukWplbO69p2dh9yVR6L
	 XGrgKqJ9QlWaKQH7nXKAec8RF5rk5mgh9tr41fHBYbXVM9UB+lmNdJopZ+pE2p820Q
	 YxWC/ryFR4x1M29mki9Hv0ZPRtW8DJusu3Jl02ek=
Date: Mon, 5 May 2025 08:02:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: stable@vger.kernel.org, Karol Wachowski <karol.wachowski@intel.com>
Subject: Re: [PATCH 1/3] accel/ivpu: Abort all jobs after command queue
 unregister
Message-ID: <2025050536-detective-kelp-9dee@gregkh>
References: <20250430123653.3748811-1-jacek.lawrynowicz@linux.intel.com>
 <20250430123653.3748811-2-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430123653.3748811-2-jacek.lawrynowicz@linux.intel.com>

On Wed, Apr 30, 2025 at 02:36:51PM +0200, Jacek Lawrynowicz wrote:
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
> Cc: <stable@vger.kernel.org> # v6.14
> Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-4-maciej.falkowski@linux.intel.com
> ---
>  drivers/accel/ivpu/ivpu_drv.c   | 32 +++----------
>  drivers/accel/ivpu/ivpu_drv.h   |  2 +
>  drivers/accel/ivpu/ivpu_job.c   | 85 +++++++++++++++++++++++++--------
>  drivers/accel/ivpu/ivpu_job.h   |  1 +
>  drivers/accel/ivpu/ivpu_mmu.c   |  3 +-
>  drivers/accel/ivpu/ivpu_sysfs.c |  5 +-
>  6 files changed, 79 insertions(+), 49 deletions(-)

This backport is quite different from the original commit, so please
document what you did differently here in the backport down in the
signed-off-by area.  Same for the other patches in this series.

thanks,

greg k-h

