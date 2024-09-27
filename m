Return-Path: <stable+bounces-77886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3120988022
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 10:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C034B24B5A
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC35A17B515;
	Fri, 27 Sep 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cw5rMQJp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB413B58B
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425024; cv=none; b=F84Bs/MiFDo9jahywH9d+v311ZoTuIvd0jJSezSCO4fwdTU1upDKUAjX5G+uvNrUOSMwoWYK5mDeZj8ShksD4chM/1KowQLR6pcDjy5+8AKz47MchszFtrfmvFzv+mwYrEK+pWtQcjjuSVt9VWAam7I6K6H5zZd8nWHOtlLF8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425024; c=relaxed/simple;
	bh=+p74/LOMa0uus+dUd5Jd2wYD+EniClIgOGSqNLVUeGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyE8o8kBQ2Egd2zqkhtBmT8r373jtJNYNtEZ7E5SBNAj1EmNP6UOFMbe9zHmAgsOmi68+RnB8hYY0lP31+FZX/AI54kgiltdryXkmHt4AE8u8Gqas0rcscAPLS1MRWgmjPGzDq9Qav+dtTEwfDuY3/2axZnJASADXqjQwdrwr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cw5rMQJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C514C4CEC4;
	Fri, 27 Sep 2024 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727425023;
	bh=+p74/LOMa0uus+dUd5Jd2wYD+EniClIgOGSqNLVUeGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cw5rMQJpKnzzhTgel4f/HRrpvkJWTIP56yV9KCVRHoPJ7v3zR5WLwCg4bGp4IQdKy
	 Oi4+SbsTNAs5bCfLRIdVFDeUMdP0rzCalqVQxTEDdMvUvgDRTAqsmuSE3xhy+RK9QP
	 TNKpRt4v3Y5JKLMOK+ekTy/HQJiBlZ2AGJed3+F4=
Date: Fri, 27 Sep 2024 10:17:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.1.y] btrfs: calculate the right space for delayed refs
 when updating global reserve
Message-ID: <2024092752-ferocious-preseason-9970@gregkh>
References: <20240924203916.713326-1-djahchankoike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924203916.713326-1-djahchankoike@gmail.com>

On Tue, Sep 24, 2024 at 05:38:52PM -0300, Diogo Jahchan Koike wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit f8f210dc84709804c9f952297f2bfafa6ea6b4bd upstream.
> 
> When updating the global block reserve, we account for the 6 items needed
> by an unlink operation and the 6 delayed references for each one of those
> items. However the calculation for the delayed references is not correct
> in case we have the free space tree enabled, as in that case we need to
> touch the free space tree as well and therefore need twice the number of
> bytes. So use the btrfs_calc_delayed_ref_bytes() helper to calculate the
> number of bytes need for the delayed references at
> btrfs_update_global_block_rsv().
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> [Diogo: this patch has been cherry-picked from the original commit;
> conflicts included lack of a define (picked from commit 5630e2bcfe223)
> and lack of btrfs_calc_delayed_ref_bytes (picked from commit 0e55a54502b97)
> - changed const struct -> struct for compatibility.]
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
> 
> ---
> Fixes WARNING in btrfs_chunk_alloc (2) [0]
> [0]: https://syzkaller.appspot.com/bug?extid=57de2b05959bc1e659af

Now queued up, thanks.

greg k-h

