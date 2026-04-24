Return-Path: <stable+bounces-240559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDMaKZjs6mnCFgAAu9opvQ
	(envelope-from <stable+bounces-240559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 06:07:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F47459A74
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 06:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F06FD300C998
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 04:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8FC3264CC;
	Fri, 24 Apr 2026 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzkKsuOJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B009211A28
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777003663; cv=pass; b=OBKlnDGOXDk5G/J/JNL4sRN/K632cWV5E50YUN2R/qeiNcODi/J5Xgi1UxF8Dv67APuq5YaScN+fC+cofv0IsmIGwKV8/4P5GQMrIuONxuIuyEe6Y6+LpUK793Xsq840M8Y78VspkC0lz+2xHZ3MWQdMeI46ua034f0n7uieg+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777003663; c=relaxed/simple;
	bh=8lT7lc9gnjls/ciyCvKLODuCStiG/EA7QUVInLxPsxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLbModYqO7+cjNm8o1cdNEa9BlgDt65sQNYCzHDEbzEfuZzRj3T6QCixXZ4QHlRtYUe3dj1SPB+xyuaJTDPiaEE8qaR7d1kS8X7G1PQYJrHPWhsilmvtif4ekn6iSncaZcwBmH6gJC92LxlrYOFzWzNBXhNFma2ULMDzsL0KLu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzkKsuOJ; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba67b332bbaso824922966b.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 21:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777003661; cv=none;
        d=google.com; s=arc-20240605;
        b=KdP9dtuumPINBvZo/0IUU9wmokUv8zKZlrrg4FQiVCQeyzNEWbduIm7+niVPW+R3GK
         r0o2Lc1wCyPbBqUnOidPv4jZgBjUZbPhsWCH+meyZnW9kWgF4nuAlG8AE8lYjgZBbBLr
         nR6iZADGFFDLzowFpsKCDwzE3zY72Fz0Z4Z8roCT0Ai2QGC7zy1pcc3sfY4ckBD8l9ia
         5J4sg03hRu8vIJ9WUqFBGDNlF5m+Svj7uFLSdWDJlckoSn+vQ2oc2VlTo3dY2jmKUWe+
         mJPaClu22vK9Gb3NFxt1MoBywnKs6c0oPL1fXpYtcWj14aSIyK2EQv14NE6wIXJLPCyE
         9FXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iI2n+RqTAHgebFCF3Qcd87I1wf5GwnnOD9L0RHCmZxk=;
        fh=8HDl3A0yFJhygGMSLb7xGAFVFE0UgpRwd7n+axvUUXw=;
        b=LUvpJLs29uz5m3FGvjolnDMIermj8z98lRhoyTAIVkI1psLrk3BwSf4lbQJaPAUrkW
         4pT/P70tH/AnINvD9o1RKXaIW8yf/j8VTCYhn9m7TKRHYfCdoDhA65MeEbSRRg86S9zm
         a+z3055sNIlICq8BMevV//JN9ah2ENm/q/i+XsmrLtNVYQAMMe6w2UZoq2Hdy+y2VSmX
         YelvXyaQ4vQ1m8aLirrknIoTxkfKVYgF6S958Sl+VCUi2QrXlB05mGXU+jZ6PN+mF9Rw
         aB8ybqwViJgP8Vx7AmZYQaOc9e4dx3usuCHJfna7lB/FrsGUuSe63e7G9BtRZQBz11FH
         HS4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777003661; x=1777608461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iI2n+RqTAHgebFCF3Qcd87I1wf5GwnnOD9L0RHCmZxk=;
        b=JzkKsuOJELGr7bluJ0y48SN7dVbS98KjpXS6+YpZfKJNLlo3I5yBBaGYEj9M+PodYE
         WL7j1Qk6/V1NB9DhjhjYmmZNdQ5T8Pq3cYulPJ7OCxrkDkephNsgGlmzcosr9/s3VW8A
         KTbe6m4XXsicUBg0L0wFz5jFvVyEt8lCBKKDBp0N3ure1qPfTnfR7nrvAYrNU/FcwM7N
         +Uehragfhb++4TWZPeXICw7XJrQ0d+ygOMFuvoTqapGwzpmG1hnZe//uYWs5YX0SirSU
         +cEPiJ1+C72PEizSXxXjdpQmyKUWU7aCV+My7sdN2cTpGO2A2Nvv/hslfkBzdLi8ZESr
         te/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777003661; x=1777608461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iI2n+RqTAHgebFCF3Qcd87I1wf5GwnnOD9L0RHCmZxk=;
        b=fUABzAwErtK1VjspjVHojCRrp737hG1Ipb2uFrbGDmAZ1oAjPoGmhYNnAMkO3rvj5g
         CIWnC/pQzoC9izyAxdHE9ZWqvdWCwTEzbudS4AW930XMR/Jrm2qbccG5i6mfQUBiF1T9
         t3Nq/Ll89TFe8JoZi8un6GomkRhTRA+UVr31vlpecawiJoBudWoKB/RtMxCSOHpNHq5S
         Os5zlxZJ5JiNwWu7MIZpX1us3r552bqQz6iX0RJ6RNy+oTy5ug0UJ2vB6IHhGfGoin0V
         F3/6k+8CX1pKMtoR5Vk/eb3CRyxjrXwZaJhJzgkjne4TiZ/ay+OBXr+tw2iBkYrWU7VG
         px3g==
X-Forwarded-Encrypted: i=1; AFNElJ98r0zlTVjphsjW4AMwyV9QJVAMWXJCqu0Ufmqks1GyRJjezsaHHihSCtyAZPwdh1Qzy75Vw1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMbr1+r0/ACVIHskETgINJla5NQyA25fKXpo7L8M0KPU1EyhM
	Dj89MdTohxkp7nUHZ2xYOAzdThV1+QhIWtbs1roWoOe1z1c8pVjPHq1hPaJMnrODmnm4zOleFy6
	YHIhC/QBIHT3bsIjxCLnW/693jEugCeY=
X-Gm-Gg: AeBDieuAgnpqLvusF4eGjfmVRF6vgtB03v6bx29A98HHxEdH+Jxf8KNyPWaK41/B3j0
	bOna1a4JdpMoVq64QQIxBuIuFD1dw/K/3734sj+bjpp4hD7Jqa7diuAwOuYX38DtRyvnL2PJlUJ
	hjzEX/wA4WYHqZbDI+8ADtdw7PVp7VS4YPfUu2/JtUbIHpwKJHCvPQyCOoSdBzMGM0FiRJwhE08
	nhbYed7wevKkGvWSBm1Y5D/jko5UnfdBKfcd8EELz76n6+a0QJQAK5t6ZStJ2VwIWV6FOk9lMy+
	hfdU+SW8XFlgr9OnTJ5c9ES7I5I=
X-Received: by 2002:a17:907:9407:b0:bad:9363:901c with SMTP id
 a640c23a62f3a-bad93639641mr72236466b.17.1777003660722; Thu, 23 Apr 2026
 21:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421063955.99164-1-sprasad@microsoft.com> <CAGypqWxMLSdPhpGcomCeokiRXFR5kb+CQGNON7bsUiOPfswLKg@mail.gmail.com>
In-Reply-To: <CAGypqWxMLSdPhpGcomCeokiRXFR5kb+CQGNON7bsUiOPfswLKg@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Fri, 24 Apr 2026 09:37:28 +0530
X-Gm-Features: AQROBzAW3w1FuK-XdtcDYR_CneGiucSLwJKIh7osAVnd0qm3QWtn-FJvFxz7nZc
Message-ID: <CANT5p=resJ+99BXP59w-ydagKExL3zUqX8SVUiWjnQNd8-_dsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] cifs: change_conf needs to be called for session setup
To: Bharath SM <bharathsm.hsk@gmail.com>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@manguebit.org, 
	bharathsm@microsoft.com, dhowells@redhat.com, henrique.carvalho@suse.com, 
	ematsumiya@suse.de, Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 20F47459A74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240559-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 21, 2026 at 7:29=E2=80=AFPM Bharath SM <bharathsm.hsk@gmail.com=
