Return-Path: <stable+bounces-240327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIebAVTA6Gm9PwIAu9opvQ
	(envelope-from <stable+bounces-240327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:34:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D647446032
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 486DF300AD51
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B693D47A5;
	Wed, 22 Apr 2026 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9/2LPbZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8BF3D1CA5
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861196; cv=none; b=k1Ofuo3uO1+/C33XJjzwVZ5yoxkcS/IIY0WqDnE/KllYo7+tL7HEYiGVNJtyUGXoU2QohRjcup+Jd3Bj3w/Qh8W7mw3eiJd8qR4HhIXw0KYwrbpI4zuYgHAxLTJPB/74gjo4G9i2iHokHMCc+rdCl/sLEhg1FUdgso+lB1LEy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861196; c=relaxed/simple;
	bh=nAmz0+PBMwNgKBUFmaghqo3euw/h0X0sfmkZygrD+i4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=COasWmPFeBiGMFIKBG9qKJKBo4kOYp+8cGa97TRQIech8H6CbIO97m4fczRqOcTZXzD6lYB0wp5E8wZa/KROQoQ6K1oOREdMiiMOrac5AkXMOVjYj/wE8vhbv1RYhRQWYjymxHg80/LTo1P3d0IbafOic4AxLXFuWYywGbdUVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9/2LPbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9532FC19425;
	Wed, 22 Apr 2026 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776861195;
	bh=nAmz0+PBMwNgKBUFmaghqo3euw/h0X0sfmkZygrD+i4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=P9/2LPbZbfT/8L6QzXNbzeExQRTL679uwLhCbBBq+yogiVXzXnJD0b0hrzsFsYLWk
	 DSM9FOkF0JvSRY8OzPB414+vIGUTe921c2VjZJgRvBMyjjTUuSc6LAdvI4+vNlhnFW
	 WCuK/9YFg5pO/q5CP+Nqil7SOhITePR+pbynBfzuR8czs0zHUtzOtLxR2SFPOthizr
	 OVU8kbA3B/MUEHEJCxB09Km7ojvVcop0yFXJ+IQTPDX84HX9PNaeoFpSX8teaPJHvz
	 3ovKpjFXjMnayPee7aaKYZKLacT4133+kHHilMUHl3aPIhJHjyQU+f4iu/9TWeGGQI
	 jbx1RLuCUcl6A==
Message-ID: <206a897a-2860-40b5-bbb8-829954d7e568@kernel.org>
Date: Wed, 22 Apr 2026 20:33:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Yongpeng Yang <yangyongpeng@xiaomi.com>, stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix incorrect FI_NO_EXTENT handling in
 __destroy_extent_node()
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260422073525.2063784-2-monty_pavel@sina.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260422073525.2063784-2-monty_pavel@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240327-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D647446032
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/2026 3:35 PM, Yongpeng Yang wrote:
> From: yangyongpeng <yangyongpeng@xiaomi.com>
> 
> When __destroy_extent_node() sets the inode flag FI_NO_EXTENT, it does
> not reset the length of the largest extent to 0 and update the inode
> folio. Since modifications to the extent tree are disallowed afterward,
> the cached largest extent may become stale. This can trigger the
> following error in xfstests generic/388:
> 
> F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent info [220057, 57, 6] is incorrect, run fsck to fix
> 
> In the f2fs_drop_inode path, __destroy_extent_node() does not need to
> guarantee that et->node_cnt is 0, because concurrency with writeback
> is expected in this path, and writeback may update the extent cache.
> 
> This patch updates __destroy_extent_node() to avoid setting the inode
> flag FI_NO_EXTENT, and to remove the check zero of et->node_cnt.
> 
> Fixes: ed78aeebef05 ("f2fs: fix node_cnt race between extent node destroy and writeback")
> Cc: stable@vger.kernel.org
> Reported-by: Chao Yu <chao@kernel.org>
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: yangyongpeng <yangyongpeng@xiaomi.com>
> ---
>   fs/f2fs/extent_cache.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 87169fd29d89..3adbead27953 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -645,14 +645,10 @@ static unsigned int __destroy_extent_node(struct inode *inode,
>   
>   	while (atomic_read(&et->node_cnt)) {
>   		write_lock(&et->lock);
> -		if (!is_inode_flag_set(inode, FI_NO_EXTENT))
> -			set_inode_flag(inode, FI_NO_EXTENT);

We'd better revert all change lines in "f2fs: fix node_cnt race between
extent node destroy and writeback"?

Thanks,

>   		node_cnt += __free_extent_tree(sbi, et, nr_shrink);
>   		write_unlock(&et->lock);
>   	}
>   
> -	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
> -
>   	return node_cnt;
>   }
>   


