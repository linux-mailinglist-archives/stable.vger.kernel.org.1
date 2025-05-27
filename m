Return-Path: <stable+bounces-146451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D69AC5166
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB751708F0
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A12279912;
	Tue, 27 May 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HL2dsqHW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0512798EB;
	Tue, 27 May 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357806; cv=none; b=XGFX7untK/lr0CoN1E2D9voTSvj4sAnjNBs6qntThfMYgWV0vqXSpULZtqCzgSggI4OtDeczNDwNwdEGoaO2jLl34FRbsOlA6t8Ikiajz5Rei4H97OEcTJtZbZghJhAK4bHAr/7fAFOlgr3J+vW5ZaBGRUvnNfMjEnFcIhFGRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357806; c=relaxed/simple;
	bh=lWEv5yXJOgpl/qinEW2WH2JUTASr1G0HnYXwJyeJYno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzzkE8dLtyIurLgfUkmnUHvfNqpVuWTaG9AGQW06pjB5Ori+af2cx0TYPB+Y9HSqamC6TqVVOKTQDO7dbN0m1ZyeDkDZjeKKa/8BrPjtNCW0vS04g+65IAjyIPQhWVJWXvQjREvNe0k/P99a5z3gLx1IBSA7C2MR2VipUp6S3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HL2dsqHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C491BC4CEE9;
	Tue, 27 May 2025 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748357804;
	bh=lWEv5yXJOgpl/qinEW2WH2JUTASr1G0HnYXwJyeJYno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HL2dsqHWaWEZYwhv2LuutAd09iMRUhq5wMM27QYXdQ2nOXMbAZd+ABPSLELmyAikD
	 KEXjEf0AQo00mrVOHEwOI8LGrjOJtx/iduOob/UE3cPsi1qkVHP1pZRE+3hx2b2qCB
	 upyhiU/I/NTQU4jPjFSvxZKKHCHxL98lOo/aesNU=
Date: Tue, 27 May 2025 16:56:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: Patch "btrfs: zoned: exit btrfs_can_activate_zone if
 BTRFS_FS_NEED_ZONE_FINISH is set" has been added to the 6.14-stable tree
Message-ID: <2025052730-humped-womanhood-4250@gregkh>
References: <20250522210607.3118447-1-sashal@kernel.org>
 <e13efec8-eaa7-47e1-9c67-06d7524a0c36@wdc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13efec8-eaa7-47e1-9c67-06d7524a0c36@wdc.com>

On Fri, May 23, 2025 at 05:49:41AM +0000, Johannes Thumshirn wrote:
> On 22.05.25 23:06, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      btrfs: zoned: exit btrfs_can_activate_zone if BTRFS_FS_NEED_ZONE_FINISH is set
> > 
> > to the 6.14-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       btrfs-zoned-exit-btrfs_can_activate_zone-if-btrfs_fs.patch
> > and it can be found in the queue-6.14 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> 
> Hey Sasha,
> 
> this patch is just a readability cleanup, no reason to backport it.


Now dropped, thanks.

greg k-h

