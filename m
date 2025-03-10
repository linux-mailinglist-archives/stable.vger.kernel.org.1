Return-Path: <stable+bounces-121695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014E7A5914C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AF03A8253
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0072226CE4;
	Mon, 10 Mar 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NjkjZs+h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241618C011
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602957; cv=none; b=OtPtQOu1ZCmeBlYBsrDV+cvv8sDZqU6R62CYn1sQp6cRrnMQYPeDv7PzqOTsUp2HZ3u6PM4gdU9WC2GKqVrXJPNhA4S6g7cYnH71xYw5zYFp4P6gFKV1Ep2BR88aL3B/NFZ41hyNTdD+noyyJiSndSebvMnrIp1VWddVKvs3HYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602957; c=relaxed/simple;
	bh=V3Bjc/eMw7lQT/m5/+3Ad2GuCVNmk+JoktiyW8D4jDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGzzXUQr8+wjV0zwjE3d7osL1XU7Zx+Gn77GE/EIfJiBBdQXRbBV3M7FtN4hRPuIma08aRYKT1FtSvXKFic0WlnlDLsVaW8S7CA0gkfTFPsTQuXs+FeMAZDI4fTn652xIb7k6C6V36F/b0ccuziII9dhCJycAjwnA3rNamlkVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NjkjZs+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191F9C4CEEC;
	Mon, 10 Mar 2025 10:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741602957;
	bh=V3Bjc/eMw7lQT/m5/+3Ad2GuCVNmk+JoktiyW8D4jDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjkjZs+hYUYeRwObWD/i4n2nApXY8G/t4U03QDFtIXXFtlRigyUJ9ravqkjFLRVvb
	 sanZZuuAMLvm0Gp8C5BYLCx2k6Zj0vSOz9RgqMkB7QS+GHuLMuMnvMzAtfPGoRAnA2
	 uYAWMfNDLiueJF6HJrSv+3JYNaS1yiJayu1i2clY=
Date: Mon, 10 Mar 2025 11:35:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: stable@vger.kernel.org, Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH 6.13.y] virt: sev-guest: Move SNP Guest Request data
 pages handling under snp_cmd_mutex
Message-ID: <2025031026-entrap-repeal-cec0@gregkh>
References: <2025030957-magnetism-lustily-55d9@gregkh>
 <20250310100027.1228858-1-aik@amd.com>
 <da8e554d-12b2-4e22-a76d-7ddd8cc8a8a6@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da8e554d-12b2-4e22-a76d-7ddd8cc8a8a6@amd.com>

On Mon, Mar 10, 2025 at 09:13:11PM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 10/3/25 21:00, Alexey Kardashevskiy wrote:
> > Compared to the SNP Guest Request, the "Extended" version adds data pages
> > for receiving certificates. If not enough pages provided, the HV can
> > report to the VM how much is needed so the VM can reallocate and repeat.
> > 
> > Commit ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command
> > mutex") moved handling of the allocated/desired pages number out of scope
> > of said mutex and create a possibility for a race (multiple instances
> > trying to trigger Extended request in a VM) as there is just one instance
> > of snp_msg_desc per /dev/sev-guest and no locking other than snp_cmd_mutex.
> > 
> > Fix the issue by moving the data blob/size and the GHCB input struct
> > (snp_req_data) into snp_guest_req which is allocated on stack now
> > and accessed by the GHCB caller under that mutex.
> > 
> > Stop allocating SEV_FW_BLOB_MAX_SIZE in snp_msg_alloc() as only one of
> > four callers needs it. Free the received blob in get_ext_report() right
> > after it is copied to the userspace. Possible future users of
> > snp_send_guest_request() are likely to have different ideas about
> > the buffer size anyways.
> > 
> > Fixes: ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
> > Cc: stable@vger.kernel.org # 6.13
> > Cc: Nikunj A Dadhania <nikunj@amd.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> 
> Missed:
> 
> (cherry picked from commit 3e385c0d6ce88ac9916dcf84267bd5855d830748)
> 
> I first cherrypicked and sent, then I read about "cherry-oick -x", sorry for
> the noise. thanks,

Please resend with this in the commit so that our tools pick it up
properly.

thanks,

greg k-h

