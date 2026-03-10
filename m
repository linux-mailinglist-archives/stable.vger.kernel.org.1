Return-Path: <stable+bounces-224578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OmGK8CHsGlpkQIAu9opvQ
	(envelope-from <stable+bounces-224578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:06:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB51258173
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0B81301303B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707B35AC07;
	Tue, 10 Mar 2026 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDMaOSBU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A131AAAA
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176764; cv=none; b=X0LTEab+0ugcsy4nWVkDW5kCLq1Sl1K3U0/1o0uaAzy8LP03FN8KMGFFN6SfbPS1YgTygW0x3oDgiwgLuFaVo/TWN+Acv2zkdqsog2eucvSQ58GJDTTXHoeJMGdx6raNDQY7ioH5tuN1geEsuk/v380/kqFzJsAmv/crP3Czszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176764; c=relaxed/simple;
	bh=JIrgtQkSf8zhty1TZ8k8oXWYwByV+1eg+nmYxdIfThU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gftZyR3iWRT1sx4cGFsmBY9NVVfjtTUgDVdOmJpT/1sKfLdId/dAQI6NM0EosXCS30kFyOPsAQfntMFMjZLvU7PO6YeHeVnL/MX+1wcAAO7QKCKD8h3pZj9ZDi2d5jIGq2eYkmiseLifnQt7+1JZiaOhpryn+VkUHFz0olOTpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDMaOSBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97851C19423;
	Tue, 10 Mar 2026 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773176763;
	bh=JIrgtQkSf8zhty1TZ8k8oXWYwByV+1eg+nmYxdIfThU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDMaOSBUnWjpblfF8GxbQEsL0ITMNsbs43VM0WG41TNsB9p4qp/F0SQgPidNNZ8cV
	 tVq+5ZaF2oOx0lx6EG9e+yAACasOIaf5jJGcKkEuz0Y1yYeRwD1I7f3tRpt+Q6mXoi
	 Bixd2tCI+DYE08FLO/LQ4vxCtMe8EvD+apWAM8s5TV50FonYIwwCeVuUG9qMoJ1xjF
	 L9ULi+US/xfvu2ny+H9cmr9CrIbcoJYWaBq/hemhTzIxAKOwoTMshZAQ+nL9f6JLJ1
	 SirKgbM13IwNW4uAbXz7Emcb8FwNwvYjSNCIZe4bBmSJG+v5t3Wj23BjKqsYiys/R/
	 +UcCSVgPzDmpQ==
Date: Tue, 10 Mar 2026 14:06:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Ethan Tidmore <ethantidmore06@gmail.com>,
	"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.12.y] xfs: Fix error pointer dereference
Message-ID: <20260310210603.GA6023@frogsfrogsfrogs>
References: <2026030917-lagged-volumes-b38a@gregkh>
 <20260309134955.1022573-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309134955.1022573-1-sashal@kernel.org>
X-Rspamd-Queue-Id: EFB51258173
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224578-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:49:55AM -0400, Sasha Levin wrote:
> From: Ethan Tidmore <ethantidmore06@gmail.com>
> 
> [ Upstream commit cddfa648f1ab99e30e91455be19cd5ade26338c2 ]
> 
> The function try_lookup_noperm() can return an error pointer and is not
> checked for one.
> 
> Add checks for error pointer in xrep_adoption_check_dcache() and
> xrep_adoption_zap_dcache().
> 
> Detected by Smatch:
> fs/xfs/scrub/orphanage.c:449 xrep_adoption_check_dcache() error:
> 'd_child' dereferencing possible ERR_PTR()
> 
> fs/xfs/scrub/orphanage.c:485 xrep_adoption_zap_dcache() error:
> 'd_child' dereferencing possible ERR_PTR()
> 
> Fixes: 73597e3e42b4 ("xfs: ensure dentry consistency when the orphanage adopts a file")
> Cc: stable@vger.kernel.org # v6.16
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Signed-off-by: Carlos Maiolino <cem@kernel.org>
> [ adapted try_lookup_noperm() calls to d_hash_and_lookup() ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Backport looks good to me,
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/scrub/orphanage.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index 7148d8362db83..46171f61eda43 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -443,6 +443,11 @@ xrep_adoption_check_dcache(
>  		return 0;
>  
>  	d_child = d_hash_and_lookup(d_orphanage, &qname);
> +	if (IS_ERR(d_child)) {
> +		dput(d_orphanage);
> +		return PTR_ERR(d_child);
> +	}
> +
>  	if (d_child) {
>  		trace_xrep_adoption_check_child(sc->mp, d_child);
>  
> @@ -480,7 +485,7 @@ xrep_adoption_zap_dcache(
>  		return;
>  
>  	d_child = d_hash_and_lookup(d_orphanage, &qname);
> -	while (d_child != NULL) {
> +	while (!IS_ERR_OR_NULL(d_child)) {
>  		trace_xrep_adoption_invalidate_child(sc->mp, d_child);
>  
>  		ASSERT(d_is_negative(d_child));
> -- 
> 2.51.0
> 

