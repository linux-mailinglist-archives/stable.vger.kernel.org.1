Return-Path: <stable+bounces-224745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COntOeG0sWnbEgAAu9opvQ
	(envelope-from <stable+bounces-224745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:30:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C601268A13
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F3B23006516
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03D3E63BE;
	Wed, 11 Mar 2026 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjpJKjN+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A482866
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253854; cv=pass; b=iZbXJXUkdfFR9ra8kw+PzQe4R1w2b5xA2A/NCunJ/0zbd0cq95+alB4WWpDvo5dzmx7mewA0H1drrRbwNirtPU9Th6EpWiryTslXnr7quYD2BP+EqBS7g/ExvF3+6sNuHHhESKjS/l7Rulv1JYsxyVg7e8n47HxkU3H5EFZJNNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253854; c=relaxed/simple;
	bh=FKAphfj+vbjBMx1fo0kitY04r3B0cepQosEg5F3tOJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpSi5p9pQAS4WJozRYJykJDI5jds00L43T1ockwHOuUIe2c30iCjy4/1toeuzwF5ikfL+3fmyl8Vd5dcgnErkST0M1+yt5tRaxgDnJwOZWlRrV/40++t8WHBGJipg7j0Xl9sMcoP61+VfURMeEpjIC+/DS7f8YgO8LVdjaUJ3f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjpJKjN+; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89a6ac6f389so2498396d6.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 11:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773253852; cv=none;
        d=google.com; s=arc-20240605;
        b=TT57iOzRSrwSN4HF0ORFcuSBUIVcjPApw8aJRrV7N+YAinAJSA3M/Su3bddZh8jX1Q
         MQhxd66dXLJMEFgGiwnGxQNikvxtr2tWh/Y9Qzzaiqpvq7/6M5YjmhFEmF9FTknR2LBP
         y7ci9IkfwZMzFbFhHfvln2SgF+uWDWylVNv2PzzIzqKpYKhKd7LVR4Cz0yDnV5Ag+3Yx
         pA/PfGAyWLPObW1vD0janVuEFcZfrfuHEhXSUSdf011SvmpQaxhHSpMrWY9rGHXjIxKF
         Vd+LuingifwQ/igSRGLmEBGLSDwPsTwYilXv8bOWJ3IhleP9JCngRFuMvgi5tNkNUeLr
         oCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NXU5+1joNF1hpozpium1vq3MyYKKFSSUHLSiAVt73fc=;
        fh=gizR/Ho0MSVpHsIvyeK5csZyC1IhkyjshjNihsR+B2Y=;
        b=KxipM/NIDuGUQLIfDzfuqOUrNkOBr7V3ZeYNlrqxUpfbTRJ0HgJ+0FGN+wMcWACkfs
         Y6XNZPUYfd0I1JsD9xx0K9BqLImHXzZzdZwTQrhrpw7XxRd3R20sILDNdZ4Ff2JEXRyi
         7xL9WCfovGxyRPd+dmmGfO3H75Hrmg0Y6NQSxqs6lU9Ow4Sl60serEATAxo/1aMyHY3z
         UJRNQdQBQ2zDvdjBvGJMKmRryi0wWtTXRzL0Cd+PLagrQr0vioxuy5IWZeE/UiTUiuaf
         5Ouk0IW8eAEOzxYeL//Rjh/1URu8cfg4QjXOxudrlsNh55IKYlN2XB9UHzHVZHoLFpyR
         GkGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773253852; x=1773858652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXU5+1joNF1hpozpium1vq3MyYKKFSSUHLSiAVt73fc=;
        b=LjpJKjN+k+bMEU3gntbgtjSxKf0d2BwwA/UjVIugnDmSKyBqaTVcm40m8mXsznzHLm
         5XvvspZ5RKgfDZ9qthipNkToDDAUOqE3zoidDs2VJoeAD5nHiITt7jTVSDHBUhzYEsW5
         eK0t1z7DgCZ6at9+Z0fdpjxTZrjfhuimqmf5L0Ba9CBFowRUmVn235jMsB6jlRdMx+Cb
         FRR5kd8obA54vXDQcCI5OYXeVwxwyYZKEvkBNWSClJh1C2c9XqDE+7tSr2BDu9AXG/8o
         BwtovxvT1hCghiPzF8dDBobNtIcvkXEtDfU4Wp2/+HLjvFVx5l3/q/8HWlCf2f1k3MtH
         08xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253852; x=1773858652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NXU5+1joNF1hpozpium1vq3MyYKKFSSUHLSiAVt73fc=;
        b=OpQXQlyBjgOXNqAucQEdX6JdymoP5hjzq8kTuUP8ZDPVyvdC9c7aq0pSdp/EKUxZc6
         MlqOXaZSBIbYrGovdRgvbX9Zm/sV0arK0WAb7uOaO75iHIuWeA1uT0PwPyo5SvsVplqr
         e2UupjN1jKaB1NvlCr2Qmupxlu3aht41iX8GJgs9gF9zhevzXZmjn9hIQJHXJprDp/YZ
         3J8DIiL54QaBFClMfVzkqudXpjiSwBwBEGE6hlCaVI8oADh4yVT2CHI26oBlY/CEaIVu
         Ud4CqD/jn5dFvDhvRXi38VSH4+EIcyFLTQyDaFQkki2ESh6MsRrIfPp+KWUZGlbtIlu0
         Cuyg==
X-Forwarded-Encrypted: i=1; AJvYcCXx6N6v6nLyYAJPmMU9kVmXEajt9ouI0/wAhFpI7xQER0GO+PgxCCwxr1mYtH9TW8I6Mwhy0yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuGeG5lA/slGIUskJuKewp01NrF93R0SG/4tC8ZF+Ovjh+5ppm
	TSSSFv6IT4Y7nLRT6nYdaHGLGF/Lmu5jW2N8C7YozGyt9EbANrvfG7n+w6NnSUvZzlOLQQAHomO
	H1Cfg4/ieIsM/IB19/C+HIdlevajZoyg=
X-Gm-Gg: ATEYQzwZYJwSDXrfuJKqDQLAaCprzPBDoEtCgzVAyEHfk96EjrKJY1SXSILT4XTa8DW
	vr0A9P2bvci2nIcbjH1IBVQ/64iqkW4HdmNsXkW2/vt/+wvDrSpttfmfSuSuLD5h7LbgBye4Jm9
	wy711OoCZSSl6Pj3zy3WDzK1CXryYCWYSFvBvz2iAdLQ7njw0nx9n/POUson9LlJ1uN77XmTr9z
	1Vv08YsNTvR8Cfzovv2zD63bkllkQSW467oq9Z7LaTNB0DToZi4UnS2N9d8wsK81aW/MMIIxGjM
	iHl5b0w0FBBvDqxl3Tw7stQhoZO85miZ6KxeTmfBMteuGayUUJDb6ZQtt98IgIrAfQ/Yst3FNX4
	lZAVxh36gW11jETVRoD0veBIe8pNoyW0VKGKEP7CqnUieFt9MOkf3bJe4CXCNpw==
X-Received: by 2002:ac8:578b:0:b0:4ee:280:2e49 with SMTP id
 d75a77b69052e-5093a1c3d31mr42578001cf.66.1773253852041; Wed, 11 Mar 2026
 11:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311051854.2584907-1-sprasad@microsoft.com> <CAGypqWzCfeckKxZs0KJuqoQMmHyfb_iJ+ObysO5-VFxGGVJwgw@mail.gmail.com>
In-Reply-To: <CAGypqWzCfeckKxZs0KJuqoQMmHyfb_iJ+ObysO5-VFxGGVJwgw@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 11 Mar 2026 13:30:40 -0500
X-Gm-Features: AaiRm52ia21s6kfRtinwc0tm7VhxEfa80TtC6t5NIa4HGMDj2y6R4joJYpaO3VI
Message-ID: <CAH2r5mtKrA9ni3_dRtaSKbATik8fPAjJ-q9jEHhtxPcdWoWTyQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: make default value of retrans as zero
To: Bharath SM <bharathsm.hsk@gmail.com>
Cc: nspmangalore@gmail.com, linux-cifs@vger.kernel.org, pc@manguebit.com, 
	bharathsm@microsoft.com, dhowells@redhat.com, 
	Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224745-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,manguebit.com,microsoft.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6C601268A13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

added to cifs-2.6.git for-next pending additional testing and reviews

On Wed, Mar 11, 2026 at 12:26=E2=80=AFAM Bharath SM <bharathsm.hsk@gmail.co=
m> wrote:
>
> On Tue, Mar 10, 2026 at 10:19=E2=80=AFPM <nspmangalore@gmail.com> wrote:
> >
> > From: Shyam Prasad N <sprasad@microsoft.com>
> >
> > When retrans mount option was introduced, the default value was set
> > as 1. However, in the light of some bugs that this has exposed recently
> > we should change it to 0 and retain the old behaviour before this optio=
n
> > was introduced.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> > ---
> >  fs/smb/client/fs_context.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
> > index 54090739535fb..a4a7c7eee038c 100644
> > --- a/fs/smb/client/fs_context.c
> > +++ b/fs/smb/client/fs_context.c
> > @@ -1997,7 +1997,7 @@ int smb3_init_fs_context(struct fs_context *fc)
> >         ctx->backupuid_specified =3D false; /* no backup intent for a u=
ser */
> >         ctx->backupgid_specified =3D false; /* no backup intent for a g=
roup */
> >
> > -       ctx->retrans =3D 1;
> > +       ctx->retrans =3D 0;
> >         ctx->reparse_type =3D CIFS_REPARSE_TYPE_DEFAULT;
> >         ctx->symlink_type =3D CIFS_SYMLINK_TYPE_DEFAULT;
> >         ctx->nonativesocket =3D 0;
> > --
> > 2.43.0
>
> Thanks, Looks good to me.



--=20
Thanks,

Steve

