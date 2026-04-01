Return-Path: <stable+bounces-232688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOJnO6SezGlFUgYAu9opvQ
	(envelope-from <stable+bounces-232688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:27:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2BF374A98
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A114B3031AE5
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 04:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CA0370D64;
	Wed,  1 Apr 2026 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqUgJzrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4A29992B;
	Wed,  1 Apr 2026 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017304; cv=none; b=MWUF5ZxLwOEA1jpoSrHBfVhFb8pkDUzWU0UKZrKJcmaQ0BkSvuLs5kNTc7F+GwDro6TGRoOXx6l6nTBpP2VQdypIwJvFh5Jx7e223irT+2TopRawMO9AXpKhXibGeDomhGovVkbeuI5IBut6Chlwfdfcn1m5CqO1m02oV9WP9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017304; c=relaxed/simple;
	bh=FIDbLrfbR6fUnlgjD/2v1iNHH75EA8hTJvGx3FtCy+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBhn/gMDVg3Pbu70iXSHh4+Vob7iMBPHJqGu3ikEJNtSorjnHVdBMDK9mHQREsf2GpTvG1ruG/012fBhlktVqIcEjlpcrjfHkkhUwI/nTXCk+tgPwFyCTQFI8moZOZWJkFFnugF6Dbv3sGGG4oxBtYYJc1efNajKbHHVkG+j7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqUgJzrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34633C4CEF7;
	Wed,  1 Apr 2026 04:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775017304;
	bh=FIDbLrfbR6fUnlgjD/2v1iNHH75EA8hTJvGx3FtCy+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqUgJzrKe3NRjw5Yuws6b+Ze88soHcExq5Zrbi/mw3U5ad40stuCm0oKPKM+nPO0n
	 q3DFlRnXWEd8TMMHetr+B4/9FNuCnPHm2P9szQ6XclwTcZCb53XhjXyy2+mwr0NmuV
	 lmAT8NhoFMBrZuNy+QUMtdiubNtMnJAGBobUQeUGQzQiyghAi5U9xB9pwV39CWD0WP
	 qlxCWFVP2DyGuBMWkorcNrTbsnfDtMuDHoBZ9+ozG315Nlt7VhuihJaSryr9WAfohe
	 CTlNlXIc0CDx1eQnFaXi/Uqr/dm2GLP+HGAM35qiCD1GBgcyOlwNy/OFeki0X0FYVg
	 SUFApz4oSwdaw==
Date: Tue, 31 Mar 2026 21:21:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: cem@kernel.org, ruansy.fnst@fujitsu.com, akpm@linux-foundation.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] xfs: fix a resource leak in xfs_alloc_buftarg()
Message-ID: <20260401042143.GR6254@frogsfrogsfrogs>
References: <20260401040241.560314-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401040241.560314-1-lihaoxiang@isrc.iscas.ac.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232688-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 4D2BF374A98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:02:41PM +0800, Haoxiang Li wrote:
> In the error path, call fs_put_dax() to drop the DAX
> device reference.
> 
> Fixes: 6f643c57d57c ("xfs: implement ->notify_failure() for XFS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Yep, that's definitely a leak...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_buf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 47edf3041631..1ca95ef46a73 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1831,6 +1831,7 @@ xfs_alloc_buftarg(
>  	return btp;
>  
>  error_free:
> +	fs_put_dax(btp->bt_daxdev, mp);
>  	kfree(btp);
>  	return ERR_PTR(error);
>  }
> -- 
> 2.25.1
> 

