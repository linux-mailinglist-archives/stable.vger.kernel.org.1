Return-Path: <stable+bounces-94468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7F99D4331
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 21:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D5DB242F5
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331941BBBE8;
	Wed, 20 Nov 2024 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXGfixLD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C972F2A;
	Wed, 20 Nov 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732135131; cv=none; b=aCTjGWnhQ9z9SHencOaFtOzsIm9EhpyE0kQPWzWUjsLKHwmmAxkLeO3K7dP6xGgPMsSxOhtsWZSJROOp8W/yayujz64Oq0i037GEWEnmXvt1xnGzYv4iBfrZn1k9oBKBgvpMULRImpOsO9GAesDmn6T4JU/XXXQI1dhIjIJpK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732135131; c=relaxed/simple;
	bh=+5Y0qbRrViO3GMeurt2tZfKhhx1FHV6cNAsoCq4C07w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKUMUITYS/lCPgbBnfkTQgsk/Y0nG/CyBqbgjvoTtClazdVoxLrBgAxmMiTtX4xjnNL853FUf1dw81/s3My55KNL+S5lLlvlOxbLI/pCmZ2OBk2l4Old9rvuKKc+BHGru4ir95cLfskMtgmo/HXlwSBu7WpavgsBK3rVAIW1feQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXGfixLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D101C4CECD;
	Wed, 20 Nov 2024 20:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732135130;
	bh=+5Y0qbRrViO3GMeurt2tZfKhhx1FHV6cNAsoCq4C07w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXGfixLDpaBgzbUue1q95L/wK0RSea9FMEURCrOLwHxHR7iZdh34rm4yYYgGdfmAL
	 4+HqG3pplXhytnRXBMGafoF6zW959Z7RBGNRv3+MvMkFjXYXhtiQf57SQloD3asaqL
	 MbbMbBGfI8mW44Yt5Cf0IRiz6VU+j7t+Pfjj2KRoJmF/BHwizj1+t9zryGa57oddUa
	 DA5lKcjwOecpHQj94QHePoQIbAfXBC12bTayISHLcEqVxy4R3iAZmCwnBv7rMmO/Ex
	 bHv2n1htZhUEZQkyhRCCvtCAKoxrb4E2bUBeVU44uXWeHIli4dqVwMDkqNLf/sLXog
	 n+/G9WMZC5K1w==
Date: Wed, 20 Nov 2024 20:38:49 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	stable@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
Subject: Re: [PATCH] Revert "f2fs: remove unreachable lazytime mount option
 parsing"
Message-ID: <Zz5I2cdFn331_0ud@google.com>
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
 <ZzPLELITeOeBsYdi@google.com>
 <493ce255-efcd-48af-ad7f-6e421cc04f1c@redhat.com>
 <ee341ea4-904c-4885-bf8d-8111f9e416b5@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee341ea4-904c-4885-bf8d-8111f9e416b5@redhat.com>

