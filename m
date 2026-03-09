Return-Path: <stable+bounces-223709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJB6Ebj6rmnZKgIAu9opvQ
	(envelope-from <stable+bounces-223709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:52:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395A23D1CC
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2CDE300107B
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7992741B6;
	Mon,  9 Mar 2026 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8i9w6fM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54322A1D4
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074999; cv=pass; b=dbtr8W1G7Uz7tDBXTrEG0gGPCBkW0mqV7GZ74vhtWy3dCYiERonrTbxOA1qHYRKmZtOuhLJhvYy3R0g3Q1nbsFsfQtlmsX4MZA6Doov38KnG9vVDZJLV8PyL/DUN697n/CzyDiExfGLJ+OK4DwB8xAnxzEZ/9DtwV48lxdtlrrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074999; c=relaxed/simple;
	bh=KAaPZbb0DZR9Gm52FjNA4Inv7exM2JbDH3cVjDEaakU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1XQIMG1aaMEoAgplrDKvq2g//ago52lofJuCm2PseJ1gXDAaSOd0bDwpHHMOYL0yiFwnQCAfNvxBWUTMHXFs+aU9QWcZYN6efPEgn7xx3Qli5JUl5id4EoelsIslpEfeo891GnF0Ly1ZKHBYr/WA/pfPDpPrpyHHHtXmgZSr90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8i9w6fM; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd90401034so61531685a.0
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 09:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773074997; cv=none;
        d=google.com; s=arc-20240605;
        b=PxYHZhKjH5yRG0mOaGgfFaD/bZsR10Ao6vSWRw410mRGUG7WSU1fV1QhBRByPpacvx
         +R+YO8qs9STZ5zGAW+6FowVzXR4R5ekHgj4cPuXDvQMsFjAaPOMa29ZQ/J8KxjCaEZRn
         zD/qJ8pJ61fulk67m+HH3CRU6Cnp96k2frBUlO03awS1Qc87J39zT0a3dsoCV2YrY2LL
         hsUadrssBKLBhL1DAz6DuPRCLR6TsLYirg8oqgtqyWKL/kn21lC/FTeljdbwPwveYue0
         WhSBvewk1PLqMmiYPUhqclMlP7FtHQwhjzXYVSd7BSR1O+o8aMp9TnVPJ0+vdXHi47tg
         UcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ezYVrHR1lgcWwO9n3xsdtR2MeYabbPAdyBaDkHGJ+Z0=;
        fh=Twe8LfSSzCRuKFh4R8dnC2TIy69Rmx2fuF1hUsegUmI=;
        b=d/P5M3UlXS4eBPsWvlRDHiTSYM8wWoanKLHktJzml/v9WnxtsLTLwoOUOveZ+nGQrY
         vPXs1iqiK8/rxC4+tc8l7PKutdancZIZUIWw1Zux1R7ydgj5Jsu9fVAVMYW+kR6sIZD0
         564Nfahl3zPCxeA8DoEoqrVFUVT5O+zIVsc943UwXuO7U6lIeovZVu8GAMtrClqbYu1a
         9hG9KauL63sDRGqnyveWZ+YEwjPe9jZVuhpA7ROCDXhmzfOUvfph2/rvdYbB5tGk296G
         Z1bDJngh+nllrB15IYFuPxyiy17p13iiZkioil1uRiBljAKBUbvNvSDqw1IZktFWJZfU
         DRvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773074997; x=1773679797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezYVrHR1lgcWwO9n3xsdtR2MeYabbPAdyBaDkHGJ+Z0=;
        b=e8i9w6fMF4QIzhv3ERPxJnOHdSDX30bsicBiXS1x7nPzm/Nxjm211pJb1cY+DiJp7k
         /kQlgwSJzst7XyAmU+acGborBFlDC2wc2sXLn/KRTdN95WIqp4p2bzntBGF6A2gHAD+5
         KR5Ky0cs0fjzPe5uEuOspEWNm+ZUtjycYSaErI7plcL71QzXQt+4wW2J7ol/wM5JpR0+
         wSzC82IaSA6gNy3BOQnSL33CCQNINWJyTx/UxmkwcEXvWUWzULfUKYrTtoMXTO30KQdG
         kyO/kXn6dhvvx3yn7iZAyyYSau/kWVkT5d6yJqKU1mx8X6GhNulohMgSE7iSIio2TSk+
         TZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074997; x=1773679797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezYVrHR1lgcWwO9n3xsdtR2MeYabbPAdyBaDkHGJ+Z0=;
        b=OsEpIYu08waruM3bnSFOe0/ZcxiKdSu3X8qCNt0xZHwg9W3jb3wqE5TRV+s7lYDro1
         P7TRH3BUSGh6L2LwhzBNP5ouvhJ/7ctCSHYC4NiDbPvYiQ4vjaMUH/cDkNO1eWe35BLq
         tinW/JEUqL+EmPqHiGl06MD1X7rpEVbsj+CnSkfTMOnME9GBxZ1B5fpnL1MdgrBGV0Pm
         YjSy2WlwFbsbAYwSnG75QkXdUhJTIMLw3jniBC3Bvo5swoaT0m92fEVk6Qr540GF7Zyl
         /CxGk1LqDW9X1K3G2Q5DMEee9Su6+Ok5rO/XSoHUlOM4h6AFZnUelW+bPCLBD8ue82vK
         zVsg==
X-Forwarded-Encrypted: i=1; AJvYcCUJCjyZC4E67v4RFNLXdRzh9u9HnW9rEUghCdt7WNLJv9bkRRyLyX/HAN3WPZYfBXzBuuoUzgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFB5zhAZfQSPKQwESxuUb0ZGwVUMVsljcExdb3ye5urAORT/ec
	m4uOadAT87k/eJa09LKKWSImaB5V54TOJg80GxN8+P8Tn1hWFUHjrB+G7ZCkg/nyUj7L1H3tAT+
	33yxwVekgX5CKzBp8EFqXUBjZpK6erk4=
X-Gm-Gg: ATEYQzxk1EP1aToxgjW/mEtDQ2fKVkJ60I8Szgz+PY1W0cAZzCAwqmnHbJxF9dWoR+k
	P+hAAy7h07sJL4asct+DnLRYG22ViB1cFgaN5OaN/0eVrIiQvUniCdc2BUBW/9wzdNnwMx2KXIL
	Tq0V37Z4O1zV2fDcMxb6157mgIjI5T0amlnqG2iG4MNNRIRamoDEQXePurOs6l6G925hNh3MpVS
	j2oNi7JKVmldSKSiXSLnR0lWflwHQkpVn/ZMfKnI3PBHOcU82iHOY3Mus9rk0/k2dtEV5eMaGRV
	PEQ4drdeui7flmW94jKfMxQTaIGveD1qQ40ejacwOILHZ99+4seqGAfZ1XFsfqyVDIBZgUKrk3d
	lio4is+u7Y1xKtJagukFaKI9zNrz8wkZkOAczTkHd+8kbYc3/98S8YbgtgkR1GGfcoHpREg3hGc
	cpb7xESMvK3GZeDyTx6VP4
X-Received: by 2002:a0c:cdc1:0:b0:89a:ec6:102c with SMTP id
 6a1803df08f44-89a30a348b0mr122617186d6.19.1773074997053; Mon, 09 Mar 2026
 09:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309103049.22169-1-bharathsm@microsoft.com> <nvmbb2fbm2zkqyk4x254d33llskfldguygq5pfkedv36upems7@jcofwqya42t4>
In-Reply-To: <nvmbb2fbm2zkqyk4x254d33llskfldguygq5pfkedv36upems7@jcofwqya42t4>
From: Steve French <smfrench@gmail.com>
Date: Mon, 9 Mar 2026 11:49:45 -0500
X-Gm-Features: AaiRm53tLnbdLcEbou2BkAZ73WFR62nyhqqgct1D2L97UsGXrHnh4TsVioqBhIg
Message-ID: <CAH2r5mtjTN1gs0sbZsKtRzRO6vRfYFPpZc-14EPfRSKPOoqbag@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix in-place encryption corruption in SMB2_write()
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: Bharath SM <bharathsm.hsk@gmail.com>, linux-cifs@vger.kernel.org, 
	dhowells@redhat.com, sprasad@microsoft.com, pc@manguebit.com, 
	ematsumiya@suse.de, bharathsm@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4395A23D1CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223709-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,microsoft.com,manguebit.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Action: no action

merged into cifs-2.6.git for-next

On Mon, Mar 9, 2026 at 10:52=E2=80=AFAM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> Acked-by: Henrique Carvalho <henrique.carvalho@suse.com>
>
> On Mon, Mar 09, 2026 at 04:00:49PM +0530, Bharath SM wrote:
> > SMB2_write() places write payload in iov[1..n] as part of rq_iov.
> > smb3_init_transform_rq() pointer-shares rq_iov, so crypt_message()
> > encrypts iov[1] in-place, replacing the original plaintext with
> > ciphertext. On a replayable error, the retry sends the same iov[1]
> > which now contains ciphertext instead of the original data,
> > resulting in corruption.
> >
> > The corruption is most likely to be observed when connections are
> > unstable, as reconnects trigger write retries that re-send the
> > already-encrypted data.
> >
> > This affects SFU mknod, MF symlinks, etc. On kernels before
> > 6.10 (prior to the netfs conversion), sync writes also used
> > this path and were similarly affected. The async write path
> > wasn't unaffected as it uses rq_iter which gets deep-copied.
> >
> > Fix by moving the write payload into rq_iter via iov_iter_kvec(),
> > so smb3_init_transform_rq() deep-copies it before encryption.
> >
> > Cc: stable@vger.kernel.org #6.3+
> > Signed-off-by: Bharath SM <bharathsm@microsoft.com>
> > ---
> >  fs/smb/client/smb2pdu.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> > index c43ca74e8704..5188218c25be 100644
> > --- a/fs/smb/client/smb2pdu.c
> > +++ b/fs/smb/client/smb2pdu.c
> > @@ -5307,7 +5307,10 @@ SMB2_write(const unsigned int xid, struct cifs_i=
o_parms *io_parms,
> >
> >       memset(&rqst, 0, sizeof(struct smb_rqst));
> >       rqst.rq_iov =3D iov;
> > -     rqst.rq_nvec =3D n_vec + 1;
> > +     /* iov[0] is the SMB header; move payload to rq_iter for encrypti=
on safety */
> > +     rqst.rq_nvec =3D 1;
> > +     iov_iter_kvec(&rqst.rq_iter, ITER_SOURCE, &iov[1], n_vec,
> > +                   io_parms->length);
> >
> >       if (retries) {
> >               /* Back-off before retry */
> > --
> > 2.48.1
> >



--=20
Thanks,

Steve

