Return-Path: <stable+bounces-238466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDPRCEP44Wn50AAAu9opvQ
	(envelope-from <stable+bounces-238466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:07:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B731419132
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7DD3216ADB
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB3374E60;
	Fri, 17 Apr 2026 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK5wESFm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633C1F427C
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416426; cv=none; b=Lo6WBuEfoHfaHrw5qIUvxkj6Pb2m+Ashb5nGs3x65UgKqrEJi66gId3hg9q9eMmKmfjgE6yzmtgokdk/2AOxJ09NTs4zjwjAV+mvr9RYKRAjZQSALs36tSNAwJZX0cwtMud95nTrGx3x/f4viUpvTqmhUPoqPTCnZR/DN2N8uPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416426; c=relaxed/simple;
	bh=BLAt2TF7xaEkO6haokGj/M1AbfbptHHhunHMjI+FzF8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u9zYjzCVcq6f+3/yqrDjjtabn2THX5vaawFMTaQ1RR5xThAZUukht6qzoHw2WX4C/rqD+QIVT9PaygFTl5dC5h5mTpGRdPh6z5H87lbPcKh1gBHLnspNTessSjMobB7LlCrw3qbsL8diA/6oHaZ5z3Dqdh3anEvHds2CLXy1Hz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK5wESFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31100C2BCB4;
	Fri, 17 Apr 2026 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776416426;
	bh=BLAt2TF7xaEkO6haokGj/M1AbfbptHHhunHMjI+FzF8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TK5wESFmUIWzcGe5ZgxgMILX5pC7k4UVY6SgjyaDJLO8TxvePud986OEzO9qv8XrW
	 J/pYy1Wwl5TS/5fmcEzbic5lVxPc5ZgUwzEDrmAl18qlyfoAuwnKUc4bsCjQ5QZtgV
	 Y5M2ZJ5i37cHDiOjnPqllJ+PYab832yXKk11cSPW6qAgowN7LqhPMvmgb1hd1nQhTT
	 jkGtoUntWFHo3rkMp4mf1VRapto7j23T41aVCrIxXycxhA93aEUDiHxAKBl9mA3mN4
	 wWu3Kgeh5VmUUhEZovk6LMJf7wW3kPGDVppV9+76gslHwJ7a6xAGobRvP3NUwvg00N
	 QMvySouEaqbgw==
Message-ID: <f997ceb6-85d1-4872-be06-2a50469b3b18@kernel.org>
Date: Fri, 17 Apr 2026 17:00:22 +0800
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238466-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Queue-Id: 8B731419132
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 22:40, Yongpeng Yang wrote:
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

I suffered below test failure, then I bisect to this change.

     generic/475  84s ... [failed, exit status 1]- output mismatch (see /share/git/fstests/results//generic/475.out.bad)
     --- tests/generic/475.out   2025-01-12 21:57:40.279440664 +0800
     +++ /share/git/fstests/results//generic/475.out.bad 2026-04-17 12:08:28.000000000 +0800
     @@ -1,2 +1,6 @@
      QA output created by 475
      Silence is golden.
     +mount: /mnt/scratch_f2fs: mount system call failed: Structure needs cleaning.
     +       dmesg(1) may have more information after failed mount system call.
     +mount failed
     +(see /share/git/fstests/results//generic/475.full for details)
     ...
     (Run 'diff -u /share/git/fstests/tests/generic/475.out /share/git/fstests/results//generic/475.out.bad'  to see the entire diff)


     generic/388  73s ... [failed, exit status 1]- output mismatch (see /share/git/fstests/results//generic/388.out.bad)
     --- tests/generic/388.out   2025-01-12 21:57:40.275440602 +0800
     +++ /share/git/fstests/results//generic/388.out.bad 2026-04-17 11:58:05.000000000 +0800
     @@ -1,2 +1,6 @@
      QA output created by 388
      Silence is golden.
     +mount: /mnt/scratch_f2fs: mount system call failed: Structure needs cleaning.
     +       dmesg(1) may have more information after failed mount system call.
     +cycle mount failed
     +(see /share/git/fstests/results//generic/388.full for details)
     ...
     (Run 'diff -u /share/git/fstests/tests/generic/388.out /share/git/fstests/results//generic/388.out.bad'  to see the entire diff)


     F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent info [220057, 57, 6] is incorrect, run fsck to fix

I suspect we may miss any extent updates after we set FI_NO_EXTENT in
__destroy_extent_node(), result in failing in sanity_check_extent_cache().

Can we just relocate f2fs_bug_on(node_cnt) rather than complicated change?
Thoughts?

Thanks,

> 
> Fixes: 3fc5d5a182f6 ("f2fs: fix to shrink read extent node in batches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>   fs/f2fs/extent_cache.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 0ed84cc065a7..87169fd29d89 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -119,9 +119,10 @@ static bool __may_extent_tree(struct inode *inode, enum extent_type type)
>   	if (!__init_may_extent_tree(inode, type))
>   		return false;
>   
> +	if (is_inode_flag_set(inode, FI_NO_EXTENT))
> +		return false;
> +
>   	if (type == EX_READ) {
> -		if (is_inode_flag_set(inode, FI_NO_EXTENT))
> -			return false;
>   		if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
>   				 !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
>   			return false;
> @@ -644,6 +645,8 @@ static unsigned int __destroy_extent_node(struct inode *inode,
>   
>   	while (atomic_read(&et->node_cnt)) {
>   		write_lock(&et->lock);
> +		if (!is_inode_flag_set(inode, FI_NO_EXTENT))
> +			set_inode_flag(inode, FI_NO_EXTENT);
>   		node_cnt += __free_extent_tree(sbi, et, nr_shrink);
>   		write_unlock(&et->lock);
>   	}
> @@ -688,12 +691,12 @@ static void __update_extent_tree_range(struct inode *inode,
>   
>   	write_lock(&et->lock);
>   
> -	if (type == EX_READ) {
> -		if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
> -			write_unlock(&et->lock);
> -			return;
> -		}
> +	if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
> +		write_unlock(&et->lock);
> +		return;
> +	}
>   
> +	if (type == EX_READ) {
>   		prev = et->largest;
>   		dei.len = 0;
>   


