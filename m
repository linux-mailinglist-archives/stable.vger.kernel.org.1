Return-Path: <stable+bounces-248913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DMDIf+GB2r57AIAu9opvQ
	(envelope-from <stable+bounces-248913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:50:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7915578DD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57EFC300A8D8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE5366820;
	Fri, 15 May 2026 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L11pyYjH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701A34251D
	for <stable@vger.kernel.org>; Fri, 15 May 2026 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878203; cv=pass; b=BYxnZoGg/QkkVe4ObBNfjSgYaai6+02CWYiWn3TqNh7zN2BNH001pCpDtO23fzDygMH5GKP6BIl+NlK9ZO8mQhOx10U6N4Fj16uhefOVpI/X8lbR3woxZLPn39yHvCqRnTQBJwl6IUZNMAQtDaBBQxgY+DK52+0MzbSlPHf9PnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878203; c=relaxed/simple;
	bh=twKFMm3fnXpbB27v6g9MCxMEqzROBKrV8kJXpuF6zrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkHSYAcWFnzAcugv3xvS16bzYeZT5VzGA3ZvuAu2RZAmggc4lI/srYWpFA+bkPFnLs0/e9PenkMprifELecoGRpBtHcQZSpdUNpAYEDuF8QeEmXXnCY0noRhVgDMjLUw3vjQ/sC1Xj4pHlVHt/191HLB9nJZiGUMsasI5mdNBjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L11pyYjH; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45d96d21e82so93836f8f.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 13:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778878201; cv=none;
        d=google.com; s=arc-20240605;
        b=JuaEyzb7+Q0Hs66vG/m9CxxudPDGfs36o17pSwKyWEHf05I0qnNWXMETpzqiWNKZOm
         J/982UfdunHiM/aG3C6S4tuFCgBoiGpOqNphfhb7ec2VZdOKShXF7MSCYpAK+Lastt1t
         o+J9Y6T3L5VaJxrVPAWQg1T5qw1QcwfK0b8YnNPRunYqzGYqQU3Zzrm4YpkaKtphUMEP
         dASA8s8fWbej2LFeMh/CEpATBBnNjXPrL4PMeW0rlQbvbwEf/9CTydCrJmw5s+PcmOWE
         eSR7Zn6GDnQXm78JfK887Umanpy+5MV/tsoiOQGDAtdaQT/uJQbl05Sq0acMZ9KZMFUB
         gAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ij3w2CjfgNV2o6HdX3r2I2TaWMvjfbeVIPwDmb0njk=;
        fh=QC09hDYhQWz6abeYNo2ZCg7//Fei3mfVkJRMg5LRVH0=;
        b=DdFV5anJSuds++8z/k3GBz7O60gwg2fyZs0IG44/ZWlYAmpxbdZ5ojzmZ9zPzvPtVM
         FH6J5CuAc5SZseAmoI/1RDytCaAhCQklK2e4AIXK+QAUz4+3EAZcxqcHBPI0sPI24szf
         8z8NHzphzDXvNoCM927Tr4X3FOe1n2PJmz+CWadCSPLp558c4cGRWpv9HPR9Tv22khCt
         SI3AAWA29ob7X3dO5DMJTm1vCpMQmTyQpBDj7ZA0DmNwSzuW/RWcrSXL6wSikNzOTknj
         SUa26sp/Cv16jDjQhfOOgld8OrVeFvEXM8mxNgh3ao0IqVNS6cJwLn5lyuPPZYq1uGOB
         K0tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778878201; x=1779483001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ij3w2CjfgNV2o6HdX3r2I2TaWMvjfbeVIPwDmb0njk=;
        b=L11pyYjHWnqlFv7n2iAIXHa3Gojk09kKVxSWLYvopSYYqvSghYFlGbHP68zAlZUKgX
         oCQJ/II6ca0ZLTophvIumj1iMyAStgO7+RjE5ycPjTaOsGXIM0vGNgkO9vXeZU1s5Aom
         T25cUWlKbGMhv+bvUwrswbhjJB2vCq8r1PvV6iLdw3+141GYjciKcnatgaA6bElfyxQa
         dDQZMgfsOQgZarEPc384tjXJOZS33mn50Zzg/mAJbPaFV5BkcRee3Ba1RB6ktE82TPqB
         UdTiQwOtXUz+jVaUkhpmZgo4POGzKRl2PXhUMTfU58N6adOh2+8bXwod+ZzDFdaiP0cp
         DphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778878201; x=1779483001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ij3w2CjfgNV2o6HdX3r2I2TaWMvjfbeVIPwDmb0njk=;
        b=XzzgCS3hbiBQnttrBxXCbiWmV6bTTZQzTZf22l6lnz8rtNG8nUXGn0IQiXjwIkkf/j
         NhoPd3F4oWpTs/ciLMC9lS3++XJ7AuHD8KOsiSsZO494hodLsIK4ylppocN5EzjDXtG5
         0TOqUJkfNBbek61wZZwb+wcxjAL1gHoI8jnoMxj1QrbrQo0WvJR+RKx73+rSZcbjxPb5
         GEa2Vs1dd+ebUZHvON5dzkn0uqleTWG377X4dTUpOOkgPw+RDCPlGDNIbiLsICAzfuYB
         tDw+RbJykQSOs2MC2MCd5oojp+WL++cWsGLsD1LTL8y2o0i71tSxRGT68k6rwccJM/sE
         t3KQ==
X-Forwarded-Encrypted: i=1; AFNElJ+huWuLT7hd2q0hTKWCEh7fn9oHh64VEPlZKRbO8QEDysIku5sKH6AP6KO0OT+wS5k4Y7yGCIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNg5v7ybvRWB/TZg/YqPQW4RmE50u3kRUHsaCyFxz5NjJMpvm
	SA1/3UAPfn6IlZgwd5xTDm7xRi6UIm5JsRcZVrlrvvHbUQbJvOo+QbYkKS+yYdrQ9W2rYWQvFcl
	sBRyTBMS9QShkYAIyG11jSIutwh7heXQ=
X-Gm-Gg: Acq92OHKviAcxF8XR3TU/uyz+Iwply5fdrYlRuIgTHdf0BEDYbfUx+At1nqLdhUPmg7
	Eq8lsVofxuYIwT5e7MN+2mozh3qpJqGQV2WtRtyhDAO8oy0hKlbKy2SqeOyogph8inmGBD0z+AD
	ffVY4DEMGnBvKuGd5uVYBNfRmM/zdyn+IdbdrBCvwgV2hm6kNGNG4wD6imZ2bzri+iVv16rjXYE
	rGFUsFePMQf9FAtJfMVXrK4nFDusp6f7l8YucbdOjl3JjeveVlJqz4yJuyyMXzkCB/p0ujO4H46
	9cma/w==
X-Received: by 2002:a05:6000:230b:b0:452:8772:b36a with SMTP id
 ffacd0b85a97d-45e5c58fd1cmr7309071f8f.2.1778878200619; Fri, 15 May 2026
 13:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515045541.1171335-1-joannelkoong@gmail.com>
 <20260515045541.1171335-2-joannelkoong@gmail.com> <f5ce0e4e-bd77-49f7-82eb-7429242e3c12@bsbernd.com>
In-Reply-To: <f5ce0e4e-bd77-49f7-82eb-7429242e3c12@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 15 May 2026 13:49:49 -0700
X-Gm-Features: AVHnY4KIx6110b-6gW_wIcikfkqAYxppkvuMyi_MB3_gOmxEta5DWqCohkZvjUk
Message-ID: <CAJnrk1bWUR7cz_rTK5XNvBO=T8XgX9L5z2JQ3kuXO5iMHXDqTw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] fuse: fix race between ring creation and
 connection abortion
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, ali@ddn.com, 
	horst@birthelmer.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DB7915578DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248913-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 4:57=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 5/15/26 06:55, Joanne Koong wrote:
