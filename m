Return-Path: <stable+bounces-158802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA83AEBF87
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 21:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3431C463F1
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D00F211A00;
	Fri, 27 Jun 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="szAfs6T5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DaGiEprG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="szAfs6T5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DaGiEprG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866B8207A32
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051675; cv=none; b=k0xRgAmuUTOcC43FgUSCBukG1Uw7NxaPHatjatxrV9kF8u71nLlxYVL8actPUDGPnhHyBdJ4NHDPvmYB6ljkZG5+WzvCFVLXAgVeDNoo0+lG//o/ATV5hAfM2HR2VGECwsyRsDnB6+F4htcE3UER4WpPOsqRfpJWEp4IxWnfyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051675; c=relaxed/simple;
	bh=LKuZ/WhnJ5ed70h2mbTh2fwu9CwkQKi/+gt3+E4rfqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiYLsAoc9mxz6B/J6oKlE0ocLedf8I8klF+YGh3XQhXPi96kbOMv5N8rn9uCYojT0gKnrYPhpqw1EOuOakEJiaR7LnBU1CcR4OhC8CFp6t+iZ/F6fl5cBhQKhQglCRvbMOvJwhN5pTZa/ocHCqiCsuHq+3pVxH83bml4VpTMqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=szAfs6T5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DaGiEprG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=szAfs6T5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DaGiEprG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A88742115E;
	Fri, 27 Jun 2025 19:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751051671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79reliRkh+Qi9AXkJF3yFkRiQKDl+EyPIWYZV31rWp0=;
	b=szAfs6T5vQC1DxDzxGM08PLs5gR9M4BwiToxJ/c4I+SJ01ywObxm/8quu1JojqPSsFKfp4
	xFLEnqudwjwfU0a9e+ELR24EGyfIDpaBASU+D9QYDgiiVAiT96uEakncLcRbw+qtXQD2BL
	0thCoeRzam32uzQHb2mk7KkxUvlgKnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751051671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79reliRkh+Qi9AXkJF3yFkRiQKDl+EyPIWYZV31rWp0=;
	b=DaGiEprGjyTTS5m38qAiD6vnWxIbJBT2Ka9nP95Dd+qLp7fM+sryDvjQvXdOaZSwG3JswJ
	ifjspZLF9cPjNdAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751051671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79reliRkh+Qi9AXkJF3yFkRiQKDl+EyPIWYZV31rWp0=;
	b=szAfs6T5vQC1DxDzxGM08PLs5gR9M4BwiToxJ/c4I+SJ01ywObxm/8quu1JojqPSsFKfp4
	xFLEnqudwjwfU0a9e+ELR24EGyfIDpaBASU+D9QYDgiiVAiT96uEakncLcRbw+qtXQD2BL
	0thCoeRzam32uzQHb2mk7KkxUvlgKnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751051671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79reliRkh+Qi9AXkJF3yFkRiQKDl+EyPIWYZV31rWp0=;
	b=DaGiEprGjyTTS5m38qAiD6vnWxIbJBT2Ka9nP95Dd+qLp7fM+sryDvjQvXdOaZSwG3JswJ
	ifjspZLF9cPjNdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98F3C138A7;
	Fri, 27 Jun 2025 19:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jhwKJZftXmiIHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Jun 2025 19:14:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 44936A08D2; Fri, 27 Jun 2025 21:14:31 +0200 (CEST)
Date: Fri, 27 Jun 2025 21:14:31 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 09/16] ext4: fix zombie groups in average fragment
 size lists
Message-ID: <pouh5hfd7lswwhczu667k2pywuawaetvv4lr44zinexbb75jeu@rgaaqa5myop7>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-10-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623073304.3275702-10-libaokun1@huawei.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 23-06-25 15:32:57, Baokun Li wrote:
> Groups with no free blocks shouldn't be in any average fragment size list.
> However, when all blocks in a group are allocated(i.e., bb_fragments or
> bb_free is 0), we currently skip updating the average fragment size, which
> means the group isn't removed from its previous s_mb_avg_fragment_size[old]
> list.
> 
> This created "zombie" groups that were always skipped during traversal as
> they couldn't satisfy any block allocation requests, negatively impacting
> traversal efficiency.
> 
> Therefore, when a group becomes completely free, bb_avg_fragment_size_order
					     ^^^ full

> is now set to -1. If the old order was not -1, a removal operation is
> performed; if the new order is not -1, an insertion is performed.
> 
> Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Good catch! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 94950b07a577..e6d6c2da3c6e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -841,30 +841,30 @@ static void
>  mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	int new_order;
> +	int new, old;
>  
> -	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_fragments == 0)
> +	if (!test_opt2(sb, MB_OPTIMIZE_SCAN))
>  		return;
>  
> -	new_order = mb_avg_fragment_size_order(sb,
> -					grp->bb_free / grp->bb_fragments);
> -	if (new_order == grp->bb_avg_fragment_size_order)
> +	old = grp->bb_avg_fragment_size_order;
> +	new = grp->bb_fragments == 0 ? -1 :
> +	      mb_avg_fragment_size_order(sb, grp->bb_free / grp->bb_fragments);
> +	if (new == old)
>  		return;
>  
> -	if (grp->bb_avg_fragment_size_order != -1) {
> -		write_lock(&sbi->s_mb_avg_fragment_size_locks[
> -					grp->bb_avg_fragment_size_order]);
> +	if (old >= 0) {
> +		write_lock(&sbi->s_mb_avg_fragment_size_locks[old]);
>  		list_del(&grp->bb_avg_fragment_size_node);
> -		write_unlock(&sbi->s_mb_avg_fragment_size_locks[
> -					grp->bb_avg_fragment_size_order]);
> -	}
> -	grp->bb_avg_fragment_size_order = new_order;
> -	write_lock(&sbi->s_mb_avg_fragment_size_locks[
> -					grp->bb_avg_fragment_size_order]);
> -	list_add_tail(&grp->bb_avg_fragment_size_node,
> -		&sbi->s_mb_avg_fragment_size[grp->bb_avg_fragment_size_order]);
> -	write_unlock(&sbi->s_mb_avg_fragment_size_locks[
> -					grp->bb_avg_fragment_size_order]);
> +		write_unlock(&sbi->s_mb_avg_fragment_size_locks[old]);
> +	}
> +
> +	grp->bb_avg_fragment_size_order = new;
> +	if (new >= 0) {
> +		write_lock(&sbi->s_mb_avg_fragment_size_locks[new]);
> +		list_add_tail(&grp->bb_avg_fragment_size_node,
> +				&sbi->s_mb_avg_fragment_size[new]);
> +		write_unlock(&sbi->s_mb_avg_fragment_size_locks[new]);
> +	}
>  }
>  
>  /*
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

