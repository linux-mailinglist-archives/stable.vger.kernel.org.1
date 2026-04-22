Return-Path: <stable+bounces-240366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMdhM8H/6Gl5SgIAu9opvQ
	(envelope-from <stable+bounces-240366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:05:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F833449264
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F048D308640A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E71B382384;
	Wed, 22 Apr 2026 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drFPjMig"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64680175A79
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876991; cv=pass; b=ja0te/QOveXgTpe9lFan2vtDHX7xGNoppwQGK2HGs1pNg0HHIl/90mdzLrzoo1BvP4g8fHYKOjrAbwY1EqRvrQQwPjyOPhzOTJeX0M+ZSOLLlqEmnez5leclYKNPv+A7NGKXJYJ0mFUg2NwS7Le5Ctc/cBHXKoLdCMXfMwk7EEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876991; c=relaxed/simple;
	bh=JysO+d3AJaHVSwsW5DrmaBgzvBL9SD0zNm6uNSsmh5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWTXWy6DS7pfCSwC92c4RfxU1ofj9RqLlItFQSAs5T+brFsOKilcrCqM4yY3Njjm8HtpZtHGn42oRUMM/LWU+417QpDqCJsjbFNdZH+vONY18JU4msSxOy/CfZ/LlnG0o/mVPxJKe4hE7I1Z35EiZMEhCAlLoI2VUFetk5nfGDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drFPjMig; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12db2e9b3bcso280801c88.3
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776876989; cv=none;
        d=google.com; s=arc-20240605;
        b=gQbjBjPA3GGCmIEVkKgPoGlU31v33e4rFyhHPcIuH7OZXNPQHXc1qwV/4bZLjBR7CF
         MIPVjEn0OotpVwweBDoPaNrlrUIzzpJ3zmsJ/S9yWBK9Hjen7bZk8AEQf7Eij098iJTA
         ffQnPMwHGT2cyL0YsYWXVHkieSwyAKhCKJGkEvls079vv9VSD4VBPhcC8XDzpQavUByB
         kC7SVhS9uKSdcf+SJCG4qb1nWenASChQ3URXxqF/9sFoomLAFJl2jcuILVJ1GehYo45u
         0CpfBJ0Wl8zFaQKkPOri2HteOZrHbJjuNtQVETr2TqG8tRr6c9XRXrSFL1efSnJcJNDJ
         rcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OojRBDFDIIdZR3BWENJt7a7Gu+luw6kbzdUuLsqds4Q=;
        fh=+RfGf+8zUxSVDwNsEproEIaYplRCyF1c5IYYYL26SUQ=;
        b=ict6TVRFpHG875pKbTcpga+HU2gucRnzIdEGCD0dKr4YqrB251NgDYME9GlHo/DNZ+
         2unPePHIdBnqOuxx3S6K3t5EL75ad4/bLhktgUu3LC6MYXB/TYoftF+mWED4TYGIetre
         8xwU1vekqMlV8ZUzxAkhbFmzRXn1KCgkGwy1JGknX2RPSauZ3SX4yhYa2CPnHraOpjQp
         zEYMMwZ/q2+DEaatoZ0W1U5PeqRuKLp+u9uX2n4P9+NsH5WC/PWONKTQZLNcJAoc+BOK
         +MEU3hZtO3BuEsAo1EY3kayvrX5Xjw5eMnWISoouZTxQNyiyHCj1cXc9A8SdMM/+Q7oA
         i5GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776876989; x=1777481789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OojRBDFDIIdZR3BWENJt7a7Gu+luw6kbzdUuLsqds4Q=;
        b=drFPjMigcALnBjZPYhi1jlRF9zC9mE9eVBn72fFDdKKIUmhIeimGy6tWlkpPRJsg8B
         HGW9IuSpJmM5iBnHC4mjJZA06UdWiNNs9yIw6R5DcHNsga9bnO47Vcl+o3IXb2uDl5Fw
         AfuGadhq8X1UJn/K7PFpOVjAMihtBjGhI2p9c1+o40ONREvg8La3w5nJEpuUZPHANlpG
         5W1eLkayF1bVqxC9W8H9XJrbbW1gENNEKjU+y6ssRksYp3qKtVHsFZyrgi0kbBDMeBLA
         bBY280VpuRd3Yoxfc0C70W48ZXQ5rLUBHjnr2dawLonRQAHEy2SorfuiZHlqCqIh9ATM
         2/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776876989; x=1777481789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OojRBDFDIIdZR3BWENJt7a7Gu+luw6kbzdUuLsqds4Q=;
        b=F+0ZdxbBb8wYJff/uZ1DNpMhrOQULPk+AEix5hMmWD1eg6da0LkwltBBJG4pdFn10Z
         0o8ju0W1bmKzv1n1PM6NaBJTF1W+/SYUZieZ8JVjtLp/Ear3ClWmvLbpXMaH+4G3nJmb
         MnnzHAtvtVcNf/LNKNNQ5ZYUIMXXQmcHTd8uds5d5ZYZfdB3gGt1wht/3bnhi5zIZzDI
         lgtW1Ps5H5XAmqNCO7ys35Ex7TfNl24VR46CCYl+eJgcJSqORlWhr13Jr6ASZjU1bKx/
         /EyKBJPmHyo1AxqRdI6QhVkR+WXVNmLNtRBrdECTkvcsUhKLnG1q80kTphHLeSJOgrv5
         4AzA==
X-Forwarded-Encrypted: i=1; AFNElJ+NovFJIu5uW84d63S87V6w59I89jw4trrJemtxH7tJ+ju67bfqCGgRhf4r6nKfD6woscUoVA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFnYjIU3+7wYWkJjQuyIeEVSTED4vrBlbSSEvFIgwWGlKF3Z1R
	IeHOt8ehTw5PRmHDc8vZJYzf6h727Bkmr8zPz/7ROq2zM0IZLWQBAkR1ZKblpOThBvADw4CG3qy
	fvCmjFLLTvpcGECBvwSLYw8CFPx1z/kc=
X-Gm-Gg: AeBDieuFd3nH3KCE+6BjtM5u6kerCaXjE8Zmho+klCNdQ9H5Jh3cH9c95kgDR2eYO4x
	rHnfA9vvgG4OMyudrbj5ZYkLtT7gzULDX9K9dfLfv4Ia0oKdVcAqMpcNHzjDPM27Gs/g5Qx6Zei
	Ed4xgjr1FQd0FUQd4VQuFi9YWwZqvQMcGz2p5Q3WVAiiqiEE8ChmC6jUcV0ko+uZG3+qgObOc7E
	vdYCpzKHOAouBYnwn5axH4mpK+Sl6m2293iVX5RfGq2uPqRNUUIbfCArS9skJJzqSET1TbhMzMY
	fmBjbQBCFRPsGpUaFlZEaBERobTLNjnQ/yqKGkPaidFUxGyAHQuJwBPW/Q6O0pZ2rxn94y4AMIu
	OFkn6KtBjiJLUsMo=
X-Received: by 2002:a05:7022:6b97:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-12c73f97796mr4503914c88.5.1776876989352; Wed, 22 Apr 2026
 09:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422162956.620362-1-sunpeng.li@amd.com>
In-Reply-To: <20260422162956.620362-1-sunpeng.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Apr 2026 12:56:17 -0400
X-Gm-Features: AQROBzA8X_HznQYPthmAG1DOnYsxrf075XbF75tbmIHFKTHf3mAp6zlU5dVB72k
Message-ID: <CADnq5_OYNSoWteuXDJrCOtj4qYn2q+vyXUKZaHvgNN+5xFFg2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs
To: sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com, 
	Aurabindo.Pillai@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com, 
	sysdadmin@m1k.cloud, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,outlook.com,m1k.cloud,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240366-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexdeucher@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,m1k.cloud:email,mail.gmail.com:mid,amd.com:email]
