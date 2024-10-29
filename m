Return-Path: <stable+bounces-89141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEDB9B3EDE
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 01:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489AB283910
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 00:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64D28F4;
	Tue, 29 Oct 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uC5CjPaH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4A2119
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160601; cv=none; b=AaVzIgz433S64gpDBmI8iJ7dGYsL0w7SN8rY6VSuiy0UKmJFn0iVPzyTM3LWE8QTE1QmLKrP+AW9czHGKftfsV/1Xks/7TOZJBBDyRXT2e8XGW/F3FQ4KYUiP4WjpcZqYBNpfLkvqnX7Ebl8C617aD7zQ9WIj22agorbiQG/ayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160601; c=relaxed/simple;
	bh=uOtS9YRTg5Bz6lgWGo5/X9y10X3xUNfq6F3RbNVisN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=too2Mj+Hlb7Z8dUm6wLTAVelXthtODN05watUk8wSrieNSsHjC/ronzuMAHq+S11g3399R76J60GkP4pOdBXhiA6B8m6PzpC4BP/9IsvMXU5yM38Z0w0K58+qodsfDE2dLjtAzWE7wlLdDwr9o0DpFbVF5tcnqALMmX8PRk4EkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uC5CjPaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70E1C4CEC3;
	Tue, 29 Oct 2024 00:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730160601;
	bh=uOtS9YRTg5Bz6lgWGo5/X9y10X3xUNfq6F3RbNVisN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uC5CjPaHKLcFPfuBYTRmRXmlvv5NAr+eT1wyuvw9ZzCUOWuj+yDiu7ChUP2zibumT
	 TCXAFKuP9B2OenZENbJvz98LWpKWd0RLiZWzh/VNeOAxY9jWTuhK4CVD2ZcMWu0UE3
	 Xp2M6GxA9aol4LM8/lluw9b01qsW1CBFausilfEk=
Date: Tue, 29 Oct 2024 01:09:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Xinyu Zhang <xizhang@purestorage.com>,
	Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Subject: Re: Remove "block: fix sanity checks in blk_rq_map_user_bvec" from
 all stable queues
Message-ID: <2024102930-chowder-chooser-bdd5@gregkh>
References: <Zx/XVRgyeCeaKrj+@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx/XVRgyeCeaKrj+@dev-ushankar.dev.purestorage.com>

On Mon, Oct 28, 2024 at 12:26:29PM -0600, Uday Shankar wrote:
> Please remove the following patch from all stable queues:
> 
> 2ff949441802 ("block: fix sanity checks in blk_rq_map_user_bvec")
> 
> The above patch should not go into any stable tree unless accompanied by
> its (currently inflight) fix:
> 
> https://lore.kernel.org/linux-block/20241028090840.446180-1-hch@lst.de/

Ok, now dropped from all queues.  When this fix lands, please let us
know so that we can pick up both changes.

thanks,

greg k-h

