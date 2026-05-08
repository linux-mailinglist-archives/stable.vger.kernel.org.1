Return-Path: <stable+bounces-244675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMR2HleH/WmefQAAu9opvQ
	(envelope-from <stable+bounces-244675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:48:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC14F29CE
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BA37300E611
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FEA378D71;
	Fri,  8 May 2026 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7CwdJuM"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9D378832
	for <stable@vger.kernel.org>; Fri,  8 May 2026 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222923; cv=pass; b=FZ4O5xFzhdBsg7kNTwBSNLrBIWOhkX9EDQQzQ5hL5G5pn/hYfmGNSTw/TR8TwYUSD/l8RGY3guIMOZWCgYqSucJEoJ3YhWpNv33zVv7tlW/6L8JpFAhOBtbI/xxbudjgrFmu3k2AEJ51/YHKVZL3przkKBB/j4SCOer7oq2QAJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222923; c=relaxed/simple;
	bh=EGcrfjCczEVgaKEMiU7nxbTB6uUaxlzGI2xTs0mhyOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFPIkaJmt3QZ4B6TnJwon3E7/92Cp8hg46x1B4lGXxi849YhRBkpdITNiMKfZZO6J7ok9HnoCjD/MLbdxt7iakY8aqCSfO6U/HCaYddKWX4XI2dgEKpTZ/9425733Fpx9Fz0F2fwhHZ/+u15Ldsu0bqdUDebLDCkMYy0NVKptJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7CwdJuM; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-57513733658so574419e0c.3
        for <stable@vger.kernel.org>; Thu, 07 May 2026 23:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778222918; cv=none;
        d=google.com; s=arc-20240605;
        b=TpzVf94bwJyS76zMy+Pe3e7M+PUIGA0+3GkbywFvYPy55mwyfIUD6PoA+kr8vJKvDA
         rwjFjYb5cZHUX/i7d6Yk5na3AhGGgQsSp9lLJkLMDa2UXUWDzP6kMjlp5kbatTO1xhKo
         LUV+lN2cryeBEVgWIybm7YPTdkEdEPmo5UDyx8tRj1YHwBJqz9tvLT6oGV3pY4IhgJxa
         XewQYMrZr0t/Ah3WA/GOEH1OC/u18ufwmuzq5jK8G+89cZV/ndwbwXSfQnUyoh40OKgs
         oguSSyRzocfScNr94ZuvnQn3V4OIG/RODSm3Bo87FwoyFIddTWMzI9iQv/62FqGqVh0J
         wdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PlYtjNBoIg67o0Kg+ur2eEMfxgNBWO5gDdNf6ayVmuQ=;
        fh=i5K/EHaufbBeD3Q+JX0bmV53iQ3RmKDSvYo7W1kezqw=;
        b=ci/r9fVTIPlCKz3gPue3fr/NdqJQZnFI+m4RmHAsPD3n6W8sedK/8jx/yIh78eFumv
         JfdYrlNID6fJIuX+tIATlT5aEhnziQjIA7NIJNsRBd+Yd+f+5LCF47InSuC6tfAdowFY
         a1xa0YG4xusPxJJlrLVKrCULkMdXhwYOwsL9M/uWdpY9+gHQTfQEY5Ioijo+xRbvQeAK
         VxP6XZHW/21JQUttO2JpBeBhGavRPI5XnvchjltYHT7Y7xO30w7PccgspYui1roizwMi
         dbYgvA46g8iteIgkGhPF317zmGJ5WQvSQJUS7osx3ErVPiEkJJ+YZbFrOHdN2IqONdLK
         xn8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778222918; x=1778827718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlYtjNBoIg67o0Kg+ur2eEMfxgNBWO5gDdNf6ayVmuQ=;
        b=Q7CwdJuMjFFZsAFib+VYX/ZdFqB38z+JpGQBfNC+WINit7v7zOHzekdw6DYUt7/9sj
         m42a1mTEfmcOvsYHJKKkK72dGu3EUgJgujsMz4VBEZdO8UZEBT3qAcqyj7hyXXMm2Q9/
         5DMgqkDfWVDEqByZOvbO0EtIZIPnOXNOfdwuAZMejUKv+0e44oJbZ4O13BAvBYv5fKs5
         +lOjZCQsdsE6dIpBwe2AC5Nyf3YAMJ/pJo9tZs5qNzabS8Cxs+jmjm5gMM/+A2e2v2KH
         zv8WuEOaorj2saJ8PC/bPCg7OkTyrYYwaQ5IsbxIBcLfsDftNKcQGTTe1Q490hdTPqqN
         kF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778222918; x=1778827718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlYtjNBoIg67o0Kg+ur2eEMfxgNBWO5gDdNf6ayVmuQ=;
        b=CZ1ruHmnRDAy/RTjaqDecxxyzTk3+hbvfpdc2s077xi0HZ3xmUKG2RQUdf087GjJ5a
         5mDveI7xt2hFboh9VVqEMCDHCth6vOH7K4FsDa497sTIIswHnu/eMISNjwxzgcoYchnV
         gFbKmOjqspD6THfHrNvZzbldE5VDgBMoG9vaL+HdrQ0OVSaDghNRggbhpv2jyxTjj1Kl
         TMf4RblYsITuzQGGYehR69wuwCePiAjmpOrB+CoX8iNDpQ1RLNFIlkzEQFydx2L+S8NJ
         id+IhQXxV5MgmLABOpZ9YP7z89kyPR6egxQBNA6laqZaimfgYxetALgoYsUbIpk4Vkh3
         zcaA==
X-Forwarded-Encrypted: i=1; AFNElJ/FCIZGfztJMq1YWFOGRsaZvzfBtgL4cwQzLvtckX3OaEmsQYCQZ1f9w2Oe1n2NzGIEJui2CHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1CkU7kQEr7geISwT16/JxpaO8NwY/1h57uVoEpj4esXwbCcj
	weh6fPh6QJBZTPzt+QqSF+54htmwUM+iaNv6Epn0D2U7N3iIbrevdyeuIX3Vk3Hta6oiOmI72xo
	Qhu/eYzQxE3Omc/EKmEKycxBxAOVzzA==
X-Gm-Gg: Acq92OHzfC/1OnL0iZYGwM8OCD9QXL9JMQ0FqLAP9yfRR/JlXjAtltDPcmacG/r1ato
	iJH9B1ytCLXflAIWmrKtKBxPTbztIZ2AiYryoRAb/WS6EjLt4NU8DcAEMts9DyFxjXDRNT91Mky
	d6goShrV+fcXUEKtW52kvBUkbcQrLWJK/PxLJIkavumYhdaqnE3NvGFmt1WgbknuOl0Gb3DoVxy
	cGtg9C16dqYjy0IfBL/9iyA+BPtXlOtyuwNYLJ4iZCz601x/X3VEqh+kNTZ0vrf92G+Qs9M5+ZB
	gOtz1//iTAE5xNIw1ur4rXZXj+fsycyo/4+XNUXc
X-Received: by 2002:a05:6122:1b8f:b0:56f:6d11:b962 with SMTP id
 71dfb90a1353d-575593b49e7mr6099620e0c.2.1778222918094; Thu, 07 May 2026
 23:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507055352.61017-1-adhikari.resume@gmail.com>
 <8bad8080780f3a1c2c45cc1385322edf09284414.camel@linux.intel.com> <afyhiigGVX3skCfF@gsse-cloud1.jf.intel.com>
In-Reply-To: <afyhiigGVX3skCfF@gsse-cloud1.jf.intel.com>
From: Ramesh Adhikari <adhikari.resume@gmail.com>
Date: Fri, 8 May 2026 12:18:26 +0530
X-Gm-Features: AVHnY4Jg5ClrapY2lCPUaUxnqA7l_ozgRBzQN6dwp_dL-l4wXRzx-bvdqR2AQfw
Message-ID: <CAC-THR-bZD8s0Pcs=ezyirUk7L-3O+YiLsj_TY0V0jyA46ok1Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/xe: Add bounds check for num_binds to prevent
 memory exhaustion
To: Matthew Brost <matthew.brost@intel.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	intel-xe@lists.freedesktop.org, rodrigo.vivi@intel.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E8AC14F29CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244675-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adhikariresume@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Matthew,



When I was tracing through the code, I found that vm_bind_ioctl_ops_create
allocates about 160 bytes per bind (drm_gpuva_ops + xe_vma_op) in the loop,
and those allocations use GFP_KERNEL without __GFP_ACCOUNT. That's separate
from the main arrays you already have protected with __GFP_ACCOUNT.

At 2048 binds that's only 320KB unaccounted, which is why I thought it was
safe to start conservative. But you're right - at 64k binds it would still
only be about 10MB unaccounted, which is probably fine and won't force
unnecessary fallbacks.

Should I send a v4 with 64k? Or do you think the loop allocations I found
need a different approach?

Thanks,
Ramesh

On Thu, May 7, 2026 at 7:58=E2=80=AFPM Matthew Brost <matthew.brost@intel.c=
om> wrote:
>
> On Thu, May 07, 2026 at 08:47:07AM +0200, Thomas Hellstr=C3=B6m wrote:
> > On Thu, 2026-05-07 at 11:23 +0530, Ramesh Adhikari wrote:
> > > The xe_vm_bind_ioctl function accepts user-controlled num_binds
> > > without
> > > bounds checking, allowing arbitrarily large memory allocations. This
> > > follows the same vulnerability pattern that was fixed for num_syncs
> > > in
> > > commit 8e461304009d ("drm/xe: Limit num_syncs to prevent huge
> > > allocations").
> > >
> > > Add DRM_XE_MAX_BINDS (2048) limit and validate num_binds before
> > > allocation.
> > >
> > > v2: Increased limit from 1024 to 2048 based on Mesa source analysis:
> > >     - Mesa's maximum usage: 960 binds (conformance test dEQP-VK)
> > >     - Confirmed by Intel Mesa developer in commit ba6bbdc
> >
> > Please use the standard way of referring to commits.
> >
> > This is the maximum usage in the conformance suite. That commit does
> > not mention maximum usage for applications in the wild, for which we
> > can't have any regressions.
> >
>
> I still think 1k, 2k to artifically too low. The Vk interface for array
> of binds doesn't have a limit nor do sync interface either. In case of
> sync I believe we found a typical max usage of of something like 10 but
> set artifical limit to 1k just be paranoid. I'd up the limit beyond 1k
> or 2k to prevent seemly valid use cases from forcing a split fallback in
> user space. Even if each individual bind maps to 4k internal (usually
> this just a handfull of bytes for the PTE writes) - 2k binds would 8M of
> temporary memory. Ofc we can increase this future but I really don't see
> the downside of starting with something larger now.
>
> Matt
>
> >
> > >     - 2048 provides 2.13x safety margin while limiting allocation to
> > > 64KB
> > >     - Prevents unbounded allocation (attacker could send 268M binds =
=3D
> > > 18.8GB)
> >
> > Referring to my previous email, it actually looks like most if not all
> > allocations in this path use __GFP_ACCOUNT | __GFP_RETRY_MAYFAIL |
> > __GFP_NOWARN, Did you actually verify that a malicious bind
> > significantly can exceed the cgroup limits?
> >
> >
> > >
> > > Cc: stable@vger.kernel.org
> > >
> > > Signed-off-by: Ramesh <adhikari.resume@gmail.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_vm.c | 5 +++++
> > >  include/uapi/drm/xe_drm.h  | 1 +
> > >  2 files changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > > index a717a2b8dea..1ff66874f43 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -3841,6 +3841,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev,
> > > void *data, struct drm_file *file)
> > >             return -EINVAL;
> > >
> > >     err =3D vm_bind_ioctl_check_args(xe, vm, args, &bind_ops);
> > > +
> > > +   if (XE_IOCTL_DBG(xe, args->num_binds > DRM_XE_MAX_BINDS)) {
> > > +           err =3D -EINVAL;
> >
> > If we end up concluding that this is indeed needed, we should return
> > -ENOBUFS here to trigger a graceful retry.
> >
> > Thanks,
> > Thomas
> >
> >
> > > +           goto put_vm;
> > > +   }
> > >     if (err)
> > >             goto put_vm;
> > >
> > > diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> > > index ae2fda23ce7..e666b73c81d 100644
> > > --- a/include/uapi/drm/xe_drm.h
> > > +++ b/include/uapi/drm/xe_drm.h
> > > @@ -1606,6 +1606,7 @@ struct drm_xe_exec {
> > >     __u32 exec_queue_id;
> > >
> > >  #define DRM_XE_MAX_SYNCS 1024
> > > +#define DRM_XE_MAX_BINDS 2048
> > >     /** @num_syncs: Amount of struct drm_xe_sync in array. */
> > >     __u32 num_syncs;
> > >

