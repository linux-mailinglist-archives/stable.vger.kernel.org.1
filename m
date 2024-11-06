Return-Path: <stable+bounces-90080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B91819BDFF4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 09:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAF728562E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2321A00FE;
	Wed,  6 Nov 2024 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I/EjQw3d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4841714B3
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880086; cv=none; b=EaP1IkQCJ+cvvjkd0lNdWQcz0P2mE0gP2A1D6FdfizV18yi+/fWiLfgnG7LPKJ0roIwNfPPD9HKrd6ALAnC30+lt4AkmOU9tqv/DnAncJ1iZTu+wl+kboI+Xqqg0E6NNNh5m4JA6qcOQ3blX1vua6QB9Lwyv6qGE5cPs43MtJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880086; c=relaxed/simple;
	bh=98IRxvH+61aAXBP1RI9/iTZ2fmCxP9IxZZF+V0qfC7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXTwNFb2ffCU5mLa2z6cyE7ztdpEu6KgjuiNohYiHuIQSu04igdqTkhc5eTgX/VFIFstapA+wET0MwDZi1D5JqMQh1xNXvU8p2z52RmCjj9EXwHWelzgsgqN6fXIjT1Oqx2EyEKYSxxnSh2N32Nbo1RVyq6uD5F+oZ61zFszjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I/EjQw3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CB0C4CECD;
	Wed,  6 Nov 2024 08:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730880085;
	bh=98IRxvH+61aAXBP1RI9/iTZ2fmCxP9IxZZF+V0qfC7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/EjQw3dYapT023qNgFjYm3na+288p1AO6ndkdTuR6rbNXBwT/va5e8gBJ+D0Xz1b
	 3WE/Su2IXVMdy5KGPbNYBY0PfKL/rv2484HH4bycIEZlni9d/RVAPX8S3+C2xr9FHA
	 WBy3UDrfHeI9OofqqEi76F5OMB6seHKYqi4q0tek=
Date: Wed, 6 Nov 2024 09:01:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.6 v2] SUNRPC: Remove BUG_ON call sites
Message-ID: <2024110659-falcon-poser-545d@gregkh>
References: <20241106075457.201502-3-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106075457.201502-3-asmadeus@codewreck.org>

On Wed, Nov 06, 2024 at 04:54:59PM +0900, Dominique Martinet wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> [ Upstream commit 789ce196a31dd13276076762204bee87df893e53 ]
> 
> There is no need to take down the whole system for these assertions.
> 
> I'd rather not attempt a heroic save here, as some bug has occurred
> that has left the transport data structures in an unknown state.
> Just warn and then leak the left-over resources.
> 
> Acked-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: NeilBrown <neilb@suse.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> v2: resend with signoff properly set as requested
> v1: https://lkml.kernel.org/r/20241102065203.13291-1-asmadeus@codewreck.org

Thanks, now queued up.

greg k-h

