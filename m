Return-Path: <stable+bounces-45975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989468CD95D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 19:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CC5282373
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8172028366;
	Thu, 23 May 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfhrwL6Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74D20332
	for <stable@vger.kernel.org>; Thu, 23 May 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486409; cv=none; b=n2wGzXTmdpflO0FfZfaxoyOiJlwthTeJ47G/dn2P/EJrA4OzLLlWTfKkE4s2QzUYcVG47qZgsKjpq8Bi4j/iKO9151xv05gT9WHs62M9YrTt+j8X3bVQDl8xkymPDvZ3I7/X4MB4W8mls/YHDXmcEdL/7mSTAtyiX298H/npaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486409; c=relaxed/simple;
	bh=axKpqX7OyxRRCvS63G23idJ5DSe9uwY6YtfBQyk6UXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwhN0q+/OmD/SyZqi2lKQzHkekOPN44yVCv9lfXA/GigLOG4plng6f0h5s0rMbWyiQctJXdT6tRIOttCQx18d8V2rvnE88hf3al2cRJsjc3xYbfVXUQBqiD50SHiiPj1mg7aumRGWn8T2q9l4tlVUHxsKNmgNvrEIrDWNxkhICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfhrwL6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F62C2BD10;
	Thu, 23 May 2024 17:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716486408;
	bh=axKpqX7OyxRRCvS63G23idJ5DSe9uwY6YtfBQyk6UXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DfhrwL6ZYr2U/k2cV+uJ6FlfSvGKBfOf0QHmX7Uh1/WxB7a4o1beGBVbtyGEcddmo
	 lkd2WcjSoHpRY98KL1OAR+5deYjV7PsEZOmY32ggScgVlHWq0ZFsv6lBod0UPBxYKI
	 JmfEZC7nZDLFjv4YZNA2ZDVQuaHvaVzI4hfbtmZZtzVvK+HLh99JtbBS6CKHP4GVcu
	 jelCq+4jj1yVOwNfk+SVQ5r5Vegh1o1Vee9IqoC/jTDq9J9hG5+wtzc0qUE6Pk08yU
	 ewf3q6EYDvI29IY1fPJ6PHGKJey5iRXtLtnfXX18mDk+tyYSdSyr4ET1MsUgyriYig
	 O3u/oYmDqFymw==
Date: Thu, 23 May 2024 17:46:46 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@kernel.org, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix false alarm on invalid block address
Message-ID: <Zk-BBpChhBi1J4PC@google.com>
References: <20240520220208.1596727-1-jaegeuk@kernel.org>
 <Zk-AilUqViUaLj8b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk-AilUqViUaLj8b@google.com>

Fixed the stable mailing list.

On 05/23, Jaegeuk Kim wrote:
> Hi Greg,
> 
> Could you please consider to cherry-pick this patch in stable-6.9, since
> there are many users suffering from unnecessary fsck runs during boot?
> 
> You can get this from Linus's tree by
> (b864ddb57eb0 "f2fs: fix false alarm on invalid block address")
> 
> Thanks,
> 
> On 05/20, Jaegeuk Kim wrote:
> > f2fs_ra_meta_pages can try to read ahead on invalid block address which is
> > not the corruption case.
> > 
> > Cc: <stable@kernel.org> # v6.9+
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218770
> > Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
> > Reviewed-by: Chao Yu <chao@kernel.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 5d05a413f451..55d444bec5c0 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -179,22 +179,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >  		break;
> >  	case META_SIT:
> >  		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
> > -			goto err;
> > +			goto check_only;
> >  		break;
> >  	case META_SSA:
> >  		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
> >  			blkaddr < SM_I(sbi)->ssa_blkaddr))
> > -			goto err;
> > +			goto check_only;
> >  		break;
> >  	case META_CP:
> >  		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
> >  			blkaddr < __start_cp_addr(sbi)))
> > -			goto err;
> > +			goto check_only;
> >  		break;
> >  	case META_POR:
> >  		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
> >  			blkaddr < MAIN_BLKADDR(sbi)))
> > -			goto err;
> > +			goto check_only;
> >  		break;
> >  	case DATA_GENERIC:
> >  	case DATA_GENERIC_ENHANCE:
> > @@ -228,6 +228,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >  	return true;
> >  err:
> >  	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +check_only:
> >  	return false;
> >  }
> >  
> > -- 
> > 2.45.0.rc1.225.g2a3ae87e7f-goog

