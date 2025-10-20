Return-Path: <stable+bounces-188131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D826FBF2020
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE0618A7B2C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF41B22D7B5;
	Mon, 20 Oct 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PkOwTjTH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE621019E
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972971; cv=none; b=sdELgr+Herj88yKl4uL/ijHt3uItvykJkIyzYbP6SZU8o52gw/v+t1ZIdFdCJoj48tPV1oYcA+sOmkDzSv4GLc94m0CJHHPrdy5syOJaA65OWatQvn4NH2sbE1j5yntGykw3Nruiucn6fFCYWSS6hJdCJjk42fwzCbmTfTf/yGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972971; c=relaxed/simple;
	bh=n0EX52OtFQ+Q0Qsu6lx4MxSKWbSNNjPrn82eWuoqTvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeMeoNl9sRLPh3txgNDK2VDPW000hJMoAemPXgkUcVmHBLGHQPi4tMAI9OZygsJr1Ur2S4hTt/TdrWqCPHhd1/RwOginwyKOz/mO+YzLrOEZqRQzQdOCv6gEFFne5n7EaV2mF2Rv5VjCgT31QzqdajISfh947evBtpTHoQ8GZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PkOwTjTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9BBC116C6;
	Mon, 20 Oct 2025 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760972970;
	bh=n0EX52OtFQ+Q0Qsu6lx4MxSKWbSNNjPrn82eWuoqTvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkOwTjTHTQbHHir6Yrr2KjyMWd1iIxcb7Iwz+yvfNNY6ooQLYvu0BF55Nj+ZO1vdP
	 uXygPPu1xVOSU8cfKUSCHNKo2MePXA2sxwTCTUmHJxkVtF8XBl3XK/O5R1GgY8v8aV
	 DnG61TzZviP+HNkVmBItQ7R1AxMwc4Ms8ELZUW2E=
Date: Mon, 20 Oct 2025 17:09:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Babu Moger <babu.moger@amd.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.17.y] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously unavailable RMID
Message-ID: <2025102051-flying-despise-6a9b@gregkh>
References: <2025102047-tissue-surplus-ff35@gregkh>
 <20251020150405.24259-1-babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020150405.24259-1-babu.moger@amd.com>

On Mon, Oct 20, 2025 at 10:04:05AM -0500, Babu Moger wrote:
> Users can create as many monitoring groups as the number of RMIDs supported
> by the hardware. However, on AMD systems, only a limited number of RMIDs
> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
> this limit are placed in an "Unavailable" state.
> 
> When a bandwidth counter is read for such an RMID, the hardware sets
> MSR_IA32_QM_CTR.Unavailable (bit 62). When such an RMID starts being tracked
> again the hardware counter is reset to zero. MSR_IA32_QM_CTR.Unavailable
> remains set on first read after tracking re-starts and is clear on all
> subsequent reads as long as the RMID is tracked.
> 
> resctrl miscounts the bandwidth events after an RMID transitions from the
> "Unavailable" state back to being tracked. This happens because when the
> hardware starts counting again after resetting the counter to zero, resctrl
> in turn compares the new count against the counter value stored from the
> previous time the RMID was tracked.
> 
> This results in resctrl computing an event value that is either undercounting
> (when new counter is more than stored counter) or a mistaken overflow (when
> new counter is less than stored counter).
> 
> Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to
> zero whenever the RMID is in the "Unavailable" state to ensure accurate
> counting after the RMID resets to zero when it starts to be tracked again.
> 
> Example scenario that results in mistaken overflow
> ==================================================
> 1. The resctrl filesystem is mounted, and a task is assigned to a
>    monitoring group.
> 
>    $mount -t resctrl resctrl /sys/fs/resctrl
>    $mkdir /sys/fs/resctrl/mon_groups/test1/
>    $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks
> 
>    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>    21323            <- Total bytes on domain 0
>    "Unavailable"    <- Total bytes on domain 1
> 
>    Task is running on domain 0. Counter on domain 1 is "Unavailable".
> 
> 2. The task runs on domain 0 for a while and then moves to domain 1. The
>    counter starts incrementing on domain 1.
> 
>    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>    7345357          <- Total bytes on domain 0
>    4545             <- Total bytes on domain 1
> 
> 3. At some point, the RMID in domain 0 transitions to the "Unavailable"
>    state because the task is no longer executing in that domain.
> 
>    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>    "Unavailable"    <- Total bytes on domain 0
>    434341           <- Total bytes on domain 1
> 
> 4.  Since the task continues to migrate between domains, it may eventually
>     return to domain 0.
> 
>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>     17592178699059  <- Overflow on domain 0
>     3232332         <- Total bytes on domain 1
> 
> In this case, the RMID on domain 0 transitions from "Unavailable" state to
> active state. The hardware sets MSR_IA32_QM_CTR.Unavailable (bit 62) when
> the counter is read and begins tracking the RMID counting from 0.
> 
> Subsequent reads succeed but return a value smaller than the previously
> saved MSR value (7345357). Consequently, the resctrl's overflow logic is
> triggered, it compares the previous value (7345357) with the new, smaller
> value and incorrectly interprets this as a counter overflow, adding a large
> delta.
> 
> In reality, this is a false positive: the counter did not overflow but was
> simply reset when the RMID transitioned from "Unavailable" back to active
> state.
> 
> Here is the text from APM [1] available from [2].
> 
> "In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
> first QM_CTR read when it begins tracking an RMID that it was not
> previously tracking. The U bit will be zero for all subsequent reads from
> that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
> read with the U bit set when that RMID is in use by a processor can be
> considered 0 when calculating the difference with a subsequent read."
> 
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
>     Bandwidth (MBM).
> 
>   [ bp: Split commit message into smaller paragraph chunks for better
>     consumption. ]
> 
> Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: stable@vger.kernel.org # needs adjustments for <= v6.17
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
> (cherry picked from commit 15292f1b4c55a3a7c940dbcb6cb8793871ed3d92)

This wasn't a "clean" cherry-pick at all, please document the changes
made from the upstream version here.

thanks,

greg k-h

