Return-Path: <stable+bounces-223694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePGaKG/trmnvKQIAu9opvQ
	(envelope-from <stable+bounces-223694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:55:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF9B23C32B
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76852301700C
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B233E0C73;
	Mon,  9 Mar 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MYc3ge0P"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB503D4115
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071529; cv=none; b=WvJrN/wdiVsVMMHx8a1YWQla+qCGqxqkhG0oAYaQYXWReUo+dsGopyHWUTL++qZXdrT5wF5rPXHc6ayrJmA9uIbu2VXfoyWZcdJ9d4gMhfQOaS8F2G4B45V18SzvLGWOSAPGOvn+y61hNsBRjffeIzxZmfukhOFXJdrMfeUkuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071529; c=relaxed/simple;
	bh=HaQEemrQWTgDUwbzmc3Mzj2qY0rDmP4XNo9O9V8u/ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx3/1o7m5WG2RjpHrVItzK0jNb3eMjJKGhJ83crN8l3RjESRcDWNWo0l2SJ/seWoy9dKUC88tRzq78VrxwVsTaN4XxzFfpXyI3/wWICZoLVEH0/hVNKKyDsahGx6cgqNk9IqrBSQfqw8zRYLunOh/uNL/RioWsKQfuFxKsWhXhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MYc3ge0P; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b611274bso5417371f8f.3
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773071524; x=1773676324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly8aqb2t/EfTDPkW0Kau0FkQv2wta+tzkVJnz2/mqYk=;
        b=MYc3ge0P1i4XreDK6vV1pSVPxULvEgfmbru+ZCnrx/bUuch1/Y/V2f3+wlz4bsFYlO
         PruWVTk0JgMxXy9LRZKAS55cJdgMkNH+uJdPtRpobA3DynmzSOjh4BEUWoEtfpMZMe2k
         wDiUUfG+QmzQpTLLpXaX3Mdoon+/QadMxs8q8MssGesIeJymf1EN7OYtvoxblDX6sg/L
         qHYwxcGwLonTI6NThk/dLP/FT8t7LScfe2kh/FtTJQ0/NRwTqTquhVuBg6NudirG/Nky
         umA4Stpi9TuXRcccCSdnA726NwNMCZNMTcTclJeuqMXhDkv5m17QrIujeUyijOugcnl0
         mlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773071524; x=1773676324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly8aqb2t/EfTDPkW0Kau0FkQv2wta+tzkVJnz2/mqYk=;
        b=sNaqTQ5gDNUDI+3gpZKMOI8RhsYbYGE88XlbX37KJ434g/9/WdZWPCWE9h7TnK2Bon
         T1NmhEq8lG5lisJKOjN0Ec7kdS2ay/tv+5s63eW2QLiJBZrBZn1X8DLds4tIdtHjZrc1
         6opjvZQb2MHatutK8JFA6gA7GkOCVCiU8OVBnj68FHoBCijv7OM+v0FgSe01LCyIqpZP
         XjuUdyMlfAHqM2Vb/XZfbf/9ia4fm0RHmS9lzMfqHk67PuhtPyEdb/Li0tyHB0S3lhWL
         nwgZmqF9moKJsluz1UpfQxAfHGHkr4x6skR1rUoBLPMugFG0GDdztmv4UneYv+GsfkCT
         2VDg==
X-Forwarded-Encrypted: i=1; AJvYcCVSy8Z+WSho1C8CLx5SunXvKKjchqq0pkxfR8eRoqgJU6AryDWLLjZoQ7MkMrTilkmu7a5sH+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU6L9HPV2mvS9D2FNZcXllNrJ/jnqpndSPnHgbrJeT6GqHsic7
	fJgj67M8sU1ZmTzm7XPw0XGCYI16q6FefZIXJKq2UwAaj0n35MQG93oQj6NmJ95F9/w=
X-Gm-Gg: ATEYQzypJ5Okpy2r57bFim9hC6/IjVivyOdiw3WrjIdIWhCnHZCd9Xtf/XR74nYCnsp
	A8nWpLidP4pblWNdcl26kxSd+s8Tkm3xEJpdBy8fU/k9D2kn5zXC3qxqgsAuMDsMnsnI/FRDarR
	jA/eJuPlZo+AhuBnDdNGdPz5C3pLCggnJpWKtu8jtm6F9HydMIoI5n3LGAOuS0sLEpP9bpGmmuy
	yleoSwIu1GkqrFktrHksBQRf1uQgmMt1tNagBBdHM3gfd0ZKSs10JVsG6Dkj/oK/KdQbrUwfE70
	He2GWRLJQO5KXui40QGF0J1Wgfu0YYoi/xd+GjDpqDksCV0gTrb3DAzCpeb2CjS0QU2Mni0IVGg
	TLau4NgiBFnxMKLGFXnV+uTTZkbhL2yNvuRj9rY1t09mrk6d9HiVVWfjKt+WfYohULx+KG/ymRD
	XeEvZ3Bt2r/4ECCT9U7a+nm0xdHaqHbUjAevFBj16PePKiXrJWJvpgurN7AowMjKNzhA==
X-Received: by 2002:a05:600c:3112:b0:485:3ff1:d5c5 with SMTP id 5b1f17b1804b1-4853ff1d6f2mr28553765e9.7.1773071523783;
        Mon, 09 Mar 2026 08:52:03 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:5e5c:35f2:2762:2c6d:a7fe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f8078c6sm11478341eec.5.2026.03.09.08.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:52:02 -0700 (PDT)
Date: Mon, 9 Mar 2026 12:51:58 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: Bharath SM <bharathsm.hsk@gmail.com>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, dhowells@redhat.com, 
	sprasad@microsoft.com, pc@manguebit.com, ematsumiya@suse.de, bharathsm@microsoft.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] smb: client: fix in-place encryption corruption in
 SMB2_write()
