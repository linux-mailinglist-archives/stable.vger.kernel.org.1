Return-Path: <stable+bounces-164588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD9BB10792
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E891894EB3
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 10:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC122609D9;
	Thu, 24 Jul 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhZT44th"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8687F9;
	Thu, 24 Jul 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352302; cv=none; b=ddmfZzi33AIS0/9xkDpX4M6mpNf9SOwgWN11Z7zT9yVEcQduxTN3PJPA2T2w1AS8jmHLJh5uCA9cYVWa08eTSVfGjpjkd0eXFpAgI7iPABsWMn2ZNXRY6H0Idh9EAZnBM8yU17/KWqcMZyG3IjgElKQIhAp8On8jOAMqHdlPAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352302; c=relaxed/simple;
	bh=kxNbWmvGgnDYGDeo1gboZY2VzKiJaS/yvAS02FMDsno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0E6ve4bHJ/Uxw7wCKu6RiFCZ+3axjF78aglPN8Heqq87yoOPA8WWK2+0loUjPwzkhhVGwAuCu5jXWlGxJMlhMl6+SLmZ8JHiAAStRJy1eFakrbXBXHDrj+Cda4C9JTclKwzKNW7RELekmxOkoQlu7FYsHH5TTZWc87nym8yKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhZT44th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738A8C4CEED;
	Thu, 24 Jul 2025 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753352302;
	bh=kxNbWmvGgnDYGDeo1gboZY2VzKiJaS/yvAS02FMDsno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhZT44thqgQVxJ9rRh0LLiA8wFQN8Uwt2NBlm3NvZilVQm7fyVM4foN38zUsSHMD/
	 z9GO9ba57JpR+ZIWxolyviW9NFX+c/YauCU1Qw8LTlnHhGX0/ixPAO502tVQEK+bY/
	 Rny13nIhUvKk4ISHPuJO0JNtgqMHROkqAgFWejWfKyzCqk5mYARBZx9iCQ0uObBB1u
	 i9vb4XE6w+DiquOhNENj9cdKwE1R4TcIZIoULdxRexeQ9QECa78EO+mAKw8Gyloe8d
	 ZEbl6+NigcGM5FkXjuQjExv0+cEgYXsGzK2qOvRruDKMJLjPFgfhM40QGy3xxgzco4
	 xfY+uuWWKloZg==
Date: Thu, 24 Jul 2025 11:18:17 +0100
From: Lee Jones <lee@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chao Yu <chao@kernel.org>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [STABLE 5.15+] f2fs: sysfs: add encoding_flags entry
Message-ID: <20250724101817.GZ11056@google.com>
References: <20250416054805.1416834-1-chao@kernel.org>
 <20250624100039.GA3680448@google.com>
 <2025070253-erased-armadillo-0984@gregkh>
 <20250723082639.GP11056@google.com>
 <2025072354-tricolor-annex-92fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025072354-tricolor-annex-92fb@gregkh>

On Wed, 23 Jul 2025, Greg Kroah-Hartman wrote:

> On Wed, Jul 23, 2025 at 09:26:39AM +0100, Lee Jones wrote:
> > On Wed, 02 Jul 2025, Greg Kroah-Hartman wrote:
> > 
> > > On Tue, Jun 24, 2025 at 11:00:39AM +0100, Lee Jones wrote:
> > > > On Wed, 16 Apr 2025, Chao Yu wrote:
> > > > 
> > > > > This patch adds a new sysfs entry /sys/fs/f2fs/<disk>/encoding_flags,
> > > > > it is a read-only entry to show the value of sb.s_encoding_flags, the
> > > > > value is hexadecimal.
> > > > > 
> > > > > ===========================      ==========
> > > > > Flag_Name                        Flag_Value
> > > > > ===========================      ==========
> > > > > SB_ENC_STRICT_MODE_FL            0x00000001
> > > > > SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
> > > > > ===========================      ==========
> > > > > 
> > > > > case#1
> > > > > mkfs.f2fs -f -O casefold -C utf8:strict /dev/vda
> > > > > mount /dev/vda /mnt/f2fs
> > > > > cat /sys/fs/f2fs/vda/encoding_flags
> > > > > 1
> > > > > 
> > > > > case#2
> > > > > mkfs.f2fs -f -O casefold -C utf8 /dev/vda
> > > > > fsck.f2fs --nolinear-lookup=1 /dev/vda
> > > > > mount /dev/vda /mnt/f2fs
> > > > > cat /sys/fs/f2fs/vda/encoding_flags
> > > > > 2
> > > > > 
> > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > ---
> > > > >  Documentation/ABI/testing/sysfs-fs-f2fs | 13 +++++++++++++
> > > > >  fs/f2fs/sysfs.c                         |  9 +++++++++
> > > > >  2 files changed, 22 insertions(+)
> > > > 
> > > > This patch, commit 617e0491abe4 ("f2fs: sysfs: export linear_lookup in
> > > > features directory") upstream, needs to find its way into all Stable
> > > > branches containing upstream commit 91b587ba79e1 ("f2fs: Introduce
> > > > linear search for dentries"), which is essentially linux-5.15.y and
> > > > newer.
> > > > 
> > > > stable/linux-5.4.y:
> > > > MISSING:     f2fs: Introduce linear search for dentries
> > > > MISSING:     f2fs: sysfs: export linear_lookup in features directory
> > > > 
> > > > stable/linux-5.10.y:
> > > > MISSING:     f2fs: Introduce linear search for dentries
> > > > MISSING:     f2fs: sysfs: export linear_lookup in features directory
> > > > 
> > > > stable/linux-5.15.y:
> > > > b0938ffd39ae f2fs: Introduce linear search for dentries [5.15.179]
> > > > MISSING:     f2fs: sysfs: export linear_lookup in features directory
> > > > 
> > > > stable/linux-6.1.y:
> > > > de605097eb17 f2fs: Introduce linear search for dentries [6.1.129]
> > > > MISSING:     f2fs: sysfs: export linear_lookup in features directory
> > > > 
> > > > stable/linux-6.6.y:
> > > > 0bf2adad03e1 f2fs: Introduce linear search for dentries [6.6.76]
> > > > MISSING:     f2fs: sysfs: export linear_lookup in features directory
> > > > 
> > > > stable/linux-6.12.y:
> > > > 00d1943fe46d f2fs: Introduce linear search for dentries [6.12.13]
> > > > MISSING:     f2fs: sysfs: export linear_lookup in features directory
> > > > 
> > > > mainline:
> > > > 91b587ba79e1 f2fs: Introduce linear search for dentries
> > > > 617e0491abe4 f2fs: sysfs: export linear_lookup in features directory
> > > 
> > > Great, then can someone submit these in a format we can apply them in?
> > > or do clean cherry-picks work properly?
> > 
> > Does this work:
> > 
> > Please backport upstream commit:
> > 
> >   617e0491abe4 f2fs: sysfs: export linear_lookup in features directory
> > 
> > ... to all stable branches up to and including linux-5.15.y.
> > 
> > If there are conflicts, I can do the backport myself and submit as patches.
> 
> There are conflicts, it doesn't apply to 6.1.y or 5.15.y :(

Okay, thanks for trying.  Leave it with me.

-- 
Lee Jones [李琼斯]

