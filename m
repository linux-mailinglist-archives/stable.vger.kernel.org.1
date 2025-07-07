Return-Path: <stable+bounces-160342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4562BAFAD80
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 09:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959817A6E21
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 07:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1598228A3EC;
	Mon,  7 Jul 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TPY7yf/n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04628A3EF
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874302; cv=none; b=pz2dh7YssGl7unXiZ6eNEJbjdOA5tjUPlM/sx00wilmMdQ9o8SFQuiMS3wPxPZClQ1ZoDdwWSdkMzDu47wmo34rvpXj4X/Jcn+TUIJxSK1G+l6cIp77n6+cTntJewCbhc8sPRnoCK1oig/ckRnljEvEEJ7YVF9e++/+n1ty/OwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874302; c=relaxed/simple;
	bh=U9+c9fK6nQQQzn0TKZzSvNEs5TgJOId0FpxZXrz6fuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcf0CMFTZStsq6ARSqhZK9GugYTz28MGJZ2UTKoSjy1k9L8rfMzJ/m0787n1pO0723s9CzqlwjicIiii4Ft9wbdHT9KZU+vgwQ3EnWwPbw4n6zhwFWn0rTVh/wWb0Hs8RCmdTuFi+O4XyybiMPwEjMwtpBRbNt2U2y0szt2Jwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TPY7yf/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB80C4CEF6;
	Mon,  7 Jul 2025 07:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751874302;
	bh=U9+c9fK6nQQQzn0TKZzSvNEs5TgJOId0FpxZXrz6fuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPY7yf/nboCLKye7y85zYnbuAD1oxKvE1PcsCCkOAbEw2WQLQBx7URgyMM7e/MbPo
	 IrrIW3Fd0S1sV6019n0FDe0ENz4CXZOGZXoeSMZ+GD4fBbtECmwR5p2b7jiWLBlbL/
	 pKhOkF2y1rM+r0EJ2ESO+H2tr8OD2zwCUbhA+D+k=
Date: Mon, 7 Jul 2025 09:44:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: stable@vger.kernel.org,
	=?utf-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>,
	Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 6.1.y] EDAC/amd64: Fix size calculation for
 Non-Power-of-Two DIMMs
Message-ID: <2025070750-lapel-bunkmate-672f@gregkh>
References: <2025063022-frail-ceremony-f06e@gregkh>
 <20250701171032.2470518-1-avadhut.naik@amd.com>
 <2025070258-panic-unaligned-0dee@gregkh>
 <8b274e68-29e4-436a-9bb1-457653edaa2e@amd.com>
 <2025070319-oyster-unpinned-ec29@gregkh>
 <3d2a2121-4a5d-445f-8db0-8f1850a72769@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d2a2121-4a5d-445f-8db0-8f1850a72769@amd.com>

On Mon, Jul 07, 2025 at 02:00:24AM -0500, Naik, Avadhut wrote:
> 
> 
> On 7/3/2025 00:28, Greg KH wrote:
> > On Wed, Jul 02, 2025 at 12:19:41PM -0500, Naik, Avadhut wrote:
> >> Hi,
> >>
> >> On 7/2/2025 09:31, Greg KH wrote:
> >>> On Tue, Jul 01, 2025 at 05:10:32PM +0000, Avadhut Naik wrote:
> >>>> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD Zen-based
> >>>> SOCs has an Address Mask and a Secondary Address Mask register associated with
> >>>> it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS granularity
> >>>> during init using these two registers.
> >>>>
> >>>> Currently, the module primarily considers only the Address Mask register for
> >>>> computing DIMM sizes. The Secondary Address Mask register is only considered
> >>>> for odd CS. Additionally, if it has been considered, the Address Mask register
> >>>> is ignored altogether for that CS. For power-of-two DIMMs i.e. DIMMs whose
> >>>> total capacity is a power of two (32GB, 64GB, etc), this is not an issue
> >>>> since only the Address Mask register is used.
> >>>>
> >>>> For non-power-of-two DIMMs i.e., DIMMs whose total capacity is not a power of
> >>>> two (48GB, 96GB, etc), however, the Secondary Address Mask register is used
> >>>> in conjunction with the Address Mask register. However, since the module only
> >>>> considers either of the two registers for a CS, the size computed by the
> >>>> module is incorrect. The Secondary Address Mask register is not considered for
> >>>> even CS, and the Address Mask register is not considered for odd CS.
> >>>>
> >>>> Introduce a new helper function so that both Address Mask and Secondary
> >>>> Address Mask registers are considered, when valid, for computing DIMM sizes.
> >>>> Furthermore, also rename some variables for greater clarity.
> >>>>
> >>>> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
> >>>> Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
> >>>> Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
> >>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> >>>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> >>>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> >>>> Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
> >>>> Cc: stable@vger.kernel.org
> >>>> Link: https://lore.kernel.org/20250529205013.403450-1-avadhut.naik@amd.com
> >>>> (cherry picked from commit a3f3040657417aeadb9622c629d4a0c2693a0f93)
> >>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> >>>
> >>> This was not a clean cherry-pick at all.  Please document what you did
> >>> differently from the original commit please.
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> Yes, the cherry-pick was not clean, but the core logic of changes between
> >> the original commit and the cherry-picked commit remains the same.
> >>
> >> The amd64_edac module has been reworked quite a lot in the last year or
> >> two. Support has also been introduced for new SOC families and models.
> >> This rework and support, predominantly undertaken through the below
> >> commits, is missing in 6.1 kernel.
> >>
> >> 9c42edd571aa EDAC/amd64: Add support for AMD heterogeneous Family 19h Model 30h-3Fh
> >> ed623d55eef4 EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
> >> a2e59ab8e933 EDAC/amd64: Drop dbam_to_cs() for Family 17h and later
> > 
> > Why not take these as prerequisite changes?  Taking changes that are
> > radically different from what is upstream is almost always wrong, it
> > makes future backports impossible, and usually is buggy.
> > 
> Just to ensure that I have understood correctly, are you suggesting
> that we backport the above three commits to 6.1 too?

Yes, why not?

