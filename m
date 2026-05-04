Return-Path: <stable+bounces-243917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAc3DCkJ+Wlt4gIAu9opvQ
	(envelope-from <stable+bounces-243917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 23:01:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D224C3D7E
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 23:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5734301BC17
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 21:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E233DEE0;
	Mon,  4 May 2026 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG6dzEnw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B5C3246E8
	for <stable@vger.kernel.org>; Mon,  4 May 2026 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928484; cv=pass; b=FrX1Zphe7yQU0FDf9yPbbVV63qduJs2tQIpXmX1RK+RJPpZY70bl+WY4XQ8ZH0Gw3SYTvogLF9oDwLv0/ObUDitNlYosxihMIdSW2xKCqqKWtvhiaRkRzgw0Sy8wHM3K053W16rOMWe7untfIGrAgqFOjrKGk3XBZrGFPhC7/Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928484; c=relaxed/simple;
	bh=/3bqiJNOiZkkfxcU8atfmQsAsjGnwRbgWwcVIsZznbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUFa9M/PKy9kDtfPefC/QgU6kFWC62FqI92PtRTb0k1kJiyESBvti3PUSvbKu5cumuQnAV8IFqsp/ad+cYS5JJsUVj7loNedROfP2XhOaE1QwRwUtXb0SAVx3fZFkcuhRSb6vTs2qZCbGhU99khtqpe93KvrFNUcYMFJfXQHD4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG6dzEnw; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12dca45c95fso192439c88.3
        for <stable@vger.kernel.org>; Mon, 04 May 2026 14:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777928483; cv=none;
        d=google.com; s=arc-20240605;
        b=JHVCUvBviXCCD+SPuk+VRPj/ap0YRibfrVxf+k/s53l559JQoUnrL/0emfnuSv08GD
         X235mA56W7V3YNXzpm+LkjGPmzs+bp9pInpqNBq+YODbX+G+lgntWnbA/dD4IfLc354I
         sacW5injPKaAFAP7p/X+hzc1LrpgHqM9r7mgHlR9ooD4MN9KLSK7UqJrbAfWwdX2InBZ
         seD5YExzqojoPfyJiWRnPq1jcXpH/wuxk3xd/+qF2rgiYVmDWAXyTr02p1vr5lnnhCzF
         qd52yRaK07UpLQh9KkSQu1w1wsvDPUjZdztebNEjpEIgzjHFRJdA7arDrdVdnKl8fgiV
         A9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Thsb2YMTJJSc0LZ57FKsAw40wawxv4IlNMBLLhTxtBs=;
        fh=14SCPQBH1kAFZXQ2+FoltjkCRP4dFeULj4rnTCzD7uE=;
        b=LUYOhylpiNiJcbNldmAqCifkygHCOEFWBg3WdyOoyULE4FK2QTwCkNMU3HuTi6u/aW
         UQskovoor/uY+sWf3HkpI83HHN0W5ZnkWkgXohS6Chp9o/1vSTN8xCue/Pyrw0WOcVia
         NAjkIbAcS0VoGsioP0DHQgVUy8t0/hWPjTshg+swUbriYlA0vTpTPSnkzklXanSIgY4G
         EYLakJCiKbauJuMOe2y5LC901WB9CJ2uNe22uX64clyWtUG7zejvjP4lWFB/5FuKLzeC
         2uflGDYTbm6wpVbVcehLRSi7WK0oHs2FVUNbNziD7BIbNBnyKsV11GJUSH9FyMv8+UKC
         Yofw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777928483; x=1778533283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Thsb2YMTJJSc0LZ57FKsAw40wawxv4IlNMBLLhTxtBs=;
        b=LG6dzEnw1he9wztVrzbvBxhT9Jmn7thxF/4dWElIs9+ZxGk2V7CimvfZpghQaItzWF
         MvuSkxBy0gEB5ESFn2YI3/XfT++sX1Fop2kB/rfn+ZW/pqgpV3At1/Wj3cvFfTh/zwzH
         j2TavFizxue9IobqqhBEwunw/S/8blqiBFIptP1G28di49e6NQNQCfinv4BjNn4HleIb
         zKgMYgEjR/uuSBuywivEDuO8vaWp8SRrS5qPvoFy1wl2Tk4LrcA2jMWRKNeBBtnGKzUg
         jg248irRpdlDDcN5IV4WVvGidoqm22JBzFL0qRVuR+4D/1iMD19kiAuLdmaIoAjgCi1c
         PxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928483; x=1778533283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Thsb2YMTJJSc0LZ57FKsAw40wawxv4IlNMBLLhTxtBs=;
        b=sYoimGur08ypqg9t9RUZcblN2F0gOaUccKrPGet1qcnqrAubczbCPxQHZeoo1JrN6V
         7zYLzaK/ZFA9KsDUcMnlrT04lZqg0hwrLcGtts5UAUBUOI++aAwjff8UzQCEA0YCgrIc
         LKxms4Y2QHDzNVQh1h6/tfjWSh1YjsEcdUh3BPiCgLVVFMPcz2yYtTdZoAdUAuv3wicJ
         pfGxwFR/mDC136Zr1mXG7keTCSrxANJ20FXnv9zk3Cb1sPyZeatYXxwFCw1gbLrbYKLB
         /w1s2tTjiz/NwicSrUj4b94Nwd1Hcuz8OmG1BTElZ48sPjpafJnBpm5YtCjJWXuhZSv7
         IgRg==
X-Forwarded-Encrypted: i=1; AFNElJ/vt8MINtLs1f8qq1qep9EZMrqoaPVlN2Q51hHb5a01y29sdtez/oLcb0Ly77e/ubHRYjixrLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEf4q4TBmdhBSDru849Oi9zaQO8AKYJchfSArA4UhWSvZp2cG1
	hPhtJknblFw6hHxu/h028UfrgtcBSDbQ+CiUCqmlOV2J/h6NonU2P5FiSavWqH8rC9Lv0CQajbu
	PQTgYFJNf3fxKJsmTEi4/76uOzLcT40g=
X-Gm-Gg: AeBDiesu7IB5gHLBzw/52fc+WeArZpZixMk3KZu1EnWMDVtLa8m2RazuHJ5DdkNqNfH
	X8/grI+SiKfKYQP8cJv1q2RbouQOQz/e13rvDQ5MdhkBW3xwlnJVbZm0VBJutJCjcge6YX2vTTW
	GknPxl+1CT5psTAlsC+5hgJ1/gI87tVfCcP16v4DW+hhNmEynWZD+lrIQPPQu80uT1q+jKiAoR0
	o2uOkY24XN8FtPZiiqz0BhD6oIVrNJgmRpEqXSU8YIW7o97sis/I90IMFwnn3l3dLDpQBemMExu
	0IveCdktfK7KbvIw7zrYrtclnGYJ1vmQYhHGIPrdEwkYqQiYoss3USR61y9/7u3nVvIeocytQFm
	SITJI
X-Received: by 2002:a05:7022:e25:b0:12d:b4e2:f566 with SMTP id
 a92af1059eb24-12dfd83b7c7mr2122042c88.4.1777928482451; Mon, 04 May 2026
 14:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504201905.90667-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260504201905.90667-1-mikhail.v.gavrilov@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 May 2026 17:01:10 -0400
X-Gm-Features: AVHnY4K3R7rLIgAJ8Xi2UhaK6C4FSDUkZrXR39UcFFKVuMCB3HxIJ4w7zD9DYJk
Message-ID: <CADnq5_MiPNMMz3aE59bXdx11e_MBqS5SnkcC_YMUYvRtwiEokQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_RUN_WITH_PREEMPTION_ENABLED
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, siqueira@igalia.com, airlied@gmail.com, 
	simona@ffwll.ch, ardb@kernel.org, hamza.mahfooz@amd.com, 
	aurabindo.pillai@amd.com, Roman.Li@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 82D224C3D7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243917-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexdeucher@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,igalia.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url]

