Return-Path: <stable+bounces-222978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJcXNwewp2nAjAAAu9opvQ
	(envelope-from <stable+bounces-222978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 05:07:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3351FA9EB
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 05:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4BA431AA128
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 04:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B59016DC28;
	Wed,  4 Mar 2026 04:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa0+vlXu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0337E31D
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772597038; cv=pass; b=JAX4ef4musTx2Qr8kty95jPJKDZAPSbjYHOhMUWBOFsXkTn+13/9bihZhMfwOT6OM28qDVb7oHUfW6Iz9s2c+kNbO1kI0JkZ30PhpY0HcN3OsTI4jgNyW16h4wlN+CjnSaltY+GjZBokc+Bzl7vpDlo7K9V+PcjBDG7QAMaZ6AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772597038; c=relaxed/simple;
	bh=hWtbzLyDTV1gVm16ymURAv/KoMNAFF+BLlK2tBsJi30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG/dAxMPYaTGQLrI1LGmM61BTnTHF1JdjnLV03AcKYda3B2xUHXtDv7P5WIJp4B2ijUUf5GEy1h3likYy+6JGagc8YHturYHFsk0Mx/0IjGCb024wMmp80JLTnsEGTpfXbntVk8H7Ipr/dnXJftuRfpN8lWlxLdvJgMqJy+0nIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa0+vlXu; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9359c0ec47so690759766b.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 20:03:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772597033; cv=none;
        d=google.com; s=arc-20240605;
        b=XHs/UmP0yxz6V/utUIJmKnENfL2PG5VDdpzclDHUity/jPzsY9ZwcFroZ+whZUk0Dc
         gdiW1GeB0LejpParbBqLu2saYuMop/ALYXPOL3pa86URitJEd8VhTfCT4ithtHH0RFj6
         0h75dAQqaK9M7jsEoKiF+otVsu0nL3Ff+NHOZynliO3cHETUgaED+H3Qbw2zCaUBEbkg
         /0NkPEtRsmcI5iEFrNqmjmESsyROheoE6flZw9oUROkprHtP2ubnzF/JAmCOQtdPnVrl
         Wrty8F/VzS6P9RSLpdGDGkIbZptSaCBDLQtVu05qZsqqn6ki2fnAkn+8tz/2yHJ59wGO
         VVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6z8M845Y+NpITZKZSzsYEQuXgpy16cvxcX5WIhmq9VA=;
        fh=MkCzdbqJ2l5OajGEN3WylAYhbUkY8yVvs4Rozdl5TVk=;
        b=KVeOBtZdstp5DyiyR8sZb7qDHYs4+IrxgDSPbE8BhYdN4wDcPWu26tILKbm4dh6B/s
         m1+4ikpWup+fVaUkXocy5JZpMdU6rRH0s53h2nqhS6eD1HqLC2DsBz+4MXV8AGPpDSO5
         XAgJEjKXbiNgg5lon9ACxvNuc60zuePDgU+U5CMTfA03yViuJKs1M5KAyzUc6qp9XHyK
         +3fdGResJvi/RAA0pfXN8hNFE8y36WBMnhCIcA0szQg/AShOZscQLgbVh21JkqtefuQq
         ehSws9tS6Hz/6zH6xqYXYT1bXNJtMa4q9UfzhZrPZi7fCpw/+0Wh/kZTF0vGOS4j9d8t
         XyvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772597033; x=1773201833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z8M845Y+NpITZKZSzsYEQuXgpy16cvxcX5WIhmq9VA=;
        b=Oa0+vlXu+IUat2DY+Lhae+xr//cIEaTYpcVKp4Y5fbr2GncFhu+X7QfH8TTO2gYneM
         R6OI7sjiuq4aTQ99wQ/iMafpf5fBBi9Kd0vSiygODgFbhmdROYMNFni4vwOPhIGXXlyM
         DJMD6i/JF8WXkwDUgDbEzCcQRfg1OqdkNt0BMnDdELL3bnCxfWluJhHTWlZkQL2uadHI
         jMTgCGuqKklRQzQ8PZCoY+qD090fBdb2xmwek6n6gsQ3HGLUhRRKnpq5l3AEdl0FQwpe
         10JW6t/NPAkOBorne2wJKONKGaB2m7lCmTjtzO73S+Nu7odlIMiSzOC9eSWhz8Qu3Pk0
         awhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772597033; x=1773201833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6z8M845Y+NpITZKZSzsYEQuXgpy16cvxcX5WIhmq9VA=;
        b=rlJVXODUm7tKYh50PvGPQDhy8ZJTdxMgKaIu+8XGOTPHMXXEyqq42OO/zLMPn/HPIY
         DIeYf0lJHRwN9hM2DoUZok2gIinkoau8VAsf87MtbBX7Bu0uHEsfPhRjXyooYnVZYkV9
         iLQ0vKZhy+LsT/zMIGBSCJ8rNAstviXYU17hoK27Fy+dB4E9y+48R9R3Y5H1P4KJaKQQ
         9Vx5RdyAB3Lvg0eZx35B0eHpItSBvuQyLjvaeRTQxCPDjd9+amVKT798t6g3q3rQgkhq
         ZXaU4z4ddq4FCGHd7wtcEv9ofHpyDmrIYuniVNhHjPAR1ZvV6ho0qcdnEjCwp07ZPKp4
         l74Q==
X-Gm-Message-State: AOJu0YxuUPpvgx9vD1enCL5U9g3AOU8dcTG//W88BQyWgQuCfDdZ+xmF
	PSNSusdBD825uZIvGJX0K5QmWL+Y22CTXIRUbjU4zDFKU/1SHrFJC+65ImHGGXUXqf0Q0pfO/3C
	kI4+8Z57RwOsBVSzntwPNAI3SAAJ97C7IOQ==
X-Gm-Gg: ATEYQzysBgiHk9n2D9NjLhOfftsRvK8welic64jZu+3XKsA4KS//Ys+AuVqCMXq2a68
	pVBjvAej5a3fYWpx5kPCwS/9YItn/ou+g/SoEPPe6ifRj84zDuNAi3PLRHiunANIupg1NaP8y13
	EHVFEeUOYNTlOHCfNQt7Gbzy06O4bvL4+litr0HnXv11oWjdI3lo79v8hoHZByiMeJF/PehKu8M
	aGdqsh7CAtdR1FqQrtedsZlE4pJlO+beZy8G8pW6ceNjlYOmhBDkHM7uFdlzQ8oADuOZruv2Fh9
	aq6mt7eCZ0Shu3mU4mxkDTPswubR+gjsLy6prTWLdVActRpx2DEy+6dXWeQiirfkacF/G9ZTkt5
	VtLPtcw==
X-Received: by 2002:a17:907:96a6:b0:b93:8460:4af with SMTP id
 a640c23a62f3a-b93f14cf1afmr27445366b.56.1772597032896; Tue, 03 Mar 2026
 20:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228045356.3561-1-rosenp@gmail.com>
In-Reply-To: <20260228045356.3561-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 3 Mar 2026 20:03:40 -0800
X-Gm-Features: AaiRm50svINP7hvFX0utAndkOyARkkDlnOGgjjSGoekSn-A5-l-P6oFmN6TdzZE
Message-ID: <CAKxU2N_FbB_d6ntXEOFzE2u-sfu9sRRFwaDnb3P=RfTwE5yuDA@mail.gmail.com>
Subject: Re: [PATCHv2 for 6.112 and 6.6 0/2] amdgpu: fix panic on old GPUs
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kenneth Feng <kenneth.feng@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
	Alex Hung <alex.hung@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lijo Lazar <lijo.lazar@amd.com>, "chr[]" <chris@rudorff.com>, Sasha Levin <sashal@kernel.org>, 
	Wentao Liang <vulab@iscas.ac.cn>, 
	"open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5F3351FA9EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222978-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,linuxfoundation.org,rudorff.com,kernel.org,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 8:54=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Because of incomplete backports to stable kernels, DC ended up breaking
> on older GCN 1 GPUs. This patchset adds the missing upstream commits to
> at least fix the panic/black screen on boot.
>
> They are applicable to 6.12, 6.6, and 6.1 as those are the currently
> supported kernels that 7009e3af0474aca5f64262b3c72fb6e23b232f9b got
> backported to.
>
> 6.1 needs two extra backports for these two commits to be cherry-picked
> cleanly. Those are
>
> 96ce96f8773da4814622fd97e5226915a2c30706
> d09ef243035b75a6d403ebfeb7e87fa20d7e25c6
>
> v2: Add Signed-off-by.
Do I need to resend?
>
> Timur Krist=C3=B3f (2):
>   drm/amd/display: Add pixel_clock to amd_pp_display_configuration
>   drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)
>
>  .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  1 +
>  .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  2 +-
>  .../drm/amd/display/dc/dm_services_types.h    |  2 +-
>  drivers/gpu/drm/amd/include/dm_pp_interface.h |  1 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
>  .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  6 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 ++++++------------
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 11 +--
>  10 files changed, 101 insertions(+), 60 deletions(-)
>
> --
> 2.53.0
>

