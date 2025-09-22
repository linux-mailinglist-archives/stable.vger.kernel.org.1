Return-Path: <stable+bounces-180956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219FFB916BF
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CAD3B07D6
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACBE2F0687;
	Mon, 22 Sep 2025 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gQDm9107";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a3/nH4o1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gQDm9107";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a3/nH4o1"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A320E023
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548153; cv=none; b=WitNXIH8addHAajS89LSWkziX0aePS+IBr98nx5OEjqheheaycPjw+6+xEyJc8F0r4ju2CpMuClM9TfY0XatXukBwGICeYxrf8/GqhS1qwTq0sUoWMoxBrk+XKzXEPvKNier8NHXj50kaftezfiM5zPML0SjI0Xh63Mg/VXOQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548153; c=relaxed/simple;
	bh=4vUse1SwJnkGhN6UZ6nkTODjFadd0dIxpVXB0dLNrLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a23Yx4Jy7/EOczZuOskvj9t3PDVstyZUsI0JoUGZ4ZeNqPmkp10s3QA/mMPaQo2eDEoWjkdQ87ifbaIJ0e80+V83Xs4yjozsl1ClR68UR3YSGyhKTZer7nsQnOYWBUdhTxf2uGNfCav7yeYtdiGhEbwvQT7X/iIEamtz6Db9fl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gQDm9107; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a3/nH4o1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gQDm9107; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a3/nH4o1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74D4F1F7BC;
	Mon, 22 Sep 2025 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758548149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYXYaUyPuDPO1a/nUp4SOZYHQHA8yTgHULry5DID3lE=;
	b=gQDm9107kCIApY/DoMu8ofwnxfDk2SN6O6Qg7QAc+2xvMm8z27Wd4dWmfkOx1Pe8UOwyRY
	4E39IHOligSRqcf+0PA/9phYKEF4jDbAfTWQnA+dRPdlXseXLSS08xQ/w8r3AkS+hXiw9b
	ZSKvmwCs/QBBcVDv5FAfwQUqHASBb6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758548149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYXYaUyPuDPO1a/nUp4SOZYHQHA8yTgHULry5DID3lE=;
	b=a3/nH4o1dnA2P10da31iLPnhTvDTdGJO3cMuDNoPxjB+t5XRSJEXq+0qzQA8hVPc8TXeOs
	GbjWoIWUw00W8PDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gQDm9107;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="a3/nH4o1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758548149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYXYaUyPuDPO1a/nUp4SOZYHQHA8yTgHULry5DID3lE=;
	b=gQDm9107kCIApY/DoMu8ofwnxfDk2SN6O6Qg7QAc+2xvMm8z27Wd4dWmfkOx1Pe8UOwyRY
	4E39IHOligSRqcf+0PA/9phYKEF4jDbAfTWQnA+dRPdlXseXLSS08xQ/w8r3AkS+hXiw9b
	ZSKvmwCs/QBBcVDv5FAfwQUqHASBb6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758548149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYXYaUyPuDPO1a/nUp4SOZYHQHA8yTgHULry5DID3lE=;
	b=a3/nH4o1dnA2P10da31iLPnhTvDTdGJO3cMuDNoPxjB+t5XRSJEXq+0qzQA8hVPc8TXeOs
	GbjWoIWUw00W8PDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6610813A63;
	Mon, 22 Sep 2025 13:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kNWcGLVQ0WhWfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 13:35:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0B137A07C4; Mon, 22 Sep 2025 15:35:45 +0200 (CEST)
Date: Mon, 22 Sep 2025 15:35:45 +0200
From: Jan Kara <jack@suse.cz>
To: Larshin Sergey <Sergey.Larshin@kaspersky.com>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, Oleg.Kazakov@kaspersky.com, 
	syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs: udf: fix OOB read in lengthAllocDescs handling
Message-ID: <icrfy7skrxx75x57emesny34cm2mn6egl46kqh62hvarr6p6ew@sxdbfjt52ve7>
References: <20250922131358.745579-1-Sergey.Larshin@kaspersky.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922131358.745579-1-Sergey.Larshin@kaspersky.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 74D4F1F7BC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,appspotmail.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,kaspersky.com:email,linuxtesting.org:url,suse.com:email];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[8743fca924afed42f93e];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.51

On Mon 22-09-25 16:13:58, Larshin Sergey wrote:
> When parsing Allocation Extent Descriptor, lengthAllocDescs comes from
> on-disk data and must be validated against the block size. Crafted or
> corrupted images may set lengthAllocDescs so that the total descriptor
> length (sizeof(allocExtDesc) + lengthAllocDescs) exceeds the buffer,
> leading udf_update_tag() to call crc_itu_t() on out-of-bounds memory and
> trigger a KASAN use-after-free read.
> 
> BUG: KASAN: use-after-free in crc_itu_t+0x1d5/0x2b0 lib/crc-itu-t.c:60
> Read of size 1 at addr ffff888041e7d000 by task syz-executor317/5309
> 
> CPU: 0 UID: 0 PID: 5309 Comm: syz-executor317 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  crc_itu_t+0x1d5/0x2b0 lib/crc-itu-t.c:60
>  udf_update_tag+0x70/0x6a0 fs/udf/misc.c:261
>  udf_write_aext+0x4d8/0x7b0 fs/udf/inode.c:2179
>  extent_trunc+0x2f7/0x4a0 fs/udf/truncate.c:46
>  udf_truncate_tail_extent+0x527/0x7e0 fs/udf/truncate.c:106
>  udf_release_file+0xc1/0x120 fs/udf/file.c:185
>  __fput+0x23f/0x880 fs/file_table.c:431
>  task_work_run+0x24f/0x310 kernel/task_work.c:239
>  exit_task_work include/linux/task_work.h:43 [inline]
>  do_exit+0xa2f/0x28e0 kernel/exit.c:939
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>  __do_sys_exit_group kernel/exit.c:1099 [inline]
>  __se_sys_exit_group kernel/exit.c:1097 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>  x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
> 
> Validate the computed total length against epos->bh->b_size.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Reported-by: syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8743fca924afed42f93e
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Larshin Sergey <Sergey.Larshin@kaspersky.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/udf/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index f24aa98e6869..a79d73f28aa7 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -2272,6 +2272,9 @@ int udf_current_aext(struct inode *inode, struct extent_position *epos,
>  		if (check_add_overflow(sizeof(struct allocExtDesc),
>  				le32_to_cpu(header->lengthAllocDescs), &alen))
>  			return -1;
> +
> +		if (alen > epos->bh->b_size)
> +			return -1;
>  	}
>  
>  	switch (iinfo->i_alloc_type) {
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

