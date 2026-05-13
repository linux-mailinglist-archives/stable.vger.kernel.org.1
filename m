Return-Path: <stable+bounces-246714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFX1KV3aA2qR/QEAu9opvQ
	(envelope-from <stable+bounces-246714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:56:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2724052C1A1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 518B63047DFE
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D144360ED7;
	Wed, 13 May 2026 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etbZ4xs/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43437382F32
	for <stable@vger.kernel.org>; Wed, 13 May 2026 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637353; cv=pass; b=F62iKlanQu7SRvojEAgXFefPYcoKeMBvaRMx7ZSdPzx9a3D+og4Xc0Uy3q8BehGAX4QPsihoLcX7yZuf8IJZ4wg93YAb7j5Rp7S8CWz/xy1GKUrkpmibtH2FA/sSEbn+/XVM8EtFzXBJM+tbKDnDyhO64SmN1s063FQkhAzVPpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637353; c=relaxed/simple;
	bh=9tiV4ZhfIE1AVrGBMXro5/HVKMSjT0yIr89kHRQQJAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGyxB5EqTAD+DdOwbsAws6JiLD8FGbCxapqZzZqsEIuZmAqTQcWITWoWho/brR+EWMWnF0Y/QMuTyX6r/5BXGdD89SpE+ozZNoNUPzTxvPXQ8Qh/4L4QlWGAqWnLiJJWYHfG+C3GqEvt3j/2sfaVGmXHTu//hxumEMBnjY6G4l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etbZ4xs/; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bd87e5d8ffso77698077b3.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 18:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778637349; cv=none;
        d=google.com; s=arc-20240605;
        b=eAdbGnnQj/wZ1IAhVrA5AoG+x7onckAEcK4i7suP3Eknq6wIGAOUUCeroMhobkyhWO
         Na5/h8gsdTLKMv9teYoC9ryqP8bQb7Qet5hZP1VLNJiD9VPsWjQrh06Qh3lG+lIpSuxF
         AtxQdIqbBorpjCiwDRNY+Oiu50ZBAbkNU9RD9j68qxCv8305lCtkqJNmmk5cZfk/MBtx
         MV5NA03Lo6uai2fNLNBW2h8Pwkk3WBpWjZ5Nim3FxjhPBaRM9atyQZ9UA3lD5UUqVWHE
         edj/RYNMh+6NCFf4YKEdkPDT7F7KO2fgv3a5AYxfOVEIOtKmCzgCyAIBsRU1vsOLSkPf
         i0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5xRhLCcP3JBRN1MwY6Q9q9IhNYwNr7l9QAT6ZuSm7sQ=;
        fh=upO5toA5Kz8S6jkER4ntO3UAXKpcdrYJKKlflPs2ZvM=;
        b=b4/cRJZyAsKTYn9/7sRyjj+qk4T0/ZWZXrUbhIQjYk9BNtywZhLK2bCpE3VruVag3D
         Zkf0yy6h84SwmUlVWOO5AvJX/Z+9wMMbH/hFW/Ig13lJLRjpT+u6/1damhPqxhi7RmCC
         6xGucQGWAdJir8rtfrSvNnug+hf1F8W74pexvkeq/2+XnGOdbuSGszbCqevm724SIUOW
         XNuzIQUjkytIMHFMRMpYtz5VX6gEcPlklFCCtJkq2CiCd6UKAc7M7hYA8ulQd9NjATRg
         ZpIq4Ro1U4GtpxjKd5V6lqNoJO4zl+QignuhywjLPPEko8p7lG5+7pdQrAVac7LCbASJ
         VdVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778637349; x=1779242149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xRhLCcP3JBRN1MwY6Q9q9IhNYwNr7l9QAT6ZuSm7sQ=;
        b=etbZ4xs/Xuj64lWD/6DlKFeKD7HqKekOZTkUIESNbjRKvlyw8ryU4rnynHuhoFIfEj
         rgu5/VIKDYsDwagumYaC4nhQX/IOatDhQBt1j+mJKs0NRxuOVknvFjcCo8A/8mHDMCMe
         mwgPoJTEb0tnfts794fBh55zfoUByFrwNoQ9oLIpd9+o7ldSR3QztmnMgOkw5D5HAEEy
         5gfSzHxZY7R0uf8RUctJjzDgBUyPTSz/N2qVfLyU3S96eSXT5AbR7mUYpRI6Ye4Jv2Qx
         8E1Qz8UvW5KvcoetLBgiAbEScwk2ROkImgqrIKbHnrCQ8GvQFAfsthX/HAMclfXlM1Bw
         KdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778637349; x=1779242149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5xRhLCcP3JBRN1MwY6Q9q9IhNYwNr7l9QAT6ZuSm7sQ=;
        b=dOWhX3quuWOCxOHm8CV5quncHpghSHbzblOQgFDoeQcgAgZvrrK8k2G+GLGU2knQ/k
         tezwhi3eoaJwKjgSwZiO7bGw/KWwecmc9TFOgZcu5NxXt4yCtPbzz1TESrP7a81vpTwg
         acYTrlI95Yjv2vMClxn4mSLqorC8WCFggGugoMTV29/Ut5b3GHuM4uuOYOtqXzm9Vzw1
         w9sS7JmvBpjm2XPLTpyzgX/TWBcDiiO25MAYDdVSmBYnXNXsO1MOoKkdC9odPS1GcKLh
         /EGlqbUYZAWUEEuvF0hHgnFuS9IG5GAHREjIt9RLluPlwx1e9pOMUpWKR6CjJ7r5rNw0
         cYTg==
X-Forwarded-Encrypted: i=1; AFNElJ/x/3GObKL5cgkVAOJVl3laaiRBnw+sEW5S/TKT9VYoHQ403msrvornVI51B82roExV7v1Zo7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKx59/buKuRKz7ZBYATDtV1QVSouM/tQEK8XMFPFl1hCqCAmf
	cILBgreVv4kdc8Fz0nIoF9qoR2ZJDaPjg81igz6BmBSvQ1mWOEJm1Th+4es0s46JoKmTjTEC7oG
	3oWPsNBy0zkDNM6er0XEsl3ZLiAXOJ4c=
X-Gm-Gg: Acq92OFfkNpJMiwIJoh4XooF4sPgJBwEuyZPpPrpIjoTczns08d4eTn05wHuS02TXAV
	lyGYnn9cie8qJyUUGSQWfMe23Eda3aAZQqRl4iXqbGya8NI5n/EPU5bLqBx14ABTSpHeDOZmuzQ
	5uYWwVmOJFxdMvZ8gEHATutW1zhIktfXZrmAJnmk/mOQYvbW5FA59BhyIz5LcPEEhJRHzqi2l4R
	AUk5BEM6hywUoWM7T10JkGFB6D6lHqOlfnXzi2Rpmb/AdldlVxigDwgTUPcvY3LE278KJweZNZZ
	l82Dc/Q3HYJf79xoYUb7TMPfe5YURyqHfI8SP7dZ9SD8+W/ltL121kbibkoeyUZNSFit50Gu
X-Received: by 2002:a05:690c:e28d:20b0:7ba:ded4:df69 with SMTP id
 00721157ae682-7c6985e165dmr12151727b3.1.1778637348672; Tue, 12 May 2026
 18:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512020718.108044-1-kartikey406@gmail.com> <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com>
In-Reply-To: <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 13 May 2026 07:25:36 +0530
X-Gm-Features: AVHnY4LCDlccPve3ZLzzDvN9woFw3uS561jxG504DrY4p0Whnei59B3Wu16XydA
Message-ID: <CADhLXY7N0eLpA30eV4Rb=F4vzCf9XYtDjMpxBSJtGeMWNi6Cwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: move cursor resv lock acquisition to prepare_fb
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2724052C1A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246714-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[redhat.com,chromium.org,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,linaro.org,amd.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org,lists.linaro.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,72bd3dd3a5d5f39a0271];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,collabora.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 12:04=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> I'm getting lockup with this patch applied and now see that
> virtio_gpu_resource_flush() also locks BO.
>
> Easiest option might be to add uninterruptible variant of
> virtio_gpu_array_lock_resv(). Could you please try it for v3?
>
> --
> Best regards,
> Dmitry

Hi Dmitry,

Thanks for testing and catching the lockup. Before I send v3, want
to confirm the approach:

  1. Revert v2's prepare_fb / cleanup_fb / plane_state changes;
     keep the lock acquisition inside cursor_plane_update like
     the original code.

  2. Add virtio_gpu_array_lock_resv_uninterruptible() in
     virtgpu_gem.c, mirroring the existing helper but using
     dma_resv_lock() instead of dma_resv_lock_interruptible() on
     the nents=3D=3D1 path. Declare it in virtgpu_drv.h.

  3. In cursor_plane_update, call the new helper and check its
     return. The signal path is closed; -ENOMEM from
     dma_resv_reserve_fences() remains and is handled by freeing
     objs and skipping the cursor update for that frame.

A skipped cursor frame on ENOMEM is the remaining failure mode in
.atomic_update; this avoids the lockup with virtio_gpu_resource_flush()
that v2's broader lock scope caused.

Does that match what you had in mind?

Thanks,
Deepanshu

