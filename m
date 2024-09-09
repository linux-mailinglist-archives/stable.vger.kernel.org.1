Return-Path: <stable+bounces-74027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BAB971B4A
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6D21C23011
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4183F1B86FE;
	Mon,  9 Sep 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpoYcBH/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EFE17837E
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889266; cv=none; b=YBWKw00v1Ap+7wvO201QBxDLeBJGCf/NGS0xZXCz4iPzZSphivvZYbK+qs6oyq4OGNXkh661bA7CHPqLk7DDvrsLDIn1uC9IddAzsqs/VU1xDLf16Tg9x/R8XknlsimLtot6xwQwV6Qgc82bg9uBjBH4kloK+9d214m3ccnOMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889266; c=relaxed/simple;
	bh=2HABHAAgV4kCrzaxXk3LQSPWgp4+S9wtyI+06OWBT1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HuDaF+U88lJAMmbGSDGvog1KNP4Hpf/XoSpPYyl6fI6cSnZ1l9BZxh1crmkvoxinTAKJkulkWC+U6Sb7tIhsW4zE9yMEmotXYm9x3qfFgkxlnMgP245StM5iMcp44/B2Pf4koNM5yFk2eSBwZajyoQCjiJX8CCIGIM32lo+18MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpoYcBH/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725889262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRT4RGVSoW78yOsC/Y7gv9msChIjfBCcI5oKX4lypl8=;
	b=MpoYcBH/YM/ha3Aj4xIquhWflGyEkd8fShN595Zo4V22tofS/mONxz0Pwga5xfXQgy5KfG
	eHlcsBn4SJlDL2IjNAKldwVT7NNBO6+VD70+lar1LXKYG7VZZrvTmBGc5v3ZZP1WJ25Ygi
	eJN4DU4EpY1uZqv0+mgXJ+zHKXgF1zg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-IC25qax0NQauhRn6VHqpGg-1; Mon, 09 Sep 2024 09:41:01 -0400
X-MC-Unique: IC25qax0NQauhRn6VHqpGg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3787ea79dceso2324344f8f.2
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 06:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889260; x=1726494060;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRT4RGVSoW78yOsC/Y7gv9msChIjfBCcI5oKX4lypl8=;
        b=X0jUaODHfa/m3IZ/b8yV9qLNuPGh20IJLug0DZwLWoYl8TNn2iNLCVrkDPZ5FrC3fR
         WYZm/D8OC/xDZwwhSor0K2r9TDir8j7NpzwcfUR7yuSe5v6/ZRNUuIwsDL1GN2mEvHv/
         Cdrirn1urdsnj1Z46nb/Q2XnOByYCbKx083NmFSoKwFzysQKSLoUToMrWwObeuZ4tKBU
         Blc9mW3Ab6qblqjhxY437+5JN1UqE0devxUGTOQUi8SwouMXFtkdJ3sKXS1sWiScO+Gh
         elL6VncyvwZoN/Qr6dkEn0XyDn9ZKevW5hvffNqMdQ1H2Gld/ohIju0VIMHth3F2ZlAg
         DxMA==
X-Forwarded-Encrypted: i=1; AJvYcCVxOZPrqJAcowV4KlXnfsNC7pYYfP1222wUTFl2zJ4jQNYuGzDp5SndoWkhMXalxYnRV2arTfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8E/MwLDCy9qO4ucN3xc7vswmGOezzAl8cNIs3gc5ypKb4b6fd
	HijrvrJCRRPDcdGeSZ4lotM+vBircX6TkgKnm6WNohKcqaDUzts3lkiZRSsvIVDUgwp3tMZQgiM
	hMy5VGxl5Ylpm4whZHqCgHt+qNpaCDL2iciJYis3UQAd2gDkazo6z0w==
X-Received: by 2002:adf:f38b:0:b0:374:c847:859 with SMTP id ffacd0b85a97d-37894a6b15dmr4073465f8f.54.1725889260408;
        Mon, 09 Sep 2024 06:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpHrLlqrLCC/C9OzpjJS85NonzndADR4+sBGv0pOLpgNEZxs4Hgk1jmN1WiQIH+0KN4RFJBg==