On Mon, May 4, 2026 at 4:29=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> dcn32_validate_bandwidth() wraps dcn32_internal_validate_bw() with
> DC_FP_START()/DC_FP_END(). On x86 non-RT, DC_FP_START expands into
> kernel_fpu_begin() which takes fpregs_lock(), i.e. local_bh_disable().
> Allocations done inside this region must therefore not sleep.
>
> The legacy DML1 path through dcn32_full_validate_bw_helper() ->
> dcn32_add_phantom_pipes() -> dcn32_enable_phantom_plane() unconditionally
> calls dc_state_create_phantom_plane() -> dc_create_plane_state(), which
> performs kvzalloc(sizeof(struct dc_plane_state)). On a recent kernel
> sizeof(struct dc_plane_state) is 343736 bytes (335 KiB), well above the
> PAGE_ALLOC_COSTLY_ORDER threshold, so __kvmalloc_node() takes the vmalloc
> path. __get_vm_area_node() then trips its BUG_ON(in_interrupt()) because
> SOFTIRQ_DISABLE_OFFSET is set in preempt_count:
>
>   kernel BUG at mm/vmalloc.c:3206!
>   RIP: __get_vm_area_node+0x257/0x2d0
>   Workqueue: events_unbound commit_work
>   Call Trace:
>    __vmalloc_node_range_noprof+0x22b/0x570
>    __kvmalloc_node_noprof+0x3d0/0xb40
>    dc_create_plane_state+0x35/0x290 [amdgpu]
>    dc_state_create_phantom_plane+0x1a/0x120 [amdgpu]
>    dcn32_enable_phantom_plane+0x101/0x780 [amdgpu]
>    dcn32_add_phantom_pipes+0x47/0x460 [amdgpu]
>    dcn32_full_validate_bw_helper.constprop.0+0xa46/0x1d70 [amdgpu]
>    dcn32_internal_validate_bw+0x49c/0x1600 [amdgpu]
>    dml1_validate+0x20f/0x800 [amdgpu]
>    dcn32_validate_bandwidth+0x317/0x540 [amdgpu]
>    dc_validate_with_context+0xd34/0x1d30 [amdgpu]
>    dc_commit_streams+0x7ca/0x1810 [amdgpu]
>    amdgpu_dm_commit_streams+0xfd4/0x1e60 [amdgpu]
>    amdgpu_dm_atomic_commit_tail+0x29e/0x3520 [amdgpu]
>    commit_tail+0x204/0x4b0
>    process_one_work+0x8fd/0x16a0
>
> Per-CPU __preempt_count on the crashing CPU at panic time was 0x202:
> SOFTIRQ_DISABLE_OFFSET (0x200) from fpregs_lock() plus two preempt holds
> from dc_fpu_begin() and kernel_fpu_begin().
>
> The DML2 paths already wrap their large vzalloc()s in
> DC_RUN_WITH_PREEMPTION_ENABLED() to handle this case (see
> drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c:26 and
> drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c:24). Apply the same
> guard to the DML1 phantom-plane allocation in dcn32_enable_phantom_plane(=
).
>
> This is a separate class of issue from "drm/amd/display: Fix unsafe uses
> of kernel mode FPU" by Ard Biesheuvel, which addressed callers entering
> DC FP compilation units without DC_FP_START. The bug fixed here is the
> inverse: a sleeping allocator invoked from within an active DC_FP_START
> region.
>
> Reproducer (RX 7900 XTX, single 4K HDMI display, DCN 3.2): launch any
> workload that produces rapid atomic modeset commits. The most reliable
> trigger observed is launching Rise of the Tomb Raider via Proton and
> repeatedly pressing the Super key during the level loading screen;
> crash occurs within ~4 minutes uptime. Random crashes are also observed
> during routine fullscreen toggles (image viewers, chat applications).
>
> Hardware verified clean: memtest86+ 4 passes, stressapptest -W -m 32
> 4 hours, both pass with 0 errors. KASAN active, no reports under load.
>
> Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files for D=
isplay Core")
> Cc: stable@vger.kernel.org # v6.0+
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4470

Alex

> ---
>  .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 82f81b586986..3751f7a94a05 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -92,9 +92,14 @@
>  #include "dml/dcn32/dcn32_fpu.h"
>
>  #include "dc_state_priv.h"
> +#include "dc_fpu.h"
>
>  #include "dml2_0/dml2_wrapper.h"
>
> +#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
> +#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
> +#endif
> +
>  #define DC_LOGGER_INIT(logger)
>
>  enum dcn32_clk_src_array_id {
> @@ -1684,7 +1689,8 @@ static void dcn32_enable_phantom_plane(struct dc *d=
c,
>                 if (curr_pipe->top_pipe && curr_pipe->top_pipe->plane_sta=
te =3D=3D curr_pipe->plane_state)
>                         phantom_plane =3D prev_phantom_plane;
>                 else
> -                       phantom_plane =3D dc_state_create_phantom_plane(d=
c, context, curr_pipe->plane_state);
> +                       DC_RUN_WITH_PREEMPTION_ENABLED(phantom_plane =3D
> +                               dc_state_create_phantom_plane(dc, context=
, curr_pipe->plane_state));
>
>                 if (!phantom_plane)
>                         continue;
> --
> 2.54.0
>

