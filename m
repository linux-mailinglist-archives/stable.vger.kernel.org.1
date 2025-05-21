Return-Path: <stable+bounces-145752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D572CABEAE1
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 06:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0883B846F
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 04:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9DD19ABC2;
	Wed, 21 May 2025 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ry7e6ucI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70991A59;
	Wed, 21 May 2025 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800945; cv=none; b=SdMNR9g+Xt1isUvocvWYtIP9micPYHSinAzzGB3j2icyPbk/D4fDy+3v3/ydd74vXK7SFMDaCeML2H+GdrNBTDdFszjpErILP696BzADD9/GRb2YkUIIO2J3y2bztndTqUO2aj09coL+97bipDg9+KYFu10C29vDD7+iYDrGHII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800945; c=relaxed/simple;
	bh=Ee3NArvNyD2JEb+TlWvCfXTvmmbT04YOAorQVbHYqV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAN30pFQLCyCusRG77gReXxcl39bU0O67b5SaP95r2SMwUqfVe1SVh7xNE+E4gWTklNAEgMFx5xO+i601tS6HMvKjwZpBUp+8DRT3E0sM7UJUccnPlfVT8oQ0GdV5F8OXULsUGFz2dzWg+ZgPN+w7aEATOPxPm1qCxAY8tHBx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ry7e6ucI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49618C4CEE4;
	Wed, 21 May 2025 04:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747800944;
	bh=Ee3NArvNyD2JEb+TlWvCfXTvmmbT04YOAorQVbHYqV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ry7e6ucIx1D0f+cf+nWcpVVCGffHGml203u03aQ8QF6KCqrhz0Uxri6+ZKcw0qpN6
	 3SM4OFafoTrrnVlvRbcZJ+kLmgNW6FQCKfFhDUQE8+FfNDkRs1rO0Qf59J3CihlBmu
	 eIp+Nu81o9sD8A4zxDwfKw7ZMsb9hoG0TY7MIVUQ=
Date: Wed, 21 May 2025 06:15:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 5.10 0/5] kernfs: backport locking and concurrency
 improvement
Message-ID: <2025052103-headband-friend-90f6@gregkh>
References: <20250521015336.3450911-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521015336.3450911-1-dqfext@gmail.com>

On Wed, May 21, 2025 at 09:53:30AM +0800, Qingfang Deng wrote:
> KCSAN reports concurrent accesses to inode->i_mode:

<snip>

Yes, but can you actually trigger this issue with a real workload?  How
were these tested in the 5.10 tree, and if this is a problem, can you
just move to a newer release instead?

thanks,

greg k-h