X-Received: by 2002:adf:f38b:0:b0:374:c847:859 with SMTP id ffacd0b85a97d-37894a6b15dmr4073453f8f.54.1725889259813;
        Mon, 09 Sep 2024 06:40:59 -0700 (PDT)
Received: from dhcp-64-8.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956654e8sm6085882f8f.41.2024.09.09.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:40:59 -0700 (PDT)
Message-ID: <3d361fc62a43dde95ce31185470d3a153c648909.camel@redhat.com>
Subject: Re: [RFC 1/4] drm/sched: Add locking to
 drm_sched_entity_modify_sched
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, Tvrtko Ursulin <tursulin@igalia.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>,  Matthew Brost <matthew.brost@intel.com>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 stable@vger.kernel.org
Date: Mon, 09 Sep 2024 15:40:58 +0200
In-Reply-To: <1848b0fc-7031-46f2-b7f8-f7c086fb00ce@igalia.com>
References: <20240906180618.12180-1-tursulin@igalia.com>
	 <20240906180618.12180-2-tursulin@igalia.com>
	 <8d763e5162ebc130a05da3cefbff148cdb6ce042.camel@redhat.com>
	 <80e02cde-19e7-4fb6-a572-fb45a639a3b7@amd.com>
	 <2356e3d66da3e5795295267e527042ab44f192c8.camel@redhat.com>
	 <fb9556a1-b48d-49ed-9b9c-74b21fb76af4@amd.com>
	 <14ef37f4-b982-41c1-8121-80882917e9c0@igalia.com>
	 <d8944e6ad57e4efcd480d917a38f9cee9475d59c.camel@redhat.com>
	 <1848b0fc-7031-46f2-b7f8-f7c086fb00ce@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-09 at 14:27 +0100, Tvrtko Ursulin wrote:
>=20
> On 09/09/2024 13:46, Philipp Stanner wrote:
> > On Mon, 2024-09-09 at 13:37 +0100, Tvrtko Ursulin wrote:
> > >=20
> > > On 09/09/2024 13:18, Christian K=C3=B6nig wrote:
> > > > Am 09.09.24 um 14:13 schrieb Philipp Stanner:
> > > > > On Mon, 2024-09-09 at 13:29 +0200, Christian K=C3=B6nig wrote:
> > > > > > Am 09.09.24 um 11:44 schrieb Philipp Stanner:
> > > > > > > On Fri, 2024-09-06 at 19:06 +0100, Tvrtko Ursulin wrote:
> > > > > > > > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > > > > >=20
> > > > > > > > Without the locking amdgpu currently can race
> > > > > > > > amdgpu_ctx_set_entity_priority() and
> > > > > > > > drm_sched_job_arm(),
> > > > > > > I would explicitly say "amdgpu's
> > > > > > > amdgpu_ctx_set_entity_priority()
> > > > > > > races
> > > > > > > through drm_sched_entity_modify_sched() with
> > > > > > > drm_sched_job_arm()".
> > > > > > >=20
> > > > > > > The actual issue then seems to be drm_sched_job_arm()
> > > > > > > calling
> > > > > > > drm_sched_entity_select_rq(). I would mention that, too.
> > > > > > >=20
> > > > > > >=20
> > > > > > > > leading to the
> > > > > > > > latter accesing potentially inconsitent entity-
> > > > > > > > >sched_list
> > > > > > > > and
> > > > > > > > entity->num_sched_list pair.
> > > > > > > >=20
> > > > > > > > The comment on drm_sched_entity_modify_sched() however
> > > > > > > > says:
> > > > > > > >=20
> > > > > > > > """
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0* Note that this must be called und=
er the same
> > > > > > > > common
> > > > > > > > lock for
> > > > > > > > @entity as
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0* drm_sched_job_arm() and
> > > > > > > > drm_sched_entity_push_job(),
> > > > > > > > or the
> > > > > > > > driver
> > > > > > > > needs to
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0* guarantee through some other mean=
s that this is
> > > > > > > > never
> > > > > > > > called
> > > > > > > > while
> > > > > > > > new jobs
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0* can be pushed to @entity.
> > > > > > > > """
> > > > > > > >=20
> > > > > > > > It is unclear if that is referring to this race or
> > > > > > > > something
> > > > > > > > else.
> > > > > > > That comment is indeed a bit awkward. Both
> > > > > > > drm_sched_entity_push_job()
> > > > > > > and drm_sched_job_arm() take rq_lock. But
> > > > > > > drm_sched_entity_modify_sched() doesn't.
> > > > > > >=20
> > > > > > > The comment was written in 981b04d968561. Interestingly,
> > > > > > > in
> > > > > > > drm_sched_entity_push_job(), this "common lock" is
> > > > > > > mentioned
> > > > > > > with
> > > > > > > the
> > > > > > > soft requirement word "should" and apparently is more
> > > > > > > about
> > > > > > > keeping
> > > > > > > sequence numbers in order when inserting.
> > > > > > >=20
> > > > > > > I tend to think that the issue discovered by you is
> > > > > > > unrelated
> > > > > > > to
> > > > > > > that
> > > > > > > comment. But if no one can make sense of the comment,
> > > > > > > should
> > > > > > > it
> > > > > > > maybe
> > > > > > > be removed? Confusing comment is arguably worse than no
> > > > > > > comment
> > > > > > Agree, we probably mixed up in 981b04d968561 that
> > > > > > submission
> > > > > > needs a
> > > > > > common lock and that rq/priority needs to be protected by
> > > > > > the
> > > > > > rq_lock.
> > > > > >=20
> > > > > > There is also the big FIXME in the drm_sched_entity
> > > > > > documentation
> > > > > > pointing out that this is most likely not implemented
> > > > > > correctly.
> > > > > >=20
> > > > > > I suggest to move the rq, priority and rq_lock fields
> > > > > > together
> > > > > > in the
> > > > > > drm_sched_entity structure and document that rq_lock is
> > > > > > protecting
> > > > > > the two.
> > > > > That could also be a great opportunity for improving the lock
> > > > > naming:
> > > >=20
> > > > Well that comment made me laugh because I point out the same
> > > > when
> > > > the
> > > > scheduler came out ~8years ago and nobody cared about it since
> > > > then.
> > > >=20
> > > > But yeah completely agree :)
> > >=20
> > > Maybe, but we need to keep in sight the fact some of these fixes
> > > may
> > > be
> > > good to backport. In which case re-naming exercises are best left
> > > to
> > > follow.
> >=20
> > My argument basically. It's good if fixes and other improvements
> > are
> > separated, in general, unless there is a practical / good reason
> > not
> > to.
>=20
> Ah cool, I am happy to add follow up patches after the fixes.
>=20
> > > Also..
> > >=20
> > > > > void drm_sched_rq_update_fifo(struct drm_sched_entity
> > > > > *entity,
> > > > > ktime_t
> > > > > ts)
> > > > > {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Both locks need to be grabbed, o=
ne to protect from
> > > > > entity-
> > > > > > rq
> > > > > change
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for entity from within concurren=
t
> > > > > drm_sched_entity_select_rq
> > > > > and the
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * other to update the rb tree stru=
cture.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock(&entity->rq_lock);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock(&entity->rq->lock);
> > >=20
> > > .. I agree this is quite unredable and my initial reaction was a
> > > similar
> > > ugh. However.. What names would you guys suggest and for what to
> > > make
> > > this better and not lessen the logic of naming each individually?
> >=20
> > According to the documentation, drm_sched_rq.lock does not protect
> > the
> > entire runque, but "@lock: to modify the entities list."
> >=20
> > So I would keep drm_sched_entity.rq_lock as it is, because it
> > indeed
> > protects the entire runqueue.
>=20
> Agreed on entity->rq_lock.
>=20
> > And drm_sched_rq.lock could be named "entities_lock" or
> > "entities_list_lock" or something. That's debatable, but it should
> > be
> > something that highlights that this lock is not for locking the
> > entire
> > runque as the one in the entity apparently is.
>=20
> AFAICT it also protects rq->current_entity and rq->rb_tree_root in
> which=20
> case it is a bit more tricky.

Then in any case we'll also have to update the documentation snippet I
had quoted above.

btw. I'm not saying you have to do all of that; I'm also currently
working on some additional scheduler documentation.

>  Only rq->sched is outside its scope. Hm.=20
> Maybe just re-arrange the struct to be like:
>=20
> struct drm_sched_rq {
> 	struct drm_gpu_scheduler	*sched;
>=20
> 	spinlock_t			lock;
> 	/* Following members are protected by the @lock: */
> 	struct list_head		entities;
> 	struct drm_sched_entity		*current_entity;
> 	struct rb_root_cached		rb_tree_root;
> };
>=20
> I have no ideas for better naming.

Hmmm. Difficult.

Maybe rq_outer_lock <-> rq_inner_lock or "partial" and "whole".

Explains why no one ever bothered renaming it.

>  But this would be inline with=20
> Christian's suggestion for tidying the order in drm_sched_entity.
>=20
> I am also not sure what is the point of setting rq->current_entity in
> drm_sched_rq_select_entity_fifo().

It seems to me that current_entity is only used (read) in
drm_sched_rq_remove_entity() and drm_sched_rq_select_entity_rr(). It=20
seems to be only really useful for the RR function?

drm_sched_rq_select_entity_fifo() was added later, in 08fb97de03aa2,
and it's very likely that the author oriented himself at the RR
function. So it's possible it's actually not needed and was just copied
by accident.


P.

>=20
> Regards,
>=20
> Tvrtko
>=20
> >=20
> >=20
> > Cheers,
> > P.
> >=20
> > >=20
> > > Regards,
> > >=20
> > > Tvrtko
> > >=20
> > > > > [...]
> > > > >=20
> > > > >=20
> > > > > P.
> > > > >=20
> > > > >=20
> > > > > > Then audit the code if all users of rq and priority
> > > > > > actually
> > > > > > hold the
> > > > > > correct locks while reading and writing them.
> > > > > >=20
> > > > > > Regards,
> > > > > > Christian.
> > > > > >=20
> > > > > > > P.
> > > > > > >=20
> > > > > > > > Signed-off-by: Tvrtko Ursulin
> > > > > > > > <tvrtko.ursulin@igalia.com>
> > > > > > > > Fixes: b37aced31eb0 ("drm/scheduler: implement a
> > > > > > > > function
> > > > > > > > to
> > > > > > > > modify
> > > > > > > > sched list")
> > > > > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > > > > Cc: Luben Tuikov <ltuikov89@gmail.com>
> > > > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > > > > Cc: David Airlie <airlied@gmail.com>
> > > > > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > > > > Cc: <stable@vger.kernel.org> # v5.7+
> > > > > > > > ---
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_ent=
ity.c | 2 ++
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A01 file changed, 2 insertions(+)
> > > > > > > >=20
> > > > > > > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > > > > b/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > > > > index 58c8161289fe..ae8be30472cd 100644
> > > > > > > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > > > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > > > > @@ -133,8 +133,10 @@ void
> > > > > > > > drm_sched_entity_modify_sched(struct
> > > > > > > > drm_sched_entity *entity,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0{
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(!num_sch=
ed_list || !sched_list);
> > > > > > > > +=C2=A0=C2=A0=C2=A0 spin_lock(&entity->rq_lock);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entity->sched_li=
st =3D sched_list;
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entity->num_sche=
d_list =3D num_sched_list;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 spin_unlock(&entity->rq_lock);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0}
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0EXPORT_SYMBOL(drm_sched_entity_modi=
fy_sched);
> > > >=20
> > >=20
> >=20
>=20


