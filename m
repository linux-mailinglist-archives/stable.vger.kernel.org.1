Return-Path: <stable+bounces-126983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B0A75285
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 23:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 509717A7215
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 22:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB11E102E;
	Fri, 28 Mar 2025 22:41:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp72.iad3a.emailsrvr.com (smtp72.iad3a.emailsrvr.com [173.203.187.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F91865E5
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743201708; cv=none; b=OGbGCCjE8RY0mtim6SvSNVJmIKhl+Qn9Imrz77F/vz0naTHIriCDQT5VBjgM1KpIdjjD484LCbqquXSGDBPUzAj5pbBPY9YtyWEkiQHoi1otuy30+CuK8IkI5Ebykq0ylaiIpZNeGGdKOoRgYTO83NNgO5wiK6JUjE9IWHRg5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743201708; c=relaxed/simple;
	bh=UxcOQ9/1QZkYpGX5Dm0DXrcBCks4xAvdoYZQQnRTQOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvEZ6NVB6aCvgpqtlbpXpl+ilHjsmt148MLr8oMhqnPrqQ5/1KrzytC/2XK41CK87n9NpdxX4Kz4FffDDSup9h0ViiTISWhR4qvcyodq/r1Ek50dFd9rKvV1We06PqD0h38v3m1YiA+2TurjvrnBK+BbvSa3LjeDZRFpDSFiQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whitecape.org; spf=pass smtp.mailfrom=whitecape.org; arc=none smtp.client-ip=173.203.187.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whitecape.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whitecape.org
X-Auth-ID: kenneth@whitecape.org
Received: by smtp26.relay.iad3a.emailsrvr.com (Authenticated sender: kenneth-AT-whitecape.org) with ESMTPSA id 8D4A358EF;
	Fri, 28 Mar 2025 18:31:47 -0400 (EDT)
From: Kenneth Graunke <kenneth@whitecape.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, zhanjun.dong@intel.com,
 stable@vger.kernel.org
Subject:
 Re: [PATCH] drm/xe: Invalidate L3 read-only cachelines for geometry streams
 too
Date: Fri, 28 Mar 2025 15:34:58 -0700
Message-ID: <4999188.31r3eYUQgx@imeretto>
In-Reply-To: <Z-b2BYJkz5laBbew@intel.com>
References:
 <20250320101212.7624-1-kenneth@whitecape.org> <Z-b2BYJkz5laBbew@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Classification-ID: 01dadefe-d6b6-45d2-9b47-56690f42a8cc-1-1

On Friday, March 28, 2025 12:18:29=E2=80=AFPM Pacific Daylight Time Rodrigo=
 Vivi wrote:
> On Thu, Mar 20, 2025 at 03:11:55AM -0700, Kenneth Graunke wrote:
> > Historically, the Vertex Fetcher unit has not been an L3 client.  That
> > meant that, when a buffer containing vertex data was written to, it was
> > necessary to issue a PIPE_CONTROL::VF Cache Invalidate to invalidate any
> > VF L2 cachelines associated with that buffer, so the new value would be
> > properly read from memory.
> >=20
> > Since Tigerlake and later, VERTEX_BUFFER_STATE and 3DSTATE_INDEX_BUFFER
> > have included an "L3 Bypass Enable" bit which userspace drivers can set
> > to request that the vertex fetcher unit snoop L3.  However, unlike most
> > true L3 clients, the "VF Cache Invalidate" bit continues to only
> > invalidate the VF L2 cache - and not any associated L3 lines.
> >=20
> > To handle that, PIPE_CONTROL has a new "L3 Read Only Cache Invalidation
> > Bit", which according to the docs, "controls the invalidation of the
> > Geometry streams cached in L3 cache at the top of the pipe."  In other
> > words, the vertex and index buffer data that gets cached in L3 when
> > "L3 Bypass Disable" is set.
> >=20
> > Mesa always sets L3 Bypass Disable so that the VF unit snoops L3, and
> > whenever it issues a VF Cache Invalidate, it also issues a L3 Read Only
> > Cache Invalidate so that both L2 and L3 vertex data is invalidated.
> >=20
> > xe is issuing VF cache invalidates too (which handles cases like CPU
> > writes to a buffer between GPU batches).  Because userspace may enable
> > L3 snooping, it needs to issue an L3 Read Only Cache Invalidate as well.
> >=20
> > Fixes significant flickering in Firefox on Meteorlake, which was writing
> > to vertex buffers via the CPU between batches; the missing L3 Read Only
> > invalidates were causing the vertex fetcher to read stale data from L3.
> >=20
> > References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4460
> > Cc: stable@vger.kernel.org # v6.13+
> > ---
> >=20
> >  drivers/gpu/drm/xe/instructions/xe_gpu_commands.h |  1 +
> >  drivers/gpu/drm/xe/xe_ring_ops.c                  | 13 +++++++++----
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
> > b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h index
> > a255946b6f77e..8cfcd3360896c 100644
> > --- a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
> > +++ b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
> > @@ -41,6 +41,7 @@
> >=20
> >  #define
> >  GFX_OP_PIPE_CONTROL(len)	((0x3<<29)|(0x3<<27)|(0x2<<24)|((len)-2))
> >=20
> > +#define	  PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE	BIT(10)=09
/* gen12 */
>=20
> this definitely matches the spec on the bitgroup0, but Mesa
> code got me a bit confused:
> PIPE_CONTROL_L3_READ_ONLY_CACHE_INVALIDATE   =3D (1 << 28),

Yeah...the values in iris_context.h is just a bitfield enum of every possib=
le=20
flag, in no particular order.  The comment above tries to clarify that they=
=20
don't match the hardware packing.  Sorry for the confusion!  src/intel/genx=
ml/
gen125.xml defines PIPE_CONTROL's actual bit layout where things get packed=
=2E =20
You can see that it's bit 10 there.

> >  #define	  PIPE_CONTROL0_HDC_PIPELINE_FLUSH		BIT(9)=09
/* gen12 */
> > =20
> >  #define   PIPE_CONTROL_COMMAND_CACHE_INVALIDATE		(1<<29)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c
> > b/drivers/gpu/drm/xe/xe_ring_ops.c index 0c230ee53bba5..9d8901a33205a
> > 100644
> > --- a/drivers/gpu/drm/xe/xe_ring_ops.c
> > +++ b/drivers/gpu/drm/xe/xe_ring_ops.c
> > @@ -141,7 +141,8 @@ emit_pipe_control(u32 *dw, int i, u32 bit_group_0, =
u32
> > bit_group_1, u32 offset,>=20
> >  static int emit_pipe_invalidate(u32 mask_flags, bool invalidate_tlb, u=
32
> >  *dw,> =20
> >  				int i)
> > =20
> >  {
> >=20
> > -	u32 flags =3D PIPE_CONTROL_CS_STALL |
> > +	u32 flags0 =3D 0;
> > +	u32 flags1 =3D PIPE_CONTROL_CS_STALL |
> >=20
> >  		PIPE_CONTROL_COMMAND_CACHE_INVALIDATE |
> >  		PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE |
> >  		PIPE_CONTROL_TEXTURE_CACHE_INVALIDATE |
> >=20
> > @@ -152,11 +153,15 @@ static int emit_pipe_invalidate(u32 mask_flags, b=
ool
> > invalidate_tlb, u32 *dw,>=20
> >  		PIPE_CONTROL_STORE_DATA_INDEX;
> >  =09
> >  	if (invalidate_tlb)
> >=20
> > -		flags |=3D PIPE_CONTROL_TLB_INVALIDATE;
> > +		flags1 |=3D PIPE_CONTROL_TLB_INVALIDATE;
> >=20
> > -	flags &=3D ~mask_flags;
> > +	flags1 &=3D ~mask_flags;
> >=20
> > -	return emit_pipe_control(dw, i, 0, flags,
> > LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0); +	if (flags1 &
> > PIPE_CONTROL_VF_CACHE_INVALIDATE)
> > +		flags0 |=3D PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE;
> > +
> > +	return emit_pipe_control(dw, i, flags0, flags1,
> > +				=20
LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
>=20
> Well, it respects the spec and if it is solving the issue let's go with i=
t.
>=20
> But last question, should we expect some performance change with this
> extra invalidation in the Geometry streams caches?

Not that I'm aware of.  I don't think we saw much of a performance drop whe=
n=20
enabling L3 bypass and the extra flushing.  But having VF be an L3 client a=
long=20
with most everything else let us have compute shaders do fewer expensive Da=
ta=20
Cache Flushes and instead only do cheaper HDC flushes, which did lead to=20
performance gains.  So if there was a drop, I think it was more than offset.

I haven't specifically tried to benchmark this patch.

> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>=20
> (I tried to trigger the CI manually, please confirm it is okay to
> add your signed-off-by so we can get this merged soon)

Thank you!  I'll resend with my Signed-off-by for clarity (I definitely mea=
nt to=20
include it)

> Thanks a lot for finding and fixing this.

No problem!



