Return-Path: <stable+bounces-224575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJGCOJiBsGmwjwIAu9opvQ
	(envelope-from <stable+bounces-224575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:39:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45863257F54
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0D2830FA327
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4D3D5677;
	Tue, 10 Mar 2026 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnZgSk7/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53D93CA487;
	Tue, 10 Mar 2026 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175185; cv=none; b=qE3yOgaHdJTYDkgggikfXwFgM68TFpyUVS1h61uLnN5CAWlmpr3tQaxoxuuYlKiYZ32wdp4MXAuqy49H1sqHzPrJPk2n4p7SIt7FsdbdXOFzfGQ3SLDicVgcYsOjL7jzafEhbT40756vGYkAp4KhnMPaj/JCIQnUy6MDkhZoB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175185; c=relaxed/simple;
	bh=lt1/kxTCNg5v0pkAV3T5RZBbwlgFYhCBNmjK4LavN8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4NFSwE3pMb78KkjQKYz6pMFJmHNfkIRc9dqSE2qjnXTW/pGO0sqkq4a5NlntvcKTfKuBoFBE23s4rmgUxfNJPx5CQvSeqjTxgVnX/4dr+pvPB2LkbsOiYJMNWDFcUphRaKHibFcf09ixNP6rtkhW+emvv8MUWHz3dhz+KHlTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnZgSk7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4DBC19423;
	Tue, 10 Mar 2026 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773175185;
	bh=lt1/kxTCNg5v0pkAV3T5RZBbwlgFYhCBNmjK4LavN8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnZgSk7/fvXTT1Sm6fsvYQ/KJyrZHRcrpBBAa+72nZiTT2VLRSAtCytOJvAm3USqh
	 BGe18+B8a+yMVvpNeidjef9g618170K5eSaFlaV3NZaleSrcZq4SpC5+OwmMhiId6W
	 FFsxCwXBz7ZSSnEZHyffwTXNVILudTC+3kJOdQB1oKmH+gSD3kHggIlor9ztSItzgC
	 NHf5jsiIxMvrfgQul977mci+dcVGVJjM5/4jVqCQMYPvfrNeSQAjoQM2y1SS58HFs+
	 GzmO8jXUvoR9gM3PTiBTi8lvvwUImuotdpaBgHb+NYtJX6WWwzogUut5/c0yj6dmSY
	 THqAfjo1Ll42w==
Date: Tue, 10 Mar 2026 13:39:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Carlos Maiolino <cem@kernel.org>, Dave Chinner <dchinner@redhat.com>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/4] xfs: stop reclaim before pushing AIL during
 unmount
Message-ID: <20260310203944.GV1105363@frogsfrogsfrogs>
References: <20260310183835.89827-6-ytohnuki@amazon.com>
 <20260310183835.89827-7-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310183835.89827-7-ytohnuki@amazon.com>
X-Rspamd-Queue-Id: 45863257F54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224575-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,652af2b3c5569c4ab63c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 06:38:37PM +0000, Yuto Ohnuki wrote:
> The unmount sequence in xfs_unmount_flush_inodes() pushed the AIL while
> background reclaim and inodegc are still running. This is broken
> independently of any use-after-free issues - background reclaim and
> inodegc should not be running while the AIL is being pushed during
> unmount, as inodegc can dirty and insert inodes into the AIL during the
> flush, and background reclaim can race to abort and free dirty inodes.
> 
> Reorder xfs_unmount_flush_inodes() to stop inodegc and cancel background
> reclaim before pushing the AIL. Stop inodegc before cancelling
> m_reclaim_work because the inodegc worker can re-queue m_reclaim_work
> via xfs_inodegc_set_reclaimable.
> 
> Reported-by: syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=652af2b3c5569c4ab63c
> Fixes: 90c60e164012 ("xfs: xfs_iflush() is no longer necessary")
> Cc: <stable@vger.kernel.org> # v5.9
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>

Looks good now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_mount.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 9c295abd0a0a..ef1ea8a1238c 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -608,8 +608,9 @@ xfs_unmount_check(
>   * have been retrying in the background.  This will prevent never-ending
>   * retries in AIL pushing from hanging the unmount.
>   *
> - * Finally, we can push the AIL to clean all the remaining dirty objects, then
> - * reclaim the remaining inodes that are still in memory at this point in time.
> + * Stop inodegc and background reclaim before pushing the AIL so that they
> + * are not running while the AIL is being flushed. Then push the AIL to
> + * clean all the remaining dirty objects and reclaim the remaining inodes.
>   */
>  static void
>  xfs_unmount_flush_inodes(
> @@ -621,9 +622,9 @@ xfs_unmount_flush_inodes(
>  
>  	xfs_set_unmounting(mp);
>  
> -	xfs_ail_push_all_sync(mp->m_ail);
>  	xfs_inodegc_stop(mp);
>  	cancel_delayed_work_sync(&mp->m_reclaim_work);
> +	xfs_ail_push_all_sync(mp->m_ail);
>  	xfs_reclaim_inodes(mp);
>  	xfs_health_unmount(mp);
>  	xfs_healthmon_unmount(mp);
> -- 
> 2.50.1
> 
> 
> 
> 
> Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284
> 
> Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705
> 
> 
> 
> 

