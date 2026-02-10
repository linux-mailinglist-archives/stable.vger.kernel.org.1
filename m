Return-Path: <stable+bounces-215666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WABlJA47i2neRgAAu9opvQ
	(envelope-from <stable+bounces-215666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:05:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E5311BB0B
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C58300E3B1
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D71B0439;
	Tue, 10 Feb 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bDhaX8B+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2BFE1gn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bDhaX8B+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2BFE1gn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3F2DC782
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732268; cv=none; b=jxBHQoCOPhuT/1Ucz9RJTDVmjtT0duvL8arrIIZQ74sHCn1YdgdkmS5HGwq3o8MgMuXt9Q0gOPh9FxVHOU4qad/H0JabGtbnBEjaT/EkssLh5Bni691oaCw8Dmar8w50GdeJ+oAiOlh0Kx488zL8NmT2b3Fhs2U5q78PgWjxxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732268; c=relaxed/simple;
	bh=+fxExFAlGQj+b72Botth+tEKOW7BvcuvaWyI2hNKm8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7tgx3iVedplavAhQBVmCGZSV6EFN6vFJn+qrM/HpIktuVMipgqAihC/oDwdIQKMbHmrXEXslGJIr3Mt3rOQLCqUbvFtDWHhjhkHFk9Z2o8dRPPMUhTpJ7dHHbSlnzsALyjipbJ5NThqEdQf55x48cml8flOJ4b44v7BZ5sofwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bDhaX8B+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2BFE1gn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bDhaX8B+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2BFE1gn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82A3D5BD5E;
	Tue, 10 Feb 2026 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770732265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShvN0TlVAhVSFriUR2oEJWHcdETIgcYitMEUjd4KOdE=;
	b=bDhaX8B+q+/o1LsGSqz9ihXjsgMHy9UPrcoqPc8F/9/T3tbckUVmhTWY6gdb+49qA+f5Xr
	cHhkG1VtKZNA9SKsdln7Xr/twCsvgm9ULx9qV8RT/KsgnaDS1tL2GEtN4Mr0l4B/zv48VY
	v4iBZm7+FfXm63noXao+YjhXe2az+Mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770732265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShvN0TlVAhVSFriUR2oEJWHcdETIgcYitMEUjd4KOdE=;
	b=G2BFE1gnAJ/WV1Xfsuqto8bZq8o8d145J9a0PapHuwF/TBkRrAfbOOhpbhi8TAMTiSBK/k
	D/M+jHj1ofqWheBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770732265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShvN0TlVAhVSFriUR2oEJWHcdETIgcYitMEUjd4KOdE=;
	b=bDhaX8B+q+/o1LsGSqz9ihXjsgMHy9UPrcoqPc8F/9/T3tbckUVmhTWY6gdb+49qA+f5Xr
	cHhkG1VtKZNA9SKsdln7Xr/twCsvgm9ULx9qV8RT/KsgnaDS1tL2GEtN4Mr0l4B/zv48VY
	v4iBZm7+FfXm63noXao+YjhXe2az+Mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770732265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShvN0TlVAhVSFriUR2oEJWHcdETIgcYitMEUjd4KOdE=;
	b=G2BFE1gnAJ/WV1Xfsuqto8bZq8o8d145J9a0PapHuwF/TBkRrAfbOOhpbhi8TAMTiSBK/k
	D/M+jHj1ofqWheBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BD063EA62;
	Tue, 10 Feb 2026 14:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IrY/Guk6i2nAdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Feb 2026 14:04:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2E3A8A0A4E; Tue, 10 Feb 2026 15:04:17 +0100 (CET)
Date: Tue, 10 Feb 2026 15:04:17 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	"Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com, Andrey Albershteyn <aalbersh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] fs: set fsx_valid hint in file_getattr() syscall
Message-ID: <hgvt24txxxr7i6d2qyh27st62rdz6hmqz3xode5hcvw3bo6b6y@o4zjjusdr3gw>
References: <20260210095042.506707-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210095042.506707-1-amir73il@gmail.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215666-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,appspotmail.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,fa79520cb6cf363d660d];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F1E5311BB0B
X-Rspamd-Action: no action

On Tue 10-02-26 10:50:42, Amir Goldstein wrote:
> The vfs_fileattr_get() API is a unification of the two legacy ioctls
> FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR.
> 
> The legacy ioctls set a hint flag, either flags_valid or fsx_valid,
> which overlayfs and fuse may use to convert back to one of the two
> legacy ioctls.
> 
> The new file_getattr() syscall is a modern version of the ioctl
> FS_IOC_FSGETXATTR, but it does not set the fsx_valid hint leading to
> uninit-value KMSAN warning in ovl_fileattr_get() as is also expected
> to happen in fuse_fileattr_get().
> 
> Reported-by: syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/698ad8b7.050a0220.3b3015.008b.GAE@google.com/
> Fixes: be7efb2d20d67 ("fs: introduce file_getattr and file_setattr syscalls")
> Cc: Andrey Albershteyn <aalbersh@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 53b356dd8c33a..910c346d81bcd 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -379,7 +379,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
>  	struct filename *name __free(putname) = NULL;
>  	unsigned int lookup_flags = 0;
>  	struct file_attr fattr;
> -	struct file_kattr fa;
> +	struct file_kattr fa = { .fsx_valid = true }; /* hint only */
>  	int error;
>  
>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

