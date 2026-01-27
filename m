Return-Path: <stable+bounces-211701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO7CEtggeGk/oQEAu9opvQ
	(envelope-from <stable+bounces-211701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:20:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C26398EF63
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A6EC30347AE
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF1D2D0614;
	Tue, 27 Jan 2026 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbqdY/Na"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5B1F5858
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480392; cv=pass; b=K1/X1O9Uc7oxE9ezFff8rKIuDOHFVRrc7/1tmpC2N9dm6uMyU7d8jG7cbRBAqGVR/ELrCVCDK4lz5I2lRnW1PL2XBx/rxMnqqPyxS+4EgHVcMvr086SX2T/MutbvXxCQK6NtTRnk6wT7nX7YP9W14J5QKfdfVWcJhXPlrY5Ds+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480392; c=relaxed/simple;
	bh=ds2MKOYIaPbKgraiif9OmBCAOVwuarVvu6z0WwORmds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojj6RW72ALMSdviB9wOy0qYYuz5O8jj02/dUg4clfHKnFDhSBORqpRiOLxKBodWIaVqoXDqYbHMFJDHcmX0N0uo/NjkqP+VPGq8Vb++2+PQCP0M2bHscRfW8lbYYj/KC6yxLrBddO/pVPGZ/ilU9fg/zzfY12FehTgdHoAB/O/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbqdY/Na; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c551edc745eso1983573a12.2
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 18:19:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769480388; cv=none;
        d=google.com; s=arc-20240605;
        b=ckUBkdvW71o3wJJW6wgsBw6ALxAiOHMPDf3ZlYZqZgmFTjeymMVJDejKoM3VxkBMjq
         eVIvkDtZRWmV2jPypR5hwoayLx2+ALUFIXySVCDWYb2l7xvDZ8HZg2r/n5fRH5krzQXX
         KvKMrVE8rdfkiJ/j5AQB6oGcRyAVRuvwdZdFpigV+N8W72jjTuqJ+pLSRA4Ji/4jRMTx
         CyBCIkkegPDNa95Xrf2Z0iJOr2j0MEP1/518KEX8Sm0oyQa0wgPEmGmXPgH/TxCEA6eD
         eRoAIjJVmxnXSrWdZcQZDmNpdKtqDTXTxa64HG/ompwNKgeh5DPOhxxUEu7ciUt0P6IF
         0olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=7AuGSERLo4VW5sSrWHTOA9xALg2QwcEpABcfv80mNKA=;
        fh=x3UXp10C0DUcwxMSslfYsAYSH43R8SL7Hwm96QOwuwk=;
        b=IGKB8CoS7DYtMjb/YxMhp1RWFl4s4IIshocoWqOY2hH7o/NlZLiXGbgKC4yyhMmcmQ
         g0XuVePRDo43OkJZTT+0CemIxt9sXWcc/JwTluTn4P1TVxsBVCrRTmLKZ3bL+BX8giwe
         OBNBdP/0WS4ZeN6l9KgIQEZutsdH7KvftFmLcYpmY2kwvHJ0yKOkf045eWZo73lfW1VT
         7TCyHkBuH+H+aBas3V3okqYaX5fxh4wsB3Hqv7MdxFVeCX6MItqXSboXgVQjm35eClai
         qa0+mrScbk3VHBZX5UGlEvd4M24WXXt2tCSqPkL3N9yQbIdtneR6AmSTqYidwNzkfpew
         86Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769480388; x=1770085188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7AuGSERLo4VW5sSrWHTOA9xALg2QwcEpABcfv80mNKA=;
        b=GbqdY/NaT0StNpZzhbs34YyFWRsnSIcmcjqnW/2liKPoKHQR0VEmoTFqBADyuVlpz1
         kk1rq0Nnq1adF7vGuqc/2blEwTMyqCyKqD1zT27yd6s3EgNPwhvqQwd7rHjh24YdYIbg
         g3VKsgLgm9DEchbjWOckiVfyA0rrBTnuGu+4e6KI6M17CvgiOrtdF0aoB1vzZeZrj8is
         AK+2L21Ixx4Ri7zslOhH5JcGOeVIXiqancB7eCgZTROrYTSSnFLdDXYoRDdDsHQYfVDO
         0WdeltN2LgmSJVLEtFJbhavKLDULLagzF14EeEjA+MULxjN6qRNeESZlK41WMmpbhUvf
         GClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769480388; x=1770085188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AuGSERLo4VW5sSrWHTOA9xALg2QwcEpABcfv80mNKA=;
        b=mmeq1e76vovJ1BVMoxXAGntIMByqFV0uKI819DmNqKH8afncizHmEUIMlY8gFAfLyr
         9nl3vGdumKDvns4qfQtepC58wfRBLdMdRR5ePVSS6lrIn6YvRcEQu8f7MX5HLfTzdYLE
         7YfofzfPecD8va9a66RNC5kZJb+r3BBvB/A0PiX1mj6oPYmtMiMVSnm6rKcVFwRlJddJ
         flTXF0BSJH2blS+2A2WeHWO52nVj5o0s5FiOSZ2Y1/Rb5b2SB0PCJ3WQfRiPf8t63FdI
         FnR1itxAqTYf98D5bLlD1HNEiN32pf0T+X6OEQObwiR30PkDxR7V/Bt0SvLthC6WiIbg
         qQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCUUh6rghZylXXnEfzUgMvU+iRFT5qzM4z/sjhN1MrdvHgA6HXpHGInDaUZgTTv8CMwEtwBqSaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziZ1RaC8gFvGlg1Ng0v3JcMxyxzUwfxZR0g8cgDRkUMKJERA3s
	9En9NTmH0itAnYP8aS/k21GX2GM7SQBy+I3toJCiFI9Kd66MuoqSayi33PnpPMJSGngTMMOiird
	se2yJe4NZlKE+rCuO5jcSGj25AUH5TRXYAwgcJolIcvtk
X-Gm-Gg: AZuq6aK55DaScfMIJRTTCep/TuHmqcxcC25a6Ym0DImlIvmn/h7n7vVZr8G4JcR7Bow
	26iDdFhoT0ggiPTkL1U8B1H+tkukzqxsiiYBZ+1BUJmjHVM184xcd5ogUWF9d4jzUh7CA303cZU
	tW2Ll+V+uJLS9CH1U91vOLQpo9rU14YzJAiS1OjIt9DOKKBh1hfhq/Cgjd3afaqKmZxwtbocq4h
	ZIUZRf8GLS7/09494I9Sx93d9PqdbL3/Y+/ZDUuegQEj73E1BdSAweVapTmHdrrRD7phYiw0YFz
	amlu
X-Received: by 2002:a17:90b:35c4:b0:341:8ad7:5f7a with SMTP id
 98e67ed59e1d1-353fed74b59mr262004a91.18.1769480388288; Mon, 26 Jan 2026
 18:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117140351.875511-1-xjdeng@buaa.edu.cn> <2026012631-suffice-enforcer-8553@gregkh>
 <qbuccwnfljpnxvpp7vl4weoecx6ujg3cy2lwwgoz42b3ux5o3k@mi5fxhplgrt7>
In-Reply-To: <qbuccwnfljpnxvpp7vl4weoecx6ujg3cy2lwwgoz42b3ux5o3k@mi5fxhplgrt7>
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Tue, 27 Jan 2026 10:18:38 +0800
X-Gm-Features: AZwV_Qgc7eQOJipl3o8vcuglbFoKSmgdRMS1oOVCwrdajZx_HYCkl-uUukOkTHc
Message-ID: <CAK+ZN9r+oCbSNjSf=yKQHGT9=Cqfw02J+TS3eZaUgrd=PfV7tA@mail.gmail.com>
Subject: Re: [PATCH v5] misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe
To: Bjorn Andersson <andersson@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, srini@kernel.org, amahesh@qti.qualcomm.com, 
	arnd@arndb.de, dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xingjing Deng <xjdeng@buaa.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211701-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[micro6947@gmail.com,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	HAS_REPLYTO(0.00)[micro6947@gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C26398EF63
X-Rspamd-Action: no action

I identified this issue through static program analysis. All other
callers of this function validate its return value, so I believe a
validation check should also be added here.

Bjorn Andersson <andersson@kernel.org> =E4=BA=8E2026=E5=B9=B41=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=BA=8C 04:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jan 26, 2026 at 04:24:55PM +0100, Greg KH wrote:
> > On Sat, Jan 17, 2026 at 10:03:51PM +0800, Xingjing Deng wrote:
> > > In the SDSP probe path, qcom_scm_assign_mem() is used to assign the
> > > reserved memory to the configured VMIDs, but its return value was not
> > > checked.
> > >
> > > Fail the probe if the SCM call fails to avoid continuing with an
> > > unexpected/incorrect memory permission configuration.
> > >
> > > The file has passed the check of checkpatch.
> > >
> > > Fixes: c3c0363bc72d4 ("misc: fastrpc: support complete DMA pool acces=
s to the DSP")
> > > Cc: stable@vger.kernel.org # 6.11-rc1
> > > Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
> > > ---
> > > v5:
> > > - Squash the functional change and indentation fix into a single patc=
h.
> > > - Link to v4: https://lore.kernel.org/linux-arm-msm/2026011637-statut=
e-showy-2c3f@gregkh/T/#t
> > >
> > > v4:
> > > - Format the indentation
> > > - Link to v3: https://lore.kernel.org/linux-arm-msm/20260113084352.72=
itrloj5w7qb5o3@hu-mojha-hyd.qualcomm.com/T/#t
> > >
> > > v3:
> > > - Add missing linux-kernel@vger.kernel.org to cc list.
> > > - Standarlize changelog placement/format.
> > > - Link to v2: https://lore.kernel.org/linux-arm-msm/20260113063618.e2=
ke47gy3hnfi67e@hu-mojha-hyd.qualcomm.com/T/#t
> > >
> > > v2:
> > > - Add Fixes: and Cc: stable tags.
> > > - Link to v1: https://lore.kernel.org/linux-arm-msm/20260113022550.40=
29635-1-xjdeng@buaa.edu.cn/T/#u
> > > ---
> > >  drivers/misc/fastrpc.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > index fb3b54e05928..d9650efa443f 100644
> > > --- a/drivers/misc/fastrpc.c
> > > +++ b/drivers/misc/fastrpc.c
> > > @@ -2338,8 +2338,13 @@ static int fastrpc_rpmsg_probe(struct rpmsg_de=
vice *rpdev)
> > >             if (!err) {
> > >                     src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> > >
> > > -                   qcom_scm_assign_mem(res.start, resource_size(&res=
), &src_perms,
> > > -                               data->vmperms, data->vmcount);
> > > +                   err =3D qcom_scm_assign_mem(res.start, resource_s=
ize(&res), &src_perms,
> > > +                                   data->vmperms, data->vmcount);
> > > +                   if (err) {
> > > +                           dev_err(rdev, "Failed to assign memory ph=
ys 0x%llx size 0x%llx err %d",
> > > +                               res.start, resource_size(&res), err);
> >
> > Shouldn't the caller function report the error?
> >
>
> That is correct, all codepaths through qcom_scm_assign_mem() will either
> be -ENOMEM or print an error message, so we shouldn't print yet another
> message in the log here.
>
> (The usefulness of the error message in qcom_scm_assign_mem() could
> certainly be improved, but that's a separate matter/patch).
>
> > How as this found and tested?
> >
>
> Looking forward to Xingjing's answer here.
>
> But failing to handle errors here means that we're ignoring the failure
> to map memory to the DSP, which will fail us later. So, that part is
> correct. Exiting through err_free_data looks good as well.
>
> Regards,
> Bjorn
>
> > thanks,
> >
> > greg k-h
> >