> wrote:
>
> On Mon, Apr 20, 2026 at 11:40=E2=80=AFPM <nspmangalore@gmail.com> wrote:
> >
> > From: Shyam Prasad N <sprasad@microsoft.com>
> >
> > Today we skip calling change_conf for negotiates and session setup
> > requests. This can be a problem for mchan as the immediate next call
> > after session setup could be due to an I/O that is made on the
> > mount point. For single channel, this is not a problem as
> > there will be several calls after setting up session.
> >
> > This change enforces calling change_conf for the last session setup
> > response, so that echoes and oplocks are not disabled before the
> > first request to the server. So if that first request is an open,
> > it does not need to disable requesting leases.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> > ---
> >  fs/smb/client/smb2ops.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> > index 509fcea28a429..3625030d1912f 100644
> > --- a/fs/smb/client/smb2ops.c
> > +++ b/fs/smb/client/smb2ops.c
> > @@ -111,10 +111,19 @@ smb2_add_credits(struct TCP_Server_Info *server,
> >                                       cifs_trace_rw_credits_zero_in_fli=
ght);
> >         }
> >         server->in_flight--;
> > +
> > +       /*
> > +        * Rebalance credits when an op drains in_flight. For session s=
etup,
> > +        * do this only when the server actually granted positive credi=
ts (>2) so a
> > +        * newly established secondary channel can reserve echo/oplock =
credits.
> > +        */
> >         if (server->in_flight =3D=3D 0 &&
> >            ((optype & CIFS_OP_MASK) !=3D CIFS_NEG_OP) &&
> >            ((optype & CIFS_OP_MASK) !=3D CIFS_SESS_OP))
> >                 rc =3D change_conf(server);
> > +       else if (server->in_flight =3D=3D 0 &&
> > +                ((optype & CIFS_OP_MASK) =3D=3D CIFS_SESS_OP) && add >=
 2)
> > +               rc =3D change_conf(server);
> >         /*
> >          * Sometimes server returns 0 credits on oplock break ack - we =
need to
> >          * rebalance credits in this case.
> > --
> I think it would be good to add a comment explaining why the ' add >
> 2' threshold is chosen
> here and the assumption that the final session setup response SMB
> server returns '>2' credits.
>
> Otherwise, Changes look good to me.

Ack. Will add more descriptive comment.

--=20
Regards,
Shyam

