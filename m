Return-Path: <stable+bounces-254656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCkfJPZEF2qS/QcAu9opvQ
	(envelope-from <stable+bounces-254656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:24:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F02185E978D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C541F303EF5E
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8BE376497;
	Wed, 27 May 2026 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1xQtI+U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNomHfnE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25259375F7C
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909867; cv=pass; b=lcUV4SYoNf/6dkFkSvhlw1Kpses0b70SJhtPbwOFGYIttNVeGTKZHzaHBHWbhJtsR+0TgdPNcOkJiYgHTH6Am93FYnblmF4mjqvT2Cn5EjBjoantJlu29wohXBkFDDfWH6qhJhWfpX/Y+tmXpMb7k7ljijpAR5i2WVa+Cd09mSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909867; c=relaxed/simple;
	bh=IE27ud53BUktEXbB6OkdYpXZ30dl4eOxgAfc8ez+tVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CclUgFpQASaHNZZh5w5/76Zje0sYc/jiB2gXRl3KUep/Zsx7/rcJa+UtiwJEVsi0nKhw2X5ewZeNE3sFKwANq60vBYH6DWo4LjOmbMcDJM/EytCeDL8PClA0l5R00hinfnvPGi1D3/BtJFwuXdc7xnEoBDj2wO4qu/BgxsYGuBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1xQtI+U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNomHfnE; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779909865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHhJRP5pVLgcPa4KuNaBBD+P9GhP2r2iVQQYvikzvXw=;
	b=M1xQtI+U63bAyWHl/bXupGdyN5wtaMRw51CYU8mxi+4WxONEi8A2ygZQiOkOcHKA+Tp8nF
	XfFuy+tbkoRfIYKlkb4FLm9KgXmxwwPxPiJb9D2gRd7YTO+eBjBthjGk+3AuhPXc88CcmC
	zTQnM5uvbKef1tDOP5cW4vaj/9mjTeg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-iwvSH9tZOVOp5rLG4ZQbCw-1; Wed, 27 May 2026 15:24:23 -0400
X-MC-Unique: iwvSH9tZOVOp5rLG4ZQbCw-1
X-Mimecast-MFC-AGG-ID: iwvSH9tZOVOp5rLG4ZQbCw_1779909862
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bdaf3ed080dso857025166b.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 12:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779909862; cv=none;
        d=google.com; s=arc-20240605;
        b=JQHyTWX3jssvzsK6F7xYsdmpdFpJP9nHsHE19L4FQ9L6Oq/q1V2tBSjK4lvuWT3sQS
         N+hFxK9PD0GQKlcA7VpNTE3zv/N0oT0UU5TMRSQ2dma1IKADY+VFku37rDli8KIPR5M8
         5QfOy237+3jrjrIrrnNoUk6dxOjNdMGCwC1roCMaxM+j+KhbLiOaKDj35s/MZYc+WwQj
         Ud3S14smOYKhe27IPte84kl2aV7XPq4mXhQMl5C2c67QXa+Q8JB+yxr/zzPtj38mLhfX
         WjmX4cklIX54zHtzTopapiKr6pn9vpYE7mq3cJCn/IJA0VAICQV5z0iMCB5jSAQb2Qlk
         Ut6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EHhJRP5pVLgcPa4KuNaBBD+P9GhP2r2iVQQYvikzvXw=;
        fh=Z6q8SMJvhA0sQlx9EBrWJYeA9TejlYVG1m0dRAwUunw=;
        b=Qk+E1t1CyfRz0xlx0d21vkFDwdJCNSaqXFR+jI3gXyfDnWyIamoIBZHBb4fLN8+Z9M
         nU3iI7KHtHvvtYNMN6qnF9QRj8Z5uaD7L+3dI43IhAcqxjLWXyq8gPSC6kH+eg/L4o7o
         5xOSmqst7n7bCdlNxMLoN8jqgYtQ2Vbd61Jon6Z/m+cBw2iQFWxnZoF+rOFunziZ9zwl
         v/6L6FB0XEb9IFTDgt/cQqNmsNcz/6rA6pI807fn6Beox7kx9cRA3FHPmV2m5IHShYSk
         677Ng5M78wE50tMhXNZsJjG7rSO/8lZsym9GvG+83wln5qD5IrsLxWtEcbuFZ4JJlSX2
         AD5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779909862; x=1780514662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHhJRP5pVLgcPa4KuNaBBD+P9GhP2r2iVQQYvikzvXw=;
        b=YNomHfnEzF1OaAthecomX7+saEVoH0+/ipI3pg7tqQ2Bb7VFFhSTdu3kwZHyP2Yx3k
         9xgRHbfhf45+nHFgT7LQyZ7A//TrWsHBXWnQ/zWY/LCbWpExIIaiaL0FQ5dgNj+X1qDN
         LwySE8mk+EEi1wAGQlMyNrI+PgcLVl9ECFxtrXgXW2kyFge5qRU56l3s7Ry4ZsXZXIUf
         +sNUCuBg9u+Ae1wA7zOgmYCR1s2i+3S+TPjLM6/5VXqyi3/2a//slJ9lU1mtdpfhG2Ho
         Cmg6Y000ndOMHtVd00L4Qu831BXvHb0wrW4MjMr06kZj5WatCxTkSLa3Z9zoETy0Ezzm
         UGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909862; x=1780514662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHhJRP5pVLgcPa4KuNaBBD+P9GhP2r2iVQQYvikzvXw=;
        b=LrLeyME4XL3SFgfhiBAzil7mRM99Vcq68BwJ8WumpMvyNNOHSHK7J5ikYJrh1YdL+q
         PFNIwepYxqv5W6OQ5BB0D0WdfYHNxOz4fCC+j4tB/ciukLje+iYyTQe298176AxSvqVf
         J/su27PAi17E7L/WLukYbYQFvSweurhkIMjrVGWO7ouSIV7kUSVF/RH9JjhkHUw0Dhex
         soOJVmafP0LAHmRUMh0LzNzMLJQyC3NMNk7aSjj1LqVMR6QIqNQHMk9Rte/coICBPTZ5
         mwdhcjXGA4deLjluCq874bohtSwLjyHvbjXzcoKBhS9W4BtLg/3Wy8gxQWgUuGAwLp4M
         I0OA==
X-Forwarded-Encrypted: i=1; AFNElJ/DLmHLAGJtlzzbuCgrXt0CEOG7oIG/AzONUVhpLvN+O/F7EKEN6kiYdT5QHfCNDNJqHu6mZ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMj50IIm4BmV37Yf1PZmXpCXulshH88NV+qcbkjKB+bgWburHu
	6FHwBJK9OiajlikeW8NU1Da/kOYoCM1AtvtofPtDFFDL9mgw4awWlMk9QQfazzIe407z0Hv8UGG
	AZAc7nKDokYHI+ELfov4IqpJKbyoJ916c6UZhrhQyET5RsL6ZdDezXFOZ0juQX7nMBYl5+HeV4b
	thhfrrPCQRVKl7fch6mPgoOoeFhHKPTxUt
X-Gm-Gg: Acq92OGRa56rBhO8eFpOdeb/YNa2Xc1L8VYsAGWmIuEAdNAWZ7HIpQ+ns+CcZljB9Oz
	ghH8NbhFfxBVXd5brEX/HIF9bNp3HQq0irBmupHLCUKEto0k+EatS4fuJc+ccxhvAD2Qs48dxhj
	nlpKAOwlhuWYotnqiYvU+plfgIfdSzqU2yrDuqw4crveoxayHF5qqSBEuwy2GTcfn3/mcz2UGLq
	JJ+HyoQtpgDq/483m58WoyS8ZKQi2+x2bQHnwf+1r7NQ4/eaP7ezwAnx/sXhUrLq15FFwfDvXRz
	YuEtAFnBeV9vhsPB3x6lEeO7iLDXnk6L3io=
X-Received: by 2002:a17:907:a647:b0:bda:24df:21b with SMTP id a640c23a62f3a-bdd251373e1mr1221763566b.5.1779909862386;
        Wed, 27 May 2026 12:24:22 -0700 (PDT)
X-Received: by 2002:a17:907:a647:b0:bda:24df:21b with SMTP id
 a640c23a62f3a-bdd251373e1mr1221762166b.5.1779909861978; Wed, 27 May 2026
 12:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org>
 <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com> <CAHC9VhQfci2gE-eD67DbjL21s7tF+rPWa9bdu0Kk5cfW+gz2Xg@mail.gmail.com>
In-Reply-To: <CAHC9VhQfci2gE-eD67DbjL21s7tF+rPWa9bdu0Kk5cfW+gz2Xg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 16:24:10 -0300
X-Gm-Features: AVHnY4KazjW9-E13AaekWdAuAmWJYNciyg2swPIqPIUBpVIkPmxIqJG7Vw-jMEQ
Message-ID: <CAABTaaDbcuPOxQhE1w0nbq-kK7HEYmkVzs+x1qa0iYsRtsWonQ@mail.gmail.com>
Subject: Re: [PATCH] audit: Update audit_alloc_mark() and audit_dupe_exe()
 CONFIG_AUDITSYSCALL=n stubs
To: Paul Moore <paul@paul-moore.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Eric Paris <eparis@redhat.com>, 
	Waiman Long <longman@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254656-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rrobaina@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,paul-moore.com:url,paul-moore.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F02185E978D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 4:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, May 27, 2026 at 2:55=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Wed, May 27, 2026 at 2:52=E2=80=AFPM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > >
> > > Commit 84470b80b7b0 ("audit: fix recursive locking deadlock in
> > > audit_dupe_exe()") added a ctx parameter to audit_alloc_mark() and
> > > audit_dupe_exe() but did not update the macro stubs used when
> > > CONFIG_AUDITSYSCALL is not enabled, resulting in a build error for th=
is
> > > configuration:
> > >
> > >   kernel/auditfilter.c: In function 'audit_data_to_entry':
> > >   kernel/auditfilter.c:592:85: error: macro 'audit_alloc_mark' passed=
 4 arguments, but takes just 3
> > >     592 |                         audit_mark =3D audit_alloc_mark(&en=
try->rule, str, f_val, NULL);
> > >         |                                                            =
                         ^
> > >   In file included from kernel/auditfilter.c:23:
> > >   kernel/audit.h:327:9: note: macro 'audit_alloc_mark' defined here
> > >     327 | #define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
> > >         |         ^~~~~~~~~~~~~~~~
> > >   kernel/auditfilter.c:592:38: error: 'audit_alloc_mark' undeclared (=
first use in this function)
> > >     592 |                         audit_mark =3D audit_alloc_mark(&en=
try->rule, str, f_val, NULL);
> > >         |                                      ^~~~~~~~~~~~~~~~
> > >   kernel/auditfilter.c:592:38: note: 'audit_alloc_mark' is a function=
-like macro and might be used incorrectly
> > >   kernel/auditfilter.c:592:38: note: each undeclared identifier is re=
ported only once for each function it appears in
> > >   kernel/auditfilter.c: In function 'audit_dupe_rule':
> > >   kernel/auditfilter.c:879:59: error: macro 'audit_dupe_exe' passed 3=
 arguments, but takes just 2
> > >     879 |                         err =3D audit_dupe_exe(new, old, ct=
x);
> > >         |                                                           ^
> > >   kernel/audit.h:333:9: note: macro 'audit_dupe_exe' defined here
> > >     333 | #define audit_dupe_exe(n, o) (-EINVAL)
> > >         |         ^~~~~~~~~~~~~~
> > >   kernel/auditfilter.c:879:31: error: 'audit_dupe_exe' undeclared (fi=
rst use in this function)
> > >     879 |                         err =3D audit_dupe_exe(new, old, ct=
x);
> > >         |                               ^~~~~~~~~~~~~~
> > >   kernel/auditfilter.c:879:31: note: 'audit_dupe_exe' is a function-l=
ike macro and might be used incorrectly
> > >
> > > Update the macros with the correct number of parameters to resolve th=
e
> > > build error.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 84470b80b7b0 ("audit: fix recursive locking deadlock in audit_=
dupe_exe()")
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > >  kernel/audit.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/audit.h b/kernel/audit.h
> > > index f1a77aef4533..92d5e723d570 100644
> > > --- a/kernel/audit.h
> > > +++ b/kernel/audit.h
> > > @@ -324,13 +324,13 @@ extern struct list_head *audit_killed_trees(voi=
d);
> > >  #define audit_watch_path(w) ""
> > >  #define audit_watch_compare(w, i, d) 0
> > >
> > > -#define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
> > > +#define audit_alloc_mark(k, p, l, c) (ERR_PTR(-EINVAL))
> > >  #define audit_mark_path(m) ""
> > >  #define audit_remove_mark(m) do { } while (0)
> > >  #define audit_remove_mark_rule(k) do { } while (0)
> > >  #define audit_mark_compare(m, i, d) 0
> > >  #define audit_exe_compare(t, m) (-EINVAL)
> > > -#define audit_dupe_exe(n, o) (-EINVAL)
> > > +#define audit_dupe_exe(n, o, c) (-EINVAL)
> > >
> > >  #define audit_remove_tree_rule(rule) BUG()
> > >  #define audit_add_tree_rule(rule) -EINVAL
> > >
> > > ---
> > > base-commit: 82bc8394b1aa74aedb9827da7730cfa6639716fd
> > > change-id: 20260527-audit-update-macro-stubs-6e4d8e8a826e
> > >
> > > Best regards,
> > > --
> > > Cheers,
> > > Nathan
> > >
> >
> > Hi Nathan,
> >
> > Good catch, I did miss that! Looks good to me, thanks for fixing it.
> >
> > Acked-by: Ricardo Robaina <rrobaina@redhat.com>
>
> Thanks Nathan!
>
> Do either of you mind if I squash these two patches together in the
> audit tree?  I would preserve Nathan's sign-off line and add a comment
> at the end of the commit description about the fix provided by Nathan.
>
> --
> paul-moore.com
>

It's fine by me.


