Return-Path: <stable+bounces-55116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA04915A1E
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 00:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9E61C223E8
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 22:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE8C1A2553;
	Mon, 24 Jun 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nbg8NQoG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r/qhYr94";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nbg8NQoG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r/qhYr94"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3A47A64;
	Mon, 24 Jun 2024 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269762; cv=none; b=tSsXxA2jL73aoVSRVmyQuWKVz/9DvIxV801E+8StelJtxE9HUf8XEL9zih4yLfmJos6xfq9VtKwADMGBKqj4CApq9QrdfgsmHl/EXk6ZxFN2C7qDefKFjKNbEjlq4VbaWNjet8B12MJU+axgyGOXqWsadBKVMR+KoVUZTPjsrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269762; c=relaxed/simple;
	bh=v/4Lo5elq/YUpbsGa1pjMf62OlvFVKZrR/mWISy9bSw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rjC4JKw4uznxWBrc3gZNbzWBIPG/Jl8+JQvoMUzc1YhULR1D5QdizscIIgLXCHfpxxRwwEACPYF+JwF3wgBgbq63r8RZuclyVPVOQG7ChbfSBbEsd3qxDZ4CccCVLO7LGH8jH/lEAGuiSY2eQg82hwZzpKe/7ug66yEcra7ye74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nbg8NQoG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r/qhYr94; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nbg8NQoG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r/qhYr94; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 978CD1FD15;
	Mon, 24 Jun 2024 22:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719269758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irYjhl8w3VLkb84h0imZ7LbqltVvMgDIMDnLL6aFOAw=;
	b=Nbg8NQoGKZM5ODaFadWJfn7drReLshe5FEtjrWmUD7+AErlzsQC2htQEbZwNkuBplOcaDj
	VCk2FqzWmwTfxKTg7ZVY3zKjF1YWOuwVfKxLaqcBkpjG6LL4J95O4X0TuQsEoulB55Umey
	qyCFURVSzONVQiqnvF6WxCoopmiez98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719269758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irYjhl8w3VLkb84h0imZ7LbqltVvMgDIMDnLL6aFOAw=;
	b=r/qhYr94aGVgI5pW0DW4L0xPutVR3jxQvZSxCIkWsy0+vCgA5C2+enTu7yf81FNMEa8GDe
	AKj2BcRmUAat2bCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719269758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irYjhl8w3VLkb84h0imZ7LbqltVvMgDIMDnLL6aFOAw=;
	b=Nbg8NQoGKZM5ODaFadWJfn7drReLshe5FEtjrWmUD7+AErlzsQC2htQEbZwNkuBplOcaDj
	VCk2FqzWmwTfxKTg7ZVY3zKjF1YWOuwVfKxLaqcBkpjG6LL4J95O4X0TuQsEoulB55Umey
	qyCFURVSzONVQiqnvF6WxCoopmiez98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719269758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irYjhl8w3VLkb84h0imZ7LbqltVvMgDIMDnLL6aFOAw=;
	b=r/qhYr94aGVgI5pW0DW4L0xPutVR3jxQvZSxCIkWsy0+vCgA5C2+enTu7yf81FNMEa8GDe
	AKj2BcRmUAat2bCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A86613ACF;
	Mon, 24 Jun 2024 22:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a4gKBHn5eWYOGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Jun 2024 22:55:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, jlayton@kernel.org,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Subject: Re: Patch "nfsd: fix oops when reading pool_stats before server is
 started" has been added to the 6.9-stable tree
In-reply-to: <20240624134957.936227-1-sashal@kernel.org>
References: <20240624134957.936227-1-sashal@kernel.org>
Date: Tue, 25 Jun 2024 08:55:44 +1000
Message-id: <171926974436.14261.14452569082069214699@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Mon, 24 Jun 2024, stable@vger.kernel.org wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     nfsd: fix oops when reading pool_stats before server is started
>=20
> to the 6.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.git=
;a=3Dsummary
>=20
> The filename of the patch is:
>      nfsd-fix-oops-when-reading-pool_stats-before-server-.patch
> and it can be found in the queue-6.9 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I feel this should not be added to the stable tree.

It moves at test on a field protected by a mutex outside of the
protection of that mutex, and so is obviously racey.

Depending on how the race goes, si->serv might be NULL when dereferenced
in svc_pool_stats_start(), or svc_pool_stats_stop() might unlock a mutex
that hadn't been locked.

I'll post a revert and a better fix for mainline.

Thanks,
NeilBrown

>=20
>=20
>=20
> commit 388a527c6cf55bde74bc0891d0b4c38f50d896be
> Author: Jeff Layton <jlayton@kernel.org>
> Date:   Mon Jun 17 07:54:08 2024 -0400
>=20
>     nfsd: fix oops when reading pool_stats before server is started
>    =20
>     [ Upstream commit 8e948c365d9c10b685d1deb946bd833d6a9b43e0 ]
>    =20
>     Sourbh reported an oops that is triggerable by trying to read the
>     pool_stats procfile before nfsd had been started. Move the check for a
>     NULL serv in svc_pool_stats_start above the mutex acquisition, and fix
>     the stop routine not to unlock the mutex if there is no serv yet.
>    =20
>     Fixes: 7b207ccd9833 ("svc: don't hold reference for poolstats, only mut=
ex.")
>     Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>     Signed-off-by: Jeff Layton <jlayton@kernel.org>
>     Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index b4a85a227bd7d..1a2982051f986 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1371,12 +1371,13 @@ static void *svc_pool_stats_start(struct seq_file *=
m, loff_t *pos)
> =20
>  	dprintk("svc_pool_stats_start, *pidx=3D%u\n", pidx);
> =20
> +	if (!si->serv)
> +		return NULL;
> +
>  	mutex_lock(si->mutex);
> =20
>  	if (!pidx)
>  		return SEQ_START_TOKEN;
> -	if (!si->serv)
> -		return NULL;
>  	return pidx > si->serv->sv_nrpools ? NULL
>  		: &si->serv->sv_pools[pidx - 1];
>  }
> @@ -1408,7 +1409,8 @@ static void svc_pool_stats_stop(struct seq_file *m, v=
oid *p)
>  {
>  	struct svc_info *si =3D m->private;
> =20
> -	mutex_unlock(si->mutex);
> +	if (si->serv)
> +		mutex_unlock(si->mutex);
>  }
> =20
>  static int svc_pool_stats_show(struct seq_file *m, void *p)
>=20


