Return-Path: <stable+bounces-139656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F7AA90C6
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C43B7EA5
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEE71FDA7B;
	Mon,  5 May 2025 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQnp8OwS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zg+FqbdN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQnp8OwS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zg+FqbdN"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADB3596A
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440370; cv=none; b=ZAHOFTQb+mZf648PezTHhjzB2ptZcjHEJsDioKfNQi7SjL1C23IcPHkUNjZNNkjDHEbdJciNU9Icg8hHh3d3sk3lbXaAVdQX58adYI3cJbGe51Alqozv7wL21wKezd2yZUiycMtH383Iu3ftsZDX8ViBoj6EGDnko7tV17GJVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440370; c=relaxed/simple;
	bh=fZRJRGBUfeoqYklT8YCLbziPfx9Gg5apvvccvcMpQRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWFCagW9fvwTlSJWf6OcDJLarz3v5gzehWP8oMxvJPfQ3lo8y99Ty6dHHNpo3FqQG4SVhPp/ah4YlEY6fXrTzYnPf4AukhWUqsJNq1t6kRoI0Lp3Dlc1CFs1WGCX8z8js5UYwoRnehzyTzgcjwnkdWpuakq2J3SEPVFukwSHy6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQnp8OwS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zg+FqbdN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQnp8OwS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zg+FqbdN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A6822118D;
	Mon,  5 May 2025 10:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746440367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+CuKktiQKfpbKb73Elr0/AnTcjJL/9A/w+U7OWH/LE=;
	b=BQnp8OwSgqSWoHT+0nVfOx/Lle04WqFl9X9v2XzL0Qx63oU3NH3XL3QGLO5RBaKskvvJou
	vOXI51ngPXU+jBuKRbbK14OdEmW0EbiKXUm+qbWM5QUjFpXvAmuHl8HM2j3tkoS7Wnx40I
	/Rlh7vu7whyExnLyK3AwM7zbSRbXd5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746440367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+CuKktiQKfpbKb73Elr0/AnTcjJL/9A/w+U7OWH/LE=;
	b=zg+FqbdN21/EnNl6Bd644y2UX3BPB0TFhpdc/929XHC2jQeEoHi5xU6b8PmPn9HmFOBIqx
	yOFvhGBAgjrQWXAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BQnp8OwS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zg+FqbdN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746440367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+CuKktiQKfpbKb73Elr0/AnTcjJL/9A/w+U7OWH/LE=;
	b=BQnp8OwSgqSWoHT+0nVfOx/Lle04WqFl9X9v2XzL0Qx63oU3NH3XL3QGLO5RBaKskvvJou
	vOXI51ngPXU+jBuKRbbK14OdEmW0EbiKXUm+qbWM5QUjFpXvAmuHl8HM2j3tkoS7Wnx40I
	/Rlh7vu7whyExnLyK3AwM7zbSRbXd5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746440367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+CuKktiQKfpbKb73Elr0/AnTcjJL/9A/w+U7OWH/LE=;
	b=zg+FqbdN21/EnNl6Bd644y2UX3BPB0TFhpdc/929XHC2jQeEoHi5xU6b8PmPn9HmFOBIqx
	yOFvhGBAgjrQWXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08DEB13883;
	Mon,  5 May 2025 10:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F04nAq+QGGhjewAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 10:19:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 923C8A0670; Mon,  5 May 2025 12:19:26 +0200 (CEST)
Date: Mon, 5 May 2025 12:19:26 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrey Kriulin <kitotavrik.s@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Andrey Kriulin <kitotavrik.media@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: minix: Fix handling of corrupted directories
Message-ID: <tmrfgsrexyytlgxpsf3xus7w6tv3ake4ogo2b7ul7p6vn36cqv@nv4m6clasxjv>
References: <20250502165059.63012-1-kitotavrik.media@gmail.com>
 <aBUAbPum1d5dNrpG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBUAbPum1d5dNrpG@casper.infradead.org>
X-Rspamd-Queue-Id: 1A6822118D
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,toxicpanda.com,suse.de,suse.cz,vger.kernel.org,linuxtesting.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Fri 02-05-25 18:27:08, Matthew Wilcox wrote:
> On Fri, May 02, 2025 at 07:50:57PM +0300, Andrey Kriulin wrote:
> > If the directory is corrupted and the number of nlinks is less than 2 
> 
> ... so should it be EIO or EFSCORRUPTED?

Well, EFSCORRUPTED is an internal define (to EUCLEAN) local to several
filesystems. So we'd need to lift that define to a generic code first.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

