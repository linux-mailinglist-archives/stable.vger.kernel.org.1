Return-Path: <stable+bounces-195473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6EEC77A5C
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 08:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AFB14E8136
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 07:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6E633509F;
	Fri, 21 Nov 2025 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kRzMlJeK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44832FA13;
	Fri, 21 Nov 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708973; cv=none; b=us0hRUYLQZycE3lrS0nCqMXdSYsxSuy15j1BXuHw6NW4hwNHy9t3EmmQF34+W4alQNnzz7zD1yu1c9CubVYohtjyB7a90yBIYWPl7TzIN8WD7/USTrnkz/PsmtD2MAcuNtKQ99COWiKpCeIJFAwh9C1w9g8CwNBhHmcTR1VLFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708973; c=relaxed/simple;
	bh=apoVyEVa+YBriawXJR5pq8IxnsehtFuMP8a2pO25D2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEmMuPAo55l6Ov2ExhEWmVAn/BifQeDreVUIfhoQkWZqTZKkZ8Z0q7T46e2vU2Qezz7dlXSE2DrIfs2O1nM88AIaUjqZ0pRc9mc1G6PQIW5grI8mDKHIrtCWgwbQPdlrQwo60xK+vg1k1IlzEpyy6QEAgjz/49VP3qFC3R1Jlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kRzMlJeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA48C4CEF1;
	Fri, 21 Nov 2025 07:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763708972;
	bh=apoVyEVa+YBriawXJR5pq8IxnsehtFuMP8a2pO25D2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRzMlJeKlbdRUIcmGtpaqGlTf2LiS3vIT1Iqi74zMaase5wPtIRSRDQLcQPmb3jRP
	 hMhqMWC+mtu+FpQDXPbs3NZglqUxKPNvxjZ+xEcIiq3e5wub/tsjvFxYI1f3wPoneg
	 Dbc23pG2mDE4YAP/RmEz5MMMk7Z8UmpLSp8jR9rs=
Date: Fri, 21 Nov 2025 08:09:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH] x86/mce: Handle AMD threshold interrupt storms
Message-ID: <2025112152-tripod-footbath-80ff@gregkh>
References: <20251120214139.1721338-1-avadhut.naik@amd.com>
 <2025112144-wizard-upcountry-292d@gregkh>
 <15355297-4ff3-4626-b5d5-ac50aea87589@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15355297-4ff3-4626-b5d5-ac50aea87589@amd.com>

On Fri, Nov 21, 2025 at 01:04:47AM -0600, Naik, Avadhut wrote:
> 
> 
> On 11/21/2025 00:53, Greg KH wrote:
> > On Thu, Nov 20, 2025 at 09:41:24PM +0000, Avadhut Naik wrote:
> >> From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> >>
> >> Extend the logic of handling CMCI storms to AMD threshold interrupts.
> >>
> >> Rely on the similar approach as of Intel's CMCI to mitigate storms per CPU and
> >> per bank. But, unlike CMCI, do not set thresholds and reduce interrupt rate on
> >> a storm. Rather, disable the interrupt on the corresponding CPU and bank.
> >> Re-enable back the interrupts if enough consecutive polls of the bank show no
> >> corrected errors (30, as programmed by Intel).
> >>
> >> Turning off the threshold interrupts would be a better solution on AMD systems
> >> as other error severities will still be handled even if the threshold
> >> interrupts are disabled.
> >>
> >> Also, AMD systems currently allow banks to be managed by both polling and
> >> interrupts. So don't modify the polling banks set after a storm ends.
> >>
> >>   [Tony: Small tweak because mce_handle_storm() isn't a pointer now]
> >>   [Yazen: Rebase and simplify]
> >>
> >> Stable backport notes:
> >> 1. Currently, when a Machine check interrupt storm is detected, the bank's
> >> corresponding bit in mce_poll_banks per-CPU variable is cleared by
> >> cmci_storm_end(). As a result, on AMD's SMCA systems, errors injected or
> >> encountered after the storm subsides are not logged since polling on that
> >> bank has been disabled. Polling banks set on AMD systems should not be
> >> modified when a storm subsides.
> >>
> >> 2. This patch is a snippet from the CMCI storm handling patch (link below)
> >> that has been accepted into tip for v6.19. While backporting the patch
> >> would have been the preferred way, the same cannot be undertaken since
> >> its part of a larger set. As such, this fix will be temporary. When the
> >> original patch and its set is integrated into stable, this patch should be
> >> reverted.
> >>
> >> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> >> Signed-off-by: Tony Luck <tony.luck@intel.com>
> >> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> >> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> >> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >> Link: https://lore.kernel.org/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com
> >> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> >> ---
> >> This is somewhat of a new scenario for me. Not really sure about the
> >> procedure. Hence, haven't modified the commit message and removed the
> >> tags. If required, will rework both.
> >> Also, while this issue can be encountered on AMD systems using v6.8 and
> >> later stable kernels, we would specifically prefer for this fix to be
> >> backported to v6.12 since its LTS.
> > 
> > What is the git commit id of this change in Linus's tree?
> 
> I think it has not yet been merged into mainline's master branch.
> This commit was recently accepted into the tip (5th November).

Then there's nothing we can do about this in the stable tree, please
read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for all about this.

thanks,

greg k-h

