Return-Path: <stable+bounces-46170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3258CEFB2
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 17:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF2B1F212EB
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F34E634E2;
	Sat, 25 May 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mA6ehZl6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE816A355
	for <stable@vger.kernel.org>; Sat, 25 May 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649790; cv=none; b=UrXmheMQHIiJ8UBLRkqNJSvptNmLlxR5Vf0d7Hvm0Rp8+x5u30Vpo6lHPELhNr+tLf6lFK+6o62T8QAVaE6KY1k+EPceYLItCFzqSR/6yg71RJp4Aj1lTTWey0/6SD2C3tMdkrQ0qQJuvC5ieGw38UJ9h4zyuqt0Qgljk22IWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649790; c=relaxed/simple;
	bh=rERhRqaJNinCHwpG13IHGqpwlk/6ViPji/yJ9rUiVRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ardw7R6+ms/ZweBT0WKwIycaNberyh6EYma5Wi+fKHRrfsBCqBEE/0yhO1BMlHfnQuyorLRWDX63GEXaUcky7o2JMDAhFX4u2Dm9sbJS1SOCHa09osTBAlVd1bhjJLYKkVw47kdBtKkbUoWAvylQcmWqSU6JcM/bCNpMf30dxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mA6ehZl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53517C2BD11;
	Sat, 25 May 2024 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716649789;
	bh=rERhRqaJNinCHwpG13IHGqpwlk/6ViPji/yJ9rUiVRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mA6ehZl6ja7Mf/llAauwdCa3tnKvSEqadOnHVYpyRdD/jBVmEx96L8JeQwmSxiiud
	 T7Q0kgwqJPSqINi6uD9aBsP3fApcYmF65mnPE64Nowf6X7SKnLw3LD+pJBtVhH0L5v
	 IfcbfPWpW3ZK6XMlqKcGcLjjVHAyzd4n2ma4xtLc=
Date: Sat, 25 May 2024 17:09:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	stable@kernel.org, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix false alarm on invalid block address
Message-ID: <2024052541-buffoon-scarce-2325@gregkh>
References: <20240520220208.1596727-1-jaegeuk@kernel.org>
 <Zk-AilUqViUaLj8b@google.com>
 <Zk-BBpChhBi1J4PC@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk-BBpChhBi1J4PC@google.com>

On Thu, May 23, 2024 at 05:46:46PM +0000, Jaegeuk Kim wrote:
> Fixed the stable mailing list.
> 
> On 05/23, Jaegeuk Kim wrote:
> > Hi Greg,
> > 
> > Could you please consider to cherry-pick this patch in stable-6.9, since
> > there are many users suffering from unnecessary fsck runs during boot?
> > 
> > You can get this from Linus's tree by
> > (b864ddb57eb0 "f2fs: fix false alarm on invalid block address")

Now queued up, thanks.

greg k-h

