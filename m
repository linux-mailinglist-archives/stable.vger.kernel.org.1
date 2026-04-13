Return-Path: <stable+bounces-235991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHc3CXbS3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:24:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0133EB41C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4E42300620D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54583AEF57;
	Mon, 13 Apr 2026 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLmmS7C+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791AC318EE7
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079428; cv=none; b=beFkmCcp7unpTTADaQrU0PK17JszkGOwXLJ4fhaH6PI5BXWlvFmEH46a2MBoXpb3clqPp1BIBRjMkCvFvSiM9tZkRY8Qzr1bOBn2kvcC+TsSHlBQf63bFwTYupzHNGyMahqMJ/Cq4aeuDj74LJ7+rY4ny99nir1iNSH2iiiu3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079428; c=relaxed/simple;
	bh=k40RQpCwrRnxHC9qiekndDrsWXyZfL6OGK0uWcAp7nY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O8th+X5om49sngN2XYFLTmRUCoBzxQnY/6n33KHVmEyQBQGeO5jcszjt2r4c6fM5NmZjNHQMlmRgIrG5CFCb4cLlgf2j3QM7UAx7KmthJZHUWkFBlM3+emlZyzN0woU1DzsOdXRvhmj8Hi/Vwa+Y8vYb73uEdXnLJ3PxVThdk08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLmmS7C+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CACC116C6;
	Mon, 13 Apr 2026 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776079428;
	bh=k40RQpCwrRnxHC9qiekndDrsWXyZfL6OGK0uWcAp7nY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kLmmS7C+SJFkpsO+zZwo6ATHMA7FZmICdvEcxpGL/R7FnnDi0q9GIFTm1USZ+CU9A
	 Vizt/6w+py10hbKAXuOvr5avS4etS48UMTiIjIt6PonNs1199JcNKQoefbPLHgMLZQ
	 73YR2YZTcZSDk18aBNH2HPmhIVhxr7eaJt++k90zTy8ZOy3zL7/i2wduLFOkaHkPgu
	 rCp8+EwwD84kl2jXCsJXWVMdgD5Z3p9Zbi8wI6f5LQmA4CQJFry1u66EYUs/xH2hsV
	 GEZ65vSp8Jww+RsBSpQ3VdS40jOxSPPb3zpFTAh3iALelfNBybBOVFVHCRQHm4qmPw
	 c8Ix6ktztqp3w==
Message-ID: <6e33b6f1-7d05-4edd-87f9-28a2a98a6b27@kernel.org>
Date: Mon, 13 Apr 2026 19:23:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Yongpeng Yang <yangyongpeng@xiaomi.com>, stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix node_cnt race between extent node destroy and
 writeback
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260403144015.221811-3-monty_pavel@sina.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260403144015.221811-3-monty_pavel@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235991-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A0133EB41C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/2026 10:40 PM, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> f2fs_destroy_extent_node() does not set FI_NO_EXTENT before clearing
> extent nodes. When called from f2fs_drop_inode() with I_SYNC set,
> concurrent kworker writeback can insert new extent nodes into the same
> extent tree, racing with the destroy and triggering f2fs_bug_on() in
> __destroy_extent_node(). The scenario is as follows:
> 
> drop inode                            writeback
>   - iput
>    - f2fs_drop_inode  // I_SYNC set
>     - f2fs_destroy_extent_node
>      - __destroy_extent_node
>       - while (node_cnt) {
>          write_lock(&et->lock)
>          __free_extent_tree
>          write_unlock(&et->lock)
>                                         - __writeback_single_inode
>                                          - f2fs_outplace_write_data
>                                           - f2fs_update_read_extent_cache
>                                            - __update_extent_tree_range
>                                             // FI_NO_EXTENT not set,
>                                             // insert new extent node
>         } // node_cnt == 0, exit while
>       - f2fs_bug_on(node_cnt)  // node_cnt > 0
> 
> Additionally, __update_extent_tree_range() only checks FI_NO_EXTENT for
> EX_READ type, leaving EX_BLOCK_AGE updates completely unprotected.
> 
> This patch set FI_NO_EXTENT under et->lock in __destroy_extent_node(),
> consistent with other callers (__update_extent_tree_range and
> __drop_extent_tree) and check FI_NO_EXTENT for both EX_READ and
> EX_BLOCK_AGE tree.
> 
> Fixes: 3fc5d5a182f6 ("f2fs: fix to shrink read extent node in batches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

