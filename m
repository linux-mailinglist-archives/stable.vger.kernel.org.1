Return-Path: <stable+bounces-131865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE5A81900
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 00:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9090E7AE715
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5470245024;
	Tue,  8 Apr 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="W/Vij0LF"
X-Original-To: stable@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BA11CAA86;
	Tue,  8 Apr 2025 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152577; cv=none; b=D1fw4LqIifB0rPfJw7bgnkJLfRL1K9l4NYsIkPEHddYJ3U27StsI1GI9CXe798yqi4p3OpnOICrwzJvgCekfZX4C4UzTHoyIUFftLZ1FT6N/9Nej0V7ryAyTVaq+7mTta4pxFrROC9RXxQLqAV7ummVB+GyJacQYS/SSUtVCmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152577; c=relaxed/simple;
	bh=esWlGWMk0hjOHa0vXYnDQpyJZQI+y4/+EFbomDvljNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWgOYseFifZrWuPjEpiGSjOYoTeHVspyN11jLhEYWoJt016vpfSGsGLny9JgBx+Q3YHoz3sKbsIjriWuthOKiB3geHudKJz+hSnn8unbC4Y60cmHRQ8BgSMre41Tc2+/iAnlOGJIJufTFpDNXx1N/vOMdLCzuc83+qXSnOD8nac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=W/Vij0LF reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GKcebr4KZ1je+omvI6wYjVgDBZuusvMWLccgV7EesoE=; b=W/Vij0LFOWUhA5fJmr7CYgXTiO
	Sw7GTf9d6f0+PG+yZQ/BrXkz3AU1JMQTC2e1v3/iT5Yfx5kTdRYAbOK2ML4PiOaIB1ILuf6toTKub
	43mwOJNugokxfw6PQRrwYHqAWtiJgI8t/KwpHMM+U/5pD9coT2QW9MHJIWEesEcIkHr2/Yn+OnLQv
	DVAitfQxAZCDGT2+qBS3YQVOghgN+yOTbHdTjyozq1gog4UD/+BhVhvtwlk+RM03wOFoJyYs0HwEx
	afJJck1pZGqDMoMhAf3OT79aB9u8EI2NE8/nMMuSPIJD35cqEWPyc/UcBqjD7HZJPKzjXKw96S3xB
	zQHxtCnw==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Hl4-00000002pTB-3uzk;
	Tue, 08 Apr 2025 22:49:31 +0000
Date: Tue, 8 Apr 2025 15:49:27 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] configfs: Correct condition for returning -EEXIST in
 configfs_symlink()
Message-ID: <Z_Wn978o-kwscN29@google.com>
Mail-Followup-To: Zijun Hu <zijun_hu@icloud.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20250408-fix_configfs-v1-0-5a4c88805df7@quicinc.com>
 <20250408-fix_configfs-v1-4-5a4c88805df7@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-fix_configfs-v1-4-5a4c88805df7@quicinc.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Tue, Apr 08, 2025 at 09:26:10PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> configfs_symlink() returns -EEXIST under condition d_unhashed(), but the
> condition often means the dentry does not exist.
> 
> Fix by changing the condition to !d_unhashed().

I don't think this is quite right.

viro put this together in 351e5d869e5ac, which was a while ago.  Read
his comment on 351e5d869e5ac.  Because I unlock the parent directory to
look up the target, we can't trust our symlink dentry hasn't been
changed underneath us.

* If there is now dentry->d_inode, some other inode has been put here.
  -EEXIST.
* If the dentry was unhashed, somehow the dentry we are creating was
  removed from the dcache, and adding things to our dentry will at best
  go nowhere, and at worst dangle in space.  I'm pretty sure viro
  returns -EEXIST because if this dentry is unhashed, some *other*
  dentry has entered the dcache in its place (another file type,
  perhaps).

If you instead check for !d_unhashed(), you're discovering our candidate
dentry is still live in the dcache, which is what we expect and want.

How did you identify this as a problem?  Perhaps we need a more nuanced
check than d_unhashed() these days (for example, d_is_positive/negative
didn't exist back then).

Thanks,
Joel

PS: I enjoyed the trip down memory lane to Al reaming me quite
    thoroughly for this API.

> 
> Fixes: 351e5d869e5a ("configfs: fix a deadlock in configfs_symlink()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  fs/configfs/symlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> index 69133ec1fac2a854241c2a08a3b48c4c2e8d5c24..cccf61fb8317d739643834e1810b7f136058f56c 100644
> --- a/fs/configfs/symlink.c
> +++ b/fs/configfs/symlink.c
> @@ -193,7 +193,7 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	if (ret)
>  		goto out_put;
>  
> -	if (dentry->d_inode || d_unhashed(dentry))
> +	if (dentry->d_inode || !d_unhashed(dentry))
>  		ret = -EEXIST;
>  	else
>  		ret = inode_permission(&nop_mnt_idmap, dir,
> 
> -- 
> 2.34.1
> 

-- 

"We will have to repent in this generation not merely for the
 vitriolic words and actions of the bad people, but for the 
 appalling silence of the good people."
	- Rev. Dr. Martin Luther King, Jr.

			http://www.jlbec.org/
			jlbec@evilplan.org

