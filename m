Return-Path: <stable+bounces-247281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOxsNnMgBmpDewIAu9opvQ
	(envelope-from <stable+bounces-247281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:20:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 445895463DD
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7C32300E3BA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F673A2E18;
	Thu, 14 May 2026 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIlv6W5l"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514043AB27D
	for <stable@vger.kernel.org>; Thu, 14 May 2026 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786412; cv=pass; b=NQm9huRFzG+nDif9MMxduij+/Eq6lmByc68jwPdxY1qdHVPTCYD/gTzSuNJFUm4sXP24gzdkC+HurKrqqO3yPgPwfO/7gAcrEsi0K1YLDJSQQREGvqPcH4Pxt0tEWLUCrRiBhe3Am/6QtauRkzLoApc6SaQDuGo7QL0OgWrrgrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786412; c=relaxed/simple;
	bh=e6KtqKPSII+2k+r3QLZqYaFAU+QrZ8o+lfNtmMMOV70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCbL1kC5pq26IDEGiw3HHxQAMPC1RYejAl1ZR4hYgppj5/lkCIeQdE1MLu6BFAhuhh5xunPk++jbjxDnH8lOPDdqLZuHqnQDIsVejI04QPNqZ4phlm6sGkzhEikESnl64cnkBx6D/vRerBryf/4BYTVSNYINLoHoYJ202h6yJIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIlv6W5l; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso15292876a12.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 12:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778786409; cv=none;
        d=google.com; s=arc-20240605;
        b=Yn9C8ZAD70MHXwJWPLFWNEb2ZcFazjnrpaMzF1GBsOu10wPWwJIWM9JiC7QMwgcvBa
         VbHsSSmh5DSTsqM/wthtj6i402eGHavz4aQqQIvw1mibpP/hIYpMGGpSxlX3Rbwl8dda
         YRV9N9WRks4Z16gdhV73EDl5ko79YJdpkpFhSWLHW7WWGG9gwWVIb7iuCHQKA7msgZ2n
         B6nYuX1/5vP+EUstQz0LW8U6/C+QxorkIMmLQDGtC9UvH0p+ePar9Lc4za4zV0RMQ7yV
         GprtwjhF5MSNZXwY2TSvQAvycQdeW8AUWyvNs8II73QBdVJz2O53jCpQd+u6wtF4dlHT
         zAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAZPl5Y6JvA88LVsf4Tu9u93qMcWBnxHmeUwtC+v/yQ=;
        fh=SEpnp2Hct+anApUtLN5a0un32FLGEkHsaId/crUUGxc=;
        b=RebVyOELqebY3nl0EucerTzomLJQ1+9EMHpybdVwTwk2E3gMldCxLhT7E6yyKL6VBW
         Vs21EGi7wk0qZMdGlX00r4i+PGrZEbRpr4g9Z1ljmzH9GORGriXNTKxXCY7z1BBrrn3+
         jcM4h52T0skN42NAEj6CsEMFbhvi0v+nW5eYiZoQsT4gPA+W90ScXi6suGkyXqpDVPeo
         T0Kn15c+DWfLTVQrkTlSob7jIKH4/Epk3kgna19yDqXh6TDIvfrvNUkXl895DMrM7Fey
         op03vukSP2THp5135lqVaM/qZsAn7wBJ3UHgF/+SVpUrzxZ6cP6EbFkku1xZUJ+ncO+7
         6gFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778786408; x=1779391208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAZPl5Y6JvA88LVsf4Tu9u93qMcWBnxHmeUwtC+v/yQ=;
        b=BIlv6W5lE+RyEWaF0HCzCB4Q4c+nEHWu41JxuIBmcUuPIPxmqLwcdgZCgiBqwwhW1v
         kfEDbN3yj6/czFHBN3zwRSdxrbOcrLZOktThXq+ttTkos89rJVibgQkq3Utc2UsxT69e
         yum8v7wRade6GU+CyON+uU7FAeCgFM1J3MNNbDFjcUsswIjrmR7DVDaIulv3dV6uXcZW
         nQXSGBPbEZ9WWGaBshayD7FU/HqePVhx0HNU5DkW+I877HNboEYjip9vIQ10FJYzTsFZ
         y5rRSnIRe5qD6oete0a1X4yfJG6tRE9R1Q6wOjcXQG9Q1MkES7JwLFFIjMncXgB6xvrf
         qO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778786409; x=1779391209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAZPl5Y6JvA88LVsf4Tu9u93qMcWBnxHmeUwtC+v/yQ=;
        b=EV5gKw4m4yyk9XXJ/NkGSAh7LUjjjwvi8tPJPS8eZ9ZUI6g/YB4zAmY6yVrO8n04i6
         maOr+zvw0FgzB0QC3ulNfM5s5d52hOuCvR5vfu/5A18ie79W55O7CZECaBzuphaGQ0n6
         N2EuzOnKLNt8uCVg1B2N0E8zEXmBdy1sPzWCOjgxeOM8cd07rMFB6+Tb7c/7v+P4ekqn
         lJ36mfUn22/1cAesjyGKllynRalbbPo+dSn/2UXI6a5vXvxR3B5GtmizoXtLW7JL3eFo
         FX2Dh0gyuciS6wHmPCFjZodwd1t7Kv/V8PwqIiGpuqSoEjqAK3sNctKS3aVqoV9YSBYw
         L89w==
X-Forwarded-Encrypted: i=1; AFNElJ9YEETLLBhFHKwKJqXxACL//xoAiyCa0paXjvNJ7MUJijd7M5T6C2U0lx3SH+dbeoXzcMehPtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFRqxZxnllHyEvlhC8fI+6nrhx4rxo8erlTQCYw8bP3O1weYy
	4/H8TsYKIwksE74skNpjr7c+jWzp8lS/qWWDur6eye4+4tvUvRx2YfS5clK3WwAuKTl2BozzAkC
	WuAb3Ngk9Vrs+7JLZCExHY1TOTb6CT38=
X-Gm-Gg: Acq92OGclGyAnMDONLQy3sZOfMApy1V64X4DkLorhxWBKF5wNjYrdPPJDG82Uxlu0+4
	UoNWYIAT15BWoVtf8oq55n7twq8PlI3SP5RyVvFZS+3ZSC+sLgJqTQzWmBpwac8Fd2E6Ew81Wm0
	shzppkf47fPKSugj0EFGDSsfCFj4ri8lIjNK4ZUZ3J3oR7JZ+dB57DES4x4sykUshB3AB0BAkD0
	iQ0g3QFZKGUv/tIWY5PBhekldLqnfD+kdUmAjzVK1ytVyta1VlBO7fXvoBgBhWHohst7H9E5v2/
	uOiE96qdXRcB058u57ZEuw26wJhJoBOQaSVW/Y7mHA==
X-Received: by 2002:a05:6402:3494:b0:683:c72:44c9 with SMTP id
 4fb4d7f45d1cf-683bc8ac2f4mr409600a12.11.1778786408274; Thu, 14 May 2026
 12:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514111354.3552538-1-nirmoyd@nvidia.com> <20260514144258.3068715-1-nirmoyd@nvidia.com>
 <CAOQ4uxjGhRLnuU_=m=P-omUMM=0F+Mxs1O=zTasVnLdLz8ut3A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjGhRLnuU_=m=P-omUMM=0F+Mxs1O=zTasVnLdLz8ut3A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 May 2026 21:19:57 +0200
X-Gm-Features: AVHnY4LPcqU0kwgtnerwPZsHb0UxBwYXdw7YvL4NvATth1Qw5XCaHuPDkFFLv0g
Message-ID: <CAOQ4uxgad=DE9wMAS6Wn9rrEkOX3p0S8jEhsjnj=Or=_7HsqyA@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: keep err zero after successful ovl_cache_get()
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 445895463DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247281-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,a16fb0cce329a320661c];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 5:26=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, May 14, 2026 at 4:43=E2=80=AFPM Nirmoy Das <nirmoyd@nvidia.com> w=
rote:
> >
> > ovl_iterate_merged() stores PTR_ERR(cache) in err before checking
> > IS_ERR(cache). On success err holds the truncated cache pointer and
> > can be returned as a bogus non-zero error.
> >
> > The syzbot reproducer reaches this through overlay-on-overlay readdir:
> >
> >   getdents64
> >     iterate_dir(outer overlay file)
> >       ovl_iterate_merged()
> >         ovl_cache_get()
> >           ovl_dir_read_merged()
> >             ovl_dir_read()
> >               iterate_dir(inner overlay file)
> >                 ovl_iterate_merged()
> >
> > Only compute PTR_ERR(cache) on the error path.
> >
> > Fixes: d25e4b739f83 ("ovl: refactor ovl_iterate() and port to cred guar=
d")
> > Reported-by: syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Da16fb0cce329a320661c
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> > ---
> > v2:
> >  - Drop the now-redundant 'int err =3D 0' initializer and the trailing
> >    'return err' in ovl_iterate_merged(); err is only used inside the
> >    loop's update-check, so the function can just return 0 on success.
> >    (Amir Goldstein)
> >  - Link to v1:
> >    https://lore.kernel.org/all/20260514111354.3552538-1-nirmoyd@nvidia.=
com/
> >
>
> I queue this up and will work on fortifying patches.

Nirmoy,

I pushed fortify patches to ovl-fixes on my github [1].

Can you verify that the assertions trigger if you revert your fix
and run the reproducer?

I imagine they would trigger much more frequently than the KASAN
warnings do.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/ovl-fixes/

