Return-Path: <stable+bounces-197982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C1C98D3B
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 20:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6520E345078
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6247E1FAC42;
	Mon,  1 Dec 2025 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSDXGfXo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947410F1
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616685; cv=none; b=RkvTSfMdIE6sLcGQliNdq2D31xcQHWR89W4n86ROLJ1DoKHgU5UIqFgHW4L+YVlHuWeLE5j6OchnyCFW/GRJiSFj8MIDu6oXLbkfyjhpRqDfj28DMfEQpiQeCrIKbzYchryBq6be8lcAstWHpt9sPS/vIV1R3QKIGVENQfkcVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616685; c=relaxed/simple;
	bh=IzPH5Klro3wwiiOI21/koAESObsx6RFP/Km849tmY70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGMd9Dr0y7/n5JYd39Kydn87a4GeIsuy2bGQifbNqr9vNqRyNLlYpnhAOIyVg8SYhcW48WzWd96H+LXXtiO0/U6R8EmcTIAlMqPgX9Bp3FpQy+WHjfmvjR33Q3ienJlUXrNwnSPWthxIhwKNeTJQsXFiCYw4jR6xBu/Fxto8PZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSDXGfXo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bb2fa942daso542015b3a.1
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 11:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764616682; x=1765221482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG1pef5j3kb+4gT82++NmcY1RocDe5RimSakU+cBCck=;
        b=ZSDXGfXoKnnFC3LDHpElYCnh+bZHqi0T6lBGrhO4M1g8PKQGy+QPHNKfVQJ7qICIvK
         PX40e8lHayTCoXkAdMDuN4L/kRf5d4DxVTV2YN2IT8YUzleWZJ5l2UtB+uHqBM+7vBTk
         970D+KvtnU2y69CcvAKixajJwt2Xc40Sd3HEjz1Ah8Np3TEeSeuP09at1LQI1L76woSD
         W55FTH4lntV3UGmH413zIBBXDhoUxRMhoSz0XSRgiMFWAZR7dqbM0PDSio62akkFyOa/
         GO/W8Nw8WbJ9KUm6tXoqkEAiTJkul9SHlB0Qe7e0ts+JN6Ggu4vT1QJ1dL0dAAUoFnSG
         crEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764616682; x=1765221482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uG1pef5j3kb+4gT82++NmcY1RocDe5RimSakU+cBCck=;
        b=UQyUKLaHhetebW8sQNZyPzeuBmHb2YwaV37JV6vdmivYBkP7HzzVOFn8yxXtGauhCf
         ILAx3Q5qJxxBG13Ox76Fp5nIl1u3auoTWDUtX8orxMjZeenR7p+fHMK1KNOMR77KNzbr
         FRK3iqZgxD6AHPnmX+z7pv8HntFaUJTEI6bOCSAh+3R/bmW3a2mtMrMy6/MrtJAxhj0q
         MJ521UnhZtU55NI8fHhpzMWq/Zab0Ow/MjTIzpIisJuWTMvAxiLxyb5pakHuK0qb4Hi7
         GTSsCYEt0bKlWGD9aYVOehyM73CnRJYdyAyie8k1SpfqvdBwEsC7DJzC26erYoybd4tM
         iGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQoD687cx8MokZR9f448omwwoJcUOqUVy1l4kMy25GIBlphn6CeaNR1pOATsQTwxfbMCo9GmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoI7odMCHQ5tsoDVvk0crNWd/Y+tddpDwCIEyRqPdJWRWfnBZV
	Hu4XCiK5UcPZiFkKwiFr8xXNTQX0pUcR/WHxOUbIu90snASq7xDSOWupCANru0uMLb24LK+r311
	FSxXNWKQNVN3JfuLnchFDwbLGx56z108=
X-Gm-Gg: ASbGncsYWGneMx61mw/6dTeDxng25K3HzUlGudeEPOH0kZMye09uhJuzRwy9PnqQ2jw
	nDRET7a0EKhvWoD7U83e1kPH9YzZCjdXhqF1bjum/MKmNM4QnqU12+OSsw1G4knoAlwWWaRsrd6
	Fe+HuFcjoG/eqiofLvJ1WUNu42fwd7/tYWzSgr4eHsJsH6OR0eM6O9yyHmIn2XR4gX10aByYUL2
	b/3FnJcyF50wNi3o3109GyKJAUU9Z2aOE6BN5pd5p690lQlWYY6diUrEbES9VXqxLdKefY=
X-Google-Smtp-Source: AGHT+IHK9eiAGQUPs7XxDwdINu82yjOiyGXjBNyvKQ1nsCNnDHeJez+OpNJZ1kHkrXY8DwHjOMdc+y57KAFRjvrxKCQ=
X-Received: by 2002:a05:7022:f902:20b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-11c9f303bbdmr17346603c88.1.1764616682007; Mon, 01 Dec 2025
 11:18:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130014631.29755-1-superm1@kernel.org> <ad10d9ef-c769-49ba-ad12-3d2b5ab7f1e1@kernel.org>
In-Reply-To: <ad10d9ef-c769-49ba-ad12-3d2b5ab7f1e1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 14:17:50 -0500
X-Gm-Features: AWmQ_blzIYmdGqX6DnxfaOOAl2trtlOnCOWHglxWvMTQPOVTdx5ArwlXlupYGzM
Message-ID: <CADnq5_OJo_Z2feLLpeCjNE6KO9LZuDV7TBU4YUi+8ckw6g8NzQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd: Skip power ungate during suspend for VPE"
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 12:04=E2=80=AFAM Mario Limonciello (AMD) (kernel.org=
)
<superm1@kernel.org> wrote:
>
>
>
> On 11/29/2025 7:46 PM, Mario Limonciello (AMD) wrote:
> > Skipping power ungate exposed some scenarios that will fail
> > like below:
> >
> > ```
> > amdgpu: Register(0) [regVPEC_QUEUE_RESET_REQ] failed to reach value 0x0=
0000000 !=3D 0x00000001n
> > amdgpu 0000:c1:00.0: amdgpu: VPE queue reset failed
> > ...
> > amdgpu: [drm] *ERROR* wait_for_completion_timeout timeout!
> > ```
> >
> > The underlying s2idle issue that prompted this commit is going to
> > be fixed in BIOS.
> > This reverts commit 31ab31433c9bd2f255c48dc6cb9a99845c58b1e4.
> >
> > Fixes: 31ab31433c9bd ("drm/amd: Skip power ungate during suspend for VP=
E")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> This was reported by a few people tangentially to me reproducing it
> myself and coming up with the revert.
>
> Here's some more tags to include with the revert.
>
> Reported-by: Konstantin <answer2019@yandex.ru>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220812
> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 076bbc09f30ce..2819aceaab749 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3414,11 +3414,10 @@ int amdgpu_device_set_pg_state(struct amdgpu_de=
vice *adev,
> >                   (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK=
_TYPE_GFX ||
> >                    adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK=
_TYPE_SDMA))
> >                       continue;
> > -             /* skip CG for VCE/UVD/VPE, it's handled specially */
> > +             /* skip CG for VCE/UVD, it's handled specially */
> >               if (adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_UVD &&
> >                   adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_VCE &&
> >                   adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_VCN &&
> > -                 adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_VPE &&
> >                   adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_JPEG &&
> >                   adev->ip_blocks[i].version->funcs->set_powergating_st=
ate) {
> >                       /* enable powergating to save power */
>

