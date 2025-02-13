Return-Path: <stable+bounces-115145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63328A340E1
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DD2169983
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295724BC09;
	Thu, 13 Feb 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PMz3okXH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199112E7F
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454911; cv=none; b=ofwIQl6CLgO99Sgmz+yUQkpPoXwmIPyOvdnR/wdFqMkulEZUsXzq0HIR6u+1aoZM4RPcup6OEsOxlXcTQZjPyov21bX8O1q+1VU/rZtI+ZUoCJHUsOPHIwejDIGKk4wNbrD4Chk/sFlcwB1p0//YdSQPwaZ2ut9LvFioNjc/HO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454911; c=relaxed/simple;
	bh=64E/N9ULDjSIClkUiDh6+ymD5+eS8cns5Rb3DQzsc4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyxCO8T92MAd6z3GbJ1CuhFg4QFiGzJbv3bS/eSlvAI1MWQ9J+st9lbiritSBxon6dDSzTEjmaSXziQ/zgfhfzrFtZ1EZbXRmAjBkdj6yCX92bKY0jmj4KF0GV2Sbp9OgsNHEepUf47JvemVL5KdK5eTpZNB0emZXjw4YvF3sX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PMz3okXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C49C4CED1;
	Thu, 13 Feb 2025 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739454911;
	bh=64E/N9ULDjSIClkUiDh6+ymD5+eS8cns5Rb3DQzsc4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMz3okXH3cvUhos1zmETURTDRu0WpoiMxx92/JSnhBKhNvmNeqHfYBTRP/QNiw4aa
	 41bI/dJ0dDtEAKA2MqdBb0VclJUTCTJCR5j/PxGPemXik1O/R40ZHDRTclkMnbnJ4/
	 v+cqkdq2Mqp+L5BuLH/m64N1PTJwGqqF0GAW/HYg=
Date: Thu, 13 Feb 2025 14:55:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: vgiraud.opensource@witekio.com
Cc: stable@vger.kernel.org, Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>, Bruno VERNAY <bruno.vernay@se.com>
Subject: Re: [PATCH 6.6] ext4: filesystems without casefold feature cannot be
 mounted with siphash
Message-ID: <2025021331-neuron-alarm-ecfc@gregkh>
References: <20250207113703.2444446-1-vgiraud.opensource@witekio.com>
 <2025021313-aware-yam-ffec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025021313-aware-yam-ffec@gregkh>

On Thu, Feb 13, 2025 at 02:53:56PM +0100, Greg KH wrote:
> On Fri, Feb 07, 2025 at 12:37:03PM +0100, vgiraud.opensource@witekio.com wrote:
> > From: Lizhi Xu <lizhi.xu@windriver.com>
> > 
> > commit 985b67cd86392310d9e9326de941c22fc9340eec upstream.
> > 
> > When mounting the ext4 filesystem, if the default hash version is set to
> > DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.
> > 
> > Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
> > Signed-off-by: Victor Giraud <vgiraud.opensource@witekio.com>
> > ---
> >  fs/ext4/super.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index f019ce64eba4..b69d791be846 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -3627,6 +3627,14 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
> >  	}
> >  #endif
> >  
> > +	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
> > +	    !ext4_has_feature_casefold(sb)) {
> > +		ext4_msg(sb, KERN_ERR,
> > +			 "Filesystem without casefold feature cannot be "
> > +			 "mounted with siphash");
> > +		return 0;
> > +	}
> > +
> >  	if (readonly)
> >  		return 1;
> >  
> > -- 
> > 2.34.1
> > 
> > 
> 
> Any specific reason you asked for just this one commit to be backported
> and NOT the fix for this commit?
> 
> How did you test this?

And the fix did not apply either, so I'm dropping this from all queues.

Be more careful please!  Don't submit patches that actually cause
documented problems.

greg k-h