X-Rspamd-Queue-Id: 5F833449264
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:49=E2=80=AFPM <sunpeng.li@amd.com> wrote:
>
> From: Leo Li <sunpeng.li@amd.com>
>
> [Why]
>
> Rapid vblank off is causing flip-done timeouts for NV3x and newer
> family of GPUs that support more idle optimization features.
>
> A proper fix requires further investigation. In lieu of it, let's
> workaround it for now.
>
> [How]
>
> For NV3x and newer family of DGPUs, restore the old 5s vblank off timer.
>
> Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle op=
timizations")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3787
> Link: https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@=
m1k.cloud/
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> Tested-by: Michele Palazzi <sysdadmin@m1k.cloud>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3fa4dbda4517c..ce5063928413c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9511,9 +9511,21 @@ static void manage_dm_interrupts(struct amdgpu_dev=
ice *adev,
>         if (acrtc_state) {
>                 timing =3D &acrtc_state->stream->timing;
>
> -               if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> -                          IP_VERSION(3, 5, 0) ||
> -                          !(adev->flags & AMD_IS_APU)) {
> +               if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=3D
> +                     IP_VERSION(3, 2, 0) &&
> +                     !(adev->flags & AMD_IS_APU)) {

Why only dGPUs?  Seems like this is reported as least as often on APUs
if not more.

Alex

> +                       /*
> +                        * DGPUs NV3x and newer that support idle optimiz=
ations
> +                        * experience intermittent flip-done timeouts on =
cursor
> +                        * updates. Restore 5s offdelay behavior for now.
> +                        *
> +                        * Discussion on the issue:
> +                        * https://lore.kernel.org/amd-gfx/20260217191632=
.1243826-1-sysdadmin@m1k.cloud/
> +                        */
> +                       config.offdelay_ms =3D 5000;
> +                       config.disable_immediate =3D false;
> +               } else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> +                            IP_VERSION(3, 5, 0)) {
>                         /*
>                          * Older HW and DGPU have issues with instant off=
;
>                          * use a 2 frame offdelay.
> --
> 2.53.0
>

