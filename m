Return-Path: <stable+bounces-94070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708849D2FBE
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 21:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEE21F2336D
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 20:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8ED1D4336;
	Tue, 19 Nov 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIEC7mwJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF71D4323;
	Tue, 19 Nov 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049315; cv=none; b=kuWBKsCFJEP+at5wumSR+ClUKbADF8bzEEbjtUTzKoo8lYvniLCOFAj/xLfMbzZe9Kdel6Dorj7yikiwVAvoQhNMI51V5l5zFmXfCsUqgjFBrg15RAJe7exAxz0veXI3jfpFXsP6ESB95Gb0fvWCUH/+6O0Q2v6G+LWEykDvql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049315; c=relaxed/simple;
	bh=Qr0mR248nqxZbkr6itNQlw4W9Nf3/OTO+EvoEqnOoMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4lRSrcCp7JrWgfIVTXnYyFvb74J0roPgs34mq07K6KPvfHle1WSlX5MIrg7fXeqbqHVRpB0Tj7AIr4uujQNSzkQXjM1xyuAH7aV5AU+zWMhP7AI278IG/ub74lq65VbykKkBxi4Bb7kjWlsK6hSVyF55StN2yFtsL/O2JuW3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIEC7mwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14DDC4CECF;
	Tue, 19 Nov 2024 20:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732049315;
	bh=Qr0mR248nqxZbkr6itNQlw4W9Nf3/OTO+EvoEqnOoMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIEC7mwJI8iVPEvgckbGHGRtiWRXMmZXZEEkypgBUWjjiRrrzoXCeOhlBMM7AqTDL
	 TDMUh6+WCqp/CFLZ0ufNpofvSox3V/u8EAYZaeindSBPVeRiwUHGEhdx+WI8Vxuy3n
	 hJf1NbDQd77MM59G2cyiybE+BdUTbn5SeD21rxrKagheTmaB4RHlYMYTvDTuquyRy5
	 Qn+MazBu/GW8EOUVdjnQuu8/pl2elRhNqvVmuI8hFYbrpI2jDrdT2+Vzmxc5RqALRK
	 FfqI49wCiS5ErLNfHOQHqXmLtMreyVwBjeaQdgCjmrrTwUTBoeH6GooQYd3p1RZ3vE
	 kIyWcfbLrxN/w==
Date: Tue, 19 Nov 2024 20:48:33 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>, Daniel Rosenberg <drosen@google.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: remove unreachable lazytime
 mount option parsing"
Message-ID: <Zzz5ocjKK_naOnMq@google.com>
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
 <ZzPLELITeOeBsYdi@google.com>
 <2d26eeee-01f7-445b-a1d2-bc2de65b5599@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d26eeee-01f7-445b-a1d2-bc2de65b5599@kernel.org>

On 11/19, Chao Yu wrote:
> On 2024/11/13 5:39, Jaegeuk Kim via Linux-f2fs-devel wrote:
> > Hi Eric,
> > 
> > Could you please check this revert as it breaks the mount()?
> > It seems F2FS needs to implement new mount support.
> 
> Hi all,
> 
> Actually, if we want to enable lazytime option, we can use mount
> syscall as:
> 
> mount("/dev/vdb", "/mnt/test", "f2fs", MS_LAZYTIME, NULL);
> 
> or use shell script as:
> 
> mount -t f2fs -o lazytime /dev/vdb /mnt/test
> 
> IIUC, the reason why mount command can handle lazytime is, after
> 8c7f073aaeaa ("libmount: add support for MS_LAZYTIME"), mount command
> supports to map "lazytime" to MS_LAZYTIME, and use MS_LAZYTIME in
> parameter @mountflags of mount(2).
> 
> So, it looks we have alternative way to enable/disable lazytime feature
> after removing Opt_{no,}lazytime parsing in f2fs, do we really need this
> revert patch?

This is a regression of the below command. I don't think offering others are
feasible.

mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > On 11/12, Jaegeuk Kim wrote:
> > > This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
> > > 
> > > The above commit broke the lazytime mount, given
> > > 
> > > mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
> > > 
> > > CC: stable@vger.kernel.org # 6.11+
> > > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >   fs/f2fs/super.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index 49519439b770..35c4394e4fc6 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -150,6 +150,8 @@ enum {
> > >   	Opt_mode,
> > >   	Opt_fault_injection,
> > >   	Opt_fault_type,
> > > +	Opt_lazytime,
> > > +	Opt_nolazytime,
> > >   	Opt_quota,
> > >   	Opt_noquota,
> > >   	Opt_usrquota,
> > > @@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
> > >   	{Opt_mode, "mode=%s"},
> > >   	{Opt_fault_injection, "fault_injection=%u"},
> > >   	{Opt_fault_type, "fault_type=%u"},
> > > +	{Opt_lazytime, "lazytime"},
> > > +	{Opt_nolazytime, "nolazytime"},
> > >   	{Opt_quota, "quota"},
> > >   	{Opt_noquota, "noquota"},
> > >   	{Opt_usrquota, "usrquota"},
> > > @@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
> > >   			f2fs_info(sbi, "fault_type options not supported");
> > >   			break;
> > >   #endif
> > > +		case Opt_lazytime:
> > > +			sb->s_flags |= SB_LAZYTIME;
> > > +			break;
> > > +		case Opt_nolazytime:
> > > +			sb->s_flags &= ~SB_LAZYTIME;
> > > +			break;
> > >   #ifdef CONFIG_QUOTA
> > >   		case Opt_quota:
> > >   		case Opt_usrquota:
> > > -- 
> > > 2.47.0.277.g8800431eea-goog
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

