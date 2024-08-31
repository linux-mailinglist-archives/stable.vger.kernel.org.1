Return-Path: <stable+bounces-71696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AE19672EA
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 20:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1519283207
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9FF74C08;
	Sat, 31 Aug 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQQtD9pF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cJMxNuTa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQQtD9pF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cJMxNuTa"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C281D556
	for <stable@vger.kernel.org>; Sat, 31 Aug 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725127224; cv=none; b=fWLu98G7RxheZdq4IiiqYS/fTyuJ7P+Ri8m4c+FpZMUvVm1n0rDq7CuCgeS8y27lEF3jeefH7Nby9n2WemeujIXKYJRwDR0qnpRsXZB30hZJpmxAQkgJpsR4FQ1TQV4C3IuKV10/OZHm/8WAMPVK7XURXQBpjlMoxxx3Vhw6nAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725127224; c=relaxed/simple;
	bh=0jkE2q2DFfSM3/bkHSRjUtiHMM1vLGP5zLkRj7TarEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WblWgGSx7YktV6ESmVWrY1pMwz0N3dCR1uOy0aR6vDakON5GFJ50rzkaokdwNqTzvz/C1kjWyCrNImAdQAOCngK2yaxFoML4L1Iyjl/C8GjMV9vahqRWZ5IODRSCcCrqXAZPgW4ZTGZWQCcrwGytQCAMtghunvxeD5yC2OWE0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQQtD9pF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cJMxNuTa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQQtD9pF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cJMxNuTa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6213B1F86A;
	Sat, 31 Aug 2024 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725127220;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W7r+AHxBNFqYcl6rMjWmlnY8J0jLA5QFf3hX+JTJ5oA=;
	b=WQQtD9pFk0ieau32Ny2mykWL4trSIJVYLQWO3dmOPcSlWddAfUKCpW6g91sNm0yCoOE3m0
	xUcdnjzMhMK9yqW7fH8Fba9m9RtkP6Z1qE/MKke0j8K/Kuo2uRNczkZAvGjhiiyC4RXokW
	wNvvgFrvr8T6/d1ycNFeFxr+pb3Hyqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725127220;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W7r+AHxBNFqYcl6rMjWmlnY8J0jLA5QFf3hX+JTJ5oA=;
	b=cJMxNuTaVTOHc8JfhBel+TPTuTIBOIPXk3klsiXR+YElAEIhk5b4m3xEUI21eFg2/kExZk
	F7qJlO0H7fOe26DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725127220;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W7r+AHxBNFqYcl6rMjWmlnY8J0jLA5QFf3hX+JTJ5oA=;
	b=WQQtD9pFk0ieau32Ny2mykWL4trSIJVYLQWO3dmOPcSlWddAfUKCpW6g91sNm0yCoOE3m0
	xUcdnjzMhMK9yqW7fH8Fba9m9RtkP6Z1qE/MKke0j8K/Kuo2uRNczkZAvGjhiiyC4RXokW
	wNvvgFrvr8T6/d1ycNFeFxr+pb3Hyqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725127220;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W7r+AHxBNFqYcl6rMjWmlnY8J0jLA5QFf3hX+JTJ5oA=;
	b=cJMxNuTaVTOHc8JfhBel+TPTuTIBOIPXk3klsiXR+YElAEIhk5b4m3xEUI21eFg2/kExZk
	F7qJlO0H7fOe26DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8038139D3;
	Sat, 31 Aug 2024 18:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RnOWMzNa02bIBQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Sat, 31 Aug 2024 18:00:19 +0000
Date: Sat, 31 Aug 2024 20:00:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: cel@kernel.org
Cc: ltp@lists.linux.it, Amir Goldstein <amir73il@gmail.com>,
	stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Li Wang <liwang@redhat.com>, Martin Doucha <martin.doucha@suse.com>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH RFC] syscalls/fanotify09: Note backport of commit
 e730558adffb
Message-ID: <20240831180010.GA173943@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240831160900.173809-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831160900.173809-1-cel@kernel.org>
X-Spam-Score: -7.50
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,vger.kernel.org,oracle.com,redhat.com,suse.com,suse.cz];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Chuck, Amir, all,

[ Add some enterprise folks just to notify ]

> From: Chuck Lever <chuck.lever@oracle.com>

Thanks for the fix!

> I backported commit e730558adffb ("fsnotify: consistent behavior for
> parent not watching children") to v5.15.y and v5.10.y. Update
> fanotify09 to test older LTS kernels containing that commit.

> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

For others, suggested here:
https://lore.kernel.org/all/CAOQ4uxiUwSiRQ9tLPw6FPDB05rRLFdjxruFM4Lk=HcZfP2tfqA@mail.gmail.com/

Reviewed-by: Petr Vorel <pvorel@suse.cz>

NOTE: we might need to add check for enterprise kernels, but that should be
trivial. I'll test it on Monday on SLES and maybe add follow up for it.

Kind regards,
Petr
> ---
>  testcases/kernel/syscalls/fanotify/fanotify09.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

> Untested.

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> index f61c4e45a88c..48b198b9415a 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> @@ -29,7 +29,6 @@
>   *      7372e79c9eb9 fanotify: fix logic of reporting name info with watched parent
>   *
>   * Test cases #6-#7 are regression tests for commit:
> - * (from v5.19, unlikely to be backported thus not in .tags):
>   *
>   *      e730558adffb fanotify: consistent behavior for parent not watching children
>   */
> @@ -380,9 +379,9 @@ static void test_fanotify(unsigned int n)
>  		return;
>  	}

> -	if (tc->ignore && tst_kvercmp(5, 19, 0) < 0) {
> +	if (tc->ignore && tst_kvercmp(5, 10, 0) < 0) {
>  		tst_res(TCONF, "ignored mask on parent dir has undefined "
> -				"behavior on kernel < 5.19");
> +				"behavior on kernel < 5.10");
>  		return;
>  	}

> @@ -520,6 +519,7 @@ static struct tst_test test = {
>  		{"linux-git", "b469e7e47c8a"},
>  		{"linux-git", "55bf882c7f13"},
>  		{"linux-git", "7372e79c9eb9"},
> +		{"linux-git", "e730558adffb"},
>  		{}
>  	}
>  };

