Return-Path: <stable+bounces-144397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DDEAB7090
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 17:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93081888271
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2942027B4EE;
	Wed, 14 May 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OOJMXwb7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w2e7ojmm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OOJMXwb7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w2e7ojmm"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F750282ED
	for <stable@vger.kernel.org>; Wed, 14 May 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747238053; cv=none; b=IMKJrY07h20H1FS3hi/v7Ouc9mvyb154M+a+ScPHGyQ5L/9/NVA5MR5gnWSvzSS2BHju+fOKNHIE4cy11Gedn5y0+TuZz9NkYMJVvKM9Ag3XhtAV7g0N+JlnHkFv3g0HyK3pKJGtxO5Qd6L/o5WPpsNaggb3nF6ZfH69MLEgvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747238053; c=relaxed/simple;
	bh=weHHEddq3NgCnyhJObSar682vkZHiYlxMVkeLdj5YaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsRq/GZAliGaK2fuuw4YXHZMFrWh9+QmUs8BWc7a2mu38o/LK2cYcf7bFjlosrl+EYAi3Vjs/zlBk7J1SSLSUDJ/GtYns2Gsj/ygwXBBr/cChqvzvVkastDg4HGMxN2PWCfVDajfoSLe6MZ2exCURYzs+DWeWpz5kt3xldD/jX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OOJMXwb7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w2e7ojmm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OOJMXwb7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w2e7ojmm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C2DE2122B;
	Wed, 14 May 2025 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747238044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExnqCH3sIsMHmrUOVPISaMOlvbAx9glFwsFKy/6VWQc=;
	b=OOJMXwb7FgME1WSTXArMf9oRfdfehSRRcN9AKsyAUa3Q2E7k+uPUdCwcO0lx2Dm+sno6ni
	2mgvqn0ZLLOUug4Oft6FQP8AAh1cFagNCZ9JH3A8fea1uYTrl8tnI2ZVoR6219epG1ChND
	GIhwVBwmRM/27Wnc+k0DfImlIe+eH4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747238044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExnqCH3sIsMHmrUOVPISaMOlvbAx9glFwsFKy/6VWQc=;
	b=w2e7ojmmtZGmZZY1IARMCL6WifP+qctBKtpuZx8y6l+U2T9YrQE1MZcr65Krtl5wgK/uXm
	VmaDPidi7EwqOUCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747238044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExnqCH3sIsMHmrUOVPISaMOlvbAx9glFwsFKy/6VWQc=;
	b=OOJMXwb7FgME1WSTXArMf9oRfdfehSRRcN9AKsyAUa3Q2E7k+uPUdCwcO0lx2Dm+sno6ni
	2mgvqn0ZLLOUug4Oft6FQP8AAh1cFagNCZ9JH3A8fea1uYTrl8tnI2ZVoR6219epG1ChND
	GIhwVBwmRM/27Wnc+k0DfImlIe+eH4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747238044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExnqCH3sIsMHmrUOVPISaMOlvbAx9glFwsFKy/6VWQc=;
	b=w2e7ojmmtZGmZZY1IARMCL6WifP+qctBKtpuZx8y6l+U2T9YrQE1MZcr65Krtl5wgK/uXm
	VmaDPidi7EwqOUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DBAD13306;
	Wed, 14 May 2025 15:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XDALD5y8JGjVMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 May 2025 15:54:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7803CA0A02; Wed, 14 May 2025 17:54:03 +0200 (CEST)
Date: Wed, 14 May 2025 17:54:03 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Kriulin <kitotavrik.s@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org, Andrey Kriulin <kitotavrik.media@gmail.com>
Subject: Re: [PATCH v2] fs: minix: Fix handling of corrupted directories
Message-ID: <s5pju6jp2k4ddyuuz2xydeys5lhashkbvwa2lmtw3dmtedupw5@sjdrgnhwsvza>
References: <20250514103837.27152-1-kitotavrik.s@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514103837.27152-1-kitotavrik.s@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,toxicpanda.com,suse.de,suse.cz,vger.kernel.org,linuxtesting.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -2.30

On Wed 14-05-25 13:38:35, Andrey Kriulin wrote:
> If the directory is corrupted and the number of nlinks is less than 2
> (valid nlinks have at least 2), then when the directory is deleted, the
> minix_rmdir will try to reduce the nlinks(unsigned int) to a negative
> value.
> 
> Make nlinks validity check for directory.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Kriulin <kitotavrik.media@gmail.com>
> Signed-off-by: Andrey Kriulin <kitotavrik.s@gmail.com>
> ---
> v2: Move nlinks validaty check to V[12]_minix_iget() per Jan Kara
> <jack@suse.cz> request. Change return error code to EUCLEAN. Don't block
> directory in r/o mode per Al Viro <viro@zeniv.linux.org.uk> request.
> 
>  fs/minix/inode.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index f007e389d5d2..d815397b8b0d 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -517,6 +517,14 @@ static struct inode *V1_minix_iget(struct inode *inode)
>  		iget_failed(inode);
>  		return ERR_PTR(-ESTALE);
>  	}
> +	if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks < 2) {
> +		printk("MINIX-fs: inode directory with corrupted number of links");

A message like this is rather useless because it shows nothing either about
the inode or the link count or the filesystem where this happened. I'd
either improve or delete it.

> +		if (!sb_rdonly(inode->i_sb)) {
> +			brelse(bh);
> +			iget_failed(inode);
> +			return ERR_PTR(-EUCLEAN);
> +		}

OK, but when the inode is cached in memory with the wrong link count and
then the filesystem is remounted read-write, you will get the same problem
as before? I guess the easiest is to fudge i_nlinks count in memory to 2 to
avoid issues...


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

