Return-Path: <stable+bounces-109644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A0A182A1
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F88188BBF7
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208721F4E40;
	Tue, 21 Jan 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9gPhA5m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OYvcMo26";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9gPhA5m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OYvcMo26"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367161F3FFF
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737479572; cv=none; b=IZ140oJyLvNPVElBz7L8EC7oA/Pnm267Q4IvQKdGW4gjCx6EOjoL1oYj06okP5i7arSqaMV943Se4THOpni3rhYY2guV1h5XKN2rmqQn/Qpb/6G2O4hCzvuWLy64Ot2zAo0h9OOUrvh2ofHmBZLbRWyreh1oOuJLGG2nzj91a5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737479572; c=relaxed/simple;
	bh=pQNf4YJAcE3RdiCOLTnwbLxlbEvfhS8WiALiBbA7u9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPVrbzZszNb2HqNmqAY9v2b5ZH36vG7iJy+fe9ssAZ9wjVhgskY9E1s9XoapLDlbtB0fFDr/dyPs1IepS5+D0M18kzDvEQ+LrJ2FEE6KtC6rH5oMeh0nOAwyx7JY76UgeVtpT1o/EJKB8rzFqKfMYxWm+8wDXNOzYk/lVqAX7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9gPhA5m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OYvcMo26; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9gPhA5m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OYvcMo26; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43DA02116F;
	Tue, 21 Jan 2025 17:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737479569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUFS1628HRDzYc0SYQv5J3xFKdBAwo+4Z842ChjXDlU=;
	b=u9gPhA5mua0+xOY3J3wit0ChWL5/GutpRRnmZpyEclR8R6nW36gtpZW2Ilw3YOBwZLPm7h
	mUK6U+lyXMCs77dSCgrP20QOR2IifzULcFR6AV7rs7dipuC9/C/ub/CUMbfXYNKQ3elHtj
	jOwokPIUKpx1zRK5QDAufF+LUKY7/Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737479569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUFS1628HRDzYc0SYQv5J3xFKdBAwo+4Z842ChjXDlU=;
	b=OYvcMo26wWy2znD7Dbq0insLKq2a5152j/W8ALSVi68qJMx5v6TStaxVUwtOizkPsmdbdU
	zWRtz24stHLk3SCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u9gPhA5m;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OYvcMo26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737479569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUFS1628HRDzYc0SYQv5J3xFKdBAwo+4Z842ChjXDlU=;
	b=u9gPhA5mua0+xOY3J3wit0ChWL5/GutpRRnmZpyEclR8R6nW36gtpZW2Ilw3YOBwZLPm7h
	mUK6U+lyXMCs77dSCgrP20QOR2IifzULcFR6AV7rs7dipuC9/C/ub/CUMbfXYNKQ3elHtj
	jOwokPIUKpx1zRK5QDAufF+LUKY7/Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737479569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUFS1628HRDzYc0SYQv5J3xFKdBAwo+4Z842ChjXDlU=;
	b=OYvcMo26wWy2znD7Dbq0insLKq2a5152j/W8ALSVi68qJMx5v6TStaxVUwtOizkPsmdbdU
	zWRtz24stHLk3SCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E1A61387C;
	Tue, 21 Jan 2025 17:12:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FiY7C5HVj2eSVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 17:12:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A658A0889; Tue, 21 Jan 2025 18:12:48 +0100 (CET)
Date: Tue, 21 Jan 2025 18:12:48 +0100
From: Jan Kara <jack@suse.cz>
To: Xingyu Li <xli399@ucr.edu>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	jack@suse.cz, brauner@kernel.org, Zheng Zhang <zzhan173@ucr.edu>
Subject: Re: Patch "fs: Block writes to mounted block devices" should
 probably be ported to 6.6 LTS.
Message-ID: <kjha4ekto27cbfbgrwdcnp6m3w63dsuao7itmazectdac6j2j7@j3y3prspqgb2>
References: <CALAgD-4q3pYUF6o+JePukOfbEBQHv0KTNBHxH71eUe+G2LdHEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-4q3pYUF6o+JePukOfbEBQHv0KTNBHxH71eUe+G2LdHEA@mail.gmail.com>
X-Rspamd-Queue-Id: 43DA02116F
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Tue 21-01-25 08:40:50, Xingyu Li wrote:
> We noticed that patch 6f861765464f should be probably ported to Linux 6.6
> LTS.  Its bug introducing commit is probably 05bdb9965305.

The truth is we have always allowed writing to mounted block devices. This
is traditional Unix behavior and Linux has been following it. So in
principle any kernel before commit 6f861765464f or with
CONFIG_BLKDEV_WRITE_MOUNTED=y is prone to the problem.  Because
unpriviledged users are not generally allowed to write to *any* block
device, this is not a security problem. Also note that there are userspace
programs (such as filesystem management tools) that need to write to
mounted block devices so just disabling CONFIG_BLKDEV_WRITE_MOUNTED is not
a generally acceptable option (also for example older versions of mount
break if you do this). Hence backporting these changes to stable kernels
makes little sense as people are unlikely to be able to use them.
CONFIG_BLKDEV_WRITE_MOUNTED is generally useful only for setups doing
system fuzzing or tighly controlled locked-down systems where even system
administrator is not supposed to get arbitrary priviledges.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

