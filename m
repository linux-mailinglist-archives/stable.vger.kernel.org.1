Return-Path: <stable+bounces-235427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP0HCz/C12mdSQgAu9opvQ
	(envelope-from <stable+bounces-235427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:14:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994873CC78B
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61BC8303D089
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870053DD524;
	Thu,  9 Apr 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="stCk0SUz"
X-Original-To: stable@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357B39023C;
	Thu,  9 Apr 2026 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747554; cv=none; b=Rlvt7KWVeEgK7qnPQOFlhz0s+SxvO9KPQkaj5VHeU9cXcCfI5OnlKdoBn6okrUEuPmoLpQrwjKuJYTzFIkKoqgVmsxtwNlgXFMd6yYoSwL5x0Kx30d5zLVvDhmUc02FKLJCs45zg7Js+TwCisCDQ6TWsEvn4IADeBoXiGfZzs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747554; c=relaxed/simple;
	bh=cHrYuJnSdlqjv4uCOURn0qikMJF0j2o572WqqnjfLF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpO/lJyQ1fdAHQtyUh7Fy0IrwyAQi8vuQUn2zAXMLnX4Ye3B/tGXreP3P4AX+2M79xBB8rDxcbwzayvx5tkM2LYg79ZMQIPQifQzPniRVhUc0jaXvXfKy0jKOLMJrJ+mEp9TvxEy/tvLwjEoq6hF+7GV9/NXWK0ajchTzjELYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=stCk0SUz; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=E/0WmzVvUfo3UoQbsOfZtNQ/Ap0A9abtgmiZFl4WGcY=; b=stCk0SUz6a7QoBzGagcU85+KQp
	7yk7axxjMiO7W8ylvzp8mBml5RG7QWaRs3eCP/18JRa+WLWdrY92BSkN0wsbgbwRXv651JcZog9iC
	lfR9NJ/87EJ2srCQBM35UDFOIlRR35RaFxNBYjzpThsATYiAxMbuPWvAjwkkfhOKnF3m+q/cf9vJa
	B4kkzgOgOP7nyB7QMy7OHJBPpdLDkGNoD7VQOPbENrBAzvCOmb73E/iOLsSyF/+107SRGnxvtJe0j
	pO3PISFlIWGH0z04cdtVwBab/fCFNtm6toIcFsUmFT0OQxEM/+d4w85toaULzcPwZ2REq15E22S5j
	RwGDUwWsVB/yR9/KMEcocuIaVksHMrnyw8QhnemzFQB8gQjJVnbXZZQT4AwE5Kv+Z94mwUItC3Drf
	dtGZPTW6CCL1StDWgsnDyqqB2vQnanbqPkiuW6elu04zSCj1UFMJPorwrJcahRRCw7CW0KTp0w117
	GEPYTNjsd9e9gofLq0/sNuoz+Lh6wsjp86jg+MJmUMTprfbraZ++2xjJCeHYq1JagFK8ILCpbXCsp
	tbn3IsfQjTo+S9OqJNDtj17jKKfJi9Usts/fSGJTJVcegO+Zq3jGs2KGu8YBgUZ6q08M8mV6A5tPu
	NvM+kfLmDWuxk2zTvJQXV5Mc+lFUnjoxm26GYuZgA=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 Pierre Barre <pierre@barre.sh>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, sandeen@redhat.com
Subject: Re: [PATCH] 9p: fix access mode flags being ORed instead of replaced
Date: Thu, 09 Apr 2026 16:51:07 +0200
Message-ID: <2406037.ElGaqSPkdT@weasel>
In-Reply-To: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
References: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235427-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,crudebyte.com:dkim,crudebyte.com:email]
X-Rspamd-Queue-Id: 994873CC78B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thursday, 2 April 2026 12:03:12 CEST Pierre Barre wrote:
> Since commit 1f3e4142c0eb ("9p: convert to the new mount API"),
> v9fs_apply_options() applies parsed mount flags with |= onto flags
> already set by v9fs_session_init(). For 9P2000.L, session_init sets
> V9FS_ACCESS_CLIENT as the default, so when the user mounts with
> "access=user", both bits end up set. Access mode checks compare
> against exact values, so having both bits set matches neither mode.
> 
> This causes v9fs_fid_lookup() to fall through to the default switch
> case, using INVALID_UID (nobody/65534) instead of current_fsuid()
> for all fid lookups. Root is then unable to chown or perform other
> privileged operations.
> 
> Fix by clearing the access mask before applying the user's choice.
> 
> Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
> Signed-off-by: Pierre Barre <pierre@barre.sh>
> ---
>  fs/9p/v9fs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 057487efaaeb..05a5e1c4df35 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -413,7 +413,11 @@ static void v9fs_apply_options(struct v9fs_session_info
> *v9ses, /*
>          * Note that we must |= flags here as session_init already
>          * set basic flags. This adds in flags from parsed options.
> +        * Access flags are mutually exclusive, so clear any access
> +        * bits set by session_init before applying the user's choice.

That phrase is a bit suboptimal, because V9FS_ACCESS_ANY is actually a bit
combination of single, user and client. But OK, I currently don't have a
better phrase for it since the access fields have to be replaced altogether.

As for the actual behaviour change; makes sense to me:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>          */
> +       if (ctx->session_opts.flags & V9FS_ACCESS_MASK)
> +               v9ses->flags &= ~V9FS_ACCESS_MASK;
>         v9ses->flags |= ctx->session_opts.flags;
>  #ifdef CONFIG_9P_FSCACHE
>         v9ses->cachetag = ctx->session_opts.cachetag;
> --
> 2.51.0





