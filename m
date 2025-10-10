Return-Path: <stable+bounces-183865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF125BCC9C9
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BC2F34DF3B
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214EC286891;
	Fri, 10 Oct 2025 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UzCew8dc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7F2853EF;
	Fri, 10 Oct 2025 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093582; cv=none; b=kF6Gh8N/oJ471/j3dne4dcvbd/54Ik5goP8C+jS+8rBrHpz5/dufkMYr5kXKWBasgnKy4pK2S3fTsSTcvKzl532D7kCgsnYyfN/s/S5dibw6l+uZUQKgvL6Gmt3K1DahcDU5WJ8Rc1Q575b+8dt8IeCyrspRVMeyZ8PvFgqVQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093582; c=relaxed/simple;
	bh=JynbkBA2me+k5Pp29xM0/6UwcAwBzfW+O65Rzj0khJs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl8FNdAu4iETlWAqP++d5SKIcXASHGnUBokwNJFen5x3mGTRutgSP+rUpuNJDAm4aoZweYIshSiSwmkFudqFusajJfatckvUA5TtnU94YFPkn6CClhltk2mmnhnDWEWaMOQ8pGCNVswwFwa0QZ79LPf49UIeHVXdDuAFgp9PySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UzCew8dc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23FFC4CEF1;
	Fri, 10 Oct 2025 10:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760093580;
	bh=JynbkBA2me+k5Pp29xM0/6UwcAwBzfW+O65Rzj0khJs=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=UzCew8dcfB4QXzil0HTuFS7xS1+JEToQqjyNR8GYQUkjVYJfhTmKvbH1OZJHI8M2I
	 1uJdFnAO4P8PkXs0l7OlsJWaVqcnZNjWpvm/dafyLei1MyUv9QJF2+zQ56XdeGngY4
	 f8Un20m9oHVPWkmzl2B6FKg0uMTelKJKVCU2eWEw=
Date: Fri, 10 Oct 2025 12:52:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shivani Agarwal <shivani.agarwal@broadcom.com>, stable@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com, sfrench@samba.org, pc@manguebit.org,
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com,
	bharathsm@microsoft.com, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Steve French <stfrench@microsoft.com>,
	Cliff Liu <donghua.liu@windriver.com>,
	He Zhe <Zhe.He@windriver.com>
Subject: Re: [PATCH v6.1] smb: prevent use-after-free due to open_cached_dir
 error paths
Message-ID: <2025101045-unheated-relock-fc67@gregkh>
References: <20251009060846.351250-1-shivani.agarwal@broadcom.com>
 <aOh20TkmJDG5Bomt@vaarsuvius.home.arpa>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOh20TkmJDG5Bomt@vaarsuvius.home.arpa>

On Thu, Oct 09, 2025 at 08:00:33PM -0700, Paul Aurich wrote:
> Thanks for proposing this!  I think this backport has the problem I was
> concerned with when Cliff Liu proposed a backport in March [1].
> 
> The handling of the 'has_lease' field in this patch depends on work done by
> two other patches, and those should be backported before this one:
> 
> - 5c86919455c1 ("smb: client: fix use-after-free in
> smb2_query_info_compound()")
> - 7afb86733685 ("smb: Don't leak cfid when reconnect races with
> open_cached_dir")
> 
> I have (somewhere...) a backport of all three of these patches three patches
> to linux-6.1.y, but it was a while ago and I never found the time to _test_
> the backports.

Now dropped from the queue, thanks for the review.

greg k-h

