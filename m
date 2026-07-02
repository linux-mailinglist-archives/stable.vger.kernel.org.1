Return-Path: <stable+bounces-271546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m8A2BmnARmptcgsAu9opvQ
	(envelope-from <stable+bounces-271546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 21:47:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6158D6FC9B7
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 21:47:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IAL+2hjq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271546-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271546-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 621EF3012C68
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8638D69D;
	Thu,  2 Jul 2026 19:45:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38D377011;
	Thu,  2 Jul 2026 19:45:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021525; cv=none; b=TwjZe/zSR6wmCjVkMeXhsuiPnHOkZ97eQ/d6kA/qgwI6tGQidysaI2NK0bvX26YxVgnkhnv0pkLShRRqvREHhNIRP7TaI0bIKH1A38M5jwwA9dKlIZ1KZeU79nsYQed4FKKOXta7t4Jws6YoC2d4/0Lxus1D8/YurbBjtzjmn6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021525; c=relaxed/simple;
	bh=MK98eyvoU4UVZDQ5olNRQsSzAqr0SVQmMtuCJGJsVIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAEXEfoUQ5bq+/86wqjJBkPV5VSOH58BUX+fiaJUy7Dy2P7QANNdmBy1XuWcG7Kb78PauKACS0+54SYRcgL11xknwe3hVejwUBKWcGa6H8EUqPKEt73KNCgyQYDlpa15C+wSdhn/O+m6bm2jzK9bIPRzFh55LmIyyTLNatK24s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAL+2hjq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2F9211F000E9;
	Thu,  2 Jul 2026 19:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783021524;
	bh=POh+Wql+aYKKiGqM4xe1lIjHUx8Pi9xF9P2QyxnFKcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IAL+2hjqn8S7dSl5iegWovAvf/Rhbm06s2JC9lOxz+gvNnB9UdYwMCv7x0EYQfwEW
	 QJLLJmlsjBn6Gnd9+0ccFaxN9I2yAIxFJT+qxgiX97hIEFrvdTRPESogoGNCLUYTN5
	 oBmrT0uvaKJ7hmv5UTKiSDrQn9BJg+12KJwq5sgJiNQ1U+sCsq5dkIVW77ILPMwISr
	 8e9BkaJaqZRyeCx5P1KyzDM98nvcyn9WzEis0F9zUR86aKBnc6DryxaLiv2x02Ey3F
	 w25pKj5OlI/70VeA2JHYFCS/LdzSdvA/cc8zYglmmnyfSJ7uaeij/w/oAhknz1cBF/
	 ocLnveDvmchKA==
Date: Thu, 2 Jul 2026 12:45:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] xfs: fail recovery on a committed log item with no
 regions
Message-ID: <20260702194523.GO9392@frogsfrogsfrogs>
References: <20260702162000.3548359-1-bestswngs@gmail.com>
 <20260702162000.3548359-4-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702162000.3548359-4-bestswngs@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:linux-xfs@vger.kernel.org,m:cem@kernel.org,m:bfoster@redhat.com,m:hch@infradead.org,m:xmei5@asu.edu,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271546-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[frogsfrogsfrogs:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6158D6FC9B7

On Thu, Jul 02, 2026 at 09:20:00AM -0700, Weiming Shi wrote:
> If the first op of a transaction is a bare transaction header
> (len == sizeof(struct xfs_trans_header)), xlog_recover_add_to_trans()
> adds an item but no region, leaving it on r_itemq with ri_cnt == 0 and
> ri_buf == NULL.
> 
> The header can be split across op records, so later ops may still add
> regions; the item is only invalid if the transaction commits with none.
> The runtime commit path never emits such a transaction, so this only
> happens on a crafted log.  It came from an AI-assisted code audit of the
> recovery parser.
> 
> xlog_recover_reorder_trans() calls ITEM_TYPE() on the item, which reads
> *(unsigned short *)item->ri_buf[0].iov_base and faults on the NULL
> ri_buf.  Reject it there, before the commit handlers that also read
> ri_buf[0].
> 
>  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>  RIP: 0010:xlog_recover_reorder_trans (fs/xfs/xfs_log_recover.c:1836)
>   xlog_recover_commit_trans (fs/xfs/xfs_log_recover.c:2043)
>   xlog_recover_process_data (fs/xfs/xfs_log_recover.c:2501)
>   xlog_do_recovery_pass (fs/xfs/xfs_log_recover.c:3244)
>   xlog_recover (fs/xfs/xfs_log_recover.c:3493)
>   xfs_log_mount (fs/xfs/xfs_log.c:618)
>   xfs_mountfs (fs/xfs/xfs_mount.c:1034)
>   xfs_fs_fill_super (fs/xfs/xfs_super.c:1938)
>   vfs_get_tree (fs/super.c:1695)
>   path_mount (fs/namespace.c:4161)
>   __x64_sys_mount (fs/namespace.c:4367)
> 
> Fixes: 89cebc847729 ("xfs: validate transaction header length on log recovery")
> Cc: <stable@vger.kernel.org> # v4.3
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Good catch!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_log_recover.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index 103b2a79667b..fdb011e6ef60 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -1907,6 +1907,15 @@ xlog_recover_reorder_trans(
>  	list_for_each_entry_safe(item, n, &sort_list, ri_list) {
>  		enum xlog_recover_reorder	fate = XLOG_REORDER_ITEM_LIST;
>  
> +		/* a committed item with no regions has a NULL ri_buf[0] */
> +		if (!item->ri_cnt || !item->ri_buf) {
> +			xfs_warn(log->l_mp,
> +				"%s: committed log item has no regions",
> +				__func__);
> +			error = -EFSCORRUPTED;
> +			break;
> +		}
> +
>  		item->ri_ops = xlog_find_item_ops(item);
>  		if (!item->ri_ops) {
>  			xfs_warn(log->l_mp,
> -- 
> 2.43.0
> 
> 

