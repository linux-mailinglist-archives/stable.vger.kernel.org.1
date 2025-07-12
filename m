Return-Path: <stable+bounces-161700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E11BB02ABC
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959C74A2422
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384FA1DB34C;
	Sat, 12 Jul 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oI2MYvB5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3F1E833C
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752321847; cv=none; b=TwUhAN44irpu0ukQd/VBgZr40I/Rs+hlHT6IPKwJcZCjjd9gB2ni9qx9O5tmCEvQGYGNV2M9m7dVO5+h4AEJ1nNn4vsbl0qBo5DHpnb662Q8rR3ppSowEUVbbvENnrjC83Z9VxWmqwYusmjxcXWHML/FXp+woLebObAk16KrJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752321847; c=relaxed/simple;
	bh=xIx8/s6G1IQlU1/hLTcLJp3aRPncXxrSjFHXy4VmPpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhFF5OArMBXrIqY1ut9G/bI2Nna9CwxVe/LmNiR5/cCsMQeqA0CHaUS1mKRNMKPWjJpd63e5r/iL7jojdZ640qE95uIPr7IqLowZ7GGbowNgmiP2itogdc6yw+63EiB9rLOptFebRDvDysVbgigLjAWkvM2XyBIqnSby/upWiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oI2MYvB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2446C4CEF1;
	Sat, 12 Jul 2025 12:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752321847;
	bh=xIx8/s6G1IQlU1/hLTcLJp3aRPncXxrSjFHXy4VmPpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oI2MYvB5KQ7d/NvnxrbU0H+wyigmAr7UIEaicuxjSd4Y2ZcJ5t0P8oM01or2UcxqD
	 i7fZHFAAQWZ2KAkR5EmQNkIxQmznuFm4kEWeDfK+qc9p57cldUhIxFC8HLBUqBT11Y
	 uqrluIhS+SC0oglFYJwnNPjCuLuLyXDFoESClBXc=
Date: Sat, 12 Jul 2025 14:04:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org, Thomas Voegtle <tv@lio96.de>,
	kim.phillips@amd.com
Subject: Re: [PATCH 5.15-stable] x86/CPU/AMD: Properly check the TSA microcode
Message-ID: <2025071253-perfectly-geography-c56f@gregkh>
References: <20250711122541.GAaHECxVpy31mIrqDb@fat_crate.local>
 <c7f1bb7d-ec91-ca9d-981a-a0bd5e484d05@lio96.de>
 <20250711153546.GBaHEvUmfVORJmONfh@fat_crate.local>
 <3e198176-90c4-4759-84c7-16d79d368ccd@lio96.de>
 <20250711164410.GDaHE_Wrs5lCnxegVz@fat_crate.local>
 <bd209368-4098-df9b-e80d-8dd3521a83ba@lio96.de>
 <20250711174157.GFaHFM5VNp1OynrF7E@fat_crate.local>
 <1a655339-cf7d-d711-f8a9-a5a689422be5@lio96.de>
 <20250711181517.GHaHFUtblXgUqlf-ym@fat_crate.local>
 <20250711194558.GLaHFp9kw1s5dSmBUa@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711194558.GLaHFp9kw1s5dSmBUa@fat_crate.local>

On Fri, Jul 11, 2025 at 09:45:58PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Fri, 11 Jul 2025 17:40:18 +0200
> 
> In order to simplify backports, I resorted to an older version of the
> microcode revision checking which didn't pull in the whole struct
> x86_cpu_id matching machinery.
> 
> My simpler method, however, forgot to add the extended CPU model to the
> patch revision, which lead to mismatches when determining whether TSA
> mitigation support is present.
> 
> So add that forgotten extended model.
> 
> Also, fix a backport mismerge which put tsa_init() where it doesn't
> belong.
> 
> This is a stable-only fix and the preference is to do it this way
> because it is a lot simpler. Also, the Fixes: tag below points to the
> respective stable patch.
> 
> Fixes: 90293047df18 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> Reported-by: Thomas Voegtle <tv@lio96.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Thomas Voegtle <tv@lio96.de>
> Message-ID: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
> ---
>  arch/x86/kernel/cpu/amd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

All now queued up, thanks.

greg k-h

