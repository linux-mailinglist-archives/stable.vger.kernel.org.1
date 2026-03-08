Return-Path: <stable+bounces-223439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJPsFrXmrGlFvwEAu9opvQ
	(envelope-from <stable+bounces-223439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 04:02:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 557AE22E5D7
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 04:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 247D830046B4
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 03:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615D92848A7;
	Sun,  8 Mar 2026 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn6/9Zo9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0915C158
	for <stable@vger.kernel.org>; Sun,  8 Mar 2026 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772938927; cv=pass; b=V6PIalJ9u6MMU/66VfstVhrCXZ+s38SVCtf69umZ63oyTVV0swms+Wx+V8gG8+zajuXQB773SEX/ESikPevat13KNFLv+5NmxAqPZXV5xLQb7Sak+E11Ofcnq5UkfXBEEdmVQGMRv7boCSmndMpuz2LkcIYA33eZZajS2Z2QWqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772938927; c=relaxed/simple;
	bh=na3CEXYe5VYNa04bxP+z3EvvHcJbLcb5PIkCbRIr368=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiOcL0JHUpCC7Q1rvQXGQMjhwuSjdcRnhriM/2Tun6dg8mpwB52OXZrebpfaIXuA7/A8x3nONpP1dVojjXXyLu5hHzYmYsMGVcr0T6L+5p4Rqikw2QqTUG3CBVM/4/jzCKi0cxpLunJzY8IftOK0vcmgA1sfJ3MEh4JoXIbw7z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn6/9Zo9; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb3825b0fbso1047022685a.0
        for <stable@vger.kernel.org>; Sat, 07 Mar 2026 19:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772938925; cv=none;
        d=google.com; s=arc-20240605;
        b=JFWeF0kk6pFrjk4Y0r3azFfBQolkg/y7zfajurLxR+MTi7IH580mJrSxmW1y5c3FAq
         66tJgpIl1Egs+gKMeK5YC4EZxGtSZc3Xlbmjqmym/xeeYNLWSDdNTP4xR+DrgTj99exz
         lSWJRbjNopBbn33raDH7QazvrSZ0JAGAdCxdRPb1THA4JfGOIC6uXficmud7EdrHewcp
         OQJ32sJhrPGBNhADxE0zVSbHtj/AbdaY964XJT1XeJriYC/UCeptQq0AZYko51twWGjl
         PtXa4+NZpmj3aKvrZQtfZk7w/IEgNj2j/JM0TnQiIOtTYNhgPzdSUVdgBtAlzqTjbf/j
         9q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0b9UiayA3it40t9bJgAqpEj1p345wqtLgZz4wISOPp0=;
        fh=oQsLuUkfLVLWTVhlFh9l7xVfRBoZwq79vFPgB8ljmxw=;
        b=IGRRmNdB2ARazW3m8i0ZiMgDTVgUWdoe5zucRVzMb4+pEmwX2VhcLyJ8bMPcgf2KSY
         Izi12qNW1J2DoK1ISeyETgnzfRash/mIWsh7MrITslxXBjE4bbvWdJzabP/ZoY6XH4Cc
         BghsZYKNhncXikbGkdgoqHMp+1i4DvFMXut94je1t+lm+NFH7D5cRvjsIoWu9cKUhU4L
         ZfcLeR7mIpGFqx6QN+aAUSBHDrk94TOItxfjD1pkTA6Qre7AgPQoeo2bXG8Sbz0wd0tO
         muzi/HKPH7y5lJG49CFm0mlEbrpu/GkEAyB6AtntU4EPAyLgVzdjLfcgUNvygFvw4ud8
         DKAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772938925; x=1773543725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b9UiayA3it40t9bJgAqpEj1p345wqtLgZz4wISOPp0=;
        b=Tn6/9Zo9kXHFDWfxLSJdiSPSnXFsvSiYvrFLn+88CAQUn2xSkD+U5NqoB2K8juSlpo
         cv4r9fJsJszwY4ed46YwKGYkkrjf6RpQSb371vL8goD7a6PPvzeQT0sNTD47TDbmjWkp
         prbIjUS/1dIpUXq9cg5Pi3L0O+/2qBo1QdkPqJewtByIZ0HlWirhKwK+gYmjjEfPYnH8
         Cty8YI+vgdI9atbiKXh6fRXreBlxmpgi5V+KmLMEC7amBDZf78I5QOpROCQ3MSngAwB1
         qTdUCl2AjT2X+gLrpxFdSA2z/gqsztbgtDzT+fwYhKUYHkNIS71S85+HsLA4uD/xwLdv
         ojMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772938925; x=1773543725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0b9UiayA3it40t9bJgAqpEj1p345wqtLgZz4wISOPp0=;
        b=atmy1MeJDzQ5V6gheA4JhpJ2/rLFuTbjAz0kmfDCGWbEXjtqZWk+8kCbgU0fkLBTun
         LzZ5qoG1rIWY9769I5DKBnYJwMZpYLro24+90/clfWVpgCKPWQAwiE4fGgd1YvXghKt4
         biS/4Q+0QyOxSsswqp50eunVfJd6gCnNZJpE1IlAvMQZXnSfzEyx/l5Q/dRsiSY+Q8O9
         hGLvb3JlQr3KjXbkzw+MfrzpgS0yADADhJf0MQIqjgm6GaI8viKrL7XbCP9b5oRfq6zU
         gxrOCfFPnQ7sMnu2rCPVPpPLkbcR+ShWtvCYIiOnzpqe/u5x/8NwLNEns0FqGjwR1mNy
         KDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0MQtTdCpsTfosYBBJ+APFjT1wpwBJ841a99/rphaacAaAhmq0y/B8vTP944TaqxEwPbSumUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHw2+w8PLcVSj6kAbAh37YB4GraMgCc4ZIZb7TKP7/9Q5zJf89
	XTO0V2aNgACoBzP8n89zJ/TcX1/Fmeip4Ilbuv1D+HpyZI1Acn4UCCidkYCn6pba2yRRec1vO+Z
	ifgOCPH6I3ZTftLafLRd7Ir4+g9/1zpE=
X-Gm-Gg: ATEYQzxVe49f/6/9jx0aky46k35iVvkaDKae9ZFxhpDezxNZAYBqaAWaR5jfV/TLF1L
	QJCg9Pa/QsmgI7H97VC7ehU7x6edJH/uXWsJ9lY9gFTTT90Fyhq+YbEZ9aXisQB0nSA7qU+N7f+
	UuuYemjtlkIhCKJHLxKbjp15sI6jVZSIVcS6ie1ywdUDih3yjXO6TiVIycvWjcRqzC13drpCPTc
	0+HSTahuxgCH4rAg5iSxpJqUTiP2QIHN5TMRM8S8EnQQu/hTWOO/f6Nbf+MqkZgOalNU7V1noui
	hLyh0HWsf/o8j5II/A2IP5EROWC4R0vzwtT8eRbXO4r+Dqlm0NJA6H3BALT20XTKzk50zWOyBX4
	VgRj4JrXQywQRg6j5TRcFlmKtMGX73FueLU5nKH8vTJltoPxOaP/qhqGrKwSzQ44Lj8sJ74o+0I
	JHtnH4bZpLV+Y73SRZa3o+1A==
X-Received: by 2002:ad4:5e88:0:b0:89a:78c:7cf2 with SMTP id
 6a1803df08f44-89a30a5ef7fmr107101396d6.20.1772938924803; Sat, 07 Mar 2026
 19:02:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212016.1328931-1-pc@manguebit.org>
In-Reply-To: <20260307212016.1328931-1-pc@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Sat, 7 Mar 2026 21:01:53 -0600
X-Gm-Features: AaiRm50qYatmPyY4sLko0GYgd20OsgwVPIdVaiTS5dCt54-YGh5USYTNNkkjLMs
Message-ID: <CAH2r5mtnfxaZdsu=9byknrk68LLnpzEM0x89k62_h9AkieqX=A@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix atomic open with O_DIRECT & O_SYNC
To: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 557AE22E5D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223439-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.903];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email]
X-Rspamd-Action: no action

