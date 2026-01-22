Return-Path: <stable+bounces-211249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLo8Ewc8cmnTfAAAu9opvQ
	(envelope-from <stable+bounces-211249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:02:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F63F68453
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BACD4301D31A
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8935CBCE;
	Thu, 22 Jan 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiKTEkut"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754993101A2
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094092; cv=none; b=EXnPxTo5mQmvKznfXBr9p61nUTj59SkT8uirNBElXIgDvoIWgQs8hBFgBLFQnAQsT2NrYAGnoD+2DrfUnC+wKldW9v5Ir8Nc2oYudXjCG5W/ZMwpsGrnBiYL3ZXSYJSFNjBSXsP4xOZl1cK70K2kPkrduEFv8sZi+MRE8v8xvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094092; c=relaxed/simple;
	bh=D75orIZJO9On1dCSeuR1du/jGNFdMznf0Nfn2soIcYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+nHt6SJ0veIYGSibqpfwsGZ5/bNf7ZTSdF6miZP7GCc5BaeJuZAGfumEnW3M9GmYK7yTHsadPmhGZQVM/gvNhxNBAerytYrk29RsQMSo2O9wlGw5clynX56P4SF6yzdBxbZ1PN1+CtjZTJ2lyKTjQNWZNQ3KShHmRpikQQ+rJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiKTEkut; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so14692815e9.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769094089; x=1769698889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvCjR8X0IAE1BREUCOgJ6vVkdqVRr0pGs0xIiR58gY8=;
        b=eiKTEkutxKBSk9E9248JvnUPSyGMCIaZ+XHdNhgFWAYk1wfek/oiCCvse/vrUEDcee
         u3nAnN8QPqZKeSBngXFvcGQMyC5VR+QgRyGXUrw/wOQJRPvLCN+qjXtUph4/ONPxORh2
         MBmk1qoX3FKC/iGEuctt+Ah+SNGPpnHzp9Shx7Em/C6XT7PRuEsxyI+M5lSw4izvKW/H
         EQpsVPcu3YIqbcyWxlmDCEkkBGZCV0Nv395VOj1JYuaP9VOdMmt/uJYLPE0YZObO16Bl
         Qnxt+tW8/9atR1hghWqPUkA56Exudf0S3YVodh0M+1Xj5gGK6PkZ088e/i6kd3xw8YNj
         dGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094089; x=1769698889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cvCjR8X0IAE1BREUCOgJ6vVkdqVRr0pGs0xIiR58gY8=;
        b=rb0ovVpt8zA/xWR5PNxGqyPP4twk0u1jF9YKNqtTbyfFqmlvNhBYf6T1RLbdgL6srK
         NcqDQtn1wI1tQWVXehrav9uPIoKZ7A3X3gPPKuQe+2m7jWN18OnS+UZRO+G6kX6XSvZ+
         ofrpjC0gQ07FQuvPAt/5wXqUxtM7o0iwQPE9jY7OQExK5EAP6jPwaPfq5GP+mPBL77j1
         HNkgdRRHR+itHGEmd1To1L6t1LA4L3z+/cLOJacbvZGZ0CaVbBZxg3Qpo9ldWWHnsJSP
         WQmKq6Yslv7mVWVa5myaCW0dxZMynvGUrw1ARAVa9l+cPz7rm8nu7Ub76jtZY8dXjdej
         aWvw==
X-Forwarded-Encrypted: i=1; AJvYcCWx1k4yTw3AGJhbh1LfkaLw3aQadJUnVy6XzcZstFZ1Mhh+kNCucIXzCGhDhra9lvCaIqRmUoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNG/P5yJgnlpFOs2t+kUNPVoTR5FyUocb14FsHRXk8gmRRizIi
	cby3NVl4Pme5oJQxwlZ0+lBKSNML4W3RS3FvbRWGyGiUFldOo7jmGvRQ
X-Gm-Gg: AZuq6aJm7WKxOtfPYZcmJrL4hUa5c/1U69mMkfNIRrBOiwqxFussfWqTfPGWDdUCtn0
	4z2UzCIgAwM5qj6HdEeqkabnkukL5MR1Y366B/TeDAS+ftu5MJ7uFTqF9sTEp8q/PBvIqFX3LJy
	x5EDcOjv1p7r/yiCgOPsqQ//Yq3bpyPCyotG7uIpS+UlxiLxwmJwKbAzALVfg6n3eaVYjJQmAgl
	UcyU+4HJ5yRVBQ4ji/fHrZbzY1VmVtVQ9H1eJo9HxAyYKdMyToOEXwl5x6fTCaddYK7IySJ8arz
	pfxHRt6GiqGDUF56C8wpPrRMGQ+5kAM03vlTIdLM+sCI+hcUmLhM8+RVu7Bqo0wAwwV1P6o6F18
	uoEw14BpDBU8EPFbL233QHgeBMGC5V+kwyshJH5uMRDtwduaA3nrlLY7r3O91l1s7XajoKJiPg4
	Xls4zqakjrYdQ2j72g8er48gw1pkgB+o/atUTUaUFP04q4K5ejJ7xWMwws
X-Received: by 2002:a05:600c:4692:b0:47d:3ead:7439 with SMTP id 5b1f17b1804b1-4803f44a19amr125655945e9.37.1769094085863;
        Thu, 22 Jan 2026 07:01:25 -0800 (PST)
Received: from timur-hyperion.localnet (5400182B.dsl.pool.telekom.hu. [84.0.24.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48048b49880sm59781895e9.11.2026.01.22.07.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:01:25 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Jon Doron <jond@wiz.io>, stable@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject:
 Re: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_gmc_filter_faults_remove
Date: Thu, 22 Jan 2026 16:01:24 +0100
Message-ID: <2808451.vuYhMxLoTh@timur-hyperion>
In-Reply-To: <20260121182447.2434085-1-alexander.deucher@amd.com>
References: <20260121182447.2434085-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211249-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timurkristof@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wiz.io:email,amd.com:email,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 6F63F68453
X-Rspamd-Action: no action

On Wednesday, January 21, 2026 7:24:47=E2=80=AFPM Central European Standard=
 Time Alex=20
Deucher wrote:
> From: Jon Doron <jond@wiz.io>
>=20
> On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
> ih2 interrupt ring buffers are not initialized. This is by design, as
> these secondary IH rings are only available on discrete GPUs. See
> vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
> AMD_IS_APU is set.
>=20
> However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
> get the timestamp of the last interrupt entry. When retry faults are
> enabled on APUs (noretry=3D0), this function is called from the SVM page
> fault recovery path, resulting in a NULL pointer dereference when
> amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].
>=20
> The crash manifests as:
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000004
>   RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
>   Call Trace:
>    amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
>    svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
>    amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
>    gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
>    amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
>    amdgpu_ih_process+0x84/0x100 [amdgpu]
>=20
> This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
> IP 9.3.0 from noretry=3D1") which changed the default for Renoir APU from
> noretry=3D1 to noretry=3D0, enabling retry fault handling and thus
> exercising the buggy code path.
>=20
> Fix this by adding a check for ih1.ring_size before attempting to use
> it. Also restore the soft_ih support from commit dd299441654f ("drm/amdgp=
u:
> Rework retry fault removal").  This is needed if the hardware doesn't
> support secondary HW IH rings.
>=20
> v2: additional updates (Alex)
>=20
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
> Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jon Doron <jond@wiz.io>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Thank you for taking care of this!

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> 8e65fec9f534e..243d75917458a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct
> amdgpu_device *adev, uint64_t addr,
>=20
>  	if (adev->irq.retry_cam_enabled)
>  		return;
> +	else if (adev->irq.ih1.ring_size)
> +		ih =3D &adev->irq.ih1;
> +	else if (adev->irq.ih_soft.enabled)
> +		ih =3D &adev->irq.ih_soft;
> +	else
> +		return;
>=20
> -	ih =3D &adev->irq.ih1;
>  	/* Get the WPTR of the last entry in IH ring */
>  	last_wptr =3D amdgpu_ih_get_wptr(adev, ih);
>  	/* Order wptr with ring data. */





