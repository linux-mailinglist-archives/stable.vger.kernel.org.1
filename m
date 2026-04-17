Return-Path: <stable+bounces-238507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE7ZDJJn4mmT5gAAu9opvQ
	(envelope-from <stable+bounces-238507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 19:02:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFCF41D67E
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 19:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44E123015D26
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5A2D6E72;
	Fri, 17 Apr 2026 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRy2AMGv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395193A4F3D
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445320; cv=pass; b=mF6tgLD5zwQOipcJv5SepgbA7inwGKpAz9ogAdTeDsp7VYzUBv7P/CRwPNddoMBkFl0K4Pur8CnqiHpbwXRqC7Mq2FEOWH3QOtKzaCDT0lWUn1uZ5xfKpa1rLHYQgTMqReWdHUVdmjFMyblvPXbI9tI4/2i1ftxfHvOYua8n3KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445320; c=relaxed/simple;
	bh=b78DnSlkUaTdHWKliqPNEL5HD6ix7is74cppKWHsCy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g48K+F0wngA2jvaOhu9r+4QypDfaF4R70c9k15sOG9D9deuLcnlAFTDXyjDXG9ANiP1tO1uLbYkovLnp1cgzkVFiIAQhVodSlIjwOWiX0XQg9ukICkoZq4hoqOoSass9VXDc6+wp34xLB/kzxbxBqPIOGvAFvVWlgi0XMTIGNw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRy2AMGv; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c565dd3a7so1398747c88.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 10:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776445312; cv=none;
        d=google.com; s=arc-20240605;
        b=J05dovovYIXGPiAjNb5C7Ycux4qNW0fjgMgqne1g1uC8iz21IxWAQzpN3ztjsE8mMR
         SHIfqmKTDQ+HTXIYZFEc2cvkMFLzdl2RChmDlkQoA3Stp/atZoJfX80SnmC92IxKXWn6
         HCqFjc13KPbQLlTT4n6frFL8T1GkqLAYijn4z5gSakJxAor720d/muSQkbo0yWcKNY5f
         1VHBUSqVudgLpMV909TD0lrjuwAJa1smh+pGGX424/MtukqUHnhM71q9M5Cc9M5eGQPh
         s/5I7JkncCeJy5Fx5td+iB72SnP4bSvWj5ZQJeWZjeiJz6i6RDhqDE1FrBY1L6f6gUQK
         8Ubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EdXbw8ruQnDuxyXud9pqLO7P6ne13TbWgACZPF9q6l4=;
        fh=EpZriUa/vdo7tOg56hTEXH1hosu8SmL5LmpdRWcfdpo=;
        b=NdgPpPHXy9FFRslbo7qbj8SxQqoAZgsGGBszA8Enp0G+v27Olw79YmLvhV+Uxfn36b
         gF0XioBeGN4IoeeIiLC2d+tbrzERDf9mryWTin/nYSFyw4Zz1SMbgc8GRZX41r1ZApOX
         6CEFKzFeDF/W1wVySuVZdg0Exr1zAu0+vmRziKVROwc7uv5VIED97LtD1RblQo0VJCYJ
         10Kb5JSMhj0d0Sx+fUT8QGrV98iIOUoVwqf9fvd0Akpp0EQeymNuBiZpY4574xy4qcnj
         IDbws3BuuIS4hkWuxZdeSsYBM4JgKyKN7Kbo0moE1YUVrBkCIPOT6L4EsLTQIS08Sajh
         zR/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776445312; x=1777050112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdXbw8ruQnDuxyXud9pqLO7P6ne13TbWgACZPF9q6l4=;
        b=hRy2AMGvo06jECQ4yw6+LjuIIHSgv00gDIrpDR1E9l8G6s19xBHKki2XAsjcX8fno1
         IvFW0Wfty3DtpByq99DWnGacf3oOFWoYukKKryrN3vWh/iLp8SdA4Jcfhu6SyIlKEpnI
         XJGJJVwxbHcEMKhV6zF5j5P3bADiud26P2vxZueF9X7Qv5FXXFjzZ6sEavJME4BwU+Gp
         2Hkw/VhKcbzSVVYyyugURK96rGPq9LDrtV6ngyejJDCxW66M8ijCuGuRn7FZAaatLAl9
         mw6ghNUOLRic5E6psnh1+CHY76b3X0DBXiGazoTtSAsGYvkSYcj57DYLZu58ZeG+0NIn
         0lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776445312; x=1777050112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EdXbw8ruQnDuxyXud9pqLO7P6ne13TbWgACZPF9q6l4=;
        b=jcK5W9y0Zo5d6BpjTV739az6qbfWeLPRmPojGCfFY7v7Y4OsFecyD3FTEIDtFvmWsG
         BWaN57zy1DEOt9so5BclbI8pWGgPvlftlRASpAMlguHyINHkPJ1hvZOERS8CT+cAyQzk
         s7QPi2PK04+FGCV38lE75/S1vRviuotYVAgTLUl53TfVDP5UXyxWF8amcfjgbzBXYoq6
         K4W6TrdaLErQw26DhXdSPdoLZLVE1ugxi2yZhDeFxCY2G7tFSqFP/JJWWSB/7C9WHmBl
         TOrNvlHzcj46XplftZHY729K9lO6HrDIEmFku8m1h5+3lKlQQ00My+390jfUnfKRHsMa
         Bgdg==
X-Forwarded-Encrypted: i=1; AFNElJ+aPmbwIXXViDaX+vqbOId+cmnBatH/5EKGb/EzgNj+B+CYTic3PpRajlljrYIFM6THLLrjhBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXmAYI/grDKmHerq1/7HXMgnYADQ5Wp9UXTUJDjCb0e13ATdy
	VZPH3t6++4YvhsXE0ENoP9cmBpST80P5Eri+NcXIHUhXOtEiy2BG4QqJLIg31vezQ+clb4zQWHs
	LFtLhpjIpa8xJ4ztTZRpa1t2k56+7ksM=
X-Gm-Gg: AeBDieuy5t1nDZmY5aIDqc/mdrRfnhDCIOooiV/0xqFbkAD8GGrpemvABkxQ6BTaPXE
	y53HZKP7F2T7Qnq5PTLYUBnnCys1XAnW0UtjwA8qIrTfsBDu8KVj9Cc/R6PUqEVt1Cl5v72qWDo
	SVifzA62mHNn8yaZMvyNVuF3I0tNgm+2oH7DF5dIyGo9bQqlpRnDUFYKOxJsj/dGkFMl8eW+VeL
	59Whwqm1zChC3F0pC4mpCI1mLICzTPqgswMXdTbMN8jcYIJraVWqyxLmT7KnCaKPXJpHwevM+ju
	QJwin7GLnELasHOdEVFFIjw7cQShAekQ+FlgmOM+y5cgnCdQKVGL9tsBnbcWxC1AhL51EvgsrEo
	+J+UGkKOQjF+99Wbn6/JsqURs6iLU0It1GPDC3nWfx9JOtPXV
X-Received: by 2002:a05:7022:985:b0:128:d7a7:526b with SMTP id
 a92af1059eb24-12c73f957c5mr1805488c88.22.1776445311456; Fri, 17 Apr 2026
 10:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
In-Reply-To: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 17 Apr 2026 12:01:24 -0500
X-Gm-Features: AQROBzAmoDifysD6gsakq-ejyyvsk094ITMTDrSQ37RcrzyThndYubnsOWLSElk
Message-ID: <CAOCHtYg6_Gob1uQ3RBp_vrjunJ5F2qi_Yvd6Z0OpKktVXuSuXg@mail.gmail.com>
Subject: Re: [PATCH 0/8] drm/imagination: Job submission fixes and cleanup
To: Alessio Belle <alessio.belle@imgtec.com>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Brajesh Gupta <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238507-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,linaro.org,amd.com,collabora.com,lists.freedesktop.org,vger.kernel.org,lists.linaro.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robertcnelson@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rcn-ee.com:url,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDFCF41D67E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 3:21=E2=80=AFAM Alessio Belle <alessio.belle@imgtec=
.com> wrote:
>
> The first two commits fix rare bugs and should be backported to stable
> branches.

Yeap, that triggered on BeaglePlay v7.0.0, Mesa 26.1.0-rc1 and xserver
21.1.20-1 overnight..  testing now (and updating xserver to 21.1.22 as
more glamor changes)..

https://gist.github.com/RobertCNelson/5e1dcf4c648a5bffaaf970c5a50e5c96

Regards,

>
> The rest is an attempt to cleanup and document the code to make it
> a bit easier to understand.
>
> Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
> ---
> Alessio Belle (8):
>       drm/imagination: Count paired job fence as dependency in prepare_jo=
b()
>       drm/imagination: Fit paired fragment job in the correct CCCB
>       drm/imagination: Skip check on paired job fence during job submissi=
on
>       drm/imagination: Rename pvr_queue_fence_is_ufo_backed() to reflect =
usage
>       drm/imagination: Rename fence returned by pvr_queue_job_arm()
>       drm/imagination: Move repeated job fence check to its own function
>       drm/imagination: Update check to skip prepare_job() for fragment jo=
bs
>       drm/imagination: Minor improvements to job submission code document=
ation
>
>  drivers/gpu/drm/imagination/pvr_job.c              |   8 +-
>  drivers/gpu/drm/imagination/pvr_queue.c            | 154 +++++++++++++--=
------
>  drivers/gpu/drm/imagination/pvr_queue.h            |   2 +-
>  .../gpu/drm/imagination/pvr_rogue_fwif_shared.h    |  10 +-
>  drivers/gpu/drm/imagination/pvr_sync.c             |   8 +-
>  drivers/gpu/drm/imagination/pvr_sync.h             |   2 +-
>  6 files changed, 110 insertions(+), 74 deletions(-)
> ---
> base-commit: 3bce3fdd1ff2ba242f76ab66659fff27207299f1
> change-id: 20260330-job-submission-fixes-cleanup-83e01196c3e9
>
> Best regards,
> --
> Alessio Belle <alessio.belle@imgtec.com>
>
>


--=20
Robert Nelson
https://rcn-ee.com/