Message-ID: <nvmbb2fbm2zkqyk4x254d33llskfldguygq5pfkedv36upems7@jcofwqya42t4>
References: <20260309103049.22169-1-bharathsm@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309103049.22169-1-bharathsm@microsoft.com>
X-Rspamd-Queue-Id: 4AF9B23C32B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223694-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,microsoft.com,manguebit.com,suse.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Acked-by: Henrique Carvalho <henrique.carvalho@suse.com>

On Mon, Mar 09, 2026 at 04:00:49PM +0530, Bharath SM wrote:
> SMB2_write() places write payload in iov[1..n] as part of rq_iov.
> smb3_init_transform_rq() pointer-shares rq_iov, so crypt_message()
> encrypts iov[1] in-place, replacing the original plaintext with
> ciphertext. On a replayable error, the retry sends the same iov[1]
> which now contains ciphertext instead of the original data,
> resulting in corruption.
> 
> The corruption is most likely to be observed when connections are
> unstable, as reconnects trigger write retries that re-send the
> already-encrypted data.
> 
> This affects SFU mknod, MF symlinks, etc. On kernels before
> 6.10 (prior to the netfs conversion), sync writes also used
> this path and were similarly affected. The async write path
> wasn't unaffected as it uses rq_iter which gets deep-copied.
> 
> Fix by moving the write payload into rq_iter via iov_iter_kvec(),
> so smb3_init_transform_rq() deep-copies it before encryption.
> 
> Cc: stable@vger.kernel.org #6.3+
> Signed-off-by: Bharath SM <bharathsm@microsoft.com>
> ---
>  fs/smb/client/smb2pdu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index c43ca74e8704..5188218c25be 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -5307,7 +5307,10 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
>  
>  	memset(&rqst, 0, sizeof(struct smb_rqst));
>  	rqst.rq_iov = iov;
> -	rqst.rq_nvec = n_vec + 1;
> +	/* iov[0] is the SMB header; move payload to rq_iter for encryption safety */
> +	rqst.rq_nvec = 1;
> +	iov_iter_kvec(&rqst.rq_iter, ITER_SOURCE, &iov[1], n_vec,
> +		      io_parms->length);
>  
>  	if (retries) {
>  		/* Back-off before retry */
> -- 
> 2.48.1
> 

