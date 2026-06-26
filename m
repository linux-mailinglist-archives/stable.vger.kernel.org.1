Return-Path: <stable+bounces-268950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9fcvKhyTPmo+IQkAu9opvQ
	(envelope-from <stable+bounces-268950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:56:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CF96CE330
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:56:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CeqLjBBX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268950-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268950-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3E4330DFD44
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2503F9F5C;
	Fri, 26 Jun 2026 14:49:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59043FD957;
	Fri, 26 Jun 2026 14:49:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485378; cv=none; b=sa02FQiztMTUXEBCv7qo8w6PilO4kDOcmTSDUg57AzUh2e/K3lco+VjNX2pN9QwVQwYasYPXCDWI+OtDmg6lk8auB4ZZ4enRv1c4Czp4+A7+ax1HmmsdmBn0qGopsjJMcVG2pZQ+UCaCquCbqALnEzV/3LI4XoOtcGZGhdjX/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485378; c=relaxed/simple;
	bh=6kIyebAgV73GN7L9ghWv6l7o8Ekv63QDtQwCnKoxTl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4BRHUk3FyGdyaa9h7PysKSdlVT+Zc5HGpWLxQpnL4qcDAlOK6aZzdynLMv36EKQ/5h9UNmd4tj+iD68nE9aMwMYEwfL7jZHAvpAV26AHNFVQRnVK/tHdlHAKxHgQ8Bt+DR/WSJh5C1zfEz5Msex2opHIk/APvt3OMj4mOk/WrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeqLjBBX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F02561F00A3A;
	Fri, 26 Jun 2026 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485375;
	bh=k4x2V1Ce5QbMnxtO7thGJ+kYlbTzfX1T4ut1+O2edcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CeqLjBBXu2zTHHPJmy6hUE+J1HS1rFbndjTE4Xb4fAVDdWsyxmSPAApqg7QV8THiJ
	 3EwKdppFbnpgD1C05FsXmUmDNB0ZnPFCJpRtWCXAXc5zbGHzB1Ooyi20dj/sG1yzEG
	 Yj6Tejlum7U+LAGVo9QZRDbg9AK/7CyjaHaxNqCOGeQ3a/5aO3VTT/L7UQoMBUkmfi
	 n4jSrpslznVawccyvVWlmHqbtlzUB3uR1GIFW52cLFa1TlhzENA8mJg/SNi3zK4Pya
	 Sy36YY6y4bO2MrHCFG4S9eZ89+Rmd1lXeB1yy5K2lYFsWSeNfG/zy2/cpEqRnHdlJH
	 ThZB3fZIvmycw==
Date: Fri, 26 Jun 2026 07:49:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org, stable@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Subject: Re: [PATCH 1/2] xfs: fix capabily check in xfs
Message-ID: <20260626144934.GR6078@frogsfrogsfrogs>
References: <20260626102934.57834-1-cem@kernel.org>
 <20260626102934.57834-2-cem@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626102934.57834-2-cem@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:stable@vger.kernel.org,m:sandeen@redhat.com,m:hch@lst.de,m:jack@suse.cz,m:david@fromorbit.com,m:thomas.orgis@uni-hamburg.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268950-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,lst.de:email,frogsfrogsfrogs:mid,uni-hamburg.de:email,fromorbit.com:email,suse.cz:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44CF96CE330

Note: s/capabily/capability/ in the subject line

On Fri, Jun 26, 2026 at 12:29:24PM +0200, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> An user reported a bug where he managed to evade group's quota
> by changing a file's gid to a different group id the same user
> belonged to, even though quotas were enforced on both gids and the
> file's size was big enough to exceed the quota's hardlimit.
> 
> Commit eba0549bc7d1 replaced a capable() call by a
> has_capability_noaudit() to prevent unnecessary selinux audit messages.
> Turns out that both calls have slightly different semantics even though
> their documentation seems similar. Where in a nutshell:
> 
> capable() - Tests the task's effective credentials
> has_ns_capability_noaudit() - Tests the task's real credentials
> 
> This most of the time has no practical difference but in some cases like
> changing attrs (specifically group id in this case) through a NFS client
> this will allow the quota code to use XFS_QMOPT_FORCE_RES, effectively
> bypassing quota accounting checks.
> 
> Using instead ns_capable_noaudit() should fix this issue and prevent
> selinux audit messages.
> 
> This also fix the remaining calls to has_capability_noaudit()
> 
> Fixes: eba0549bc7d1 ("xfs: don't generate selinux audit messages for capability testing")
> Cc: <stable@vger.kernel.org> # v5.18
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Eric Sandeen <sandeen@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dave Chinner <david@fromorbit.com>
> Reported-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  fs/xfs/xfs_fsmap.c | 2 +-
>  fs/xfs/xfs_ioctl.c | 2 +-
>  fs/xfs/xfs_iops.c  | 3 ++-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
> index b6a3bc9f143c..7c79fbe0a74c 100644
> --- a/fs/xfs/xfs_fsmap.c
> +++ b/fs/xfs/xfs_fsmap.c
> @@ -1175,7 +1175,7 @@ xfs_getfsmap(
>  		return -EINVAL;
>  
>  	use_rmap = xfs_has_rmapbt(mp) &&
> -		   has_capability_noaudit(current, CAP_SYS_ADMIN);
> +		   ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
>  	head->fmh_entries = 0;
>  
>  	/* Set up our device handlers. */
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 96af6b62ce39..852ff2ab4531 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -647,7 +647,7 @@ xfs_ioctl_setattr_get_trans(
>  		goto out_error;
>  
>  	error = xfs_trans_alloc_ichange(ip, NULL, NULL, pdqp,
> -			has_capability_noaudit(current, CAP_FOWNER), &tp);
> +			ns_capable_noaudit(&init_user_ns, CAP_FOWNER), &tp);
>  	if (error)
>  		goto out_error;
>  
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 325c2200c501..9db9ef1d8c3a 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -835,7 +835,8 @@ xfs_setattr_nonsize(
>  	}
>  
>  	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> -			has_capability_noaudit(current, CAP_FOWNER), &tp);
> +				ns_capable_noaudit(&init_user_ns, CAP_FOWNER),
> +				&tp);

Extra indenting of the second and third lines, but otherwise this looks
good to me.  With the indent fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


>  	if (error)
>  		goto out_dqrele;
>  
> -- 
> 2.54.0
> 
> 