> > This fixes this race:
> > - thread a: fuse_uring_cmd() gets called, passes fch->connected check
> >   (connection abortion not yet triggered)
> > - thread b: abort is called, calls fuse_uring_abort(),
> > fuse_uring_abort() is a no-op since ring =3D=3D NULL right now
> > - thread a: creates ring, creates queue, creates entry
> >
> > which results in
> > - leaked ring, queue, ent
> > - if thread a increments queue_refs before thread b calls
> >   fuse_chan_wait_aborted(), then fuse_chan_wait_aborted() calls
> >   "wait_event(ring->stop_waitq, atomic_read(&ring->queue_refs) =3D=3D 0=
);"
> >   which will hang the abort/unmount thread indefinitely in unkillable
> >   state, as nothing will decrement queue_refs or wake stop_waitq.
> >
> > Fix this by checking fch->connected under fch->lock in
> > fuse_uring_create() before publishing the ring via
> > smp_store_release(&fch->ring, ring) under the same lock scope.
>
> We had this discussion before, I still think it is covered by 2nd patch
> "fuse: fix race between registration and connection abortion", because
>
> fuse_uring_destruct() is called by delayed_release() in inode.c and that
> is only called when there is nothing accessing /dev/fuse anymore.
>
> The follow-up patch also handles ring->queue_refs going to 0.
>
> From my point of view, what this patch really does is to avoid ring and
> queue creation overhead when the connection is going down anyway, so
> just the commit message is a bit confusing.

Good point, when I looked at this last month, i had split it into this
patch first before the registration one. I'll reorder it so the
registration one goes first and update the commit message for this
one. Thanks for reviewing the patches!

Thanks,
Joanne

>
> >
> > Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands"=
)
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index e467b23e6895..cd75f61018ec 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -244,6 +244,10 @@ static struct fuse_ring *fuse_uring_create(struct =
fuse_chan *fch)
> >       max_payload_size =3D max(max_payload_size, fch->max_pages * PAGE_=
SIZE);
> >
> >       spin_lock(&fch->lock);
> > +     if (!fch->connected) {
> > +             spin_unlock(&fch->lock);
> > +             goto out_err;
> > +     }
> >       if (fch->ring) {
> >               /* race, another thread created the ring in the meantime =
*/
> >               spin_unlock(&fch->lock);
>
>
> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
>
>

