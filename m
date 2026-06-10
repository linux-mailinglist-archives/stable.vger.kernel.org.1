Return-Path: <stable+bounces-262417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NQX6CXjvKGq1NwMAu9opvQ
	(envelope-from <stable+bounces-262417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 07:00:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0829665D3C
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 07:00:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dVDe2QeV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262417-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262417-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EA76305900D
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 05:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA012690D5;
	Wed, 10 Jun 2026 05:00:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8824A32;
	Wed, 10 Jun 2026 05:00:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781067633; cv=none; b=rAnBRNxBptUoPZaQ71ZA1l4tB4Yhrlj0018o5D0pvJF9yVb69eYEAouEULJdr9vKSDOg5Nbr2Nzm0Kf7nc9C4b1XR3eOwpvu9DBJc0ANwxtxqLuLoUvTD/OkPDQAIC4GpLIwFlHq8mEGpZkNm+zRjKuo9ZvZNX63yxuoiK8MBKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781067633; c=relaxed/simple;
	bh=KV3Gn+8cf7Pp+/wunO8+5tk/xzn9Na27+sBpnfgr03s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh6DvzlxewueVMtSwGTIr8yvFiBmQy+j6y9Iihs9kMF4X5OunpGQ/jUJDzCvTf6NEMp4w/S9N/3XG7WQF0cXAFnyR+P+PKUZiFcDK2lD3Ac0mxUGiwFyPiz4soSTpEM0h9Ij6vRisJMWN4xzD1Vn19S22tDoBaR4b3jZsC/eZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVDe2QeV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6CA031F00893;
	Wed, 10 Jun 2026 05:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781067632;
	bh=lUAvqflCpaW5B6Ldgvps0KJCZIBpBLVyYKw02shUYxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dVDe2QeVb+X2CsahXRI5DQjnvRyBjzTy4RId4J5RSE2QO2ZCl45Jw6sCN4+SAp1Th
	 q2eW4E/69XzZlIVfwLADu1Mek5CTDXfkeSpAtm58A6OHdyNnwg9FN1z+ZM4qGCclCO
	 IGSAc3uRVA/43dC5fDqfdaMXal+KSzy7xhQHeuVg67YCZV6WKLdBqUa7a/Dj4DgrWa
	 vjPS6WQC/rhrVfU1PKv4Dy0uwSw1n7a2A1CldEHF74JLw4ZwytmPdMV1UNdvb/7jDw
	 yQyvFF66XX1pfrkRQC6Qyj/DSqGSJBzcGMshPxLmnQS31dqE6Ph1gSVffGvxIIzm6I
	 VbIa+FUX1AW7w==
Date: Tue, 9 Jun 2026 22:00:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yingjie Gao <gaoyingjie@uniontech.com>
Cc: linux-xfs@vger.kernel.org, cem@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] xfs: fix inode ref leak in attr intent recovery
Message-ID: <20260610050032.GD6078@frogsfrogsfrogs>
References: <20260609111619.1866748-1-gaoyingjie@uniontech.com>
 <20260610022028.79846-1-gaoyingjie@uniontech.com>
 <20260610022028.79846-2-gaoyingjie@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610022028.79846-2-gaoyingjie@uniontech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gaoyingjie@uniontech.com,m:linux-xfs@vger.kernel.org,m:cem@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262417-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,uniontech.com:email,frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0829665D3C

On Wed, Jun 10, 2026 at 10:20:27AM +0800, Yingjie Gao wrote:
> xfs_attri_recover_work() grabs the target inode, attaches it to the
> reconstructed attr work item, and adds that work item to the defer
> pending list.
> 
> If xfs_attr_recover_work() fails to allocate the recovery transaction,
> it returns immediately without dropping the inode reference.  The later
> cancel path only frees the attr work item state, so the inode reference
> leaks.
> 
> Send the failure through the existing cleanup path so the inode
> reference is dropped before the function returns the error.
> 
> Fixes: e70fb328d527 ("xfs: recreate work items when recovering intent items")
> Cc: <stable@vger.kernel.org> # v6.8
> Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>

Looks good,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_attr_item.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
> index deab14f31b38..841838bc1d0f 100644
> --- a/fs/xfs/xfs_attr_item.c
> +++ b/fs/xfs/xfs_attr_item.c
> @@ -774,7 +774,7 @@ xfs_attr_recover_work(
>  	resv = xlog_recover_resv(&resv);
>  	error = xfs_trans_alloc(mp, &resv, total, 0, XFS_TRANS_RESERVE, &tp);
>  	if (error)
> -		return error;
> +		goto out_rele;
>  	args->trans = tp;
>  
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> @@ -791,6 +791,7 @@ xfs_attr_recover_work(
>  	error = xfs_defer_ops_capture_and_commit(tp, capture_list);
>  out_unlock:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +out_rele:
>  	xfs_irele(ip);
>  	return error;
>  out_cancel:
> -- 
> 2.20.1
> 
> 

