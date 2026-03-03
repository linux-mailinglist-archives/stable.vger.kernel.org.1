Return-Path: <stable+bounces-222777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEcVLEdLpmm1NgAAu9opvQ
	(envelope-from <stable+bounces-222777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 03:45:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FEA1E826E
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 03:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9253306C53B
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 02:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E21E2614;
	Tue,  3 Mar 2026 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb2+I+WU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcIWlNA1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD018E025
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505925; cv=pass; b=iaq08UFY711/v/vExKs2HL3fGu3w/HEHQldDdDaNWDJ0KwMC48n8rQKH2rTpGvrD+NXY7QGh+v3hWE9DHF1xg104qCu5iqqBpvfkvf8WHoa3nN2XWUp8VXsUjpDXtqNqqZwR7jviwKJxrc/V+pCUCdrHN9ZU8PJzHLtIIDGO3VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505925; c=relaxed/simple;
	bh=LcVGh2aDVHYVq3yJXUmxS295+8D/ey7+3K+jakR1Dcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OV5kSukfWsT7i50d68pVqzJMOVPPbYKKI7M9YR+EnTRjE+T7wcLmO/BZ33RLr1ouxnYqZA2GYAHo/Amxl8LJaS+7H3lSlm/qEUUadJpcgJkpq3Rtc87bCYF97NvwUBZWr4LoF2/iSLZlNOg3Dy/Ars3bY+joN401NvrsB/RZx1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb2+I+WU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcIWlNA1; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772505922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyIiPvo1Hi6sPVeMJBvore0WWbDttn+oJaE6w0roYKA=;
	b=eb2+I+WUqZG68L+IjL6diu0J4NYpG48IGuf1m0mfMC9j/WauAI1vJIgxNwAi+2JTqQscMG
	EiESDp3f1SpCNkOL0KT1seUv4XOfVoLL+gD7IyDppRCe6fTLTLfUHBXsF+8UbffDtfswqT
	u6dsXSXsdk2iMgBfxJghfpNA4KC0Ynk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Hgnzy-l_M36thN9Zta6a1w-1; Mon, 02 Mar 2026 21:45:21 -0500
X-MC-Unique: Hgnzy-l_M36thN9Zta6a1w-1
X-Mimecast-MFC-AGG-ID: Hgnzy-l_M36thN9Zta6a1w_1772505921
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5033c483b76so476815491cf.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 18:45:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772505921; cv=none;
        d=google.com; s=arc-20240605;
        b=ioAzLxXrqaqUjbkHoSA3k4i4P4DrELiWM10dxphtoE4qhydlUV0swMJt4cD1zNu88T
         J/1//3q56xsiix8gvr9Qan5Pt2R0V29BfUcPxzEaHmL30HPckxuGwVMzUOqnMsHpry/G
         1xOFNipeatdQwaVe0YuVulAIQpEzXfTaBAPMziVrW//IMbnFa9LNlMcllxeI7kOwUKwZ
         T9L7vB1qLzq5r5z0KR0KTzgoqlC1xfpVfnZG9/TOuh7cCGoxpLfftBLt1Y6OptHePYYf
         S7+2elw+O0HVZLQQ+yME2vmhva72edzJP7OIdLV851g39NiWBGmU6yRRxXzk8j0dESjs
         Z1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nyIiPvo1Hi6sPVeMJBvore0WWbDttn+oJaE6w0roYKA=;
        fh=X2go3uDYZuLVPnWPwrV+cJ25Ak5CPIxg7c2Os4Yjwu8=;
        b=kLbkfA0ZIhwAnubKfqAFq0GC7SUeUmJ5+cNoFkB7+yhpgk4OOMvoyiYr8HOiK0ZdRG
         1uYDDLQkMM57qnCN+yz2H+SIYghcpA5136JckiDogNruGFTmbKTVF0KSVlqXJxDYARyC
         mqma4QCo1QxlaSnOirBuOJgP11/esospo1o4Lwa7dJDGlJKvauQSxzIvMBg5TX3aQCdd
         Qr2GZ0ZOsKOtrBiMkzE366bPZ9NlL4eF2f1vbdMOuHwLWN0k+mm7JYLLgXyp3C9YKCf4
         eziG6v8DRd1QImPu71GltWAF1Bt9lYh54w63Dj7hFxNeS8Tu9UCSejuYMWUDxZhoVsjV
         S0xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772505921; x=1773110721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyIiPvo1Hi6sPVeMJBvore0WWbDttn+oJaE6w0roYKA=;
        b=GcIWlNA1xI/jRN6Iyh/Imqw8e+sq/xaZa2m9ak/M+8lZnybhv37P6c6VI+6uum+G14
         k94i9TEtOoLgLN8nTS+6o6YMbXYj5YC1RxxQfhoM1SjUzG4AQvySyvZxThz6AS2FCz9D
         eOVPTeXJbKuU3+g8r69U2UxhuvStbu4Y8iDbzegCaHF0P9Uga06xSpMRgg95eTV7j6VK
         AyaOmPG6ZDORotdMbtR3r4rSlTYwfGqnsCuC1KeQkREFAo1+CcejaxbeV19PiJyE6/zJ
         0PuIg5qJBf2KwiPj3G5POXUpgThBF56aWh3VBnKy4R4OyDV+w4F+KH3WuADXiBVgyFFC
         MPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772505921; x=1773110721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nyIiPvo1Hi6sPVeMJBvore0WWbDttn+oJaE6w0roYKA=;
        b=tRS46Z1/WeeN5D7MyW88CflmCe1Egv5j8WAuO4fuI9lAIVkE7sjgQGOAWm6ZwaM/Ta
         knld9HS0HWjq0ubPruqD7zHNwZA97ZmcFDW5004GmCGgoV52vLrwnOZoS06DlBRP81Ak
         DhCScEvvrKXpY9V7pzLA661Me9KzLi1GxpoQtzLm7GBPE1df8dovY7y4dOPtDOUAYpxy
         ssXz1MqDgTFkFQRnalRt1GG0z3UNZHxbdcdTCJAGk6iJWprXZ4uT0JyJf521MypPg5VV
         6E5j3zWkTXGr2kGa3jFCCoq+nt66OujjVJPZWlOuJNbs9K4JmyAQT5oZ++gX6MAcSw+z
         ebQg==
X-Forwarded-Encrypted: i=1; AJvYcCUNjmSn+WOiq+bmcFbNKLqlRZhtTf47auJMK7nAjvwc9OHx+YMzCSUo7sSdyumCKEKDrckwvg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9sZe5jUNsFSci+hMWwhSZhD3UHSuO2h2z5bVxJthkVi+xDYP
	h+/s20wsgKhninGPJbxbPiqNRWzWVvoe/cWFyFhzYpEFantAZbykxoBsEOk+mQYcC5yldV2Bgpo
	UPpH0yuOAgnXQNgIKkPCMqi+b2n4x/Q4jCI692/Hx7aKTGEMLC/zFFuN/oOgOvb7N2EtgwBoHKW
	JqGW1prONH2fu0+FMq7GDLtMZBqi/+vGLx
X-Gm-Gg: ATEYQzwgR1pmdcbtwY3mSqN20HnmDGfZ9P47hKuU6c/NNoNJrtlEmZI1nxmvTWlre80
	O9M8S4Wf3YpFrmiyj0/SBe8QoMMJZ0crmGZiA+2SUOTHgcuERzuwsRfgoL98HyrqH16XInozFN1
	HydikySrGyvBxakMS/buTL8JFwxvopf/Isf6fd8q8Ai2XQ4nrDFCZCgSze1XFtEIGDnMLsAfJqZ
	Z13L+c=
X-Received: by 2002:a05:622a:138d:b0:506:6e65:2334 with SMTP id d75a77b69052e-50752884908mr162390161cf.7.1772505920851;
        Mon, 02 Mar 2026 18:45:20 -0800 (PST)
X-Received: by 2002:a05:622a:138d:b0:506:6e65:2334 with SMTP id
 d75a77b69052e-50752884908mr162390021cf.7.1772505920456; Mon, 02 Mar 2026
 18:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202183950.2450315-1-jani.nikula@intel.com> <20260302174849.1541350-1-imre.deak@intel.com>
In-Reply-To: <20260302174849.1541350-1-imre.deak@intel.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 3 Mar 2026 15:44:43 +1300
X-Gm-Features: AaiRm53OebrURJ-3U3Cm7zHgAwIYzvZZvrjnJgud4bVF_XJhK0QR7JJ_X9W5ZWM
Message-ID: <CAO7dBbU8CS7EC8+m9v-RMMs7u4XgUHvFyaRnZtyYV1BKmzQA1A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915/dmc: fix an unlikely NULL pointer deference
 at probe
To: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	Mohammed Thasleem <mohammed.thasleem@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 18FEA1E826E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222777-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltao@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Action: no action

I have tested this patch can work for my kdump case as described in
Link: https://lore.kernel.org/all/20260228130946.50919-2-ltao@redhat.com.

Tested-by: Tao Liu <ltao@redhat.com>

On Tue, Mar 3, 2026 at 6:49=E2=80=AFAM Imre Deak <imre.deak@intel.com> wrot=
e:
>
> intel_dmc_update_dc6_allowed_count() oopses when DMC hasn't been
> initialized, and dmc is thus NULL.
>
> That would be the case when the call path is
> intel_power_domains_init_hw() -> {skl,bxt,icl}_display_core_init() ->
> gen9_set_dc_state() -> intel_dmc_update_dc6_allowed_count(), as
> intel_power_domains_init_hw() is called *before* intel_dmc_init().
>
> However, gen9_set_dc_state() calls intel_dmc_update_dc6_allowed_count()
> conditionally, depending on the current and target DC states. At probe,
> the target is disabled, but if DC6 is enabled, the function is called,
> and an oops follows. Apparently it's quite unlikely that DC6 is enabled
> at probe, as we haven't seen this failure mode before.
>
> It is also strange to have DC6 enabled at boot, since that would require
> the DMC firmware (loaded by BIOS); the BIOS loading the DMC firmware and
> the driver stopping / reprogramming the firmware is a poorly specified
> sequence and as such unlikely an intentional BIOS behaviour. It's more
> likely that BIOS is leaving an unintentionally enabled DC6 HW state
> behind (without actually loading the required DMC firmware for this).
>
> The tracking of the DC6 allowed counter only works if starting /
> stopping the counter depends on the _SW_ DC6 state vs. the current _HW_
> DC6 state (since stopping the counter requires the DC5 counter captured
> when the counter was started). Thus, using the HW DC6 state is incorrect
> and it also leads to the above oops. Fix both issues by using the SW DC6
> state for the tracking.
>
> This is v2 of the fix originally sent by Jani, updated based on the
> first References: discussion below.
>
> Link: https://lore.kernel.org/all/3626411dc9e556452c432d0919821b76d999121=
7@intel.com
> Link: https://lore.kernel.org/all/20260228130946.50919-2-ltao@redhat.com
> Fixes: 88c1f9a4d36d ("drm/i915/dmc: Create debugfs entry for dc6 counter"=
)
> Cc: Mohammed Thasleem <mohammed.thasleem@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Tao Liu <ltao@redhat.com>
> Cc: <stable@vger.kernel.org> # v6.16+
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display_power_well.c | 2 +-
>  drivers/gpu/drm/i915/display/intel_dmc.c                | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_power_well.c b/dr=
ivers/gpu/drm/i915/display/intel_display_power_well.c
> index 9c8d29839cafc..969b2c421d308 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_power_well.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_power_well.c
> @@ -852,7 +852,7 @@ void gen9_set_dc_state(struct intel_display *display,=
 u32 state)
>                         power_domains->dc_state, val & mask);
>
>         enable_dc6 =3D state & DC_STATE_EN_UPTO_DC6;
> -       dc6_was_enabled =3D val & DC_STATE_EN_UPTO_DC6;
> +       dc6_was_enabled =3D power_domains->dc_state & DC_STATE_EN_UPTO_DC=
6;
>         if (!dc6_was_enabled && enable_dc6)
>                 intel_dmc_update_dc6_allowed_count(display, true);
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i=
915/display/intel_dmc.c
> index c3b411259a0c5..90ba932d940ac 100644
> --- a/drivers/gpu/drm/i915/display/intel_dmc.c
> +++ b/drivers/gpu/drm/i915/display/intel_dmc.c
> @@ -1598,8 +1598,7 @@ static bool intel_dmc_get_dc6_allowed_count(struct =
intel_display *display, u32 *
>                 return false;
>
>         mutex_lock(&power_domains->lock);
> -       dc6_enabled =3D intel_de_read(display, DC_STATE_EN) &
> -                     DC_STATE_EN_UPTO_DC6;
> +       dc6_enabled =3D power_domains->dc_state & DC_STATE_EN_UPTO_DC6;
>         if (dc6_enabled)
>                 intel_dmc_update_dc6_allowed_count(display, false);
>
> --
> 2.49.1
>


