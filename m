Return-Path: <stable+bounces-225654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LFgM3BLuGlTbgEAu9opvQ
	(envelope-from <stable+bounces-225654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:26:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7720D29F048
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E9C304520E
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A983D411F;
	Mon, 16 Mar 2026 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb8ho7fp"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B053D903F
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685581; cv=pass; b=LrQ/ZunlF3yNilZsuPFKxVrKdnxbq5fGXFl1yoJNzoxRLZQ6Wv4Ax79CfIUPTexc7OO6ySzmujqkvpMEYRUIrMjkxs1EotylwDSmN2tCODShwToD0m2SuhgK7JXJkCSfVnjLc9yNvux1oaJ4/QVCLoxxyA0b+cdyZMU5coDv7u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685581; c=relaxed/simple;
	bh=ODuNhgRZuf+DphxmAeK9W2ttr4M7Xg3l+26yw6FQlUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuSWh2sDbB+jlpx1nU/mX9peX7J9BfXjbkIdBeSBrXfIYUIp61xrnNLw3La2wItOKfe1RDZoChgUjZhPJWb/ubFgB1nA8JgxVLOMJ9/Lrr3fXGOtVDJp7nOouTnAAGuqG/6JM28eaB+JyadaTzhOM1BP/mtVN8bqEbYzZiBfiUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb8ho7fp; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79800183233so65387297b3.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 11:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773685573; cv=none;
        d=google.com; s=arc-20240605;
        b=KyVFbpHeU5r5UmQyg3Nsd66q9bPnrC05uOqxrYzsDUHECVxn4vXRC2iCmKZ7J6/DKC
         ToMg20cnNxRydo7hSEvwjvugj7t8W8hgQiwz+I2jKK3NonKx49RGscDZNuUPUWVovAPH
         XaCq7x+KYUp0v1EGhRcPIQUtV1wJIZAt//zVDlJezRm4tloIo+JXxxGs7mGUFyeyDrsf
         HRwYpF4JeDRCU3TmbWKvgiv2RT1Zo6ql6Y8uOZ2RAZ91/wxbeSO9EYJgq3UNeQRHxJgd
         3bwB7lPLbaGI/6Igw6zWfZw8Ab9Lc0/EBJS4r6WFgboS78J89ZjBaNdxWFbmt27f2e6r
         vZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3kkpPvX9iiQRabDqcRFUBUlzbFZGaOhyaGyOhqlkCgw=;
        fh=rmhnsSoasPSMdwf8/6878o/xFrNv8lmsnyIIOyMXQKs=;
        b=PiGyv0++D02vujOrE72eYY366r8ORptoS0/HMG/NdzVNmc1JZQ46k+XsusxbdL095L
         R7Y1WWqqvnjpbBTNLUDPMV9B8V2fhFSweMcUJLJqgDsk+d61BVfhHtoyAa8tnPFiUdVb
         3OWKXOxZynHE6iob136tszvVlWCSZMJdqDOFBEhXJaocj8zInUIymyk51bM9r/cf9kFA
         h06zNH3xHF24u9fyJhfkBHG/4euDp03WLGELC3arrLVqGBoj/ulHvuVNbmIXAMAYmPko
         FC1mYpkf5IF5FVObDJq+vbT0usM/k6Hb0sa5ROQeYUWwV6X/I+RHkkIdE6AYOMZXX3+l
         wKAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773685573; x=1774290373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kkpPvX9iiQRabDqcRFUBUlzbFZGaOhyaGyOhqlkCgw=;
        b=eb8ho7fpiAzg5iccyn/x+a7GoFAwWxs9bcZfq1i6xtw7pWMV6BzJSeMtWybj74fQiS
         zdKNO6eNir2HBrzL32QlwfziAlfMDZuRBI6ARrSgqxiRVmDyw6X2N1EKf6SRXBFMtLlV
         jja6mVinICAR9kX+cGNnYbi3v8DQfMpk0bPbCpoqg77Zh8boajP/9YmfgEFrbSFNwCYa
         mctG+l58XuZNz842eOvRcLfDWfeeMZYDWGYUWs8BQdqiK7VekRJ4S88vrVeNCC7H+dzv
         cWCkc9o2ApQV/J/GQBLKWN4s56kRRuN6mpqpKeoEqa2W3v6cmY/qtL8L1myl212SwUbE
         E4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773685573; x=1774290373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3kkpPvX9iiQRabDqcRFUBUlzbFZGaOhyaGyOhqlkCgw=;
        b=djfVkQ2y6fO++Xgy8hiJX2Q6+ADlZ5OddmQqBV/ufaDtUBSdiopty2qw8fIziAp+Rm
         WrQnDAK85pETJyLE+uBgBmaras2TuGqTrw68I17IzbaWG8FkfQs1w4pZVRaOCGqutAPw
         JsHNl4R/tBDDlEBMLsI/8l/hBD+bgOJ/9/BWJEhfPbsM3uVjhndhmWhhzMSgCnkknqDe
         Rx7fejNwfRIfsHPJzZ6N2bzM5h1lYvukMpiEs0Uzw7b+EIoeie1fkRRsXPcSUJGlA7pd
         0l3ZQisvbN0GIqBen3p2Kc4orbywzrIbF1NvoD6MLFl/35Qow2Q7iJEe+O0AM6yqxH6t
         zmFA==
X-Forwarded-Encrypted: i=1; AJvYcCWwz72a1rMJYijyw376bspJdKEc4SImFOefK50jvUGA/HZirUMgFo9kX6mllKwxhZwuyZ37NQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01FS9EtWwk8OsZB3h4ANFtSMo/BTWG7z+8cvaDgxKCqB0UwnG
	EFthqjYxCLwotHJpboO376tbCiqtCJwWEuJ4qpNe2wwmKy8AA6Usi1Ym8EJWLmjeKrGKuzaHHpK
	aHi29P5QilEtyXyIyrPWJQaZ463vpN0I=
X-Gm-Gg: ATEYQzxlAyJxqETGDjjccxw6qkvcIjyT5TexRMJiUgqG3hRtLqSibcicX7z3DUh75+e
	4l9bsqC4K2Bs8tXlmsYCuE+DGbcOw0uXwPx2TQcyGGb/xU6kd1D0063Cbbq0HpXO3KsBmo/pocr
	Z6UI8nTy57scXPEqCfh1HzGUtw+BnQGAGPZI0jiRbkjxVsdoiquTnKHTRFU0qrQNWv+DtwzANF2
	dJO8V7+2F+D6Xcr/VjPnEoP6Rh0dOZbx7askwpME+OWWUjYC5a2ovIzlbbaGE+vc0U/MM0oMobY
	s4l2DL5izW+MD17UOK0pcZ6HiIdpY8v6bJZMAEg=
X-Received: by 2002:a05:690c:398:b0:799:1913:1157 with SMTP id
 00721157ae682-79a61843aaemr6579057b3.16.1773685572704; Mon, 16 Mar 2026
 11:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304140452.1606662-1-bharathsm@microsoft.com> <2026030442-cleft-appealing-93ec@gregkh>
In-Reply-To: <2026030442-cleft-appealing-93ec@gregkh>
From: Bharath SM <bharathsm.hsk@gmail.com>
Date: Mon, 16 Mar 2026 11:26:00 -0700
X-Gm-Features: AaiRm52vkx1o4KUlFUplZY1SlPbCSAIAgITGANrDqlX316hTVt3Fp6-hQME48bQ
Message-ID: <CAGypqWx543J5t2nYPOUEPS_WJT=w=n90NMq1Z-XgMUCa=e845Q@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] smb: client: fix page cache corruption from
 in-place encryption in SMB2_write
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, dhowells@redhat.com, 
	sprasad@microsoft.com, pc@manguebit.com, ematsumiya@suse.de, 
	henrique.carvalho@suse.com, bharathsm@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225654-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,microsoft.com,manguebit.com,suse.de,suse.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharathsmhsk@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7720D29F048
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 4, 2026 at 6:22=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Mar 04, 2026 at 07:34:52PM +0530, Bharath SM wrote:
> > SMB2_write() passes data kvecs inline in rq_iov by setting
> > rqst.rq_nvec =3D n_vec + 1. When SMB3 encryption is negotiated,
> > smb3_init_transform_rq() -> crypt_message() encrypts data in the
> > kvec buffers in-place.
> >
> > For synchronous writes through cifs_write(), the kvec buffers point
> > directly into the page cache via kmap(). In-place encryption overwrites
> > the page cache with ciphertext. If the send fails with a replayable
> > error such as -EAGAIN (e.g., from a connection reset), SMB2_write()
> > retries the write using the same iov[1] buffer. Since iov[1] now
> > contains ciphertext from the first attempt, the retry encrypts and
> > sends ciphertext-as-data to the server, resulting in data corruption.
> >
> > The corruption is most likely to be observed when connections are
> > unstable, as reconnects trigger write retries that re-send the
> > already-encrypted page cache data.
> >
> > The sync path can be reached during partial-page O_WRONLY writes when
> > the page is not in cache (common for append workloads with repeated
> > open/write/close patterns).
> >
> > The async write path (smb2_async_writev) is not affected because it
> > passes data via rqst.rq_iter, which the encryption layer handles
> > without modifying the source buffers.
> >
> > Fix by setting rq_nvec =3D 1 (header only) and moving data kvecs into
> > rq_iter via iov_iter_kvec().
> >
> > Signed-off-by: Bharath SM <bharathsm@microsoft.com>
> > Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  fs/smb/client/smb2pdu.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> > index a8890ae21714..a88a19dec494 100644
> > --- a/fs/smb/client/smb2pdu.c
> > +++ b/fs/smb/client/smb2pdu.c
> > @@ -5072,7 +5072,11 @@ SMB2_write(const unsigned int xid, struct cifs_i=
o_parms *io_parms,
> >
> >       memset(&rqst, 0, sizeof(struct smb_rqst));
> >       rqst.rq_iov =3D iov;
> > -     rqst.rq_nvec =3D n_vec + 1;
> > +     rqst.rq_nvec =3D 1;
> > +     iov_iter_kvec(&rqst.rq_iter, ITER_SOURCE, &iov[1], n_vec,
> > +                   io_parms->length);
> > +     rqst.rq_iter_size =3D io_parms->length;
> > +
> >
> >       if (retries)
> >               smb2_set_replay(server, &rqst);
> > --
> > 2.45.4
> >
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.

Thanks Geg for your comments.I have submitted a modified patch to
mainline with cc: stable@vger.kernel.org
"smb: client: fix in-place encryption corruption in SMB2_write()"
d78840a6a38d312dc1a51a65317bb67e46f0b929
Please help adding this patch to stable kernels >=3D6.3.

