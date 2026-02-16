Return-Path: <stable+bounces-216715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD6yHxM2k2mV2gEAu9opvQ
	(envelope-from <stable+bounces-216715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:21:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BE9145716
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3D6F30062CB
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B580318B96;
	Mon, 16 Feb 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAHfG1Gw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01031BC94
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255030; cv=pass; b=RuxTFHukyFOwXxwZI4/EM4YROV+RA7J1SWcpX4OejiRGAHApWMWaSg9JTALmTlk1nJWz1u94zmVNMm1t1xeZ/DvwsjcXF783i8OTRCrmCan5dFHRa5U9kb7WzTIFe2Zg5OjSOyyyDfeIYKNH0Q+mTg4btLMFwXoo/qtohyX8k1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255030; c=relaxed/simple;
	bh=XfW1/fGTUJOoZviWyc/RCpgfeHSoIXmfHJAt8VuqUtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROUP37WuEOdK3vABUQtbF72YE+doS99KY7MmocHgqUQG2zQtYW64u4RbqOWrzI+37k9LEfX+qP2dtQi1Tixw6ukhcPU+IdhjtG5xFcPagRA3thxGHz97jBEtk5+gL/NBcXdWwbr02ZD3AkYueXqyAfWqu56W/T0aiqp3R8PV9pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAHfG1Gw; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba716126f5so165946eec.3
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 07:17:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771255028; cv=none;
        d=google.com; s=arc-20240605;
        b=low3anfGQ14eyHNqMNyOnnXvORkK3wfgIUUktfKm2S81ZwtnjoV1amxnbPzpK9P7aJ
         BV0JT4RCQCe4Y6nZjso2AWCaFNsJL60O1QtuCF5T7WGN4ua29Jtc2oQmg+v/sUNyZvyy
         zoI4EY0hNTLVx/Bn9/k9NhHuyzzEVPflf3euf9wbp4L/sDlCPl5LWvT1uwud9G8moXVJ
         fJT1aFBJfC6tlq89MQoS0mhrFdwrcFOnQZBbqYmnGwlC05ZNWRzBC4FeFnOi+P5xEmsV
         eJrAG2Nc3CePTVN4qDF0jo/PSDC4+3vo7s2zUSACgtJHln9sqBcd6ltTAYXdL+r0h7lS
         qgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YKPC9P2MdUr1p8+ptPTrIBFkfHYN1KOmv4Jan9hFXOc=;
        fh=IQDzjbo6DjUKIuKjqcreqVARO/JCT6uv1K7ecgEgAYU=;
        b=VZ/wVxiY2dtSh9ekPkSVVTeA2r0jxbT5GyCdpVtd5ieFRoVgXenG+Q1PBwc41m+L8R
         cbwK6sdVjlfpVmla4i1MpNteltYUit4E1jSwAyeD+fNTjcGmoccB0otLDgBv2sHS6FqZ
         QJa/Zpjc2KE4BpxHPnXo97J/kAqI4LUbCquoRxIvZ/ECrLfmS1FLZINrIPV8upK8RieT
         2THahe147dhTmRI4HI8IA8LB9qzWwTfSkES1GSeoYo8OsUhHTD1qIIApGS3s1yldrrBx
         f9egdF2Smoj5JQ72Dqc6cO8KpQXDdwdF8sqGF6jpqgIS+6btz30fHKzxwkLpWjEHC1Wq
         oMxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771255028; x=1771859828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YKPC9P2MdUr1p8+ptPTrIBFkfHYN1KOmv4Jan9hFXOc=;
        b=gAHfG1Gw1JZ5+71Ve4Dux2laR2qp716aeEdKXH+GbfPV//ElqImayqiYCeO6P4l93S
         Dty9ZI3++MTheP1n/eyI2FnPoIwMa+dJJ8KOrLNTOwzIE6LjNND00rX1cn9rECaRzbHG
         btPS0mZbT85bjpclSYRTOoOO+B0mO0jnsPTBWb2WD47XIAbAUIGHBtz47bj1rILZaPcj
         +CT1a14okr+ZE8nHc0iGDa3vRrJgkgOgYGpRpr5oVd+9N0mT7bx6ixlRBWFHiSO0OnlN
         R12nEum8pXtyZXc3Kr1uTq7a2+ZWsAzWWFfPZw59Ycqt+uM81cYrM57YxciY1zcsiQf4
         R+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255028; x=1771859828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKPC9P2MdUr1p8+ptPTrIBFkfHYN1KOmv4Jan9hFXOc=;
        b=QXOoym0aREGn9Pgf3JDROVV4LDxFRdTvrHR840bthALo3ndh4NWcEvbKY5gKlLpXXW
         h21BF3C+4p000g7kqYJWv0E2wLP31bnjZ8GLJfJTo/b/kowm3Pyn512/45pq81EY4Kxs
         26oiyNoCaKuokViZvCieyQOx0KM6BLZrZxUjdBX9E5OU1qrCy70DuY8DGqb5mKOL/PPU
         2s0g6nrzvJ95aQbWgIU1wFOlItk5YRWfdPC1tuY2zIc7nJEAp8puPbPgro/4/W58HgSr
         u/kHPlDwf1Y/oQxweJDgask8u3ezQ/Gs0pQ4gKusNvnBZPWK0N+LCqe/TJRXh48GrT8x
         CN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBBaSRH9EVkU1mfkLnhgFoaM5ukxjPDZ1TxR4F7LYa/apljVt9Ehz/A2cgA/S4KJUMKQ+wWd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcV3IWubtpipcSy0XIqQLR5s7QReROVPaKSf5GkM79YFm5s9ts
	vdwWHLtuVzWvs9el3a/Z1REiDV5sOLg8kqoeDQt4PwxzMLy67PRMARY1A8mmAkfTCUfkbS8rYbh
	C7aayoV4ThHLc4o4rttcQQcN6gxMUwEJnig==
X-Gm-Gg: AZuq6aKqQwDVET7Kc6JVOL7MASyJqLQNu3kjNzM6D1j2Q5zPAStZvEa0/C6THqIQpem
	itrHLdQwNNygMuCtTHNCBYCN8Hin02d+figwo60MPOL2V3W5LkvfaGpZacCBmZewnrk8fdqFLNw
	zvef/LOp5MmeB73OMv45g/IQ3N7MYBkQGtFPHABccOQuA4ezJGrg7um8+qKLi5hzHJ3DBye9yOm
	i4KngPsBmcixezfWcTF3LL+fE+SFC8gY3p+m7m5eiqvEP/WnILpmxE29ioBRYOVWR6JC117qJOC
	IV/na6i55vlykOrxi+Ujnp44fowdWrkSlPriKFAzCAO/F0zbgwU846jgfFhgkuerNCcD3i7Hiv2
	yqU4U
X-Received: by 2002:a05:693c:3747:b0:2ba:7321:cf91 with SMTP id
 5a478bee46e88-2baba0158e1mr2351361eec.3.1771255027376; Mon, 16 Feb 2026
 07:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216044735.6814-1-mario.kleiner.de@gmail.com>
In-Reply-To: <20260216044735.6814-1-mario.kleiner.de@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Feb 2026 10:16:55 -0500
X-Gm-Features: AaiRm51WrxeDGXyaEQrCB3OfmfTE87V2C5BJQUcl4yyEMYoSRmsnvc_EPo28dIM
Message-ID: <CADnq5_PfxV9r+LEAhvR_MRGOC_Xgp8vRWgMk8o9qKzur3bw2ag@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Prevent cursor bo's from being pinned to
 VRAM address zero
To: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/mixed; boundary="000000000000b73185064af27275"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216715-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexdeucher@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,gitlab.freedesktop.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E5BE9145716
X-Rspamd-Action: no action

--000000000000b73185064af27275
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 12:02=E2=80=AFAM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Why?
>
> On some AMD gpu's in some configurations, the start of the VRAM domain, a=
s
> reported by amdgpu_ttm_domain_start(adev, AMDGPU_GEM_DOMAIN_VRAM), is
> placed at address 0 during GMC init. This is a problem if, during a curso=
r
> plane update, the cursor image bo, which gets always pinned into VRAM,
> is placed at offset zero of the VRAM domain, and thereby at the
> absolute address afb->address 0.
>
> The display hw apparently doesn't like such a zero start address for at
> least native cursor mode, as various checks inside DC are in place, e.g.,
> high level dc_stream_check_cursor_attributes(), and lower level DCN
> version specific cursor hw programming checks, which do reject cursor
> attribute updates with attributes->address.quad_part =3D=3D 0.
>
> User visible symptoms of this are seriously broken mouse cursors under
> both X11 and Wayland (tested with KDE/KWin, GNOME/Mutter, GDM login
> manager): Mouse cursor flickers, is invisible, randomly becomes invisible=
,
> or fails to adapt the cursor shape to the context, e.g., when moving from
> a text input field to other windows, or window decorations etc. This make=
s
> the cursor irritating and impossible to use.
>
> The drm.debug=3D4 log shows DRM KMS debug messages of the form
> "DC: Cursor address is 0!", and the general syslog prints errors like
> "[drm:amdgpu_dm_plane_handle_cursor_update [amdgpu]] *ERROR* DC failed to
> set cursor attributes"
>
> I observe this bug on my dual-gpu Apple 2017 MacBookPro since Linux 4.11,
> where the kernels early EFI setup force-enables both the Intel iGPU and
> AMD dGPU. This leads to the AMD VRAM start being placed at 0x0 and then
> causes massive cursor problems. On earlier kernels, only the AMD dGPU was
> exposed, the Intel iGPU was disabled / hidden from Linux by EFI firmware.
> This caused the AMD gpu to place VRAM start at the non-zero
> address 0x000000F400000000, and the mouse cursor worked fine. I confirmed
> with umr that the mmMC_VM_FB_LOCATION register of my Polaris 11 gpu indee=
d
> read back 0x0000 in the lower 16 bits in the dual-gpu case, causing
> gmc_v8_0_vram_gtt_location() to setup start of VRAM domain at zero.
> I don't know what causes the change, but most likely the UEFI firmware
> somehow triggers this change before main kernel boot - calling into the
> VBIOS, I guess.
>
> There is at least one 8 months old bug report in AMD's issue tracker,
> reporting the same symptoms on other AMD setups, cfe.:
> https://gitlab.freedesktop.org/drm/amd/-/issues/4302
>
> So unless there is another more clean and reliable way to prevent the
> cursor bo from being placed at address zero, or unless the display hw
> is actually fine with address zero and those checks in DC are overly
> cautious, this needs to be fixed.
>
> Note that simply removing the "zero address -> reject cursor update"
> checks worked on my Polaris11 with DCE 11.2 display engine, fixing the
> cursor without causing any other obvious trouble. So maybe this is only
> a limitation of recent DCN engine versions, or a pointless check.
>
> How?
>
> Add a new AMD bo placement flag which requests bo pinning / placement at
> non-zero VRAM address only during amdgpu_bo_pin(). Use this flag for bo's
> on the cursor plane during amdgpu_dm_plane_helper_prepare_fb().
>
> I don't know if this is the best approach. It feels hacky, but it is the
> only approach I was able to do and it seems to work fine enough.
>
> If this is a good enough fix, it should be backported, but backporting
> to earlier than Linux 6.12 might be cumbersome due to changes to the
> amdgpu_bo_pin() implementation.

Thanks for tracking this down.  I think this patch would be cleaner
and easier to apply to older kernels.

Alex

>
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c            | 11 +++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  6 ++++--
>  include/uapi/drm/amdgpu_drm.h                         |  7 +++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 1fb956400696..97131fc8fbdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -975,6 +975,17 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
>                 if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>                     bo->placements[i].mem_type =3D=3D TTM_PL_VRAM)
>                         bo->placements[i].flags |=3D TTM_PL_FLAG_CONTIGUO=
US;
> +
> +               /* Ensure bo is never pinned at amdgpu_bo_gpu_offset() =
=3D=3D 0
> +                * for VRAM allocations, as some of the DC code does not
> +                * like that, e.g., mouse cursor display image bo's.
> +                */
> +               if (bo->flags & AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS &=
&
> +                   bo->placements[i].mem_type =3D=3D TTM_PL_VRAM &&
> +                   !bo->placements[i].fpfn &&
> +                   !amdgpu_ttm_domain_start(adev, TTM_PL_VRAM)) {
> +                       bo->placements[i].fpfn =3D 1;
> +               }
>         }
>
>         r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 394880ec1078..cd7f53d3036c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -959,10 +959,12 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct=
 drm_plane *plane,