merged into cifs-2.6.git for-next pending additional review and testing

On Sat, Mar 7, 2026 at 3:20=E2=80=AFPM Paulo Alcantara <pc@manguebit.org> w=
rote:
>
> When user application requests O_DIRECT|O_SYNC along with O_CREAT on
> open(2), CREATE_NO_BUFFER and CREATE_WRITE_THROUGH bits were missed in
> CREATE request when performing an atomic open, thus leading to
> potentially data integrity issues.
>
> Fix this by setting those missing bits in CREATE request when
> O_DIRECT|O_SYNC has been specified in cifs_do_create().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  fs/smb/client/cifsglob.h | 10 ++++++++++
>  fs/smb/client/dir.c      |  1 +
>  fs/smb/client/file.c     | 18 +++---------------
>  3 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 6f9b6c72962b..2f4470f9df58 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -2375,4 +2375,14 @@ static inline bool cifs_forced_shutdown(const stru=
ct cifs_sb_info *sbi)
>         return cifs_sb_flags(sbi) & CIFS_MOUNT_SHUTDOWN;
>  }
>
> +static inline int cifs_open_create_options(unsigned int oflags, int opts=
)
> +{
> +       /* O_SYNC also has bit for O_DSYNC so following check picks up ei=
ther */
> +       if (oflags & O_SYNC)
> +               opts |=3D CREATE_WRITE_THROUGH;
> +       if (oflags & O_DIRECT)
> +               opts |=3D CREATE_NO_BUFFER;
> +       return opts;
> +}
> +
>  #endif /* _CIFS_GLOB_H */
> diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> index 953f1fee8cb8..4bc217e9a727 100644
> --- a/fs/smb/client/dir.c
> +++ b/fs/smb/client/dir.c
> @@ -308,6 +308,7 @@ static int cifs_do_create(struct inode *inode, struct=
 dentry *direntry, unsigned
>                 goto out;
>         }
>
> +       create_options |=3D cifs_open_create_options(oflags, create_optio=
ns);
>         /*
>          * if we're not using unix extensions, see if we need to set
>          * ATTR_READONLY on the create call
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index cffcf82c1b69..13dda87f7711 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -584,15 +584,8 @@ static int cifs_nt_open(const char *full_path, struc=
t inode *inode, struct cifs_
>   *********************************************************************/
>
>         disposition =3D cifs_get_disposition(f_flags);
> -
>         /* BB pass O_SYNC flag through on file attributes .. BB */
> -
> -       /* O_SYNC also has bit for O_DSYNC so following check picks up ei=
ther */
> -       if (f_flags & O_SYNC)
> -               create_options |=3D CREATE_WRITE_THROUGH;
> -
> -       if (f_flags & O_DIRECT)
> -               create_options |=3D CREATE_NO_BUFFER;
> +       create_options |=3D cifs_open_create_options(f_flags, create_opti=
ons);
>
>  retry_open:
>         oparms =3D (struct cifs_open_parms) {
> @@ -1314,13 +1307,8 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool =
can_flush)
>                 rdwr_for_fscache =3D 1;
>
>         desired_access =3D cifs_convert_flags(cfile->f_flags, rdwr_for_fs=
cache);
> -
> -       /* O_SYNC also has bit for O_DSYNC so following check picks up ei=
ther */
> -       if (cfile->f_flags & O_SYNC)
> -               create_options |=3D CREATE_WRITE_THROUGH;
> -
> -       if (cfile->f_flags & O_DIRECT)
> -               create_options |=3D CREATE_NO_BUFFER;
> +       create_options |=3D cifs_open_create_options(cfile->f_flags,
> +                                                  create_options);
>
>         if (server->ops->get_lease_key)
>                 server->ops->get_lease_key(inode, &cfile->fid);
> --
> 2.53.0
>


--=20
Thanks,

Steve