On 11/20, Eric Sandeen wrote:
> On 11/20/24 8:27 AM, Eric Sandeen wrote:
> > On 11/12/24 3:39 PM, Jaegeuk Kim wrote:
> >> Hi Eric,
> >>
> >> Could you please check this revert as it breaks the mount()?
> >> It seems F2FS needs to implement new mount support.
> >>
> >> Thanks,
> > 
> > I'm sorry, I missed this email. I will look into it more today.
> 
> Ok, I see that I had not considered a direct mount call passing
> the lazytime option strings. :(
> 
> Using mount(8), "lazytime" is never passed as an option all the way to f2fs,
> nor is "nolazytime" -
> 
> # mount -o loop,nolazytime f2fsfile.img mnt
> # mount | grep lazytime
> /root/f2fs-test/f2fsfile.img on /root/f2fs-test/mnt type f2fs (rw,relatime,lazytime,seclabel,background_gc=on,nogc_merge,discard,discard_unit=block,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,barrier,extent_cache,mode=adaptive,active_logs=6,alloc_mode=reuse,checkpoint_merge,fsync_mode=posix,memory=normal,errors=continue)
> 
> (note that lazytime is still set despite -o nolazytime)
> 
> when mount(8) is using the new mount API, it does do fsconfig for (no)lazytime:
> 
> fsconfig(3, FSCONFIG_SET_FLAG, "nolazytime", NULL, 0) = 0
> 
> but that is consumed by the VFS and never sent into f2fs for parsing.
> 
> And because default_options() does:
> 
> sbi->sb->s_flags |= SB_LAZYTIME;
> 
> by default, it overrides the "nolazytime" that the vfs had previously handled.
> 
> I'm fairly sure that when mount(8) was using the old mount API (long ago) it also
> did not send in the lazytime option string - it sent it as a flag instead.
> 
> However - a direct call to mount(2) /will/ pass those options all the way
> to f2fs, and parse_options() does need to handle them there or it will be rejected
> as an invalid option.
> 
> (Note that f2fs is the only filesystem that attempts to handle lazytime within
> the filesystem itself):
> 
> [linux]# grep -r \"lazytime\" fs/*/
> fs/f2fs/super.c:	{Opt_lazytime, "lazytime"},
> [linux]#
> 
> I'm not entirely sure how to untangle all this, but regressions are not acceptable,
> so please revert my commit for now.

Thanks for the explanation. At a glance, I thought it's caused that f2fs doesn't
implement fs_context_operations. We'll take a look at how to support it.

> 
> Thanks,
> -Eric
> 
> 
> > As for f2fs new mount API support, I have been struggling with it for a
> > long time, f2fs has been uniquely complex. The assumption that the superblock
> > and on-disk features are known at option parsing time makes it much more
> > difficult than most other filesystems.
> > 
> > But if there's a problem/regression with this commit, I have no objection to
> > reverting the commit for now, and I'm sorry for the error.
> > 
> > -Eric
> > 
> >> On 11/12, Jaegeuk Kim wrote:
> >>> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
> >>>
> >>> The above commit broke the lazytime mount, given
> >>>
> >>> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
> >>>
> >>> CC: stable@vger.kernel.org # 6.11+
> >>> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>  fs/f2fs/super.c | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>> index 49519439b770..35c4394e4fc6 100644
> >>> --- a/fs/f2fs/super.c
> >>> +++ b/fs/f2fs/super.c
> >>> @@ -150,6 +150,8 @@ enum {
> >>>  	Opt_mode,
> >>>  	Opt_fault_injection,
> >>>  	Opt_fault_type,
> >>> +	Opt_lazytime,
> >>> +	Opt_nolazytime,
> >>>  	Opt_quota,
> >>>  	Opt_noquota,
> >>>  	Opt_usrquota,
> >>> @@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
> >>>  	{Opt_mode, "mode=%s"},
> >>>  	{Opt_fault_injection, "fault_injection=%u"},
> >>>  	{Opt_fault_type, "fault_type=%u"},
> >>> +	{Opt_lazytime, "lazytime"},
> >>> +	{Opt_nolazytime, "nolazytime"},
> >>>  	{Opt_quota, "quota"},
> >>>  	{Opt_noquota, "noquota"},
> >>>  	{Opt_usrquota, "usrquota"},
> >>> @@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
> >>>  			f2fs_info(sbi, "fault_type options not supported");
> >>>  			break;
> >>>  #endif
> >>> +		case Opt_lazytime:
> >>> +			sb->s_flags |= SB_LAZYTIME;
> >>> +			break;
> >>> +		case Opt_nolazytime:
> >>> +			sb->s_flags &= ~SB_LAZYTIME;
> >>> +			break;
> >>>  #ifdef CONFIG_QUOTA
> >>>  		case Opt_quota:
> >>>  		case Opt_usrquota:
> >>> -- 
> >>> 2.47.0.277.g8800431eea-goog
> >>
> > 

