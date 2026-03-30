Return-Path: <stable+bounces-231268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLi+AD3TymmsAQYAu9opvQ
	(envelope-from <stable+bounces-231268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:47:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE103609D5
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26955302BB88
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 19:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89391399354;
	Mon, 30 Mar 2026 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVOBsBak"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11099274FD0
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899652; cv=pass; b=tYcFMC3Zl+RR0XgLCpz0v0zItGme6JYIIaAMgOfCmMvqRULisw4Yq8P5gJ6PCp04rPLLYS9cW7c7bjmjVKNCEhdvq1bh/nS6a0attUbt+Mj+BreBMC6T1Fnq1nkAYHxdLYpO6XWThPT5Ump91+LZFVwSCdw/eerimv8hElkwJ+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899652; c=relaxed/simple;
	bh=JtrqGpzkFeMqhCTnub6yv9ZTPOgaZH9WHlfKWzJJpVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0uPgJZbF2ZrapZwasVXlyOlQr380lj2e9Mnc8H08Ve2SfctdCbuA0KBhl0vD/5U8E648aTF3H/Pat1OM+QX520BvxQar6125SfLS75bXjoqr0GfjsqD9L5kwT+AGc4TMgLSzNDjJ5d9SVk0hUF9U+G9P9/eLWoJ2EAHCMiH6rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVOBsBak; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso2757740a34.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 12:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774899650; cv=none;
        d=google.com; s=arc-20240605;
        b=OyKZHnAGkPEG7jLhvV6VDOPYC/xLiDGHEKt6kYtQiWOVK1Xf2YVAuWc7GCruuIImWK
         cOE7gNS3p/BCEWSLlZ67pMZxLtGfow0PFIkgoFwU4g7Q0jecSheKIYiIgogE1levjgks
         2RQvNaJgaX+gsaAU8Goboe3EqKmEeiFDUM0j/lZICCmx9B4Pm+Q93Hr1MgmwTVxD3fLP
         w9zKn7/9+1v2GaBEeNGK0FynqFUdPWa7MEF0fE5AvoV6fA43pgEjN0HPSLwJN7ci3Oio
         HTmtmvG4fw1rrx1+AIZ8+HgjUfeH35mJyixgEP2TzfXGlctZQVa2xtxtoiBDP+HFMBeo
         595g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MgOLE8rNdBeVw50FL1H/Cs48AXcvUXmUqQIxBQAsmUE=;
        fh=wh9zOz7cJgU7orTWp8ofg45JEtYdFDKrTgxRmfJ6e4k=;
        b=UowfXYIi/TsNVx8VjBClCdpjepkG109NVYISghtcR3VkKU6SNdSTfjMoGYvbolk6EE
         iV97xaczRS2urMn7shTHo00WySD4ZQ4Gj88zvvgfnHw7mjrLeQiDFOf9ygAszS3dXftM
         6w0pm9JxK+lxvFh9tOX9ySoZx8ZXQR62hkf5tGTxc1yJjpOLa+BKp+0I3C+1Sz/eKkDU
         V4kVCqob/5+/4+sliZPR2ExpdL/B5Zq9UE34ifsSnG5X+yCIv4993HmF4vOFEKk/r2/l
         ks9PXqfCxZrrP1ISurGuB4iL4D4c0nnkrpww2Iic0U2t7FpxY55DpV1Y7o+g5oyGuply
         hMKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774899650; x=1775504450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgOLE8rNdBeVw50FL1H/Cs48AXcvUXmUqQIxBQAsmUE=;
        b=aVOBsBakd8Wr8k0SSowBink94IFRXufpR0LA3uOOKzH+AGuMOSy2cOuVY6lYtuj3d3
         S2fqEX0q0agdib8HXTMnuCEn9gINvbSdq6vLqmy+Q21/fPgskQOPA0JO30Rmm6hfYxLs
         CQEvUWj0QnZB/6bAu6toBFJXljPmpJjmpL4BbZVfLH+EAyQa+na5Tjx4VsDWxp1Qbrv8
         CUpvYC4AgLEgPgBIR95Kj0v95VdqHMC9E/TwSlpW+dNYOgswoZoln/lsKmiMtEAoaa49
         a42L3Bsl3B2YqdeCbBD5rlRYYTroG1WR0+35WcrfkZxMdC3UcQNqaPP0azMlNASi6FX3
         xBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774899650; x=1775504450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MgOLE8rNdBeVw50FL1H/Cs48AXcvUXmUqQIxBQAsmUE=;
        b=tYkevBQx2REqqTIKYH4ecjS7gu33IxyWtMlpxr2ymn7M39buSHjr9uOLE+H428GaHB
         mn/uNGffKCs8U9in2llAhsfbCSiy5oZQ5yTwJIqu6BcunGQ4ImECR/vPBDxg0m0lbTDt
         ryaDLUQRKvlbygwJ3/K8W8f4N1WuSKAH2m4nOXMVBrX+7yJJ10E/hs4Fe+zUBkcB7TTN
         CNi9j18xGUoThOmhFfTRCoecP8eIpOCcw5DVKIEJ5vrQopHCLhgB1Fg6K4MkFnB9xIYu
         9pR06EyrMC1gMo1idQMdpT5FWX40Ea6xOe2p2B0muy8KwIRktoczHZYjApmvcfJzRRa7
         24og==
X-Forwarded-Encrypted: i=1; AJvYcCVd0vTC1vLrzq4sPTwG0CgmdK/Umvy3qplcEUe5OWgfXcIcspF4xHQP1ThgW2nttCJ/vE14dug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqHSGj6J2HKCBgV2ofA6w6Z11vXYzJWry24BIZEuZthq4YPu9k
	Dw+N3dO4ZgwArEgeMxHzliYi+hvDbfxZcOrSZ3FGTSHglv1vU/r4Lti33weDPsVGklQztKjoahq
	FCKd/jKnjNqJQbyWqOJi0GHd+itvag8s=
X-Gm-Gg: ATEYQzxrBzS7LyjLo4c7gqPlxiv/39Jdon3ZVwQa9tE1V9RXPj7+dRHKq+5u2iMl6As
	1+d6p/yqbI1hDpAlc0n8OV9q9qeLpVeX5CJBAoIqj+LV871Xp083Wayu/VnDBwuZFP0ABq+HICW
	6+MgV3OW5c0aTJT7RfZ/lDZurZBiao3hVIJw8a6VYNFQTI7XmG2wXEh0URKWGtR0oBeJVK5mCAi
	CjW1J2o48V3IM11WV9j5mf/UxSWrELAJAWtB3HqNLDM/sarRp7koGNuSZPXEPQiUVQPLhQ5P94s
	/irHLGOogQ==
X-Received: by 2002:a05:6830:67d8:b0:7d7:cc53:623c with SMTP id
 46e09a7af769-7d9fad8747fmr8039420a34.7.1774899649966; Mon, 30 Mar 2026
 12:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330145049.21936-1-mikhail.v.gavrilov@gmail.com> <d05a9c56-5248-462f-96b5-44ad167f284a@amd.com>
In-Reply-To: <d05a9c56-5248-462f-96b5-44ad167f284a@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 31 Mar 2026 00:40:37 +0500
X-Gm-Features: AQROBzCNLSSWm2n2ptMDD0gOB6l-aEGg2SU0scPbi356emx3GUuYWX7qeZGkREs
Message-ID: <CABXGCsOguZU1k2zS7ngbAMYU10A-sWtoQLQ7P+ThiXR-7e_Crg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: replace PASID IDR with XArray
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-231268-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7DE103609D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 10:33=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
> Sorry, I didn't mean to confuse. In v3, was only talking about
> alloc_cyclic call.
>
> As per the call trace posted, amdgpu_pasid_free() has a chance to be
> called from irq context and that may still use irq save/restore
> approach. Eric/Christian, could you confirm?

Hi Lijo,

You're right, xa_erase() uses plain xa_lock() without irqsave =E2=80=94
I verified in lib/xarray.c.

I've sent v5 which uses xa_lock_irqsave/__xa_erase for
amdgpu_pasid_free() since it can be called from hardirq via
amdgpu_pasid_free_cb.  xa_alloc_cyclic() in amdgpu_pasid_alloc()
is kept as-is since it handles irq-safe locking internally.

https://lore.kernel.org/all/20260330191120.105065-1-mikhail.v.gavrilov@gmai=
l.com/

Thanks for catching this.

--=20
Best Regards,
Mike Gavrilov.

