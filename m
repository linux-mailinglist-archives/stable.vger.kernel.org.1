Return-Path: <stable+bounces-195469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690CC779E9
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 07:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 973CC4E7A41
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 06:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CBC1C84C0;
	Fri, 21 Nov 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w4Ehqa6w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008727A469;
	Fri, 21 Nov 2025 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708047; cv=none; b=NbVOlVZpkEP367MoreYesBsOE+2okpY+cOfPVwXKUHGqxBMxl2qVMvZEpeZ7+R0Bq4L1a2/BtQc3HyxQUqqYpiRB2E7D1dy8BBROzeA8xfSdW2Oq5Hfg1bJzXbbwkPkDQL20ajoAvRUwHgxObQdbOXXFyQYanfW0ZErwBiRrJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708047; c=relaxed/simple;
	bh=7J1qHLg9MNKehT8t5EyZLfHtGqN8q3NhKWYNKDJrwrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2/t00F69OlcxsUpjUfPyi6SFJpwHRItBQX13gvJ4D438Z0P3NhSlTqmFcuw/IOLcodwwg+zr+fBNFSAXT3Q57MQKKAl+BTL4sG8nPJTTQfEZa4/er238S0nbfC4dP/9/vuPVwOKqQsYvtEO6ydv0zpojXv3w+EKHTy+m02giHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w4Ehqa6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB7FC4CEF1;
	Fri, 21 Nov 2025 06:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763708046;
	bh=7J1qHLg9MNKehT8t5EyZLfHtGqN8q3NhKWYNKDJrwrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w4Ehqa6wIsO0LCVfeg4bAd7N3aOs4QjiPRsgVDDbaVbGfjFAtpXyDGMVcbLB3Zt1s
	 Ela1kW++F2dXuYHOXZVcNVeCy2Zc/9O9YPoYqfh6vxnhVBMD6ZQ8czLPesfH0oGCz+
	 xypyK0/heBt/mzA/JndeC6gWOFexErID6DRl2/TU=
Date: Fri, 21 Nov 2025 07:53:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] x86/mce: Handle AMD threshold interrupt storms
Message-ID: <2025112144-wizard-upcountry-292d@gregkh>
References: <20251120214139.1721338-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120214139.1721338-1-avadhut.naik@amd.com>

On Thu, Nov 20, 2025 at 09:41:24PM +0000, Avadhut Naik wrote:
> From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> Extend the logic of handling CMCI storms to AMD threshold interrupts.
> 
> Rely on the similar approach as of Intel's CMCI to mitigate storms per CPU and
> per bank. But, unlike CMCI, do not set thresholds and reduce interrupt rate on
> a storm. Rather, disable the interrupt on the corresponding CPU and bank.
> Re-enable back the interrupts if enough consecutive polls of the bank show no
> corrected errors (30, as programmed by Intel).
> 
> Turning off the threshold interrupts would be a better solution on AMD systems
> as other error severities will still be handled even if the threshold
> interrupts are disabled.
> 
> Also, AMD systems currently allow banks to be managed by both polling and
> interrupts. So don't modify the polling banks set after a storm ends.
> 
>   [Tony: Small tweak because mce_handle_storm() isn't a pointer now]
>   [Yazen: Rebase and simplify]
> 
> Stable backport notes:
> 1. Currently, when a Machine check interrupt storm is detected, the bank's
> corresponding bit in mce_poll_banks per-CPU variable is cleared by
> cmci_storm_end(). As a result, on AMD's SMCA systems, errors injected or
> encountered after the storm subsides are not logged since polling on that
> bank has been disabled. Polling banks set on AMD systems should not be
> modified when a storm subsides.
> 
> 2. This patch is a snippet from the CMCI storm handling patch (link below)
> that has been accepted into tip for v6.19. While backporting the patch
> would have been the preferred way, the same cannot be undertaken since
> its part of a larger set. As such, this fix will be temporary. When the
> original patch and its set is integrated into stable, this patch should be
> reverted.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Link: https://lore.kernel.org/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
> This is somewhat of a new scenario for me. Not really sure about the
> procedure. Hence, haven't modified the commit message and removed the
> tags. If required, will rework both.
> Also, while this issue can be encountered on AMD systems using v6.8 and
> later stable kernels, we would specifically prefer for this fix to be
> backported to v6.12 since its LTS.

What is the git commit id of this change in Linus's tree?

