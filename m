Return-Path: <stable+bounces-227010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKOADNRyumkeWwIAu9opvQ
	(envelope-from <stable+bounces-227010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:39:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEEA2B93AD
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E71F3186F8D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0A73B8BA7;
	Wed, 18 Mar 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K+JEMtYW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213F3B7B9B
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826457; cv=pass; b=L5DDEJ/Hf8/2ls89PIYj+oQ0wHelW0ouRjTT+GH3vAFftauIapE2eUof1+vpQQdtf/O/sMAhpXPQpdFPuPN9N+s3w91Hz+1wKkPxlrsGH7CtuvZW8shp/Da9XMCAxjh45rwZdON3aTXf1S5qYChNeZYrH9TP7bulCP57EuSx1hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826457; c=relaxed/simple;
	bh=FgwypM2/jduioBmSjpVWhPtL8Tudc0OhB5HXfAUjt0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoWR2HkXfnGTEC6oZ5YOTf0QGdZ5Wl0/822d134P/nrx1mqO6ez32qjayveIHPhA01QcU78QtPf1OwdaLfURGIfPpjS+uwqOKZOmQqnc7/cvBp8pM+whkUzcMXpQ6iCKGf6s6T8xvy+VCgVGAzMD4U4zgm7Xb2IZhj1Na9NYXd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=K+JEMtYW; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-505a1789a27so34650731cf.3
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 02:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826449; cv=none;
        d=google.com; s=arc-20240605;
        b=KxSz2xiwkRuIGP5aCq9bszHvnSQvv/rIUdcESUDYTdCC1C7v5itjnJ6zQL3HR+tr9w
         LcgCyejpK3OPjd2GMFI2q9AdhVE4qAd35P+/81dMWAjfq7pmFa1RCKJa6LC+t6HkCG6u
         iKwvc+ghVrUHtQ6BARrWoljTdJn15qin1cJTzJJrkzyx/R09wh1Sk6GQfU+eMwk+ZSeL
         7BeFDOepDkV+Hq/rHt2W0bCh5EqRceL2vGx0CWlKUXroreKC3kttPJsoztkHOwe6Ofc5
         8gaBa5OIJvZzXR1jqm14XqzDN6Vmup/i44wEQ1HV/hlFb7ecQS16RLrhJqLvABGPMLb0
         qk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sSllBgqSMghiwQLqLxGBHsfbw2/TvkAtTe1iuB8Im0A=;
        fh=pr6l0AcHSKHli4B519jn74SKK2SfR+zi+ioSWUH3CoM=;
        b=Hllla3pAeRyVZHaYRRg4f3WMZkqo7w4AFuo5jsx3LnT5SsEcSHTd4SXsBAqmikKgiW
         OcI3NtpURJWr6GHN/Dc1LZ7LE2cY1fBOXRVZ6CUfTKse0sWS0frWq9y9UGwC9ZlYHgoK
         9L44DbHLDI0Lf6eU8bFRXSIhEax/1fBoFUOW8huKplQcn2HGkB6oSarU3YrZq4dNj98y
         BpJu+6Wo8H2gvd8ZZBLNtp3jlxpkdGbW5pqT9js8qyq0kmexEvgi4qXtoIEaaz9tjqam
         +TH3i08fRJCgAt1UBg3GvnFoLJlwmu8hO7Mps9KzvvGDTHqaJKpq2K54yqaMnFsNKUii
         FlJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1773826449; x=1774431249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sSllBgqSMghiwQLqLxGBHsfbw2/TvkAtTe1iuB8Im0A=;
        b=K+JEMtYWVlubcp1/NWU4UXfcjCLBId6bLRLK3xNG0dJVOi77qaMEW2ptk4kMf+ZxsH
         Djq7yTwZnAd0C4RcSa0c230oe1TV1VQr+InEx+f2j0JZzxR8fI6hHl8ng32XukPm1GyX
         7w0jH4RavfDza6z2HHSAfr4JyPXBxjSqhsYgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773826449; x=1774431249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSllBgqSMghiwQLqLxGBHsfbw2/TvkAtTe1iuB8Im0A=;
        b=NxUgd12VgDgRImbgTYcKEgyOnCc4tdnQZXVqXu/MR7bkqIOwp6M6rJEmHXUYuc9dBV
         /+/GBmDdAoVMOQ9xlfCqJEUHo8BOnByDYCLUth+vXW+SvE9B03Aepmaq8R8RH3osOlyI
         63I2RqxB+Jjb+KuyZvsKEgSgVOli9i2y89E/lMjGGN6jI+6+84bNOx9eJMFHEFekwigb
         pGwxBTm2p3+tbNnEKrjXMIqouRhCBAHn3tdTwGel568zp1PFjYH2uKjsrtZdsKWxcQdS
         BcENEdZXc9Lh0Oa3rbisDKMhZs0+XKGzXr+8MKfQDXpDyZ7u6FbkTH+J8xL+RsEInOTP
         qRGw==
X-Forwarded-Encrypted: i=1; AJvYcCWh85YVoc7CJgsNW5e5KGtzfrCl7QIQRFCYq2+ODWl/j7t4tubPep2pVCQdTTyrQIj3WN849Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4m+cIInYu6/TnKL24PtwI9+coywMZwjhgvGmj54RliAUbSSIm
	leLqdjanLjbj0W0jjd8D1D8WvFE7gzIzS72mAC3oBLik2gFcLG9RsEXX0g1gkrFBSPoeGzrwoks
	igIThppv2zQ7IuPYyRuhKS9XiCpQUz+iF9yR4ZVxGDQ==
X-Gm-Gg: ATEYQzxirPo1MLgWwqFsDDSKs5Hy+jbZJVm05o51AuusvAaANSk87TYxFoGRf4f1w+k
	cy+TNz+cMf8zYaW2CDiMA8JUUfxWaLVZ/9M510EPicny8Pbig/0BaBhUc71JDlzjaMxIz+W6iZN
	OjPU0jTVmjgcHrDOxf+Qaz56iNuJMVMQQRYThyLQlel2krwtN0xA3Heik9fcTjsDeYVlDotlMBP
	PHgoRi0emcVwxmeO4is0Q4Fa2lx7ntz5GkS0O3p3nS7QSCikPS1RbAeqNR+3gAoeYg42DU6+ECw
	d1h4ij7GbYBRRjn0CgypepGtdONoB++3XSs+Ug10
X-Received: by 2002:ac8:7d0b:0:b0:509:44c3:5ff6 with SMTP id
 d75a77b69052e-50b147cb2d8mr29167171cf.32.1773826449375; Wed, 18 Mar 2026
 02:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316165320.3245526-1-mszeredi@redhat.com> <20260316165320.3245526-2-mszeredi@redhat.com>
 <0fb13941-6fca-433f-a560-9da51113d88f@bsbernd.com>
In-Reply-To: <0fb13941-6fca-433f-a560-9da51113d88f@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Mar 2026 10:33:58 +0100
X-Gm-Features: AaiRm52YxwAdl4yxvi4IYC4_ikRu2-TvWci0NKOKZP5OiNNSFOCKGcwpuJP2NGA
Message-ID: <CAJfpeguhwLHh=Fk+EGG_j9ap8yHgn9Mkocy-9X_0O-uuo_q3-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] fuse: abort on fatal signal during sync init
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227010-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,bsbernd.com:email]
X-Rspamd-Queue-Id: AEEEA2B93AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 at 21:24, Bernd Schubert <bernd@bsbernd.com> wrote:
>
>
>
> On 3/16/26 17:53, Miklos Szeredi wrote:
> > When sync init is used and the server exits for some reason (error, crash)
> > while processing FUSE_INIT, the filesystem creation will hang.  The reason
> > is that while all other threads will exit, the mounting thread (or process)
> > will keep the device fd open, which will prevent an abort from happening.
> >
> > This is a regression from the async mount case, where the mount was done
> > first, and the FUSE_INIT processing afterwards, in which case there's no
> > such recursive syscall keeping the fd open.
> >
> > Fixes: dfb84c330794 ("fuse: allow synchronous FUSE_INIT")
> > Cc: stable@vger.kernel.org # v6.18
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/fuse/dev.c    | 6 +++++-
> >  fs/fuse/fuse_i.h | 1 +
> >  fs/fuse/inode.c  | 1 +
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 2c16b94357d5..f0631c48abef 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -576,6 +576,9 @@ static void request_wait_answer(struct fuse_req *req)
> >                       removed = fuse_remove_pending_req(req, &fiq->lock);
> >               if (removed)
> >                       return;
> > +
> > +             if (req->args->abort_on_kill)
> > +                     fuse_abort_conn(fc);
> >       }
> >
> >       /*
> > @@ -676,7 +679,8 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
> >                       fuse_force_creds(req);
> >
> >               __set_bit(FR_WAITING, &req->flags);
> > -             __set_bit(FR_FORCE, &req->flags);
> > +             if (!args->abort_on_kill)
> > +                     __set_bit(FR_FORCE, &req->flags);
> >       } else {
> >               WARN_ON(args->nocreds);
> >               req = fuse_get_req(idmap, fm, false);
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7f16049387d1..23a241f18623 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -345,6 +345,7 @@ struct fuse_args {
> >       bool is_ext:1;
> >       bool is_pinned:1;
> >       bool invalidate_vmap:1;
> > +     bool abort_on_kill:1;
> >       struct fuse_in_arg in_args[4];
> >       struct fuse_arg out_args[2];
> >       void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index e57b8af06be9..84f78fb89d35 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1551,6 +1551,7 @@ int fuse_send_init(struct fuse_mount *fm)
> >       int err;
> >
> >       if (fm->fc->sync_init) {
> > +             ia->args.abort_on_kill = true;
> >               err = fuse_simple_request(fm, &ia->args);
> >               /* Ignore size of init reply */
> >               if (err > 0)
>
>
> I haven't looked at the other patches yet, so basically the mount can be
> aborted with ctrl-c, but no self abort in this patch yet.

This should work with all kinds of exit, since they ultimately
generate signals on all threads.

So the rest of the patchset are not even part of this fix, they are
just cleanups/improvements.

Thanks,
Miklos

