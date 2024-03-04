Return-Path: <stable+bounces-25922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050618702BC
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A85B1F25349
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97CE3E49D;
	Mon,  4 Mar 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KJ8BBBGS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ECF3E48C
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559003; cv=none; b=HA3L6BHDfEWVYYFiMTiintveZoAssncjYV3U90rn4KR2MqrFlr5MxqmMGHfz5ZgRIym+Or1+F9truCMCOhmyQo3QBEWFueB/vNuSgbne7v0fBSPvxZMuCVqLZIOPUFLOUDye1C+l5lIoGPZ5tHB3C1TvjJsIQhBMfNHgTi0Y62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559003; c=relaxed/simple;
	bh=BNBDu31S6tQ3dcTUqDfuvqSlLwoZdIJUMyciiwuvUuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3xQvReerfz3RSuU4Yxj5B7/NX8ubFie2OJBhvPAyN88bj7vPJ2DpWz5tR72/l6GtrzRN1H32c0dubVgJDSf756It96FdsdHOrs46bnWkPqRgv21VPG1eLkfeGq6nkT0eq8RHMF0PTI1J5zg3bv55FOxFclGFQaEQMt445Slcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KJ8BBBGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74B5C433C7;
	Mon,  4 Mar 2024 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709559003;
	bh=BNBDu31S6tQ3dcTUqDfuvqSlLwoZdIJUMyciiwuvUuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJ8BBBGSpigrm1SFJkNe2bhPgHHgGft/PiqwuKCSCtE+Y3+1K0KN+CUbmy1XOWibg
	 fGexHxYpnCGmrkO9NDxWk+BwtjxCSygo5YNx9UYEA9xBx0xNB0QLKlb2R1QVGBE5+D
	 KnOhZKs3nhBUDZgwgBBkxBjfbA1HM5Yqh0e7n4x8=
Date: Mon, 4 Mar 2024 14:29:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 6.7.y v2 0/5] Delay VERW - 6.7.y backport
Message-ID: <2024030429-starry-slider-b3e0@gregkh>
References: <20240303-delay-verw-backport-6-7-y-v2-0-439b1829d099@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303-delay-verw-backport-6-7-y-v2-0-439b1829d099@linux.intel.com>

On Sun, Mar 03, 2024 at 08:24:01PM -0800, Pawan Gupta wrote:
> v2:
> - Dropped already backported patch "x86/bugs: Add asm helpers for
>   executing VERW".
>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.7.8&id=09b0b1a090b74c9b453f9281e72289834c1a3dbb
> - Boot tested with KASLR and KPTI enabled.
> - Rebased to v6.7.8

Thanks for these, the 6.7.y, 6.6.y, and 6.1.y series now queued up.

greg k-h

