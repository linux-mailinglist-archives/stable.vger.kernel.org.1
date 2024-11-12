Return-Path: <stable+bounces-92846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252A49C6392
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 22:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CBD28501A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F5C21A4AD;
	Tue, 12 Nov 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjP5qwzq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418EB204930;
	Tue, 12 Nov 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447571; cv=none; b=Uxwv+pvjWqpHsCleucZnkZEfw7rt41V7F2DGRn4iEA48lnQDnLGxdjHgpWYdKU17WqfGqzXhua/xLpyW1mNPwKbITNH+BMbjwXBUpL+pA4jQsgEUp/TLIY7R3vQG0wI98AssK53HebanP3TyCe4eMWq79erfLUSrrq7GHwXNq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447571; c=relaxed/simple;
	bh=9pk1AsME6rZGiOxewMrICrzKTyHvu3xjCllKNiqeHVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT5Wj1jyY8hKpr4hYkI5/3j13rJdJd2dYrbVFvBF5jZiXXDjQHse5Ct07XV3hmxTZQLm/oIPVp2gCE7+GD8gb6sdrzIO7srNpD/XAVzG1P8gR2ooKEqa4L/I3WCmF9WBO4Kft8x10zO4Rfh91MTz0odm7+3hb+OZUPsx6qCvLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjP5qwzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9302CC4CECD;
	Tue, 12 Nov 2024 21:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731447570;
	bh=9pk1AsME6rZGiOxewMrICrzKTyHvu3xjCllKNiqeHVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjP5qwzqavKkOvy0mCyR8hsndiZ4/WlOLOngrc8Z0VDnOAruNdaL9uE8I8ElrRksZ
	 iR6EUBppMV1CT1Qfq79vftI8TJjSGPSXGmktKjCVkkdaRv2mMkNuSAq1n4ox8VHSBZ
	 xZfXOyRcXXc8Yp4zq8UdH0xyB4G5gFtnkxts7BrjGmWCAJDyKbbkN9gtuDghFtav5L
	 viyEOfg2IfemHHwl+iFtnZ2p4bgrMtxTO6KRBt8EajPqpITC01dOukTN9IuIDYWNGk
	 Dy380jDeR3T4MFPD8od+bCk1oUIfFpQN8MR6oaCSfEgsl3PMcaFvR7b70ktDAnrt92
	 Q4x21nhRoKSuw==
Date: Tue, 12 Nov 2024 21:39:28 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
	Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH] Revert "f2fs: remove unreachable lazytime mount option
 parsing"
Message-ID: <ZzPLELITeOeBsYdi@google.com>
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112010820.2788822-1-jaegeuk@kernel.org>

Hi Eric,

Could you please check this revert as it breaks the mount()?
It seems F2FS needs to implement new mount support.

Thanks,

On 11/12, Jaegeuk Kim wrote:
> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
> 
> The above commit broke the lazytime mount, given
> 
> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
> 
> CC: stable@vger.kernel.org # 6.11+
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 49519439b770..35c4394e4fc6 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -150,6 +150,8 @@ enum {
>  	Opt_mode,
>  	Opt_fault_injection,
>  	Opt_fault_type,
> +	Opt_lazytime,
> +	Opt_nolazytime,
>  	Opt_quota,
>  	Opt_noquota,
>  	Opt_usrquota,
> @@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
>  	{Opt_mode, "mode=%s"},
>  	{Opt_fault_injection, "fault_injection=%u"},
>  	{Opt_fault_type, "fault_type=%u"},
> +	{Opt_lazytime, "lazytime"},
> +	{Opt_nolazytime, "nolazytime"},
>  	{Opt_quota, "quota"},
>  	{Opt_noquota, "noquota"},
>  	{Opt_usrquota, "usrquota"},
> @@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			f2fs_info(sbi, "fault_type options not supported");
>  			break;
>  #endif
> +		case Opt_lazytime:
> +			sb->s_flags |= SB_LAZYTIME;
> +			break;
> +		case Opt_nolazytime:
> +			sb->s_flags &= ~SB_LAZYTIME;
> +			break;
>  #ifdef CONFIG_QUOTA
>  		case Opt_quota:
>  		case Opt_usrquota:
> -- 
> 2.47.0.277.g8800431eea-goog

