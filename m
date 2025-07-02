Return-Path: <stable+bounces-159221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F3DAF119C
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EBB17CC22
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571E24C664;
	Wed,  2 Jul 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ldHuEhFu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0E19CC11;
	Wed,  2 Jul 2025 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451633; cv=none; b=pbEwtAbeigOBR0/EKAcdLo+dNTNbaR++yHWXU5PVoXedcgDgcj1WMKRHFqcpu2K/OaRjcqDlOfQl4a0ruYaHGVCQverz29e3VPbN7Jm1ebOdT0uEw21H1fnxjVWU843z3RmzZe3gNe+YjiYl7tnTJmzk0yMxCwo5S6Qm9rFT8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451633; c=relaxed/simple;
	bh=isVC2OxjtYeqrfimdWGEstYRYwCNvNScMRWqnkaXR5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+bvHatC/ZitxfW3tLY20B5fz8soXRhoGn8D76zezFLJxUERf9w9VD7cMOGjc/zmjkY5xmwslvebtcTZmug+yIzRieXPQMyTVj5gMRTDhdt9SJ+CKwbANlJ2NdXPApGKpW9ouaxPPMSIHd60HERazoT+k5AGlVOz7Zw3bs/dCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ldHuEhFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11C2C4CEED;
	Wed,  2 Jul 2025 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751451633;
	bh=isVC2OxjtYeqrfimdWGEstYRYwCNvNScMRWqnkaXR5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldHuEhFu2SGpKZLoH1Ob+UWzanKdn4CbBABLItbBdbvqk3EYLiAREtyvVyNJVJsIO
	 QrfOqR5WxC997Tn11w9ouYm+N85Vqt49rr2e9zg3opiRPnIPU9fQampZJR72A3VlTj
	 zdlyJ/H5U3hvRbdazjEt7nnd6gwVcNf3kUtzYgWI=
Date: Wed, 2 Jul 2025 12:20:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Chao Yu <chao@kernel.org>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [STABLE 5.15+] f2fs: sysfs: add encoding_flags entry
Message-ID: <2025070253-erased-armadillo-0984@gregkh>
References: <20250416054805.1416834-1-chao@kernel.org>
 <20250624100039.GA3680448@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624100039.GA3680448@google.com>

On Tue, Jun 24, 2025 at 11:00:39AM +0100, Lee Jones wrote:
> On Wed, 16 Apr 2025, Chao Yu wrote:
> 
> > This patch adds a new sysfs entry /sys/fs/f2fs/<disk>/encoding_flags,
> > it is a read-only entry to show the value of sb.s_encoding_flags, the
> > value is hexadecimal.
> > 
> > ===========================      ==========
> > Flag_Name                        Flag_Value
> > ===========================      ==========
> > SB_ENC_STRICT_MODE_FL            0x00000001
> > SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
> > ===========================      ==========
> > 
> > case#1
> > mkfs.f2fs -f -O casefold -C utf8:strict /dev/vda
> > mount /dev/vda /mnt/f2fs
> > cat /sys/fs/f2fs/vda/encoding_flags
> > 1
> > 
> > case#2
> > mkfs.f2fs -f -O casefold -C utf8 /dev/vda
> > fsck.f2fs --nolinear-lookup=1 /dev/vda
> > mount /dev/vda /mnt/f2fs
> > cat /sys/fs/f2fs/vda/encoding_flags
> > 2
> > 
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> >  Documentation/ABI/testing/sysfs-fs-f2fs | 13 +++++++++++++
> >  fs/f2fs/sysfs.c                         |  9 +++++++++
> >  2 files changed, 22 insertions(+)
> 
> This patch, commit 617e0491abe4 ("f2fs: sysfs: export linear_lookup in
> features directory") upstream, needs to find its way into all Stable
> branches containing upstream commit 91b587ba79e1 ("f2fs: Introduce
> linear search for dentries"), which is essentially linux-5.15.y and
> newer.
> 
> stable/linux-5.4.y:
> MISSING:     f2fs: Introduce linear search for dentries
> MISSING:     f2fs: sysfs: export linear_lookup in features directory
> 
> stable/linux-5.10.y:
> MISSING:     f2fs: Introduce linear search for dentries
> MISSING:     f2fs: sysfs: export linear_lookup in features directory
> 
> stable/linux-5.15.y:
> b0938ffd39ae f2fs: Introduce linear search for dentries [5.15.179]
> MISSING:     f2fs: sysfs: export linear_lookup in features directory
> 
> stable/linux-6.1.y:
> de605097eb17 f2fs: Introduce linear search for dentries [6.1.129]
> MISSING:     f2fs: sysfs: export linear_lookup in features directory
> 
> stable/linux-6.6.y:
> 0bf2adad03e1 f2fs: Introduce linear search for dentries [6.6.76]
> MISSING:     f2fs: sysfs: export linear_lookup in features directory
> 
> stable/linux-6.12.y:
> 00d1943fe46d f2fs: Introduce linear search for dentries [6.12.13]
> MISSING:     f2fs: sysfs: export linear_lookup in features directory
> 
> mainline:
> 91b587ba79e1 f2fs: Introduce linear search for dentries
> 617e0491abe4 f2fs: sysfs: export linear_lookup in features directory

Great, then can someone submit these in a format we can apply them in?
or do clean cherry-picks work properly?

thanks,

greg k-h