>                 goto error_unlock;
>         }
>
> -       if (plane->type !=3D DRM_PLANE_TYPE_CURSOR)
> +       if (plane->type !=3D DRM_PLANE_TYPE_CURSOR) {
>                 domain =3D amdgpu_display_supported_domains(adev, rbo->fl=
ags);
> -       else
> +       } else {
>                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> +               rbo->flags |=3D AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS;
> +       }
>
>         rbo->flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>         r =3D amdgpu_bo_pin(rbo, domain);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 1d34daa0ebcd..6dee7653c54e 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -181,6 +181,13 @@ extern "C" {
>  #define AMDGPU_GEM_CREATE_EXT_COHERENT         (1 << 15)
>  /* Set PTE.D and recompress during GTT->VRAM moves according to TILING f=
lags. */
>  #define AMDGPU_GEM_CREATE_GFX12_DCC            (1 << 16)
> +/* Flag that BO must not be placed in VRAM domain at offset zero if the
> + * VRAM domain itself starts at address zero.
> + *
> + * Used internally to prevent placement of cursor image BO at that locat=
ion,
> + * as the display hardware doesn't like that for hardware cursors.
> + */
> +#define AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS (1 << 17)
>
>  struct drm_amdgpu_gem_create_in  {
>         /** the requested memory size */
> --
> 2.43.0
>

--000000000000b73185064af27275
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-keep-vga-memory-on-MacBooks-with-switchab.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-keep-vga-memory-on-MacBooks-with-switchab.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mlpbhyi90>
X-Attachment-Id: f_mlpbhyi90

RnJvbSBlMDU1YjRmNjg3OWMzNjIyMTdhMjRjMmQ2YWJhOTI1YWVmM2MxNzg0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMTYgRmViIDIwMjYgMTA6MDI6MzIgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBrZWVwIHZnYSBtZW1vcnkgb24gTWFjQm9va3Mgd2l0aCBzd2l0Y2hhYmxl
CiBncmFwaGljcwoKT24gSW50ZWwgTWFjQm9va1Byb3Mgd2l0aCBzd2l0Y2hhYmxlIGdyYXBoaWNz
LCB3aGVuIHRoZSBpR1BVCmlzIGVuYWJsZWQsIHRoZSBhZGRyZXNzIG9mIFZSQU0gZ2V0cyBwdXQg
YXQgMCBpbiB0aGUgR1BVJ3MKdmlydHVhbCBhZGRyZXNzIHNwYWNlLiAgVGhpcyBpcyBub24tc3Rh
bmRhcmQgYW5kIHNlZW1zIHRvIGNhdXNlCmlzc3VlcyB3aXRoIHRoZSBjdXJzb3IgaWYgaXQgc2Vu
ZHMgdXAgYXQgMC4gIFdlIGFscmVhZHkgcmVzZXJ2ZQpoYXZlIHRoZSBmcmFtZXdvcmsgdG8gcmVz
ZXJ2ZSBtZW1vcnkgYXQgMCBpbiB0aGUgYWRkcmVzcyBzcGFjZSwKc28gZW5hYmxlIGl0IGhlcmUg
aWYgdGhlIHZyYW0gc3RhcnQgYWRkcmVzcyBpcyAwLgoKQ2xvc2VzOiBodHRwczovL2dpdGxhYi5m
cmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy80MzAyCkNjOiA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4gIyB2Ni4xMisKQ2M6IE1hcmlvIEtsZWluZXIgPG1hcmlvLmtsZWluZXIuZGVAZ21h
aWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgMTAg
KysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKaW5kZXggNTZlNDYyMzhlNjcyMy4uNDRmZjgwMGE1
NzE1NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwpAQCAtMTA2Nyw2
ICsxMDY3LDE2IEBAIHZvaWQgYW1kZ3B1X2dtY19nZXRfdmJpb3NfYWxsb2NhdGlvbnMoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJY2FzZSBDSElQX1JFTk9JUjoKIAkJYWRldi0+bW1hbi5r
ZWVwX3N0b2xlbl92Z2FfbWVtb3J5ID0gdHJ1ZTsKIAkJYnJlYWs7CisJY2FzZSBDSElQX1BPTEFS
SVMxMDoKKwljYXNlIENISVBfUE9MQVJJUzExOgorCWNhc2UgQ0hJUF9QT0xBUklTMTI6CisJCS8q
IE1hY0Jvb2tQcm9zIHdpdGggc3dpdGNoYWJsZSBncmFwaGljcyBwdXQgVlJBTSBhdCAwIHdoZW4K
KwkJICogdGhlIGlHUFUgaXMgZW5hYmxlZCB3aGljaCByZXN1bHRzIGluIGN1cnNvciBpc3N1ZXMg
aWYKKwkJICogdGhlIGN1cnNvciBlbmRzIHVwIGF0IDAuICBSZXNlcnZlIHZyYW0gYXQgMCBpbiB0
aGF0IGNhc2UuCisJCSAqLworCQlpZiAoYWRldi0+Z21jLnZyYW1fc3RhcnQgPT0gMCkKKwkJCWFk
ZXYtPm1tYW4ua2VlcF9zdG9sZW5fdmdhX21lbW9yeSA9IHRydWU7CisJCWJyZWFrOwogCWRlZmF1
bHQ6CiAJCWFkZXYtPm1tYW4ua2VlcF9zdG9sZW5fdmdhX21lbW9yeSA9IGZhbHNlOwogCQlicmVh
azsKLS0gCjIuNTMuMAoK
--000000000000b73185064af27275--

