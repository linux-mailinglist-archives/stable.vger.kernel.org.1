Return-Path: <stable+bounces-254242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMemIF4iFWquSwcAu9opvQ
	(envelope-from <stable+bounces-254242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 06:32:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 724B35D0AA3
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 06:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C76A330055C6
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894743BE65F;
	Tue, 26 May 2026 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMm5xX/B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B03BD64E
	for <stable@vger.kernel.org>; Tue, 26 May 2026 04:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779769943; cv=none; b=Lxl30vlTkSgCyIKdyG/5KELGtUECKe3FQCi3XrPMgJMw/VotnIN0tGcM1hD8jIglvoHESxZHWv7IaEliWDD+mqUwKWftAtco6Tc1tzFKP9ySWRLRTChN5lq346/CV7n2j+xxiBVZMPNyTIv90JnbwNPvI7fX6z6zdVUHmjZOMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779769943; c=relaxed/simple;
	bh=AjAfTHyXLBEuUJMO115Gr8O3guOhw1q5RWPbes6LNj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mz1y3TFU+DkFs6LejVXA0sBOuW5e8Sfm1SBSWX9j8LVAmNKsHqxIa640PcbWzNiwuTGGM82BppnP0NvgYsmbK4RNmruzBCGa67bLHFs2uoE9pggJbHthEHlgjygFitepBbnWZKjxcbnIVKdTEgSfEJlVydRbNgVR0i6F8fck8e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMm5xX/B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C241F00A3D
	for <stable@vger.kernel.org>; Tue, 26 May 2026 04:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779769939;
	bh=ai5Q14jbwcZ0QXOzcZ5e2a1qHdxnDlR9GdBOGwP/4zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bMm5xX/BL83LLtC0nIb4xneM9GMA5UJY3oNJXo105+sP/Y8PytGmH/4q8wHREx8tr
	 09yT1dO9DY+HEdGnw/q0GHcPjuWZr9GDPSVm4zlDL7zyhgHc/cobBF2dNEXuJr9IIi
	 A6DmVVWOojAqjOPQVOUgbvC2Ci35YbrGT7jgrCszys2uLMqMKqf5JRdTILbl5WBzBn
	 UDkOND5VzTEWR85O3cSz2QYsikW0+bku21e21O3U9KeNY031h9qU8d3boMoiep/OKR
	 6qo18fhWOc5lozjee1s4dCwv+BZUm5EMBMu2tU5L067eNDpVjfNmhrwo4bo6+C2CM+
	 d1ryh+8NCrjLA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so1705378866b.3
        for <stable@vger.kernel.org>; Mon, 25 May 2026 21:32:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9DJse9DJTk4oHDtffX9L44bxFKdtNI13H0cLFh6Qr2zJRRFMF96VpV1ebgoLygdoB3l83EzZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7D/Rfo16ZvbBpfpyHPFnzYSuVip5Y4CTIHa9NxIL3a77Jd3ep
	yV0zSiGAcx2V11jChIee2MiA9yw+w6r/4r/Vr3aMOFQvVce96TkYoXceMrtYeQnn2a7Ab9XtHQW
	5S9pCD0GiuLgXAmGTQLMBIhyr/bw2wuE=
X-Received: by 2002:a17:907:9289:b0:bd5:1482:930a with SMTP id
 a640c23a62f3a-bdd272d1c46mr995158766b.39.1779769938505; Mon, 25 May 2026
 21:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
 <20260525104130.1252-1-alvalan9@foxmail.com> <tencent_88A30183B6BDC6E9A34612CF7A10071E4605@qq.com>
 <CAKYAXd_=z9THUikoBQnCCMcq2yoA14RdwTWNS+4eQWSiSQMfKA@mail.gmail.com> <tencent_8D358C1F4992EDD688387C30330D18B45608@qq.com>
In-Reply-To: <tencent_8D358C1F4992EDD688387C30330D18B45608@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 26 May 2026 13:32:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9R4PwtaR8Us5r=V5oOjpWuxasas9-XV+=nh9kDu874Mw@mail.gmail.com>
X-Gm-Features: AVHnY4JlsVbex_JAEmXWuVH3PYUhVoQKY-8Jpi1r9WAT9DToVpJb2FWwyfesAd8
Message-ID: <CAKYAXd9R4PwtaR8Us5r=V5oOjpWuxasas9-XV+=nh9kDu874Mw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y v2 2/3] ksmbd: add durable scavenger timer
To: Alva Lan <alvalan9@foxmail.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stfrench@microsoft.com, d.ornaghi97@gmail.com, 
	knavaneeth786@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254242-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 724B35D0AA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 12:08=E2=80=AFPM Alva Lan <alvalan9@foxmail.com> wr=
ote:
>
>
> On 5/26/2026 10:22 AM, Namjae Jeon wrote:
> > @@ -817,6 +968,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work
> > *work, struct ksmbd_file *fp)
> > }
> >              up_write(&ci->m_lock);
> > +           fp->f_state =3D FP_NEW;
> >               __open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLAT=
ILE_ID);
> > You seem to have missed this change above.
> I remove this line for:
> fp->f_state =3D FP_NEW was moved the beginning of ksmbd_reopen_durable_fd=
 ()
> in upstream commit 235e32320a47 ("ksmbd: fix use-after-free in
> __ksmbd_close_fd() via durable scavenger")
> in v7.1. This upstream commit 235e32320a47 have been backported into
> v6.6 [1] before this patch,
Okay, I would appreciate it if you could also include what Sasha
pointed out in the next version.
Thanks!

