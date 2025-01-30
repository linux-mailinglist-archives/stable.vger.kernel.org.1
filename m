Return-Path: <stable+bounces-111281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4787EA22D1F
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 13:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D99B1889594
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AABC1C5F37;
	Thu, 30 Jan 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eEDYr6sd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D8B660
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738241910; cv=none; b=GbRMYmqxY5waniwBhOMXvnVTX7WfS3MHGZJdfn/V9S2thRUMNbU8Imgbf0vJcBOuRL0r6qWtCq6GQzIwCTpEOdMhxGwD1dS5cKtFvFmkkMgjTj0xHcUDUt8E5zfjmrBmvIqkxOBH6n6Iz4t8Fi4HWznWe45A536LJSRYb5Nr8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738241910; c=relaxed/simple;
	bh=1gU1WrhXgCqGWiTgROc1qu5vJGYP4uLpr0W1MAQ4FIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfXDworrvjBkMHywzRPw6dYyRpgmmJCuymGOefaqhiihJbEnfGqh8vxFkPXVK8X2XwD3I138ZDQOfueUVisje5A7KfjgtClpAY/u0I5i7KSbiAxmk31AbBacl2rZRzGvybVQ7/7WdOeeVRtq3Q/88/JixaTStSWMQ4ZDzJxWKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eEDYr6sd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2DCC4CED2;
	Thu, 30 Jan 2025 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738241910;
	bh=1gU1WrhXgCqGWiTgROc1qu5vJGYP4uLpr0W1MAQ4FIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEDYr6sdc2IVuuM7B9L3iEP3e4ouLpM5UIYcJoVPnWU1mtyjB3CPLirYalXnWlOGg
	 Fkm6FlhJlT2M1r0n8dX2QLAWsUCeetpaF3j3c2p6945mjhTDiflLbNZ95SNh5e+Pgi
	 R4nr+PW4aQkFC68nz+9U7bgW+hQNT0Yv9OSthCoM=
Date: Thu, 30 Jan 2025 13:58:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rajani kantha <rajanikantha@engineer.com>
Cc: lizhi.xu@windriver.com, tytso@mit.edu, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] ext4: filesystems without casefold feature cannot
 be mounted with siphash
Message-ID: <2025013034-whooping-defraud-f4bd@gregkh>
References: <trinity-9fdb9995-866f-4221-8e4b-f08e3d33894b-1737681797536@3c-app-mailcom-lxa10>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-9fdb9995-866f-4221-8e4b-f08e3d33894b-1737681797536@3c-app-mailcom-lxa10>

On Fri, Jan 24, 2025 at 02:23:17AM +0100, Rajani kantha wrote:
> From: Lizhi Xu <lizhi.xu@windriver.com>
> 
> [ upstream commit 985b67cd86392310d9e9326de941c22fc9340eec ]
> 
> When mounting the ext4 filesystem, if the default hash version is set to
> DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.
> 
> Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Rajani Kantha <rajanikantha@engineer.com>
> ---
>  fs/ext4/super.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Why are you submitting this for these 2 kernels?  Why are they required
for them?  You didn't provide any information here at all :(

And what about the fix for this commit?  You forgot that.  Please send a
proper series of backports and make sure you actually tested them.

thanks,

gre gk-h

