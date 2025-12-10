Return-Path: <stable+bounces-200534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5806DCB1EEE
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 06:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9746D302FA32
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39DD20A5EA;
	Wed, 10 Dec 2025 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkrefraction-com.20230601.gappssmtp.com header.i=@darkrefraction-com.20230601.gappssmtp.com header.b="xJKj53xP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528861E86E
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765342897; cv=none; b=diaAWVYHuxYZtQlQICbcqjJ04FRzKRtpCBqHCeRlsS5auVIRwpIQUMPQY2KBNnw3EZyPvOCAPL/plIFpC8inqgbBEePhSSfgpy0Jqz8lGI44dwXmFg+Y4WRwGXAcUMZSNIs/6ouC6n89E3E9GT9xRnChisP1kv+gj0CY7xxaqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765342897; c=relaxed/simple;
	bh=WXxD719dy2hjGMO3wbw17ffA0XyC2Fpi8GIIpwbBhBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raC1bEgM6BPuFloSuaSHYkVTwo/PlgK5qgXHZqHueIknHVb8K6vo//11TjJuA3kA0YnGBPVV0Npqs/vQ7ZYbc6YSrmvXSXfVxaTc2nV+khGRA2CuCHrIOlYcqiyGmyCGJdeL78JUEA5k1o3FzrbVxtb91tSW+jOc8e/kRYkCZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkrefraction.com; spf=none smtp.mailfrom=darkrefraction.com; dkim=pass (2048-bit key) header.d=darkrefraction-com.20230601.gappssmtp.com header.i=@darkrefraction-com.20230601.gappssmtp.com header.b=xJKj53xP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkrefraction.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=darkrefraction.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so11126258a12.1
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 21:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkrefraction-com.20230601.gappssmtp.com; s=20230601; t=1765342895; x=1765947695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXxD719dy2hjGMO3wbw17ffA0XyC2Fpi8GIIpwbBhBM=;
        b=xJKj53xPD4fjtUVM4Hfdao9yZ9Ez0pWaKgIrrK/0VBxlZOSz/bwga4vlm8WsDTeLXz
         KmJt3IEzp8j2C2+3fW/fN6oFWngm4ITFsQBw6440MKMvCLMJX4VF2RqgKcz90hXV32f9
         OfubTk+Yycj2ojgllJb5TmsH5cmMgReKFWMjwPmP8PpB06618ljE/pI3pVGt5BaFytYR
         xtzDQHJ7fiY71dBKCTWEFnuR3ssQF49NkNIF8geKx5RIOHvp2EYU5pBtvoV7mRHu14RH
         GTi4zgDb29UR08MWdU5QEMhyc0OIzzJSC7DMwQHTTyjwxsd+e0GtOJjZRkf90HhBlUZa
         TJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765342895; x=1765947695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WXxD719dy2hjGMO3wbw17ffA0XyC2Fpi8GIIpwbBhBM=;
        b=YZrrOk+038qq7hNgZ9oFVMftNsCSv2fLH1s05Hlnhn6Cq/rRcwF5UadFp4q+j+HVjx
         8iuvJ6hREoF2006uEphU+uASF3kIuI3Qfuf/4xQx/TVfBor+SYoABrSdSiHapRpTFA5H
         D/rD0gCgjskhDcogR0H69VU0i8wtmig/TJgAs+aaLwIwNW+nrG6AWa6cxuHuMfUv80Vt
         KtJuf6NrdJK4fzf9xRfuufVoHmwDAkDsD8nYEZkRaG7V0/zq86q5SZt/+nda46eTJjd/
         8a10OoKf5kVjN1LwBKYlJo7lBr96JtxAny2cBkiTNx42hJY1cqMXtKlvf9ZjpveQ+s5R
         A7mg==
X-Forwarded-Encrypted: i=1; AJvYcCW9eM8TnjKZUUiYG/2lHHiWPww7L7cgZP/tVoL+uOykntPxMyy91rVvX5BdwAxyK1PxZ1nWArE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyvjgygbG/8bdV9SwfiTGyYbsHVxOQIKAM9xtslF3ytE2HkmcH
	eKVlvlFuwaHU8BcUD+AGyHc6h1SJ8aZEvllztzf7VsPdxk3QYs8FOVkQTbqUdB+FBLzzPln7Ili
	qfCbVmSsAuN2BipwRchjW2o/HQbaPpA+LjqWDZHHtYXxA5zSA/zmTeUOU3w==
X-Gm-Gg: AY/fxX5L/xHFzrjPAj9QlhIcGDUmmI2cP6T/LYRWOVbEeFrYJoMd1dMinFNtkn3lvTZ
	GCeAiRXssmjCHnOhHogRCpjsD/q26NwI8s30EeHWwsG92AhCk1ZWVCAokuUwdccqUath5CkPdVP
	OhYs93pew7xXSz33oiJXV/pwKCss2CzOOegPPKSmT2okYD8whesxgGXEOOlKQt7dPeSQYQXqn3w
	HTj+LywLn9rBwz71hlYMNTVxmScSZIg2vtNUpninfXA5wGAktvXLpkODPuS5GfYI4XLsNmVeXEY
	fe1QSQ==
X-Google-Smtp-Source: AGHT+IEonKudisdXsoUX6nwqgYRT7I8OYV2s5URNsD7bwkXAsmrKaErN0y2xgAY1HKoxTGOxIyLbu4hZobhy/CLJrZw=
X-Received: by 2002:a05:6402:350c:b0:641:4b82:10c9 with SMTP id
 4fb4d7f45d1cf-6496d5d0fcfmr1132873a12.27.1765342894506; Tue, 09 Dec 2025
 21:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205213156.2847867-1-lyude@redhat.com> <CAPM=9txpeYNrGEd=KbHe0mLbrG+vucwdQYRMfmcXcXwWoeCkWA@mail.gmail.com>
In-Reply-To: <CAPM=9txpeYNrGEd=KbHe0mLbrG+vucwdQYRMfmcXcXwWoeCkWA@mail.gmail.com>
From: M Henning <mhenning@darkrefraction.com>
Date: Wed, 10 Dec 2025 00:01:08 -0500
X-Gm-Features: AQt7F2qfGPcnwhJI4UUlXnZS397JFiGDANTdLTmA6Amc3DZHfva7fmE76SbOb6Q
Message-ID: <CAAgWFh1DDq4BdGUTR7RGpWZzi3ky0GoAoof7Z21XA6uVNNWvfw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/dispnv50: Don't call drm_atomic_get_crtc_state()
 in prepare_fb
To: Dave Airlie <airlied@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	nouveau@lists.freedesktop.org, Faith Ekstrand <faith.ekstrand@collabora.com>, 
	Dave Airlie <airlied@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Ben Skeggs <bskeggs@nvidia.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, James Jones <jajones@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 7:40=E2=80=AFPM Dave Airlie <airlied@gmail.com> wrot=
e:
> get_new_crtc_state only returns NULL not an error.

In case anyone other than me gets a sense of d=C3=A9j=C3=A0 vu while readin=
g
this: https://lists.freedesktop.org/archives/nouveau/2025-December/050813.h=
tml

