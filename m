Return-Path: <stable+bounces-254653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D4KOlxCF2ov/AcAu9opvQ
	(envelope-from <stable+bounces-254653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:13:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A9C5E967E
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D845A302978E
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C08367298;
	Wed, 27 May 2026 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fXNGzB3T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C1365A03
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909204; cv=pass; b=RyaW8SpbtBM/s3dLy0kqgpAmjyO3KMFfrX3KBii/7cWoQyR2zcaEk0OGlNSxgVWViiYEDl2rPc/An/+D0XF3sitpeEwBB/e6zqimsCZzw7loex/eIDC+qS0QppsGSDZHA6rKSOLcvniIOq0x9af7+LBkkdH5mMCw7nyoQ3/wq/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909204; c=relaxed/simple;
	bh=arW85NP4G3Vx1E1uaf3yqqPfSSzR3Kno27p4gRd3hlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYQ6lwnGFdZIRmJr7ZjpBpz/2YZUj7741VOCUpoysmjz15/QU9MBfoqmQywDvykHhhtT92cICEeq4sFKYl8hbwEz0H7aHXSN5tu45W+kAuSbFUrWfug4F+ekDeXN5iuqrxrQzdKRlMak+uvplnBXmPX/dX5Hg68Hw5x23d0PWsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fXNGzB3T; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b45cb89f7eso81362975ad.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 12:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779909202; cv=none;
        d=google.com; s=arc-20240605;
        b=Yrsx9UyzFqE+jAh7fAlpUKEJPAORblSa+zKsAvchuACI/fIBaagZTVKBwU1/UyoNtt
         h0jyiOvw+IBg3rID8Id6vKxKUMNLBP74zSpM2atC39Cisu8V73kdxP0bv1eRdE2uS+s6
         giHHSIRYx6RsMPRGLHL/vhSefYnKbiywclKGH+lw/U02qZ8pVXudLuWP+jtor/9AWgX+
         BfeqaI72y0CS6cQUTiIpVtbZOkyln3bnhulqTQXVkwEAgtQLAPZ9aiq5u4pY/Nz8zvdn
         yAWw/HdxN+DTNn+77atbl65M5p53W4Ztx9W73AyI6y+ZdKem6b9O9vuqB8StH+hWr/6K
         4fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZBJOcUZKwlryBrLyHrM1pbqAMloKqVU+cfZbZQFpt1E=;
        fh=u+YrH3oOJwJ/AGthG8cuXGHnAHWSMAQuHrduzvAKiDc=;
        b=M+mbQrgMNzcjmx+rE0Q1N90Zs5NNer8NroKsZs5A6ek+UlMlJAGdu4neO8df1U8bJ9
         F91RqbFfCQwuxn50BPaT38E8vqXuCk2tk5cMZt7iihJMk8Tjb74nF+8W98gV13z6o1cG
         ibg5wvmbOMZyeL79SU8DqCyVSJbaBoGZH1KbfdInONVmynJmKh4R4IVkvDzsysdTVdBQ
         lJbSQPdxId5wcnWPRs8hWXogfj25sDQuf+hxXTEGqCZ9NkIrA3cdJuDXU87767q/WxkK
         Fphkk38iOa/zs5+PxZJaw4rDt4Gxz7rEP52hCJeqKfPBHDC5FFOKqRwCjm5Ubu10drs6
         nXuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779909202; x=1780514002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBJOcUZKwlryBrLyHrM1pbqAMloKqVU+cfZbZQFpt1E=;
        b=fXNGzB3TFZyq7edBEWR4FNBxN4Pv/CMd8lAJud0CCOx25HDdq3FdeYPDGAbc0ymlOO
         CavMLnlvTtnFjI6LdUUHHqETuav4Ky3H8LXzFWQ3UTbczoFKQpDI4jWiVF9270o4OxZb
         ntr8GKU2YGEuUDZ5EgQyE4SlzXv1rMCGNwLU4biQ4WIGyoop8OKq/3vLR+eZlxXmpfRM
         oVO/djy0y2D/JjWMcqfY7OMSVzj2G7BRuXbO76ucCTGqAmNfy9zGzce7qm5jTQOB+8R6
         CrjoBgQ+t93qfDuycAV56GpD1pq8GKnLgdV5wOZz87g6mn0Z6TRzkBjPgddEVaU3ut8Z
         dQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909202; x=1780514002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBJOcUZKwlryBrLyHrM1pbqAMloKqVU+cfZbZQFpt1E=;
        b=d5ipIkCa0JjBfvB08BWETVKpRlsLq5pK8j/cKGiVbINQ7hbrMUTPsdeU8vfRzGDLQn
         g+h283IMTdurb1OPsLkcVw85Jy4AZ/5qkwXxoWyzUrTes6Bk8DMu8iC9c3EjiZoPyG9k
         Ms7y2UMqIlD7nHRDokX2D4+xV5OdkLcedIYjr0N+UqoyTUTh/Eq7ieF2IV8Gi15XnVJB
         eexMUAV5eEVHpXNZgRy18M/LqrbbO6BLgkCcH6+vf5nRI6ANoIoAgLCD6fzfJOLd22R2
         KSj86Ya+zxCC7yT/WCi47s/h35v7WGuSRygy3QiSJhK/O9ddGQZjeEXEdvrvMwoF5kvD
         4o3g==
X-Forwarded-Encrypted: i=1; AFNElJ/GvB0hKJF/BLxW2Atljz65zA4z+iBj7eksZxFRHuSYEGHrgwQdGdsTJet0a925foMcL8M+JiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4cFu023qZoyHx2i0Db1SKSZ/O3bb0YCxZj8I0/LTrLNgGvOU
	tdtgG+ZYrZjPbtu4jcAU1S5vSDmw9HZtx8BHL7St13Gc8Ys64QLPEOKho4z5mzm45OBHrOV5oZu
	EN/h1AEDhFdDysYSwQpqwk6FyDablYwGwa7XjKgLI
X-Gm-Gg: Acq92OF7bTVKy3yUV8wMXa2mI0E31IMe9LrmOmu0F/7/1W8d63G/r9G6XeyoBvPlwRN
	ISWRnYpqTkutU5Xn2FeOzYTHh4WFEpj0bPjzlrsaIotpLadkaASRCcWG1DBNj40oh5/O30lF30/
	d5ZFnO0wN8HdNsTa+4Rg7kE7Oug1gJHvwK8NHvROrceZydeDYfRkS3ebTkCdXd7f6Cv9nccC3mp
	ailCR91d0zZmhDMEsPm2gYg78UiVB4C1P/zhe0pDHd4hZa+5QLlgKGUqXaLK7NHz2yyuYuDTABG
	0Tj4DlcH3I4Zhhe4pgBFkMvt0Fuy
X-Received: by 2002:a17:903:244c:b0:2bd:7ff4:ab0b with SMTP id
 d9443c01a7336-2beb06552bbmr262114595ad.39.1779909202300; Wed, 27 May 2026
 12:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org> <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com>
In-Reply-To: <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 May 2026 15:13:06 -0400
X-Gm-Features: AVHnY4JyDaihz5j2KMbjN9c3bYMT5kulIDfNm6wxP3VCcHavB9S0Ini-jhjCGkY
Message-ID: <CAHC9VhQfci2gE-eD67DbjL21s7tF+rPWa9bdu0Kk5cfW+gz2Xg@mail.gmail.com>
Subject: Re: [PATCH] audit: Update audit_alloc_mark() and audit_dupe_exe()
 CONFIG_AUDITSYSCALL=n stubs
To: Nathan Chancellor <nathan@kernel.org>, Ricardo Robaina <rrobaina@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, Waiman Long <longman@redhat.com>, 
	Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254653-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 62A9C5E967E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 2:55=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Wed, May 27, 2026 at 2:52=E2=80=AFPM Nathan Chancellor <nathan@kernel.=
org> wrote:
> >
> > Commit 84470b80b7b0 ("audit: fix recursive locking deadlock in
> > audit_dupe_exe()") added a ctx parameter to audit_alloc_mark() and
> > audit_dupe_exe() but did not update the macro stubs used when
> > CONFIG_AUDITSYSCALL is not enabled, resulting in a build error for this
> > configuration:
> >
> >   kernel/auditfilter.c: In function 'audit_data_to_entry':
> >   kernel/auditfilter.c:592:85: error: macro 'audit_alloc_mark' passed 4=
 arguments, but takes just 3
> >     592 |                         audit_mark =3D audit_alloc_mark(&entr=
y->rule, str, f_val, NULL);
> >         |                                                              =
                       ^
> >   In file included from kernel/auditfilter.c:23:
> >   kernel/audit.h:327:9: note: macro 'audit_alloc_mark' defined here
> >     327 | #define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
> >         |         ^~~~~~~~~~~~~~~~
> >   kernel/auditfilter.c:592:38: error: 'audit_alloc_mark' undeclared (fi=
rst use in this function)
> >     592 |                         audit_mark =3D audit_alloc_mark(&entr=
y->rule, str, f_val, NULL);
> >         |                                      ^~~~~~~~~~~~~~~~
> >   kernel/auditfilter.c:592:38: note: 'audit_alloc_mark' is a function-l=
ike macro and might be used incorrectly
> >   kernel/auditfilter.c:592:38: note: each undeclared identifier is repo=
rted only once for each function it appears in
> >   kernel/auditfilter.c: In function 'audit_dupe_rule':
> >   kernel/auditfilter.c:879:59: error: macro 'audit_dupe_exe' passed 3 a=
rguments, but takes just 2
> >     879 |                         err =3D audit_dupe_exe(new, old, ctx)=
;
> >         |                                                           ^
> >   kernel/audit.h:333:9: note: macro 'audit_dupe_exe' defined here
> >     333 | #define audit_dupe_exe(n, o) (-EINVAL)
> >         |         ^~~~~~~~~~~~~~
> >   kernel/auditfilter.c:879:31: error: 'audit_dupe_exe' undeclared (firs=
t use in this function)
> >     879 |                         err =3D audit_dupe_exe(new, old, ctx)=
;
> >         |                               ^~~~~~~~~~~~~~
> >   kernel/auditfilter.c:879:31: note: 'audit_dupe_exe' is a function-lik=
e macro and might be used incorrectly
> >
> > Update the macros with the correct number of parameters to resolve the
> > build error.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 84470b80b7b0 ("audit: fix recursive locking deadlock in audit_du=
pe_exe()")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  kernel/audit.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index f1a77aef4533..92d5e723d570 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -324,13 +324,13 @@ extern struct list_head *audit_killed_trees(void)=
;
> >  #define audit_watch_path(w) ""
> >  #define audit_watch_compare(w, i, d) 0
> >
> > -#define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
> > +#define audit_alloc_mark(k, p, l, c) (ERR_PTR(-EINVAL))
> >  #define audit_mark_path(m) ""
> >  #define audit_remove_mark(m) do { } while (0)
> >  #define audit_remove_mark_rule(k) do { } while (0)
> >  #define audit_mark_compare(m, i, d) 0
> >  #define audit_exe_compare(t, m) (-EINVAL)
> > -#define audit_dupe_exe(n, o) (-EINVAL)
> > +#define audit_dupe_exe(n, o, c) (-EINVAL)
> >
> >  #define audit_remove_tree_rule(rule) BUG()
> >  #define audit_add_tree_rule(rule) -EINVAL
> >
> > ---
> > base-commit: 82bc8394b1aa74aedb9827da7730cfa6639716fd
> > change-id: 20260527-audit-update-macro-stubs-6e4d8e8a826e
> >
> > Best regards,
> > --
> > Cheers,
> > Nathan
> >
>
> Hi Nathan,
>
> Good catch, I did miss that! Looks good to me, thanks for fixing it.
>
> Acked-by: Ricardo Robaina <rrobaina@redhat.com>

Thanks Nathan!

Do either of you mind if I squash these two patches together in the
audit tree?  I would preserve Nathan's sign-off line and add a comment
at the end of the commit description about the fix provided by Nathan.

--=20
paul-moore.com

