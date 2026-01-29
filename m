Return-Path: <stable+bounces-212714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FypKH2lemmN8wEAu9opvQ
	(envelope-from <stable+bounces-212714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:10:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A4DAA1F6
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7970E3004412
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337061A294;
	Thu, 29 Jan 2026 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1ZwhSgu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945493EBF04
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645433; cv=pass; b=m/Lnu9ypdLybiGAZyqC5TpvmTfY3G8dCjVfBAHdP7UXjg9ljDrCIncMx9aBhDCvbJKBFn3Z15v2oEuBh7HlxgJURHNWa9OujvJQBhNZIjYUE97TuIyDZv0TS/h0yGgnxSTofHOjyA7KOqO28Ucvr1i5sDRuazIcstuIGVebsk6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645433; c=relaxed/simple;
	bh=CRea/sHGoU31RRDtXpjn0kXbvznYwwDits66631/iI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxXmHrM6zECch4kWBIphIcMbSnRwN3qrYQ0WzryUtJ1IjZx1jqU1zPEl3qVSK6xFSKQ9XdyimQoTeLvGfOFCSOqPeYb4pQJC5CO2IkYpqaaWaZYZMeSaLdwvjl5qMs80A52sSNT5tjMmRd9WJkQdvvP7zr9T6UEnohdU9EKzrUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1ZwhSgu; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432755545fcso294245f8f.1
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 16:10:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769645430; cv=none;
        d=google.com; s=arc-20240605;
        b=kjWdp0eFSAQwgeDgHn74tIROho2D1niWMQrTTYmawJI+pBNHfc1PxxGAHgROYxQiz/
         1wx6wqv4/Qd+THWppIoaPtJyFFqHdvNU8rtelfQvUNpijJ9yt3oTdBddXgCaTy7gY5Nr
         TUdPOkf6W9pDUqBSDVQX8kNt03ACqHuf6PFWXYgqGlof06q9UYkxoKSthdl0mIyPpAJU
         quZwxwIJeOUOu1LLOOEgQNRRx5io2vdPBmTF/CAfxeJ2kPG0YVEVtYIC3CWcgWAoZXOy
         zLK/eRnujSMz8hdvIWDboG87q1YSsIbCaUKnEyTg3FHINBicLRHMrP77adZ2yeD5Md5p
         oJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uqJ0WvFK3b9iPhiYy6g2qTs0iQN4YJvVeIc2JBueXkU=;
        fh=MTJgx31A20PyqMg5lclN6scNXRKiU5PII70SnqKm9HI=;
        b=HbwTUm0kKQXlnm+eZ9gbQ8o7lVQT06FjtNpAv8tTRm+uN0S9AYWsjhcHTEy31SyfzE
         3dfPM19Y2uQ943DJUARZRNDI6RpeFtWUcbEoHVIwNAwsydAITvdQK4L2kj/5ZmC4Aa43
         Ny7OV0t0htCUtC7wE8ypm1RjoHA3ByuBDXWmlLtMAEAG6xZ7sqBdIfBgULYhi4MQqD9k
         /NcDQJu+TJcp35/lytWXMfsseSDv9LDDD4AnQfipNryMRFFSz1KTuX+tfdGI3xq+wiO7
         lJT0DhKUyDnWrFfjYRJdiXo9kkL+Z1QvNkNYHE5Cq8TgCBlwiayNVdhxiYPaRHRaGVs3
         CI/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769645430; x=1770250230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqJ0WvFK3b9iPhiYy6g2qTs0iQN4YJvVeIc2JBueXkU=;
        b=R1ZwhSgukAbK11t8YuLgthPzrOe0KGWQcNzWQXg9hTRAaoc57OM5Rn6kUaUnMbaE1w
         ya8GN8L7p1yaF9w5d4kgIOwRw9SFyUnDIojLvHcjqA3Tf7JreFNBYO4qsEgLcgvPxG3l
         mtkyog+60vKQshjDziB0XHtgQFOhPQzhXGEmzLskNnoq+6tnfuWearO94+QlKo+n+Njm
         WuV/kl8Ijye2mJfEmNJgg8arvdHzQZgxFQXgaBBex9MFqlDJn70phWH3GoqiLpSF7fFB
         6+Ha3asIcuGOSPO4Jxw6H8krt8CpNGuZGmp+UksvGN3HJqwJZ+sM9N//Eht5l8wlfSAY
         jScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769645430; x=1770250230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqJ0WvFK3b9iPhiYy6g2qTs0iQN4YJvVeIc2JBueXkU=;
        b=rXYjoddwgPrMcKhJTrgYmjhTF4wmoopwE1eaaq65t+opoWblMTHSUvC/UsyLWHd9q0
         piQ9AOgoubf7+0cQrGi/DiMqdoquQE15C1PH0NBmhS6YRe6SIYuBHgCuro5jesAiaEBQ
         Yqe+Otg7KyRHWoXX8p8i5D5wj68AzKx+Y1LUJyP1Dq1FSGGuqEOSfPITgsY9/ITbTJXf
         qq/7bxJuDz/940qagDqiQ1rza23/bshno8HV6OwSpOcvpmt6tdXsjF1qnf8Bvlp1disO
         2fnfN8LM/ZphjTHevCmfyfwoRIGUWUNMGKTxX4AC6FfLsjS+odSim/CUGykyfPpOSs5E
         y2tA==
X-Forwarded-Encrypted: i=1; AJvYcCUPehrX32SUKL2lXUdpAPVZRDpvAT0lzOZOvcRiJDeHJ3XEQDSxkOOQJysDum++8W2I9aJ0UXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwepmMOTIEdgH6cZUdOFe3uCR7kasprI28P9Wh2+xYeFjMkXuK
	yv9W2tdYw9W9mUeZ64zxpE2qxG/BzBLu6Iee/cdivG9C2hkHfBKPlOqfuy8pIe/ugm8fgNtvm/f
	cwAUJkz2qarCz1Rafv7Rtnb45nMwr3u0=
X-Gm-Gg: AZuq6aIq7SoRvVFOaHyPp083UH6JNT3QikuMiaq1aI+bnt0tPMIi7pcIcYeL8NMDdXV
	1lcGCWdgeF5CEJC3SBAUGgPJ3iQXmYj80exqxLHD6ia21bPzdq7bESqTlnXEdZwaYca3R3hUlIq
	QQ3frhJC6O+MiTYAg531SIxT2WOjmVqf2+qQneOptl47U9qAM3VTutDTNpJIWPCVNLHtoKmkKmc
	Ra9n+nUYj2lMpYzQCelYW3pVD2b8dxtfSG2ebg1/O8fnS/cDRMvp/AxIjRZ8Hd/iOHdCZ9+DzA+
	WXZcV/X9sdrAOpg3S5aBs1wqi3w=
X-Received: by 2002:a05:6000:2310:b0:432:ca6c:7b03 with SMTP id
 ffacd0b85a97d-435dd073c8dmr10943655f8f.26.1769645429765; Wed, 28 Jan 2026
 16:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126022715.404984-1-CFSworks@gmail.com> <20260126022715.404984-2-CFSworks@gmail.com>
 <f351a9235ec9da785af840beb28db0513aa66ba6.camel@ibm.com>
In-Reply-To: <f351a9235ec9da785af840beb28db0513aa66ba6.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 28 Jan 2026 16:10:18 -0800
X-Gm-Features: AZwV_QguMmRDCrhJq0NR6nex3VxA2VLwfomnVytdVwhjNkrsdUh2ngEaeAZktgA
Message-ID: <CAH5Ym4hUiVHgHQQA15r2ZRaq8KNg4xLs2Ub5fFs1FaPOcgHZbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ceph: free page array when ceph_submit_write() fails
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	Milind Changire <mchangir@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212714-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: D0A4DAA1F6
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 2:51=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Sun, 2026-01-25 at 18:27 -0800, Sam Edwards wrote:
> > If `locked_pages` is zero, the page array must not be allocated:
> > ceph_process_folio_batch() uses `locked_pages` to decide when to
> > allocate `pages`, and redundant allocations trigger
> > ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
> > writeback stall) or even a kernel panic. Consequently, the main loop in
> > ceph_writepages_start() assumes that the lifetime of `pages` is confine=
d
> > to a single iteration.
> >
> > The ceph_submit_write() function claims ownership of the page array on
> > success (it is later freed when the write concludes). But failures only
> > redirty/unlock the pages and fail to free the array, making the failure
> > case in ceph_submit_write() fatal.
> >
> > Free the page array (and reset locked_pages) in ceph_submit_write()'s
> > error-handling 'if' block so that the caller's invariant (that the arra=
y
> > does not remain in ceph_wbc) is maintained unconditionally, making
> > failures in ceph_submit_write() recoverable as originally intended.
> >
> > Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  fs/ceph/addr.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 63b75d214210..c3e0b5b429ea 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1470,6 +1470,14 @@ int ceph_submit_write(struct address_space *mapp=
ing,
> >                       unlock_page(page);
> >               }
> >
> > +             if (ceph_wbc->from_pool) {
> > +                     mempool_free(ceph_wbc->pages, ceph_wb_pagevec_poo=
l);
> > +                     ceph_wbc->from_pool =3D false;
> > +             } else
> > +                     kfree(ceph_wbc->pages);
> > +             ceph_wbc->pages =3D NULL;
> > +             ceph_wbc->locked_pages =3D 0;
> > +
>
>
> I see the completely identical code pattern in two patches:

The second patch only contains that pattern because it is moving it to
a separate function, patch 2 isn't introducing any *new* code.

>
> +       if (ceph_wbc->from_pool) {
> +               mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
> +               ceph_wbc->from_pool =3D false;
> +       } else
> +               kfree(ceph_wbc->pages);
> +       ceph_wbc->pages =3D NULL;
> +       ceph_wbc->locked_pages =3D 0;
>
> I believe we need to introduce the inline function that can be reused in =
two
> places.

Patch 2 is introducing that inline function as requested -- but that
function is not actually used in two places: for now (in this series),
it is only split out for better readability.

These patches are organized like this because of kernel development
norms: bugfixes intended for stable (such as this patch) should
consist of minimal, backport-friendly and correctness-focused changes.
Moving existing code to a new function is a separate change and does
not constitute a bugfix, so it needs to go in its own patch that isn't
Cc: stable.

Cheers,
Sam

>
> Thanks,
> Slava.
>
> >               ceph_osdc_put_request(req);
> >               return -EIO;
> >       }

